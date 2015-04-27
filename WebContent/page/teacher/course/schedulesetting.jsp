<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%> 
<script>
	Ext.onReady(function() {
		var orderCourseStore = new SysParam.store("ORDER_COURSE");
		var scheduleStatusStore = new SysParam.store("SCHEDULE_STATUS");
		var teacherId = jQuery.url.param("teacherId");
		var isReadOnly = jQuery.url.param("isReadOnly"); 
		isReadOnly = isReadOnly=='true'?true:false;
		var weekStore = new SysParam.store("WEEK"); 
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
			}/* , {
				header : "授课老师",
				dataIndex : "teacherId",
				renderer : function(value) {
					return SysUser.translate(value);
				}
			} */, {
				header : "课程",
				dataIndex : "courseType",
				renderer : function(value) {
					return SysParam.translate(orderCourseStore, value);
				}
			}, {
				header : "开始日期",
				dataIndex : "startDate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "结束日期",
				dataIndex : "endDate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "课程时间",
				dataIndex : "startTime",
				renderer : function(value, metaData, record, rowIndex,
						colIndex, store) { 
					return value+"-"+record.get("endTime");
				}

			} , {
				header : "总课时",
				dataIndex : "totalCourseHour"
			}, {
				header : "已用课时",
				dataIndex : "totalCostHour"
			}, {
				header : "排课日",
				dataIndex : "weekDays",
				renderer : function(value) {
					 return SysParam.translateArray(weekStore, value);
				}
			}, {
				header : "状态",
				dataIndex : "status",
				renderer : function(value) {
					 return SysParam.translate(scheduleStatusStore, value);
				}
			}  ,{
				header : "操作",
				xtype : 'actioncolumn',
				items : [ {
					getClass : function(v, meta, rec) {  
						  return "btn_edit";
					},
					tooltip : '编辑',
					handler : function(grid, rowIndex, colIndex) {
						var rec = store.getAt(rowIndex);
						new Schedule.showScheduleDetailList(rec.get('id') );
					}
				}, {
					getClass : function(v, meta, rec) {  
						if(!isReadOnly)
						  return "btn_remove";
					},
					tooltip : '删除',
					handler : function(grid, rowIndex, colIndex) {
						var rec = store.getAt(rowIndex);
						removeData(rec.get('id') );
					}
				}  ]
			}
             ],
			defaults : {
				sortable : true,
				menuDisabled : false,
				width : 150
			}
		});

		
		var removeData = function(b) { 
			Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
				if (c == "yes") {
					Ext.Ajax.request( {
						url : "Busi_CourseSchedule_delete.action",
						params : {
							scheduleId : b
						},
						method : "post",
						success : function() {
							Ext.Msg.show( {
								title : '编辑',
								msg : '成功删除记录',
								buttons : Ext.MessageBox.OK,
								icon : Ext.Msg.INFO
							});
							loadGirdStore();
						}, 
						failure : function() {
							 Ext.MessageBox.show( {
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
						"totalCostHour", "studentId", "status", "weekDays",
						"startDate","endDate","startTime","endTime" ]
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
			store.setBaseParam('_QUERY_s_eq_iseff', 0);
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
		loadGirdStore();
		Frame.busiPage(formpanel, gridPanel);

	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>