Ext.ns("Frame");
/**
 * 包含搜索和数据列表的界面
 */
Frame.busiPage = function(searchPanel, listPanel) {
	return new Ext.Viewport( {
		layout : 'border',
		items : [ {
			region : 'center',
			layout : 'fit',
			minSize : 175,
			maxSize : 400,
			items : [ listPanel ]
		}, {
			region : 'north',
			id : 'menuArea22',
			height : 130,
			minSize : 175,
			maxSize : 400,
			items : [ searchPanel ]
		} ]
	});
}

/**
 * 包含搜索和数据列表的界面
 */
Frame.busiPage2 = function(searchPanel, listPanel) {
	var tabPanel = new Ext.TabPanel( {
		border : false, // already wrapped so don't add another border
		activeTab : 1, // second tab initially active
		tabPosition : 'bottom'
	})
	new Ext.Viewport( {
		layout : 'border',
		items : [ {
			region : 'center',
			layout : 'fit',
			minSize : 175,
			maxSize : 400,
			items : [ tabPanel ]
		} ]
	});
	tabPanel.add( {
		title : '信息列表',
		autoWidth : true,
		autoHeight : true,
		iconCls : 'tabs',
		// closable : true,
		items : [ searchPanel, listPanel ]
	}).show();
	return tabPanel;
}

/**
 * 包含搜索和数据列表的界面
 */
Frame.editPage = function(editPanel) {
	return new Ext.Viewport( {
		layout : 'border',
		items : [ {
			region : 'center',
			minSize : 175,
			layout : 'fit',
			items : [ editPanel ]
		} ]
	});
}
/**
 * 编辑窗口
 */
Frame.editWindow = function(editPanel, height, width, title) {
	var _title = title != null ? title : "编辑";
	var _height = height != null ? height : 600;
	var _width = width != null ? width : 500;
	var win = new Ext.Window( {
		id : "editForm",
		title : _title,
		width : _width,
		height : _height,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		frame : true,
		border : false,
		// plain:true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ editPanel ]
	});
	win.show();
}

Frame.addTab = function(mainFrame,tabTitle,tab_id,showPage) {

	mainFrame
			.add(
					{
						title : tabTitle,
						id : tab_id,
						autoWidth : true,
						iconCls : 'tabs',
						closable : true,
						html : '<iframe  src="' + showPage + '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
					}).show();
}
