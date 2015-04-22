Ext.ns("OrderCourse");

OrderCourse.courseEditGrid = function(orderId, needChooseCharger) {
	var isEdit = orderId != null ? true : false;
	var orderCourseStore = new SysParam.store("ORDER_COURSE");

	var returnObj = {
		grid : '',
		getCourseList : function() {
			var records = store.getRange(0, store.getCount() - 1);
			var courseList = '';
			for (var i = 0; i < records.length; i++) {
				var courseType = records[i].get('courseType');
				var courseHour = records[i].get('hour');
				var chargerId = records[i].get('chargerId');
				courseList += courseType + "_" + courseHour + '_'+chargerId+',';
			}
			return courseList;
		},
		getTotalCourseHour : function() {
			var records = store.getRange(0, store.getCount() - 1);
			var totalCourseHour = 0;
			for (var i = 0; i < records.length; i++) {
				var hour = records[i].get('hour');
				if (!isNaN(hour)) {
					totalCourseHour += parseInt(hour);
				}
			}
			return totalCourseHour;
		},
		isLegalHour : function() {
			var records = store.getRange(0, store.getCount() - 1);
			for (var i = 0; i < records.length; i++) {
				var hour = records[i].get('hour');
				if (isNaN(hour)) {
					return false;
				}
			}
			return true;
		},
		hasDuplicateCourseType : function() {
			var records = store.getRange(0, store.getCount() - 1);
			for (var i = 0; i < records.length; i++) {
				var courseType = records[i].get('courseType');
				for (var j = 0; j < records.length; j++) {
					if (i != j) {
						var courseType2 = records[j].get('courseType');
						if (courseType == courseType2)
							return true;
					}
				}
			}
			return false;
		},
		reset : function() {
			store.removeAll(false);
		},
		validate : function(totalOrderHour) {
			if (totalOrderHour == null || isNaN(totalOrderHour)) {
				Common.ErrMegBox('请正确填写签单课时总数！');
				return false;
			}
			if (this.getCourseList() == '') {
				Common.ErrMegBox('请编辑课程信息！');
				return false;
			}

			if (this.hasDuplicateCourseType()) {
				Common.ErrMegBox('请重新编辑，存有重复的科目！');
				return false;
			}

			if (!this.isLegalHour()) {
				Common.ErrMegBox('请重新编辑，请正确填写课时！');
				return false;
			}

			if (this.getTotalCourseHour() != totalOrderHour) {
				Common.ErrMegBox('请重新编辑，课程总课时和签单总数不相等！');
				return false;
			}

			return true;
		}
	}

	var cm = new Ext.grid.ColumnModel({
		defaults : {
			sortable : true
		},
		columns : [
				{
					header : "课程",
					dataIndex : "courseType",
					renderer : function(value) {
						return SysParam.translate(orderCourseStore, value);
					}
				},
				{
					header : '课时',
					dataIndex : 'hour',
					width : 130
				},
				{
					header : '已花课时',
					dataIndex : 'costHour',
					width : 130
				},
				{
					header : '排课课时',
					dataIndex : 'scheduleHour',
					width : 130
				},
				{
					header : "授课老师",
					dataIndex : "chargerId",
					renderer : function(value) {
						return SysUser.translate(value);
					}
				},
				{
					header : "操作",
					xtype : 'actioncolumn',
					defaults : {
						width : 230
					},// 默认每个子item大小
					width : 50,
					items : [
							{
								getClass : function(v, meta, rec) {
									return "btn_edit";
								},
								tooltip : '编辑',
								handler : function(grid, rowIndex, colIndex) {
									var rec = store.getAt(rowIndex); 
									new OrderCourse.editCourseWin(store, grid, needChooseCharger,rec.get('id'));
								}
							},
							{
								getClass : function(v, meta, rec) {
									if (rec.get("costHour") == 0
											&& rec.get("scheduleHour") == 0)
										return "btn_remove";
								},
								tooltip : '删除',
								handler : function(grid, rowIndex, colIndex) {
									store.removeAt(rowIndex);
								}
							} ]
				} ]
	});

	// create the Data Store
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_OrderCourse_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ 'courseType', 'id', 'chargerId', 'costHour', 'hour',
					'scheduleHour', 'status' ]
		}),
		sortInfo : {
			field : 'courseType',
			direction : 'ASC'
		}
	});

	function loadGirdStore() {
		store.setBaseParam('_QUERY_n_eq_order_id', orderId);
		store.reload();
	}
	if (isEdit)
		loadGirdStore();
	// create the editor grid
	var grid = new Ext.grid.EditorGridPanel({
		store : store,
		cm : cm,
		width : 800,
		height : 300,
		clicksToEdit : 1,
		tbar : [ {
			text : '增加课程',
			iconCls : "btn_add",
			handler : function() {
				new OrderCourse.editCourseWin(store, grid, needChooseCharger);
			}
		} ]
	});

	var field = new Ext.form.FieldSet({
		title : '课程选择',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				labelStyle : 'text-align:right;'
			},
			items : [ grid ]
		} ]

	});

	returnObj.grid = field;
	return returnObj;
};

