Ext.ns("Schedule");

/**
 * 签单信息
 * 
 * @param orderId
 * @return
 */
Schedule.settingPanel = function(teacherId) {

	var settingSet;

	settingSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : .5,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				width : 100,
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "studentId",
				fieldLabel : "学生"
			}, {
				id : "courseHour",
				fieldLabel : "课时",
				readOnly : true
			}, {
				id : "remainHour",
				fieldLabel : "剩余课时",
				readOnly : true
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.5,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				width : 100,
				labelStyle : 'text-align:right;'
			},
			items : [ {
				fieldLabel : "日期",
				allowBlank : false,
				id : "sceduleDate",
				xtype : "datefield",
				format : "Y-m-d"
			}, new CoursePeriod.ComboBox("coursePeriod") ]
		}, {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaultType : "textfield", 
			items : [ new Order.orderCourse() ]
		} ]
	});
	return settingSet;
};

Schedule.showCalender = function(teacherId, month) {
	var curDay = new Date();
	var curMonth = curDay.format("Y-m");
	var store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_CourseCalender_showMonthSchedule.action'

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
			} ]
		})
	});

	function loadStore() {
		var selectDay = Ext.getCmp('month').getValue();
		var month = selectDay.format("Y-m");
		store.reload({
			params : {
				month : month,
				teacherId : teacherId
			}
		});
	}

	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "id",
			dataIndex : "id",
			hidden : true
		}, {
			header : "星期日",
			dataIndex : "content1"
		}, {
			header : "星期一",
			dataIndex : "content2"
		}, {
			header : "星期二",
			dataIndex : "content3"
		}, {
			header : "星期三",
			dataIndex : "content4"
		}, {
			header : "星期四",
			dataIndex : "content5"
		}, {
			header : "星期五",
			dataIndex : "content6"
		}, {
			header : "星期六",
			dataIndex : "content7",
			height : 100
		} ],
		defaults : {
			width : 100,
			align : "center"
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 700,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	var filePanelSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 0.3,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				width : 150,
				labelStyle : 'text-align:right;'
			},
			items : [ {
				fieldLabel : "月份",
				allowBlank : false,
				id : "month",
				xtype : "datefield",
				format : "Y-m",
				value : curMonth
			} ]
		}, {
			xtype : "container",
			columnWidth : 0.3,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				width : 150,
				labelStyle : 'text-align:right;'
			},
			items : [ {
				xtype : "button",
				text : "查询",
				iconCls : "btn_query",
				handler : function() {
					loadStore();
				}
			} ]
		}, {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaults : {
				anchor : "100%",
				labelStyle : 'text-align:right;'
			},
			items : [ gridPanel ]
		} ]
	});
	loadStore();
	return filePanelSet;
};