Ext.ns("Order");

/**
 * 提交表单类型
 */
/* {@link #SubmitType} */
var SUBMITTYPE_NOTHING = "0";
var SUBMITTYPE_APPLY_FILE = "1";
var SUBMITTYPE_UPLOAD_FILE = "2";

/**
 * 附件审批状态
 */
var STATUS_WAIT='0';
var STATUS_ACCEPT='1';
var STATUS_REJECT='2';
 
Order.getAttachData=function(orderAttachId){ 
	if(orderAttachId==null || orderAttachId ==undefined || orderAttachId==0)
		return null;
	var url = "Busi_OrderAttch_query.action?condition=id="+orderAttachId; 
	var attachData=null; 
	 Ajax.syncRequest(url,  
			 function(data) { 
		 	 if(data.result && data.result.length==1)
		 		attachData =data.result[0];
	 });   
	return  attachData ;
	
};

Order.viewFileFiled=function(orderAttachId){ 
	var isExist =orderAttachId!=null && orderAttachId !=undefined && orderAttachId>0?true:false;  
	var attachData =  Order.getAttachData(orderAttachId); 
	var filePath='';
	var fileName = '';
	if(attachData!=null){
		filePath = attachData.path;
		fileName = attachData.name;
	}
	var file = {
			xtype : 'compositefield',
			fieldLabel : '附件名称',
			hidden:isExist?false:true, 
			items : [
					{
						xtype : 'textfield', 
						width : 280,
						value : fileName,
						editable:false,
						readOnly : true
					},
					{ 
						xtype : "button",
						text : "查看",
						width : 50,
						handler : function() {
							if (filePath != '' || filePath != undefined) {
								new Order.filePreview2(filePath);
							}
						}
					}  ]
		};
	return file;
}
/**
 * 文件列表
 * 
 * @param orderId
 * @param fileTypeList
 *            文件类型 格式："1,2,3,4"
 * 
 * @return
 */
Order.fileListComp = function(orderId, fileTypeList) {
	var store = new Ext.data.Store( {
		proxy : new Ext.data.HttpProxy( {
			url : 'Busi_OrderView_showOrderAttach.action'

		}),
		reader : new Ext.data.JsonReader( {
			root : 'result',
			totalProperty : 'totalProperty',
			remoteSort : true,
			fields : [ {
				name : "id",
				type : "int"
			}, "orderId", "name","swfpath", "type", "path", "status", "commet", {
				name : "createTime",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			}, {
				name : "lastUpdate",
				type : "date",
				mapping : 'createTime.time',
				dateFormat : 'time'
			} ]
		})
	});
	store.reload( {
		params : {
			orderId : orderId,
			typeList : fileTypeList
		}
	});
	var cm = new Ext.grid.ColumnModel( {
		columns : [
				new Ext.grid.RowNumberer(),
				{
					header : "id",
					dataIndex : "id",
					hidden : true
				},
				{
					header : "文件",
					dataIndex : "name"
				},{
					header : "类型",
					dataIndex : "type",
					renderer : function(value) {
						return SysParam.translate(attachTypeStore, value);
					}
				},  {
					header : "状态",
					dataIndex : "status",
					renderer : function(value) {
						return SysParam.translate(applyStatusStore, value);
					}
				}  
				, { header : "审查", 
					dataIndex : "status",
					renderer :
					   function(value, m, rec) { 
						var status = SysParam.translate(applyStatusStore, value); 
						var path =  rec.get("path"); 
						var swfPath =  rec.get("swfpath");  
						var fileType = rec.get("type"); 
					 /*   var viewBtn = '<button id="viewBtn' + fileType + '" onclick="Order.filePreview(\'' + path
						+ '\')" height="2px" >查看</button>'; 
						*/
						 var viewBtn = '<button id="viewBtn' + fileType + '" onclick=" new Order.filePreview2(\''+swfPath+'\')" height="2px" >查看</button>';
					 
					   return viewBtn ; 
					  } 
				}
					  ],
		defaults : {
			sortable : true,
			menuDisabled : false,
			width : 100
		}
	});
	var gridPanel = new Ext.grid.EditorGridPanel( {
		id : "fileGird",
		store : store,
		region : "center",
		autoScroll : true,
		cm : cm,
		height : 150,
		clicksToEdit : 1,
		viewConfig : {
			forceFit : true,// 填满width.
			enableRowBody : true,
			showPreview : false
		}
	});

	var filePanelSet = new Ext.form.FieldSet( {
		xtype : 'fieldset',
		title : '资料',
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			layout : "form",
			defaults : {
				anchor : "100%",
				labelStyle : 'text-align:right;'
			},
			items : [ gridPanel ]
		} ]
	});
	return filePanelSet;
};
/**
 * 清空
 */
