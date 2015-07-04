var isBook=0;
var EditWindow = function(b,customerId) {
	this.primaryId = b;
	var editform = this.editform();
	var win = new Ext.Window( {
		id : "userEditForm",
		title : '沟通编辑',
		width : 500,
		height : 430,
		minWidth : 500,
		minHeight : 300,
		autoScroll : true,
		layout : 'fit',
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ editform ],
		buttons : [ {
			text : "保存",
			iconCls : "btn_save",
			handler : function() { 
			    if(isBook==1 && $("#bookTime").val()==''){
			    	 Common.ErrMegBox('预约时间不能为空！'); 
			    	 return;
			    }
				if (!editform.getForm().isValid())
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
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url = "Busi_CustomerExchange_update.action";
	} else {
		this.url = "Busi_CustomerExchange_save.action";
	}
	var editForm = new Ext.FormPanel( {
		url : this.url,
		layout : "form",
		autoScroll : true,
		autoDestroy : true,
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
		}, [ {
			name : "id",
			type : "int"
		}, "customerId", "custStatus", "sourceType", "isBook", "userId",
				"content", "customerAttachId",

				{
					name : "bookTime",
					type : "date",
					mapping : 'bookTime.time',
					dateFormat : 'time',
					convert : covBookTime
				}, {
					name : "createTime",
					type : "date",
					mapping : 'createTime.time',
					dateFormat : 'time',
					convert : covCreateTime
				}, {
					name : "lastUpdate",
					type : "date",
					mapping : 'lastUpdate.time',
					dateFormat : 'time',
					convert : covLastUpdateTime
				} ]),
		items : [
				{
					id : "id",
					xtype : "hidden",
					value : this.primaryId == null ? "" : this.primaryId
				},
				{
					id : "userId",
					xtype : "hidden",
					value :  session_userId
				},
				{
					id : "customerId",
					xtype : "hidden",
					value :  customerId
				},
				new SysParam.ComboBox('当前状态', 'custStatus', 'CUSTOMER_STATUS',
						false),
				new SysParam.ComboBox('信息来源', 'sourceType',
						'VISIT_SOURCE_TYPE', false),
				new SysParam.ComboBox('是否预约', 'isBook', 'YESORNO', false,false,function(combo,  record, index){
					     var checkValue = record.get("paramValue"); 
					     bookTimeChange(checkValue);
						 
				}), {
					fieldLabel : "预约时间",
					id : "bookTime" ,
					xtype:"datefield" , 
					format:"Y-m-d H:i:s"
				}, {
					fieldLabel : "沟通记录",
					xtype : "textarea",
					width : 400,
					height : 120,
					id : "content",
					allowBlank :false
				}

		]
	});
	function bookTimeChange(checkValue){
		 if(checkValue==0){ 
			  isBook=0;
			  $("#bookTime").val("");
			   $("#bookTime").attr("disabled","true");
		  }else if(checkValue==1){ 
			  isBook=1; 
			   $("#bookTime").attr("disabled","");
		  }	
	}
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url : "Busi_CustomerExchange_query.action?condition=id="
							+ this.primaryId,
					waitMsg : "正在载入数据...",
					success : function(d, e) {
						  isBook = Ext.getCmp("isBook").getValue();
						    bookTimeChange(isBook);
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

function covCreateTime(v, record) {
	return new Date(record.createTime.time).format('Y-m-d H:i:s');
}
function covBookTime(v, record) {
	return new Date(record.bookTime.time).format('Y-m-d H:i:s');
}
function covLastUpdateTime(v, record) {
	return new Date(record.lastUpdate.time).format('Y-m-d H:i:s');
}
