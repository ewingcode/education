Ext.ns("Order");

var isLoad=false;
var applyStatusComBox;
var applyStatusStore;
var orderCourseStore;  
var gradeStore;
var attachTypeStore;
var statusStore;
var yesOrNoStore;
var runStatusStore;
/**
 * 初始化数据
 * 
 * @return
 */
Order.initData = function() {
	if(!isLoad){
		applyStatusComBox = new SysParam.ComboBox('审批', 'applyStatus',
				'APPLY_STATUS', true, true);
		applyStatusStore = new SysParam.store("APPLY_STATUS");
		orderCourseStore = new SysParam.store("ORDER_COURSE"); 
		gradeStore = new SysParam.store("GRADE"); 
		attachTypeStore = new SysParam.store("ATTACH_TYPE");  
		statusStore = new SysParam.store("CONTRACT_STATUS");
		gradeStore = new SysParam.store("GRADE");
		yesOrNoStore = new SysParam.store("YESORNO");
		runStatusStore = new SysParam.store("ORDER_RUN_STATUS");
		isLoad=true;
	}
}


/**
 * 流程操作列表
 * 
 * @param orderId
 * @param selectFn
 * @return
 */
Order.transitionChoice = function(orderId,isReadOnly, selectFn) {
	 var _isReadOnly=isReadOnly!=null&&isReadOnly?true:false;
	 var url = "Busi_OrderView_showPageAction.action?orderId=" + orderId;
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	           {name: 'name'},
	           {name: 'needArrange'}
	        ]
	    }); 
	 var arrayObj;
	 Ajax.syncRequest(url,  
			 function(data) {  
		         arrayObj = new Array(data.result.length);　
		 		 for(var i=0;i<data.result.length;i++){
		 			var name =data.result[i].name;
		 			var needArrange =data.result[i].needArrange;
		 			arrayObj[i] = [name,needArrange]; 
		 		 }
	 	}
	  );  
	 arrayStore.loadData(arrayObj); 
	return new Ext.form.ComboBox( {
		id : "transitionName",
		hiddenName : "transitionName",
		triggerAction : "all",
		width : 150, 
		fieldLabel : '签单处理',
		emptyText : '请选择', 
		valueField : "name",
		displayField : "name",
		allowBlank : false, 
		lazyRender:true,
		mode: 'local', 
		store:arrayStore,  
		listeners : {
			"select" : function(c, r, i) {
				var isShow = r.get("needArrange"); 
				 Assigner.showAssinerField(isShow);
			}
		}
	});
};
/**
 * 签单负责人
 * 
 * @param showMainTeacher
 * @param showTeacher
 * @return
 */
Order.chargerComp = function(showMainTeacher, showTeacher) {
	var _showMainTeacher = true;
	var _showTeacher = true;
	if (showMainTeacher != null) {
		_showMainTeacher = showMainTeacher;
	}
	if (showTeacher != null) {
		_showTeacher = showTeacher;
	}
	var chargerSet = new Ext.form.FieldSet( {
		title : '签单负责人',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "100%",
				labelStyle : 'text-align:right;'
			},
			items : [ {
				id : "mainTeacher",
				fieldLabel : "班主任",
				readOnly : true,
				hidden : !_showMainTeacher
			}, {
				id : "teacher",
				fieldLabel : "授课老师",
				readOnly : true,
				hidden : !_showTeacher
			} ]
		} ]
	});
	return chargerSet;
};

/**
 * 签单信息
 * 
 * @param orderId
 * @return
 */
