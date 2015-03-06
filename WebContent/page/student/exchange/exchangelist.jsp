<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%> 
<c:set var="_jsFiles" value="${_cp}/page/personal/exchange/edit.js"/>  
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script> 
  var studentId ;
  var yesornoStore;
   var ds;
Ext.onReady(function() {  
   studentId = jQuery.url.param("studentId");  
   yesornoStore = new SysParam.store("YESORNO");
   
  
   var toolbar = new Ext.Toolbar({ 
        items   : [ 
            {
                text: '编写新的评价',
                iconCls: 'btn_add',
                handler:function(){
                	new EditWindow(studentId);
                }
            } 
        ]
    });
  
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
  		"orderId", "userId", "content", "orderAttachId" ]
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
                width: 20,
                sortable: true
            },
            columns: [
                expander,
                {id:'orderId',header: "签单编号", width: 40, dataIndex: 'orderId'}, 
                {header: "内容",width: 80, dataIndex: 'content'},
                {header: "编辑人", renderer: function(value) {return SysUser.translate(value);},dataIndex: 'userId'},
                {header: "附件查看",
                 renderer: function(value) {
                   var attachData =  Order.getAttachData(value);
                    if(attachData!=null)
                 	return '<button  onclick="Order.filePreview(\'' + attachData.path
						+ '\')">'+attachData.name+'</button>';
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
 function reload(){
   ds.load({params:{start:0, limit:10, studentId:jQuery.url.param("studentId")}}); 
 }
 
</script>
 
 
<%@ include file="/common/include/html_bottom.jsp"%>