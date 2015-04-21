<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/js/ireport/jasperreports.js" />
<script> 
   Ext.onReady(function() { 
   var  searchform = new Ext.FormPanel( { 
		layout : "form",   
		frame : true, 
		border : true,  
		autoScroll:true,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		height:100,
		buttonAlign:'center',  
		items:[ 
		{  
			allowBlank : false, 
			hidden:true,
			id : "reportID" ,
			value:"OrderCountDaily"
		} ,{
			fieldLabel : "起始日期",
			allowBlank : false, 
			id : "beginDate",
			xtype:"datefield",
			format:"Y-m-d",
		},{
			fieldLabel : "结束日期",
			allowBlank : false, 
			id : "endDate",
			xtype:"datefield",
			format:"Y-m-d",
		}
		 ],
		 buttons : [ {
					text : "查询",
					iconCls : "btn_query",
					handler : function() {   
					      var sql ="select date_format(create_time,'%Y-%m-%d') as create_date,count(*) as total from order_info where 1=1 ";
					          if($("#beginDate").val()!='')
 								   sql += " and date_format(create_time,'%Y-%m-%d') >='"+$("#beginDate").val()+"'";
					           if($("#endDate").val()!='')
					        	   sql += " and date_format(create_time,'%Y-%m-%d') <='"+$("#endDate").val()+"'";
						      sql +=" group by date_format(create_time,'%Y-%m-%d')";
					      var title="签单日统计报表";
					      var headers="签单日期,签单总数";
					      var alias="create_date,total";
					      var paramMap = {
					              "STATISTIC_TIME" : $("#beginDate").val()+"到"+ $("#endDate").val()
					         }; 
					     JasperReports.doQuery(sql,title,headers,alias,paramMap);
						}
					},
					{
					   iconCls : "btn_reset",
						text : "重置",  
						handler : function() {
							searchform.form.reset();
						} 
					}] 
  });  
 	searchform.render("searchCondition");
});
</script>

 
	<body>
		<div id="searchCondition"></div>
		 <jsp:include flush="true" page="/jasperreports/commons/brower.jsp" />
	</body>
 <%@ include file="/common/include/html_bottom.jsp"%>