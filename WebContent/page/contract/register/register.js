Ext.onReady(function() {
	 Order.initData(); 
	var orderCourseGrid = new OrderCourse.courseEditGrid(null, false);
	var registerForm = new Ext.FormPanel({
		fileUpload : true,
		labelAlign : 'left',// 字样显示在顶部
		id : "card-1",
		autoScroll : true,
		buttonAlign : 'center',
		items : [
				{
					xtype : 'fieldset',
					title : '签单信息',
					layout : "column",
					items : [
							{
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "orderNo",
									fieldLabel : "合同编号",
									allowBlank : false,
								} ]
							},
							{
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ new Student.choose(false,
										"studentId", "studentName") ]
							},
							{
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "fee",
									fieldLabel : "签单费用(元)",
									allowBlank : false 
								} ]
							},
							{
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ new SysParam.ComboBox('年级', 'grade',
										'GRADE', false) ]
							}, {
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "courseHour",
									fieldLabel : "课时总数(小时)",
									maxLength : 10,
									allowBlank : false,
								} ]
							}, {
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "adjustHour",
									fieldLabel : "调整课时(小时/可选)",
									maxLength : 10,
									value:0
								} ]
							}, {
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "startTime",
									xtype : "datefield",
									format : "Y-m-d",
									fieldLabel : "开始时间",
									allowBlank : false,
									maxLength : 10,
									vtype : 'daterange',
									endDateField : 'endTime'
								} ]
							}, {
								xtype : "container",
								columnWidth : 1,
								layout : "form",
								defaultType : "textfield",
								defaults : {
									width : 300,
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "endTime",
									xtype : "datefield",
									format : "Y-m-d",
									fieldLabel : "结束时间",
									allowBlank : false,
									maxLength : 10,
									vtype : 'daterange',
									startDateField : 'startTime'
								} ]
							} ]
				}, orderCourseGrid.grid /*
										 * , new Order.fileUploadComp('初期辅导方案',
										 * "1", null, true, false), new
										 * Order.fileUploadComp('华实模拟协议', "2",
										 * null, true, false), new
										 * Order.fileUploadComp('方位测评报告', "3",
										 * null, true, false), new
										 * Order.fileUploadComp('教学安排表', "4",
										 * null, true, false)
										 */],
		buttons : [ {
			text : "保存",
			iconCls : "btn_save",
			handler : function() {

				if (!registerForm.getForm().isValid())
					return;
				var totalHour = $('#courseHour').val() - $('#adjustHour').val();
				if (!orderCourseGrid.validate(totalHour))
					return;
				var checkCourse = '';
				checkCourse = orderCourseGrid.getCourseList();

				// 验证是否有上传文件
				/*
				 * if (!Order.validateAttach(SUBMITTYPE_UPLOAD_FILE)) return;
				 */
				registerForm.getForm().submit({
					url : "Busi_OrderControl_createNewOrder.action",
					method : "post",
					params : {
						courseList : checkCourse,
						transitionName : $("#transitionName").val(), 
						assignerId : $("#assignerId").val() 
						 
					},
					waitMsg : "正在提交数据...",
					success : function(i, j) {
						Common.SucMegBox(j.result.retinfo);
						registerForm.form.reset();
						orderCourseGrid.reset();
						// Order.resetAttach();
					},
					failure : function(i, j) {
						Common.ErrMegBox(j.result.retinfo);

					}
				});
			}
		}, {
			text : "重置",
			iconCls : "btn_cancel",
			handler : function() {
				registerForm.form.reset();
				orderCourseGrid.reset();
				// Order.resetAttach();
			}
		} ]
	});
	registerForm.add(new Order.transitionChoice());
	registerForm.add(new Assigner.assingerFiled());
	Frame.editPage(registerForm);
});
