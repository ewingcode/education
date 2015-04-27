<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedulecomp.js" />
<%@ include file="/common/include/html_head.jsp"%>
<script>
	Ext.onReady(function() {
		var orderCourseStore = new SysParam.store("ORDER_COURSE");
		var scheduleStatusStore = new SysParam.store("SCHEDULE_STATUS");
		var studentId = jQuery.url.param("studentId");
		var weekStore = new SysParam.store("WEEK"); 
		var sm = new Ext.grid.CheckboxSelectionModel();
		var cm = new Ext.grid.ColumnModel({
			columns : [ sm, new Ext.grid.RowNumberer(), {
				header : "id",
				dataIndex : "id",
				hidden : true
			}  , {
				header : "授课老师",
				dataIndex : "teacherId",
				renderer : function(value) {
					return SysUser.translate(value);
				}
			}  , {
				header : "课程",
				dataIndex : "courseType",
				renderer : function(value) {
					return SysParam.translate(orderCourseStore, value);
				}
			}, {
				header : "开始日期",
				dataIndex : "startDate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "结束日期",
				dataIndex : "endDate",
				renderer : Ext.util.Format.dateRenderer('Y-m-d')
			}, {
				header : "课程时间",
				dataIndex : "startTime",
				renderer : function(value, metaData, record, rowIndex,
						colIndex, store) { 
					return value+"-"+record.get("endTime");
				}

			} , {
				header : "总课时",
				dataIndex : "totalCourseHour"
			}, {
				header : "已用课时",
				dataIndex : "totalCostHour"
				
			},{
				header : "排课日",
				dataIndex : "weekDays",
				renderer : function(value) {
					 return SysParam.translateArray(weekStore, value);
				}
			}, {
				header : "状态",
				dataIndex : "status",
				renderer : function(value) {
					 return SysParam.translate(scheduleStatusStore, value);
				}
			} ,
			{
				header : "课程时间",
				dataIndex : "startTime",
				renderer : function(value, metaData, record, rowIndex,
						colIndex, store) { 
					return value+"-"+record.get("endTime");
				}

			} 
             ],
			defaults : {
				sortable : true,
				menuDisabled : false,
				width : 150
			}
		});

		
	 
		var store = new Ext.data.Store({
			// autoLoad : true,//是否自动加载
			proxy : new Ext.data.HttpProxy({
				url : 'Busi_CourseSchedule_pageQuery.action'
			}),
			reader : new Ext.data.JsonReader({
				root : 'result',
				totalProperty : 'totalProperty',
				remoteSort : true,
				fields : [ {
					name : "id",
					type : "int"
				}, "teacherId", "courseType", "totalCourseHour",
						"totalCostHour", "studentId", "status", "weekDays",
						"startDate","endDate","startTime","endTime" ]
			})
		});
		var gridPanel = new Ext.grid.GridPanel({
			id : "depGrid",
			store : store, 
			trackMouseOver : true,
			loadMask : true,
			region : "center",
			cm : cm,
			sm : sm,
			height : 550,
			viewConfig : {
				forceFit : true,// 填满width.
				enableRowBody : true,
				showPreview : false
			},
			// paging bar on the bottom
			bbar : new Ext.PagingToolbar({
				pageSize : 20,
				store : store,
				displayInfo : true,
				displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
				emptyMsg : "没有记录"

			})
		});

		var formpanel = new Ext.FormPanel({
			labelAlign : 'left',// 字样显示在顶部
			bodyStyle : 'padding:5px',
			plain : true,
			items : [  {
				xtype : 'fieldset',
				layout : "column",  
				autoHeight : true,
				items : [ {
					xtype : "container",
					columnWidth : 0.5,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						anchor : "96%,96%",
						labelStyle : 'text-align:right;'
					},

					items : [ {
						id : "totalScheduleHour",
						fieldLabel : "总课时",
						readOnly:true
					} ]
				} ,{
					xtype : "container",
					columnWidth : 0.5,
					defaultType : "textfield",
					layout : "form",
					defaults : {
						anchor : "96%,96%",
						labelStyle : 'text-align:right;'
					},

					items : [ {
						id : "totalCostScheduleHour",
						fieldLabel : "已用课时" 
					} ]
				} ]
			} ]
		});
		function loadGirdStore() { 
			store.load({
				params : {
					start : 0,
					limit : 20,
					_QUERY_n_eq_student_id:studentId,
					_QUERY_s_eq_iseff:0,
					_ORDERBY : 'order by create_time desc'
				},
			    callback: function(r, options, success){ 
			    	var totalScheduleHour=0;
			    	var totalCostScheduleHour=0;
			        if(success){
			        	for(var i=0;i<r.length;i++){
				    		var record = r[i];
				    		totalScheduleHour += record.data.totalCourseHour;
				    		totalCostScheduleHour += record.data.totalCostHour; 
				    		}    
			        	 Ext.getCmp("totalScheduleHour").setValue(totalScheduleHour);  
			        	 Ext.getCmp("totalCostScheduleHour").setValue(totalCostScheduleHour);  
			        }  
			    }    
			});
		}
 
		 loadGirdStore();
		 Frame.busiPage2(formpanel, gridPanel);

	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>