<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/tree.tld" prefix="tree"%>
<%@ page import="nis.nms.domains.*"%>
<%@ page import="nis.nms.util.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	XtYhJbxx user = (XtYhJbxx)request.getSession().getAttribute(Constant.SESSION_CZY_NAME);
	String systemname = (String)request.getSession().getAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME);
	if(systemname == null)systemname="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="Shortcut icon" href="images/logo.ico"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--<meta http-equiv="refresh" content="60;<%=path%>/nmstaskManager/nmsTaskManager.do?action=query" />-->
<title>i18n_main.message.title_n81i</title>
<link rel="Shortcut icon" href="favicon.ico"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/nms.css'/>" />	
<link rel="stylesheet" type="text/css" href="<c:url value='/css/leftTreeMenuCss.css'/>" />
<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/iconfont.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/nav.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/scrollBar/scrollBar.css'/>" />
<link rel="stylesheet"
			href="<c:url value='/js/jquery-easyui-1.1.2/themes/default/easyui.css'/>"
			type="text/css"></link>
<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery1.11.3.js'/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value='/js/layer.js'/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/browser.js"/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value="/js/nav.js"/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value="/scrollBar/scrollBar.js"/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/jquery-easyui-1.1.2/jquery.easyui.min.js' />"></script>
<script type="text/javascript">
$(function(){
	var lang=$("#languageChange").val();
	if(lang != "zh_CN"){
		$(".memuNameSpan").prop("style","margin-left:0px;")
	}

	$("#leftNodes").scrollBar({
		barWidth: 3,
		position: "y"
	});
	$(window).resize(function(){
		$(window.document).height(($(window).height()));
		middle_height = ($(this).height()-$("#top").outerHeight())-2;
		//alert($(window).height()-middle_height);
		$("div[id^=rightNodes]").height(middle_height);
		$("#switch1").height(middle_height);
		//$("#middleRight").height(middle_height);
		$("#I3").height(middle_height);
		$("#leftNodes").height(middle_height);
		middle_width = ($(this).width()-$("#leftNodes").outerWidth()-$("#switch1").outerWidth());
		//alert($(this).width()+" "+$("#leftNodes").outerWidth()+" "+$("#switch1").outerWidth());
		//alert("LLLL:"+middle_width);
		$("#I3").width(middle_width);
	});
	$(window).trigger('resize');
	$("#leftNodes").find("li[menuLevel=1]").click(function(){
		$("#leftNodes").find("li[class='nodeSelStyle']").addClass('nodeStyle');
		$("#leftNodes").find("li[menuLevel=1]").removeClass('nodeSelStyle');
		$(this).addClass('nodeSelStyle');
		$("div[id^='rightNodes']").hide();
		$("#rightNodes"+$(this).attr('num')).show();
		//alert($("#dleft")[0].innerHTML);
		if($(this).closest("div[id='dleft']").size()>0){
			//var $sUL= $("#dleft").find("ul");
			$("#dleft").append($("#dright").find("ul"));//.clone(true)
			$("#dright").append($("#dleft").find("ul").first());
			//var temp = $("#dleft")[0].innerHTML;
			//$("#dleft")[0].innerHTML=$("#dright")[0].innerHTML;			
			//$("#dright")[0].innerHTML=temp;
		}
		//主页面初始化为该菜单下的第一个菜单的最底层一级菜单			
		$("#rightNodes"+$(this).attr("num")+" li:first a:first").trigger('click');
		$("iframe[name='I3']").attr("src",$("#rightNodes"+$(this).attr("num")+" li:first a:first").attr('href'));
		
		
		//$("#switch1").css("left",$("div[class='menu_2']").width()+40+"px");
		//$("#middleRight").css("left",$("div[class='menu_2']").width()+40+$("#switch1").outerWidth()+"px");
		//middle_width = ($(window.document).width()-$("#leftNodes").outerWidth()-40-$("#switch1").outerWidth());
		//alert($(this).width()+" "+$("#leftNodes").outerWidth()+" "+$("#switch1").outerWidth());
		//alert("LLLL:"+middle_width);
		//$("#I3").width(middle_width);
		
	});
	//$("#rightNodes")
	//if($("#leftNodes").find("li[class='nodeSelStyle']").closest("div[id='dleft']").size()>0){
	//alert($("#leftNodes").find("div[id='dright']").size());
	//alert($("#leftNodes").find("div[id='dright']").size());
	
	
	//初始化时先换位置
	if($("#leftNodes").find("div[id='dright']").size()>0){
		$("#dleft").append($("#dright").find("ul"));//.clone(true)
		$("#dright").append($("#dleft").find("ul").first());
	}else{//alert("aa");
		$("div[class='menu_2']").hide();
		$("div[id='rightNodes0']").show();
	}

	//menu css revertBgColor()
	$(".menu_2").find("li").click(function(){
		//alert("p3:"+$(".menu_2").find("li[class='mfoucsli']").size()+":::::"+$(".menu_2").find("li[menuLevel='no1']").size());
		//$(".menu_2").find("li[menuLevel='no1']").addClass("mli");
		$(".menu_2").find("li[menuLevel='no1']").removeClass("mfoucsli");
		$(this).addClass('mfoucsli');//alert("p3");
		//alert("p4:"+$(".menu_2").find("li[class='mli']").size()+":::::"+$(".menu_2").find("li[menuLevel='no1']").size());
	});
	//拓扑图，拓扑图展示为当前选择菜单
	//$("#node5").trigger('click');
	//node5		
	//	$("#rightNodes"+$(this).attr("num")+" li:first a:first").trigger('click');
});
	function switchLeft(){
		var switchimage=document.getElementById("switchlefts").src.split("/");
		var every=switchimage[switchimage.length-1];		
		if(every=="an1.jpg"){//alert("passs");
			document.getElementById("middleRight").className="middle_rightswitch";
			document.getElementById("switchlefts").src="<c:url value='images/an2.jpg'/>";
			document.getElementById("leftNodes").style.display="none";			
			document.getElementById("switch1").className="middle_tab1";	
			document.getElementById("middleRight").className="middle_right1";		
			var offsetWidth=$(window).width();
			$("#I3").width((offsetWidth-18));
		}
		else{
			document.getElementById("middleRight").className="middle_right";
			document.getElementById("switchlefts").src="<c:url value='images/an1.jpg'/>";
			document.getElementById("leftNodes").style.display="block";
			document.getElementById("switch1").className="middle_tab";
			document.getElementById("middleRight").className="middle_right";				
			var offsetWidth=$(window).width();
			$("#I3").width($(window).width()-$("#leftNodes").outerWidth()-$("#switch1").outerWidth());
		}
	}
	
	
	
		var dto;//下沉线程
		//页面加载调用方法
		$("document").ready(function(){
			//refresh("");
			$("#msgTable").css("display","none");
			//动画载入工作提醒
			 showMsg();
			//5秒后下沉
			dto=setTimeout(showMsg,5000);
			//绑定显示提醒按钮点击事件
			$("#show").on("click",
				function(){
					showMsg();
				}
  			);
  			window.setTimeout(resetTaskMsg,60000);
		});
		
		//操控工作提醒Div显示
		function showMsg(){
			//去除下沉线程
			if(dto!=null){
				window.clearTimeout(dto);
				dto=null;
			}
			console.log($("#msgTable").css("display"));
			//如果是显示的则触发隐藏动画
			if($("#msgTable").css("display")=="block"){
				$("#msgTable").animate({opacity:0},
					500,
					function(){
						$("#msgTable").css("display","none");
						$("#msgBox").animate({opacity:0,width:180,height:10},//宽度根据页面宽度设置
							1000,
							function(){
								//$("#msgTr").css("display","none");
								$("#msgBox").css("display","block");
								$("#show").text("△i18n_main.text.show1_n81i△");								
							}
						);	
				});
			}else{				
				//如果是隐藏的则触发显示动画
				//$("#msgTr").css("display","block");
				$("#msgTable").css("display","block");
				$("#msgBox").css("display","block");
				$("#msgBox").animate({opacity:1,width:180,height:100},//宽度根据页面宽度设置
	  				1000,
	  				function(){
	  					$("#msgTable").animate({opacity:1,width:180},//宽度根据页面宽度设置
						500);
						$("#show").text("▽i18n_main.text.show1_n81i▽");
	  				}
				);		
				resetMessages();
			}
		
		}
	
		//ajax,查询五分钟之类是否发现有新的结果数据
		function resetMessages(){
			var url="<%=path%>/detection/detectionWarning.do?action=getTaskMessages";
			$.ajax({
			  url: url,
			  cache: false,
			  success: function(data){		  		
	   				var msg=$("alarms",data);	//alert("pass:0000"+msg.length);		  		
	   				var msgList = '';
	   				$("#msgTable").empty();
			  		if(msg.length>0){
			  			$("#warningmsg").css("display","block");	
			  			msg.each(function(){
		   					var name=$("alarm_level",this).text();//alert("pass:name"+name);
							var urlStr=$("url",this).text();//alert("pass:urlStr"+urlStr);
							var count=$("count",this).text(); //alert("count："+count);
							var msgList="<a  target='I3' title='"+name+"("+count+")"+"' href='"+urlStr+"' ><li style='margin-left: 5px;'>"+name+"<font color='red'>("+count+")</font></a>";
							$("#msgTable").append("<tr><td>"+msgList+"<td></tr>");
		   				})	
			  		}
			  		else{
			  			$("#warningmsg").css("display","none");			  			
			  		}			  		
			  }
			});	  		
			window.setTimeout(resetMessages,300000);
		}	
		//window.onload=resetMessages;
		
	
		function hideMsg(){
			$("#warningmsg").css("display","none");	
		}
	
	
	
		var time=<%=new Date().getTime()%>;
		var date=new Date(time);
		var step=1000;
		function reload(){
			date.setTime(time);
			time+=step;
			document.getElementById("td_time").innerHTML=date.format("yyyy-MM-dd hh:mm:ss");
		}
		setInterval('reload()',1000);
		
		Date.prototype.format=function(style){
			var o={
			"M+":this.getMonth()+1,
			"d+":this.getDate(),
			"h+":this.getHours(),
			"m+":this.getMinutes(),
			"s+":this.getSeconds(),
			"w+":"天一二三四五六".charAt(this.getDay()),
			"q+":Math.floor((this.getMonth()+3)/3),
			"S":this.getMilliseconds()
			}
			if(/(y+)/.test(style)){
			style=style.replace(RegExp.$1,
			(this.getFullYear()+"").substr(4-RegExp.$1.length));
			}
			for(var k in o){
			if(new RegExp("("+k+")").test(style)){
			style=style.replace(RegExp.$1,
			RegExp.$1.length==1?o[k]:
			("00"+o[k]).substr((""+o[k]).length));
			}
			}
			return style;
		}
		
		$("#I3").ready(function(){
  		//	window.setTimeout(resetTaskMsg,60000);//30000
		});
		
		function hideMe(id){
			//$("#"+id).hide("fast");
			$("#"+id).next().remove();
			$("#"+id).remove();
		}

		//ajax,查询五分钟之类是否发现有新的完成的任务
		function resetTaskMsg(){
				var url="<%=path%>/nmstaskManager/nmsTaskManager!getTaskOfUnLook.do";
				$.ajax({
				  url: url,
				  cache: false,
				  success: function(data){
		   				var msg=$("alarms",data);	//alert("pass==="+msg.length);		  		
				  		if(msg.length>0){
				  			var info="";
				  			var stateInfo="";
				  			msg.each(function(){
			   					var name=$("task_name",this).text();
			   					var id=$("task_id",this).text();
			   					var state=$("task_state",this).text();
			   					switch(Number(state)){
			   						case 3:
			   							stateInfo ="<font color='blue'>i18n_main.message.stateInfo1_n81i</font>";
			   							break;
			   						case 30:
			   							stateInfo ="<font color='green'>i18n_main.message.stateInfo2_n81i</font>";
			   							break;
			   						case 31:
			   							stateInfo ="<font color='red'>i18n_main.message.stateInfo3_n81i</font>";
			   							break;
			   						case 32:
			   							stateInfo ="<font color='#e47833'>i18n_main.message.stateInfo4_n81i</font>";
			   							break;
			   						default:
			   							stateInfo="";
			   					}
								var urlStr=$("url",this).text();
								info+="<a target='I3' id="+id+" title='"+name+"' href='"+urlStr+"' onclick='hideMe("+id+");'>"+ name +"&nbsp;&nbsp;"+stateInfo+"</a><br>";
			   				})								
								//console.log(info);
			   			//var currentEle = document.getElementById("I3").contentWindow.document.activeElement;  //获取当前焦点元素10000
				    	 $.jBox.messager(info,"i18n_main.message.info_n81i",10000,{
						    width: 300,
						    height:92,
						    showType: 'show',
						    border:1,
						    buttonsFocus: 100
						}); 
						//$.jBox.messager(info,"i18n_main.message.info_n81i",0,$.jBox.messagerDefaults);
				  	}
			  		
				  }
				});	
				
		
				window.setTimeout(resetTaskMsg,300000);//300000
			}	
		$(function(){
			
			var selectedOption=$("#languageChange option:selected");
			
			$("#languageChange").change(function(){
				/* /main.jsp?i18n_lang=zh_CN */
				$(selectedOption).removeProp("selected");
				
				location.href="<c:url value='/main.jsp?i18n_lang='/>"+this.value;
			});
		});
		/* $(function(){
			$("#toTarget").click(function(){
				$.ajax({
					url:"${pageContext.request.contextPath }/authentication/identificat.do?action=toTargetSys",
					type:"get",
					dataType:"json",
					success:function(data){
						window.open(data.url+"?token="+data.token,"_blank");
						//openWin(data.url,data.token);
					}
				});
			});
		}); */
		function openWin(url,token){
			$("body").append("<a href="+url+"?token="+token+" target='_blank' id='openWin'></a>");
			$(document.getElementById("openWin")).click();
			$("#openWin").remove();
		}
		$(function(){
			var url=window.location.href;
	           
			var split=url.split("/");
			url=split[2];
			
			var objA=$("#toTarget");
			var val=objA.attr("href");
			
			objA.attr("href",val+"&addr="+url);
		});
		
