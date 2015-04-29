<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<script>
	Ext.onReady(function() {
		var orderCourseStore = new SysParam.store("ORDER_COURSE");
		var studentId = jQuery.url.param("studentId");
		var sm = new Ext.grid.CheckboxSelectionModel();
		var cm = new Ext.grid.ColumnModel({
			columns : [ sm, new Ext.grid.RowNumberer(), {
				header : "id",
				dataIndex : "id",
				hidden : true
			}, {
				header : "学生名称",
				dataIndex : "studentId",
				renderer : function(value) {
					return Student.translate(value);
				}
			}  , {
				header : "授课老师",
				dataIndex : "chargerId",
				renderer : function(value) {
					return SysUser.translate(value);
				}
			}, {
				header : "课程",
				dataIndex : "courseType",
				renderer : function(value) {
					return SysParam.translate(orderCourseStore, value);
				}
			}, {
				header : "考试时间",
				dataIndex : "examTime",
				renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
			}, {
				header : "考试分数",
				dataIndex : "score"
			}, {
				header : "创建时间",
				dataIndex : "createTime",
				renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
			}, {
				header : "更新时间",
				dataIndex : "lastUpdate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')

			} ],
			defaults : {
				sortable : true,
				menuDisabled : false,
				width : 100
			}
		});

		var store = new Ext.data.Store({
			// autoLoad : true,//是否自动加载
			proxy : new Ext.data.HttpProxy({
				url : 'Busi_OrderCourseScore_pageQuery.action'
			}),
			reader : new Ext.data.JsonReader({
				root : 'result',
				totalProperty : 'totalProperty',
				remoteSort : true,
				fields : [ {
					name : "id",
					type : "int"
				}, "orderId", "courseType", "chargerId", "studentId", "score",
						{
							name : "createTime",
							type : "date",
							mapping : 'createTime.time',
							dateFormat : 'time'
						}, {
							name : "lastUpdate",
							type : "date",
							mapping : 'lastUpdate.time',
							dateFormat : 'time'
						}, {
							name : "examTime",
							type : "date",
							mapping : 'examTime.time',
							dateFormat : 'time'
						} ]
			})
		});
		var gridPanel = new Ext.grid.GridPanel({
			id : "depGrid",
			store : store,
			trackMouseOver : true,
			loadMask : true,
			region : "center",
			cm : cm,
			sm : sm,
			height : 550,
			viewConfig : {
				forceFit : true,// 填满width.
				enableRowBody : true,
				showPreview : false
			},
			// paging bar on the bottom
			bbar : new Ext.PagingToolbar({
				pageSize : 20,
				store : store,
				displayInfo : true,
				displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
				emptyMsg : "没有记录"

			})
		});
		store.setBaseParam('start', 0);
		store.setBaseParam('limit', 20);
		store.setBaseParam('_QUERY_n_eq_student_id', studentId);
		store.setBaseParam('_ORDERBY', 'order by create_time desc');
		store.reload();

		Frame.editPage(gridPanel);

	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>