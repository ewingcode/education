<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%>  
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
  var studentId ;
  var yesornoStore;
   var ds;
   Ext.onReady(function() {  
   studentId = jQuery.url.param("studentId");  
   yesornoStore = new SysParam.store("YESORNO");
   
  
   
  
   ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy( {
			url : 'Busi_OrderExchange_findStudentExchange.action?studentId='+jQuery.url.param("studentId") 
		}),
      reader : new Ext.data.JsonReader( {
  		root : 'result',
  		totalProperty : 'totalProperty',
  		remoteSort : true,
  		fields : [ 
  		   { name : "id", type : "int" }, 
  		"orderId", "userId", "content", "orderAttachId", 
		{name:"createTime" , type : "date", mapping : 'createTime.time',dateFormat : 'time'} ]
      })
     
  });
   
  ds.load({params:{start:0, limit:10, studentId:jQuery.url.param("studentId")}}); 



  var expander = new Ext.ux.grid.RowExpander({
        tpl : new Ext.Template(
            '<p><b>内容:</b> {content}</p><br>'
        )
    });

    var grid1 = new Ext.grid.GridPanel({
        store: ds,  
         bbar: new Ext.PagingToolbar({
          store: ds,
          pageSize: 10,
          displayInfo: true,
          displayMsg : ' 合共  {2} 条记录，正在显示第 {0} 到 {1} 的记录 ',
  		  emptyMsg : "没有记录"
      }),
        cm: new  Ext.grid.ColumnModel({
            defaults: { 
                sortable: true
            },
            columns: [
                expander,
                {id:'orderId',header: "签单编号", width: 40, dataIndex: 'orderId'}, 
                {header: "内容",width: 150, dataIndex: 'content'},
                {header: "编辑人", renderer: function(value) {return SysUser.translate(value);},dataIndex: 'userId'},
                {header: "创建时间", renderer: function(value) {return  new Date(value).format('Y-m-d H:i:s');},dataIndex: 'createTime'},
                {header: "附件查看",
                 renderer: function(value) {
                   var attachData =  Order.getAttachData(value); 
                    if(attachData!=null)
                 		return  '<a href=# onclick="Order.filePreview(\'' + attachData.path
										+ '\')">'+attachData.name+'</a>';
                 	},
                  dataIndex: 'orderAttachId'}
                  
            ]
        }),
        viewConfig: {
            forceFit:true
        },        
        width: 600,
        height: 400,
        plugins: expander,
        collapsible: false,
        animCollapse: false,
        title: '交流记录',
        iconCls: 'icon-grid',
        renderTo: document.body
    }); 
  Frame.editPage(  grid1); 
});
var removeData = function(b) { 
	Ext.Msg.confirm("信息确认", "您确认要删除该记录吗？", function(c) {
		if (c == "yes") {
			Ext.Ajax.request( {
				url : "Busi_OrderExchange_delete.action",
				params : {
					id : b
				},
				method : "post",
				success : function() {
					Ext.Msg.show( {
						title : '编辑',
						msg : '成功删除记录',
						buttons : Ext.MessageBox.OK,
						icon : Ext.Msg.INFO
					});
					reload();
				}, 
				failure : function() {
					 Ext.MessageBox.show( {
						title : "操作信息",
						msg : "信息保存出错，请联系管理员！",
						buttons : Ext.MessageBox.OK,
						icon : "ext-mb-error"
					}); 
				}
			});
		}
	});
};

 function reload(){  
		store.setBaseParam('start',0); 
		store.setBaseParam('limit',20); 
		store.setBaseParam('studentId',studentId);  
		store.setBaseParam('_ORDERBY','order by create_time desc');     
		store.reload();  
 }
 
</script>
 
 
<%@ include file="/common/include/html_bottom.jsp"%>