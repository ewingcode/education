<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
var mainFrame;
	Ext.onReady(function() {
		Order.initData(); 
		var studentId = jQuery.url.param("studentId");
		store.setBaseParam('_QUERY_n_eq_student_id', studentId);
		OrderList.loadGirdStore(store);
		mainFrame = Frame.busiPage2(formpanel, gridPanel);
	 
	});
	var studentId = jQuery.url.param("studentId");
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = OrderList.ColumnModel(sm,true);
	var formpanel = new OrderList.formpanel(studentId);
	var toolbar = new OrderList.Toolbar(formpanel, false, false,true);
	var store = new OrderList.store('Busi_OrderInfo_pageQuery.action');
	var gridPanel = new OrderList.gridPanel(toolbar, cm, sm, store);
</script>

<%@ include file="/common/include/html_bottom.jsp"%>