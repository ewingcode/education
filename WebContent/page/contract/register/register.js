Ext.onReady(function() {
	Frame.editPage(registerForm);
});

var registerForm = new Ext.FormPanel({
	fileUpload : true,
	labelAlign : 'left',// 字样显示在顶部
	id : "card-1",
	autoScroll : true,
	buttonAlign : 'center',
	items : [ {
		xtype : 'fieldset',
		title : '学生',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "80%,98%",
				labelStyle : 'text-align:right;'
			},
			items : [ new Student.choose(false, "studentId", "studentName") ]
		} ]
	}, {
		xtype : 'fieldset',
		title : '签单',
		layout : "column",
		defaults : {
			anchor : "80%",
			labelStyle : 'text-align:right;'
		},
		items : [ {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "30%",
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "orderNo",
				fieldLabel : "合同编号",
				allowBlank : false,
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.5,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "30%",
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "courseHour",
				fieldLabel : "课时总数",
				maxLength : 10,
				allowBlank : false,
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.5,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "30%",
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "costCourseHour",
				fieldLabel : "已消耗课时",
				maxLength : 10,
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.5,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "30%",
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
			columnWidth : 0.5,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "30%",
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
	}, {
		xtype : 'fieldset',
		title : '课程信息',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaultType : "textfield",
			defaults : {
				anchor : "20%",
				labelStyle : 'text-align:right;'
			},
			items : [ new SysParam.ComboBox('年级', 'grade', 'GRADE', false) ]
		} ]
	},new Order.orderCourse()  /*
		 * , new Order.fileUploadComp('初期辅导方案', "1", null, true, false), new
		 * Order.fileUploadComp('华实模拟协议', "2", null, true, false), new
		 * Order.fileUploadComp('方位测评报告', "3", null, true, false), new
		 * Order.fileUploadComp('教学安排表', "4", null, true, false)
		 */],
	buttons : [ {
		text : "保存",
		iconCls : "btn_save",
		handler : function() {
			var courseList = Ext.getCmp("courseList").getValue();
			var checkCourse = '';

			if (!registerForm.getForm().isValid())
				return;
			// 验证是否有选择课程
			for (i = 0; i < courseList.length; i++) {
				checkCourse += courseList[i].inputValue;
				if (i < courseList.length - 1)
					checkCourse += ",";
			}
			if (checkCourse == '') {
				Ext.MessageBox.show({
					title : "操作信息",
					msg : "可选课程不能为空！",
					buttons : Ext.MessageBox.OK,
					icon : "ext-mb-error"
				});
				return;
			}

			// 验证是否有上传文件
			if (!Order.validateAttach(SUBMITTYPE_UPLOAD_FILE))
				return;
			registerForm.getForm().submit({
				url : "Busi_OrderControl_createNewOrder.action",
				method : "post",
				params : {
					courseList : checkCourse
				},
				waitMsg : "正在提交数据...",
				success : function(i, j) {
					Common.SucMegBox('成功新建签单');
					registerForm.form.reset();
					Order.resetAttach();
				},
				failure : function(i, j) {
					Common.ErrMegBox('保存失败');

				}
			});
		}
	}, {
		text : "重置",
		iconCls : "btn_cancel",
		handler : function() {
			registerForm.form.reset();
			Order.resetAttach();
		}
	} ]
});
