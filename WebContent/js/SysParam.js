Ext.ns("SysParam");
/**
 * 异步静态参数store
 */ 

SysParam.asyncStore=function(rootCode){
	var paramStore = new Ext.data.Store( {
		  autoLoad : true,// 是否自动加载
		  proxy : new Ext.data.HttpProxy( {
		  url : "Public_SysParam_queryByRootCode.action?rootCode="+rootCode
		}),
		reader : new Ext.data.JsonReader( {
			id:"paramValue",
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ 'paramName', 'paramValue' ]
		}) 
	});
	paramStore.load();
	return paramStore; 
};

/**
 * 同步静态参数store
 */
SysParam.store=function(rootCode){
	var url = "Public_SysParam_queryByRootCode.action?rootCode="+rootCode;
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
	return arrayStore; 
};
SysParam.ComboBox = function(fieldName, filedId, rootCode, allowBlank,isReadOnly,selectFn) {
	var _allowBlank = true;
	var _isReadOnly=false;
	if (allowBlank != null)
		_allowBlank = allowBlank;
	if (isReadOnly != null)
		_isReadOnly =  isReadOnly; 
	 var url = "Public_SysParam_queryByRootCode.action?rootCode="+rootCode;
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
				   "select": function(combo,  record, index){
							if($.isFunction(selectFn))
								selectFn(combo,record,index)
								}
				}
			});
};

SysParam.translate = function(paramStore, value) {
	var retStr=null; 
	for ( var i = 0; i < paramStore.getCount(); i++) {
		var rec = paramStore.getAt(i);
		if (rec.get('paramValue') == value) {
			retStr = rec.get('paramName');
		}
	} 
	return   retStr ;
};
 

SysParam.checkbox = function(fieldName, fieldId, rootCode,selectArray,checkFn) {  
	var url = "Public_SysParam_queryByRootCode.action?rootCode="+rootCode; 
	var checkItems="";	  
	 Ajax.syncRequest(url,  
			 function(data) {  
		 		 for(var i=0;i<data.result.length;i++){
		 			var paramValue =data.result[i].paramValue;
		 			var paramName =data.result[i].paramName; 
		 			checkItems +="{ boxLabel: '"+paramName+"',  name:'"+paramName+"',  inputValue:'"+paramValue+"'   ";
		 			 
		 			if(selectArray!=null){
		 				 for(var j=0;j<selectArray.length;j++){
		 					if(paramValue == selectArray[j]){
		 						checkItems +=" ,checked: true";
		 						break;
		 					}
		 				} 
		 			}
		 			 if($.isFunction(checkFn)){
		 				checkItems += " ,  listeners:{'check':function(checkbox,isChecked){checkFn(checkbox,isChecked)} }";
                   
		 			}  
		 			checkItems += " }"; 
		 				if(i<data.result.length-1)
		 					checkItems += ",";
		 		 	} 
		 		 }
	  );  
	 var checkboxField ={
				id:fieldId,
			    xtype: 'checkboxgroup',
			    fieldLabel:fieldName,  
			    columns: 4,
			    items: eval("["+checkItems+"]")
		};
	return   checkboxField ;
}; 
