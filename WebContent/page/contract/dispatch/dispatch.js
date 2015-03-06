
Ext.onReady(function() {  
	Ext.QuickTips.init();// 需要加载这个有提示功能
	 gridPanel.render("list_div");
	formpanel.render("search_div");  
	 
});

var sexTypeStore = new SysParam.store("SEXTYPE");
var positionStore = new SysParam.store("POSITION");
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
							header : "签单编号",
							dataIndex : "userName"
						},
						{
							header : "签单名称",
							dataIndex : "addr"
						},
						{
							header : "学生",
							dataIndex : "sex",
							 renderer: function(value) { 
								return  SysParam.translate(sexTypeStore,value);    
							}
							 
						}, 
						{
							header : "签单时间",
							dataIndex : "position",
							 renderer: function(value) { 
								return  SysParam.translate(positionStore,value);    
							}
						},
						{
							header : "签单状态",
							dataIndex : "position",
							 renderer: function(value) { 
								return  SysParam.translate(positionStore,value);    
							}
						},
					    {
							header : "转发",
			                xtype: 'actioncolumn',
			                defaults: {width: 230},// 默认每个子item大小
			                width: 50,
			                items: [{
			                	getClass :function(v, meta, rec) {          
		                        	return "btn_edit";
		                        } ,	
			                    tooltip: '转发',
			                    handler: function(grid, rowIndex, colIndex) {
			                        var rec = store.getAt(rowIndex); 
			                        new EditWindow(rec.get('id'));
			                    }
			                }, { 
			                	getClass :function(v, meta, rec) {         
			                        return "btn_remove";
			                    } ,
			                    tooltip: '查看',
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
				url : "public/SysUser_delete.action",
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
		url : 'public/SysUser_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader( {
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ 
		   { name : "id", type : "int" }, 
		"userName", "addr", "sex", "position", "phone", "zipcode" ]
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
			text : "转发",
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
	id : "userGrid",
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
	store.setBaseParam('_QUERY_s_rlike_user_name',Ext.getCmp('QUERY_user_name').getValue()); 
	store.setBaseParam('_QUERY_n_rlike_phone',Ext.getCmp('QUERY_phone').getValue()); 
	store.setBaseParam('_QUERY_n_rlike_addr',Ext.getCmp('QUERY_addr').getValue());
	store.setBaseParam('_QUERY_s_eq_position',Ext.getCmp('QUERY_position').getValue()); 
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
						id:"QUERY_user_name", 
						fieldLabel : "签单编号" 
					}, { 
						id:"QUERY_phone", 
						fieldLabel : "学生"  
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
						new SysParam.ComboBox('签单状态','QUERY_position', 'CONTRACT_STATUS' ),
						{ 
							id : "testTime",
							xtype:"datefield",
							fieldLabel : "签单时间"
						}  ] 
			} ]
	    }]
	}); 
  
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '用户编辑',
        width: 500,
        height:300,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform  ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() { 
				if(!editform.getForm().isValid())
					return;
				       editform.getForm().submit( {
							method : "post",
							waitMsg : "正在提交数据...",
							success : function(i, j) { 
								 Ext.Msg.show( {
									title : '编辑',
									msg : '编辑成功',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								}); 
								 
							    store.reload();
								win.close();
							},
							failure : function(i, j) {
								 Ext.MessageBox.show( {
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								}); 
								 
								win.close();
								 
							}
						});
					}
				}
			 , { 
				text : "取消",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
	}); 
	win.show();
}; 
EditWindow.prototype.editform = function() {
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="public/SysUser_update.action";
	}else{
		this.url="public/SysUser_save.action";
	}
	var editForm = new Ext.FormPanel( {
		url :   this.url,
		layout : "form",
		autoDestroy:true,
		id : "AppointmentForm",
		frame : false,
		border : false, 
		formId : "AppointmentFormId",
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		defaults : {
			anchor : "98%,100%"
		},
		reader : new Ext.data.JsonReader( {
			  successProperty : 'success',
				root : 'result'
			}, ['id','userName','addr', 'sex','position','phone','zipcode','iseff','password' ]),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} , {
			fieldLabel : "用户名称",
			allowBlank : false, 
			id : "userName"
		},
		new SysParam.ComboBox('性别','sex', 'SEXTYPE',true)
		, 
		 new SysParam.ComboBox('职位','position', 'POSITION' ,true)
		  ,
		{
			fieldLabel : "地址",
			allowBlank : false, 
			id : "addr"
		},
		{
			fieldLabel : "电话",
			allowBlank : false, 
			id : "phone"
		},
		{
			fieldLabel : "邮编",
			allowBlank : false, 
			id : "zipcode"
		},
		 new SysParam.ComboBox('是否有效','iseff', 'ISEFF' ,true)
		,{
			fieldLabel : "密码",
			allowBlank : false, 
			id : "password"
		}  ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "public/SysUser_query.action?condition=id="+this.primaryId,
					waitMsg : "正在载入数据...",
					success : function(d, e) {
					 
					},
					failure : function(b, c) { 
						Ext.MessageBox.show( {
							title : "编辑",
							msg : "载入失败！",
							buttons : Ext.MessageBox.OK,
							icon : "ext-mb-error"
						});
					}
				});
	}
	return editForm;
	}; 
	
	gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {  
		new EditWindow(e.data.id); 
	});
});  
