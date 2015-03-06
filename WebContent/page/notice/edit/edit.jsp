<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%> 

<script> 
Ext.onReady(function() {  
   var queryType=0;
    var  editform = new Ext.FormPanel( { 
        url :   "Busi_NoticeHis_addNotice.action",
		layout : "form",   
		frame : true,
		border : true,  
		autoScroll:true,
		bodyStyle : "padding:5px;",
		defaultType : "textfield", 
		buttonAlign:'center',  
		defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
		items:[ 
		     { 
			    id:"receiverType",
                fieldLabel: '收件者', 
                hidden:true,
                value:0 
		     }
		/* 
			  new SysParam.ComboBox('接收者类型','receiverType', 'NOTICER_TYPE',false,false,function(c,r){
			 	  queryType = r.get("paramValue");
			 	   alert(queryType);
			  }) */
			  , 
			  {
			    xtype: 'compositefield',
			    id:"assignerComp",
                fieldLabel: '收件者', 
                width:"500", 
                items: [
					{ 
						xtype:"textfield",   
						id : "receiverIds",
						hidden:true 
					},
					{ 
						xtype:"textfield",  
						id : "receiverNames",
						readOnly : true,
						allowBlank : false,
						width:"400"
					} ,
                    { 
						xtype:"button",
						id:"choseAssigerBtn",
						text : "选择指派人",
						width:"150",  
						 listeners: {
				        	   "click": function( d, i, n, e ){ 
									 new SysOrg.viewWin('receiverIds','receiverNames',queryType); 
			                   }
				       		}
					} 
                ]
			}, 
			  
		     { 
				id : "content",
				xtype:"textarea",
				fieldLabel : "消息内容",
				allowBlank : false 
			 }],
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
								 Common.SucMegBox("成功发送公告！"); 
								  editform.form.reset();
							},
							failure : function(i, j) {
								Common.ErrMegBox( "信息保存出错，请联系管理员！"); 
							}
						});
						}
					},
					{
					   text : "重置",
						iconCls : "btn_reset",
						handler : function() { 
						  editform.form.reset();
						}
					}] 
  });  
  Frame.editPage( editform ); 
});
 </script>

<div id="detailForm">
</div>

<%@ include file="/common/include/html_bottom.jsp"%>