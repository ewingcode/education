<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles"
	value="${_cp}/page/system/menu/menuview.js,${_cp}/page/system/menu/menuedit.js" />
<%@ include file="/common/include/html_head.jsp"%>
<style type="text/css">
#menu_div,#edit_div {
	float: left;
	margin: 20px;
	border: 1px solid #c3daf9;
	overflow: auto;
}
</style>
<div id="menu_div">
</div>
<div id="edit_div">
</div>
<%@ include file="/common/include/html_bottom.jsp"%>