 
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '公告查看',
        width: 500,
        height:400,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform  ],
			buttons : [   { 
				text : "关闭",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
	}); 
	win.show();
}; 
EditWindow.prototype.editform = function() { 
	var editForm =  new Ext.FormPanel( {  
		layout : "form",
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
			}, [  { name : "id", type : "int" },  
					{name:"receiverId",convert: covReceiverName}
			        , "content",
					{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time',convert:covCreateTime},
					{name:"lastUpdate" , type : "date",mapping : 'lastUpdate.time',dateFormat : 'time'} ]),
		
			items:[ 
			       {
			    	fieldLabel : "收件人",
		    		id : "receiverId",
		    		readOnly : true 
			       },
			     { 
					id : "content",
					xtype:"textarea",
					fieldLabel : "消息内容",
					readOnly : true 
				 },{ 
						id : "createTime", 
						fieldLabel : "发送时间",
						readOnly : true 
				 }] 
	  });  

	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_NoticeHis_query.action?condition=id="+this.primaryId,
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
	function covReceiverName(v, record){ 
	    return SysUser.mutipleTranslate(record.receiverId);
	}
	function covCreateTime(v, record){
	    return  new Date(record.createTime.time).format('Y-m-d H:i:s') ; 
	}

	