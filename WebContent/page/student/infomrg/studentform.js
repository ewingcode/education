var studentInfoForm = function(studentId){
	var _url="";
	if (studentId != null && studentId != "undefined") {
		_url="Busi_Student_update.action";
	}else{
		_url="Busi_Student_save.action";
	}  
	return new Ext.FormPanel( { 
	url:_url,	
	labelAlign : 'left',// 字样显示在顶部
	id : "card-0",   
	autoScroll:true,
	buttonAlign:'center',
	reader : new Ext.data.JsonReader( {
		  successProperty : 'success',
			root : 'result'
		}, ['id','name','sex','areaId','grade', 'school','brithday','age','phone','homephone','addr','fatherName',"fatherUnit","fatherPhone",
		    'fatherPosition','motherName','motherUnit', 'motherPhone','motherPosition',
		    {name:"lastExamDate" , type : "date", mapping : 'lastExamDate',dateFormat : 'Y-m-d H:i:s'},'scoreYuwen',
		    'scoreHuaxue','scoreShuxue','scoreZhengzhi', 'scoreYingwen','scoreLishi','scoreWuli','scoreShengwu',
		    'interest','livehabit','selfevaluation', 'liketeacherstyle','likecoursestyle','qq','email' ]),
	items : [ { 
		id : "id",
		xtype : "hidden",
		value :  this.primaryId == null ? "" :  this.primaryId
	} ,{
		xtype : 'fieldset', 
		title : '学生情况登记 ',
		layout : "column", 
		items : [ {
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [new SysArea.ComboBox('areaId',true), { 
					id : "name",
					fieldLabel : "学生姓名", 
					maxLength :10,
					listeners:{ 
						   "blur": function(field){  
							 Ajax.syncRequest("Busi_Student_validateStudent.action?studentName="+field.getValue(),  
									 function(data) {   
								      if(data.result){
								    	  Common.ErrMegBox('该学生：'+field.getValue()+'名称已重复！');
								    	  field.reset();
								      }
							 		}
							  );  	
							}
						}
				}, 
				new SysParam.ComboBox('年级','grade', 'GRADE' ,false),
				{
					fieldLabel : "email",
					name : 'email',
					vtype : 'email'  
				}]
		},{
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ 
				    new SysParam.ComboBox('性别','sex', 'SEXTYPE',true), 
				    {
					id : "school",
					fieldLabel : "学校",
					maxLength :100
				} , {
					fieldLabel : "移动电话", 
					id : "phone",
				    xtype:"numberfield", 
					maxLength :20
				}, {
					fieldLabel : "qq", 
					id : "qq",
				    xtype:"numberfield", 
					maxLength :50
				}]
		} ,{
			xtype : "container",
			columnWidth : 0.33,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ {
					id : "brithday", 
					xtype:"datefield", 
					fieldLabel : "生日", 
					maxValue:new Date(),  
					format:"Y-m-d", 
					listeners:{
						"blur":function(_df){  
							Ext.getCmp("age").setValue(new Date().getFullYear() - _df.getValue().getFullYear());
						}
					}
			}, {
				id : "age",
				readOnly:true,
				fieldLabel : "年龄"
			}
]
		},{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "30%",
				labelStyle: 'text-align:right;'
			},
			items : [ {
				fieldLabel : "家庭电话", 
				id : "homephone",
			    xtype:"numberfield", 
				maxLength :20
			} ]
		},{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "50%",
				labelStyle: 'text-align:right;'
			},
			items : [ {
				fieldLabel : "家庭住址", 
				id : "addr",
				maxLength :100
			} ]
		} ]
	} ,
	 {
		xtype : 'fieldset', 
		title : '家庭情况登记 ',
		layout : "column", 
		items : [ {
			xtype : "container",
			columnWidth : 0.5,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ {
					 
					id : "fatherName",
					fieldLabel : "父亲", 
					maxLength :10
				}, {
					id : "fatherUnit",
					fieldLabel : "工作单位",
					maxLength :100
				}]
		},{
			xtype : "container",
			columnWidth : 0.5,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ 
				 { 
					id : "fatherPhone",
					fieldLabel : "手机"
				}, {
					id : "fatherPosition",
					fieldLabel : "职务"
				}]
		},{
			xtype : "container",
			columnWidth : 0.5,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ { 
					id : "motherName",
					fieldLabel : "母亲"
				}, {
					id : "motherUnit",
					fieldLabel : "工作单位"
				}]
		},{
			xtype : "container",
			columnWidth : 0.5,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			},
			 
				items : [ 
				 { 
					id : "motherPhone",
					fieldLabel : "手机"
				}, {
					id : "motherPosition",
					fieldLabel : "职务"
				}]
		} ]
	},{
		xtype : 'fieldset', 
		title : '现在各科成绩',
		layout : "column", 
		items : [{
			xtype : "container",
			columnWidth : 1,
			defaultType : "numberfield",
			layout : "form", 
			defaults : {
				anchor : "50%",
				labelStyle: 'text-align:right;' 
			}, 
			items : [ { 
					id : "lastExamDate",
					xtype:"datefield",
					format:"Y-m-d H:i:s",
					//maxLength :10, 
					fieldLabel : "考试时间"
				} ]
		}, {
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "numberfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;',
				maxLength :3
			}, 
			items : [ { 
					id : "scoreYuwen",
					fieldLabel : "语文", 
					maxLength :3
				}, {
					id : "scoreHuaxue",
					fieldLabel : "化学",
					maxLength :3
				}]
		} ,{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "numberfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;',
				maxLength :3
			}, 
			items : [ { 
					id : "scoreShuxue",
					fieldLabel : "数学", 
					maxLength :3
				}, {
					id : "scoreZhengzhi",
					fieldLabel : "政治", 
					maxLength :3
				}]
		},{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "numberfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;',
				maxLength :3
			}, 
			items : [ { 
					id : "scoreYingwen",
					fieldLabel : "英文", 
					maxLength :3
				}, {
					id : "scoreLishi",
					fieldLabel : "历史", 
					maxLength :3
				}]
		},{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "numberfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;',
				maxLength :3
			}, 
			items : [ { 
					id : "scoreWuli",
					fieldLabel : "物理" 
				}, {
					id : "scoreShengwu",
					fieldLabel : "生物"
				}]
		}]
	},{
		xtype : 'fieldset', 
		title : '其它',
		layout : "column", 
		items : [{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "interest",
					xtype:"textarea",
					fieldLabel : "兴趣爱好"
				} ]
		} ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "livehabit",
					xtype:"textarea",
					fieldLabel : "生活习惯"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "selfevaluation",
					xtype:"textarea",
					fieldLabel : "自我评价"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "liketeacherstyle",
					xtype:"textarea",
					fieldLabel : "喜欢的老师类型"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "80%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "likecoursestyle",
					xtype:"textarea",
					fieldLabel : "喜欢的课程类型"
				} ]
		}    ]
	}]  
})
};
