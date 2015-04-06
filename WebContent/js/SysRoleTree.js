Ext.ns("SysRoleTree");

SysRoleTree.viewWin = function(singleCheck, parentSelectId,
		parentSelectUserName, roleIds, frameId) {
	var _frameId = frameId != null ? frameId : 'frameId1';
	var url = _contextPath + '/page/system/role/roletree.jsp?singleCheck='
			+ singleCheck;
	url += '&roleIds=' + roleIds;
	url += '&parentSelectUserName=' + parentSelectUserName;
	url += '&parentSelectId=' + parentSelectId;
	var win = new Ext.Window({
		id : "orgStructForm",
		title : '负责人',
		width : 580,
		height : 500,
		minWidth : 500,
		minHeight : 300,
		layout : 'fit',
		autoScroll : true,
		plain : true,
		bodyStyle : 'padding:5px;',
		buttonAlign : 'center',
		items : [ {
			html : '<iframe  src="' + url
					+ '" frameborder="0"   scrolling="yes"  name="' + _frameId
					+ '"  id="' + _frameId + '" width="100%" height="100%"/>'
		} ],
		buttons : [ {
			text : "确定",
			iconCls : "btn_accept",
			handler : function() {
				document.frames(_frameId).window.confirm();
				win.close();
			}
		}, {
			text : "取消",
			iconCls : "btn_cancel",
			handler : function() {
				win.close();
			}
		} ]
	});
	win.show();

}
