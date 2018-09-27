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
		<title>i18n_uup.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/checkpw.js'/>"></script>
		<script type="text/javascript">
			function doUpdate(yhid,yhbh){
				if($id("yhmm","","i18n_uup.text.yhmm_n81i")&&$id("confirm","","i18n_uup.text.confirm_n81i")){	 		
					var yhmm = document.getElementById("yhmm").value;
					var confirm = document.getElementById("confirm").value;
					if(yhmm!=confirm){
						alert('i18n_uup.message.confirm_n81i');
					}else{
						document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdatePassword&yhid="+yhid+"&yhbh="+encodeURI(yhbh);
						document.yhForm.submit();
					}		
				}
			}
			function goBack(){
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryUserInfo";
				document.yhForm.submit();	
			}
			function containSpecial(s)       
			{       
		   		var cs = /^\w+$/;  
		   		resu = cs.test(s);     
		   		return (cs.test(s));       
			} 
		</script>
	</head>
	<body>
		<div class="middle_list">
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'" onclick="goBack()" value="i18n_uup.button.back_n81i"/>
			 </div>
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_uup.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="40%" align="right">
							i18n_uup.message.yhmc_n81i：
						</td>
						<td class="color_6" width="50%" align="left">
							<input type="text" name="user.yhmc" id="yhmc"
								value="${userInfo[0].yhmc }" disabled="disabled"/>
							<input type="hidden" name="user.yhmc"  value="${userInfo[0].yhmc }"/>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_uup.text.yhmm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="user.yhmm" id="yhmm" value=""/>
							<font color="red">*</font>
							<span style="color: red;" id="password">i18n_uup.message.password_n81i</span>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_uup.text.confirm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="confirm" id="confirm" value="" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_7" align="right" colspan="2">
										&nbsp;
										<input type="button" class=btn3_mouseout id="tj"
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="doUpdate('${userInfo[0].yhid }','${userInfo[0].yhbh}')" value="i18n_uup.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" value="i18n_uup.text.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