Order.contractStatus = function(orderId) {
	var status = "";
	var contractSet;
	var url = 'Busi_OrderView_showOrderInfo.action?orderId=' + orderId;
	Ajax.syncRequest(url, function(data) {
		var status = data.result.status;
		var courseHour = data.result.courseHour;
		var remainHour = data.result.courseHour- data.result.costCourseHour; 
		var studentId = data.result.studentId; 
		var grade = data.result.grade; 
		var runStatus=data.result.runStatus;
		var status=data.result.status;
		var fee= parseFloat(data.result.fee)/100;
		 
		var startTime =  new Date(data.result.startTime.time).format('Y-m-d H:i:s') ; 
		var endTime =  new Date(data.result.endTime.time).format('Y-m-d H:i:s') ; 
		contractSet = new Ext.form.FieldSet( {
			xtype : 'fieldset',
			title : '签单信息',
			layout : "column",
			items : [ {
				xtype : "container",
				columnWidth : .3,
				defaultType : "textfield",
				layout : "form",
				defaults : {  
					width:150,
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "customerId",
					fieldLabel : "学生",
					readOnly : true,
					value :  Student.translate(studentId)
				} , {
					id : "courseHour",
					fieldLabel : "课时",
					readOnly : true,
					value : courseHour
				} ,{
					id : "orderStatus",
					fieldLabel : "审批状态",
					readOnly : true,
					value : status
				}
				]
			},{
				xtype : "container",
				columnWidth : 0.3,
				defaultType : "textfield",
				layout : "form",
				defaults : {  
					width:150,
					labelStyle : 'text-align:right;'
				},
				items : [
					{
					id : "gradeName",
					fieldLabel : "报读年级",
					readOnly : true,
					value : SysParam.translate(gradeStore,grade)
				},
				{
					id : "remainHour",
					fieldLabel : "剩余课时",
					readOnly : true,
					value : remainHour
				},
				{
					id : "runStatus",
					fieldLabel : "签单状态",
					hidden : true,
					value: runStatus
				} ,
				 {
					id : "runStatusStr",
					fieldLabel : "签单状态",
					readOnly : true,
					value:SysParam.translate(runStatusStore,runStatus)
				} 
				]
			} ,{
				xtype : "container",
				columnWidth : 0.3,
				defaultType : "textfield",
				layout : "form",
				defaults : {  
					width:150,
					labelStyle : 'text-align:right;'
				},
				items : [
				  {
					id : "fee",
					fieldLabel : "签单费用",
					readOnly : true,
					value : fee
				  }
				]
			},
			{
				xtype : "container",
				columnWidth : 0.3,
				defaultType : "textfield",
				layout : "form",
				defaults : {  
					width:150,
					labelStyle : 'text-align:right;'
				},
				items : [
				   {
					id : "startTime",
					fieldLabel : "开始时间",
					readOnly : true,
					value:startTime
					} ,
				   {
					id : "endTime",
					fieldLabel : "结束时间",
					readOnly : true,
					value:endTime
					}  
				]
			}
	          
			]
		});
		
	});
	return contractSet;
};
 
/**
 * 签单课程时间信息
 * 
 * @param orderId
 * @return
 */
Order.courseTimeEdit = function(orderId) {
	var status = "";
	var contractSet;
	var url = 'Busi_OrderView_showOrderInfo.action?orderId=' + orderId;
	Ajax.syncRequest(url, function(data) {
		var status = data.result.status;
		var courseHour = data.result.courseHour;
		var studentId = data.result.studentId; 
		var grade = data.result.grade; 
		var startTime =  new Date(data.result.startTime.time).format('Y-m-d') ;  
		var endTime =  new Date(data.result.endTime.time).format('Y-m-d') ; 
		contractSet = new Ext.form.FieldSet( {  
			xtype : 'fieldset',
			title : '签单信息',
			layout : "column",
			items : [ 
		         
			    {
				xtype : "container",
				columnWidth : 1,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "20%,20%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "studentId", 
					hidden : true,
					value:studentId,
					 
				}, {
					id : "studentName",
					fieldLabel : "学生",
					readOnly : true,
					value:Student.translate(studentId),
					 
				}]
			}, {
				xtype : "container",
				columnWidth : 0.3,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "courseHour",
					fieldLabel : "课时",
					value:courseHour,
					maxLength : 10,
				} ]
			}, {
				xtype : "container",
				columnWidth : 0.3,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "startTime",
					xtype : "datefield",
					format : "Y-m-d",
					fieldLabel : "开始时间", 
					maxLength : 10,
					value:startTime,
					vtype : 'daterange',
					endDateField : 'endTime'
				} ]
			}, {
				xtype : "container",
				columnWidth : 0.3,
				layout : "form",
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "endTime",
					xtype : "datefield",
					format : "Y-m-d",
					fieldLabel : "结束时间", 
					maxLength : 10,
					vtype : 'daterange',
					value:endTime,
					startDateField : 'startTime'
				} ]
			} ]
		});

	});
	return contractSet;
};


/**
 * 流程提交
 * 
 * @param orderId
 * @param submitType
 * @param assignerId
 * @param comment
 * @return
 */
Order.submitForm = function(isOnlyEdit,editform,orderId, submitType, assignerId, comment,courseOper,checkCourse) {
	var _orderId = orderId;
	var _submitType = submitType;
	var _assignerId = assignerId;
	var _courseOper=courseOper;
	var _comment = comment;
	var _isOnlyEdit=isOnlyEdit;
	if(!editform.getForm().isValid())
		return;
	Ext.Msg.confirm("信息确认", "您确认要保存该记录吗？", function(c) {
		if (c == "yes") {
			
			 editform.getForm().submit( {
				    url : "Busi_OrderControl_submit.action",
					method : "post",
					params : {
						orderId : _orderId,
						transitionName : $("#transitionName").val(),
						submitType : _submitType,
						courseOper: _courseOper,
						assignerId : _assignerId,
						comment : _comment,
						isOnlyEdit:_isOnlyEdit, 
						courseList : checkCourse 
					},
					waitMsg : "正在提交数据...",
					success : function(i, j) { 
						 Ext.Msg.show( {
							title : '编辑',
							msg : '保存成功',
							fn:function(){
							   parent.window.closeTabPanel(orderId);
						 	},
							buttons : Ext.MessageBox.OK,
							icon : Ext.Msg.INFO
						});     
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
	});

};

