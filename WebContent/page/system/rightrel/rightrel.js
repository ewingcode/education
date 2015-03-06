Ext.ns("SysRel");
SysRel.viewWin = function(type,relId){
	var treeLoader = new Ext.tree.TreeLoader( { 
		dataUrl : 'Public_SysRightRel_querySettingTree.action?type='+type+'&relId='+relId  
		 
	});

	 var tree = new Ext.tree.TreePanel({  
	        autoHeight:true, 
	        useArrows:true,
	        animate:true,  
	        rootVisible: false,  
		        root: {
		            nodeType: 'async'
		        }, 
	        loader :treeLoader 
			  
	    });
	 tree.getRootNode().expand(true);
	 tree.on('checkchange',function(node, checked )
			 {   
		 		checkAction(node,checked)
			 }); 
	 var win =   new Ext.Window( {
			id : "rightRelForm",
		    title: '权限设置',
	        width: 500,
	        height:500,
	        minWidth: 500,
	        minHeight: 300, 
	        layout: 'fit', 
	        autoScroll:true,
	        plain:true,
	        bodyStyle:'padding:5px;',
	        buttonAlign:'center',
			 	items : [ tree  ],
			 	buttons : [ {
					text : "设置",
					iconCls : "btn_save",
					handler : function() { 
			 		 var  msg = '';
			 		 var selNodes = tree.getChecked();
					   Ext.each(selNodes, function(node){
						   if(msg.length > 0){ 
							   msg += ','; 
							   }
						   msg +=   node.id; 
						   });  
					   Ext.Ajax.request( {
							url : "Public_SysRightRel_roleSetting.action",
							params : {
								relId : relId,
								type: type ,
								menuIds:msg
							},
							method : "post",
							success : function() {
								Ext.Msg.show( {
									title : '编辑',
									msg : '设置成功',
									buttons : Ext.MessageBox.OK,
									icon : Ext.Msg.INFO
								}); 
							}, 
							failure : function() {
								 Ext.MessageBox.show( {
									title : "操作信息",
									msg : "信息保存出错，请联系管理员！",
									buttons : Ext.MessageBox.OK,
									icon : "ext-mb-error"
								}); 
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
}
function checkAction(node,checked)
{   
	 node.getUI().checkbox.checked = checked; 
	 node.attributes.checked = checked; 
	 node.eachChild(function(){ 
		 var childNode = this; 
		 childNode.getUI().checkbox.checked = checked; 
		 childNode.attributes.checked = checked; 
	 });
}