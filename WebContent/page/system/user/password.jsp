<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>

<script>
	Ext.onReady(function() {
		var editForm = new Ext.FormPanel({
			url : this.url,
			layout : "form",
			autoDestroy : true,
			id : "userForm",
			frame : false,
			buttonAlign : 'center',
			border : false,
			bodyStyle : "padding:5px;",
			defaultType : "textfield",
			defaults : {
				//	anchor : "30%,30%"
				labelStyle : 'text-align:right;'
			},
			reader : new Ext.data.JsonReader({
				successProperty : 'success',
				root : 'result'
			}, [ 'id', 'userName', 'addr', 'sex', 'position', 'phone',
					'zipcode', 'iseff', 'password', "depId", 'roleId' ]),
			items : [ {
				id : "id",
				xtype : "hidden",
				value : this.primaryId == null ? "" : this.primaryId
			}, {
				fieldLabel : "旧密码",
				allowBlank : false,
				id : "oldPassword",
				inputType : "password"
			}, {
				fieldLabel : "新密码",
				allowBlank : false,
				id : "newPassword",
				inputType : "password"
			}, {
				fieldLabel : "重复密码",
				allowBlank : false,
				id : "repeatPassword",
				inputType : "password"
			} ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() {

					if (!editForm.getForm().isValid())
						return; 
					var oldPassword = Ext.getCmp("oldPassword").getValue();
					var newPassword = Ext.getCmp("newPassword").getValue();
					var repeatPassword = Ext.getCmp("repeatPassword")
							.getValue(); 
					if (newPassword != repeatPassword){ 
						Common.ErrMegBox('新密码和重复输入密码不相符！');
						return;
					}
					editForm.getForm().submit({
						url : "Public_SysUser_setPwd.action",
						method : "post",
						waitMsg : "正在提交数据...",
						params : {
							oldPassword : oldPassword,
							newPassword : newPassword
						},
						success : function(i, j) {
							Common.SucMegBox(j.result.retinfo);
							editForm.form.reset();
						},
						failure : function(i, j) {
							Common.ErrMegBox(j.result.retinfo);
							editForm.form.reset();
						}
					});
				}
			} ]
		});

		editForm.getForm().load({
			deferredRender : false,
			url : "Public_SysUser_query.action?condition=id=" + session_userId,
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

		Frame.editPage(editForm);
	});
</script>
<%@ include file="/common/include/html_bottom.jsp"%>