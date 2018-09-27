<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/tlds/x.tld" prefix="x"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/tree.tld" prefix="tree"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>i18n_middle.message.title_n81i</title>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />	
<script type="text/javascript" src="<c:url value='/js/menu.js'/>">
</script>
<script language="javascript" type="text/javascript"
	src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/leftTreeMenuCss.css'/>" />
<script type="text/javascript">
$(function(){
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
	});
	//初始化时先换位置
	//if($("#leftNodes").find("li[class='nodeSelStyle']").closest("div[id='dleft']").size()>0){
	//alert($("#leftNodes").find("div[id='dright']").size());
	if($("#leftNodes").find("div[id='dright']").size()>0){
		$("#dleft").append($("#dright").find("ul"));//.clone(true)
		$("#dright").append($("#dleft").find("ul").first());
	}
});
	function getPosition(){
		var top = document.documentElement.scrollTop;
		var left = document.documentElement.scrollLeft;
		var height = document.documentElement.clientHeight;
		var width = document.documentElement.clientWidth;
		return {top:top,left:left,height:height,width:width};
	}
	function switchLeft(){
		var switchimage=document.getElementById("switchlefts").src.split("/");
		var every=switchimage[switchimage.length-1];		
		if(every=="an1.jpg"){
			document.getElementById("middleRight").className="middle_rightswitch";
			document.getElementById("switchlefts").src="images/an2.jpg";
			document.getElementById("leftNodes").style.display="none";
		}
		else{
			document.getElementById("middleRight").className="middle_right";
			document.getElementById("switchlefts").src="images/an1.jpg";
			document.getElementById("leftNodes").style.display="block";
		}
	}
</script>
</head>
<body>		
<div class="middle">
<!--中间部分左边开始-->
  <div class="middle_left" id="leftNodes" style="overflow:scroll;">
	<tree:showTree xmlStr='<%=(String) session.getAttribute("treeStr")%>'
				parentMenuCss="parentMenu" childMenuCss="childMenu"
				childMenuTableCss="childMenuTable" topTrCss="trCss"
				imgSrc="/nmsweb/images/tree/close_image.gif" openAndCloseImgWidth="2"
				parentMenuBg="/nmsweb/images/tree/parentMenu.gif"
				childMenuBg="/nmsweb/tree/blank.gif" target="I3"
				showParentOpenAndCloseImg="false"
				linkMenuImg="/nmsweb/images/tree/menu_link.gif"
				spaceImage="/nmsweb/images/tree/kb.gif"
				clickLinkEvent="clickLinkEvent()"></tree:showTree>   
  </div> 

<!--中间部分左边结束-->
<table border="0" cellpadding="0" cellspacing="0" class="middle_tab">
  <tr>
    <td>
    <img src="<c:url value='images/an1.jpg'/>" class="img_middle" id="switchlefts" onclick="switchLeft()" />
    </td>
   </tr>
 </table>
<!--中间部分右边开始-->
<div class="middle_right" id="middleRight">
	  <iframe id="I3" name="I3" height="100%" width="100%" border="0"
						frameborder="0" src="<c:url value='/nodePosition/topoShow.do'/>" scrolling="auto">
						i18n_middle.message.I3_n81i
					</iframe>
  
</div>  
<!--中间部分结束-->
<div style="clear:both;"></div>
</body>
</html>
