Ext.ns("Common");
Common.Message = function() {
	var msgCt;

	function createBox(t, s) {
		return [
				'<div class="msg-div">',
				'<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
				'<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>',
				t,
				'</h3>',
				s,
				'</div></div></div>',
				'<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
				'</div>' ].join('');
	}
	return {
		msg : function(title, format) {
			if (!msgCt) {
				msgCt = Ext.DomHelper.insertFirst(document.body, {
					id : 'msg-div'
				}, true);
			}
			var s = String.format.apply(String, Array.prototype.slice.call(
					arguments, 1));
			var m = Ext.DomHelper.append(msgCt, {
				html : createBox(title, s)
			}, true);
			m.slideIn('t').pause(1).ghost("t", {
				remove : true
			});
		},

		init : function() {
			var lb = Ext.get('lib-bar');
			if (lb) {
				lb.show();
			}
		}
	};
}();

Common.ErrMegBox =function(message){
	Ext.MessageBox.show( {
		title : "操作信息",
		msg : message,
		buttons : Ext.MessageBox.OK,
		icon : "ext-mb-error"
	}); 
};

Common.SucMegBox =function(message){
	Ext.MessageBox.show( {
		title : "操作信息",
		msg : message,
		buttons : Ext.MessageBox.OK,
		icon : Ext.Msg.INFO
	}); 
};
Common.SingleCheck=function(gridPanel){
if(gridPanel.getSelectionModel().getCount()!=1){
	Common.ErrMegBox('请选择一项进行操作');
	return false;
	}
return true;
};