
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "studentEditForm",
	    title: '学生信息编辑', 
        height:500,
        width:750,
        minWidth: 500,
        minHeight: 300,
        layout: 'form',
        autoScroll:true,
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform  ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() { 
				if(!editform.getForm().isValid())
					return;
				       editform.getForm().submit( {
							method : "post",
							waitMsg : "正在提交数据...",
							success : function(i, j) { 
								 Ext.Msg.show( {
									title : '编辑',
									msg : '编辑成功',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								});  
								win.close();
							},
							failure : function(i, j) {
								 Ext.MessageBox.show( {
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								}); 
								 
								win.close();
								 
							}
						});
					}
				}
			 , { 
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
	var studentForm =new studentInfoForm(this.primaryId); 
		studentForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_Student_query.action?condition=id="+this.primaryId,
					waitMsg : "正在载入数据...",
					success : function(d, e) {
					 
					},
					failure : function(b, c) { 
						Ext.MessageBox.show( {
							title : "编辑",
							msg : "载入失败！",
							buttons : Ext.MessageBox.OK,
							icon : "ext-mb-error"
						});
					}
				}); 
	return studentForm;
}; 
	