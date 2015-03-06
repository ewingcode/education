
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '客户编辑',
        width: 500,
        height:430,
        minWidth: 500,
        minHeight: 300,
        autoScroll:true,
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
								 
							    store.reload();
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
		this.url="Busi_Customer_update.action";
	}else{
		this.url="Busi_Customer_save.action";
	}
	var editForm = new Ext.FormPanel( {
		url :   this.url,
		layout : "form",
		 autoScroll:true,
		autoDestroy:true,
		id : "userForm",
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
			},  [    { name : "id", type : "int" },"classes","email",
			   			"name", "addr", "sex", "phone", "brithday","iseff","school","class","age","parentName","studentType","residentType",
			   			{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
			   			{name:"lastUpdate" , type : "date",mapping : 'createTime.time',dateFormat : 'time'}]),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} , {
			fieldLabel : "学生名称",
			allowBlank : false, 
			id : "name"
		},
		new SysParam.ComboBox('性别','sex', 'SEXTYPE',true),
		 {
			id : "brithday", 
			xtype:"datefield", 
			fieldLabel : "生日", 
			maxValue:new Date(),  
			format:"Y-m-d", 
			listeners:{
				"blur":function(_df){  
					Ext.getCmp("age").setValue(new Date().getFullYear() - _df.getValue().getFullYear());
				}
			}
		}, {
			id : "age",
			readOnly:true,
			fieldLabel : "年龄"
		},
		new SysParam.ComboBox('学生类型','studentType', 'STUDENT_TYPE',true),
		new SysParam.ComboBox('户口类型','residentType', 'RESIDENT_TYPE',true) ,
		{
			fieldLabel : "学校", 
			id : "school", 
		}, 
		{
			fieldLabel : "班级", 
			id : "classes", 
		}, 
		{
			fieldLabel : "家长名称", 
			id : "parentName", 
		}, 
		{
			fieldLabel : "家长名称", 
			id : "parentName", 
		}, 
		{
			fieldLabel : "email", 
			id : "email",
		    vtype:"email"
		}, 
		{
			fieldLabel : "地址", 
			id : "addr"
		},
		{
			fieldLabel : "电话",
			id : "phone"
		}
		  ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_Customer_query.action?condition=id="+this.primaryId,
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
	