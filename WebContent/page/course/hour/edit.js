
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
								 
							    store.reload();
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
	var isModify=false;
	if (this.primaryId != null && this.primaryId != "undefined") {
		this.url="Busi_OrderCourseHour_update.action";
		isModify = true;
	}else{
		this.url="Busi_OrderCourseHour_save.action";
	}
	var orderId='';
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
			}, [   
				   { name : "id", type : "int" }, 
					"orderId", "costHour", "operator","studentId", 
					{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
					{name:"lastUpdate" , type : "date",mapping : 'lastUpdate.time',dateFormat : 'time'},

					{
						name : "teachTime",
						type : "date",
						mapping : 'teachTime.time',
						dateFormat : 'time' 
					}
					 ]),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} , 
		new Ext.form.ComboBox(
				{
					id : "studentId",
					hiddenName : "studentId",
					triggerAction : "all",
					fieldLabel : "学生",
					readOnly : isModify?true:false,
					editable : false,
					emptyText : '请选择',   
					mode: 'remote', 
					region : "center",
					valueField : "id",
					displayField : "name", 
					store:parentStore, 
				    listeners:{ 
					   "select": function(combo,  record, index){  
					 Ajax.syncRequest('Busi_OrderInfo_queryStudentRelOrder.action?userId=0&studentId='+combo.value,  
							 function(data) { 
						       if(!data.result || data.result.length==0){
						        	var studentName= Student.translate(combo.value);
						        	Common.ErrMegBox('该'+studentName+'没有签约课程信息');
						        	editForm.form.reset();
						        	return;
						        }
						 		if(data.result && data.result.length==1){ 
						 			orderId =data.result[0].id;
						 			$("#orderId").val(orderId);
						 		}
					 	}
					  );  
					 
                     }
					}
				}) ,
			{ 
				fieldLabel : "签单编号",
				readOnly : true,  
				hidden:true,
				id : "orderId"
			}, 
			{
				fieldLabel : "花费学时",
				allowBlank : false,
				maxLength:3,
				id : "costHour"
			} ,
			{
				fieldLabel : "上课时间",
				id : "teachTime" ,
				xtype:"datefield" , 
				format:"Y-m-d"
			}
					
		 ]
	});
	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_OrderCourseHour_query.action?condition=id="+this.primaryId,
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
	        url: 'Busi_Student_query.action'   
	    }),   
	    reader: new Ext.data.JsonReader({  
    	 successProperty : 'success',
		 root : 'result' 
	    }, [   
	        {name: 'id', mapping: 'id'},   
	        {name: 'name', mapping: 'name'}   
	    ])  
	});   
	parentStore.load(); 
	function covExtimTime(v, record) {
		return new Date(record.bookTime.time).format('Y-m-d H:i:s');
	}
	function covTeachTime(v, record) {
		return new Date(record.teachTime.time).format('Y-m-d H:i:s');
	} 
	