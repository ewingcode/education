<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
 
<script type="text/javascript"> 
	  function init() { 
			p_join_listen('/notice');
  		}

		// Event Callback: display all events
		function onEvent(event) { 
		      var userId = ${sessionScope.USER_INFO_SESSION.id};
			$("#title").html(event.get("notice_"+userId+"_notreadcount")); 
		}
</script>
 
<body  onLoad="init()">
	<h1>
		my first pushlet
		now
	</h1>
	<div id="title">2222</div>
</body> 
<%@ include file="/common/include/html_bottom.jsp"%>

