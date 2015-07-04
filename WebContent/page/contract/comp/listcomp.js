Ext.ns("OrderList");
OrderList.loadGirdStore = function(dataStore) {
	dataStore.setBaseParam('start', 0);
	dataStore.setBaseParam('limit', 20);
	dataStore.setBaseParam('_QUERY_s_rlike_order_no', Ext.getCmp('QUERY_orderNo')
			.getValue());
	dataStore.setBaseParam('_QUERY_s_eq_iseff', new Constant.IsEff().EFFECTIVE);
	dataStore.setBaseParam('_QUERY_n_in_student_id', Student.mutipleId($(
			"#QUERY_name").val()));
	dataStore.setBaseParam('_QUERY_d_ge_create_time', Ext.getCmp(
			'QUERY_create_startTime').getValue());
	dataStore.setBaseParam('_QUERY_d_le_create_time', Ext.getCmp(
			'QUERY_create_endTime').getValue());
	dataStore.setBaseParam('_QUERY_s_eq_run_status', Ext.getCmp(
			'QUERY_runStatus').getValue());
	dataStore.setBaseParam('QUERY_isSchedule', Ext.getCmp(
	'QUERY_isSchedule').getValue());
	
	dataStore.setBaseParam('_ORDERBY', "order by id desc");
	datastore.load();
};

