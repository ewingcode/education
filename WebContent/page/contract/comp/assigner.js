Ext.ns("Assigner");

Assigner.showAssinerField = function(isShow) {
	var isDisabled = isShow == 1 ? false : true;
	Ext.getCmp("assignerId").setValue("");
	Ext.getCmp("assignerName").setValue("");
	Ext.getCmp("assignerName").allowBlank = isDisabled;
	Ext.getCmp("assignerName").setDisabled(isDisabled);
	Ext.getCmp("choseAssigerBtn").setDisabled(isDisabled);

}

Assigner.assingerFiled = function(orderId) { 
	
	var orderRoleStore = Order.loadOrderRoleStore();
	var field = {
		xtype : 'compositefield',
		id : "assignerComp",
		fieldLabel : '下一个执行者',
		width : "300",
		items : [
				{
					xtype : "textfield",
					id : "assignerId",
					hidden : true
				},
				{
					xtype : "textfield",
					id : "assignerName",
					readOnly : true,
					disabled : true,
					width : "150"
				},
				{
					xtype : "button",
					id : "choseAssigerBtn",
					text : "选择指派人",
					width : "150",
					listeners : {
						"click" : function(d, i, n, e) {  
							var studentId = $("#studentId").val();
							var assigner = '';
							var roleId =''; 
							var areaId ='';
							if($("#transitionName").val()=='请选择')
								return;
							var url = "Busi_OrderView_getAssigner.action?orderId="
									+ orderId
									+ "&transitionName="
									+ $("#transitionName").val();  
							Ajax.syncRequest(url, function(data) {
								assigner = data.result;  
							    for(var i=0;i<orderRoleStore.getTotalCount();i++){
							    	var rec = orderRoleStore.getAt(i);
							    	
							    	if(rec.get("charger")==assigner){ 
							    		roleId = rec.get("roleId");
							    	} 
							    } 
							});  
							if(studentId){
								var queryStudentUrl = "Busi_Student_query.action?condition=id=" + studentId; 
								Ajax.syncRequest(queryStudentUrl, function(data) {
									if (data.result && data.result.length == 1)
										areaId = data.result[0].areaId;
								}); 
							}  
							if(orderId){ 
								var queryOrderUrl = "Busi_OrderInfo_query.action?condition=id=" + orderId; 
								Ajax.syncRequest(queryOrderUrl, function(data) {
									if (data.result && data.result.length == 1)
										areaId = data.result[0].areaId;
								}); 
							}  
							if (roleId != null && roleId != '')
								new SysRole.selectWin('assignerId',
										'assignerName', roleId , areaId);

						}
					}
				} ]
	};
	return field;
};
Assigner.assingerWindow = function(orderId) {
	var _orderId = orderId;
	// Custom rendering Template for the View
	var resultTpl = new Ext.XTemplate('<tpl for=".">',
			'<div class="search-item">',
			'<p style="CURSOR: pointer">{userName}</p>', '</div></tpl>');
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : 'Busi_OrderView_showAssigerList.action'
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
		})
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

		tbar : [ '搜索: ', ' ', new Ext.ux.form.SearchField({
			id : 'search',
			store : ds,
			width : 320,
			onTrigger2Click : function() {
				loadds(ds, orderId);
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

	loadds(ds, orderId);
	var win = new Ext.Window({
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
						Ext.getCmp("assignerId").setValue(
								recIns.get('assignerId'));
						Ext.getCmp("assignerName").setValue(
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

function loadds(ds, _orderId) {
	ds.load({
		params : {
			start : 0,
			limit : 10,
			transitionName : $("#transitionName").val(),
			orderId : _orderId,
			_QUERY_s_rlike_user_name : Ext.getCmp("search").getValue()
		}
	});

}
