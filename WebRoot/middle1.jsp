<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/tlds/x.tld" prefix="x"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/tree.tld" prefix="tree"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>i18n_middle1.message.title_n81i</title>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />	
<script type="text/javascript" src="<c:url value='/js/menu.js'/>">
</script>
<script language="javascript" type="text/javascript"
	src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/leftTreeMenuCss.css'/>" />
<script type="text/javascript">
	function getPosition(){
		var top = document.documentElement.scrollTop;
		var left = document.documentElement.scrollLeft;
		var height = document.documentElement.clientHeight;
		var width = document.documentElement.clientWidth;
		return {top:top,left:left,height:height,width:width};
	}
	function choseNode(v){
		for(var i=0;i<8;i++){
			if(v==i){
				document.getElementById("node"+i).className="nodeSelStyle";
				document.getElementById("rightNodes"+i).style.display="block";				
				window.onscroll = function(){
					var Position = getPosition();
					document.getElementById("rightNodes"+i).style.top=(Position.top)+"px";
					document.getElementById("rightNodes"+i).style.left=(Position.left)+"px";
				};
			}
			else{
				document.getElementById("node"+i).className="nodeStyle";
				document.getElementById("rightNodes"+i).style.display="none";
			}
		}
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
<body style="background:#FFFFFF;">		
<!--中间部分右边开始-->
<div class="middle_list">
<div class="box_1">
	   <img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />&nbsp;i18n_middle1.text.position_n81i</div>
		<div class="box_2"> i18n_middle1.text.selectMessage_n81i
	        <select >
                <option>--i18n_middle1.text.selectDefault_n81i--</option>
	            <option>24</option>
	             <option>25</option>
            </select>
	             i18n_middle1.text.allMessage_n81i
	             <select >
                    <option>--i18n_middle1.text.selectDefault_n81i--</option>
	                <option>i18n_middle1.text.undergraduate_n81i</option>
	                <option>i18n_middle1.text.graduate_n81i</option>
	           </select>
			   <img src="<c:url value='/images/button_chaxun.png'/>" class="img_middle"  />
          </div>
			<table  border="0" cellpadding="0" cellspacing="0" class="table" >
		                    <tr>
		                      <td class="color_top">i18n_middle1.text.message_n81i</td>
		                      <td class="color_top">i18n_middle1.text.username_n81i</td>
		                      <td class="color_top">i18n_middle1.text.realName_n81i</td>
		                      <td class="color_top">i18n_middle1.text.currentState_n81i</td>
				              <td colspan="2" class="color_8">i18n_middle1.text.operation_n81i</td>
                            </tr>
                            <tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_5">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.state_n81i</td>
				              <td class="color_9">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_9">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_5">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_5">i18n_middle1.text.state_n81i</td>
				              <td class="color_9">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_9">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_1">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_1">i18n_middle1.text.state_n81i</td>
				              <td class="color_7">
							  <img src="images/logo_1.png" class="img_middle"/>&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_7">
							  <img src="images/logo_2.png" class="img_middle" />&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							<tr>
		                      <td class="color_3">i18n_middle1.text.messageName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.userRealName_n81i</td>
		                      <td class="color_3">i18n_middle1.text.state_n81i</td>
				              <td class="color_6">
							  <img src="images/logo_1.png" class="img_middle" />&nbsp;i18n_middle1.text.operation_n81i</td>
							  <td class="color_6">
							  <img src="images/logo_2.png" class="img_middle"/>&nbsp;i18n_middle1.text.delete_n81i</td>
                            </tr>
							
                      </table>
              <div class="box_3">i18n_middle1.text.page.total_n81i50i18n_middle1.text.page.pageInfo_n81i&nbsp;&nbsp;i18n_middle1.text.page.current_n81i1i18n_middle1.text.page.page_n81i</div>
				 <div class="box_2">i18n_middle1.text.page.change_n81i
	               <select class="option2">
                    <option>11</option>
	                <option>12</option>
	                <option>13</option>
                  </select>i18n_middle1.text.page.unit_n81i
				 <img src="images/button_up.png" class="img_middle"   />
			     <img src="images/button_down.png" class="img_middle"  />
		    </div>
		<!--中间部分右边结束-->	
  </div>
</body>
</html>
