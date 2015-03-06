 Ext.ux.ThemeChange = Ext.extend(Ext.form.ComboBox,{   
     editable : false,   
    displayField : 'theme',   
     valueField : 'css',   
     typeAhead : true,   
     mode : 'local',   
     width : 90 ,   
     value : '默认蓝',   
     readonly : true,   
     triggerAction : 'all',   
     selectOnFocus : true,   
     initComponent : function(){   
         var themes = [   
                 ['默认蓝', 'ext-all.css'],   
                  ['青绿色', 'xtheme-gray.css'],    
                  ];
         this.store = new Ext.data.SimpleStore({   
             fields : ['theme', 'css'],   
             data : themes   
         });   
        this.readCookie() ;   
     },   
     initEvents : function(){   
         this.on('collapse', function(){   
             this.changeTheme(this.getRawValue()) ;//切换样式   
             this.writeCookie(this.getRawValue()) ;//将样式代号写入 Cookie   
         });   
     } ,   
     writeCookie : function(){   
        //设定Cookie值   
         Ext.state.Manager.setProvider(   
             new Ext.state.CookieProvider({   
                expires: new Date(new Date().getTime()+(1000*60*60*24*30)) //30 days   
             }).set('adaptoflowTheme',arguments[0])   
        );      
     } ,   
     readCookie : function(){   
        //读取Cookie值      
        var theme = new Ext.state.CookieProvider().get('adaptoflowTheme');      
         if(theme){   
             this.changeTheme(theme) ;   
        }else{   
            this.changeTheme("默认蓝") ;   
        }   
     } ,   
     changeTheme : function(){   
            var colorCSS = "#cad9ec" ;//页头页脚的颜色变量   
            var themeCSS = "" ;//Ext主题变量   
            if(arguments[0]=="深灰色"){   
                colorCSS = "#848484" ;   
                 themeCSS = "xtheme-darkgray.css" ;   
            }else if(arguments[0]=="默认蓝"){   
                 colorCSS = "#cad9ec" ;   
                 themeCSS = "" ;   
            }   

             this.setValue(arguments[0]) ;//更改样式Combo的现实值   
            Ext.util.CSS.swapStyleSheet('theme', 'resources/css/'+ themeCSS);//切换Ext皮肤   
            document.getElementById("south").style.background = colorCSS ;//更换页角样式   
             document.getElementById("north").style.background = colorCSS ;//更换页头样式   
     }    
 });   
 Ext.reg('xthemeChange', Ext.ux.ThemeChange);  
