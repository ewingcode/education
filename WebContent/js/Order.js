Ext.ns("OrderPublic");



OrderPublic.relOrderCompBox = function(userId,studentId) {
 
	 var url = "Busi_OrderInfo_queryRelOrder.action?userId="+userId+"&studentId="+studentId;
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
		 			var paramValue =data.result[i].paramValue;
		 			var paramName =data.result[i].paramName;
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
				fieldLabel : fieldName,
				readOnly : false,
				editable : false,
				emptyText : '请选择',   
				lazyRender:true,
				mode: 'local', 
				region : "center",
				valueField : "paramValue",
				displayField : "paramName",
				allowBlank : _allowBlank,
				store:arrayStore, 
			    listeners:{ 
				   "select": function(c,r,i){
							if($.isFunction(selectFn))
								selectFn(c,r,i)
								}
				}
			});
};
