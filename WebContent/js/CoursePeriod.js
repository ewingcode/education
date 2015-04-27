Ext.ns("CoursePeriod");
/**
 * 课程时间
 */

CoursePeriod.store=function(){ 
	var url = "Busi_CoursePeriod_queryByCache.action";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	           {name: 'paramName'},
	           {name: 'paramValue'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);
		 		 for(var i=0;i<data.result.length;i++){
		 			var paramValue = data.result[i].id;
		 			var paramName = data.result[i].startTime+"-"+data.result[i].endTime;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj);
	return arrayStore; 
};
CoursePeriod.ComboBox = function( filedId, allowBlank) {
	var _allowBlank = true;
	if (allowBlank != null)
		_allowBlank = allowBlank;
	
	 var url = "Busi_CoursePeriod_queryByCache.action";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	          {name: 'paramName'},
	           {name: 'paramValue'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);
		 		 for(var i=0;i<data.result.length;i++){
		 			var paramValue = data.result[i].id;
		 			var paramName = data.result[i].startTime+"-"+data.result[i].endTime;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj); 
	return new Ext.form.ComboBox(
			{
				id : filedId,
				hiddenName : filedId,
				triggerAction : "all",
				fieldLabel : "课程时间",
				editable : false,
				emptyText : '请选择',    
				lazyRender:true,
				mode: 'local', 
				region : "center",
				valueField : "paramValue",
				displayField : "paramName",
				allowBlank : _allowBlank,
				 store : arrayStore
				 
			});
};

CoursePeriod.translate = function( roleId) {
	var url = "Busi_CoursePeriod_queryByCache.action?condition=id="+roleId; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) { 
		 	 if(data.result && data.result.length==1)
		 		 retStr =data.result[i].startTime+"-"+data.result[i].endTime;
	 }); 
	return   retStr ;
};