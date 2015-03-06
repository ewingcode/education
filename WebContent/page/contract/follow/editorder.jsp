<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
	Ext.onReady(function() {
		var orderId = jQuery.url.param("orderId");
		var isOnlyEdit = jQuery.url.param("isOnlyEdit");
		Order.initData();
		var courseMangeFiled = new Order.courseManage(orderId, true, false,
				true);
		var editform = new Ext.FormPanel( {
			layout : "form",
			autoDestroy : true,
			id : "contractEditForm",
			frame : false,
			border : false,
			fileUpload : true,
			autoScroll : true,
			bodyStyle : "padding:5px;",
			defaultType : "textfield",
			height : 600,
			buttonAlign : 'center',
			items : [
					Order.courseTimeEdit(orderId),
					new Order.fileUploadComp('初期辅导方案', "1", orderId, true,
							false, true,true),
					new Order.fileUploadComp('华实模拟协议', "2", orderId, true,
							false, true,true),
					new Order.fileUploadComp('华实全方位测评报告', "3", orderId, true,
							false, true,true),
					new Order.fileUploadComp('教学安排表', "4", orderId, true,
							false, true,true)

			],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() {
					var courseList = Ext.getCmp("courseList").getValue();
					var checkCourse = '';
					// 验证是否有选择课程
				for (i = 0; i < courseList.length; i++) {
					checkCourse += courseList[i].inputValue;
					if (i < courseList.length - 1)
						checkCourse += ",";
				}
				if (checkCourse == '') {
					Ext.MessageBox.show( {
						title : "操作信息",
						msg : "可选课程不能为空！",
						buttons : Ext.MessageBox.OK,
						icon : "ext-mb-error"
					});
					return;
				}
				if (!Order.validateCourse(COURSEOPER_CHARGER))
					return;
				if (!Order.validateAttach(SUBMITTYPE_UPLOAD_FILE))
					return;
				sumitForm(editform, orderId,isOnlyEdit);
			}
			}, {
				text : "关闭",
				iconCls : "btn_cancel",
				handler : function() {
					parent.window.closeTabPanel(orderId);
				}
			} ]
		});
		var courseTypeFiled = new Order.courseTypeEdit(orderId,
				courseMangeFiled, editform);
		var file5Filed = new Order.fileUploadComp('教学方案', "5", orderId, true,
				false, true,true); 
		editform.add(file5Filed);
		editform.add(courseTypeFiled);
		editform.add(courseMangeFiled);

		Frame.editPage(editform);
	});

/**
	 * 流程提交
	 *  
	 * @param parentOrderId 
	 * @return
	 */
	function sumitForm(editform, orderId ,isOnlyEdit) { 
		if (!editform.getForm().isValid())
			return; 
		Ext.Msg.confirm("信息确认", "您确认要保存该记录吗？", function(c) {
			if (c == "yes") {

				editform.getForm().submit( {
					url : "Busi_OrderControl_editOrder.action",
					method : "post",
					params : { 
						orderId : orderId,
						isOnlyEdit:isOnlyEdit
					},
					waitMsg : "正在提交数据...",
					success : function(i, j) {
						Ext.Msg.show( {
							title : '编辑',
							msg : '保存成功',
							fn : function() {
								parent.window.closeTabPanel(orderId);
							},
							buttons : Ext.MessageBox.OK,
							icon : Ext.Msg.INFO
						});
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
		});

	};
	 
</script>

<%@ include file="/common/include/html_bottom.jsp"%>