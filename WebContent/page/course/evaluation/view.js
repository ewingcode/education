
Ext.onReady(function() {  
	Frame.busiPage(formpanel,gridPanel); 
	 
});

var orderCourseStore = new SysParam.store("ORDER_COURSE");  
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
							header : "学生名称",
							dataIndex : "studentId",
							 renderer: function(value) { 
								return  Student.translate(value);    
							}
						},
						{
							header : "签单编号",
							dataIndex : "orderId"
						},  
						{
							header : "编辑者",
							dataIndex : "operator",
							renderer : function(value){
								return SysUser.translate(value);
							}
						} ,
						{
							header : "课程",
							dataIndex : "courseType",
							renderer : function(value){
								return SysParam.translate(orderCourseStore,value);
							}
						} ,
						{
							header : "授课老师",
							dataIndex : "chargerId",
							renderer : function(value) { 
							    return SysUser.translate(value);
							}
						} , 
						{
							header : "评价内容",
							dataIndex : "content"
						} , 
						{
							header : "附件",
							dataIndex : "orderAttachId",
							 renderer: function(value) {
				                   var attachData =  Order.getAttachData(value);
				                    if(attachData!=null)
				                 	return  '<a href=# onclick="Order.filePreview(\'' + attachData.path
										+ '\')">'+attachData.name+'</a>';
		                 	}
						} , 
						{
							header : "上课时间",
							dataIndex : "courseTime" ,
							renderer : Ext.util.Format.dateRenderer('Y-m-d')  
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
			                        new EditWindow(rec.get('id'),rec.get('orderAttachId'),rec.get('orderId'));
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
				url : "Busi_OrderCourseEvaluation_delete.action",
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
		url : 'Busi_OrderCourseEvaluation_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"orderId", "courseType", "chargerId","studentId","content","orderAttachId","operator",
		,
		{name:"courseTime" , type : "date",mapping : 'courseTime.time',dateFormat : 'time'},
		{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
		{name:"lastUpdate" , type : "date",mapping : 'lastUpdate.time',dateFormat : 'time'}]
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
	var studentIds = Student.mutipleId($("#QUERY_name").val());
	var operators = SysUser.mutipleId($("#QUERY_operator").val());
	store.setBaseParam('_QUERY_n_in_student_id',studentIds) ; 
	store.setBaseParam('_QUERY_n_in_operator',operators) ; 
	store.setBaseParam('_QUERY_n_eq_course_type',Ext.getCmp('QUERY_courseType')
			.getValue()) ;   
	store.setBaseParam('_QUERY_d_ge_course_time',Ext.getCmp('QUERY_course_startTime')
			.getValue()); 
	store.setBaseParam('_QUERY_d_le_course_time',Ext.getCmp('QUERY_course_endTime')
			.getValue());  
	store.setBaseParam('_ORDERBY',"order by create_time desc"); 
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
						fieldLabel : "学生名称" 
					} ,{  
						id:"QUERY_operator", 
						fieldLabel : "编辑者" 
					}]
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
							      new SysParam.ComboBox('课程','QUERY_courseType', 'ORDER_COURSE')
							      ,{
										xtype : 'compositefield',
										fieldLabel : '上课时间',
										msgTarget : 'side',
										anchor : '-20',
										defaults : {
											flex : 1
										},
										items : [ {
											id : "QUERY_course_startTime",
											xtype : "datefield",
											vtype : 'daterange',
											endDateField : 'QUERY_course_endTime'
										}, {
											id : "QUERY_course_endTime",
											xtype : "datefield",
											vtype : 'daterange',
											startDateField : 'QUERY_course_startTime'
										} ]
									}
							      ]
						}]
	    }]
	}); 
  
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {   
		new EditWindow(e.data.id,e.data.orderAttachId,e.data.orderId); 
	});
	});  
