<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%>
<style>
a:link,a:visited {
	text-decoration: none;
	font-weight: bold;
	border-bottom: 1px dotted #000;
}

a:hover,a:active {
	border-bottom-style: solid;
}

 
</style> 
<script>
	Ext.onReady(function() {
		var teacherId = jQuery.url.param("teacherId");
		var isReadOnly = jQuery.url.param("isReadOnly");  
		var shedulePanel = new Ext.FormPanel({
			region : 'center',
			split : true,
			defaultType : "textfield",
			height : 1000,
			autoScroll : true,
			buttonAlign : 'center',
			items : [ new Schedule.showCalender(teacherId, isReadOnly) ]
		});
		Frame.editPage(shedulePanel);
	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>