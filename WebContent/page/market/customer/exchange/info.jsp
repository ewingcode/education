<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<c:set var="_jsFiles"
	value="${_cp}/page/market/customer/exchange/edit.js" />
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
	var studentId;
	var yesornoStore;
	var ds;
	var customerId;
	var isOnlyQuery;
	var isSingleCustomer = false;
	Ext.onReady(function() {
		customerId = jQuery.url.param("customerId");
		if(customerId!=null)
			isSingleCustomer = true;
		isOnlyQuery =  jQuery.url.param("isOnlyQuery");
		var sexTypeStore = new SysParam.store("SEXTYPE");
		var iseffStore = new SysParam.store("ISEFF");
		var yesornoStore = new SysParam.store("YESORNO");
		var visitsourcetypeStore = new SysParam.store("VISIT_SOURCE_TYPE");
		var customerstatusStore = new SysParam.store("CUSTOMER_STATUS");
		var sm = new Ext.grid.CheckboxSelectionModel();
		var cm = new Ext.grid.ColumnModel( {
			columns : [ sm, new Ext.grid.RowNumberer(), {
				header : "id",
				dataIndex : "id",
				hidden : true
			}, {
				header : "客户",
				dataIndex : "customerId",
				renderer : function(value) {
					var a = Customer.translate(value);
					return a;
				}
			}, {
				header : "编辑人",
				dataIndex : "userId",
				renderer : function(value) {
					return SysUser.translate(value);
				}
			}, {
				header : "当前状态",
				dataIndex : "custStatus",
				renderer : function(value) {
					return SysParam.translate(customerstatusStore, value);
				}
			}, {
				header : "信息来源",
				dataIndex : "sourceType",
				renderer : function(value) {
					return SysParam.translate(visitsourcetypeStore, value);
				}
			}, {
				header : "是否预约",
				dataIndex : "isBook",
				renderer : function(value, metaData, record, rowIndex, colIndex, store) {
				  
					return SysParam.translate(yesornoStore, value);
				}
			}, {
				header : "预约时间",
				dataIndex : "bookTime",
				renderer :  function(value, metaData, record, rowIndex, colIndex, store) {
				    if(record.get("isBook")==1){
				    	//var  time =  Ext.util.Format.dateRenderer('Y-m-d H:i:s');
				    	var time =  new Date(value).format('Y-m-d H:i:s') 
				    	 
				    	return time;
				    }else{
				        return "没预约";
				    }
				}

			}, {
				header : "沟通内容",
				dataIndex : "content"
			}, {
				header : "创建时间",
				dataIndex : "createTime",
				renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
			}, {
				header : "更新时间",
				dataIndex : "lastUpdate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')

			}, {
				header : "操作",
				hidden:isOnlyQuery?true:false,
				xtype : 'actioncolumn',
				defaults : {
					width : 230
				},
				width : 50,
				items : [ {
					getClass : function(v, meta, rec) {
						return "btn_edit";
					},
					tooltip : '编辑',
					handler : function(grid, rowIndex, colIndex) {
						var rec = store.getAt(rowIndex);
						new EditWindow(rec.get('id'));
					}
				}, {
					getClass : function(v, meta, rec) {
						return "btn_remove";
					},
					tooltip : '删除',
					handler : function(grid, rowIndex, colIndex) {
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
						url : "Busi_CustomerExchange_delete.action",
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
			},{
				iconCls : "btn_reset",
				text : "重置",
				xtype : "button",
				 scale: 'medium',
				handler : function() {
				formpanel.form.reset();
				}
			}, {
				iconCls : 'btn_add',
				text : "新建沟通记录",
				xtype : "button",
				hidden : customerId != null ? false : true,
				scale : 'medium',
				handler : function() {
					new EditWindow(null, customerId);
				}
			} ]
		});
		var gridPanel = new Ext.grid.GridPanel( {
			id : "userGrid",
			tbar : toolbar,
			store : store,
			trackMouseOver : true,
			// disableSelection: false,
			loadMask : true,
			region : "center",
			autoExpandColumn : "school",
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
			var customerIds ; 
			if(isSingleCustomer)
				customerIds = customerId;
			else
				customerIds = Customer.mutipleId($("#QUERY_name").val());
			store.setBaseParam('start',0); 
			store.setBaseParam('limit',20);  
			store.setBaseParam('_QUERY_n_in_customer_id',customerIds) ;  
			store.setBaseParam('_QUERY_n_rlike_phone',Ext.getCmp('QUERY_phone').getValue()) ; 
			store.setBaseParam('_QUERY_n_rlike_addr',Ext.getCmp('QUERY_addr').getValue()) ; 
			store.setBaseParam('_QUERY_n_eq_is_book',Ext.getCmp('QUERY_isBook').getValue()) ; 
			store.setBaseParam('_QUERY_n_eq_source_type',Ext.getCmp('QUERY_sourceType').getValue()) ; 
			store.setBaseParam('_QUERY_n_eq_cust_status',Ext.getCmp('QUERY_custStatus').getValue()) ;  
			store.setBaseParam('_ORDERBY',"order by lastUpdate desc"); 
			store.reload();  
			 
		} ;
		if(!isOnlyQuery){
			gridPanel.addListener("rowdblclick", function(g, f, h) {
				g.getSelectionModel().each(function(e) {
					new EditWindow(e.data.id, customerId);
				});
			});
		}
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
							fieldLabel : "客户名称" ,
							hidden:isSingleCustomer
						}, { 
							id:"QUERY_phone", 
							fieldLabel : "电话"  
						} ,new SysParam.ComboBox('信息来源','QUERY_sourceType', 'VISIT_SOURCE_TYPE' )]
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
							},new SysParam.ComboBox('是否预约','QUERY_isBook', 'YESORNO' )
							,new SysParam.ComboBox('当前状态','QUERY_custStatus', 'CUSTOMER_STATUS' )
							 ] 
				} ]
		    }]
		}); 
		
		loadGirdStore();
		Frame.busiPage(formpanel, gridPanel);
	});
	
	
	var store = new Ext.data.Store( {
		// autoLoad : true,//是否自动加载
		proxy : new Ext.data.HttpProxy( {
			url : 'Busi_CustomerExchange_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader( {
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "userId", "customerId", "custStatus", "sourceType", "isBook",
					"userId", "content", "customerAttachId", "createTime",
					"lastUpdate", "bookTime", {
						name : "bookTime",
						type : "date",
						mapping : 'bookTime.time',
						dateFormat : 'time'
					}, {
						name : "createTime",
						type : "date",
						mapping : 'createTime.time',
						dateFormat : 'time'
					}, {
						name : "lastUpdate",
						type : "date",
						mapping : 'lastUpdate.time',
						dateFormat : 'time'
					} ]
		})
	});
 </script>


<%@ include file="/common/include/html_bottom.jsp"%>