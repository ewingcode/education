var isLoginOper;
var queryUrl = 'Busi_TeacherRefStudent_pageQuery.action';
Ext.onReady(function() { 
	isLoginOper = jQuery.url.param("isLoginOper");   
	if(isLoginOper) { 
		store.setBaseParam('_QUERY_n_eq_teacher_id',session_userId) ; 
	} 
	Frame.busiPage(formpanel, gridPanel);
});
 
var sexTypeStore = new SysParam.store("SEXTYPE"); 
var courseStore = new SysParam.store("ORDER_COURSE");
var gradeStore = new SysParam.store("GRADE"); 
var sm = new Ext.grid.CheckboxSelectionModel();
var cm = new Ext.grid.ColumnModel( {
	columns : [ 
			new Ext.grid.RowNumberer(),
			 
			{
				header : "教师名称",
				dataIndex : "teacherId" ,
				renderer : function(value) { 
				    return Teacher.translate(value);  
				}	
			}  ,
			{
				header : "授课科目",
				dataIndex : "courseType",
				renderer : function(value) { 
				    return SysParam.translate(courseStore,value);  
				}
			}, 
			{
				header : "学生名称",
				dataIndex : "name" ,
			},
			{
				header :"年龄",
				dataIndex : "age" ,
			},
			{
				header : "学生年级",
				dataIndex : "grade",
				renderer : function(value) { 
				    return SysParam.translate(gradeStore,value);  
				}
			},
			{
				header : "学生性别",
				dataIndex : "sex",
				renderer : function(value) {
					return SysParam.translate(sexTypeStore, value);
				}

			}  ],
	defaults : {
		sortable : true,
		menuDisabled : false,
		width : 100
	}
}); 



var store = new Ext.data.Store( {
	// autoLoad : true,//是否自动加载 
	proxy : new Ext.data.HttpProxy( {
		url : queryUrl
	}),
	baseParams :{
		start : 0,
		limit : 20
	},
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ { name : "id", type : "int" }, "studentId", "teacherId", "courseType", "runStatus", "name", "sex",
				"grade", "age" ]
	})
});
 

var toolbar = new Ext.Toolbar( {
	id : "userTopBar",
	items : [ {
		iconCls : "btn_query",
		text : "查询",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			loadGirdStore();
		}
	}, {
		iconCls : "btn_reset",
		text : "重置",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			formpanel.form.reset();
		}
	} ]
});
var gridPanel = new Ext.grid.GridPanel( {
	id : "userGrid",
	tbar : toolbar,
	store : store,
	trackMouseOver : true,
	autoExpandColumn : true,
	// disableSelection: false,
	loadMask : true,
	region : "center",
	cm : cm,
	sm : sm,
	height : 550,
	viewConfig : {
		forceFit : true,// 填满width.
		enableRowBody : true,
		showPreview : false
	},
	// paging bar on the bottom
	bbar : new Ext.PagingToolbar( {
		pageSize : 20,
		store : store,
		displayInfo : true,
		displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
		emptyMsg : "没有记录"
	})
});

function loadGirdStore() {
	var studentIds = Student.mutipleId($("#QUERY_student_name").val());
	store.setBaseParam('_QUERY_n_in_student_id',studentIds) ;  
	if(!isLoginOper){
	var teacherIds = Teacher.mutipleId($("#QUERY_teacher_name").val());
	store.setBaseParam('_QUERY_n_in_teacher_id',teacherIds) ; 
	} 
	store .reload();
};

var formpanel = new Ext.FormPanel( {
	labelAlign : 'left',// 字样显示在顶部
	bodyStyle : 'padding:5px',
	plain : true,
	items : [ {
		xtype : 'fieldset',
		layout : "column",
		title : '查询条件',
		collapsible : true,
		autoHeight : true,
		items : [ {
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle : 'text-align:right;'
			},

			items : [ {
				id : "QUERY_student_name",
				fieldLabel : "学生名称"
			}   ]
		} ,{
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle : 'text-align:right;'
			},

			items : [ {
				id : "QUERY_teacher_name",
				fieldLabel : "教师名称"
			}  ]
		}]
	} ]
});

 
