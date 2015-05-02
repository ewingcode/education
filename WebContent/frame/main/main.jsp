<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<link rel="stylesheet" type="text/css" href="layout-browser.css" />
<%@ include file="/common/include/html_head.jsp"%>
<script type="text/javascript"> 
    var treeId=1;
      
	function addMenu(title,menuId) {  
		var menuArea = Ext.getCmp('menuArea');
		var url ='system/menuList.action?menuId='+menuId; 
		var treePanel = new Ext.tree.TreePanel( {
			id : 'tree-panel'+(treeId++), 
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
			}),
			root : new Ext.tree.AsyncTreeNode()
		});
		// 加载页面
			var businessArea = Ext.getCmp('businessArea');
		businessArea.add(
							{
								id : 'business_welcome',
								title : '欢迎登陆',
								height:800,
								autoWidth:true,
								iconCls : 'tabs',
								  html : '<iframe  src="welcome.jsp" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>',
								closable : true,
								items : [    ]
							}).show();
		// Assign the changeLayout function to be called on tree node click. 
			treePanel
					.on(
							'click',
							function(n) { 
								var treeId = n.id;
								if(!n.attributes.hrefTarget)return
								var menuUrl=_contextPath+n.attributes.hrefTarget;  
								var treeName = n.text; 
								var businessArea = Ext.getCmp('businessArea');
								var tab_id = 'business_tab_' + treeId;
								//Ext.log('tab_id:' + tab_id);
								//Ext.log('menuUrl:' + menuUrl);
								if (!businessArea.getItem(tab_id)) {
								 
									businessArea
											.add(
													{
														id : 'business_tab_' + treeId,
														title : treeName,
														height:800,
														autoWidth:true,
														iconCls : 'tabs',
														  html : '<iframe  src="'+menuUrl+'" frameborder="0"   scrolling="yes" id="setframe"  name="setframe" width="100%" height="100%"/>',
														closable : true,
														items : [    ]
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
												html : '<div id="header"><h1>华实教育办公系统</h1></div>'
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
										 enableTabScroll:true,
										id : 'businessArea',
										border : false, // already wrapped so don't add another border
										activeTab : 1, // second tab initially active
										tabPosition : 'top'
									})
								}, {
									region : 'west',
									id : 'menuArea',
									split : true, 
									collapsible: true,
									width : 200,
									minSize : 175,
									maxSize : 400,
									margins : '0 0 0 5',
									layout : {
										type : 'accordion',
										animate : true
									},
									items : [ ]
								}, {
					                // lazily created panel (xtype:'panel' is default)
					                region: 'south',
					                // contentEl: 'south', 
					                height: 50,
					                minSize: 50,
					                maxSize: 200,
					                collapsible: true, 
					                margins: '0 0 0 0' ,
					                items:[tb] 
					                
					            }]
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
			 
			Ext.get('styleswitcher_select').on('change',function(e,select){ 
		        var name = select[select.selectedIndex].value; 
		       	Ext.util.CSS.swapStyleSheet('theme', _contextPath+'/resources/css/xtheme-'+name+'.css');
		    }); 
		    initNoticeListen();
		});
		 
	   function initNoticeListen() {  
			p_join_listen('/notice');
  		} 
 
		// Event Callback: display all events
		function onEvent(event) {    
		      var notReadCount = event.get("notice_"+session_userId+"_notreadcount");
		    
		      var shapeCls = "notice_red"; 
		      var shapeTarget= $("#messageId") ; 
		      if(notReadCount == 'undefined' || notReadCount == undefined){
		    	  notReadCount=0;
		      } 
		      //console.log('notReadCount:'+notReadCount);
		      if(notReadCount>0 ){
		              Ext.getCmp("messageId").setText("("+notReadCount+")"); 
			          if(isShaking)
			             return;  
					  shake(shapeTarget);
			  }else{ 
			         clearInterval(timeInterval);
					 shapeTarget.removeClass(shapeCls);
					 isShaking =false;
					 Ext.getCmp("messageId").setText("("+notReadCount+")");
					 
			  }
		}
		
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
         
		
var timeInterval=null; 	
var isShaking=false;
function shake(ele){
	var i = 0,  c ="",times=times||2;
	if(isShaking) return;
	isShaking =true;
	timeInterval= setInterval(function(){
			i++;
			c = i%2 ? "notice_black": "notice_red";  
			 
			 var messageIdClass = $("#messageId").attr("class");
                  if(messageIdClass.indexOf("notice_black")>-1){
                       Ext.getCmp("messageId").removeClass("notice_black");
                  }else if( messageIdClass.indexOf("notice_red")>-1){
                        Ext.getCmp("messageId").removeClass("notice_red");
                  }
                  
            Ext.getCmp("messageId").addClass(c);
		},1000);
};
 </script>


<div id="south" class="x-hide-display">
	 
	    <img alt="" src="../../images/message.png"> <label >
			未读消息:
	    </label>[ <label id="notreadmessage" style="width: 10" >0</label>]

	     <form id="styleswitcher" style="display: none">
	     
		<label for="styleswitcher_select">
			界面:
		</label>
		<select name="styleswitcher_select" id="styleswitcher_select" style="width: 100px">
			<option value="gray" selected="true">
				默认灰色
			</option>
			<option value="blue">
				蓝色
			</option>
			<option value="access">
				深蓝
			</option> 
		</select>
		
	</form> 
	 
</div>
<%@ include file="/common/include/html_bottom.jsp"%>
