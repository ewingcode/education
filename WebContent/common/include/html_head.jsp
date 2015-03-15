<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%-- html head标签中的内容 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv=Cache-Control content=no-cache />
		<meta http-equiv=Expires content=0 />
		<title>华实教育</title>

		<link rel="stylesheet" type="text/css"
			href="${_contextPath}/resources/css/ext-all.css"></link>
		<!--灰色样式
		<link rel="stylesheet" type="text/css" title="gray"
			href="${_contextPath}/resources/css/xtheme-gray.css" /> 
		-->
		<link rel="stylesheet" type="text/css"
			href="${_contextPath}/resources/css/debug.css"></link>
		<link rel="stylesheet" type="text/css"
			href="${_contextPath}/js/core/ext/portal/Portal.css"></link>
		<link rel="stylesheet" type="text/css"
			href="${_contextPath}/css/common.css"></link>
	<link rel="stylesheet" type="text/css"
			href="${_contextPath}/frame/main/layout-browser.css"></link>
		<script type="text/javascript"
			src="${_contextPath}/js/core/jquery/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/core/jquery/jquery.url.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/core/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/core/ext/ext-all.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/core/ext/ux/RowExpander.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/core/ext/ux/SearchField.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/pushlet/js-pushlet-client.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/pushlet/ajax-pushlet-client.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysParam.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Common.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Department.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Plugin.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Frame.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Ajax.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysUser.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysRole.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Student.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Teacher.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Public.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/Customer.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysResource.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysOrg.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysRoleTree.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/SysArea.js"></script>
		<script type="text/javascript" src="${_contextPath}/js/DateUtil.js"></script>
		<script type="text/javascript"
			src="${_contextPath}/js/ireport/jasperreports.js"></script>
		<script type="text/javascript"> 
	var _contextPath = '${_contextPath}';//js中使用的当前路径
	var outsession = jQuery.url.param("outsession");
	if (outsession == '0')
		parent.location.href = _contextPath + "/login.jsp";
	var _cp = '${_cp}';//js中使用的当前路径
	var userInfo = '${sessionScope.USER_INFO_SESSION}';
	var session_userId = '${sessionScope.USER_INFO_SESSION.id}';
	var session_userName = '${sessionScope.USER_INFO_SESSION.userName}';
	var session_roleId = '${sessionScope.USER_INFO_SESSION.roleId}';
	var session_depId= '${sessionScope.USER_INFO_SESSION.depId}';
	var session_sex= '${sessionScope.USER_INFO_SESSION.sex}';

</script>
	</head>
	<body>