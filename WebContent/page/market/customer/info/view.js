
Ext.onReady(function() {  
	loadGirdStore();
	 mainFrame = Frame.busiPage2(formpanel,gridPanel); 
});
function closeTabPanel(studentId){
	mainFrame.remove("busi_tab_student_"+studentId);
}
var mainFrame;
var sexTypeStore = new SysParam.store("SEXTYPE"); 
var iseffStore = new SysParam.store("ISEFF");
var studentTypeStore = new SysParam.store("STUDENT_TYPE"); 
var residentTypeStore = new SysParam.store("RESIDENT_TYPE"); 
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
							header : "学生名称",
							dataIndex : "name"
						},
						{
							header : "年龄",
							dataIndex : "age"
						},
						{
							header : "性别",
							dataIndex : "sex",
							 renderer: function(value) { 
								return  SysParam.translate(sexTypeStore,value);    
							}
							 
						},
						{
							header : "学生类型",
							dataIndex : "studentType",
							hidden:true,
							 renderer: function(value) { 
								return  SysParam.translate(studentTypeStore,value);    
							}
						},
						{
							header : "户口类型",
							dataIndex : "studentType",
							hidden:true,
							 renderer: function(value) { 
								return  SysParam.translate(residentTypeStore,value);    
							}
						},
						{
							header : "年龄",
							dataIndex : "age"
						},
						{
							header : "电话",
							dataIndex : "phone"
						}, 
						{
							header : "学校",
							dataIndex : "school"
						},
						{
							header : "班级",
							dataIndex : "classes"
						},
						{
							header : "家长",
							dataIndex : "parentName"
						},  
						{
							header : "是否有效",
							dataIndex : "iseff",
							 renderer: function(value) { 
								return  SysParam.translate(iseffStore,value);    
							}
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
			                width: 200,
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
			                } ]
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
				url : "Busi_Customer_delete.action",
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
		url : 'Busi_Customer_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, "email", 
		"school","name", "addr", "sex", "phone", "iseff","classes","age","parentName","studentType","residentType",
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
		}, {
			iconCls : "btn_add",
			text : "新建",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
				new EditWindow(); 
			}
		},{
			iconCls : "btn_communicate",
			text : "客户交流",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
				if(gridPanel.getSelectionModel().getCount()!=1){
					Common.ErrMegBox('请选择一项进行操作');
					return;
					}
			    gridPanel.getSelectionModel().each(function(e) {  
					 var customerId = e.data.id;
					 var customerName = e.data.name;
					 var tab_id="busi_tab_customer_"+customerId; 
					 var showPage = _contextPath+"/page/market/customer/exchange/info.jsp?customerId="+customerId;
					 
 					mainFrame.add({  
             			title : '客户['+customerName+']',
             			id : tab_id,
             			autoWidth:true,
             			iconCls : 'tabs', 
             			closable : true,
             			html : '<iframe  src="'+showPage+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
             		}).show(); 
				});  
			}
		},{
			iconCls : "btn_reset",
			text : "重置",
			xtype : "button",
			 scale: 'medium',
			handler : function() {
			formpanel.form.reset();
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
	autoExpandColumn:"school",
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
	store.setBaseParam('_QUERY_s_rlike_name',Ext.getCmp('QUERY_name').getValue()) ;  
	store.setBaseParam('_QUERY_n_rlike_phone',Ext.getCmp('QUERY_phone').getValue()) ; 
	store.setBaseParam('_QUERY_n_rlike_addr',Ext.getCmp('QUERY_addr').getValue()) ; 
	store.setBaseParam('_ORDERBY',"order by lastUpdate desc"); 
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
						fieldLabel : "客户名称" 
					}, { 
						id:"QUERY_phone", 
						fieldLabel : "电话"  
					} ]
				  },
				  {
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
							id:"QUERY_addr",
							fieldLabel : "地址" 
						} ] 
			} ]
	    }]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new EditWindow(e.data.id); 
	});
	});  