</script>
<style type="text/css">	
html, body {
	height:100%;
	overflow:hidden;
	_overflow-x:hidden;
	_overflow-y:hidden;
}
.nav{
	width:200px;
}

.nav a{
	text-align: left;
}

.nav a span{
	margin-left: 40px;
}

.middle_tab{
	left: 180px;
}

.middle_right{
	left : 185px;
}


#msgTable a:link{color:#F3F3F8;}
#msgTable a:visited{color:#F3F3F8;}
#msgTable a:hover{color:#F3F3F8;}
#msgTable a:active{color:#F3F3F8;}

</style>
</head>


<%--<body style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;">--%>
<body style="height: 100%;width: 100%;overflow: hidden;overflow-x: hidden;overflow-y: hidden;font-size: 12px; border: 0px;margin: 0px;padding: 0px; overflow: false;">
<!--顶部开始-->
<!-- 1为禁止查询，2为可以联想查询 -->
<input type="hidden" id="lianxiangStatus" value="2"/>  
<div class="top" id="top">
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >
  <tr>
   
   <td class="top_img">
   <span class="sn">i18n_main.message.title_n81i</span>
   </td>
    <!--
     <td width="1002" height="67" background = "<c:url value='images/top.jpg'/>"><div id="nav">
              <ul>
                <li><a href="#">系统首页&nbsp;|</a></li>
                <li><a href="#">系统设置&nbsp;|</a></li>
                <li><a href="#">系统指南&nbsp;|</a></li>
                <li><a href="#" onclick="quitSytem();">退出系统&nbsp;|</a></li>
              </ul>
            </div>	</td>-->
    </tr> 
      <tr>
        <td height="3" class="top_color1"></td>
       </tr>
       <tr>
        <td height="20" class="top_color2" >
        	<div id="navlogin">
				
				<ul>
                <li><a href="<c:url value='/login!logout.do'/>">i18n_main.text.logout_n81i</a></li>
                <li><a href="<c:url value='/login!systemSelect.do?SytemChange=yes'/>">i18n_main.text.systemSelect_n81i&nbsp;&nbsp;|</a></li>
                <%-- <li><a href="<c:url value='/main.jsp?i18n_lang=zh_CN'/>">简体中文&nbsp;&nbsp;|</a></li> 
                <li><a href="<c:url value='/main.jsp?i18n_lang=en_US'/>">ENGLISH&nbsp;&nbsp;|</a></li> --%>
                <li>
                	<!-- <a href="<c:url value="/authentication/identificat.do?action=toTargetSys"/>">To Grafana &nbsp;&nbsp;|</a> -->
                	<a href="<c:url value='/authentication/identificat.do?action=toTargetSys'/>" id="toTarget" target='_blank'>To Grafana &nbsp;&nbsp;|<a/>
                </li>
                <li>
                	<span>
                		<select id="languageChange">
                			<%String lang=request.getParameter("i18n_lang"); %>
                			<option <%if(lang==null) {%> <%="en_US".equals(user.getLanguage())?" selected='selected'":"" %><%}else{%><%="en_US".equals(lang)?" selected='selected'":"" %><% }%> value="en_US">ENGLISH</option>
                			<option <%if(lang==null) {%> <%="zh_CN".equals(user.getLanguage())?" selected='selected'":"" %><%}else{%><%="zh_CN".equals(lang)?" selected='selected'":"" %><% }%> value="zh_CN">简体中文</option>
                			<option <%if(lang==null) {%> <%="ru_RU".equals(user.getLanguage())?" selected='selected'":"" %><%}else{%><%="ru_RU".equals(lang)?" selected='selected'":"" %><% }%> value="ru_RU">русский язык</option>
                		</select>
                		
                	</span>|
                </li>
                
                <!-- <li><a href="<c:url value='/nodePosition/nodePosition.do?action=showTopology'/>" target="I3">拓扑图&nbsp;&nbsp;|</a></li> -->
                <!-- <li><a href="<c:url value='/nodePosition/topoShow.do'/>" target="I3">拓扑图&nbsp;&nbsp;|</a></li> -->
                <!-- <li><a href="<c:url value='/nodePosition/nodePosition.do?action=showTopology'/>" target="I3">拓扑图&nbsp;&nbsp;|</a></li>-->
                <li><a href="#">&nbsp;|</a></li>
              </ul>
            </div>	
             <div id="nav">
              	<ul>
                <li style="align:left;"><%=user == null ? ""
							: user.getYhmc()%>，i18n_main.text.welcome_n81i！  <span id="td_time" style="align:left;"></span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<%if(systemname!=null && !"".equals(systemname)){%>i18n_main.text.systemName_n81i：<font color="red"><%=systemname %></font><%}%>
							</li> 
              </ul>
            </div>	
		 </td>
       </tr>
  </table>
