
Ext.onReady(function() {   
	mainFrame = Frame.busiPage2(formpanel,gridPanel);  
	 
});
function closeTabPanel(studentId){
	mainFrame.remove("busi_tab_student_"+studentId);
}
var mainFrame;
var sexTypeStore = new SysParam.store("SEXTYPE");
var positionStore = new SysParam.store("POSITION");
var yesornoStore = new SysParam.store("YESORNO");
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
							header : "年龄",
							dataIndex : "age"
						},
						{
							header : "年级",
							dataIndex : "grade"
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
							header : "家庭电话",
							dataIndex : "homephone"
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
		url : 'Busi_OrderExchange_findEditableStudents.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"name","age","grade", "addr", "sex", "school", "phone","homephone",
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
			text : "沟通交流",
			xtype : "button", 
			scale : 'medium',
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
				                        showPage = _contextPath+"/page/personal/exchange/edit.jsp?studentId="+studentId;
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
		}  ]
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
	height:400,
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
	store.load();  
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
  
	 
