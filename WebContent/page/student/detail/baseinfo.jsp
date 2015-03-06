<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/student/infomrg/studentform.js" />
<%@ include file="/common/include/html_head.jsp"%> 
<script>
	Ext.onReady(function() {
		var studentId = jQuery.url.param("studentId");
		 var studentForm =new studentInfoForm(studentId); 
		studentForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_Student_query.action?condition=id="+studentId,
					waitMsg : "正在载入数据...",
					success : function(d, e) {
					 
					},
					failure : function(b, c) { 
						Ext.MessageBox.show( {
							title : "编辑",
							msg : "载入失败！",
							buttons : Ext.MessageBox.OK,
							icon : "ext-mb-error"
						});
					}
				}); 
		studentForm.setHeight(450);
		Frame.editPage(studentForm);
	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>