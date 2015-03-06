<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
 <%@ include file="/common/include/html_head.jsp"%> 
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
	Ext.onReady(function() {
		Order.initData();
		var studentId = jQuery.url.param("studentId"); 
		var sm = new Ext.grid.CheckboxSelectionModel();
		var cm = OrderList.ColumnModel(sm); 
		var store = new OrderList.store('Busi_OrderInfo_pageQuery.action');
		var gridPanel = new OrderList.gridPanel(null, cm, sm, store);
		store.setBaseParam('start',0); 
		store.setBaseParam('limit',20); 
		store.setBaseParam('_QUERY_n_eq_student_id',studentId);  
		store.setBaseParam('_ORDERBY','order by create_time desc');     
		store.reload(); 
		 
		Frame.editPage(gridPanel);
	});
</script>

<%@ include file="/common/include/html_bottom.jsp"%>