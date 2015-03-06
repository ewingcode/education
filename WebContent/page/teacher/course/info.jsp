<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
Ext.onReady(function() { 
 
var menuUrl=_contextPath+"/page/teacher/course/schedule.jsp";   
var  editform = new Ext.Panel( {   
		id : "contractEditForm", 
		frame : true,
		border : true,   
		bodyStyle : "padding:5px;", 
		height:600,
		buttonAlign:'center', 
		autoScroll:true, 
		items:[ { 
			//	html:"11"
			height:400,
			  html : '<iframe   src="'+menuUrl+'"  frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
					}									
				],
		 buttons : [ {
					text : "保存",
					iconCls : "btn_save",
					handler : function() { 
						alert(menuUrl);   
						}
					}] 
  });   
  Frame.editPage( editform ); 
   
});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>