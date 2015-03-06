Ext
		.onReady(function() {

			var cardNav = function(incr) {
				var l = Ext.getCmp('card-wizard-panel').getLayout();
				var i = l.activeItem.id.split('card-')[1];
				var next = parseInt(i, 10) + incr; 
				
				if(incr==-2){
					studentInfoForm.getForm().reset();
					fileUpdateForm.getForm().reset();
					Ext.getCmp('card-prev').show();
					Ext.getCmp('card-next').show();
					Ext.getCmp('card-done').hide();
				}
				if(next==2){
					Ext.getCmp('card-prev').hide();
					Ext.getCmp('card-next').hide();
					Ext.getCmp('card-done').show();
					isEnd=true;
				}
				l.setActiveItem(next);
				Ext.getCmp('card-prev').setDisabled(next == 0);
				Ext.getCmp('card-next').setDisabled(next == 2);
				 
			};
			var isEnd=false;
			var cardWizard = new Ext.Panel(
					{
						id : 'card-wizard-panel',
						title : '签约登记',
						layout : 'card',
						activeItem : 0, 
						bodyStyle : 'padding:15px',
						defaults : {
							anchor : "96%,96%",
							border : false
						},
						bbar : [ '->', {
							id : 'card-prev',
							text : '&laquo; 上一步',
							handler : cardNav.createDelegate(this, [ -1 ]),
							disabled : true
						}, {
							id : 'card-next',
							text : '下一步 &raquo;',
							handler : cardNav.createDelegate(this, [ 1 ])
						},  {
							id : 'card-done',
							text : '继续登记',
							handler : cardNav.createDelegate(this, [ -2 ]),
							hidden:true
						}  ],
						items : [
								studentInfoForm,
								fileUpdateForm,
								{
									id : 'card-2',
									html : '签约成功！'
								} ]
					});
			cardWizard.render("sysuser_div");
		});

var studentInfoForm = new Ext.FormPanel( {
	labelAlign : 'left',// 字样显示在顶部
	id : "card-0",
	height:820,
	items : [{
		labelStyle: 'text-align:right;',
		xtype : 'textfield', 
		fieldLabel : "选择学生",
		allowBlank : false, 
		id : "chooseStudent"
		}, {
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
			 
				items : [ {
					 
					id : "studentName",
					fieldLabel : "学生姓名", 
				}, {
					id : "grade",
					fieldLabel : "年级"
				} ]
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
					fieldLabel : "学校"
				} ]
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
					id : "age",
					fieldLabel : "年龄", 
				}, {
					id : "brithday",
					fieldLabel : "生日"
				} ]
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
				id : "homePhone"
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
				id : "addr"
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
				}, {
					id : "fatherUnit",
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
					id : "fatherPhone",
					fieldLabel : "手机", 
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
					fieldLabel : "母亲", 
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
					fieldLabel : "手机", 
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
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "30%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "testTime",
					xtype:"datefield",
					fieldLabel : "考试时间"
				} ]
		}, {
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "yuwen",
					fieldLabel : "语文", 
				}, {
					id : "huaxue",
					fieldLabel : "化学"
				}]
		} ,{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "shuxue",
					fieldLabel : "数学", 
				}, {
					id : "zhengzhi",
					fieldLabel : "政治"
				}]
		},{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "yingwen",
					fieldLabel : "英文", 
				}, {
					id : "lishi",
					fieldLabel : "历史"
				}]
		},{
			xtype : "container",
			columnWidth : 0.25,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "96%,96%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "wuli",
					fieldLabel : "物理", 
				}, {
					id : "shengwu",
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
				anchor : "50%",
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
				anchor : "50%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "liveHabit",
					xtype:"textarea",
					fieldLabel : "生活习惯"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "50%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "selfEvaluation",
					xtype:"textarea",
					fieldLabel : "自我评价"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "50%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "likeTeacherStyle",
					xtype:"textarea",
					fieldLabel : "喜欢的老师类型"
				} ]
		}  ,{
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form", 
			defaults : {
				anchor : "50%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ { 
					id : "likeCourseStyle",
					xtype:"textarea",
					fieldLabel : "喜欢的课程类型"
				} ]
		}    ]
	}] 
});


var fileUpdateForm =new Ext.FormPanel( {
	labelAlign : 'left',// 字样显示在顶部
	id : "card-1",
	items : [ {
		xtype : 'fieldset', 
		title : '初期辅导方案',
		layout : "column", 
		items : [
		 {
			xtype : "container",
			columnWidth : 1, 
			layout : "form", 
			defaultType : "textfield",
			defaults : {
				anchor : "80%,98%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ {
					xtype : 'textfield',   
				    inputType : 'file', 
			        id: 'form-file',
			        emptyText: '请选择', 
			        name: 'photo-path',
			        fieldLabel: '上传文件',
			        buttonText: '',
			        buttonCfg: {
			            iconCls: 'upload-icon'
			        }
			    }  ]
		} ]
	},{
		xtype : 'fieldset', 
		title : '华实模拟协议',
		layout : "column", 
		items : [
			{
				xtype : "container",
				columnWidth : 1, 
				layout : "form", 
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle: 'text-align:right;'
				}, 
				items : [ {
						xtype : 'textfield',   
					    inputType : 'file', 
				        id: 'form-file2',
				        emptyText: '请选择', 
				        name: 'photo-path',
				        fieldLabel: '上传文件',
				        buttonText: '',
				        buttonCfg: {
				            iconCls: 'upload-icon'
				        }
				    }  ]
			}]
	},{
		xtype : 'fieldset', 
		title : '全方位测评报告',
		layout : "column", 
		items : [
			{
				xtype : "container",
				columnWidth : 1, 
				layout : "form", 
				defaultType : "textfield",
				defaults : {
					anchor : "80%,98%",
					labelStyle: 'text-align:right;'
				}, 
				items : [ {
						xtype : 'textfield',   
					    inputType : 'file', 
				        id: 'form-file3',
				        emptyText: '请选择', 
				        name: 'photo-path',
				        fieldLabel: '上传文件',
				        buttonText: '',
				        buttonCfg: {
				            iconCls: 'upload-icon'
				        }
				    }  ]
			} ]
	},{
		xtype : 'fieldset', 
		title : '教学安排表',
		layout : "column", 
		items : [
		{
			xtype : "container",
			columnWidth : 1, 
			layout : "form", 
			defaultType : "textfield",
			defaults : {
				anchor : "80%,98%",
				labelStyle: 'text-align:right;'
			}, 
			items : [ {
					xtype : 'textfield',   
				    inputType : 'file', 
			        id: 'form-file4',
			        emptyText: '请选择',
			        fieldLabel: '上传文件',
			        name: 'photo-path',
			        buttonText: '',
			        buttonCfg: {
			            iconCls: 'upload-icon'
			        }
			    }  ]
		} ]
	}]
});
 