Ext.ns("Order");

/* {@link #OrderCourseOper} */
var COURSEOPER_CHARGER = "0";
var COURSEOPER_APPLY = "1";
/**
 * 课程列表
 * 
 * @return
 */
Order.courseList = function(orderId, showCharger,showSchedule) {
	var _showCharger = (showCharger != null && showCharger) ? true : false;
	var _showSchedule = (showSchedule != null && showSchedule) ? true : false;
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_OrderCourse_query.action'

		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "hour", "orderId", "courseType", "chargerId","studentId", {
				name : "createTime",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			}, {
				name : "lastUpdate",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			}, "costHour","scheduleHour" ]
		})
	});
	store.reload({
		params : {
			condition : 'orderId=' + orderId
		}
	});
	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "id",
			dataIndex : "id",
			hidden : true
		}, {
			header : "科目",
			width : 25,
			dataIndex : "courseType",
			renderer : function(value) {
				return SysParam.translate(orderCourseStore, value);
			}
		}, {
			header : "课时",
			width : 25,
			dataIndex : "hour"
		}, {
			header : "消耗课时",
			width : 25,
			dataIndex : "costHour"
		}, {
			header : "排课课时",
			width : 25,
			dataIndex : "scheduleHour"
		}, {
			header : "负责人",
			width : 50,
			dataIndex : "chargerId",
			hidden : !_showCharger,
			renderer : function(value) {
				return Teacher.translate(value);
			}
		}, {
			header : "排课",
			xtype : 'actioncolumn',
			hidden : !_showSchedule, 
			defaults : {
				width : 230
			},// 默认每个子item大小
			width : 50,
			items : [
					{
						getClass : function(v, meta, rec) {
							return "btn_edit";
						},
						tooltip : '排课',
						handler : function(grid, rowIndex, colIndex) {
							var rec = store.getAt(rowIndex);
							 var teacherId = rec.get("chargerId");
							 var studentId = rec.get("studentId");
							 var teacherName = SysUser.translate(teacherId);  
							 var showPage = _contextPath
								+ "/page/teacher/course/scheduleframe.jsp?teacherId="+teacherId+"&studentId="+studentId ; 
							 window.open(showPage,'排课['+teacherName+']');  
						    // Frame.editPageWindow(showPage, 500, 1100, '排课['+teacherName+']');
						    
						}
					} ]
		} ],
		defaults : {
			sortable : true,
			menuDisabled : false
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "courseGird",
		store : store,
		region : "center",
		cm : cm,
		height : 120,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	var coursePanelSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		title : '课程信息',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaults : {
				anchor : "100%"
			// labelStyle : 'text-align:right;'
			},
			items : [ gridPanel ]
		} ]
	});
	return coursePanelSet;
};
/**
 * 课程 选择授课教师、审批
 * 
 * @param fieldName
 * @param type
 * @param orderId
 * @return
 */
