<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%> 
<script>
	Ext.onReady(function() {

		var shedulePanel = new Ext.FormPanel({
			title : '日程表',
			region : 'center',
			split : true,
			width : 700,
			layout : "form",
			defaultType : "textfield",
			buttonAlign : 'center',
			items : [ new Schedule.showCalender(11) ]

		});
		var configPanel = new Ext.FormPanel({
			title : '排课设置',
			region : 'west',
			split : true,
			width : 300,
			layout : "form",
			defaultType : "textfield",
			buttonAlign : 'center',
			items : [ new Order.contractStatus(11) ]

		});
		new Ext.Viewport({
			layout : 'border',
			items : [ configPanel, shedulePanel ]
		});
	});


	Order.contractStatus = function(orderId) {
		var status = "";
		var contractSet;
		contractSet = new Ext.form.FieldSet({
			xtype : 'fieldset',
			title : '排课时间',
			layout : "column",
			items : [ {
				xtype : "container",
				columnWidth : .5,
				defaultType : "textfield",
				layout : "form",
				defaults : {
					width : 150,
					labelStyle : 'text-align:right;'
				},
				items : [ {
					xtype : 'compositefield',
					fieldLabel : '排课日期',
					msgTarget : 'side',
					anchor : '-20',
					width : 150,
					defaults : {
						flex : 1
					},
					items : [ {
						id : "QUERY_schedule_startTime",
						xtype : "datefield",
						width : 150,
						vtype : 'daterange'
					} ]
				}, new SysParam.ComboBox('课程时间', 'grade', 'GRADE', false)

				]
			}, {
				xtype : "container",
				columnWidth : 0.5,
				defaultType : "textfield",
				layout : "form",
				defaults : {
					width : 150,
					labelStyle : 'text-align:right;'
				},
				items : [ {
					id : "startTime",
					fieldLabel : "学生"
				}, new SysParam.ComboBox('科目', 'courseList', 'ORDER_COURSE')

				]
			} ]
		});
		return contractSet;
	};
</script> 

<%@ include file="/common/include/html_bottom.jsp"%>