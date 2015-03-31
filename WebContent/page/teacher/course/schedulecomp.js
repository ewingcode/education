Ext.ns("Schedule");

Schedule.showCalender = function(teacherId, month) {
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
	 
	  store.reload({ params : { month : '2015-03', teacherId : '19' }
	  });
	 
	store.reload();
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
			height:100
		} ],
		defaults : {
			sortable : true,
			menuDisabled : false,
			width : 100, 
			align:"center"
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel({
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 800,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	var filePanelSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		// title : '资料',
		layout : "column",
		items : [ {
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
	return filePanelSet;
};