
Ext.onReady(function() {   
	var checkTreeNode; 
	var removeData = function(b) { 
	Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
		if (c == "yes") {
			Ext.Ajax.request( {
				url : "Public_SysMenu_delete.action",
				params : {
					id : b
				},
				method : "post",
				success : function() {
					Ext.Msg.show( {
						title : '编辑',
						msg : '成功删除记录',
						buttons : Ext.MessageBox.OK,
						icon : Ext.Msg.INFO
					});
					tree.root.reload();
					tree.root.expand(true,false);
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
	});
};
 function onInsertNode()   {    
	 Ext.Msg.prompt('请输入新建的节点名称' , '新建标准名称' , onInsertNodePrompt , this) ;    
 }    
 function onInsertNodePrompt(btn , text)    
 {     
	 if(btn == 'ok')    
	 {       
	   var selectedParentNode = checkTreeNode.parentNode;  
	   var newNode = new Ext.tree.TreeNode({    
	      text : text    
	     });     
		 checkTreeNode.appendChild(newNode); 
		 newTreeData.reload( {
				params : {
					parentid : checkTreeNode.id, 
				}
			});  
		 	newTreeData.on('load', function(store, records) { 
				store.each(function(rec) {
					editform.get("id").setValue(rec.get('id'));
					editform.get("name").setValue(text); 
					editform.get("level").setValue(rec.get('level')); 
					editform.get("sort").setValue(rec.get('sort'));
					editform.get("parentid").setValue(rec.get('parentid'));
				});
			});
	 }
 }
 var newTreeData = new Ext.data.Store( {
		proxy : new Ext.data.HttpProxy( {
			url : 'Public_SysMenu_createNewMenu.action'  
		}),
		reader : new Ext.data.JsonReader( {
			root : 'result',
			fields : [ 'id', 'parentid','sort','level' ]

		})
	});
 	
	
	var rightClick = new Ext.menu.Menu({
					id :'rightClickCont',
					items : [{
					id:'uploadT',
					text: '导入内容',
					style: 'display:none;',
					// 增加菜单点击事件
					handler:function (node){
					upwin.show(); 
					}
					},{
						id: 'newT',
						text: '新增',
						// 增加菜单点击事件
						handler:function (node){ 
							onInsertNode();
							
						}    
						},{
					id: 'modT',
					text: '编辑',
					// 增加菜单点击事件
					handler:function (node){
						 
						editform.getForm().load(
								{
									deferredRender : false,
									url :  "Public_SysMenu_query.action?condition=id="+checkTreeNode.id, 
									success : function(d, e) { 
									},
									failure : function(b, c) { 
										  Ext.MessageBox.show( {
											title : "编辑",
											msg : "载入失败！",
											buttons : Ext.MessageBox.OK,
											icon : "ext-mb-error"
										});
									}
								});
					}    
					},{
						id: 'modT',
						text: '编辑',
						// 增加菜单点击事件
						handler:function (node){
							 
							editform.getForm().load(
									{
										deferredRender : false,
										url :  "Public_SysMenu_query.action?condition=id="+checkTreeNode.id, 
										success : function(d, e) { 
										},
										failure : function(b, c) { 
											  Ext.MessageBox.show( {
												title : "编辑",
												msg : "载入失败！",
												buttons : Ext.MessageBox.OK,
												icon : "ext-mb-error"
											});
										}
									});
						}    
						},
						{
					id:'delT',
					text : '删除',
					handler:function (node){
						removeData(checkTreeNode.id );  
						}    
					} ]
	});
 var treeLoader = new Ext.tree.TreeLoader( { 
		dataUrl : 'Public_SysMenu_queryAllMenuTree.action?isAll=true'   
 });
 
	 var tree = new Ext.tree.TreePanel({ 
		    width:300,
		    height:500,
	      //  autoHeight:true, 
	       // useArrows:false,
	        autoScroll:true,
	        animate:false,  
	        rootVisible: false,  
 	        root: {
 	            nodeType: 'async'
 	        }, 
	        loader :treeLoader
	        /*
			 * ,
			 * 
			 * listeners: { checkchange : function(node, checked){ alert(1111);
			 * if(checked){ node.getUI().addClass('complete'); }else{
			 * node.getUI().removeClass('complete'); } }, dbclick
			 * :function(node,event) { alert(1); } },
			 * 
			 * buttons: [{ text: 'Get Completed Tasks', handler: function(){ var
			 * msg = '', selNodes = tree.getChecked(); Ext.each(selNodes,
			 * function(node){ if(msg.length > 0){ msg += ', '; } msg +=
			 * node.text; }); Ext.Msg.show({ title: 'Completed Tasks', msg:
			 * msg.length > 0 ? msg : 'None', icon: Ext.Msg.INFO, minWidth: 200,
			 * buttons: Ext.Msg.OK }); } }]
			 */
	    });
	 
	 tree.getRootNode().expand(true);
		// 绑定节点右键菜单功能
		 tree.on('contextmenu',function(node,event)
		 { 
			 checkTreeNode = node ;
			 event.preventDefault();// 阻止浏览器默认右键菜单
			 rightClick.showAt(event.getXY());// 取得鼠标点击坐标，展示菜单
		 });  
 
		var editform = new Ext.FormPanel( {
			width:500,
			url :   'Public_SysMenu_update.action',
			layout : "form",
			autoDestroy:true,
			id : "menuForm",  
		// autoWidth:true,
			border : true,  
			bodyStyle : "padding:5px;",
			defaultType : "textfield",
			frame:true,
			defaults : {
				anchor : "98%,100%"
			},
			reader : new Ext.data.JsonReader( {
				  successProperty : 'success',
					root : 'result'
				}, ['id','name','url','level','parentid','iseff','isleaf','des','sort']),
			items : [ { 
				id : "id",
				xtype : "hidden",
				value :  this.primaryId == null ? "" :  this.primaryId
			} , {
				fieldLabel : "菜单名称",
				allowBlank : false, 
				id : "name"
			}, 
			{
				fieldLabel : "菜单链接",
				allowBlank : true, 
				id : "url"
			},
			{
				fieldLabel : "层次",
				allowBlank : true, 
				id : "level"
			},
			{
				fieldLabel : "父菜单",
				allowBlank : false, 
				id : "parentid"
			}, 
			{
				fieldLabel : "描述",
				allowBlank : true, 
				id : "des"
			},
			{
				fieldLabel : "排序",
				allowBlank : true, 
				id : "sort"
			},
			 new SysParam.ComboBox('是否叶子','isleaf', 'YESORNO' ,false),
			 new SysParam.ComboBox('是否有效','iseff', 'ISEFF' ,false)
			 ],
			  buttonAlign:'center',
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
										tree.root.reload();
										tree.root.expand(true,false);
								    
								},
								failure : function(i, j) {
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
					text : "重置",
					iconCls : "btn_reset",
					handler : function() {
					 editform.form.reset();
					}
				} ]
		});
		 
	  
	  var mainPanel = new Ext.Panel({ 
		    renderTo:'menu_div',  
		    autoHeight: true, 
		    border:false,
		    items:[tree]
	});    
	  var mainPanel = new Ext.Panel({ 
		    renderTo:'edit_div',  
		    autoHeight: true, 
		    border:false,
		    items:[editform]
	});    
});
 
