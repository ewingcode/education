
Ext.onReady(function() { 
	var isOnlyQuery = false;
	isOnlyQuery = jQuery.url.param("isOnlyQuery") == 'true' ? true : false;
	var sexTypeStore = new SysParam.store("SEXTYPE");
	var iseffStore = new SysParam.store("ISEFF");
	var courseStore = new SysParam.store("ORDER_COURSE");
	var gradeStore = new SysParam.store("GRADE");
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
					header : "教师名称",
					dataIndex : "userName"
				} ],
		defaults : {
			sortable : true,
			menuDisabled : false,
			width : 100
		}
	});

	 
	 

	var store = new Ext.data.Store({
		// autoLoad : true,//是否自动加载
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_CourseScheduleList_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				mapping : 'id'
			}, {
				name : "teacherId",
				mapping : 'teacherId'
			}, {
				name : "teacherName",
				mapping : 'teacherName'
			}, {
				name : "content1",
				mapping : 'contents[0]'
			}, {
				name : "content2",
				mapping : 'contents[1]'
			}, {
				name : "content3",
				mapping : 'contents[2]'
			}, {
				name : "content4",
				mapping : 'contents[3]'
			}, {
				name : "content5",
				mapping : 'contents[4]'
			}, {
				name : "content6",
				mapping : 'contents[5]'
			}, {
				name : "content7",
				mapping : 'contents[6]'
			}  ]
		})
	});

	function getDateList() {
		var startDate = Ext.getCmp('QUERY_schedule_startTime').getValue();
		var endDate = Ext.getCmp('QUERY_schedule_endTime').getValue();
		var nextDay = startDate;
		while (!nextDay.between(nextDay, endDate)) {
			nextDay = nextDay.add(Date.DAY, 1);
			nextDay.format('Ymd');
		}
	}

	function getDynamicColumn() {
		var columString = null;
		var startDate = Ext.getCmp('QUERY_schedule_startTime').getValue();
		var endDate = Ext.getCmp('QUERY_schedule_endTime').getValue();

		if (startDate == '' || endDate == '') {
			Common.ErrMegBox("排课时间不能为空！");
			return null;
		}
		var start = "new Ext.grid.ColumnModel( {" + "columns : [" + "sm,"
				+ "new Ext.grid.RowNumberer(),"
				+ "{header : \"id\",dataIndex : \"teacherId\",hidden : true}, "
				+ "{header : \"教师名称\",dataIndex : \"teacherName\"} ,";
		var date = "";
		var maxdayInterval = 7;
		var dayInterval = 0;
		while (startDate <= endDate) {
			dayInterval++;
			var weekName = DateUtil.getWeekName(startDate);
			var dateColumn = startDate.format('Ymd')+"<br>"+weekName;
			 
			date = date + "{header : '" + dateColumn
					+ "',dataIndex : 'content"+dayInterval+"'}";
			if (startDate < endDate)
				date = date + ",";
			startDate = startDate.add(Date.DAY, 1);
			
		}
		if (dayInterval > maxdayInterval) {
			Common.ErrMegBox("排课时间不能超过7日！");
			return null;
		}

		var end = "],defaults : {align:'center',width : 100}})";
		columString = start + date + end; 
		return columString;
	}
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
			text : "排课",
			xtype : "button",
			hidden : isOnlyQuery,
			scale : 'medium',
			handler : function() {  
				if(gridPanel.getSelectionModel().getCount()!=1){
					Common.ErrMegBox('请选择一项进行操作');
					return;
					}
			    gridPanel.getSelectionModel().each(function(e) {  
					 var teacherId = e.data.teacherId;
					 var teacherName = e.data.teacherName;  
					 var showPage = _contextPath
						+ "/page/teacher/course/schedule.jsp?teacherId="+teacherId ; 
				     var tab_id = "busi_tab_order_"
						+ orderId;
				     Frame.addTab(mainFrame, '排课['+teacherName+']', tab_id,  showPage);
				});  
				
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
		id : "userGrid",
		tbar : toolbar,
		store : store,
		trackMouseOver : true,
		autoExpandColumn : true,
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
			pageSize : 5,
			store : store,
			displayInfo : true,
			displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
			emptyMsg : "没有记录"
		})
	});

	function loadGirdStore() {
		var dynamicColumnStr = getDynamicColumn();
		if (dynamicColumnStr == null)
			return; 
		var item = eval(dynamicColumnStr);
		gridPanel.reconfigure(store, item); 
		store.setBaseParam('start', 0);
		store.setBaseParam('limit', 5);
		store.setBaseParam('_QUERY_s_rlike_user_name', Ext
				.getCmp('QUERY_user_name').getValue());
		store.setBaseParam('_QUERY_schedule_startTime',Ext.getCmp('QUERY_schedule_startTime').getValue());
		store.setBaseParam('_QUERY_schedule_endTime',Ext.getCmp('QUERY_schedule_endTime').getValue());
		store.setBaseParam('_QUERY_n_eq_area_id', Ext.getCmp('QUERY_areaId')
				.getValue());
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
					id : "QUERY_user_name",
					fieldLabel : "教师名称"
				}, {
					xtype : 'compositefield',
					fieldLabel : '排课时间',
					msgTarget : 'side',
					anchor : '-20',
					defaults : {
						flex : 1
					},
					items : [ {
						id : "QUERY_schedule_startTime",
						xtype : "datefield",
						vtype : 'daterange',
						endDateField : 'QUERY_schedule_endTime'
					}, {
						id : "QUERY_schedule_endTime",
						xtype : "datefield",
						vtype : 'daterange',
						startDateField : 'QUERY_schedule_startTime'
					} ]
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
				items : [ new SysArea.ComboBox('QUERY_areaId', false), ]
			} ]
		} ]
	});

	gridPanel.addListener("rowdblclick", function(g, f, h) {
		g.getSelectionModel().each(function(e) {
			new EditWindow(e.data.id, e.data.courseType, e.data.gradeType);
		});
	});

	mainFrame = Frame.busiPage2(formpanel, gridPanel); 
	var today =  new Date();
	var weekEndDay = today.add(Date.DAY, 6);  
	$("#QUERY_schedule_startTime").val(today.format("n/j/Y"));
	$("#QUERY_schedule_endTime").val(weekEndDay.format("n/j/Y"));
	loadGirdStore();
});
var mainFrame;
