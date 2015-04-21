var isUpload = 0;

var EditWindow = function(b, fn, sId, orderAttachId) {

	this.primaryId = b;
	this.studentId = sId;
	this.orderAttachId = orderAttachId;
	var editform = this.editform();
	var win = new Ext.Window({
		id : "userEditForm",
		title : '评价信息',
		width : 600,
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
				if ($("#content").val() == "") {
					Common.ErrMegBox('评价不能为空！');
					return;
				}
				if (isUpload == 1 && $("#uploadfile20").val() == "") {
					Common.ErrMegBox('请上传文件！');
					return;
				}
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
						if ($.isFunction(fn))
							fn();
						win.close();
					},
					failure : function(i, j) {
						Ext.MessageBox.show({
							title : "操作信息",
							msg : "信息保存出错，请联系管理员！",
							buttons : Ext.MessageBox.OK,
							icon : "ext-mb-error"
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
EditWindow.prototype.editform = function() {
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url = "Busi_StudentExchange_update.action";
	} else {
		this.url = "Busi_StudentExchange_save.action";
	}
	var editForm = new Ext.FormPanel({
		url : this.url,
		layout : "form",
		autoDestroy : true,
		id : "userForm",
		frame : false,
		border : false,
		fileUpload : true,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		reader : new Ext.data.JsonReader({
			successProperty : 'success',
			root : 'result'
		}, [ {
			name : "id",
			type : "int"
		}, "operator", "content", "studentId", {
			name : "createTime",
			type : "date",
			mapping : 'createTime.time',
			dateFormat : 'time'
		}, {
			name : "lastUpdate",
			type : "date",
			mapping : 'createTime.time',
			dateFormat : 'time'
		} ]),
		items : [ {
			id : "id",
			hidden : true
		}, {
			id : "operator",
			hidden : true,
			value : session_userId
		}, {
			id : "studentId",
			hidden : true,
			value : this.studentId
		}, {
			fieldLabel : "评价",
			xtype : "textarea",
			width : 400,
			height : 200,
			id : "content"
		} ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url : "Busi_StudentExchange_query.action?condition=id="
							+ this.primaryId,
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
