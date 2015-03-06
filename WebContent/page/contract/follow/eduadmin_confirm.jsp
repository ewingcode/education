<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
Ext.onReady(function() {  
  var orderId = jQuery.url.param("orderId"); 
  var isOnlyEdit = jQuery.url.param("isOnlyEdit"); 
	 Order.initData(); 
var  editform = new Ext.FormPanel( { 
		layout : "form",
		autoDestroy:true, 
		id : "contractEditForm", 
		frame : false,
		border : false,  
		autoScroll:true,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		height:600,
		buttonAlign:'center',  
		items:[   
			new Order.contractStatus(orderId),
			new Order.fileListComp(orderId,'1,2,3,4'),
			new Order.courseManage(orderId, false, true),
			new Order.fileUploadComp('教学方案',"5",orderId,false,true) 
				],
		 buttons : [ {
					text : "保存",
					iconCls : "btn_save",
					handler : function() { 
					if(isOnlyEdit!='true'){  
								if(!Order.validateCourse(COURSEOPER_APPLY))
								    return;
							 //验证是否有上传文件
								 if(!Order.validateAttach(SUBMITTYPE_APPLY_FILE))
									 return;
									 var transitionName = $("#transitionName").val(); 
								 var isExistNotPassAttach = Order.existNotPassAttach();
								 var isExistNotPassCourse = Order.existNotPassCourse();
							     if(isExistNotPassAttach ) { 
									if('不通过'!=transitionName){
										 Common.ErrMegBox('存在不通过的文档审批记录，签单处理应为不通过'); 
										 return;
									 }
								  }
								 
								 if(isExistNotPassCourse){ 
									if('不通过'!=transitionName){
									 Common.ErrMegBox('存在不通过的课程审批记录，签单处理应为不通过'); 
									 return;
								 }
							  }
							  if(!isExistNotPassCourse && !isExistNotPassAttach){
							  	if('通过'!=transitionName){
									 Common.ErrMegBox('签单处理应为通过'); 
									 return;
								 }
							  }
						  }
					     Order.submitForm(jQuery.url.param("isOnlyEdit"),editform,orderId,SUBMITTYPE_APPLY_FILE,$("#assignerId").val(),'',COURSEOPER_APPLY);
					  
						}
					},
					{
					   text : "关闭",
						iconCls : "btn_cancel",
						handler : function() { 
					       parent.window.closeTabPanel(orderId); 
						}
					}] 
  });  
    if(isOnlyEdit!='true'){ 
 	 editform.add(new Order.transitionChoice(orderId));
 	 editform.add( new Assigner.assingerFiled(orderId)); 
  }
  Frame.editPage( editform ); 
});
</script>
 
 
<%@ include file="/common/include/html_bottom.jsp"%>