Order.resetAttach=function(){
	$("input[name^='uploadfile']").each(function(){
		var attach = $(this);
		attach.after(
				attach.clone(true).val(""));  
		attach.remove();
	} );
	
}
/**
 * 文件上传,审批,查看
 * 
 * @param fieldName
 * @param type
 * @param orderId
 * @return
 */
Order.fileUploadComp = function(fieldName, type, orderId, needModify,
		needApproval,isLastOrder,needDown) {
	var _needDown =  (needDown != null && needDown) ? true : false;
	var _needModify = (needModify != null && needModify) ? true : false;
	var _needApproval = (needApproval != null && needApproval) ? true : false;
	var _fieldName = fieldName != null ? fieldName : "上传文件";
	var _fileLookBtn = "fileLookBtn" + type;
	var _fileModfiyBtn = "fileModfiyBtn" + type;
	var _fileCancelModfiyBtn = "fileCancelModfiyBtn" + type;
	var _fileAcceptBtn = "fileAcceptBtn" + type;
	var _fileRejectBtn = "fileRejectBtn" + type;
	var _uploadfileStatus = "uploadStatus" + type + "";
	var _uploadfileStatusStr = "fileStatusStr" + type + "";
	var _uploadfileCommet = "uploadCommet" + type + "";
	var _updateFileName = "uploadName" + type;
	var _uploadfile = "uploadfile" + type;
	var _uploadTitle = "uploadTitle" + type;
	var filePath = '';
	var swfPath='';
	var fileName = '';
	var fileStatus = '';
	var _isShowStatus =false;
	var fileStatusStr = '';
	var fileCommet = '';
	var exitFile = false;
	var isReUpload=false;
	var url = 'Busi_OrderAttch_query.action?condition=order_id=' + orderId
			+ ' and type=' + type;
	
	if (orderId != null) {
		Ajax.syncRequest(url, function(data) {

			if (data.result.length > 0) {
				filePath = data.result[0].path;
				swfPath= data.result[0].swfpath;
				fileName = data.result[0].name;
				fileStatus = data.result[0].status; 
				//状态未不通过的和不要审批的就需要显示修改文件的按钮
				if(fileStatus==STATUS_REJECT && !_needApproval){
					isReUpload=true;
					_needModify=true;
				}
				//状态未已经审批通过的，不再需要审批
				 if(fileStatus==STATUS_ACCEPT ){
					_needApproval=false;
					_needModify=false;
				}  
				 if(fileStatus!=''){
					 _isShowStatus=true;
				 }
				 //续单的时候，需要选择老师
				if(isLastOrder==true){ 
					_needModify=true;
					_isShowStatus=false;
				}  
				$("#" + _uploadfileStatus).val(fileStatus); 
				fileCommet = data.result[0].commet;
				fileStatusStr = SysParam
						.translate(applyStatusStore, fileStatus);
				exitFile = true;
			}
		});
	}
	var file = {
		xtype : 'compositefield',
		fieldLabel : '文档名称',
		hidden : !exitFile,
		items : [
				{
					xtype : 'textfield',
					id : _updateFileName,
					width : 300,
					value : fileName,
					readOnly : true
				},
				{
					id : _fileLookBtn,
					xtype : "button",
					text : "查看",
					width : 50,
					handler : function() {
						if (swfPath != '' || swfPath != undefined) {
							//new Order.filePreview(filePath);
							 new Order.filePreview2(swfPath);
						}
					}
				},
				{ 
					xtype : "button",
					text : "下载",
					hidden: !_needDown,
					width : 50,
					handler : function() {
						  new Order.fileDown(filePath); 
					}
				},
				{
					id : _fileModfiyBtn,
					xtype : "button",
					text : "修改",
					hidden : !_needModify,
					width : 50,
					handler : function() {
						Public.toggleClick($("#" + _fileModfiyBtn), $("#"
								+ _fileCancelModfiyBtn));
						Ext.getCmp(_uploadfile).show();
					}
				},
				{
					id : _fileCancelModfiyBtn,
					xtype : "button",
					text : "取消",
					//disabled :true,
					hidden : !_needModify,
					width : 50,
					handler : function() { 
					   if($("#"+_fileModfiyBtn).attr("disabled")== true ){ 
						Public.toggleClick($("#" + _fileCancelModfiyBtn), $("#"
								+ _fileModfiyBtn)); 
						$('#' + _uploadfile).after(
								$('#' + _uploadfile).clone(true).val("")); // 复制对象并清空值[FF]
						$('#' + _uploadfile).remove();
						Ext.getCmp(_uploadfile).hide();
					   }
					}
				},
				{
					id : _fileAcceptBtn,
					xtype : "button",
					text : "通过",
					hidden : !_needApproval,
					width : 50,
					handler : function() {
						Public.toggleClick($("#" + _fileAcceptBtn), $("#"
								+ _fileRejectBtn));
						$("#" + _uploadfileStatus).val(STATUS_ACCEPT);
						$("#"+_uploadfileStatusStr).val('通过');
						Public.hideField(_uploadfileCommet);
					}

				},
				{
					id : _fileRejectBtn,
					xtype : "button",
					text : "不通过",
					hidden : !_needApproval,
					width : 50,
					handler : function() {
						Public.toggleClick($("#" + _fileRejectBtn), $("#"
								+ _fileAcceptBtn));
						$("#" + _uploadfileStatus).val(STATUS_REJECT);
						$("#"+_uploadfileStatusStr).val('不通过');
						Public.showField(_uploadfileCommet);
					}

				}, {
					id : _uploadfileStatus,
					xtype : "textfield",
					hidden : true,
					value:fileStatus
				} ]
	};
	var fileUpload = {
		xtype : 'textfield',
		inputType : 'file',
		hidden : exitFile,
		width : 500,
		id : _uploadfile,
		// emptyText : '请选择',
		name : _uploadfile,
		buttonCfg : {
			iconCls : 'upload-icon'
		}
	};

	var fileCommet = {
		fieldLabel : '审批意见',
		xtype : 'textfield',
		width : 500,
		hidden : fileCommet !=''?false:true,
		id : _uploadfileCommet,
		value : fileCommet,
		allowBlank : true
	};
	var statusField = {
		id:_uploadfileStatusStr,
		fieldLabel : '审批状态',
		xtype : 'textfield',
		hidden : !_isShowStatus,
		readOnly : true,
		width : 150,
		value : fileStatusStr
	};

	var field = new Ext.form.FieldSet( {
		title : fieldName,
		layout : "column",
		items : [ {
			xtype : "container",
			columnWidth : 1,
			defaultType : "textfield",
			layout : "form",
			defaults : {
				// anchor : "100%",
			labelStyle : 'text-align:right;'
		},
		items : [ {
			xtype : 'textfield',
			id : _uploadTitle,
			hidden : true,
			value : fieldName
		},  file, fileUpload, statusField, fileCommet ]
		} ]
	});
	return field;
};