</div>
<!--顶部结束-->
<!--中间部分开始-->
<div class="middle" id="main_middle">
	<div class="middle_mid" align="center" style="position: fixed;">
<!--中间部分左边开始-->
		  <div class="middle_left nav" id="leftNodes">		     
			<%-- <tree:showTree xmlStr='<%=(String) session.getAttribute("treeStr")%>'
						parentMenuCss="parentMenu" childMenuCss="childMenu"
						childMenuTableCss="childMenuTable" topTrCss="trCss"
						imgSrc="images/tree/close_image.gif" openAndCloseImgWidth="2"
						parentMenuBg="images/tree/parentMenu.gif"
						target="I3"
						showParentOpenAndCloseImg="false"
						linkMenuImg="images/tree/menu_link.gif"
						spaceImage="images/tree/kb.gif"
						clickLinkEvent="clickLinkEvent()"
						onMouseOver=""
						></tree:showTree> --%>
						${treeHtml }
			<!-- <ul>
	            <li class="nav-item">
	                <a href="javascript:;"><span>System Configuration</span><i class="my-icon nav-more"></i></a>
	                <ul>
	                    <li><a href="javascript:;" data-url='/nmsweb/detection/monitorData.do?action=query'><span>网站设置</span></a></li>
	                    <li><a href='/nmsweb/sysManage/sysErrorManage!execute.do?action=queryError' target='I3'><span>友情链接</span></a></li>
	                    <li><a href='/nmsweb/detection/monitorData.do?action=query' target='I3'><span>分类管理</span></a></li>
	                    <li><a href="javascript:;"><span>系统日志</span></a></li>
	                </ul>
	            </li>
	            <li class="nav-item">
	                <a href="javascript:;"><span>文章管理</span><i class="my-icon nav-more"></i></a>
	                <ul>
	                    <li><a href="javascript:;"><span>站内新闻</span></a></li>
	                    <li><a href="javascript:;"><span>站内公告</span></a></li>
	                    <li><a href="javascript:;"><span>登录日志</span></a></li>
	                </ul>
	            </li>
	            <li class="nav-item">
	                <a href="javascript:;"><i class="my-icon"></i><span>订单管理</span><i class="my-icon nav-more"></i></a>
	                <ul>
	                    <li><a href="javascript:;"><span>订单列表</span></a></li>
	                    <li><a href="javascript:;"><span>打个酱油</span></a></li>
	                    <li><a href="javascript:;"><span>也打酱油</span></a></li>
	                </ul>
	            </li>
	        </ul> -->
	        
		</div><!-- childMenuBg="<c:url value='/tree/blank.gif'/>"--> 		   
		<div style="position: absolute; bottom: 80px;display: block ;background-color: rgb(44, 8, 14);" id="warningmsg">
			<table>
				<tr valign="buttom" id="titles">
						<td width="100%" height="18" background="<c:url value='/images/main_58.png'/>">
							<div align="center" style="width: 180px;background-color: #a81e32">
								<span id="show" class="STYLE1" 
									style="color: rgb(242, 229, 229);cursor:pointer; font-weight: bold;width: 100%">▽i18n_main.text.show1_n81i▽</span>
							</div>
						</td>
					</tr>
					<tr id="msgTr">
						<td>
							<div id="msgBox" style="overflow-y: auto;overflow-x: hidden;" >
								<table id='msgTable' width='100%' class='STYLE3'>
								
								</table>
							</div>
						</td>
					</tr> 
			</table>
		</div>	
		<!--中间部分左边结束-->
		<table border="0" cellpadding="0" cellspacing="0" id="switch1" class="middle_tab" >
		  <tr>
		    <td id="switchlefts2">
		    	<img src="<c:url value='/images/an1.jpg'/>" class="img_middle" id="switchlefts" onclick="switchLeft()" />
		    </td>
		   </tr>
		 </table>
		<!--中间部分右边开始-->
		<div class="middle_right" id="middleRight" height="100%" width="100%" background="#FFFFFF">
		<%
		String userName = "";
		if(user != null){userName = user.getYhbh();}
		if("admin".equals(userName)){
		%>			
			<iframe id="I3" name="I3" height="100%" width="100%" border="0" style="background:#FFFFFF;"	
				frameborder="0" src="<c:url value='/detection/detectionWarning.do?action=queryAllConfigLevel'/>" scrolling="auto">
				i18n_main.message.I3_n81i。
			</iframe>
		<%
		}else{
		%>
			<iframe id="I3" name="I3" height="100%" width="100%" border="0" style="background:#FFFFFF;"	
				frameborder="0" src="<c:url value='/nodePosition/newTopoShow.do?action=showTopo'/>" scrolling="auto">
				i18n_main.message.I3_n81i。
			</iframe>
		<%
		}
		%>
		</div>  
	</div>
	
	<!-- <div id="nodeList" closed="true">
		1为禁止查询，2为可以联想查询  此开关同main.jsp
		<input type="hidden" id="lianxiangStatus" value="2" />
		<span id="title" class="color_3_tip"
			style="width: 100%;  display: none; text-align: center;"></span>
		<div id="title" class="color_3_tip" style="height: 20px;text-align: center;line-height: 20px">i18n_st.text.policy_n81i</div>
		<iframe id="I4" name="I4" height="30%" width="100%" border="0"
			style="background: #FFFFFF; display: none;" frameborder="0" src=""
			scrolling="no">
			i18n_st.message.frameInfo_n81i
		</iframe>
		<hr id="hr" />
		<iframe id="I5" name="I5" height="100%" width="100%" border="0"
			style="background: #FFFFFF;" frameborder="0" src="" scrolling="no">
			i18n_st.message.frameInfo_n81i
		</iframe>
	</div>
	 -->
	
	
	
	
