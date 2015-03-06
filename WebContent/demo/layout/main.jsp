<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="CenterLayout.css" />
<link rel="stylesheet" type="text/css" href="layout-browser.css" />
<%@ include file="/common/include/html_head.jsp"%>
<script type="text/javascript">
	function addMenu(title,menuId) { 
		var menuArea = Ext.getCmp('menuArea');
		var url ='system/menuList.action?menuId='+menuId;
		 
		var treePanel = new Ext.tree.TreePanel( {
			id : 'tree-panel', 
			layout : 'fit',
			split : true,
			height : 1200,
			minSize : 150,
			autoScroll : true,

			// tree-specific configs:
			rootVisible : false,
			lines : false,
			singleExpand : true,
			useArrows : true, 
			loader : new Ext.tree.TreeLoader( { 
					dataUrl : url 
					//baseParams :{ menuId :menuId }
			}),
			root : new Ext.tree.AsyncTreeNode()
		});
		// Assign the changeLayout function to be called on tree node click.
		treePanel
					.on(
							'beforeclick',
							function(n) {
								
							   n.href=_contextPath + '/demo/gird/griddata.jsp';
							   n.hrefTarget= "setframe";
							});
			treePanel
					.on(
							'click',
							function(n) { 
								var treeId = n.id;
								var menuUrl=_contextPath+n.attributes.hrefTarget;  
								var treeName = n.text; 
								var businessArea = Ext.getCmp('businessArea');
								var tab_id = 'business_tab_' + treeId;
								Ext.log('menuUrl:' + menuUrl);
								if (!businessArea.getItem(tab_id)) {
									Ext
											.log('add tab for tree node[' + treeId + ']');
									businessArea
											.add(
													{
														id : 'business_tab_' + treeId,
														title : treeName,
														iconCls : 'tabs',
														html : '<iframe  src="'+menuUrl+'" frameborder="0" scrolling="yes" id="setframe" name="setframe" width="100%" height="100%"/>',
														closable : true,
														items : []
													}).show();
								}else{
									businessArea.getItem(tab_id).show();
								}
 

							});
		
		menuArea.add( {
			title : title,
			border : false,
			iconCls : 'settings3',
			items : [treePanel]
		});
		menuArea.doLayout();
	}
	 
	Ext.onReady(function() {

		Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
		

			var viewport = new Ext.Viewport(
					{
						layout : 'border',
						items : [
						// create instance immediately
								new Ext.BoxComponent(
										{
											region : 'north',
											height : 32, // give north and south regions a height
											autoEl : {
												tag : 'div',
												html : '<div id="header"><h1>OA System</h1></div>'
											}
										}), {
									region : 'center',
									split : true,
									width : 225, // give east and west regions a width
									minSize : 175,
									maxSize : 400,
									margins : '0 5 0 0',
									layout : 'fit', // specify layout manager for items
									items : // this TabPanel is wrapped by another Panel so the title will be applied
									new Ext.TabPanel( {
										id : 'businessArea',
										border : false, // already wrapped so don't add another border
										activeTab : 1, // second tab initially active
										tabPosition : 'top'
									})
								}, {
									region : 'west',
									id : 'menuArea',
									split : true,
									width : 200,
									minSize : 175,
									maxSize : 400,
									margins : '0 0 0 5',
									layout : {
										type : 'accordion',
										animate : true
									},
									items : [ ]
								} ]
					});

			var moduleTreeData = new Ext.data.Store( {
				proxy : new Ext.data.HttpProxy( {
					url : 'system/moduleList.action'
				}),
				reader : new Ext.data.JsonReader( {
					fields : [ 'id', 'text' ]

				})
			});
			moduleTreeData.load(); 
			moduleTreeData.on('load', function(store, records) {
				store.each(function(rec) {
					addMenu(rec.get('text'),rec.get('id'));
				});
			});
		});
</script>

<!-- use class="x-hide-display" to prevent a brief flicker of the content -->
<div id="west" class="x-hide-display">
	<p>
		Hi. I'm the west panel.
	</p>
</div>

<div id="south" class="x-hide-display">
	<p>
		south - generally for informational stuff, also could be for status
		bar
	</p>
</div>
<%@ include file="/common/include/html_bottom.jsp"%>
