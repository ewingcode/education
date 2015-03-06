<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ taglib uri="/WEB-INF/ai-fn" prefix="aiFn"%>
 <c:set var="_appDefaultPortTemp"
	value="${(pageContext.request.serverPort == '80' || pageContext.request.serverPort == '') ? '' : aiFn:append(':', pageContext.request.serverPort)}" />
<c:set var="_contextPath"
	value="${pageContext.request.scheme}://${pageContext.request.serverName}${_appDefaultPortTemp}${pageContext.request.contextPath}" />
<%-- 设置页面根路径（简写） --%>
<c:set var="_cp" value="${_contextPath}" /> 
 