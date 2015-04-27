Ext.ns("Order"); 
 
Order.showTrace = function(orderId) {
	var orderRoleStore = Order.loadOrderRoleStore();
	var store = new Ext.data.Store( {
		proxy : new Ext.data.HttpProxy( {
			url : 'Busi_OrderTrace_pageQuery.action'

		}),
		reader : new Ext.data.JsonReader( {
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "taskName", "roleId","userId","operator", "oper", {
				name : "createTime",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			}, {
				name : "lastUpdate",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			},"transition" ]
		})
	});
	store.reload( {
		params : {
			start : 0,
			limit : 20,
			_QUERY_n_eq_orderId : orderId,
			_ORDERBY:"order by create_time"
		}
	});
	var cm = new Ext.grid.ColumnModel( {
		columns : [
				new Ext.grid.RowNumberer(),
				{
					header : "id",
					dataIndex : "id",
					hidden : true
				},
				{
					header : "步骤",
					dataIndex : "taskName"
				}, {
					header : "指派角色",
					dataIndex : "roleId",
					renderer : function(value) {
						var roleId =''; 
					    for(var i=0;i<orderRoleStore.getTotalCount();i++){
					    	var rec = orderRoleStore.getAt(i);
					    	if(rec.get("charger")==value){
					    		roleId = rec.get("roleId")
					    	} 
					    } 
					    if(roleId!='')
						return SysRole.translate(roleId);
					}
				} ,
				{
					header : "指派用户",
					dataIndex : "userId",
					renderer : function(value) {
						if(value!='')
						return SysUser.translate(value);
					}
				}  
				, {
					header : "实际执行者",
					dataIndex : "operator",
					renderer : function(value) {
						return SysUser.translate(value);
					}
				} ,{
					header : "操作",
					dataIndex : "transition"  
				} 
					  ],
		defaults : {
			sortable : true,
			menuDisabled : false,
			width : 100
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel( {
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 200,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		},  
		bbar : new Ext.PagingToolbar( {
			pageSize : 20,
			store : store,
			displayInfo : true,
			displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
			emptyMsg : "没有记录"
		})
	});

	var filePanelSet = new Ext.form.FieldSet( {
		xtype : 'fieldset',
		title : '签单跟踪情况',
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

Order.loadOrderRoleStore =function(){
	var url = "Busi_OrderRole_query.action";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	           {name: 'charger'},
	           {name: 'roleId'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);
		 		 for(var i=0;i<data.result.length;i++){
		 			var charger =data.result[i].charger;
		 			var roleId =data.result[i].roleId;
		 			arrayObj[i] = [charger,roleId]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj);
	 return arrayStore;
 
}