<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%> 
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
  <style type="text/css">
        .tip-target {
            width: 100px;
            text-align:center;
            padding: 5px 0;
            border:1px dotted #99bbe8;
            text-align:left;
            background:#dfe8f6;
            color: #15428b;
            cursor:default;
            margin:10px;
            font:bold 11px tahoma,arial,sans-serif;
            float:left;
        }
    </style>
<script>
Ext.chart.Chart.CHART_URL = '../../resources/charts.swf';

Ext.onReady(function(){ 
	var sexTypeStore = new SysParam.store("SEXTYPE"); 
	var url = "Public_Common_noMappedObjectQuery.action?sql=select * from order_info_daily order by create_date  limit 7";
	 var arrayStore = new Ext.data.ArrayStore({
	        fields: [
	           {name: 'create_date'},
	           {name: 'total'}
	        ]
	    }); 

	 var store = new Ext.data.Store( {
			// autoLoad : true,//是否自动加载
			proxy : new Ext.data.HttpProxy( {
				url : url
			}),
			reader : new Ext.data.JsonReader( {
				root : 'result',
				totalProperty : 'totalProperty',
				remoteSort : true,
				fields : [  
				 "create_date", "total" ]
			})
		});
	 store.reload();

	 
	 var taskCount=0;
	 var taskHisCount=0;
	 var noReadNoticeCount=0;
	 Ajax.syncRequest('Busi_OrderInfo_findPersonalTasks.action?start=0&limit=10',  
			 function(data) {  
			if(data) 
				taskCount = data.totalProperty; 
	 	}
	  );  
	 Ajax.syncRequest('Busi_OrderInfo_findPersonalTasksHis.action?start=0&limit=10',  
			 function(data) {  
		 	if(data) 
			 taskHisCount = data.totalProperty; 
	 	}
	  );  
	 Ajax.syncRequest('Busi_Notice_pageQuery.action?start=0&limit=10&_QUERY_n_eq_receiver_id='+session_userId+'&_QUERY_s_eq_status=0',  
			 function(data) {  
		 	if(data) 
		 		noReadNoticeCount = data.totalProperty; 
	 	}
	  );  
	
	  // extra extra simple
 
    var tb = new Ext.Toolbar({
         height: 100,
         items:[
         {
            text:'个人中心'  
        },'-',
        {
            text:'操作员：'+session_userName,
            iconCls: 'usercenter'  
        } ,
        '-', 
        {
            text:'公告消息:', 
            iconCls: 'notice_pic'  
        } , 
		{ 
            id:'messageId',
            text: '(0)' ,
            cls:"notice_black"
        } ,'-',
         {
            text:'退出',
             handler:function(){ 
               Ext.Msg.confirm("信息确认", "您确认退出系统吗？",function(c){
               if (c == "yes") 
               window.location.href="Public_Login_userLogOut.action";
               }); 
         	}   
        } 
         ]
	    });
    var table = {
    	    id: 'table-panel', 
    	    layout: 'table',
    	    width:500,
            height:300, 
            autoScroll:true,
    	    layoutConfig: {
    	        columns: 2
    	    },
    	    defaults: {
    	        bodyStyle:'padding:15px 20px'
    	    },
    	    items: [{
    	        title: '个人中心',
    	        width:380,
    	        height:250,
    	       html: '<p  class="tip-target" style="width: 320px;">用户名称：'+session_userName+'</p><br />'
    	             +'<p class="tip-target" style="width: 320px;">角 &nbsp; &nbsp;色：'+SysRole.translate(session_roleId)+'</p><br /> '
    	             +'<p class="tip-target" style="width: 320px;">部 &nbsp; &nbsp;门：'+Department.translate(session_depId)+'</p><br /> '
    	             +'<p class="tip-target" style="width: 320px;">性&nbsp; &nbsp;别：'+SysParam.translate(sexTypeStore,session_sex)+'</p><br /> '
    	    },{
    	        title: '工作情况',
    	        width:380,
    	        height:250, 
    	       html: '<p  class="tip-target" style="width: 320px;">未处理任务：'+taskCount+'</p><br />'
    	             +'<p class="tip-target" style="width: 320px;">已处理任务：'+taskHisCount+'</p><br />'
    	             +'<p class="tip-target" style="width: 320px;">未读公告：'+noReadNoticeCount+'</p><br />'
    	    }/* ,{
    	        title: '近15日签单统计',
    	        width:760,
    	        height:250,
    	        html: '<div id="container"></div>',
    	        colspan:2
    	    } */ ]
    	};

    new Frame.editPage(table);
    new Ext.Panel({
       // title: '签单日报表',
        renderTo: 'container',
        width:700,
        height:200,
        layout:'fit', 
        border :false,
        autoDestroy :true,
        items: {
            xtype: 'linechart',
            store: store,
            xField: 'create_date',
            yField: 'total',
			listeners: {
				itemclick: function(o){
					var rec = store.getAt(o.index);
					Ext.example.msg('Item Selected', 'You chose {1}.','总数：'+ rec.get('total'));
				}
			}
        }
    }); 
    
});


</script>
  
<%@ include file="/common/include/html_bottom.jsp"%>