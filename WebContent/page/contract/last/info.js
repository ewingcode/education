Ext.onReady(function() {
	Order.initData();
	mainFrame = Frame.busiPage2(formpanel, gridPanel);
});
function closeTabPanel(orderId) {
	mainFrame.remove("busi_tab_order_" + orderId);
}
var mainFrame;
var sm = new Ext.grid.CheckboxSelectionModel();
var cm = OrderList.ColumnModel(sm);
var formpanel = new OrderList.formpanel();
var toolbar = new OrderList.Toolbar(formpanel,false,true,true);
var store = new OrderList.store(
		'Busi_OrderInfo_pageQuery.action?condition=run_status!=0  ');
var gridPanel = new OrderList.gridPanel(toolbar, cm, sm, store);

