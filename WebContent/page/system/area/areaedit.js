
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "areaEditForm",
	    title: '区域编辑',
        width: 500,
        height:300,
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
								 
							    store.load();
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
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="Public_SysArea_update.action";
	}else{
		this.url="Public_SysArea_save.action";
	}
	var editForm = new Ext.FormPanel( {
		url :   this.url,
		layout : "form",
		autoDestroy:true,
		id : "RoleForm",
		frame : false,
		border : false,  
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		defaults : {
			anchor : "98%,100%"
		},
		reader : new Ext.data.JsonReader( {
			  successProperty : 'success',
				root : 'result'
			}, ['id','name','menu_id','iseff']),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} ,{ 
			id : "parentid",
			xtype : "hidden",
			value :  0
		} , {
			fieldLabel : "区域名称",
			allowBlank : false, 
			id : "name"
		}, 
		{
			fieldLabel : "描述",
			allowBlank : true, 
			id : "des"
		},
		 new SysParam.ComboBox('是否有效','iseff', 'ISEFF' ,false)
		 ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Public_SysArea_query.action?condition=id="+this.primaryId,
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
	