OrderList.Toolbar = function(formpanel, isEdit, isLast, isDetail,
		isPersonalProc, isModify, isModifyCharger, isDeleteOrder,isSchedule) {

	return new Ext.Toolbar(
			{
				id : "userTopBar",
				items : [
						{
							iconCls : "btn_query",
							text : "查询",
							xtype : "button",
							scale : 'medium',
							handler : function() {
								OrderList.loadGirdStore(store);

							}
						},
						{
							iconCls : "btn_reset",
							text : "重置",
							xtype : "button",
							scale : 'medium',
							handler : function() {
								formpanel.form.reset();
							}
						},
						{
							iconCls : "btn_edit",
							text : "流程处理",
							hidden : isEdit ? false : true,
							xtype : "button",
							scale : 'medium',
							handler : function() {
								if (!Common.SingleCheck(gridPanel)) {
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													var student = Student
															.translate(e.data.studentId);
													Ext.Ajax
															.request({
																url : 'Busi_OrderView_showTaskPage.action?orderId='
																		+ orderId,
																method : "post",
																success : function(
																		response) {
																	var rec = Ext.util.JSON
																			.decode(response.responseText);
																	var showPage = rec.page;
																	showPage = _contextPath
																			+ showPage
																			+ "?orderId="
																			+ orderId;
																	var tab_id = "busi_tab_order_"
																			+ orderId;
																	Frame
																			.addTab(
																					mainFrame,
																					'签单['
																							+ student
																							+ ']',
																					tab_id,
																					showPage);
																}
															});
												});
							}
						},
						{
							iconCls : "btn_setting",
							text : "续单",
							hidden : isLast ? false : true,
							xtype : "button",
							scale : 'medium',
							handler : function() {
								if (gridPanel.getSelectionModel().getCount() != 1) {
									Common.ErrMegBox('请选择一项进行操作');
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													var isLast = e.data.isLast;
													if (isLast == '1') {
														Common
																.ErrMegBox('该信息已经进行了续单操作！');
														return;
													}
													var student = Student
															.translate(e.data.studentId);
													var showPage = '/page/contract/last/last.jsp';
													showPage = _contextPath
															+ showPage
															+ "?orderId="
															+ orderId;
													var tab_id = "busi_tab_order_"
															+ orderId;

													mainFrame
															.add(
																	{
																		title : '签单['
																				+ student
																				+ ']',
																		id : tab_id,
																		autoWidth : true,
																		iconCls : 'tabs',
																		closable : true,
																		html : '<iframe  src="'
																				+ showPage
																				+ '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
																	}).show();
												});
							}
						},
						{
							iconCls : "btn_detail",
							text : "详细信息",
							xtype : "button",
							hidden : isDetail ? false : true,
							scale : 'medium',
							handler : function() {
								if (!Common.SingleCheck(gridPanel)) {
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													var student = Student
															.translate(e.data.studentId);
													var showPage = _contextPath
															+ "/page/contract/follow/order_detail.jsp?orderId="
															+ orderId
															+ "&isOnlyEdit=true";
													var tab_id = "busi_tab_order_"
															+ orderId;
													Frame.addTab(mainFrame,
															'签单[' + student
																	+ ']',
															tab_id, showPage);
												});
							}
						},
						{
							iconCls : "btn_edit",
							text : "排课",
							xtype : "button",
							hidden : isSchedule ? false : true,
							scale : 'medium',
							handler : function() {
								if (!Common.SingleCheck(gridPanel)) {
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var runStatus = e.data.runStatus;
													if (runStatus != '1') {
														Common
																.ErrMegBox('不能排课,签单状态可能为审批或者结束!');
														return;
													}
													var orderId = e.data.id;
													var student = Student
															.translate(e.data.studentId);
													var showPage = _contextPath
															+ "/page/contract/follow/order_detail.jsp?orderId="
															+ orderId
															+ "&isOnlyEdit=true&schedule=true";
													var tab_id = "busi_tab_order_"
															+ orderId;
													Frame.addTab(mainFrame,
															'签单[' + student
																	+ ']',
															tab_id, showPage);
												});
							}
						},
						{
							iconCls : "btn_edit",
							text : "任务处理",
							xtype : "button",
							hidden : isPersonalProc ? false : true,
							scale : 'medium',
							handler : function() {
								if (!Common.SingleCheck(gridPanel)) {
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													var student = Student
															.translate(e.data.studentId);
													var curOperator = e.data.curOperator;
													if (session_userId != curOperator) {
														Common
																.ErrMegBox('没权限编辑,你不是当前的签单负责人!');
														return;
													}
													if (e.data.runStatus != '0') {
														Common
																.ErrMegBox('没权限编辑,签单已经审批结束!');
														return;
													}
													Ext.Ajax
															.request({
																url : 'Busi_OrderView_showUserEditedTaskPage.action?orderId='
																		+ orderId
																		+ '&userId='
																		+ session_userId,
																method : "post",
																success : function(
																		response) {
																	var rec = Ext.util.JSON
																			.decode(response.responseText);
																	var showPage = _contextPath
																			+ rec.page
																			+ "?orderId="
																			+ orderId
																			+ "&isOnlyEdit=true";
																	var tab_id = "busi_tab_order_"
																			+ orderId;
																	Frame
																			.addTab(
																					mainFrame,
																					'签单['
																							+ student
																							+ ']',
																					tab_id,
																					showPage);
																}
															});
												});
							}
						},
						{
							iconCls : "btn_edit",
							text : "修改签单",
							hidden : isModify ? false : true,
							xtype : "button",
							scale : 'medium',
							handler : function() {
								if (gridPanel.getSelectionModel().getCount() != 1) {
									Common.ErrMegBox('请选择一项进行操作');
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													var student = Student
															.translate(e.data.studentId);
													var showPage = "/page/contract/follow/editorder.jsp?orderId="
															+ orderId
															+ "&isOnlyEdit=true";
													showPage = _contextPath
															+ showPage
															+ "?orderId="
															+ orderId;
													var tab_id = "busi_tab_order_"
															+ orderId;

													mainFrame
															.add(
																	{
																		title : '签单['
																				+ student
																				+ ']',
																		id : tab_id,
																		autoWidth : true,
																		iconCls : 'tabs',
																		closable : true,
																		html : '<iframe  src="'
																				+ showPage
																				+ '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
																	}).show();
												});
							}
						},
						{
							iconCls : "btn_edit",
							text : "修改负责人",
							hidden : isModifyCharger ? false : true,
							xtype : "button",
							scale : 'medium',
							handler : function() {
								if (gridPanel.getSelectionModel().getCount() != 1) {
									Common.ErrMegBox('请选择一项进行操作');
									return;
								}
								gridPanel.getSelectionModel().each(function(e) {
									var orderId = e.data.id;
									OrderCharger.EditWindow(orderId);
								});

							}
						},
						{
							iconCls : "btn_remove",
							text : "撤单",
							hidden : isDeleteOrder ? false : true,
							xtype : "button",
							scale : 'medium',
							handler : function() {
								if (gridPanel.getSelectionModel().getCount() != 1) {
									Common.ErrMegBox('请选择一项进行操作');
									return;
								}
								gridPanel
										.getSelectionModel()
										.each(
												function(e) {
													var orderId = e.data.id;
													Ext.Msg
															.confirm(
																	"信息确认",
																	"您确认要删除该记录吗？",
																	function(c) {
																		if (c == "yes") {
																			Ext.Ajax
																					.request({
																						url : 'Busi_OrderControl_cancelOrder.action?orderId='
																								+ orderId
																								+ '&userId='
																								+ session_userId,
																						method : "post",
																						success : function(
																								response) {
																							var rec = Ext.util.JSON
																									.decode(response.responseText);
																							Common
																									.SucMegBox(rec.retinfo);
																						}
																					});
																		}
																	});

												});
							}
						} ]
			});
};
OrderList.ColumnModel = function(selectModel, isShort) {
	var _isShort = isShort ==null || !isShort ? false:true; 
	return new Ext.grid.ColumnModel({
		columns : [
				selectModel,
				new Ext.grid.RowNumberer(),
				{
					header : "签单合同号", 
					dataIndex : "orderNo", 
				},  
				{
					header : "签单费用(元)",
					dataIndex : "fee",
					renderer : function(value) {
						return parseFloat(value)/100;
					}
				},
				{
					header : "学生",
					dataIndex : "studentId",
					hidden:_isShort,
					renderer : function(value) {
						return Student.translate(value);
					}
				},
				{
					header : "年级",
					dataIndex : "grade",
					hidden:_isShort,
					width : 100,
					renderer : function(value) {
						return SysParam.translate(gradeStore, value);
					}
				},
				{
					header : "课时",
					width : 50,
					dataIndex : "courseHour"

				},
				{
					header : "调整课时",
					width : 80,
					dataIndex : "adjustHour"

				},
				{
					header : "已排课时",
					width : 80,
					dataIndex : "scheduleHour"

				},
				{
					header : "已用课时",
					width : 80,
					dataIndex : "costCourseHour",
					renderer : function(value, metaData, record, rowIndex,
							colIndex, store) {
						if(record.get("costCourseHour")==0)
							return value;
						var remainHour = record.get("courseHour")
								- record.get("costCourseHour") - record.get("adjustHour");
						if (remainHour < 30) {
							return "<span style='color:red'>" + value
									+ "</span>";
						}
						return value;
					}
				},  {
					header : "授课状态",
					dataIndex : "runStatus",
					renderer : function(value) {
						return SysParam.translate(runStatusStore, value);
					}
				},{
					header : "排课状态",
					dataIndex : "scheduleHour",
					renderer : function(value, metaData, record, rowIndex,
							colIndex, store) {
						if(record.get("courseHour") - record.get("adjustHour") > record.get("scheduleHour")) 
							return "<span style='color:red'>未排课</span>";
						else
							return "已排课";
					}
				},{
					header : "审批状态",
					dataIndex : "status"
				}, {
					header : "当前负责人",
					dataIndex : "curOperator",
					renderer : function(value) {
						return SysUser.translate(value);
					}
				}/*, {
					header : "是否被续单",
					width : 80,
					dataIndex : "isLast",
					renderer : function(value) {
						return SysParam.translate(yesOrNoStore, value);
					}
				}*/, {
					header : "是否有效",
					dataIndex : "iseff",
					renderer : function(value) {
						return SysParam.translate(iseffStore, value);
					}
				}, {
					header : "创建时间",
					dataIndex : "createTime",
					width : 120,
					renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')
				}/*, {
					header : "更新时间",
					width : 120,
					dataIndex : "lastUpdate",
					renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')

				}*/ ],
		defaults : {
			sortable : true,
			menuDisabled : false,
			width : 100
		}
	});
};
OrderList.gridPanel = function(toolbar, columnModel, selectModel, dataStore) {
	return new Ext.grid.GridPanel({
		id : "contractListGird",
		tbar : toolbar,
		store : dataStore,
		layout : 'fit',
		trackMouseOver : true,
		height : 500,
		// disableSelection: false,
		loadMask : true,
		region : "center",
		cm : columnModel,
		sm : selectModel,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		},
		// paging bar on the bottom
		bbar : new Ext.PagingToolbar({
			pageSize : 10,
			store : dataStore,
			displayInfo : true,
			displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
			emptyMsg : "没有记录"

		})
	});
};

