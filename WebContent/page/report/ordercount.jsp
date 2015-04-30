<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<style type="text/css">
.tip-target {
	width: 100px;
	text-align: center;
	padding: 5px 0;
	border: 1px dotted #99bbe8;
	text-align: left;
	background: #dfe8f6;
	color: #15428b;
	cursor: default;
	margin: 10px;
	font: bold 11px tahoma, arial, sans-serif;
	float: left;
}
</style>
<script>
	Ext.chart.Chart.CHART_URL = '../../resources/charts.swf';

	Ext.onReady(function() {
				var sexTypeStore = new SysParam.store("SEXTYPE");
				var url = "Public_Common_noMappedObjectQuery.action?sql=select * from order_info_daily order by create_date  limit 7";
				var arrayStore = new Ext.data.ArrayStore({
					fields : [ {
						name : 'create_date'
					}, {
						name : 'total'
					} ]
				});

				var store = new Ext.data.Store({
					// autoLoad : true,//是否自动加载
					proxy : new Ext.data.HttpProxy({
						url : url
					}),
					reader : new Ext.data.JsonReader({
						root : 'result',
						totalProperty : 'totalProperty',
						remoteSort : true,
						fields : [ "create_date", "total" ]
					})
				});
				store.reload();

				var countPanel = new Ext.Panel({
					title : '签单日报表',
					width : 700,
					height : 200,
					layout : 'fit',
					border : false,
					autoDestroy : true,
					items : {
						xtype : 'linechart',
						store : store,
						xField : 'create_date',
						yField : 'total',
						listeners : {
							itemclick : function(o) {
								var rec = store.getAt(o.index);
								Ext.example.msg('Item Selected',
										'You chose {1}.', '总数：'
												+ rec.get('total'));
							}
						}
					}
				});

				new Frame.editPage(countPanel);

			});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>