/**
 * 文件预览
 * 
 * @param fileUrl
 * @return
 */
Order.filePreview = function(fileUrl) {
	fileUrl = _contextPath+"/"+fileUrl;
	var win = new Ext.Window(
			{
				id : "filePreview",
				title : '文件预览',
				width : 700,
				height : 500,
				minWidth : 500,
				minHeight : 300,
				layout : 'fit',
				plain : true,
				bodyStyle : 'padding:5px;',
				buttonAlign : 'center',
				items : [ {
					html : '<iframe  src="' + fileUrl + '" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>'
				} ],
				buttons : [ {
					text : "关闭",
					iconCls : "btn_cancel",
					handler : function() {
						win.close();
					}
				} ]
			});
	win.show();
};

/**
 * SWF文件预览
 * 
 * @param fileUrl
 * @return
 */
Order.filePreview2 = function(fileUrl) {
	if(fileUrl==undefined || fileUrl=='' || fileUrl==null){
		Common.ErrMegBox('文档正在处理中，请稍候查看');
		return;
	}
	fileUrl = _contextPath+"/"+fileUrl; 
	var win = new Ext.Window(
			{
				id : "filePreview",
				title : '文件预览',
				width : 800,
				height : 500,
				minWidth : 500,
				minHeight : 300,
				layout : 'fit',
				plain : true,
				//autoScroll :true,
				bodyStyle : 'padding:5px;',
				buttonAlign : 'center',
				items : [ {
					html : '  <embed src="'+fileUrl+'" width="750" height="450"></embed>'
				} ],
				buttons : [ {
					text : "关闭",
					iconCls : "btn_cancel",
					handler : function() {
						win.close();
					}
				} ]
			});
	win.show();
};

