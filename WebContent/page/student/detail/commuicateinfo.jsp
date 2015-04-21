<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/personal/exchange/edit.js" />
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
	var studentId;
	var yesornoStore;
	var ds;
	Ext
			.onReady(function() {
				studentId = jQuery.url.param("studentId");
				yesornoStore = new SysParam.store("YESORNO");

				 

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

				var grid1 = new Ext.grid.GridPanel(
						{
							store : ds, 
							bbar : new Ext.PagingToolbar(
									{
										store : ds,
										pageSize : 10,
										displayInfo : true,
										displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
										emptyMsg : "没有记录"
									}),
							cm : new Ext.grid.ColumnModel(
									{
										defaults : {
											width : 20,
											sortable : true
										},
										columns : [
												expander, 
												{
													header : "内容",
													width : 80,
													dataIndex : 'content'
												}, 
												{
													header : "创建时间",
													dataIndex : "createTime" ,
													renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')  
												},
												{
													header : "更新时间",
													dataIndex : "lastUpdate" ,
													renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
													 
												},
												{
													header : "编辑人",
													renderer : function(value) {
														return SysUser
																.translate(value);
													},
													dataIndex : 'operator'
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