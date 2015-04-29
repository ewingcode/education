 
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
								 
								loadGirdStore();
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
		this.url="Busi_OrderCourseScore_update.action";
		isModify =true;
	}else{
		this.url="Busi_OrderCourseScore_save.action";
	}
  
	
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
	var courseStore = new Ext.data.Store({   
	    proxy: new Ext.data.HttpProxy({   
	    	url: 'Busi_OrderCourse_findCourseByStudent.action?studentId='+$("#studentId").val()  
	    }),   
	    reader: new Ext.data.JsonReader({   
	    	 successProperty : 'success',
			 root : 'result'   
	    }, [    
	        {name: 'id', mapping: 'courseType'},   
	        {name: 'name', mapping: 'courseType'
	        	 ,convert: covCourseName
	        	}   
	    ])   
	});   
	 
	var chargerStore = new Ext.data.Store({   
	    proxy: new Ext.data.HttpProxy({   
	    	url: 'Busi_OrderCourse_findChargerForCourse.action?studentId='+$("#studentId").val()+'&courseType='+Ext.getCmp("courseType").getValue()  
	    }),   
	    reader: new Ext.data.JsonReader({   
	    	 successProperty : 'success',
			 root : 'result'   
	    }, [    
	        {name: 'id', mapping: 'chargerId'},   
	        {name: 'name', mapping: 'chargerName' }   
	    ])   
	});
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
					  "courseType", "chargerId","studentId","score",
					"operator",
					{name:"operatorName" , type : "string", mapping : 'operator',convert : converOperator},
					{name:"chargerName" , type : "string", mapping : 'chargerId',convert : converCharger},
					{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'},
					{name:"lastUpdate" , type : "date",mapping : 'lastUpdate.time',dateFormat : 'time'},
					{name:"examTime" , type : "date",mapping : 'examTime.time',dateFormat : 'time'}]),
		items : [ { 
			id : "id",
			xtype : "hidden",
			value :  this.primaryId == null ? "" :  this.primaryId
		} , 
		{ 
			  hidden : true,  
			id : "operator",
			value: session_userId  
		}, 
		{ 
			fieldLabel : "编辑者",
			id : "operatorName",
			hidden:this.primaryId == null ? true :  false
		},
		{
			xtype : 'compositefield',
			id : "assignerComp",
			fieldLabel : '学生',
			width : "200",
			items : [
					{
						xtype : "textfield",
						id : 'studentId',
						hidden : true
					},
					{
						xtype : "textfield",
						id : "studentName",
						width : "70",
						readOnly : true
					},
					{
						xtype : "button",
						id : "choseAssigerBtn",
						text : "选择",
						width : "50",
						listeners : {
							"click" : function(d, i, n, e) {
								new Student.selectWin(function(studentId, studentName) {
									Ext.getCmp('studentId').setValue(studentId);
									Ext.getCmp('studentName').setValue(studentName);
									
								    Ext.getCmp("courseType").clearValue();  
									courseStore.removeAll();
									 if(studentId == null || studentId=='')
										 return; 
				                    courseStore.load();   
				                      
								});
							}
						}
					} ]
		},
		 new Ext.form.ComboBox(
					{
						id : "courseType",
						hiddenName : "courseType",
						triggerAction : "all",
						fieldLabel : "课程",
						readOnly : false,
						editable : false,
						emptyText : '请选择',  
						mode: 'remote',
						region : "center",
						valueField : "id",
						displayField : "name", 
						store:courseStore, 
					    listeners:{ 
						   "select": function(combo,  record, index){
							   var courseType = combo.value;
							   var studentId = $("#studentId").val();
							   if(courseType == null && courseType!='' && studentId!=null && studentId!='')
							   {  
								   Ext.getCmp("chargerId").clearValue(); 
								   chargerStore.load();
						       }
							}
						}
					}), 
			 new Ext.form.ComboBox(
								{
									id : "chargerId",
									hiddenName : "chargerId",
									triggerAction : "all",
									fieldLabel : "教师",
									readOnly : false,
									editable : false,
									emptyText : '请选择',  
									mode: 'remote',
									region : "center",
									valueField : "id",
									displayField : "name", 
									store:chargerStore
			}), 
			{
				fieldLabel : "分数",
				allowBlank : false,
				maxLength:3,
				id : "score"
			},
			{
				fieldLabel : "考试时间", 
				xtype:"datefield",  
				maxValue:new Date(),  
				format:"Y-m-d", 
				name : "examTime" 
			}
					
		 ]
	});

	if (this.primaryId != null && this.primaryId != "undefined") {
		editForm.getForm().load(
				{
					deferredRender : false,
					url :  "Busi_OrderCourseScore_query.action?condition=id="+this.primaryId,
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
	
	

	function covCourseName(v, record){ 
	    return  SysParam.translate(orderCourseStore,record.courseType) ; 
	}
	
	function covExtimTime(v, record) {
		return new Date(record.bookTime.time).format('Y-m-d H:i:s');
	}
	function converCharger(v, record){
		return SysUser.translate(record.chargerId);
	} 
	function converOperator(v, record){
		return SysUser.translate(record.operator);
	}
	