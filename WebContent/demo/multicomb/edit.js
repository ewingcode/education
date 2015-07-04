
var EditWindow = function(b) {
   this.primaryId = b;
	var editform = this.editform();
	var win =   new Ext.Window( {
		id : "depEditForm",
	    title: '考试分数管理',
        width: 500,
        height:300,
        minWidth: 500,
        minHeight: 300,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
		 	items : [ editform  ],
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
								 
							    store.load();
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
EditWindow.prototype.editform = function() {
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="Busi_OrderCourseScore_update.action";
	}else{
		this.url="Busi_OrderCourseScore_save.action";
	}
	var editForm = new Ext.FormPanel( {
		url :   this.url,
		layout : "form",
		autoDestroy:true,
		id : "RoleForm",
		frame : false,
		border : false,  
		bodyStyle : "padding:5px;",
		defaultType : "textfield",
		defaults : {
			anchor : "98%,100%"
		},
		reader : new Ext.data.JsonReader( {
			  successProperty : 'success',
				root : 'result'
			}, [   { name : "id", type : "int" }, 
					"orderId", "courseType", "chargerId","studentId","score",
					{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
					{name:"lastUpdate" , type : "date",mapping : 'lastUpdate.time',dateFormat : 'time'},
					{name:"examTime" , type : "date",mapping : 'examTime.time',dateFormat : 'time'}]),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} , { 
			hidden : true, 
			id : "orderId"
		},/*{
			xtype : 'fieldset',
			title : '学生',
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
				items : [ new Student.choose(false) ]
			} ]
		},*/
		new Ext.form.ComboBox(
				{
					id : "studentId",
					hiddenName : "studentId",
					triggerAction : "all",
					fieldLabel : "学生",
					readOnly : false,
					editable : false,
					emptyText : '请选择',   
					mode: 'remote', 
					region : "center",
					valueField : "id",
					displayField : "name", 
					store:parentStore, 
				    listeners:{ 
					   "select": function(combo,  record, index){
						childStore.proxy= new Ext.data.HttpProxy({
							url: 'Busi_OrderCourse_query.action?condition=order_id='+combo.value 
							});   
	                    childStore.load();   
                     }
					}
				}),
			new Ext.form.ComboBox(
					{
						id : "courses",
						hiddenName : "courses",
						triggerAction : "all",
						fieldLabel : "课程",
						readOnly : false,
						editable : false,
						emptyText : '请选择',  
						mode: 'remote',
						region : "center",
						valueField : "id",
						displayField : "name", 
						store:childStore, 
					    listeners:{ 
						   "select": function(combo,  record, index){
									 
										}
						}
					}) 
		 ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Public_SysDepartment_query.action?condition=id="+this.primaryId,
					waitMsg : "正在载入数据...",
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
	return editForm;
	}; 
	
	var parentStore = new Ext.data.Store({   
	    proxy: new Ext.data.HttpProxy({   
	        url: 'Busi_OrderInfo_query.action'   
	    }),   
	    reader: new Ext.data.JsonReader({  
    	 successProperty : 'success',
		 root : 'result' 
	    }, [   
	        {name: 'id', mapping: 'id'},   
	        {name: 'name', mapping: 'id'}   
	    ])  
	});   
	parentStore.load();
	var childStore = new Ext.data.Store({   
	    proxy: new Ext.data.HttpProxy({   
	        url: 'Busi_OrderCourse_query.action?condition=order_id=35'   
	    }),   
	    reader: new Ext.data.JsonReader({   
	    	 successProperty : 'success',
			 root : 'result'   
	    }, [    
	        {name: 'id', mapping: 'id'},   
	        {name: 'name', mapping: 'courseType',convert: covCourseName}   
	    ])   
	});  
	childStore.load();
	var orderCourseStore = new SysParam.store("ORDER_COURSE");
	function covCourseName(v, record){ 
	    return  SysParam.translate(orderCourseStore,record.courseType) ; 
	}
	