var isUpload = 0;
var orderId = '';
var EditWindow = function(primaryId) {
	this.primaryId = primaryId;
	var editform = this.editform();
	var win = new Ext.Window({
		id : "depEditForm",
		title : '课程评价',
		width : 500,
		height : 500,
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

						loadGirdStore();
						win.close();
					},
					failure : function(i, j) {
						Ext.MessageBox.show({
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
	var isModify = false;
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url = "Busi_OrderCourseEvaluation_editExchange.action";
		isModify = true;
	} else {
		this.url = "Busi_OrderCourseEvaluation_saveExchange.action";
	}
	var parentStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_Student_query.action'
		}),
		reader : new Ext.data.JsonReader({
			successProperty : 'success',
			root : 'result'
		}, [ {
			name : 'id',
			mapping : 'id'
		}, {
			name : 'name',
			mapping : 'name'
		} ])
	});
	parentStore.load();
	var childStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_OrderCourse_query.action?condition=order_id=' + orderId
		}),
		reader : new Ext.data.JsonReader({
			successProperty : 'success',
			root : 'result'
		}, [ {
			name : 'id',
			mapping : 'courseType'
		}, {
			name : 'name',
			mapping : 'courseType',
			convert : covCourseName
		} ])
	});
	childStore.load();
	var editForm = new Ext.FormPanel(
			{
				url : this.url,
				layout : "form",
				autoDestroy : true,
				id : "RoleForm",
				frame : false,
				border : false,
				fileUpload : true,
				bodyStyle : "padding:5px;",
				defaultType : "textfield",
				defaults : {
					anchor : "98%,100%"
				},
				reader : new Ext.data.JsonReader({
					successProperty : 'success',
					root : 'result'
				}, [ {
					name : "id",
					type : "int"
				}, "courseType", "chargerId", "studentId", "content",
						"operator", {
							name : "operatorName",
							type : "string",
							mapping : 'operator',
							convert : converOperator
						}, {
							name : "chargerName",
							type : "string",
							mapping : 'chargerId',
							convert : converCharger
						}, {
							name : "createTime",
							type : "date",
							mapping : 'createTime.time',
							dateFormat : 'time'
						}, {
							name : "lastUpdate",
							type : "date",
							mapping : 'lastUpdate.time',
							dateFormat : 'time'
						}, {
							name : "courseTime",
							type : "date",
							mapping : 'courseTime.time',
							dateFormat : 'time'
						} ]),
				items : [
						{
							id : "id",
							xtype : "hidden",
							value : this.primaryId == null ? ""
									: this.primaryId
						},
						{
							hidden : true,
							id : "orderId"
						},
						{
							hidden : true,
							id : "operator",
							value : session_userId
						},

						{
							fieldLabel : "编辑者",
							id : "operatorName",
							hidden : this.primaryId == null ? true : false
						},
						new Ext.form.ComboBox(
								{
									id : "studentId",
									hiddenName : "studentId",
									triggerAction : "all",
									fieldLabel : "学生",
									readOnly : isModify ? true : false,
									editable : false,
									emptyText : '请选择',
									mode : 'remote',
									region : "center",
									valueField : "id",
									displayField : "name",
									store : parentStore,
									listeners : {
										"select" : function(combo, record,
												index) {
											Ajax
													.syncRequest(
															'Busi_OrderInfo_queryStudentRelOrder.action?userId='
																	+ session_userId
																	+ '&studentId='
																	+ combo.value,
															function(data) {
																if (!data.result
																		|| data.result.length == 0) {
																	var studentName = Student
																			.translate(combo.value);
																	Common
																			.ErrMegBox('该'
																					+ studentName
																					+ '没有签约课程信息');
																	editForm.form
																			.reset();
																	return;
																}
																if (data.result
																		&& data.result.length == 1) {
																	orderId = data.result[0].id;
																	$(
																			"#orderId")
																			.val(
																					orderId);
																}
															});
											Ext.getCmp("courseType")
													.clearValue();
											childStore.removeAll();
											childStore.proxy = new Ext.data.HttpProxy(
													{
														url : 'Busi_OrderCourse_query.action?condition=order_id='
																+ orderId
													});
											childStore.load();
										}
									}
								}),
						new Ext.form.ComboBox(
								{
									id : "courseType",
									hiddenName : "courseType",
									triggerAction : "all",
									fieldLabel : "课程",
									readOnly : false,
									editable : false,
									emptyText : '请选择',
									mode : 'remote',
									region : "center",
									valueField : "id",
									displayField : "name",
									store : childStore,
									listeners : {
										"select" : function(combo, record,
												index) {
											$("#chargerName").val("");
											$("#chargerId").val("");
											Ajax
													.syncRequest(
															'Busi_OrderCourse_query.action?condition=orderId='
																	+ $(
																			"#orderId")
																			.val()
																	+ ' and courseType='
																	+ combo.value,
															function(data) {
																if (data.result
																		&& data.result.length == 1) {
																	var chargerId = data.result[0].chargerId;
																	var chargerName = SysUser
																			.translate(chargerId);
																	$(
																			"#chargerId")
																			.val(
																					chargerId);
																	$(
																			"#chargerName")
																			.val(
																					chargerName);
																}
															});
										}
									}
								}), {
							hidden : true,
							id : "chargerId"
						}, {
							fieldLabel : "授课老师",
							allowBlank : false,
							readOnly : true,
							id : "chargerName"
						},

						{
							fieldLabel : "上课时间",
							xtype : "datefield",
							maxValue : new Date(),
							format : "Y-m-d",
							name : "courseTime"
						}, {
							fieldLabel : "评价",
							xtype : "textarea",
							width : 400,
							height : 180,
							id : "content"
						} ]
			});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm
				.getForm()
				.load(
						{
							deferredRender : false,
							url : "Busi_OrderCourseEvaluation_query.action?condition=id="
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

function covCourseName(v, record) {
	return SysParam.translate(orderCourseStore, record.courseType);
}

function covExtimTime(v, record) {
	return new Date(record.bookTime.time).format('Y-m-d H:i:s');
}
function converCharger(v, record) {
	return SysUser.translate(record.chargerId);
}
function converOperator(v, record) {
	return SysUser.translate(record.operator);
}
