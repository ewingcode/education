
Ext.onReady(function() {

	Ext.MyWindow = Ext.extend(Ext.Window, {
		xtype : "window",
		title : "我的窗口",
		width : 400,
		height : 250,
		layout : "border",
		initComponent : function() {
			this.items = [ {
				xtype : "combo",
				triggerAction : "all",
				fieldLabel : "标签",
				emptyText:'请选',
				region : "center",
				valueField : "paramValue",
				displayField : "paramName",
				store : {
					xtype : "jsonstore",
					autoLoad : false,
					url : "public/SysParam_queryByRootCode.action?rootCode=SEXTYPE",
					root : "result",
					fields : [ 'paramName', 'paramValue' ]
				}
			} ]
			Ext.MyWindow.superclass.initComponent.call(this);
		}
	})
	var myWin = new Ext.MyWindow( {});
	myWin.show();
});