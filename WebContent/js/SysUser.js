Ext.ns("SysUser");
/**
 * 系统用户
 */

SysUser.store=function(){ 
	var url = "Public_SysUser_queryAll.action?rootCode="+rootCode;
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
		 			var paramName =data.result[i].userName;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj);
	return arrayStore; 
};
SysUser.ComboBox = function( filedId, allowBlank) {
	var _allowBlank = true;
	if (allowBlank != null)
		_allowBlank = allowBlank;
	
	 var url = "Public_SysUser_queryAll.action";
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
		 			var paramName =data.result[i].userName;
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
				fieldLabel : "操作员",
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

SysUser.translate = function( userId) {
	var url = "Public_SysUser_queryByCache.action?condition=id="+userId; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) {  
		 	 if(data.result && data.result.length==1){
		 		 retStr =data.result[0].userName;  
		 	 }
	 }); 
	return   retStr ;
};

SysUser.mutipleTranslate = function( userId) {
	var userIds = userId.split(",");
	if(userIds =='' || userIds.length==0)
		return ''; 
	var sql ="id in ("
	for(var i=0;i<userIds.length;i++){
		sql += userIds[i]; 
		if( i < userIds.length-1)
			sql +=",";    
	}
	sql +=")";
	 
	var url = "Public_SysUser_queryByCache.action?condition="+sql; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) {   
		 		for(var i=0;i<data.result.length;i++){
		 		  retStr += data.result[i].userName;
		 		 if( i < data.result.length-1)
		 			retStr +=",";  
		 		}
	 }); 
	return   retStr ;
};

SysUser.mutipleId = function( userName) {  
	if(userName =='' || userName==null)
		return ''; 
	var sql ="user_name like '"+userName+"%'"; 
	var url = "Public_SysUser_query.action?condition="+sql;  
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
