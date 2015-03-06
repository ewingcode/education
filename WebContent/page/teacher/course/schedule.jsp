<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%>  
<%@ include file="/common/include/html_head.jsp"%> 
<style type="text/css">
 

		.left{
			width:160px;
			float:left;
		}
		.left table{
			background:#E0ECFF;
		}
		.left td{
			background:#eee;
		}
		.right{
			float:right;
			width:900px; 
		}
		.right table{ 
			width:100%;
		}
		.right td{ 
			text-align:center;
			padding:2px;
		}
		.right td{ 
			height:20px;
			
		}
		.right td.drop{
			background:#fafafa;
			width:100px;  
			border:1px solid #C0C0C0;
		}
		.right td.time{
			background:#fafafa;
			width:80px; 
			border:1px solid #99CCFF;
		}
		.right td.title{
			background:#99CCFF;
			width:80px; 
			border:1px solid #99CCFF;
		}
		.right td.over{
			background:#FBEC88; 
		}
		.item{
			text-align:center;
			border:1px solid ;
			background:#fafafa;
			width:80px;
			height:18px;
		}
		.assigned{
			border:1px solid #BC2A4D;
		}
</style>
<script>
		$(function(){ 
			$('.left .item').draggable({
				revert:true,
				proxy:'clone'
			});
			$('.right td.drop').droppable({
				onDragEnter:function(){
					$(this).addClass('over');
				},
				onDragLeave:function(){
					$(this).removeClass('over');
				},
				onDrop:function(e,source){
					$(this).removeClass('over');
					if ($(source).hasClass('assigned')){
						$(this).append(source);
					} else {
						var c = $(source).clone().addClass('assigned');
						$(this).empty().append(c);
						c.draggable({
							revert:true
						});
					}
				}
			}); 
		});
	</script>
<body  >  
<div style="width:1200px;">
  
	<div class="left">
	    
		<table>
			<tr>
				<td><div class="item">语文</div></td>
			</tr>
			<tr>
				<td><div class="item">数学</div></td>
			</tr>
			<tr>
				<td><div class="item">英文</div></td>
			</tr>
			<tr>
				<td><div class="item">政治</div></td>
			</tr>
			 
		</table>
	</div>
	<div class="right">
		<table >
			<tr>
				<td class="blank"></td>
				<td class="title">周一</td>
				<td class="title">周二</td>
				<td class="title">周三</td>
				<td class="title">周四</td>
				<td class="title">周五</td>
				<td class="title">周六</td>
				<td class="title">周日</td>
			</tr>
			<tr>
				<td class="time">08:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">09:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">10:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">11:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">12:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">13:00</td>
				<td class="lunch" colspan="7"> </td>
			</tr>
			<tr>
				<td class="time">14:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">15:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">16:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
		</table>
	</div>
</div>
</body>
<%@ include file="/common/include/html_bottom.jsp"%>