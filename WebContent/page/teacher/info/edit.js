var primaryId;
var courseType;
var gradeType;
var EditWindow = function(_primaryId, _courseType, _gradeType) {
	primaryId = _primaryId;
	if (_courseType != null)
		courseType = _courseType;
	if (_gradeType != null)
		gradeType = _gradeType;
	var editform = this.editform();
	var win = new Ext.Window({
		id : "userEditForm",
		title : '教师编辑',
		width : 700,
		height : 450,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ editform ],
		buttons : [ {
			text : "保存",
			iconCls : "btn_save",
			handler : function() {
				if (!editform.getForm().isValid())
					return;
				var courseList = Ext.getCmp("courseList").getValue();
				var checkCourse = '';

				// 验证是否有选择课程
				for (i = 0; i < courseList.length; i++) {
					checkCourse += courseList[i].inputValue;
					if (i < courseList.length - 1)
						checkCourse += ",";
				}
				if (checkCourse == '') {
					Ext.MessageBox.show({
						title : "操作信息",
						msg : "科目不能为空！",
						buttons : Ext.MessageBox.OK,
						icon : "ext-mb-error"
					});
					return;
				}

				var gradeList = Ext.getCmp("gradeList").getValue();
				var checkGrade = '';

				// 验证是否有选择课程
				for (i = 0; i < gradeList.length; i++) {
					checkGrade += gradeList[i].inputValue;
					if (i < gradeList.length - 1)
						checkGrade += ",";
				}
				if (checkGrade == '') {
					Ext.MessageBox.show({
						title : "操作信息",
						msg : "教学年级不能为空！",
						buttons : Ext.MessageBox.OK,
						icon : "ext-mb-error"
					});
					return;
				}
				editform.getForm().submit({
					method : "post",
					params : {
						courseType : checkCourse,
						gradeType : checkGrade
					},
					waitMsg : "正在提交数据...",
					success : function(i, j) {
						Ext.Msg.show({
							title : '编辑',
							msg : '编辑成功',
							buttons : Ext.MessageBox.OK,
							icon : Ext.Msg.INFO
						});

						loadGirdStore();
						win.close();
					},
					failure : function(i, j) {
						Ext.MessageBox.show({
							title : "操作信息",
							msg : "信息保存出错，请联系管理员！",
							buttons : Ext.MessageBox.OK,
							icon : "ext-mb-error"
						});

						win.close();

					}
				});
			}
		}, {
			text : "取消",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	win.show();
};
EditWindow.prototype.editform = function() {
	if (primaryId != null && primaryId != "undefined") {
		this.url = "Busi_Teacher_editTeacher.action";
	} else {
		this.url = "Busi_Teacher_addNewTeacher.action";
	}
	var editForm = new Ext.FormPanel({
		url : this.url,
		layout : "form",
		autoDestroy : true,
		id : "userForm",
		frame : false,
		border : false,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		defaults : {
			anchor : "98%,100%"
		},
		reader : new Ext.data.JsonReader({
			successProperty : 'success',
			root : 'result'
		}, [ {
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
			name : "zipcode",
			mapping : 'zipcode'
		}, {
			name : "email",
			mapping : 'email'
		}, {
			name : "iseff",
			mapping : 'iseff'
		}, {
			name : "roleId",
			mapping : 'roleId'
		}, {
			name : "courseType",
			mapping : 'courseType'
		}, {
			name : "gradeType",
			mapping : 'gradeType'
		}, {
			name : "areaId",
			mapping : 'areaId'
		}, "qq", "teacherType" ]),
		items : [
				{
					id : "id",
					xtype : "hidden",
					value : this.primaryId == null ? "" : this.primaryId
				},
				new SysParam.ComboBox('教师类型', 'teacherType', 'TEACHER_TYPE',
						true),
				{
					fieldLabel : "用户名称",
					allowBlank : false,
					id : "userName",
					listeners : {
						"blur" : function(field) {
							Ajax.syncRequest(
									"Public_SysUser_query.action?condition=user_name='"
											+ field.getValue() + "'", function(
											data) {
										if (data.result
												&& data.result.length >= 1) {
											Common.ErrMegBox('该用户：'
													+ field.getValue()
													+ '名称已重复！');
											field.reset();
										}
									});
						}
					}
				},
				new SysArea.ComboBox('areaId', true),
				new SysParam.ComboBox('性别', 'sex', 'SEXTYPE', true),
				new SysParam.checkbox('教学年级', 'gradeList', 'GRADE',
						gradeType != null ? gradeType.split(",") : null),
				new SysParam.checkbox('科目', 'courseList', 'ORDER_COURSE',
						courseType != null ? courseType.split(",") : null),

				{
					fieldLabel : "地址",
					allowBlank : false,
					id : "addr"
				}, {
					fieldLabel : "电话",
					allowBlank : false,
					id : "phone"
				}, {
					fieldLabel : "qq",
					id : "qq",
					xtype : "numberfield",
					maxLength : 50
				}, {
					fieldLabel : "邮箱",
					vtype : 'email',
					id : "email"
				}, new SysParam.ComboBox('是否有效', 'iseff', 'ISEFF', true), {
					fieldLabel : "密码",
					allowBlank : false,
					id : "password",
					hidden : true,
					value : "111111"
				}, {
					allowBlank : false,
					id : "roleId",
					hidden : true,
					value : "6"
				}, {
					allowBlank : false,
					id : "depId",
					hidden : true,
					value : "1"
				} ]
	});
	if (primaryId != null && primaryId != "undefined") {
		editForm.getForm().load({
			deferredRender : false,
			url : "Busi_Teacher_query.action?condition=id=" + primaryId,
			waitMsg : "正在载入数据...",
			success : function(d, e) {

			},
			failure : function(b, c) {
				Ext.MessageBox.show({
					title : "编辑",
					msg : "载入失败！",
					buttons : Ext.MessageBox.OK,
					icon : "ext-mb-error"
				});
			}
		});
	}
	return editForm;
};
