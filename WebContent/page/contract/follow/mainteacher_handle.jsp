<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
	Ext.onReady(function() {
		var orderId = jQuery.url.param("orderId");
		var isOnlyEdit = jQuery.url.param("isOnlyEdit");
		Order.initData(); 
		var editform = new Ext.FormPanel(
				{
					layout : "form",
					autoDestroy : true,
					fileUpload : true, 
					id : "contractEditForm",
					frame : false,
					border : false,
					autoScroll : true,
					bodyStyle : "padding:5px;",
					defaultType : "textfield",
					height : 600,
					buttonAlign : 'center',
					items : [
							new Order.contractStatus(orderId),
							/*	new Order.fileListComp(orderId, '1,2,3,4'),
						 	new Order.fileUploadComp('教学方案', "5", orderId,
									true, false), */
							new Order.courseManage(orderId, true, false)
							,new Order.showTrace(orderId)
									 ],
					buttons : [ {
						text : "保存",
						iconCls : "btn_save",
						handler : function() { 
							 var transitionName = $("#transitionName").val(); 
						     if(isOnlyEdit!='true' && '确认'==transitionName){   
								if (!Order.validateCourse(COURSEOPER_CHARGER))
									return;
								if (!Order.validateAttach(SUBMITTYPE_UPLOAD_FILE))
									return;
								/* if(!Order.validateReplyNotPassCharger())
								    return;  */
							  }  
							Order.submitForm(jQuery.url.param("isOnlyEdit"),editform, orderId,
									SUBMITTYPE_UPLOAD_FILE, $("#assignerId")
											.val(), '',COURSEOPER_CHARGER); 
						}
					},
					{
					   text : "关闭",
						iconCls : "btn_cancel",
						handler : function() { 
					       parent.window.closeTabPanel(orderId); 
						}
					} ]
				}); 
				 if(!isOnlyEdit || isOnlyEdit!='true'){ 
				 	 editform.add(new Order.transitionChoice(orderId));
				 	 editform.add( new Assigner.assingerFiled(orderId)); 
				  } 
				Frame.editPage( editform ); 
	});
 </script>
 

<%@ include file="/common/include/html_bottom.jsp"%>