Order.courseManage = function(orderId, needChoose, needApproval, isLastOrder) {
	var url = "Busi_OrderCourse_query.action?condition=order_id=" + orderId;

	var field = new Ext.form.FieldSet({
		title : '课程管理',
		layout : "column",
		items : []
	});
	var _needModify = false;
	Ajax
			.syncRequest(
					url,
					function(data) {
						for (var i = 0; i < data.result.length; i++) {
							var type = data.result[i].courseType;
							var status = data.result[i].status;
							var hour = data.result[i].hour;
							var statusStr = SysParam.translate(
									applyStatusStore, status);
							var courseName = SysParam.translate(
									orderCourseStore, type);
							var chargerId = data.result[i].chargerId;
							var chargerStr = Teacher.translate(chargerId);
							var _needChoose = (needChoose != null && needChoose) ? true
									: false;
							var _needApproval = (needApproval != null && needApproval) ? true
									: false;
							var _courseName = 'courseName' + type;
							var _hour = 'hour' + type;
							var _courseAcceptBtn = "courseAcceptBtn" + type;
							var _courseRejectBtn = "courseRejectBtn" + type;
							var _courseStatus = "courseStatus" + type;
							var _courseChargerId = "courseChargerId" + type;
							var _courseStatusStr = "ccStatusStr" + type;
							var _courseChargerName = "courseChargerName" + type;
							var _chooseCourseCharger = "chooseCourseCharger"
									+ type;
							var _lastCourseCharger = "lastCourseChargerId"
									+ type;
							var _lastCourseChargerName = "lastCourseChargerName"
									+ type;
							var _courseFiled = "courseFiled" + type;
							var _hourFiled = "hourFiled" + type;
							var _chargerFiled = "chargerFiled" + type;
							var _isShowStatus = true;
							// 状态是不通过的和通过的才显示审批状态
							if (status != STATUS_REJECT
									&& status != STATUS_ACCEPT) {
								_isShowStatus = false;
							}
							// 状态未不通过的和不要审批的就需要显示修改文件的按钮
							if (status == STATUS_REJECT && !_needApproval) {
								_needModify = true;
							}
							if (status == STATUS_ACCEPT) {
								_needChoose = false;
								_needModify = false;
								// _needApproval=false;
							}
							// 续单的时候，需要选择老师
							if (isLastOrder == true) {
								needChoose = true;
								_isShowStatus = false;
							}

							var courseField = {
								xtype : 'compositefield',
								fieldLabel : '科目',
								items : [ {
									xtype : 'textfield',
									id : _courseName,
									width : 50,
									value : courseName,
									readOnly : true
								}, {
									id : _courseStatus,
									xtype : "textfield",
									hidden : true,
									value : status
								} ]
							};
							var hourField = {
								xtype : 'compositefield',
								fieldLabel : '课时',
								items : [ {
									xtype : 'textfield',
									id : _hour,
									width : 50,
									value : hour,
									readOnly : true
								} ]
							};
							var chargerField = {
								xtype : 'compositefield',
								fieldLabel : '授课老师',
								items : [
										{
											xtype : "textfield",
											id : _lastCourseCharger,
											hidden : true,
											value : chargerId
										},
										{
											xtype : "textfield",
											id : _lastCourseChargerName,
											hidden : true,
											value : chargerStr
										},
										{
											xtype : "textfield",
											id : _courseChargerId,
											hidden : true,
											value : chargerId
										},
										{
											xtype : "textfield",
											// hidden:!_needChoose,
											id : _courseChargerName,
											readOnly : true,
											value : chargerStr,
											width : "100"
										},
										new SysParam.ComboBox(
												'审批',
												"courseAcceptBtn" + type,
												'APPLY_STATUS',
												true,
												false,
												function(combo, record, index) {
													var _i_type = combo
															.getId()
															.replace(
																	"courseAcceptBtn",
																	"");
													var _i_courseStatusStr = "ccStatusStr"
															+ _i_type;
													var _i_courseStatus = "courseStatus"
															+ _i_type;
													$("#" + _i_courseStatusStr)
															.val(
																	record
																			.get('paramName'));
													$("#" + _i_courseStatus)
															.val(
																	record
																			.get('paramValue'));
												}, null, !_needApproval),

										{
											id : _chooseCourseCharger,
											hidden : !_needChoose,
											xtype : "button",
											text : "选择",
											width : 50,
											handler : function(button, event) {
												// 内部值，解决变量定义域问题
												var _i_type = button
														.getId()
														.replace(
																"chooseCourseCharger",
																"");
												var _i_courseChargerId = "courseChargerId"
														+ _i_type;
												var _i_courseChargerName = "courseChargerName"
														+ _i_type;
												var _i_lastCourseChargerIdValue = $(
														"#lastCourseChargerId"
																+ _i_type)
														.val();
												var areaId ; 
												if(orderId){ 
													var queryOrderUrl = "Busi_OrderInfo_query.action?condition=id=" + orderId; 
													Ajax.syncRequest(queryOrderUrl, function(data) {
														if (data.result && data.result.length == 1)
															areaId = data.result[0].areaId;
													}); 
												}   
												Teacher.selectWin(
														_i_courseChargerId,
														_i_courseChargerName,areaId);
											}
										} ]
							};

							var statusField = {
								id : _courseStatusStr,
								fieldLabel : '审批状态',
								xtype : 'textfield',
								hidden : statusStr != '' ? false : true,
								readOnly : true,
								width : 150,
								value : statusStr
							};

							field.add({
								xtype : "container",
								id : _courseFiled,
								columnWidth : 0.3,
								defaultType : "textfield",
								layout : "form",
								defaults : {
									labelStyle : 'text-align:right;'
								},
								items : [ courseField ]
							});
							field.add({
								xtype : "container",
								id : _hourFiled,
								columnWidth : 0.3,
								defaultType : "textfield",
								layout : "form",
								defaults : {
									labelStyle : 'text-align:right;'
								},
								items : [ hourField ]
							});
							field.add({
								xtype : "container",
								id : _chargerFiled,
								columnWidth : 0.4,
								defaultType : "textfield",
								layout : "form",
								defaults : {
									labelStyle : 'text-align:right;'
								},
								items : [ chargerField ]
							});

							if (_isShowStatus) {
								field.add({
									xtype : "container",
									columnWidth : 1,
									defaultType : "textfield",
									layout : "form",
									defaults : {
										labelStyle : 'text-align:right;'
									},
									items : [ statusField ]
								});
							}
						}
					});

	return field;
};
/**
 * 添加课程的授课老师选择
 */

