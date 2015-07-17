Ext.onReady(function() {
	Order.initData();
	OrderList.loadGirdStore(store);
	mainFrame = Frame.busiPage2(formpanel, gridPanel);
});
function closeTabPanel(orderId) {
	mainFrame.remove("busi_tab_order_" + orderId);
}
var mainFrame;
var sm = new Ext.grid.CheckboxSelectionModel();
var sm = new Ext.grid.CheckboxSelectionModel();
var cm = OrderList.ColumnModel(sm);
var formpanel = new OrderList.formpanel(); 
var toolbar = new OrderList.Toolbar(formpanel, true, false,true,false,true,true,true,true);
var store = new OrderList.store('Busi_OrderInfo_findPersonalTasksHis.action');
var gridPanel = new OrderList.gridPanel(toolbar, cm, sm, store);
