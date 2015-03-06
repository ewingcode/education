Ext.onReady(function() {
	var fileUpdateForm = new Ext.FormPanel( {
		labelAlign : 'left',// 字样显示在顶部
		fileUpload : true, //关键！！！
		renderTo:"file-example",
		id : "card-1",
		items : [   {
			xtype : 'fieldset',
			title : '全方位测评报告',
			layout : "column",
			items : [ {
				xtype : "container",
				columnWidth : 1,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					 xtype : 'textfield', 
				     fieldLabel : '上传文件1', 
				     name : 'uploadfile', 
				      inputType : 'file'
				} ]
			} ]
		}, {
			xtype : 'fieldset',
			title : '教学安排表',
			layout : "column",
			items : [ {
				xtype : "container",
				columnWidth : 1,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					 xtype : 'textfield', 
				     fieldLabel : '上传文件1', 
				     name : 'uploadfile2', 
				      inputType : 'file'
				} ]
			} ]
		} ,{
			fieldLabel : "下载文档", 
			xtype :"textfield",
			id : "downTargetPath"
		}],
		 buttons: [{   
			             text: 'Save',   
			            handler: function(){   
			                 if(fileUpdateForm.getForm().isValid()){   
			                	 fileUpdateForm.getForm().submit({ 
			                		 method : 'post',
			                        url:'Busi_UploadFile_upload.action',   //'Busi_File_upload.action',   
			                        waitMsg: 'Uploading your photo...',   
			                        success: function(fp, o){   
			                             alert('ok');   
			                         }   
			                    });   
			                 }   
			             }   
			          },{   
				             text: 'down',   
					            handler: function(){   
			        	           window.location="file/fileAction.action?downTargetPath="+$("#downTargetPath").val();
					             }   
					          },{   
			            text: 'Reset',   
			            handler: function(){   
			        	  fileUpdateForm.getForm().reset();   
			             }   
			         }] 
	});
});