<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/js/ireport/jasperreports.js" />
<script>
	Ext
			.onReady(function() {
				var searchform = new Ext.FormPanel(
						{
							layout : "form",
							frame : true,
							border : true,
							autoScroll : true,
							bodyStyle : "padding:5px;",
							defaultType : "textfield",
							height : 100,
							buttonAlign : 'center',
							items : [ {
								allowBlank : false,
								hidden : true,
								id : "reportID",
								value : "OrderCountDaily"
							}, {
								fieldLabel : "起始月份",
								allowBlank : false,
								id : "beginDate",
								xtype : "datefield",
								format : "Y-m",
							}, {
								fieldLabel : "结束月份",
								allowBlank : false,
								id : "endDate",
								xtype : "datefield",
								format : "Y-m",
							} ],
							buttons : [
									{
										text : "查询",
										iconCls : "btn_query",
										handler : function() {
											var sql = "select date_format(create_time,'%Y-%m') as month,count(*) as total,"+
											    "sum(course_hour) as course_hour,sum(cost_course_hour) as cost_course_hour,"+
											    "sum(schedule_hour) as schedule_hour from order_info where 1=1 ";
											if ($("#beginDate").val() != '')
												sql += " and date_format(create_time,'%Y-%m') >='"
														+ $("#beginDate").val()
														+ "'";
											if ($("#endDate").val() != '')
												sql += " and date_format(create_time,'%Y-%m') <='"
														+ $("#endDate").val()
														+ "'";
											sql += " group by date_format(create_time,'%Y-%m')";
											var title = "签单日统计报表"
											var headers = "月份,总数,课时,已用课时,已排课时";
											var alias = "month,total,course_hour,cost_course_hour,schedule_hour";
											var paramMap = {
												"STATISTIC_TIME" : $(
														"#beginDate").val()
														+ "到"
														+ $("#endDate").val()
											};
											JasperReports.doQuery(sql, title,
													headers, alias, paramMap);
										}
									}, {
										iconCls : "btn_reset",
										text : "重置",
										handler : function() {
											searchform.form.reset();
										}
									} ]
						});
				searchform.render("searchCondition");
			});
</script>


<body>
	<div id="searchCondition"></div>
	<jsp:include flush="true" page="/jasperreports/commons/brower.jsp" />
</body>
<%@ include file="/common/include/html_bottom.jsp"%>