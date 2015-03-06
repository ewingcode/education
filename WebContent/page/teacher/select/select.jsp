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
	var parentSelectId = '';
	var parentSelectUserName = ''
	Ext
			.onReady(function() {

				parentSelectId = jQuery.url.param("parentSelectId") != undefined ? jQuery.url
						.param("parentSelectId")
						: '';
				parentSelectUserName = jQuery.url.param("parentSelectUserName") != undefined ? jQuery.url
						.param("parentSelectUserName")
						: '';

				/* teacher info */

				var sexTypeStore = new SysParam.store("SEXTYPE");
				var iseffStore = new SysParam.store("ISEFF");
				var courseStore = new SysParam.store("ORDER_COURSE");
				var gradeStore = new SysParam.store("GRADE");
				var sm = new Ext.grid.CheckboxSelectionModel();
				var cm = new Ext.grid.ColumnModel(
						{
							columns : [
									sm,
									new Ext.grid.RowNumberer(),
									{
										header : "id",
										dataIndex : "id",
										hidden : true
									},
									{
										header : "教师名称",
										dataIndex : "userName"
									},
									{
										header : "科目",
										width:120,
										dataIndex : "courseType",
										renderer : function(value) {
											if (value != null
													|| value != "undefined") {
												var courses = new Array();
												courses = value.split(",");
												var coursetrans = "";
												for ( var i = 0; i < courses.length; i++) {
													coursetrans += SysParam
															.translate(
																	courseStore,
																	courses[i]);
													if (i < courses.length - 1)
														coursetrans += ",";
												}
												return coursetrans;
											} else {
												return "";
											}
										}
									},
									{
										header : "教学年级",
										dataIndex : "gradeType",
										width:120,
										renderer : function(value) {
											if (value != null
													|| value != "undefined") {
												var grades = new Array();
												grades = value.split(",");
												var gradestrans = "";
												for ( var i = 0; i < grades.length; i++) {
													gradestrans += SysParam
															.translate(
																	gradeStore,
																	grades[i]);
													if (i < grades.length - 1)
														gradestrans += ",";
												}
												return gradestrans;
											} else {
												return "";
											}
										}
									},
									{
										header : "性别",
										dataIndex : "sex",
										width:60,
										renderer : function(value) {
											return SysParam.translate(
													sexTypeStore, value);
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
						url : 'Busi_Teacher_pageQuery.action'
					}),
					reader : new Ext.data.JsonReader( {
						root : 'result',
						totalProperty : 'totalProperty',
						remoteSort : true,
						fields : [ {
							name : "id",
							mapping : 'id'
						}, {
							name : "userName",
							mapping : 'userName'
						}, {
							name : "addr",
							mapping : 'addr'
						}, {
							name : "sex",
							mapping : 'sex'
						}, {
							name : "phone",
							mapping : 'phone'
						}, {
							name : "iseff",
							mapping : 'iseff'
						}, {
							name : "zipcode",
							mapping : 'zipcode'
						}, {
							name : "email",
							mapping : 'email'
						}, {
							name : "roleId",
							mapping : 'roleId'
						}, {
							name : "courseType",
							mapping : 'courseType'
						}, {
							name : "gradeType",
							mapping : 'gradeType'
						} ]
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
					width : 400,
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
					store.setBaseParam('start',0); 
					store.setBaseParam('limit',20); 
					store.setBaseParam('_QUERY_s_rlike_user_name',Ext.getCmp('QUERY_name').getValue());  
					store.reload();
				} ;

				var formpanel = new Ext.FormPanel( {
					labelAlign : 'left',// 字样显示在顶部
					bodyStyle : 'padding:5px',
					plain : true,
					items : [ {
						xtype : 'fieldset',
						layout : "column",
						title : '已选教师',
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
								fieldLabel : "教师名称"
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
								hidden : true,
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
								id : "QUERY_name",
								fieldLabel : "教师名称"
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