OrderList.store = function(queryUrl) {
	return new Ext.data.Store({
		// autoLoad : true,//是否自动加载
		proxy : new Ext.data.HttpProxy({
			url : queryUrl
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "studentId", "status","fee", "grade", "courseHour", "costCourseHour","adjustHour",
					"scheduleHour", {
						name : "startTime",
						type : "date",
						mapping : 'createTime.time',
						dateFormat : 'time'
					}, {
						name : "endTime",
						type : "date",
						mapping : 'endTime.time',
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
					}, "iseff", "des", "isLast", "curOperator",
					"costCourseHour", "runStatus","orderNo" ]
		})
	});
};

OrderList.formpanel = function(studentId) {
	var readOnlyStudent = studentId!=null?true:false;
	return new Ext.FormPanel(
			{
				labelAlign : 'left',// 字样显示在顶部
				bodyStyle : 'padding:5px',
				id : "contractSearchForm",
				name : "contractSearchForm",
				plain : true,
				items : [ {
					xtype : 'fieldset',
					layout : "column",
					title : '查询条件',
					// collapsible: true,
					autoHeight : true,
					items : [
							{
								xtype : "container",
								columnWidth : 0.5,
								defaultType : "textfield",
								layout : "form",
								defaults : {
									anchor : "50%,50%",
									labelStyle : 'text-align:right;'
								},
								items : [ {
									id : "QUERY_orderNo",
									fieldLabel : "签单合同号"
								},
								new SysParam.ComboBox('授课状态',
										'QUERY_runStatus',
										'ORDER_RUN_STATUS'),
								new SysParam.ComboBox('是否已排课',
												'QUERY_isSchedule',
												'YESORNO')]
							},
							{
								xtype : "container",
								columnWidth : 0.5,
								defaultType : "textfield",
								layout : "form",
								defaults : {
									anchor : "50%,50%",
									labelStyle : 'text-align:right;'
								},
								items : [

										{
											xtype : 'compositefield',
											fieldLabel : '签单开始时间',
											msgTarget : 'side',
											anchor : '-20',
											defaults : {
												flex : 1
											},
											items : [
													{
														id : "QUERY_create_startTime",
														xtype : "datefield",
														vtype : 'daterange',
														endDateField : 'QUERY_create_endTime'
													},
													{
														id : "QUERY_create_endTime",
														xtype : "datefield",
														vtype : 'daterange',
														startDateField : 'QUERY_create_startTime'
													} ]
										}, {
											id : "QUERY_name",
											fieldLabel : "学生名称",
											hidden: readOnlyStudent
										} ]
							} ]
				} ]
			});
}
