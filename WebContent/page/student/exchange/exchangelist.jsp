<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/personal/exchange/edit.js" />
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
	var studentId;
	var yesornoStore;
	var ds;
	Ext.onReady(function() {
		studentId = jQuery.url.param("studentId");
		yesornoStore = new SysParam.store("YESORNO");

		var toolbar = new Ext.Toolbar({
			items : [ {
				text : '编写新的评价',
				iconCls : 'btn_add',
				handler : function() {
					new EditWindow(null, function() {
						reload()
					}, studentId);
				}
			} ]
		});

		ds = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({
				url : 'Busi_StudentExchange_pageQuery.action'
			}),
			reader : new Ext.data.JsonReader({
				root : 'result',
				totalProperty : 'totalProperty',
				remoteSort : true,
				fields : [ {
					name : "id",
					type : "int"
				}, "operator", "content", "studentId", {
					name : "createTime",
					type : "date",
					mapping : 'createTime.time',
					dateFormat : 'time'
				}, {
					name : "lastUpdate",
					type : "date",
					mapping : 'createTime.time',
					dateFormat : 'time'
				} ]
			})

		});

		var expander = new Ext.ux.grid.RowExpander({
			tpl : new Ext.Template('<p><b>内容:</b> {content}</p><br>')
		});

		var grid1 = new Ext.grid.GridPanel({
			store : ds,
			tbar : toolbar,
			bbar : new Ext.PagingToolbar({
				store : ds,
				pageSize : 10,
				displayInfo : true,
				displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
				emptyMsg : "没有记录"
			}),
			cm : new Ext.grid.ColumnModel({
				defaults : {
					width : 20,
					sortable : true
				},
				columns : [ expander, {
					header : "内容",
					width : 80,
					dataIndex : 'content'
				}, {
					header : "创建时间",
					dataIndex : "createTime",
					renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
				}, {
					header : "更新时间",
					dataIndex : "lastUpdate",
					renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')

				}, {
					header : "编辑人",
					renderer : function(value) {
						return SysUser.translate(value);
					},
					dataIndex : 'operator'
				}, {
					header : "操作",
					xtype : 'actioncolumn',
					defaults : {
						width : 230
					},// 默认每个子item大小
					width : 50,
					items : [ {
						getClass : function(v, meta, rec) {
							return "btn_remove";
						},
						tooltip : '删除',
						handler : function(grid, rowIndex, colIndex) {
							var rec = ds.getAt(rowIndex);
							removeData(rec.get('id'))
						}
					} ]
				}

				]
			}),
			viewConfig : {
				forceFit : true
			},
			width : 600,
			height : 400,
			plugins : expander,
			collapsible : false,
			animCollapse : false,
			title : '交流记录',
			iconCls : 'icon-grid',
			renderTo : document.body
		});
		var removeData = function(b) {
			Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
				if (c == "yes") {
					Ext.Ajax.request({
						url : "Busi_StudentExchange_delete.action",
						params : {
							id : b
						},
						method : "post",
						success : function() {
							Ext.Msg.show({
								title : '编辑',
								msg : '成功删除记录',
								buttons : Ext.MessageBox.OK,
								icon : Ext.Msg.INFO
							});
							reload();
						},
						failure : function() {
							Ext.MessageBox.show({
								title : "操作信息",
								msg : "信息保存出错，请联系管理员！",
								buttons : Ext.MessageBox.OK,
								icon : "ext-mb-error"
							});
						}
					});
				}
			});
		};
		reload();
		Frame.editPage(grid1);
	});

	function reload() {
		ds.load({
			params : {
				start : 0,
				limit : 20,
				_QUERY_n_eq_studentId : studentId,
				_ORDERBY : 'order by last_update desc'
			}
		});
	}
</script>


<%@ include file="/common/include/html_bottom.jsp"%>