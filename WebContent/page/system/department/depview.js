
Ext.onReady(function() {    
	loadGirdStore();
	Frame.busiPage(formpanel,gridPanel);
	 
});

 
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
							header : "部门名称",
							dataIndex : "name"
						},
						{
							header : "部门描述",
							dataIndex : "des"
						} 
						,
					    {
							header : "操作",
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
			                        new EditWindow(rec.get('id'));
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
				url : "Public_SysDepartment_delete.action",
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
				}, 
				failure : function() {
					 Ext.MessageBox.show( {
						title : "操作信息",
						msg : "信息保存出错，请联系管理员！",
						buttons : Ext.MessageBox.OK,
						icon : "ext-mb-error"
					}); 
				}
			});
		}
	});
};

var store = new Ext.data.Store( {
	// autoLoad : true,//是否自动加载
	proxy : new Ext.data.HttpProxy( {
		url : 'Public_SysDepartment_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"name", "des", "iseff" ]
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
		}, {
			iconCls : "btn_add",
			text : "新建",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
				new EditWindow(); 
			}
		},{
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
	id : "depGrid",
	tbar : toolbar,
	store : store, 
	trackMouseOver : true,
	// disableSelection: false,
	loadMask : true,
	region : "center",
	cm : cm,
	sm : sm,
	height:550,
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
						fieldLabel : "部门名称" 
					} ]
				  }]
	    }]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new EditWindow(e.data.id); 
	});
	});  
