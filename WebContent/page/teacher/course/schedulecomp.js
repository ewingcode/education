Ext.ns("Schedule");


/**
 * 弹出计算排课列表
 */
Schedule.computeScheduleResult = function(teacherId, studentId, courseType,coursePeriod,scheduleWeekday,startDate,endDate) {
	var scheduleDetailStatusStore = new SysParam.store("SCHEDULE_DETAIL_STATUS");
	var orderCourseStore = new SysParam.store("ORDER_COURSE"); 
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_CourseSchedule_computeScheduleList.action'

		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				mapping : 'id',
				hidden : true,
			},  "courseType","startTime","endTime","teacherId","studentId","date","isFinish" ]
		})
	});

	function loadStore() {
		store.reload({
			params : {
				teacherId : teacherId,
				studentId : studentId,
				courseType : courseType,
				coursePeriod : coursePeriod,
				weekDays : scheduleWeekday,
				startDate : startDate,
				endDate : endDate
			}
		});
	}

	var cm = new Ext.grid.ColumnModel(
			{
				columns : [
						new Ext.grid.RowNumberer(),
						{
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
						} , {
							header : "开始时间",
							dataIndex : "startTime"

						}, {
							header : "结束时间",
							dataIndex : "endTime"
						} , {
							header : "状态",
							dataIndex : "isFinish",
							renderer : function(value) { 
								return SysParam.translate(scheduleDetailStatusStore, value);
							}
						},
						{
							header : "操作",
							xtype : 'actioncolumn',
							items : [ {
								getClass : function(v, meta, rec) { 
									//只对没有结束的计划提供删除的按钮
									if(rec.get("isFinish") ==0)
									  return "btn_remove";
								},
								tooltip : '删除',
								handler : function(grid, rowIndex, colIndex) {
									var rec = store.getAt(rowIndex);
									Ext.Msg
											.confirm(
													"信息确认",
													"您确认要删除该记录吗？",
													function(c) {
														if (c == "yes") {
															Ext.Ajax
																	.request({
																		url : "Busi_CourseScheduleManage_delete.action",
																		params : {
																			id : rec
																					.get('id')
																		},
																		method : "post",
																		success : function() {
																			Ext.Msg
																					.show({
																						title : '编辑',
																						msg : '成功删除记录',
																						buttons : Ext.MessageBox.OK,
																						icon : Ext.Msg.INFO
																					});
																			loadStore();
																		},
																		failure : function() {
																			Ext.MessageBox
																					.show({
																						title : "操作信息",
																						msg : "信息保存出错，请联系管理员！",
																						buttons : Ext.MessageBox.OK,
																						icon : "ext-mb-error"
																					});
																		}
																	});
														}
													});
								}
							} ]
						} ],
				defaults : {
					width : 160,
					align : "center"
				}
			});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 600,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	loadStore();

	var win = new Ext.Window({
		id : "editScheduleWin",
		title : '排课编辑',
		width : 750,
		height : 350,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ gridPanel ],
		buttons : [ {
			text : "关闭",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	win.show();
}
/**
 * 弹出单日排课列表
 */
Schedule.showDailySchedule = function(teacherId, date) {
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_CourseScheduleManage_listDailySchedule.action'

		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				mapping : 'id',
				hidden : true,
			}, {
				name : "teacherName",
				mapping : 'teacherName'
			}, {
				name : "studentName",
				mapping : 'studentName'
			}, {
				name : "courseName",
				mapping : 'courseName'
			}, {
				name : "date",
				mapping : 'date'
			}, {
				name : "startTime",
				mapping : 'startTime'
			}, {
				name : "endTime",
				mapping : 'endTime'
			}, {
				name : "isFinish",
				mapping : 'isFinish'
			} ]
		})
	});

	function loadStore() {
		store.reload({
			params : {
				_QUERY_s_eq_date : date,
				_QUERY_n_eq_teacherId : teacherId,
				_ORDERBY : " order by start_time asc"
			}
		});
	}

	var cm = new Ext.grid.ColumnModel(
			{
				columns : [
						new Ext.grid.RowNumberer(),
						{
							header : "id",
							dataIndex : "id",
							hidden : true
						},
						{
							header : "教师",
							width : 260,
							dataIndex : "teacherName"
						},
						{
							header : "学生",
							width : 260,
							dataIndex : "studentName"
						},
						{
							header : "科目",
							dataIndex : "courseName"
						},
						{
							header : "日期",
							dataIndex : "date",
							renderer : Ext.util.Format.dateRenderer('Y-m-d')
						},
						{
							header : "开始时间",
							dataIndex : "startTime"
						},
						{
							header : "结束时间",
							dataIndex : "endTime"
						}, 
						{
							header : "状态",
							dataIndex : "isFinsh",
							 renderer: function(value) {  
									return  value == 0 ?"未执行":"结束";    
								}
						},
						{
							header : "操作",
							xtype : 'actioncolumn',
							items : [ {
								getClass : function(v, meta, rec) { 
									//只对没有结束的计划提供删除的按钮
									if(rec.get("isFinish") ==0)
									  return "btn_remove";
								},
								tooltip : '删除',
								handler : function(grid, rowIndex, colIndex) {
									var rec = store.getAt(rowIndex);
									Ext.Msg
											.confirm(
													"信息确认",
													"您确认要删除该记录吗？",
													function(c) {
														if (c == "yes") {
															Ext.Ajax
																	.request({
																		url : "Busi_CourseScheduleManage_delete.action",
																		params : {
																			id : rec
																					.get('id')
																		},
																		method : "post",
																		success : function() {
																			Ext.Msg
																					.show({
																						title : '编辑',
																						msg : '成功删除记录',
																						buttons : Ext.MessageBox.OK,
																						icon : Ext.Msg.INFO
																					});
																			loadStore();
																		},
																		failure : function() {
																			Ext.MessageBox
																					.show({
																						title : "操作信息",
																						msg : "信息保存出错，请联系管理员！",
																						buttons : Ext.MessageBox.OK,
																						icon : "ext-mb-error"
																					});
																		}
																	});
														}
													});
								}
							} ]
						} ],
				defaults : {
					width : 160,
					align : "center"
				}
			});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 600,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	loadStore();

	var win = new Ext.Window({
		id : "editScheduleWin",
		title : '排课编辑',
		width : 750,
		height : 350,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ gridPanel ],
		buttons : [ {
			text : "关闭",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	win.show();
}

/**
 * 设置排都课的面板
 * 
 * @param teacherId
 * @return
 */
Schedule.addSchedulePanel = function(teacherId) {

	var settingForm = new Ext.FormPanel(
			{
				layout : "form",
				autoScroll : true,
				defaultType : "textfield",
				buttonAlign : 'center',
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [
						{
							id : "teacherId",
							fieldLabel : "教师",
							value : teacherId,
							hidden : true
						},
						{
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
										width : "70",
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
															var url = 'Busi_CourseScheduleDetail_getOrderCourseForStudent.action?studentId=' + studentId+"&courseType="+courseType;
															Ajax.syncRequest(url, function(data) {
																var courseHour = data.result.hour;
																var costHour = data.result.costHour;
																var scheduleHour = data.result.scheduleHour;
																$("#courseHour").val(courseHour);
																$("#costHour").val(costHour);
																$("#scheduleHour").val(scheduleHour);
																var orderCourseStore = new SysParam.store("ORDER_COURSE"); 
																var courseName = SysParam.translate(orderCourseStore, courseType);
																$("#courseName").val(courseName);
															});
														});
											}
										}
									} ]
						},
						{
							id : "courseName",
							fieldLabel : "科目",
							readOnly : true
						},
						{
							id : "courseHour",
							fieldLabel : "科目课时",
							readOnly : true
						},
						{
							id : "costHour",
							fieldLabel : "消耗课时",
							readOnly : true
						},
						{
							id : "scheduleHour",
							fieldLabel : "排课课时",
							readOnly : true
						},
						{
							fieldLabel : "开始日期",
							allowBlank : false,
							id : "startDate",
							xtype : "datefield",
							format : "Y-m-d"
						}, 
						{
							fieldLabel : "结束日期",
							allowBlank : false,
							id : "endDate",
							xtype : "datefield",
							format : "Y-m-d"
						},
						new CoursePeriod.ComboBox("coursePeriod", false),
						new SysParam.ComboBox('科目', 'courseType',
								'ORDER_COURSE', false),
						new SysParam.checkbox('排课日', 'scheduleWeekday', 'WEEK') 
					    ],
				buttons : [ {
					text : "计算课时",
					iconCls : "btn_save",
					handler : function() {

						if (!settingForm.getForm().isValid())
							return;  
						var coursePeriod = Ext.getCmp("coursePeriod").getValue(); 
						var scheduleWeekday = Public.getCheckList("scheduleWeekday"); 
						var startDate = Ext.getCmp("startDate").getValue().format("Y-m-d"); 
						var endDate = Ext.getCmp("endDate").getValue().format("Y-m-d");
						var courseType = Ext.getCmp("courseType").getValue();
						var studentId = Ext.getCmp("studentId").getValue();
						new Schedule.computeScheduleResult(teacherId,
								studentId, courseType,
								coursePeriod ,scheduleWeekday ,startDate,endDate);
						/*settingForm.getForm().submit({
							url : "Busi_CourseScheduleManage_save.action",
							method : "post",
							params : {
							// courseList : checkCourse
							},
							waitMsg : "正在提交数据...",
							success : function(i, j) {
								Common.SucMegBox('成功新建排课信息');
								settingForm.form.reset();
							},
							failure : function(i, j) {
								Common.ErrMegBox(j.result.retinfo);

							}
						});*/
					}
				}, {
					text : "重置",
					iconCls : "btn_cancel",
					handler : function() {
						settingForm.form.reset();
					}
				} ]
			});

	return settingForm;
};

