
Ext.onReady(function() {   
	loadGirdStore();
	 Frame.editPage( gridPanel);  
});
 
var noticerTypeStore =new SysParam.store("NOTICER_TYPE"); 
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
							header : "发送人",
							dataIndex : "senderId",
							renderer :  function(value) { 
							   return SysUser.translate(value); 
							}
								
						},
						/*{
							header : "接收者类型",
							dataIndex : "receiverType",
							renderer :  function(value) { 
								  return SysParam.translate(noticerTypeStore,value); 
								}
							
						},*/
						{
							header : "接收者",
							dataIndex : "receiverId" ,
							renderer :  function(value, cellmeta, record, rowIndex, columnIndex, store) { 
							       var rec = store.getAt(rowIndex); 
							       var receiverType=rec.get('receiverType');
							     //  if(receiverType=='0')
							    	   return SysUser.mutipleTranslate(value); 
//							       if(receiverType=='1')
//							    	   return SysRole.translate(value);
//							       if(receiverType=='2')
//							    	   return Department.translate(value);
								}
						},
						{
							header : "内容",
							dataIndex : "content"
								
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
			                xtype: 'actioncolumn',
			                defaults: {width: 230},// 默认每个子item大小
			                width: 50,
			                items: [{
			                	getClass :function(v, meta, rec) {          
	                        	return "btn_detail";
	                        } ,	
		                    tooltip: '编辑',
		                    handler: function(grid, rowIndex, colIndex) {
		                        var rec = store.getAt(rowIndex);  
		                        new EditWindow(rec.get('id'));
		                        
		                    }
		                } ]
			            } ],
				defaults : {
					sortable : true,
					menuDisabled : false,
					width : 100
				}
			});
 

var store = new Ext.data.Store( {
	
	// autoLoad : true,//是否自动加载
	proxy : new Ext.data.HttpProxy( {
		url : 'Busi_NoticeHis_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"senderId", "receiverType", "receiverId", "content",
		{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
		{name:"lastUpdate" , type : "date",mapping : 'createTime.time',dateFormat : 'time'}]
	})
}); 

var toolbar = new Ext.Toolbar( {
		id : "userTopBar",  
		items : [ {
			 iconCls : "btn_query",
			text : "查询",
			xtype : "button",
			 scale: 'medium',
			handler : function() {  
				 loadGirdStore(); 
			}
		} ]
	}); 
var gridPanel =  new Ext.grid.GridPanel( {
	id : "userGrid",
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
	store.setBaseParam('_QUERY_n_eq_sender_id',session_userId); 
	 store.setBaseParam('_ORDERBY',"order by id desc"); 
	store.load(); 
};

 
var formpanel =  new Ext.FormPanel( {
	    labelAlign: 'left',// 字样显示在顶部
	    bodyS: '查询条件',
        collapsible: true,
        autoHeight:true, 
        hidden:true,
		items : [ ]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new EditWindow(e.data.id); 
	});
	});  
