<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<%@ include file="/common/include/html_head.jsp"%> 
<%@ include file="/page/contract/comp/ordercompinc.jsp"%>
<script>
  var   oWin;   
  function   openIt0()   
  {   
  oWin=window.open("http://localhost/Core/11.doc","myWin");   
  }   
  function   openIt1()   
  { 
  oWin=window.open("http://localhost/Core/11.doc","myWin"); 
  oWin.document.execCommand("print",false,"http://localhost/Core/11.doc");   
  }   
   function   openIt2()   
  { 
  // oWin=window.open("http://localhost/Core/11.doc","myWin");  
     new Order.filePreview("fileupload/C.doc");
  }  
    function   openIt3()   
  { 
  // oWin=window.open("http://localhost/Core/11.doc","myWin");  
    // new Order.filePreview2("fileupload/C_swf.swf");
  new Order.filePreview2("fileupload/s1/o124/f3/1353335703523_swf.swf");
  //new Order.filePreview2("fileupload/s1/o124/f3/C_swf.swf");
  }   

</script>
<a href="#" onclick="openIt1()">SHOW1 华实系统关系设计</a>
<a href="#" onclick="openIt2()">SHOW2华实系统关系设计</a>
<a href="#" onclick="openIt3()">SHOW3华实系统关系设计</a>
<%@ include file="/common/include/html_bottom.jsp"%>