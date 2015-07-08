Ext.ns("Teacher");

Teacher.selectWin = function(parentSelectId, parentSelectUserName,areaId, successFn ) {

	var sexTypeStore = new SysParam.store("SEXTYPE"); 
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
				},{
					header : "区域",
					dataIndex : "areaId",
					renderer : function(value) {
						return SysArea.translate(value);
					}
				},
				{
					header : "科目",
					width : 120,
					dataIndex : "courseType",
					renderer : function(value) {
						if (value != null || value != "undefined") {
							var courses = new Array();
							courses = value.split(",");
							var coursetrans = "";
							for (var i = 0; i < courses.length; i++) {
								coursetrans += SysParam.translate(courseStore,
										courses[i]);
								if (i < courses.length - 1)
									coursetrans += ",";
							}
							return coursetrans;
						} else {
							return "";
						}
					}
				},
				{
					header : "教学年级",
					dataIndex : "gradeType",
					width : 120,
					renderer : function(value) {
						if (value != null || value != "undefined") {
							var grades = new Array();
							grades = value.split(",");
							var gradestrans = "";
							for (var i = 0; i < grades.length; i++) {
								gradestrans += SysParam.translate(gradeStore,
										grades[i]);
								if (i < grades.length - 1)
									gradestrans += ",";
							}
							return gradestrans;
						} else {
							return "";
						}
					}
				}, {
					header : "性别",
					dataIndex : "sex",
					width : 60,
					renderer : function(value) {
						return SysParam.translate(sexTypeStore, value);
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
			url : 'Busi_Teacher_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				mapping : 'id'
			}, {
				name : "userName",
				mapping : 'userName'
			}, {
				name : "addr",
				mapping : 'addr'
			}, {
				name : "sex",
				mapping : 'sex'
			}, {
				name : "phone",
				mapping : 'phone'
			}, {
				name : "iseff",
				mapping : 'iseff'
			}, {
				name : "zipcode",
				mapping : 'zipcode'
			}, {
				name : "email",
				mapping : 'email'
			}, {
				name : "roleId",
				mapping : 'roleId'
			}, {
				name : "courseType",
				mapping : 'courseType'
			}, {
				name : "gradeType",
				mapping : 'gradeType'
			},"areaId" ]
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
		 
		if(areaId)
			store.setBaseParam('_QUERY_n_eq_area_id', areaId);
		store.setBaseParam('_QUERY_s_rlike_user_name', Ext
				.getCmp('QUERY_user_name').getValue());
		store.setBaseParam('_QUERY_s_like_course_type', Ext
				.getCmp('QUERY_course_type').getValue());
		store.setBaseParam('_QUERY_s_like_grade_type', Ext
				.getCmp('QUERY_grade_type').getValue());
		store.setBaseParam('_QUERY_s_eq_teacher_type', Ext.getCmp(
				'QUERY_teacher_type').getValue());  
		store.load();
	}
	;

	var formpanel = new Ext.FormPanel({
		labelAlign : 'left',// 字样显示在顶部
		bodyStyle : 'padding:5px',
		plain : true,
		items : [  {
			xtype : 'fieldset',
			layout : "column",
			title : '查询条件',
			// collapsible: true,
			autoHeight : true,
			items : [ 
						{
							xtype : "container",
							columnWidth : 0.33,
							defaultType : "textfield",
							layout : "form",
							defaults : {
								anchor : "96%,96%",
								labelStyle : 'text-align:right;'
							},

							items : [
									{
										id : "QUERY_user_name",
										fieldLabel : "教师名称"
									},
									new SysParam.ComboBox('教师类型', 'QUERY_teacher_type',
											'TEACHER_TYPE') ]
						}, {
							xtype : "container",
							columnWidth : 0.33,
							defaultType : "textfield",
							layout : "form",
							defaults : {
								anchor : "96%,96%",
								labelStyle : 'text-align:right;'
							},
							items : [  
							          new SysParam.ComboBox('科目', 'QUERY_course_type', 'ORDER_COURSE'),
										new SysParam.ComboBox('教学年级', 'QUERY_grade_type',
										'GRADE') ]
						}  ]
		} ]
	});
	gridPanel.addListener("rowdblclick", function(g, f, h) {
		g.getSelectionModel().each(function(e) {
			if($.isFunction(successFn)){
				successFn(e.data.id,e.data.userName); 
			}else{
				$("#" + parentSelectId).val(e.data.id);
				$("#" + parentSelectUserName).val(e.data.userName);
			}
		});
	});

	var win = new Ext.Window({
		id : "editScheduleWin",
		title : '教师信息',
		width : 650,
		height : 500,
		minWidth : 500,
		minHeight : 300,
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ formpanel, gridPanel ],
		buttons : [ {
			text : "选择教师",
			iconCls : "btn_accept",
			handler : function() {
				if (gridPanel.getSelectionModel().getCount() != 1) {
					Common.ErrMegBox('请选择一项进行操作');
					return;
				}
				gridPanel.getSelectionModel().each(function(e) { 
					if($.isFunction(successFn)){ 
						successFn(e.data.id,e.data.userName); 
					}else{
						$("#" + parentSelectId).val(e.data.id);
						$("#" + parentSelectUserName).val(e.data.userName);
					}
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

Teacher.choose = function() {
	var field = {
		xtype : 'compositefield',
		id : "assignerComp",
		fieldLabel : '教师',
		width : "300",
		items : [ {
			xtype : "textfield",
			id : "teachId",
			hidden : true
		}, {
			xtype : "textfield",
			id : "assignerName",
			readOnly : true,
			disabled : true,
			width : "150"
		}, {
			xtype : "button",
			id : "choseAssigerBtn",
			text : "选择指派人",
			width : "150",
			readOnly : true,
			disabled : true,
			listeners : {
				"click" : function(d, i, n, e) {
					new Teacher.assingerWindow();

				}
			}
		} ]
	};
	return field;
};
Teacher.assingerWindow = function(assingerId, assingerName, lastAssingerIdValue) {
	var _assingerName = assingerName;
	var _assingerId = assingerId;
	var _lastAssingerId = lastAssingerIdValue;
	// Custom rendering Template for the View
	var resultTpl = new Ext.XTemplate('<tpl for=".">',
			'<div class="search-item">',
			'<p style="CURSOR: pointer">{userName}</p>', '</div></tpl>');
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_Teacher_pageQuery.action'
		}),
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "userName", "addr", "sex", "position", "depId", "phone",
					"zipcode", "iseff" ]
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
						assignerName : ds.getAt(i).get("userName")
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

	var win = new Ext.Window(
			{
				id : "userEditForm",
				title : '任务执行者',
				width : 500,
				height : 350,
				minWidth : 500,
				minHeight : 300,
				layout : 'fit',
				plain : true,
				bodyStyle : 'padding:5px;',
				buttonAlign : 'center',
				items : [ panel ],
				buttons : [
						{
							text : "确定",
							iconCls : "btn_save",
							handler : function() {
								if (_lastAssingerId != null
										&& _lastAssingerId == recIns
												.get('assignerId')) {
									Common.ErrMegBox('不能再次选择不通过审批的授课老师！');
									return;
								}
								$('#' + _assingerId).val(
										recIns.get('assignerId'));
								$('#' + _assingerName).val(
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

Teacher.translate = function(teacherId) {
	var url = "Busi_Teacher_query.action?condition=id=" + teacherId;
	var retStr = "";
	Ajax.syncRequest(url, function(data) {
		if (data.result && data.result.length == 1)
			retStr = data.result[0].userName;
	});
	return retStr;
};

Teacher.mutipleId = function(teacherName) {
	if (teacherName == '' || teacherName == null)
		return '';
	var sql = "user_name like '" + teacherName + "%'";
	var url = "Busi_Teacher_query.action?condition=" + sql;
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

/**
 * 选择教师关联的学生
 */
Teacher.selectRefStudent = function(teacherId,studentId, callbackFn) {
	var queryUrl = 'Busi_TeacherRefStudent_pageQuery.action';
	var sexTypeStore = new SysParam.store("SEXTYPE");
	var courseStore = new SysParam.store("ORDER_COURSE");
	var gradeStore = new SysParam.store("GRADE");
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = new Ext.grid.ColumnModel({
		columns : [ new Ext.grid.RowNumberer(), {
			header : "教师名称",
			dataIndex : "teacherId",
			renderer : function(value) {
				return Teacher.translate(value);
			}
		}, {
			header : "授课科目",
			dataIndex : "courseType",
			renderer : function(value) {
				return SysParam.translate(courseStore, value);
			}
		}, {
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
			url : queryUrl
		}),
		baseParams : {
			start : 0,
			limit : 20
		},
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "studentId", "teacherId", "courseType", "runStatus", "name",
					"sex", "grade", "age" ]
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
		if(studentId)
			store.setBaseParam('_QUERY_n_eq_student_id', studentId);
		store.setBaseParam('_QUERY_n_eq_teacher_id', teacherId);
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
		id : "editScheduleWin",
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
					var studentId = e.data.studentId;
					var studentName = e.data.name;
					var courseType = e.data.courseType;
					callbackFn(studentId, studentName,courseType);
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
}
