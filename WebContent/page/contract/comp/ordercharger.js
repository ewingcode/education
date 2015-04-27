Ext.ns("OrderCharger");

var orderId;
OrderCharger.EditWindow = function(orderId) { 
	var editform = new OrderCharger.editform(orderId); 
	var win =   new Ext.Window( {
		id : "userEditForm",
	    title: '签单权限',
        width: 700,
        height:400,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform ],
			buttons : [ {
				text : "保存",
				iconCls : "btn_save",
				handler : function() { 
				if(!editform.getForm().isValid())
					return;
				       editform.getForm().submit( {
							method : "post",
							waitMsg : "正在提交数据...",
							success : function(i, j) { 
								 Ext.Msg.show( {
									title : '编辑',
									msg : '编辑成功',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								});  
								win.close();
							},
							failure : function(i, j) {
								 Ext.MessageBox.show( {
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								});  
								win.close();
								 
							}
						});
					}
				}
			 , { 
				text : "取消",
				iconCls : "btn_cancel",
				handler : function() {
					win.close();
				}
			} ]
	}); 
	win.show();
}; 

OrderCharger.editform = function(orderId){
	
	return new Ext.FormPanel( {
	layout : "form",
	autoDestroy : true,
	id : "contractEditForm",
	url :   "Busi_OrderControl_modifyOrderCharger.action",
	frame : false,
	border : false,
	fileUpload : true,
	autoScroll : true,
	bodyStyle : "padding:5px;",
	defaultType : "textfield",
	height : 600,
	width:500,
	buttonAlign : 'center',
	items : [ {
			id : "orderId", 
				hidden: true,
				value:orderId
			},	
	         new OrderCharger.roleManage(orderId,true)  ]
});
}
OrderCharger.translate = function( chargerType) {
	var url = "Busi_OrderRole_query.action?condition=charger="+chargerType;
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) {  
		 	 if(data.result && data.result.length==1){
		 		 retStr = SysRole.translate(data.result[0].roleId);  
		 	 }
	 }); 
	return   retStr ;
};

OrderCharger.translateToRoleId = function( chargerType) {
	var url = "Busi_OrderRole_query.action?condition=charger="+chargerType;
	var retStr="";
	 Ajax.syncRequest(url,  
			 function(data) {  
		 	 if(data.result && data.result.length==1){
		 		 retStr =  data.result[0].roleId ;  
		 	 }
	 }); 
	return   retStr ;
};
/**
 * 签单负责人
 * 
 * @param fieldName
 * @param type
 * @param orderId
 * @return
 */
OrderCharger.roleManage = function(orderId, needChoose) { 
	var _needChoose=needChoose!=null&&needChoose?needChoose:false; 
	var url = "Busi_OrderRelHis_query.action?condition=order_id="+orderId;
 
	var field = new Ext.form.FieldSet( {
		title : '签单负责人',
		layout : "column",
		items : [ 

		 ]
	});   
	 Ajax.syncRequest(url,  
			 function(data) {   
		 		 for(var i=0;i<data.result.length;i++){
		 		 
		 			var  chargerType=data.result[i].chargerType;
		 			var roleId = OrderCharger.translateToRoleId(chargerType);
		 			var chargerTypeStr =OrderCharger.translate(data.result[i].chargerType);
		 			var operator = data.result[i].operator;
		 			var operatorStr =SysUser.translate(data.result[i].operator);
		 			var _operator = "operator" + chargerType; 
		 			var _operatorStr = "operatorStr" + chargerType;
		 			var _choseBtn = "chargerChoseBtn_" + chargerType+"_"+roleId;  
		 			var _chargerTypeStr="chargerTypeStr"+chargerType;
		 			var _chargerType="chargerType"+chargerType; 
		 		    var _roleField="roleField"+chargerType;
					var _chargerFiled=	"chargerFiled"+chargerType;  
		 			var roleField = {
		 					xtype : 'compositefield',
		 					fieldLabel : '角色', 
		 					items : [  {
		 						xtype : 'textfield',
		 						id : _chargerTypeStr,
		 						width : 150,
		 						value : chargerTypeStr,
		 						readOnly : true
		 					},
		 					 {
		 						id : _chargerType,
		 						xtype:"textfield", 
		 						hidden: true,
		 						value:chargerType
		 					} ]
		 			};
		 			 
		 		 
		 			var chargerField = {
		 					xtype : 'compositefield',
		 					fieldLabel : '负责人', 
		 					items : [ 
							{ 
								xtype:"textfield",
								id : _operatorStr, 
								value:operatorStr
							},
							{ 
								xtype:"textfield",
								id : _operator, 
								hidden:true,
								value:operator
							} ,
		 					{
		 						id : _choseBtn, 
		 						hidden:!_needChoose,
		 						xtype : "button",
		 						text : "选择",
		 						width : 50 ,
		 						handler : function(button,event) { 
									var _i_type = button.getId().split("_")[1]; 
									var roleId = button.getId().split("_")[2]; 
									new SysRole.selectWin('operator'+_i_type,'operatorStr'+_i_type,roleId);
		 				      	/*	var _setFrame="setFrame"+_i_type; 
		 				      		new SysRoleTree.viewWin('true','operator'+_i_type,'operatorStr'+_i_type,roleId,_setFrame);*/
		 				       
		 						   	} 
		 					} ]
		 			};
		 			  
		 			field.add(
		 					{
		 						xtype : "container", 
			 					id:_roleField,
		 						columnWidth : 0.4,
		 						defaultType : "textfield",
		 						layout : "form",
		 						defaults : { 
		 							labelStyle : 'text-align:right;'
		 						},
		 						items : [ roleField ]
		 						} );
		 			 
		 		 	field.add(
		 					{
		 						xtype : "container",
		 						id:_chargerFiled,
		 						columnWidth : 0.6,
		 						defaultType : "textfield",
		 						layout : "form",
		 						defaults : { 
		 							labelStyle : 'text-align:right;'
		 						},
		 						items : [chargerField ]
		 					} );   
		 			 
	 		 	} 
	 		 }
	  ); 
	 
 
	return  field;
};