<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%> 
<script>
	Ext.onReady(function() {
		var teacherId = jQuery.url.param("teacherId");
		var shedulePanel = new Ext.FormPanel({ 
			region : 'center',
			split : true,  
			defaultType : "textfield",
			height:1000, 
			autoScroll : true,
			buttonAlign : 'center',
			items : [  new Schedule.showCalender(teacherId)
			]  
		});
		Frame.editPage(shedulePanel);
	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>