Order.addCourse = function(type, parentCourseFiled, parentEditForm) {
	var _courseChargerId = "courseChargerId" + type;
	var _courseChargerName = "courseChargerName" + type;
	var _chooseCourseCharger = "chooseCourseCharger" + type;
	var courseName = SysParam.translate(orderCourseStore, type);
	var _courseName = 'courseName' + type;
	var _courseFiled = "courseFiled" + type;
	var _chargerFiled = "chargerFiled" + type;
	var courseField = {
		xtype : 'compositefield',
		fieldLabel : '课程',
		items : [ {
			xtype : 'textfield',
			id : _courseName,
			width : 50,
			value : courseName,
			readOnly : true
		} ]
	};
	var chargerField = {
		xtype : 'compositefield',
		fieldLabel : '授课老师',
		items : [
				{
					xtype : "textfield",
					id : _courseChargerId,
					hidden : true,
				},
				{
					xtype : "textfield",
					id : _courseChargerName,
					readOnly : true,
					width : "100"
				},
				{
					id : _chooseCourseCharger,
					xtype : "button",
					text : "选择",
					width : 50,
					handler : function(button, event) {
						// 内部值，解决变量定义域问题
						var _i_type = button.getId().replace(
								"chooseCourseCharger", "");
						var _i_courseChargerId = "courseChargerId" + _i_type;
						var _i_courseChargerName = "courseChargerName"
								+ _i_type;
						// Teacher.assingerWindow(_i_courseChargerId,_i_courseChargerName);
						Teacher.selectWin(_i_courseChargerId,
								_i_courseChargerName);
					}
				} ]
	};
	var courseContainer = {
		xtype : "container",
		id : _courseFiled,
		columnWidth : 0.3,
		defaultType : "textfield",
		layout : "form",
		defaults : {
			labelStyle : 'text-align:right;'
		},
		items : [ courseField ]
	};
	var chargerContainer = ({
		xtype : "container",
		id : _chargerFiled,
		columnWidth : 0.7,
		defaultType : "textfield",
		layout : "form",
		defaults : {
			labelStyle : 'text-align:right;'
		},
		items : [ chargerField ]
	});
	parentCourseFiled.add(courseContainer);
	parentCourseFiled.add(chargerContainer);
	parentEditForm.doLayout();

};

Order.delCourse = function(courseType, parentCourseFiled, parentEditForm) {
	// $('#courseFiled'+courseType).remove();
	// $('#chargerFiled'+courseType).remove();
	parentCourseFiled.remove(Ext.getCmp('courseFiled' + courseType));
	parentCourseFiled.remove(Ext.getCmp('chargerFiled' + courseType));
	parentEditForm.doLayout();
}

