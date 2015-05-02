Ext.ns("SysRole");
/**
 * 系统用户
 */

SysRole.store=function(){ 
	var url = "Public_SysRole_queryByCache.action";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	           {name: 'paramName'},
	           {name: 'paramValue'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);
		 		 for(var i=0;i<data.result.length;i++){
		 			var paramValue =data.result[i].id;
		 			var paramName =data.result[i].name;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj);
	return arrayStore; 
};
SysRole.ComboBox = function( filedId, allowBlank) {
	var _allowBlank = true;
	if (allowBlank != null)
		_allowBlank = allowBlank;
	
	 var url = "Public_SysRole_queryByCache.action";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	          {name: 'paramName'},
	           {name: 'paramValue'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);
		 		 for(var i=0;i<data.result.length;i++){
		 			var paramValue =data.result[i].id;
		 			var paramName =data.result[i].name;
		 			arrayObj[i] = [paramName,paramValue]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj); 
	return new Ext.form.ComboBox(
			{
				id : filedId,
				hiddenName : filedId,
				triggerAction : "all",
				fieldLabel : "角色",
				editable : false,
				emptyText : '请选择',    
				lazyRender:true,
				mode: 'local', 
				region : "center",
				valueField : "paramValue",
				displayField : "paramName",
				allowBlank : _allowBlank,
				 store : arrayStore
				 
			});
};

SysRole.translate = function( roleId) {
	var url = "Public_SysRole_queryByCache.action?condition=id="+roleId; 
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) { 
		 	 if(data.result && data.result.length==1)
		 		 retStr =data.result[0].name;
	 }); 
	return   retStr ;
};



SysRole.selectWin = function(parentSelectId, parentSelectUserName, roleIds) {
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
			width : 100,
			dataIndex : "userName"
		}, {
			header : "性别",
			hidden : true,
			dataIndex : "sex",
			renderer : function(value) {
				return SysParam.translate(sexTypeStore, value);
			}

		}, {
			header : "角色",
			dataIndex : "roleId",
			renderer : function(value) {
				return SysRole.translate(value);
			}

		}, {
			header : "部门",
			dataIndex : "depId",
			renderer : function(value) {
				return Department.translate(value);
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
			url : 'Public_SysUser_pageQuery.action'
		}),
		baseParams : {
			start : 0,
			limit : 10
		},
		reader : new Ext.data.JsonReader({
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "userName", "addr", "sex", "position", "depId", "phone",
					"zipcode", "iseff", 'roleId',"areaId" ]
		})
	});

	var roleToolbar = new Ext.Toolbar({ 
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
		id : "roleWinGrid",
		tbar : roleToolbar,
		store : store,
		trackMouseOver : true,
		autoExpandColumn : true,
		loadMask : true,
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
		if (roleIds != '')
			store.setBaseParam('_QUERY_n_in_role_id', roleIds);
		store.setBaseParam('_QUERY_s_rlike_user_name', Ext.getCmp(
				'QUERY_user_name').getValue());
		store.reload();
	}
	;

	var formpanel = new Ext.FormPanel({
		labelAlign : 'left',// 字样显示在顶部
		bodyStyle : 'padding:5px',
		plain : true,
		items : [ {
			xtype : 'fieldset',
			layout : "column",
			title : '查询条件',
			// collapsible: true,
			autoHeight : true,
			items : [ {
				xtype : "container",
				columnWidth : 1,
				defaultType : "textfield",
				layout : "form",
				defaults : {
					anchor : "96%,96%",
					labelStyle : 'text-align:right;'
				},

				items : [ {
					id : "QUERY_user_name",
					fieldLabel : "用户名称"
				} ]
			} ]
		} ]
	});
	gridPanel.addListener("rowdblclick", function(g, f, h) {
		g.getSelectionModel().each(function(e) {
			$("#" + parentSelectId).val(e.data.id);
			$("#" + parentSelectUserName).val(e.data.userName);
		});
	});
	var win = new Ext.Window({
		id : "selectStudentWin",
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
					$("#" + parentSelectId).val(e.data.id);
					$("#" + parentSelectUserName).val(e.data.userName);
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
