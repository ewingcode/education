<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%>

<script>
	Ext
			.onReady(function() {
				var teacherId = session_userId;
				var scheduledailyUrl = _contextPath
						+ "/page/teacher/course/scheduledaily.jsp?teacherId="
						+ teacherId+"&isReadOnly=true";
				var scheduleSettingUrl = _contextPath
						+ "/page/teacher/course/schedulesetting.jsp?teacherId="
						+ teacherId+"&isReadOnly=true";
				var tabs = new Ext.TabPanel(
						{
							activeTab : 0,
							border : false,
							autoScroll : false,
							items : [
									{
										title : '排课列表',
										height : 800,
										autoWidth : true,
										iconCls : 'tabs',
										html : '<iframe  src="'
												+ scheduleSettingUrl
												+ '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
									},
									{
										title : '日程表',
										autoWidth : true,
										height : 800,
										iconCls : 'tabs',
										html : '<iframe  src="'
												+ scheduledailyUrl
												+ '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
									}

							]
						});
				var shedulePanel = new Ext.FormPanel({
					//title : '日程表',
					region : 'center',
					split : true,
					width : "100%",
					layout : "form",
					autoScroll : true,
					defaultType : "textfield",
					buttonAlign : 'center',
					items : [ tabs ]

				});
				new Ext.Viewport({
					layout : 'border',
					items : [ shedulePanel ]
				});
			});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>