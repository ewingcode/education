Ext.onReady(function() {
	Frame.busiPage(formpanel, gridPanel);

});

var orderCourseStore = new SysParam.store("ORDER_COURSE");
var courseHourStatusStore = new SysParam.store("COURSE_HOUR_STATUS");

var sm = new Ext.grid.CheckboxSelectionModel();
var cm = new Ext.grid.ColumnModel({
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
				renderer : function(value) {
					return Student.translate(value);
				}
			},
			{
				header : "授课老师",
				dataIndex : "teacherId",
				renderer : function(value) {
					return SysUser.translate(value);
				}
			},
			{
				header : "签单编号",
				hidden : true,
				dataIndex : "orderId"
			},
			{
				header : "课程",
				dataIndex : "courseType",
				renderer : function(value) {
					return SysParam.translate(orderCourseStore, value);
				}
			},
			{
				header : "花费学时",
				dataIndex : "costHour"
			},
			{
				header : "状态",
				dataIndex : "status",
				renderer : function(value) {
					return SysParam.translate(courseHourStatusStore, value);
				}
			},
			{
				header : "上课时间",
				dataIndex : "teachTime",
				renderer : function(value, metaData, record, rowIndex,
						colIndex, store) {
					var time = new Date(value).format('Y-m-d');
					return time;
				}

			}, {
				header : "操作者",
				dataIndex : "operator",
				renderer : function(value) {
					return SysUser.translate(value);
				}

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
				xtype : 'actioncolumn',
				defaults : {
					width : 230
				},// 默认每个子item大小
				width : 50,
				items : [ {
					getClass : function(v, meta, rec) {
						return "btn_remove";
					},
					tooltip : '取消',
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
				url : "Busi_OrderCourseHour_rollbackCourseHour.action",
				params : {
					courseHourLogId : b
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
		url : 'Busi_OrderCourseHourLog_pageQuery.action'
	}),
	reader : new Ext.data.JsonReader({
		root : 'result',
		totalProperty : 'totalProperty',
		remoteSort : true,
		fields : [ {
			name : "id",
			type : "int"
		}, "orderId", "courseType", "operator", "studentId", "teacherId",
				"status", "costHour", {
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
var toolbar = new Ext.Toolbar({
	id : "topBar",
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
	} ]
});
var gridPanel = new Ext.grid.GridPanel({
	id : "depGrid",
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
	var studentIds = Student.mutipleId($("#QUERY_name").val());
	store.setBaseParam('_QUERY_n_in_student_id', studentIds);
	store.setBaseParam('_QUERY_d_ge_teach_time', Ext.getCmp(
			'QUERY_teach_startTime').getValue());
	store.setBaseParam('_QUERY_d_le_teach_time', Ext.getCmp(
			'QUERY_teach_endTime').getValue());
	store.setBaseParam('_ORDERBY', "order by create_time desc");
	store.reload();
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
				id : "QUERY_name",
				fieldLabel : "学生名称"
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
				xtype : 'compositefield',
				fieldLabel : '上课时间',
				msgTarget : 'side',
				anchor : '-20',
				defaults : {
					flex : 1
				},
				items : [ {
					id : "QUERY_teach_startTime",
					xtype : "datefield",
					vtype : 'daterange',
					endDateField : 'QUERY_teach_endTime'
				}, {
					id : "QUERY_teach_endTime",
					xtype : "datefield",
					vtype : 'daterange',
					startDateField : 'QUERY_teach_startTime'
				} ]
			} ]
		} ]
	} ]
});
