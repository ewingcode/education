<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
	Ext.onReady(function() {
		var orderId = jQuery.url.param("orderId");
		var orderCourseGrid = new OrderCourse.courseEditGrid(orderId, true);
		var orderInfoForm = new Ext.FormPanel({
			fileUpload : true,
			labelAlign : 'left',// 字样显示在顶部
			id : "card-1",
			autoScroll : true,
			buttonAlign : 'center',
			reader : new Ext.data.JsonReader({
				successProperty : 'success',
				root : 'result'
			}, [ {
				name : "id",
				type : "int"
			}, "studentId","studentName", "status", "fee", "grade", "courseHour","adjustHour",
					"costCourseHour", "scheduleHour","feeFloat", {
						name : "fee", 
						mapping : 'fee',
						convert : function(value,rec){  
								return rec.feeFloat;
						}
					}, {
						name : "startTime",
						type : "date",
						mapping : 'createTime.time',
						dateFormat : 'time'
					}, {
						name : "endTime",
						type : "date",
						mapping : 'endTime.time',
						dateFormat : 'time'
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
					}, "iseff", "des", "isLast", "curOperator",
					"costCourseHour", "runStatus", "orderNo" ]),
			items : [
					{
						xtype : 'fieldset',
						title : '签单信息',
						layout : "column",
						items : [
								{
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "orderNo",
										fieldLabel : "合同编号",
										allowBlank : false,
									} ]
								},
								{
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "studentId",
										fieldLabel : "学生id",
										hidden:true
									} , {
										id : "studentName",
										fieldLabel : "学生名称",
										allowBlank : false,
										readOnly:true
									}  ]
								},
								{
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [  {
										id : "fee",
										fieldLabel : "签单费用(元)",  
										allowBlank : false
									} ]
								},
								{
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ new SysParam.ComboBox('年级',
											'grade', 'GRADE', false) ]
								}, {
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "courseHour",
										fieldLabel : "课时总数(小时)",
										maxLength : 10,
										allowBlank : false
									} ]
								},{
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "adjustHour",
										fieldLabel : "调整课时(小时)",
										maxLength : 10 
									} ]
								}, {
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "costCourseHour",
										fieldLabel : "已消耗课时(小时)",
										maxLength : 10,
										readOnly:true
									} ]
								}, {
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "startTime",
										xtype : "datefield",
										format : "Y-m-d",
										fieldLabel : "开始时间",
										allowBlank : false,
										maxLength : 10,
										vtype : 'daterange',
										endDateField : 'endTime'
									} ]
								}, {
									xtype : "container",
									columnWidth : 1,
									layout : "form",
									defaultType : "textfield",
									defaults : {
										width : 300,
										labelStyle : 'text-align:right;'
									},
									items : [ {
										id : "endTime",
										xtype : "datefield",
										format : "Y-m-d",
										fieldLabel : "结束时间",
										allowBlank : false,
										maxLength : 10,
										vtype : 'daterange',
										startDateField : 'startTime'
									} ]
								} ]
					}, orderCourseGrid.grid ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() {

					if (!orderInfoForm.getForm().isValid())
						return;
					var totalHour = $('#courseHour').val() - $('#adjustHour').val();;
					if (!orderCourseGrid.validate(totalHour))
						return;
					var checkCourse = '';
					checkCourse = orderCourseGrid.getCourseList();

					// 验证是否有上传文件
					/*
					 * if (!Order.validateAttach(SUBMITTYPE_UPLOAD_FILE)) return;
					 */
				  	 orderInfoForm.getForm().submit({
						url : "Busi_OrderControl_editOrder.action",
						method : "post",
						params : {
							courseList : checkCourse,
							orderId:orderId
						},
						waitMsg : "正在提交数据...",
						success : function(i, j) {
							 Ext.Msg.show( {
									title : '编辑',
									msg : '保存成功',
									fn:function(){
									   parent.window.closeTabPanel(orderId);
								 	},
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								});     
						},
						failure : function(i, j) {
							Common.ErrMegBox(j.result.retinfo);

						}
					});  
				}
			} ]
		});

		if (orderId != null) {
			orderInfoForm.getForm().load({
				deferredRender : false,
				url : "Busi_OrderInfo_findOrderInfo.action?orderId=" + orderId,
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
		Frame.editPage(orderInfoForm);
	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>