/**
 * 显示月排课信息
 */
Schedule.showCalender = function(teacherId, month) {
	var curDay = new Date();
	var curMonth = curDay.format("Y-m");
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_CourseCalender_showMonthSchedule.action'

		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				mapping : 'id'
			}, {
				name : "teacherId",
				mapping : 'teacherId'
			}, {
				name : "teacherName",
				mapping : 'teacherName'
			}, {
				name : "content1",
				mapping : 'contents[0]'
			}, {
				name : "content2",
				mapping : 'contents[1]'
			}, {
				name : "content3",
				mapping : 'contents[2]'
			}, {
				name : "content4",
				mapping : 'contents[3]'
			}, {
				name : "content5",
				mapping : 'contents[4]'
			}, {
				name : "content6",
				mapping : 'contents[5]'
			}, {
				name : "content7",
				mapping : 'contents[6]'
			} ]
		})
	});

	function loadStore() {
		var selectDay = Ext.getCmp('month').getValue();
		var month = selectDay.format("Y-m");
		store.reload({
			params : {
				month : month,
				teacherId : teacherId
			}
		});
	}

	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "id",
			dataIndex : "id",
			hidden : true
		}, {
			header : "星期日",
			dataIndex : "content1"
		}, {
			header : "星期一",
			dataIndex : "content2"
		}, {
			header : "星期二",
			dataIndex : "content3"
		}, {
			header : "星期三",
			dataIndex : "content4"
		}, {
			header : "星期四",
			dataIndex : "content5"
		}, {
			header : "星期五",
			dataIndex : "content6"
		}, {
			header : "星期六",
			dataIndex : "content7",
			height : 100
		} ],
		defaults : {
			width : 200,
			align : "center"
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 700, 
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	var filePanelSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 0.3,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				width : 150,
				labelStyle : 'text-align:right;'
			},
			items : [ {
				fieldLabel : "月份",
				allowBlank : false,
				id : "month",
				xtype : "datefield",
				format : "Y-m",
				value : curMonth
			} ]
		}, {
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
					loadStore();
				}
			} 
		}, {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaults : {
				anchor : "100%",
				labelStyle : 'text-align:right;'
			},
			items : [ gridPanel ]
		} ]
	});
	loadStore();
	return filePanelSet;
};