</div>
<!--中间部分结束-->
<div style="clear:both;"></div>

<script type="text/javascript">
	document.body.style.overflow="hidden";
	document.body.style.overflowX="hidden";	
	document.body.style.overflowY="hidden";
	
	/* //以下代码解决了easy-ui报错 can't read property msie of undefined
	jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
	
	$(function(){
		 //告警节点列表初始化
		$("#nodeList").dialog({
			title:"i18n_st.nodeList.title_n81i",
			resizable:true,
			width:1024,
			height:600
		});	
		 console.log("123213213213")
	})

	
	function getDetectInfo(id,type,showStatus){
		//根据类型的不同 判断节点或节点组的查询条件
		var url ="<c:url value='/detection/monitorData.do?action=query&nodeType=1&requestType=newTopo&nodeGroupId="+id+"'/>";
		var url2="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&nodeType=1&requestType=topo&nodeGroupId="+id+"'/>";
		if(type==2){
			url ="<c:url value='/detection/monitorData.do?action=query&nodeType=2&requestType=newTopo&nodeId="+id+"'/>";
			url2="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&nodeType=2&requestType=topo&nodeId="+id+"'/>";
		}
	//异常情况，显示紧急告警列表，否则不显示
	if(showStatus == 1){
		$("#title").show();
		$("#I4").show();
		$("#hr").show();
		$("#I4").attr("src",url2);
	}else{
		$("#title").hide();
		$("#I4").hide();
		$("#hr").hide();
	}

	$("#I5").attr("src",url);//由于所有数据列表不会出现隐藏的情况，所以标题的确定就有I5来负责
}


 function setDivTitle(groupName) {
	if(groupName!='undefined' && groupName!=null && groupName!="") {
		$("#nodeList").dialog({
			title:groupName+" i18n_st.text.monitorData_n81i"
		});	
	}else {
		$("#nodeList").dialog({
			title:"i18n_st.text.monitorData_n81i"
		});	
	}
	$("#nodeList").dialog("open");
}
 	 // iframe切换关闭拓扑图的节点数据弹出框
	 function closeTopo(){
		 $("#nodeList").dialog("close");
	 } */
</script>
</body>
</html>