OrderCourse.editCourseWin = function(store, grid, needChooseCharger,
		orderCourseId) {
	var editCourseForm = new Ext.FormPanel({ 
		layout : "form",
		autoDestroy : true,
		id : "RoleForm",
		frame : false,
		border : false,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		defaults : {
			anchor : "98%,100%"
		},
		reader : new Ext.data.JsonReader({
			successProperty : 'success',
			root : 'result'
		}, [  {name: 'editCourseType', mapping: 'courseType'},
		      {name: 'editCourseHour', mapping: 'hour'},
		      {name: 'editChargerId', mapping: 'chargerId'},
		      {name: 'editChargerName', mapping: 'chargerName'},
		      'courseType', 'id', 'chargerId', 'costHour', 'hour',
				'scheduleHour', 'status' ]),
		items : [
				new SysParam.ComboBox('科目', 'editCourseType', 'ORDER_COURSE',
						false, false),
				{
					id : "editCourseHour",
					fieldLabel : "课时"
				},
				{
					xtype : "container",
					columnWidth : 1,
					hidden : !needChooseCharger,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						anchor : "50%,50%",
						labelStyle : 'text-align:left;'
					},
					items : [ {
						xtype : 'compositefield',
						fieldLabel : '授课老师',
						msgTarget : 'side',
						anchor : '-20',
						defaults : {
							flex : 1
						},
						items : [
								{
									id : "editChargerId",
									xtype : "textfield",
									hidden : true,
								},
								{
									id : "editChargerName",
									xtype : "textfield",
									width : "80",
									readOnly : true
								},
								{
									xtype : "button",
									id : "choseAssigerBtn",
									text : "选择",
									width : "100",
									listeners : {
										"click" : function(d, i, n, e) {
											new Teacher.selectWin(
													"editChargerId",
													"editChargerName");
										}
									}
								} ]
					} ]
				} ]
	}); 
 
	if (orderCourseId != null ) {
	 
		editCourseForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_OrderCourse_findOrderCourse.action?orderCourseId="+orderCourseId,
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
	var win = new Ext.Window({
		id : "userEditForm",
		title : '科目编辑',
		width : 400,
		height : 200,
		layout : 'fit',
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ editCourseForm ],
		buttons : [ {
			text : "保存",
			iconCls : "btn_save",
			handler : function() {
				if (!editCourseForm.getForm().isValid())
					return;
				var Plant = grid.getStore().recordType;
				var p = new Plant({
					courseType : Ext.getCmp('editCourseType').getValue(),
					hour : Ext.getCmp('editCourseHour').getValue(),
					chargerName : Ext.getCmp('editChargerName').getValue(),
					chargerId : Ext.getCmp('editChargerId').getValue(),
					costHour : 0,
					scheduleHour : 0
				});
				grid.stopEditing();
				store.insert(0, p);
				grid.startEditing(0, 0);
				win.close();
			}
		}, {
			text : "取消",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	win.show();
};
