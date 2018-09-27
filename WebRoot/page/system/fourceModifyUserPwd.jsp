<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_fmup.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/checkpw.js'/>"></script>
		<script type="text/javascript">
			function doUpdate(){
				if($id("yhmm","","i18n_fmup.text.yhmm_n81i")&&$id("confirm","","i18n_fmup.text.confirm_n81i")){	 		
					var yhmm = document.getElementById("yhmm").value;
					var confirm = document.getElementById("confirm").value;
					if(yhmm!=confirm){
						alert('i18n_fmup.message.confirm_n81i');
					}else{
						//if(containSpecial(yhmm)&& containSpecial(confirm)){
						//	document.yhForm.action="<c:url value='/login!forceModifyPassword.do'/>";
						//	document.yhForm.submit();
						//}else{
						//	alert('密码包含非法字符，请重新输入!');
						//}
						document.yhForm.action="<c:url value='/login!forceModifyPassword.do'/>";
						document.yhForm.submit();
					}		
				}
			}
			function goBack(){
				document.yhForm.action="<%=path%>/login.jsp";
				document.yhForm.submit();	
			}
			function containSpecial(s)       
			{       
		   		var cs = /^\w+$/;  
		   		resu = cs.test(s);     
		   		return (cs.test(s));       
			} 
			function enterkey(){
			   if(event.keyCode==13){
					doUpdate();
				}
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="yhForm" method="post" onkeydown="enterkey();">
				<input type="hidden" name="yhid" value="${logInInfo.yhid}" />
				<input type="hidden" name="yhbh" value="${logInInfo.yhbh}" />				
				<!-- <div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 系统配置 —> 用户管理 —> 修改密码信息
				</div>-->
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_fmup.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="40%" align="right">
							i18n_fmup.text.yhmc_n81i：
						</td>
						<td class="color_6" width="50%" align="left">
							<input type="text" name="user.yhmc" id="yhmc"
								value="${logInInfo.yhmc }" disabled="disabled"/>
							<input type="hidden" name="user.yhmc"  value="${logInInfo.yhmc }"/>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_fmup.text.yhmm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="logInInfo.yhmm" id="yhmm" value=""/>
							<font color="red">*</font>
							<span style="color: red;" id="password">i18n_fmup.message.yhmm_n81i</span>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_fmup.text.confirm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="confirm" id="confirm" value="" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_7" align="right" colspan="2">
										&nbsp;
										<input type="button" class=btn3_mouseout  id="tj"
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="doUpdate()" value="i18n_fmup.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" value="i18n_fmup.button.reset_n81i"/>
											
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" onclick="goBack()" value="i18n_fmup.button.back_n81i"/>
											
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
