<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<script>
	Ext.onReady(function() {
		var orderCourseStore = new SysParam.store("ORDER_COURSE");
		var scheduleStatusStore = new SysParam.store("SCHEDULE_STATUS");
		var teacherId = jQuery.url.param("teacherId");
		var weekStore = new SysParam.store("WEEK");
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
			}, {
				header : "授课老师",
				dataIndex : "teacherId",
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
				header : "开始日期",
				dataIndex : "startDay",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "结束日期",
				dataIndex : "endDay",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "开始时间",
				dataIndex : "startTime"

			}, {
				header : "结束时间",
				dataIndex : "endTime"
			}, {
				header : "总课时",
				dataIndex : "totalCourseHour"
			}, {
				header : "排课日",
				dataIndex : "weekdays",
				renderer : function(value) {
					return SysParam.translateArray(weekStore, value);
				}
			}, {
				header : "状态",
				dataIndex : "status",
				renderer : function(value) {
					return SysParam.translate(scheduleStatusStore, value);
				}
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
				url : 'Busi_CourseSchedule_pageQuery.action'
			}),
			reader : new Ext.data.JsonReader({
				root : 'result',
				totalProperty : 'totalProperty',
				remoteSort : true,
				fields : [ {
					name : "id",
					type : "int"
				}, "teacherId", "courseType", "totalCourseHour",
						"totalCostHour", "studentId", "status", "weekdays", {
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
							name : "startDay",
							type : "date",
							mapping : 'examTime.time',
							dateFormat : 'time'
						}, {
							name : "endDay",
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

		function loadGirdStore() {
			store.setBaseParam('start', 0);
			store.setBaseParam('limit', 20);
			store.setBaseParam('_QUERY_n_eq_student_id', $("#studentId").val());
			store.setBaseParam('_QUERY_n_eq_teacher_id', teacherId);
			store.setBaseParam('_ORDERBY', 'order by create_time desc');
			store.reload();
		}

		 
		var formpanel = new Ext.FormPanel({
			labelAlign : 'left',// 字样显示在顶部
			bodyStyle : 'padding:5px',
			height:100,  
			items : [ {
				xtype : 'fieldset',
				layout : "column",
				title : '查询条件', 
				autoHeight : true,
				items : [ {
					xtype : "container",
					columnWidth : 0.33,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						anchor : "96%,96%",
						labelStyle : 'text-align:right;'
					},

					items : [ {
						xtype : 'compositefield',
						id : "assignerComp",
						fieldLabel : '学生',
						width : "200",
						items : [
								{
									xtype : "textfield",
									id : 'studentId',
									hidden : true
								},
								{
									xtype : "textfield",
									id : "studentName",
									width : "150",
									readOnly : true
								},
								{
									xtype : "button",
									id : "choseAssigerBtn",
									text : "选择",
									width : "50",
									listeners : {
										"click" : function(d, i, n, e) {
											new Teacher.selectRefStudent(
													teacherId,
													function(studentId,
															studentName,courseType) {
														Ext.getCmp('studentId').setValue(studentId);
														Ext.getCmp('studentName').setValue(studentName); 
													});
										}
									}
								} ]
					} ]
				},{
					xtype : "container",
					columnWidth : 0.3,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						width : 150,
						labelStyle : 'text-align:right;'
					},
					items : {
						xtype : "button",
						text : "查询",
						iconCls : "btn_query",
						handler : function() {
							loadGirdStore();
						}
					} 
				} ]
			} ]
		});
		Frame.busiPage(formpanel, gridPanel);

	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>