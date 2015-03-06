<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
   
 
Ext.onReady(function() {  
   var orderId = jQuery.url.param("orderId"); 
    var isOnlyEdit = jQuery.url.param("isOnlyEdit"); 
   Order.initData();  
  var  editform = new Ext.FormPanel( { 
		layout : "form",
		autoDestroy:true, 
		id : "contractEditForm", 
		frame : false,
		border : false,  
		autoScroll:true,
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		height:770,
		buttonAlign:'center',  
		items:[ 
		{
			xtype : 'fieldset', 
			title : '',
			layout : "column", 
			items : [ 
				{
				xtype : "container",
				columnWidth : 1,
				defaultType : "textfield",
				layout : "form", 
				defaults : {
					anchor : "96%",
					labelStyle: 'text-align:right;'
				}, 
					items : [new Order.contractStatus(orderId)  ]
			}   
				]
		},    
		  new Order.courseList(orderId,false),
			new Order.fileUploadComp('初期辅导方案',"1",orderId,false,true),
			new Order.fileUploadComp('华实模拟协议',"2",orderId,false,true),
			new Order.fileUploadComp('华实全方位测评报告',"3",orderId,false,true),
			new Order.fileUploadComp('教学安排表',"4",orderId,false,true)
				],
		 buttons : [ {
					text : "保存",
					iconCls : "btn_save",
					hidden: isOnlyEdit,
					handler : function() { 
						if(isOnlyEdit!='true'){ 
						 	if(!Order.validateAttach(SUBMITTYPE_APPLY_FILE))
							 	return;
							var transitionName = $("#transitionName").val(); 
						     if(Order.existNotPassAttach()){ 
								if('不通过'!=transitionName){
									 Common.ErrMegBox('存在不通过的文档审批记录，签单处理应为不通过'); 
									 return;
								 }
							 }else{
							 	if('通过'!=transitionName){
									 Common.ErrMegBox('签单处理应为通过'); 
									 return;
								 }
							 }
						 }
						 Order.submitForm(jQuery.url.param("isOnlyEdit"),editform,orderId,SUBMITTYPE_APPLY_FILE,$("#assignerId").val(),''); 
						}
					}, 
					{
					   text : "关闭",
						iconCls : "btn_cancel",
						handler : function() { 
					       parent.window.closeTabPanel(orderId); 
						}
					}] 
  }); 
   if(isOnlyEdit!='true'){ 
 	 editform.add(new Order.transitionChoice(orderId));
 	 editform.add( new Assigner.assingerFiled(orderId)); 
  }
  Frame.editPage( editform );
});
 

</script>
  
 
<%@ include file="/common/include/html_bottom.jsp"%>