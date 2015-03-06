Ext.onReady(function() {
	var moduleTreeData = new Ext.data.Store( {
		autoLoad : true,
		proxy : new Ext.data.HttpProxy( {
			url : 'test/queryuserInfo.action'
		}),
		reader : new Ext.data.JsonReader( {
			fields : [ 'id', 'name', 'address' ]
		})
	});
	var myGrid = new Ext.grid.GridPanel({
		frame: true,
	    title: 'Framed with Row Selection and Horizontal Scrolling',
	    iconCls: 'icon-grid',

		title : "我的表格",
		store : moduleTreeData,
		//width : 400,
		height : 250,
		columns : [ {
			header : "id",
			sortable : true,
			resizable : true,
			dataIndex : "id"
			//width : 100
		}, {
			header : "name",
			sortable : true,
			resizable : true,
			dataIndex : "name"
			//width : 100
		}, {
			header : "address",
			sortable : true,
			resizable : true,
			dataIndex : "address"
			//width : 100
		} ]

	});
	 
	myGrid.render('grid-example');
});