/**
 *  文件下载
 * 
 * @param fileUrl
 * @return
 */
Order.fileDown = function(fileUrl) {
	if(fileUrl==undefined || fileUrl=='' || fileUrl==null){
		Common.ErrMegBox('文档正在处理中，请稍候查看');
		return;
	} 
	window.location="file/fileAction.action?downTargetPath="+fileUrl;
};
/**
 * 验证课程信息
 * 
 */
Order.validateAttach = function(oper) {
	var ret = true;  
	if (oper == SUBMITTYPE_UPLOAD_FILE) {
		$("input[name^='uploadfile']").each(function() { 
			var input = $(this);
			var val = jQuery.trim(input.val());
			var inputName = input.attr('id');
			var fileType = inputName.replace('uploadfile', ''); 
			var status= $("#uploadStatus"+fileType).val();
			var fileTypeName = $("#uploadTitle" + fileType).val();
			if (val == '' && !(STATUS_REJECT ==status || STATUS_ACCEPT ==status)) {
				Common.ErrMegBox('请上传' + fileTypeName + '！');
				ret = false;
				return false;
			}
		});
	} else if (oper == SUBMITTYPE_APPLY_FILE) {
		$("input[name^='uploadStatus']").each(
				function() {
					var input = $(this);
					var val = jQuery.trim(input.val());
					var inputName = input.attr('id');
					var fileType = inputName.replace('uploadStatus', '');
					var fileTypeName = $("#uploadTitle" + fileType).val();
					if (val == ''|| !(STATUS_REJECT ==val || STATUS_ACCEPT ==val)) {
						Common.ErrMegBox('请对' + fileTypeName + '的文档进行审批！');
						ret = false;
						return false;
					}
				});
	} 
	return ret;
 
};
/**
 * 判断是否有不通过的审批
 */
Order.existNotPassAttach=function(){
	var ret=false;
	$("input[name^='uploadStatus']").each(
			function() {
				var input = $(this);
				var val = jQuery.trim(input.val()); 
				if(val==STATUS_REJECT){
					ret=true;
					return true;
				} 
			});
	return ret;
};
 