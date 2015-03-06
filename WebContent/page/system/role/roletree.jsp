<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<style type="text/css">
#menu_div,#edit_div {
	float: left;
	margin: 5px;
	border: 1px solid #c3daf9;
	overflow: auto;
}
</style>
<script>
	var roleIds = '';
	var parentSelectId = '';
	var parentSelectUserName = ''
	Ext
			.onReady(function() {
				roleIds = jQuery.url.param("roleIds") != undefined ? jQuery.url
						.param("roleIds") : '';
				parentSelectId = jQuery.url.param("parentSelectId") != undefined ? jQuery.url
						.param("parentSelectId")
						: '';
				parentSelectUserName = jQuery.url.param("parentSelectUserName") != undefined ? jQuery.url
						.param("parentSelectUserName")
						: '';
				var treeLoader = new Ext.tree.TreeLoader(
						{
							dataUrl : 'Public_SysRole_queryRoleStructTree.action?roleIds=' + roleIds + '&singleCheck=true'
						});

				var tree = new Ext.tree.TreePanel( {
					width : 150,
					height : 410,
					autoScroll : true,
					animate : false,
					rootVisible : false,
					root : {
						nodeType : 'async'
					},
					loader : treeLoader

				});
				tree.getRootNode().expand(true);

				tree.on('checkchange', function(node, checked) {
					checkAction(node, checked)
				});
				tree.on('dblclick', function(node, e) {
					if (node.attributes.type == '1') {
						$("#selectUserId").val(node.id);
						$("#selectUserName").val(node.text);
					}
				});
				function checkAction(node, checked) {
					node.getUI().checkbox.checked = checked;
					node.attributes.checked = checked;
					node.eachChild(function() {
						var childNode = this;
						childNode.getUI().checkbox.checked = checked;
						childNode.attributes.checked = checked;
					});
				}

				/* user */

				var sexTypeStore = new SysParam.store("SEXTYPE");
				var positionStore = new SysParam.store("POSITION");
				var iseffStore = new SysParam.store("ISEFF");
				var depStore = new Department.store();
				var roleStore = new SysRole.store();
				var sm = new Ext.grid.CheckboxSelectionModel();
				var cm = new Ext.grid.ColumnModel( {
					columns : [ sm, new Ext.grid.RowNumberer(), {
						header : "id",
						dataIndex : "id",
						hidden : true
					}, {
						header : "用户",
						width:100,
						dataIndex : "userName"
					}, {
						header : "性别",
						hidden:true,
						dataIndex : "sex",
						renderer : function(value) {
							return SysParam.translate(sexTypeStore, value);
						}

					}, {
						header : "角色",
						dataIndex : "roleId",
						renderer : function(value) {
							return SysRole.translate(value);
						}

					}, {
						header : "部门",
						dataIndex : "depId",
						renderer : function(value) {
							return Department.translate(value);
						}

					}, {
						header : "职位",
						dataIndex : "position",
						hidden:true,
						renderer : function(value) {
							return SysParam.translate(positionStore, value);
						}
					} ],
					defaults : {
						sortable : true,
						menuDisabled : false,
						width : 100
					}
				});

				var store = new Ext.data.Store( {
					// autoLoad : true,//是否自动加载
					proxy : new Ext.data.HttpProxy( {
						url : 'Public_SysUser_pageQuery.action'
					}),
					baseParams : {
						start : 0,
						limit : 10
					},
					reader : new Ext.data.JsonReader( {
						root : 'result',
						totalProperty : 'totalProperty',
						remoteSort : true,
						fields : [ {
							name : "id",
							type : "int"
						}, "userName", "addr", "sex", "position", "depId",
								"phone", "zipcode", "iseff", 'roleId' ]
					})
				});

				var toolbar = new Ext.Toolbar( {
					id : "userTopBar",
					items : [ {
						iconCls : "btn_query",
						text : "查询",
						xtype : "button",
						scale : 'medium',
						handler : function() {
							loadGirdStore();
						}
					}, {
						iconCls : "btn_reset",
						text : "重置",
						xtype : "button",
						scale : 'medium',
						handler : function() {
							formpanel.form.reset();
						}
					} ]
				});
				var gridPanel = new Ext.grid.GridPanel( {
					id : "userGrid",
					tbar : toolbar,
					store : store,
					trackMouseOver : true,
					// disableSelection: false,
					loadMask : true,
					region : "center",
					cm : cm,
					sm : sm,
					width : 350,
					height : 250,
					viewConfig : {
						forceFit : true,// 填满width.
						enableRowBody : true,
						showPreview : false
					},
					// paging bar on the bottom
					bbar : new Ext.PagingToolbar( {
						pageSize : 20,
						store : store,
						displayInfo : true,
						displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
						emptyMsg : "没有记录"
					})
				});

				function loadGirdStore() {
					if (roleIds != '')
						store.setBaseParam('_QUERY_n_in_role_id', roleIds);
					store.setBaseParam('_QUERY_s_rlike_user_name', Ext.getCmp(
							'QUERY_user_name').getValue());
					store.reload();
				}
				;

				var formpanel = new Ext.FormPanel( {
					labelAlign : 'left',// 字样显示在顶部
					bodyStyle : 'padding:5px',
					plain : true,
					items : [ {
						xtype : 'fieldset',
						layout : "column",
						title : '已选用户',
						// autoHeight:true, 
						items : [ {
							xtype : "container",
							columnWidth : .8,
							defaultType : "textfield",
							layout : "form",
							defaults : {
								anchor : "96%,96%",
								labelStyle : 'text-align:right;'
							},

							items : [ {
								id : "selectUserName",
								fieldLabel : "用户名称"
							}, {
								id : "selectUserId",
								hidden : true
							} ]
						}, {
							xtype : "container",
							columnWidth : .2,
							defaultType : "textfield",
							layout : "form",
							defaults : {
								anchor : "96%,96%",
								labelStyle : 'text-align:right;'
							},

							items : [ {
								id : 'btnConfirm',
								xtype : "button",
								iconCls : "btn_accept",
								text : "确定",
								hidden:true,
								width : 50,
								handler : function(button, event) {
									alert(parentSelectId);
								}
							} ]
						} ]
					}, {
						xtype : 'fieldset',
						layout : "column",
						title : '查询条件',
						// collapsible: true,
						autoHeight : true,
						items : [ {
							xtype : "container",
							columnWidth : 1,
							defaultType : "textfield",
							layout : "form",
							defaults : {
								anchor : "96%,96%",
								labelStyle : 'text-align:right;'
							},

							items : [ {
								id : "QUERY_user_name",
								fieldLabel : "用户名称"
							} ]
						} ]
					} ]
				});
				gridPanel.addListener("rowdblclick", function(g, f, h) {
					g.getSelectionModel().each(function(e) {
						$("#selectUserId").val(e.data.id);
						$("#selectUserName").val(e.data.userName);
					});
				});
				/*user end*/
				var mainPanel = new Ext.Panel( {
					renderTo : 'menu_div',
					autoHeight : true,
					border : false,
					items : [ tree ]
				});
				var mainPanel = new Ext.Panel( {
					renderTo : 'edit_div',
					autoHeight : true,
					border : false,
					items : [ formpanel, gridPanel ]
				});

			});
	function confirm() {
		var selectUserId = $('#selectUserId').val();
		var selectUserName = $('#selectUserName').val();
		$('#' + parentSelectId, parent.document).val(selectUserId);
		$('#' + parentSelectUserName, parent.document).val(selectUserName);

	}
</script>
<div id="menu_div">
</div>
<div id="edit_div">
</div>

<%@ include file="/common/include/html_bottom.jsp"%>