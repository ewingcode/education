Ext.ns("Student");

Student.selectWin = function(callbackFn) {
	var sexTypeStore = new SysParam.store("SEXTYPE"); 
	var gradeStore = new SysParam.store("GRADE");
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "学生名称",
			dataIndex : "name",
		}, {
			header : "年龄",
			dataIndex : "age",
		}, {
			header : "学生年级",
			dataIndex : "grade",
			renderer : function(value) {
				return SysParam.translate(gradeStore, value);
			}
		}, {
			header : "学生性别",
			dataIndex : "sex",
			renderer : function(value) {
				return SysParam.translate(sexTypeStore, value);
			} 
		},{
			header : "区域",
			dataIndex : "areaId",
			renderer : function(value) {
				return SysArea.translate(value);
			}
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
			url : 'Busi_Student_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "name", "age", "grade", "addr", "sex", "school", "phone","areaId",
					"homephone", {
						name : "createTime",
						type : "date",
						mapping : 'createTime.time',
						dateFormat : 'time'
					}, {
						name : "lastUpdate",
						type : "date",
						mapping : 'createTime.time',
						dateFormat : 'time'
					} ]
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
		loadMask : true,
		cm : cm,
		sm : sm,
		height : 450,
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
		store.setBaseParam('_QUERY_s_like_name', Ext.getCmp(
				"QUERY_student_name").getValue());
		store.load();
	}

	var formpanel = new Ext.FormPanel({
		labelAlign : 'left',// 字样显示在顶部
		bodyStyle : 'padding:5px',
		plain : true,
		height : 100,
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
					id : "QUERY_student_name",
					fieldLabel : "学生名称"
				} ]
			} ]
		} ]
	});

	var win = new Ext.Window({
		id : "selectStudentWin",
		title : '学生信息',
		width : 650,
		height : 500,
		minWidth : 500,
		minHeight : 300,
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ formpanel, gridPanel ],
		buttons : [ {
			text : "选择学生",
			iconCls : "btn_accept",
			handler : function() {
				if (gridPanel.getSelectionModel().getCount() != 1) {
					Common.ErrMegBox('请选择一项进行操作');
					return;
				}
				gridPanel.getSelectionModel().each(function(e) {
					var studentId = e.data.id;
					var studentName = e.data.name;
					callbackFn(studentId, studentName);
					win.close();
				});
			}
		}, {
			text : "关闭",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	loadGirdStore();
	win.show();
};
Student.choose = function(allowBlank, studentIdField, studentNameField) {
	var _studentIdField = studentIdField == null ? "studentId" : studentIdField;
	var _studentNameField = studentNameField = null ? "studentName"
			: studentNameField;
	var _allowBlank = allowBlank != null && allowBlank ? true : false;
	var field = {
		xtype : 'compositefield',
		id : "assignerComp",
		fieldLabel : '学生',
		width : "300",
		items : [ {
			xtype : "textfield",
			id : _studentIdField,
			hidden : true
		}, {
			xtype : "textfield",
			id : _studentNameField,
			readOnly : true,
			allowBlank : _allowBlank
		}, {
			xtype : "button",
			id : "choseStudentBtn",
			text : "选择",
			width : "150",
			listeners : {
				"click" : function(d, i, n, e) {
					new Student.selectWin(function(studentId, studentName) {
						Ext.getCmp(_studentIdField).setValue(studentId);
						Ext.getCmp(_studentNameField).setValue(studentName);
					});
				}
			}
		} ]
	};
	return field;
};
Student.assingerWindow = function(studentIdField, studentNameField) {
	// Custom rendering Template for the View
	var resultTpl = new Ext.XTemplate('<tpl for=".">',
			'<div class="search-item">',
			'<p style="CURSOR: pointer">{name}</p>', '</div></tpl>');
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_Student_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "name" ]
		}),
		params : {
			start : 0,
			limit : 20
		}
	});
	var assignRecord = Ext.data.Record.create([ // creates a subclass of
	// Ext.data.Record
	{
		name : 'assignerId'
	}, {
		name : 'assignerName'
	} ]);
	var recIns;
	var panel = new Ext.Panel({
		id : 'searchPanel',
		height : 300,
		autoScroll : true,
		items : new Ext.DataView({
			tpl : resultTpl,
			store : ds,
			itemSelector : 'div.search-item',
			listeners : {
				"dblclick" : function(d, i, n, e) {
					recIns = new assignRecord({
						assignerId : ds.getAt(i).get("id"),
						assignerName : ds.getAt(i).get("name")
					});
					Ext.getCmp("search").setValue(recIns.get('assignerName'));
				}
			}
		}),

		tbar : [
				'搜索: ',
				' ',
				new Ext.ux.form.SearchField({
					id : 'search',
					store : ds,
					width : 320,
					onTrigger2Click : function() {
						ds.load({
							params : {
								start : 0,
								limit : 10,
								_QUERY_s_rlike_user_name : Ext.getCmp("search")
										.getValue()
							}
						});
						this.hasSearch = true;
						this.triggers[0].show();
					}
				}) ],

		bbar : new Ext.PagingToolbar({
			store : ds,
			pageSize : 10,
			displayInfo : true,
			displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
			emptyMsg : "没有记录"
		})
	});

	ds.load({
		params : {
			start : 0,
			limit : 10,
			_QUERY_s_rlike_user_name : Ext.getCmp("search").getValue()
		}
	});

	var win = new Ext.Window({
		id : "userEditForm",
		title : '学生信息',
		width : 500,
		height : 350,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		// plain:true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ panel ],
		buttons : [
				{
					text : "确定",
					iconCls : "btn_save",
					handler : function() {
						Ext.getCmp(studentIdField).setValue(
								recIns.get('assignerId'));
						Ext.getCmp(studentNameField).setValue(
								recIns.get('assignerName'));
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

Student.translate = function(studentId) {
	var url = "Busi_Student_query.action?condition=id=" + studentId;
	var retStr = "";
	Ajax.syncRequest(url, function(data) {
		if (data.result && data.result.length == 1)
			retStr = data.result[0].name;
	});
	return retStr;
};

Student.mutipleId = function(studentName) {
	if (studentName == '' || studentName == null)
		return '';
	var sql = "name like '" + studentName + "%'";
	var url = "Busi_Student_query.action?condition=" + sql;
	var retStr = "";
	Ajax.syncRequest(url, function(data) {
		for (var i = 0; i < data.result.length; i++) {
			retStr += data.result[i].id;
			if (i < data.result.length - 1)
				retStr += ",";
		}
	});
	if (retStr == '')
		return 0;
	return retStr;
};
