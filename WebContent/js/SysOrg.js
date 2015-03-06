Ext.ns("SysOrg");
/**
 * 
 * @param queryType 0:个人 2:部门
 */
SysOrg.viewWin = function(assingerId,assingerName,queryType){
	var treeLoader = new Ext.tree.TreeLoader( { 
		//dataUrl : 'Public_SysOrg_queryOrgStructTree.action?queryType='+ queryType  
		dataUrl : 'Public_SysRole_queryRoleStructTree.action'  
	});
	
	 var tree = new Ext.tree.TreePanel({  
	        autoHeight:true, 
	       // useArrows:true,
	        animate:false,  
	        rootVisible: false,  
		        root: {
		            nodeType: 'async'
		        }, 
	        loader :treeLoader ,
	        listeners: {  
		        	dbclick :function(node,event) { alert(111) } }
			  
	    });
	 tree.getRootNode().expand(true);
 
	 tree.on('checkchange',function(node, checked )
			 {   
		 		checkAction(node,checked)
			 });   
	 var win =   new Ext.Window( {
			id : "orgStructForm",
		    title: '组织架构',
	        width: 350,
	        height:400,
	        minWidth: 500,
	        minHeight: 300, 
	        layout: 'fit', 
	        autoScroll:true,
	        plain:true,
	        bodyStyle:'padding:5px;',
	        buttonAlign:'center',
			 	items : [ tree
			 	         
			 	         ],
			 	buttons : [ {
					text : "设置",
					iconCls : "btn_save",
					handler : function() { 
			 		 var  ids = '';
			 		 var  names = '';
			 		 var selNodes = tree.getChecked();
					   Ext.each(selNodes, function(node){ 
						   if(node.attributes.type=='1'){
							   if(ids.length > 0){ 
								   ids += ','; 
								   names +=","
								   }
							     ids +=   node.id; 
							     names += node.text
						   }
						   });
					   $('#'+assingerId).val(ids );
					   $('#'+assingerName).val(names );
					   win.close();
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