/**
 * 科目选择
 * 
 * @return
 */
Order.orderCourse = function() {
	var field = new Ext.form.FieldSet(
			{
				title : '课程选择',
				layout : "column",
				items : [ {
					xtype : "container",
					columnWidth : 1,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						// anchor : "50%",
						labelStyle : 'text-align:right;'
					},
					items : [ new SysParam.checkbox('科目', 'courseList',
							'ORDER_COURSE') ]
				} ]

			});
	return field;
};
/**
 * 验证课程信息
 * 
 */
Order.validateCourse = function(oper) {
	var ret = true;
	if (oper == COURSEOPER_CHARGER) {
		$("input[name^='courseChargerId']")
				.each(
						function() {
							var input = $(this);
							var val = jQuery.trim(input.val());
							var inputName = input.attr('id');
							var courseType = inputName.replace(
									'courseChargerId', '');
							var courseStatus = $("#courseStatus" + courseType)
									.val();
							var courseName = $("#courseName" + courseType)
									.val(); 
							if ((val == 0 || val == '')
									//&& !(STATUS_REJECT == courseStatus || STATUS_ACCEPT == courseStatus)
									) {
								Common.ErrMegBox('请选择' + courseName + '的授课老师！');
								ret = false;
								return false;
							}
						});
	} else if (oper == COURSEOPER_APPLY) {
		$("input[name^='courseStatus']").each(function() {
			var input = $(this);
			var val = jQuery.trim(input.val());
			var inputName = input.attr('id');
			var courseType = inputName.replace('courseStatus', '');
			var courseName = $("#courseName" + courseType).val();
			
			if (val == '' 
				//|| !(STATUS_REJECT == val || STATUS_ACCEPT == val)
				) {

				Common.ErrMegBox('请对' + courseName + '的信息进行审批！');
				ret = false;
				return false;
			}
		});
	}
	return ret;
};

/**
 * 判断是否有不通过的审批
 */
Order.existNotPassCourse = function() {
	var ret = false;
	$("input[name^='courseStatus']").each(function() {
		var input = $(this);
		var val = jQuery.trim(input.val());
		if (val == STATUS_REJECT) {
			ret = true;
			return true;
		}
	});
	return ret;
};

/**
 * 判断是否选择上次不通过的授课老师
 */
Order.validateReplyNotPassCharger = function() {
	var ret = true;
	$("input[name^='courseStatus']")
			.each(
					function() {
						var input = $(this);
						var inputName = input.attr('id');
						var val = jQuery.trim(input.val());
						var courseType = inputName.replace('courseStatus', '');
						var courseName = $("#courseName" + courseType).val();
						var _curCourseCharger = $(
								"#courseChargerId" + courseType).val();
						var _curCourseChargerName = $(
								"#courseChargerName" + courseType).val();
						var _lastCourseCharger = $(
								"#lastCourseChargerId" + courseType).val();
						var _lastCourseChargerName = $(
								"#lastCourseChargerName" + courseType).val();
						if (val == STATUS_REJECT
								&& _curCourseCharger == _lastCourseCharger) {
							Common.ErrMegBox('请对' + courseName + '的选择新的授课老师！');
							ret = false;
							return false;
						}
					});
	return ret;
};

/**
 * 签单课程时间信息
 * 
 * @param orderId
 * @return
 */
