Ext.ns("Department");
/**
 * 系统部门
 */

Department.store=function(){ 
	 
	var url = "Public_SysDepartment_queryByCache.action";
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
		 			var paramValue =data.result[i].id;
		 			var paramName =data.result[i].name;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj);
	return arrayStore; 
};
Department.ComboBox = function( filedId, allowBlank) {
	var _allowBlank = true;
	if (allowBlank != null)
		_allowBlank = allowBlank;
	
	 var url = "Public_SysDepartment_queryByCache.action";
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
		 			var paramValue =data.result[i].id;
		 			var paramName =data.result[i].name;
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
				fieldLabel : "部门",
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

Department.translate = function( roleId) {
	var url = "Public_SysDepartment_queryByCache.action?condition=id="+roleId; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) { 
		 	 if(data.result && data.result.length==1)
		 		 retStr =data.result[0].name;
	 }); 
	return   retStr ;
};
