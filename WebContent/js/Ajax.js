 Ext.ns("Ajax");
 
 Ajax.syncRequest= function(url,successFn){
 	$.ajax({
			url : encodeURI(url),
			type : 'POST',
			async : false,
			dataType : 'json', 
			success :  successFn  
 			 
		});
}
 
 
 Ajax.asyncRequest= function(url,completeFn){
 	$.ajax({
			url : encodeURI(url),
			type : 'POST',
			async : true,
			dataType : 'json', 
			complete :  completeFn  
 			 
		});
}