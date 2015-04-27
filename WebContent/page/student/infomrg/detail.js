
var DetailWindow = function(b) {
   this.primaryId = b;
	 var editform = this.editform();
	var win =   new Ext.Window( {
		id : "studentEditForm",
	    title: '学生信息中心', 
        height:500,
        width:900, 
        layout: 'form', 
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [editform ],
			buttons : [ { 
				text : "关闭",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
	}); 
	win.show();
}; 
DetailWindow.prototype.editform = function() {  
	  var baseInfoUrl = _contextPath + "/page/student/detail/baseinfo.jsp?studentId="+ this.primaryId;
	  var orderInfoUrl = _contextPath + "/page/student/detail/orderinfo.jsp?studentId="+ this.primaryId;
	  var commuicateUrl = _contextPath + "/page/student/detail/commuicateinfo.jsp?studentId="+ this.primaryId;
	  var socreUrl = _contextPath + "/page/student/detail/scoreinfo.jsp?studentId="+ this.primaryId;
	  var scheduleUrl = _contextPath + "/page/student/detail/scheduleinfo.jsp?studentId="+ this.primaryId;
						 
	  var tabs = new Ext.TabPanel({  
	        activeTab: 0, 
	        height:450,  
	        border : false,
	        autoScroll:false,
	        defaults:{autoHeight: true},
	        items:[ 
	             {	title : '基本信息',  
					autoWidth : true,
					iconCls : 'tabs', 
					html : '<iframe  src="'+baseInfoUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="400"/>'
				}, 
	            {   title : '签单信息', 
					autoWidth : true,
					iconCls : 'tabs', 
					html : '<iframe src="'+orderInfoUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="400"/>'
				}, 
				{   title : '排课信息', 
					autoWidth : true,
					iconCls : 'tabs', 
					html : '<iframe  src="'+scheduleUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="400"/>'
				},
	            {   title : '交流沟通', 
					autoWidth : true,
					iconCls : 'tabs', 
					html : '<iframe  src="'+commuicateUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="400"/>'
				},
	            {   title : '各课成绩', 
					autoWidth : true,
					iconCls : 'tabs', 
					html : '<iframe  src="'+socreUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="400"/>'
				}
	        ]
	    });
	  return tabs;
}; 
	