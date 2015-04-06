Ext.ns("OrderCourse");

OrderCourse.courseEditGrid = function() {
	var returnObj = {
		grid : '',
		getCourseList : function() {
			var records = store.getRange(0, store.getCount() - 1);
			var courseList = '';
			for (var i = 0; i < records.length; i++) {
				var courseType = records[i].get('courseType');
				var courseHour = records[i].get('courseHour');
				courseList += courseType + "_" + courseHour + ',';
			}
			return courseList;
		},
		getTotalCourseHour : function() {
			var records = store.getRange(0, store.getCount() - 1);
			var totalCourseHour = 0;
			for (var i = 0; i < records.length; i++) {
				var hour = records[i].get('courseHour');
				if (!isNaN(hour)) {
					totalCourseHour += parseInt(hour);
				}
			}
			return totalCourseHour;
		},
		isLegalHour : function() {
			var records = store.getRange(0, store.getCount() - 1);
			for (var i = 0; i < records.length; i++) {
				var hour = records[i].get('courseHour');
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

	var fm = Ext.form;

	var cm = new Ext.grid.ColumnModel({
		defaults : {
			sortable : true
		},
		columns : [
				{
					header : '科目',
					dataIndex : 'courseType',
					width : 220,
					editor : new SysParam.ComboBox('科目', 'courseType',
							'ORDER_COURSE', false, false, null, true)
				}, {
					header : '课时',
					dataIndex : 'courseHour',
					width : 130,
					editor : new fm.TextField({
						allowBlank : false
					})
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
						tooltip : '删除',
						handler : function(grid, rowIndex, colIndex) {
							store.removeAt(rowIndex);
						}
					} ]
				} ]
	});

	// create the Data Store
	var store = new Ext.data.Store({
		autoDestroy : true,
		url : 'plants.xml',
		reader : new Ext.data.XmlReader({
			record : 'plant',
			fields : [ {
				name : 'courseType',
				type : 'string'
			}, {
				name : 'courseHour',
				type : 'int'
			} ]
		}),
		sortInfo : {
			field : 'courseType',
			direction : 'ASC'
		}
	});

	// create the editor grid
	var grid = new Ext.grid.EditorGridPanel({
		store : store,
		cm : cm,
		width : 500,
		height : 300,
		clicksToEdit : 1,
		tbar : [ {
			text : '增加课程',
			iconCls : "btn_add",
			handler : function() {
				// access the Record constructor through the grid's store
				var Plant = grid.getStore().recordType;
				var p = new Plant({
					courseType : '',
					courseHour : ''
				});
				grid.stopEditing();
				store.insert(0, p);
				grid.startEditing(0, 0);
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
}