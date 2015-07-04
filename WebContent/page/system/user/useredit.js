var EditWindow = function(b) {
	this.primaryId = b;
	var editform = this.editform();
	var win = new Ext.Window({
		id : "userEditForm",
		title : '用户编辑',
		width : 500,
		height : 400,
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
				editform.getForm().submit({
					method : "post",
					waitMsg : "正在提交数据...",
					success : function(i, j) {
						Ext.Msg.show({
							title : '编辑',
							msg : '编辑成功',
							buttons : Ext.MessageBox.OK,
							icon : Ext.Msg.INFO
						});

						store.load();
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
	var isEdit = this.primaryId!=null ? true : false;
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url = "Public_SysUser_update.action";
	} else {
		this.url = "Public_SysUser_save.action";
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
		}, [ 'id', 'userName', 'addr', 'sex', 'position', 'phone', 'zipcode',
				'iseff', 'password', "depId", 'roleId', 'areaId','email','qq' ]),
		items : [
				{
					id : "id",
					xtype : "hidden",
					value : this.primaryId == null ? "" : this.primaryId
				},
				{
					fieldLabel : "用户名称",
					allowBlank : false,
					id : "userName",
					readOnly:isEdit,
					listeners : {
						"blur" : function(field) {
							 if(isEdit)
								 return;
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
				}, new SysParam.ComboBox('性别', 'sex', 'SEXTYPE', true),
				new SysRole.ComboBox('roleId', true),
				new SysArea.ComboBox('areaId', true),
				new Department.ComboBox('depId', true), {
					fieldLabel : "email",
					name : 'email',
					vtype : 'email'  
				},{
					fieldLabel : "qq",
					name : 'qq',
					vtype : 'alphanum' 
				}, {
					fieldLabel : "地址",
					allowBlank : false,
					id : "addr"
				}, {
					fieldLabel : "电话",
					allowBlank : false,
					id : "phone"
				}, {
					fieldLabel : "邮编",
					allowBlank : false,
					id : "zipcode"
				}, new SysParam.ComboBox('是否有效', 'iseff', 'ISEFF', true), {
					fieldLabel : "密码",
					allowBlank : false,
					id : "password",
					hidden : true,
					value : "111111"
				} ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load({
			deferredRender : false,
			url : "Public_SysUser_query.action?condition=id=" + this.primaryId,
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
