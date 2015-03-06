
var isUpload=0;
 
var EditWindow = function(b,fn,sId,orderAttachId) {

   this.primaryId = b;
   this.studentId = sId; 
   this.orderAttachId=orderAttachId;  
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '评价信息',
        width: 600,
        height:400,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform  ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() { 
			    if($("#content").val()==""){
			    	Common.ErrMegBox('评价不能为空！');
			    	return;
			    }  
			    if(isUpload==1 && $("#uploadfile20").val()==""){
			    	Common.ErrMegBox('请上传文件！');
			    	return;
			    }
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
							if($.isFunction(fn))
								fn();
								win.close();
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
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="Busi_OrderExchange_editExchange.action";
	}else{
		this.url="Busi_OrderExchange_saveExchange.action";
	}
	var editForm = new Ext.FormPanel( {
		url :   this.url,
		layout : "form",
		autoDestroy:true,
		id : "userForm",
		frame : false,
		border : false,  
		fileUpload : true, 
		bodyStyle : "padding:5px;",
		defaultType : "textfield", 
		reader : new Ext.data.JsonReader( {
			  successProperty : 'success',
				root : 'result'
			}, ['id','content','orderId','studentId','userId','orderAttachId' ]),
		items : [{ 
			id : "id",
			hidden:true  
		},{ 
			id : "orderId",
			hidden:true  
		},{ 
			id : "userId",
			hidden:true  
		},{ 
			 hidden : true,  
				id : "orderAttachId"  
		}, { 
			id : "studentId",
			hidden:true,
			value :  this.studentId
		} , {
			fieldLabel : "评价",
			xtype : "textarea",
			width : 400,
			height : 200, 
			id : "content"
		}, 
		//Order.viewFileFiled(this.orderAttachId),
		 new Ext.form.ComboBox(
					{
						fieldLabel :"是否上传附件", 
						triggerAction : "all", 
						emptyText : '请选择',   
						lazyRender:true,
						mode: 'local', 
						hiddenName : "isUpload",
						//id:"isUpload",
						region : "center",
						valueField : "paramValue",
						displayField : "paramName", 
						store:yesornoStore, 
						width : 150, 
					    listeners:{ 
						   "select": function(c,r,i){
								var paramValue = r.get("paramValue");  
								isUpload = paramValue; 
								 if(paramValue==1){ 
										 Ext.getCmp("uploadfile20").show();
										 
								 }else{ 
									 if(isUpload==1){ 
										 $("input[name^='uploadfile']").each(function(){
												var attach = $(this);
												attach.after(
														attach.clone(true).val(""));  
												attach.remove();
											} );
									 
										 Ext.getCmp("uploadfile20").hide(); 
									 }
								 }
							 }
						}
					}) 
		 ,
		{
			xtype : 'textfield',
			inputType : 'file', 
			width : 400,
			hidden:true,
			fieldLabel : "附件",
			id : "uploadfile20", 
			name : "uploadfile20",
			buttonCfg : {
				iconCls : 'upload-icon'
			}
		}
		]
	}); 
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_OrderExchange_query.action?condition=id="+this.primaryId,
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
	} 
	return editForm;
	}; 
	