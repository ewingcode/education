 
JasperReports = function(){}
 
JasperReports.doQuery = function(sql,title,headers,alias,paramMap){ 
    var url = "Public_JasperReport_doQuery.action?";
    url +=  "sql="+sql;
    url +=  "&title="+title;
    url +=  "&headers="+headers;
    url +=  "&alias="+alias;  
    for (var key in paramMap) {
         
          url +=  "&"+key+"="+paramMap[key];  
       }
    Ajax.syncRequest(url,  
			 function(data) {  
		           JasperReports.refreshPage(data.result);
		 		 }
	  
	  );  
}

 
JasperReports.refreshPage = function(retMap){
	 
	if(retMap==null || retMap=='undefined'){
		$("#reportView").css( "display", "none" ); 
		return;
	}
	$("#reportView").css( "display", "" ); 
	 
	var pageIndex = parseInt(retMap.pageIndex);
	var lastPageIndex = parseInt(retMap.lastPageIndex);
	
	 $("#printOpt").attr("href",_contextPath + "/jasperreports/commons/print?imageKey=" + retMap.imageKey);
	 $("#exportOpt").attr("href",  _contextPath + "/jasperreports/commons/export?imageKey=" + retMap.imageKey);
	
	if(pageIndex > 1){
		$("firstPage").html("<a href=\"javascript:JasperReports.doQuery(1);\"><img src=\"" + _contextPath + "/images/jasperview/first.GIF\" border=\"0\"></a>");
		$("priorPage").html( "<a href=\"javascript:JasperReports.doQuery(" + (pageIndex - 1) + ");\"><img src=\"" + _contextPath + "/images/jasperview/previous.GIF\" border=\"0\"></a>");
	}else{
		$("firstPage").html( "<img src=\"" + _contextPath + "/images/jasperview/first_grey.GIF\" border=\"0\">");
		$("priorPage").html(  "<img src=\"" + _contextPath + "/images/jasperview/previous_grey.GIF\" border=\"0\">");
	}
	
	if(pageIndex < lastPageIndex){
		$("nextPage").html(  "<a href=\"javascript:JasperReports.doQuery(" + (pageIndex + 1) + ");\"><img src=\"" + _contextPath + "/images/jasperview/next.GIF\" border=\"0\"></a>");
		$("lastPage").html(  "<a href=\"javascript:JasperReports.doQuery(" + lastPageIndex + ");\"><img src=\"" + _contextPath + "/images/jasperview/last.GIF\" border=\"0\"></a>");
	}else{
		$("nextPage").html(  "<img src=\"" + _contextPath + "/images/jasperview/next_grey.GIF\" border=\"0\">");
		$("lastPage").html( "<img src=\"" + _contextPath + "/images/jasperview/last_grey.GIF\" border=\"0\">");
	} 
	 
	$("#reportContent").html(retMap.reportContent);
}