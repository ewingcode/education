 Ext.ns("Teacher");

 Teacher.selectWin = function(parentSelectId,parentSelectUserName,frameId) {
	    var _frameId=frameId!=null?frameId:'frameId1'; 
		var url = _contextPath + '/page/teacher/select/select.jsp?1=1' ;
		url += '&parentSelectUserName=' + parentSelectUserName;
		url += '&parentSelectId=' + parentSelectId;
		var win = new Ext.Window( {
			id : "orgStructForm",
			title : '选择教师',
			width : 460,
			height : 510, 
			layout : 'fit',
			autoScroll : true,
			plain : true,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : [ {
				html : '<iframe  src="' + url
						+ '" frameborder="0"   scrolling="yes"  name="' + _frameId
						+ '"  id="' + _frameId + '" width="100%" height="100%"/>'
			} ],
			buttons : [ {
				text : "确定",
				iconCls : "btn_accept",
				handler : function() {
					document.frames(_frameId).window.confirm();
					win.close();
				}
			}, {
				text : "取消",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
		});
		win.show();

	};
 
 Teacher.choose =function(){ 
	 var field =   {
			    xtype: 'compositefield',
			    id:"assignerComp",
                fieldLabel: '教师',
                width:"300", 
                items: [
					{ 
						xtype:"textfield",   
						id : "teachId",
						hidden:true 
					},
					{ 
						xtype:"textfield",  
						id : "assignerName",
						readOnly : true,
						disabled:true,
						width:"150"
					} ,
                    { 
						xtype:"button",
						id:"choseAssigerBtn",
						text : "选择指派人",
						width:"150",
						readOnly:true,
						disabled:true,
						 listeners: {
				        	   "click": function( d, i, n, e ){ 
									  new Teacher.assingerWindow(); 
								 
			                   }
				       		}
					} 
                ]
			};
	return field; 
};
Teacher.assingerWindow = function(assingerId,assingerName,lastAssingerIdValue) { 
  var _assingerName=assingerName;
  var _assingerId=assingerId; 
  var _lastAssingerId=lastAssingerIdValue;
   // Custom rendering Template for the View
  var resultTpl = new Ext.XTemplate(
		   '<tpl for=".">',
		      '<div class="search-item">', 
		          '<p style="CURSOR: pointer">{userName}</p>',
		      '</div></tpl>'
  );
  var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy( {
			url : 'Busi_Teacher_pageQuery.action'
		}),
      reader : new Ext.data.JsonReader( {
  		root : 'result',
  		totalProperty : 'totalProperty',
  		remoteSort : true,
  		fields : [ 
  		   { name : "id", type : "int" }, 
  		"userName", "addr", "sex", "position","depId", "phone", "zipcode","iseff" ]
      }), 
      params : {
			start : 0,
			limit : 20  
	  }
  });
  var assignRecord = Ext.data.Record.create(
		  [ // creates a subclass of Ext.data.Record
             {name: 'assignerId' },
             {name: 'assignerName' } 
 ]);
  var recIns;
 var panel = new Ext.Panel({ 
	   id:'searchPanel',
      height:300,
      autoScroll:true, 
      items: new Ext.DataView({
          tpl: resultTpl,
           store: ds,
          itemSelector: 'div.search-item',
          listeners: {
       	   "dblclick": function( d, i, n, e ){ 
    	  	    recIns = new assignRecord({
    	  		   assignerId:ds.getAt(i).get("id"),
    	  		   assignerName:ds.getAt(i).get("userName")
    	  	   });  
    	    	Ext.getCmp("search").setValue(recIns.get('assignerName'));  
              }
      		}
      }),

      tbar: [
          '搜索: ', ' ',
          new Ext.ux.form.SearchField({
       	      id:'search',
              store: ds,
              width:320,
              onTrigger2Click : function(){ 
              ds.load({params:{start:0, limit:10, _QUERY_s_rlike_user_name:Ext.getCmp("search").getValue()}}); 
              this.hasSearch = true;
              this.triggers[0].show();
          }
          })
      ],

      bbar: new Ext.PagingToolbar({
          store: ds,
          pageSize: 10,
          displayInfo: true,
          displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
  		  emptyMsg : "没有记录"
      })
  }); 
 
  ds.load({params:{start:0, limit:10, _QUERY_s_rlike_user_name:Ext.getCmp("search").getValue()}}); 

	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '任务执行者',
        width: 500,
        height:350,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ panel  ],
			buttons : [ {
				text : "确定",
				iconCls : "btn_save",
				handler : function() {   
					  if(_lastAssingerId!=null && _lastAssingerId==recIns.get('assignerId')){
						  Common.ErrMegBox('不能再次选择不通过审批的授课老师！'); 
						  return;
					  }
					  $('#'+_assingerId).val(recIns.get('assignerId')); 
					  $('#'+_assingerName).val(recIns.get('assignerName'));
					  win.close();
					}
				}
			 , { 
				text : "取消",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
	}); 
	win.show();
}; 

Teacher.translate = function( teacherId) {
	var url = "Busi_Teacher_query.action?condition=id="+teacherId; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) { 
		 	 if(data.result && data.result.length==1)
		 		 retStr =data.result[0].userName;
	 }); 
	return   retStr ;
};

Teacher.mutipleId = function( teacherName) {  
	if(teacherName =='' || teacherName==null)
		return ''; 
	var sql ="user_name like '"+teacherName+"%'"; 
	var url = "Busi_Teacher_query.action?condition="+sql;  
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
 