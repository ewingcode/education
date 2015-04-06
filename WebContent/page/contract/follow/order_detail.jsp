<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
Ext.onReady(function() {  
  var orderId = jQuery.url.param("orderId");  
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
			new Order.contractStatus(orderId),/* 
			new Order.fileListComp(orderId,'1,2,3,4,5'), */
			new Order.courseList(orderId,true),
			new Order.showTrace(orderId),
			   new OrderCharger.roleManage(orderId)
		 ] 
		  
  }); 
   Frame.editPage( editform ); 
});
</script>
 
 
<%@ include file="/common/include/html_bottom.jsp"%>