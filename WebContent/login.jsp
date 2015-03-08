<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>
<%@ include file="/common/include/html_head.jsp"%>
 <script type="text/javascript">
	var LoginWin = function(b, g) {
		this.isCodeEnabled = b;
		this.isDyPwdEnabled = g;
		var a = new Ext.form.FormPanel( {
			id : "LoginFormPanel",
			bodyStyle : "padding-top:6px",
			defaultType : "textfield",
			columnWidth : 0.75,
			labelAlign : "right",
			labelWidth : 55,
			labelPad : 0,
			border : false,
			layout : "form",
			defaults : {
				style : "margin:0 0 0 0",
				anchor : "90%,120%",
				selectOnFocus : true
			},
			items : [ {
				name : "username",
				fieldLabel : "账      号",
				//	cls : "text-user",
				allowBlank : false,
				blankText : "账号不能为空"
			}, {
				name : "password",
				fieldLabel : "密      码",
				allowBlank : false,
				blankText : "密码不能为空",
				cls : "text-lock",
				inputType : "password"
			}, {
				name : "checkCode",
				id : "checkCode",
				fieldLabel : "验证码",
				allowBlank : false,
				hidden : true,
				cls : "text-code",
				blankText : "验证码不能为空"
			}, {
				name : "curDynamicPwd",
				//hidden : true,
				id : "curDynamicPwd",
				fieldLabel : "令     牌",
				cls : "text-dynamic",
				blankText : "令牌不能为空"
			}, {
				xtype : "container",
				id : "codeContainer",
				layout : "table",
				defaultType : "textfield",
				hideLabel : false,
				layoutConfig : {
					columns : 3
				}
			}, {
				xtype : "container",
				style : "padding-left:57px",
				layout : "column",
				hidden : true,
				items : [ {
					xtype : "checkbox",
					name : "_spring_security_remember_me",
					boxLabel : "让系统记住我 "
				} ]
			} ]
		});
		if (this.isCodeEnabled != "undefined" && this.isCodeEnabled != ""
				&& this.isCodeEnabled != "1" || this.isCodeEnabled == "close") {
			a.remove(Ext.getCmp("checkCode"));
		} else {
			Ext.getCmp("checkCode").show();
			var d = [
					{
						width : 150,
						xtype : "label",
						text : "          "
					},
					{
						width : 200,
						id : "loginCode",
						xtype : "panel",
						border : false,
						html : '<img border="0" height="30" width="200" src="' + _contextPath + '/CaptchaImg"/>'
					}, {
						width : 55,
						xtype : "panel",
						border : false,
						bodyStyle : "font-size:12px;padding-left:12px",
						html : '<a href="javascript:refeshCode()">看不清</a>'
					} ];
			var f = Ext.getCmp("codeContainer");
			f.add(d);
			f.doLayout();
		}
		if (this.isDyPwdEnabled != "undefined" && this.isDyPwdEnabled != ""
				&& this.isDyPwdEnabled != "1" || this.isDyPwdEnabled == "close") {
			a.remove(Ext.getCmp("curDynamicPwd"));
		} else {
			Ext.getCmp("curDynamicPwd").show();
		}
		var e = function() {
			if (a.form.isValid()) {
				a.form.submit( {
					waitTitle : "请稍候",
					waitMsg : "正在登录......",
					url : 'Public_Login_debugLogin.action',
					success : function(h, i) {
						handleLoginResult(i.result);
					},
					failure : function(h, i) {
						handleLoginResult(i.result);
						h.findField("password").setRawValue("");
						h.findField("username").focus(true);
					}
				});
			}
		};
		var c = new Ext.Window(
				{
					id : "LoginWin",
					title : "用户登录",
					iconCls : "login-icon",
					bodyStyle : "background-color: white",
					border : true,
					closable : false,
					resizable : false,
					buttonAlign : "center",
					height : 200,
					width : 450,
					layout : {
						type : "vbox",
						align : "stretch"
					},
					keys : {
						key : Ext.EventObject.ENTER,
						fn : e,
						scope : this
					},
					items : [ {
						xtype : "panel",
						border : false,
						layout : "column",
						items : [
								a,
								{
									xtype : "panel",
									border : false,
									columnWidth : 0.25,
									html : '<img src="' + _contextPath + '/images/login-user.jpg"/>'
								} ]
					} ],
					buttons : [ {
						text : "登录",
						iconCls : "btn-login",
						handler : e.createDelegate(this)
					}, {
						text : "重置",
						iconCls : "btn-login-reset",
						handler : function() {
							a.getForm().reset();
						}
					} ]
				});
		 return c;
		 
	};
	function handleLoginResult(a) {
		if (a.success) {
			Ext.getCmp("LoginWin").hide();
			var b = new Ext.ProgressBar( {
				text : "正在登录..."
			});
			b.show();
			window.location.href = _contextPath + "/frame/main/main.jsp";
		} else {
			Ext.MessageBox.show( {
				title : "操作信息",
				msg : a.retinfo,
				buttons : Ext.MessageBox.OK,
				icon : "ext-mb-error"
			});

		}
	}
	function refeshCode() {
		var a = Ext.getCmp("loginCode");
		a.body.update('<img border="0" height="30" width="150" src="'
				+ _contextPath + "/CaptchaImg?rand=" + Math.random() + '"/>');
	}
	function toSuggestBox() {
		window.open(_contextPath + "/info/suggest.do", "_blank");
	}
	Ext.onReady(function() {
		Ext.QuickTips.init();
		window.status="";
		 new LoginWin(1, 2).show();  
		 
	});
</script>
<style>
 
#header { 
  background: #7F99BE url(frame/main/images/layout-browser-hd-bg1.gif) repeat-x center;
  font-style: italic;
  height: 40px
}
#header h1 {
    font-size: 28px;
    color: #fff;
    font-weight: normal;
    padding: 5px 10px;
    height:100px
    font-style: italic;
}
 
</style>
<body>
 
	<link href="css/login.css" type="text/css" rel="stylesheet">

	<div class="doc">
	<div id="header"><h1> &nbsp; &nbsp; &nbsp; &nbsp;华实教育办公系统</h1></div>
		 
		<div id="highlight">
			<div id="loginfrarme">
				<div id="loginArea">

				</div>
			</div>
		</div>

		<div id="ft">
			<div class="wrp">
				<p class="fl">
					<span>&copy; 2012 华实教育软件</span> 
				</p>
				<p class="fr" id="ftSlogan">
					随时随地，快乐工作！
				</p>
			</div>
		</div>

	</div>
  
      

	<%@ include file="/common/include/html_bottom.jsp"%>