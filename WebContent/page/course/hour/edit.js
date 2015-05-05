var EditWindow = function(b) {
	this.primaryId = b;
	var editform = this.editform();
	var win = new Ext.Window({
		id : "depEditForm",
		title : '课时管理',
		width : 500,
		height : 300,
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
				Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
					if (c == "yes") {
						Ext.Ajax.request({
							url : "Busi_OrderCourseHourLog_rollbackCourseHour.action",
							params : {
								courseHourLogId : b,
								reason: Ext.getCmp("reason").getValue()
							},
							method : "post", 
							success : function(response, opts) {
								var rec = Ext.util.JSON.decode(response.responseText); 
								Common.SucMegBox(rec.retinfo); 
								loadGirdStore();
								win.close();
							},
							failure : function(response, opts) {
								var rec = Ext.util.JSON.decode(response.responseText); 
								Common.ErrMegBox(rec.retinfo); 
								loadGirdStore();
								win.close();
							}
						});
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

var removeData = function(b) { 

};
EditWindow.prototype.editform = function() {
	var editForm = new Ext.FormPanel({
		layout : "form",
		autoDestroy : true,
		id : "RoleForm",
		frame : false,
		border : false,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		reader : new Ext.data.JsonReader( {
			  successProperty : 'success',
				root : 'result'
			}, ['id','reason' ]),
		defaults : {
			anchor : "98%,100%"
		},
		items : [ {
			id : "reason",
			xtype : "textarea",
			fieldLabel : "撤销课时理由",
			allowBlank : false
		} ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_OrderCourseHourLog_query.action?condition=id="+this.primaryId,
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
