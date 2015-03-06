<%@ page language="java" pageEncoding="UTF-8"%>
 <c:if test="${_jsFiles!=null && _jsFiles != ''}">
		<c:forEach items="${fn:split(_jsFiles,',')}" var="jsFile">
			<script type="text/javascript" src="${jsFile}"></script>
		</c:forEach>
	</c:if> 
	</body>
	</html>
