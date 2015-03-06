<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>  
<%@ include file="/common/include/html_head.jsp"%>
<script>


Ext.onReady(function() {    
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
							header : "用户名称",
							dataIndex : "userId",
							renderer : function(value) {
								return SysUser.translate(value);
							}
						},
						{
							header : "模块名称",
							dataIndex : "moduleName"
						} 
						,
						{
							header : "创建时间",
							dataIndex : "loginTime",
							width:120,
							renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
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
		url : 'Public_SysLogTrace_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"userId", "moduleName",  {
			name : "loginTime",
			type : "date",
			mapping : 'loginTime.time',
			dateFormat : 'time'
		} ]
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
	var userIds = SysUser.mutipleId($("#QUERY_name").val()); 
	store.setBaseParam('start',0); 
	store.setBaseParam('limit',20); 
	store.setBaseParam('_QUERY_n_in_user_id',userIds); 
	store.setBaseParam('_QUERY_s_rlike_module_name',Ext.getCmp('QUERY_moduleName').getValue()); 
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
						fieldLabel : "用户名称" 
					} ]
				  },{
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
								id:"QUERY_moduleName", 
								fieldLabel : "模块名称" 
							} ]
						  }]
	    }]
	}); 
  
 


</script>
<%@ include file="/common/include/html_bottom.jsp"%>