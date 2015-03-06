<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%> 
 <script>
 
 Ext.onReady(function() {   
    var menuUrl = jQuery.url.param("menuUrl");  
    alert(menuUrl)
   Frame.busiPage3(menuUrl);
});
 

 
 </script>
<%@ include file="/common/include/html_bottom.jsp"%>