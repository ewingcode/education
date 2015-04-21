var sexTypeStore = new SysParam.store("SEXTYPE");
var positionStore = new SysParam.store("POSITION");
var gradeStore = new SysParam.store("GRADE");
Ext.onReady(function() { 
	isOnlyQuery = jQuery.url.param("isOnlyQuery") == 'true' ? true : false; 
	   
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
							 
						},
					    {
							header : "操作",
							hidden : isOnlyQuery,
			                xtype: 'actioncolumn',
			                defaults: {width: 230},// 默认每个子item大小
			                width: 50,
			                items: [{
			                	getClass :function(v, meta, rec) {          
		                        	return "btn_edit";
		                        } ,	
			                    tooltip: '编辑',
			                    handler: function(grid, rowIndex, colIndex) {
			                        var rec = store.getAt(rowIndex); 
			                        new studentEditWindow(rec.get('id'),function(){loadGirdStore()},true);
			                    }
			                }, { 
			                	getClass :function(v, meta, rec) {         
			                        return "btn_remove";
			                    } ,
			                    tooltip: '删除',
			                    handler: function(grid, rowIndex, colIndex) {
			                        var rec = store.getAt(rowIndex); 
			                        removeData(rec.get('id')) 
			                    }
			                }]
			            } ],
				defaults : {
					sortable : true,
					menuDisabled : false,
					width : 100
				}
			});
var removeData = function(b) { 
	Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
		if (c == "yes") {
			Ext.Ajax.request( {
				url : "Busi_Student_delete.action",
				params : {
					id : b
				},
				method : "post",
				success : function() {
					Ext.Msg.show( {
						title : '编辑',
						msg : '成功删除记录',
						buttons : Ext.MessageBox.OK,
						icon : Ext.Msg.INFO
					});
					loadGirdStore();
				}
			});
		}
	});
};

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
			iconCls : "btn_detail", 
			text : "学生详细信息",
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
									var student = Student
											.translate( studentId); 
									new DetailWindow(studentId);  
								});
				
			}
		} ,{
			iconCls : "btn_reset",
			text : "重置",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
				formpanel.form.reset();
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
	autoExpandColumn:'col_age',
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
					} ]
				  }  ]
	    }]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new studentEditWindow(e.data.id,function(){loadGirdStore()},true); 
	});
	});  
	loadGirdStore();
	Frame.busiPage(formpanel,gridPanel);
});
