Ext.onReady(function() {
	var myForm = new Ext.FormPanel( {
		title : "我的表单",
		 id: 'form-widgets',
		layout : 'form',  
		//labelWidth : 100,
		labelAlign : "right",
		layout : "form",
		//width : 486,
		//height : 320,
		 frame: true, 
		 closable: true,
//		 tools: [
//		            {id:'toggle'},{id:'close'},{id:'minimize'},{id:'maximize'},{id:'restore'},{id:'gear'},{id:'pin'},
//		            {id:'unpin'},{id:'right'},{id:'left'},{id:'up'},{id:'down'},{id:'refresh'},{id:'minus'},{id:'plus'},
//		            {id:'help'},{id:'search'},{id:'save'},{id:'print'}
//		        ],
		 
		monitorValid : true,// 验证表单 
		reader : new Ext.data.JsonReader( {
			// successProperty : 'success',
				root : ''
			}, ['id','userName','addr', 'sex','position','phone','zipcode' ]),
		items : [ {
			xtype : "textfield",
			name : "userName",
			fieldLabel : "名称",
			anchor : "100%",
			allowBlank : false

		}, {
			xtype : "textfield",
			name : "addr",
			fieldLabel : "地址",
			anchor : "100%",
			allowBlank : false
		}, {
			xtype : "textfield",
			name : "phone",
			fieldLabel : "电话",
			anchor : "100%",
			vtype : "alphanum",
			allowBlank : false
		}, {
			xtype : "datefield",
			name : "creation",
			fieldLabel : "创建时间",
			format : 'Y-m-d',
			anchor : "100%",
			allowBlank : true
		}, {
			xtype : "textarea",
			name : "des",
			fieldLabel : "详细信息",
			anchor : "100%",
			allowBlank : true
		} ],
		 buttons: [{
	            text:'禁止/开启',
	           // cls: 'x-icon-btn',
	           // iconCls: 'x-icon-btn-toggle',
	            handler: function(){
	                Ext.getCmp('form-widgets').getForm().items.each(function(ctl){
	                    ctl.setDisabled(!ctl.disabled);
	                });
	            }
	        },{
	            text: '重置',
	            cls: 'x-icon-btn',
	            iconCls: 'x-icon-btn-reset',
	            handler: function(){
	                Ext.getCmp('form-widgets').getForm().reset();
	            }
	        },{
	            text:'验证',
	            cls: 'x-icon-btn',
	            iconCls: 'x-icon-btn-ok',
	            handler: function(){
	                Ext.getCmp('form-widgets').getForm().isValid();
	            }
	        },{
	        	text:'查询',
	            cls: 'x-icon-btn',
	            iconCls: 'x-icon-btn-ok',
	            handler: function(){
	                Ext.getCmp('form-widgets').getForm().load( {
	        			//url : 'test/queryuserInfo.action'
	                	url: 'public/SysUser_query.action'
	        		})
	            }
	        },{
	        	text:'保存',
	            cls: 'x-icon-btn',
	            iconCls: 'x-icon-btn-ok',
	            handler: function(){
	        	myForm.getForm().submit( {
					url : 'public/SysUser_save.action',
					waitMsg : 'Saving Data...',
					submitEmptyText : false,
					success : function(form, action) {
	        			if(!Ext.getCmp('form-widgets').getForm().isValid())
	        				return;
						Ext.Msg.show( {
							title : '成功提示',
							msg : action.result.retinfo,
							buttons : Ext.MessageBox.OK,
							icon : Ext.Msg.INFO
						});
					},
					failure : function(form, action) {
						if(!Ext.getCmp('form-widgets').getForm().isValid())
	        				return;
						Ext.Msg.show( {
							title : '错误提示',
							msg : action.result.retinfo,
							buttons : Ext.Msg.OK,
							// fn : function() {btn.enable();},
							icon : Ext.Msg.ERROR
						});
					}

				});
	            }
	        	
	        }
	        
	        ]
	});
 
	myForm.render("grid-example");
});
