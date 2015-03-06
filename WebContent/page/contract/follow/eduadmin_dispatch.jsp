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
		height:600,
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
			new Order.fileListComp(orderId,'1,2,3,4') 
				],
		 buttons : [ {
					text : "保存",
					iconCls : "btn_save", 
				    hidden: isOnlyEdit=='true'?true:false,
					handler : function() {  
					     Order.submitForm(jQuery.url.param("isOnlyEdit"),editform,orderId,SUBMITTYPE_NOTHING,$("#assignerId").val(),''); 
						}
					},
					{
					   text : "关闭",
						iconCls : "btn_cancel",
						handler : function() { 
					       parent.window.closeTabPanel(orderId); 
						}
					} ] 
  });  
    if(isOnlyEdit!='true'){ 
 	 editform.add(new Order.transitionChoice(orderId));
 	 editform.add( new Assigner.assingerFiled(orderId)); 
  }
  Frame.editPage( editform ); 
});
</script>
  
 
<%@ include file="/common/include/html_bottom.jsp"%>