Ext.onReady(function() {
	loadGirdStore();
	Frame.busiPage(formpanel, gridPanel);
});

var sexTypeStore = new SysParam.store("SEXTYPE");
var positionStore = new SysParam.store("POSITION");
var iseffStore = new SysParam.store("ISEFF");
var depStore = new Department.store();
var roleStore = new SysRole.store();
var sm = new Ext.grid.CheckboxSelectionModel();
var cm = new Ext.grid.ColumnModel({
	columns : [ sm, new Ext.grid.RowNumberer(), {
		header : "id",
		dataIndex : "id",
		hidden : true
	}, {
		header : "用户",
		dataIndex : "userName"
	}, {
		header : "角色",
		dataIndex : "roleId",
		renderer : function(value) {
			return SysRole.translate(value);
		}

	}, {
		header : "区域",
		dataIndex : "areaId",
		renderer : function(value) {
			return SysArea.translate(value);
		}
	}, {
		header : "部门",
		dataIndex : "depId",
		renderer : function(value) {
			return Department.translate(value);
		}

	}, {
		header : "性别",
		dataIndex : "sex",
		renderer : function(value) {
			return SysParam.translate(sexTypeStore, value);
		}

	}, {
		header : "电话",
		dataIndex : "phone"
	}, {
		header : "邮编",
		dataIndex : "zipcode"
	}, {
		header : "是否有效",
		dataIndex : "iseff",
		renderer : function(value) {
			return SysParam.translate(iseffStore, value);
		}
	}, {
		header : "操作",
		xtype : 'actioncolumn',
		defaults : {
			width : 230
		},// 默认每个子item大小
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
			Ext.Ajax.request({
				url : "Public_SysUser_delete.action",
				params : {
					id : b
				},
				method : "post",
				success : function() {
					Ext.Msg.show({
						title : '编辑',
						msg : '成功删除记录',
						buttons : Ext.MessageBox.OK,
						icon : Ext.Msg.INFO
					});
					loadGirdStore();
				},
				failure : function() {
					Ext.MessageBox.show({
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

var store = new Ext.data.Store({
	// autoLoad : true,//是否自动加载
	proxy : new Ext.data.HttpProxy({
		url : 'Public_SysUser_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader({
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ {
			name : "id",
			type : "int"
		}, "userName", "addr", "sex", "position", "depId", "phone", "zipcode",
				"iseff", 'roleId', 'areaId' ]
	})
});

var toolbar = new Ext.Toolbar({
	id : "userTopBar",
	items : [ {
		iconCls : "btn_query",
		text : "查询",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			loadGirdStore();
		}
	}, {
		iconCls : "btn_add",
		text : "新建",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			new EditWindow();
		}
	}, {
		iconCls : "btn_reset",
		text : "重置",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			formpanel.form.reset();
		}
	}, {
		iconCls : "btn_reset",
		text : "重置密码",
		xtype : "button",
		scale : 'medium',
		handler : function() {
			if (gridPanel.getSelectionModel().getCount() != 1) {
				Common.ErrMegBox('请选择一项进行操作');
				return;
			}
			gridPanel.getSelectionModel().each(function(e) {
				Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
					if (c == "yes") {
						Ext.Ajax.request({
							url : "Busi_SysUser_resetPwd.action",
							params : {
								userId : e.data.id
							},
							method : "post",
							success : function() {
								Ext.Msg.show({
									title : '编辑',
									msg : '成功删除记录',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								});
								loadGirdStore();
							},
							failure : function() {
								Ext.MessageBox.show({
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								});
							}
						});
					}
				});
			});
		}
	} ]
});
var gridPanel = new Ext.grid.GridPanel({
	id : "userGrid",
	tbar : toolbar,
	store : store,
	trackMouseOver : true,
	// disableSelection: false,
	loadMask : true,
	region : "center",
	cm : cm,
	sm : sm,
	height : 550,
	viewConfig : {
		forceFit : true,// 填满width.
		enableRowBody : true,
		showPreview : false
	},
	// paging bar on the bottom
	bbar : new Ext.PagingToolbar({
		pageSize : 20,
		store : store,
		displayInfo : true,
		displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
		emptyMsg : "没有记录"
	})
});

function loadGirdStore() {

	store.setBaseParam('start', 0);
	store.setBaseParam('limit', 20);
	store.setBaseParam('_QUERY_s_rlike_user_name', Ext
			.getCmp('QUERY_user_name').getValue());
	store.setBaseParam('_QUERY_n_rlike_phone', Ext.getCmp('QUERY_phone')
			.getValue());
	store.setBaseParam('_QUERY_n_rlike_addr', Ext.getCmp('QUERY_addr')
			.getValue());
	store.load();
};

var formpanel = new Ext.FormPanel({
	labelAlign : 'left',// 字样显示在顶部
	bodyStyle : 'padding:5px',
	plain : true,
	items : [ {
		xtype : 'fieldset',
		layout : "column",
		title : '查询条件',
		collapsible : true,
		autoHeight : true,
		items : [ {
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle : 'text-align:right;'
			},

			items : [ {
				id : "QUERY_user_name",
				fieldLabel : "用户名称"
			}, {
				id : "QUERY_phone",
				fieldLabel : "电话"
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "QUERY_addr",
				fieldLabel : "地址"
			} ]
		} ]
	} ]
});

gridPanel.addListener("rowdblclick", function(g, f, h) {
	g.getSelectionModel().each(function(e) {
		new EditWindow(e.data.id);
	});
});
