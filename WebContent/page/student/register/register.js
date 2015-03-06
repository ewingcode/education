Ext.onReady(function() {
	
var studentForm = new studentInfoForm();
studentForm.addButton(
		 {
				text : "保存",
				iconCls : "btn_save",
				handler : function() { 
				if(!studentForm.getForm().isValid())
					return;
				studentForm.getForm().submit( {
						    url:"Busi_Student_save.action",
							method : "post",
							waitMsg : "正在提交数据...",
							success : function(i, j) { 
								 Ext.Msg.show( {
									title : '编辑',
									msg : '注册学生成功',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								}); 
								 studentForm.form.reset();
							},
							failure : function(i, j) {
								 Ext.MessageBox.show( {
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								}); 
								 
								 
							}
						});
					}
				}
			 , { 
				text : "重置",
				iconCls : "btn_cancel",
				handler : function() {
				 studentForm.form.reset();
				}
			} 
); 
 Frame.editPage(studentForm); 
});
 
 