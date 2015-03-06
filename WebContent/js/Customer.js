Ext.ns("Customer");
Customer.translate = function(customerId) {
	var url = "Busi_Customer_query.action?condition=id=" + customerId;
	var retStr = "";
	Ajax.syncRequest(url, function(data) {  
		 if (data.result && data.result.length==1 ){ 
			retStr = data.result[0].name;
		 }
	}); 
	return retStr;
}

Customer.mutipleId = function( customerName) {  
	if(customerName =='' || customerName==null)
		return ''; 
	var sql ="name like '"+customerName+"%'"; 
	var url = "Busi_Customer_query.action?condition="+sql;  
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) {   
		 		for(var i=0;i<data.result.length;i++){
		 		  retStr += data.result[i].id;
		 		 if( i < data.result.length-1)
		 			retStr +=",";  
		 		}
	 }); 
	 if(retStr=='')
		 return 0;
	return   retStr ;
};