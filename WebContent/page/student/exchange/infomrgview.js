
Ext.onReady(function() {   
	loadGirdStore();
	mainFrame =Frame.busiPage2(formpanel,gridPanel);  
	 
});
var mainFrame;
function closeTabPanel(studentId){
	mainFrame.remove("busi_tab_student_"+studentId);
}
var sexTypeStore = new SysParam.store("SEXTYPE");
var positionStore = new SysParam.store("POSITION");
var gradeStore = new SysParam.store("GRADE");
var sm = new Ext.grid.CheckboxSelectionModel(); 
var cm = new Ext.grid.ColumnModel(
		{
			columns : [
					sm,
					new Ext.grid.RowNumberer(),
					{
						header : "id",
						dataIndex : "id",
						hidden : true
					},
					{
						header : "区域",
						dataIndex : "areaId", 
						renderer: function(value) { 
							return  SysArea.translate(value);    
						}
					},
					{
						header : "学生",
						dataIndex : "name"
					},
					{
						header : "性别",
						dataIndex : "sex",
						 renderer: function(value) { 
							return  SysParam.translate(sexTypeStore,value);    
						}
					},
					{
						id:'col_age',
						header : "年龄",
						dataIndex : "age"
					},
					{
						header : "年级",
						dataIndex : "grade", 
						 renderer: function(value) { 
							return  SysParam.translate(gradeStore,value);    
						}
					},
					{
						header : "学校",
						dataIndex : "school"  
					},
					{
						header : "联系电话",
						dataIndex : "phone"
					},
					 
					{
						header : "创建时间",
						dataIndex : "createTime" ,
						renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')  
					},
					{
						header : "更新时间",
						dataIndex : "lastUpdate" ,
						renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
						 
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
		url : 'Busi_Student_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"name","age","grade", "addr", "sex", "school", "phone","homephone","areaId",
		{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
		{name:"lastUpdate" , type : "date",mapping : 'createTime.time',dateFormat : 'time'} ]
	})
});

var toolbar = new Ext.Toolbar( {
		id : "topBar",  
		items : [ {
			 iconCls : "btn_query",
			text : "查询",
			xtype : "button",
			 scale: 'medium',
			handler : function() { 
				 loadGirdStore(); 
			}
		},{
			iconCls : "btn_reset",
			text : "重置",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
			formpanel.form.reset();
			}
		},{
			iconCls : "btn_communicate", 
			text : "记录沟通信息",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
				if (!Common.SingleCheck(gridPanel)) {
					return;
				}
				gridPanel
						.getSelectionModel()
						.each(
								function(e) {
									var studentId = e.data.id; 
			                        var student=Student.translate(studentId);
				                        showPage = _contextPath+"/page/student/exchange/exchangelist.jsp?studentId="+studentId;
	            					var tab_id="busi_tab_student_"+studentId; 
			            					mainFrame.add({  
				                    			title : '学生['+student+']',
				                    			id : tab_id,
				                    			autoWidth:true,
				                    			iconCls : 'tabs', 
				                    			closable : true,
				                    			html : '<iframe  src="'+showPage+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
				                    		}).show(); 
								});
				
			}
		} ]
	}); 
var gridPanel =  new Ext.grid.GridPanel( {
	id : "grid",
	tbar : toolbar,
	store : store, 
	trackMouseOver : true,
	// disableSelection: false,
	loadMask : true,
	region : "center",
	cm : cm,
	sm : sm,
	height:600,
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

function loadGirdStore(){ 
   store.setBaseParam('start',0); 
	store.setBaseParam('limit',20); 
	store.setBaseParam('_QUERY_s_rlike_name',Ext.getCmp('QUERY_name').getValue()); 
	store.setBaseParam('_ORDERBY',"order by id desc"); 
	store.reload();  
	  
};

 
var formpanel =  new Ext.FormPanel( {
	    labelAlign: 'left',// 字样显示在顶部
	    bodyStyle:'padding:5px', 
	    plain:true,
	    items:[ {
	        xtype:'fieldset',
	    	layout : "column", 
            title: '查询条件',
            collapsible: true,
            autoHeight:true, 
			items : [ {
				xtype : "container",
				columnWidth : 0.33,
				defaultType : "textfield",
				layout : "form",
				defaults : {
					anchor : "96%,96%",
					labelStyle: 'text-align:right;'
				}, 
					items : [
					 {  
						id:"QUERY_name", 
						fieldLabel : "学生" 
					}]
				  }  ]
	    }]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new studentEditWindow(e.data.id,null,false); 
	});
	});
	