Order.courseTypeEdit = function(orderId, courseMangeFiled, editform) {

	var aaaa = courseMangeFiled;
	var status = "";
	var contractSet;
	var courseUrl = 'Busi_OrderCourse_query.action?condition=order_id='
			+ orderId;
	var courseArray = new Array();
	Ajax.syncRequest(courseUrl, function(data) {
		if (data.result) {
			for (var i = 0; i < data.result.length; i++) {
				courseArray.push(data.result[i].courseType);
			}
		}
	});
	var url = 'Busi_OrderView_showOrderInfo.action?orderId=' + orderId;
	var courseCheckBoxs;
	if (courseMangeFiled) {
		courseCheckBoxs = new SysParam.checkbox('科目', 'courseList',
				'ORDER_COURSE', courseArray, function(checkbox, checked) {
					if (checked) {
						Order.addCourse(checkbox.getRawValue(),
								courseMangeFiled, editform);
					} else {
						Order.delCourse(checkbox.getRawValue(),
								courseMangeFiled, editform);
					}
				});
	} else {
		courseCheckBoxs = new SysParam.checkbox('科目', 'courseList',
				'ORDER_COURSE', courseArray);
	}
	Ajax.syncRequest(url, function(data) {
		var status = data.result.status;
		var courseHour = data.result.courseHour;
		var studentId = data.result.studentId;
		var grade = data.result.grade;
		contractSet = new Ext.form.FieldSet({
			xtype : 'fieldset',
			title : '课程信息',
			layout : "column",
			items : [
					{
						xtype : "container",
						columnWidth : 1,
						layout : "form",
						defaultType : "textfield",
						defaults : {
							anchor : "20%",
							labelStyle : 'text-align:right;'
						},
						items : [ new SysParam.ComboBox('年级', 'grade', 'GRADE',
								false) ]
					}, {
						xtype : "container",
						columnWidth : 1,
						layout : "form",
						defaultType : "textfield",
						defaults : {
							anchor : "80%,98%",
							labelStyle : 'text-align:right;'
						},
						items : [ courseCheckBoxs ]
					} ]
		});
		Ext.getCmp("grade").setValue(grade);
	});
	return contractSet;
};



Order.selectOrderCourse = function(studentId) {
	var sexTypeStore = new SysParam.store("SEXTYPE"); 
	var gradeStore = new SysParam.store("GRADE");
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "学生名称",
			dataIndex : "name",
		}, {
			header : "年龄",
			dataIndex : "age",
		}, {
			header : "学生年级",
			dataIndex : "grade",
			renderer : function(value) {
				return SysParam.translate(gradeStore, value);
			}
		}, {
			header : "学生性别",
			dataIndex : "sex",
			renderer : function(value) {
				return SysParam.translate(sexTypeStore, value);
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
			url : 'Busi_OrderCourse_findCourseByStudent.action?studentId='+studentId
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "name", "age", "grade", "addr", "sex", "school", "phone",
					"homephone", {
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

	var toolbar = new Ext.Toolbar({
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
	var gridPanel = new Ext.grid.GridPanel({
		id : "userGrid",
		tbar : toolbar,
		store : store,
		trackMouseOver : true,
		autoExpandColumn : true,
		loadMask : true,
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
		store.setBaseParam('_QUERY_s_like_name', Ext.getCmp(
				"QUERY_student_name").getValue());
		store.load();
	}

	var formpanel = new Ext.FormPanel({
		labelAlign : 'left',// 字样显示在顶部
		bodyStyle : 'padding:5px',
		plain : true,
		height : 100,
		items : [ {
			xtype : 'fieldset',
			layout : "column",
			title : '查询条件',
			collapsible : true,
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
					id : "QUERY_student_name",
					fieldLabel : "学生名称"
				} ]
			} ]
		} ]
	});

	var win = new Ext.Window({
		id : "selectStudentWin",
		title : '学生信息',
		width : 650,
		height : 500,
		minWidth : 500,
		minHeight : 300,
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ formpanel, gridPanel ],
		buttons : [ {
			text : "选择学生",
			iconCls : "btn_accept",
			handler : function() {
				if (gridPanel.getSelectionModel().getCount() != 1) {
					Common.ErrMegBox('请选择一项进行操作');
					return;
				}
				gridPanel.getSelectionModel().each(function(e) {
					var studentId = e.data.id;
					var studentName = e.data.name;
					callbackFn(studentId, studentName);
					win.close();
				});
			}
		}, {
			text : "关闭",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	loadGirdStore();
	win.show();
};