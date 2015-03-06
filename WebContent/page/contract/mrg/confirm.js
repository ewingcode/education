var TaskOperForm = function(orderId,status,page) {
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="Public_SysUser_update.action";
	}else{
		this.url="Public_SysUser_save.action";
	}
	var showPage = _contextPath+page+"?orderId="+orderId; 
 
	var editPanel = new Ext.FormPanel( { 
				layout : "form",
				autoDestroy:true,
				id : "confirmForm",
				frame : false,
				height:800,
				border : false, 
				plain:false,  
				buttonAlign:'center',
				defaults : {
					//anchor : "98%,100%"
				} ,
			 	items : [  
						{
							xtype : 'fieldset',
							hideBorders :true, 
							height:780,
							layout : "fit", 
							items:[{
							    	   html : '<iframe  src="'+showPage+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>',
										
							       }
							       ]
						}  ]   
	 }) ; 
	return editPanel;
	 //Frame.editWindow(editPanel,700,1000); 
};
	 
	
	