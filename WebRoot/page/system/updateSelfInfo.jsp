<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
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
		<title>i18n_usi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/checkpw.js'/>"></script>
			<script type="text/javascript">
	//function checkEmail(str){
		//var myRegExp=/^[a-z0-9]{1,30}@[a-z0-9]{1-65}.(com|net|org|info|biz|([a-z]){2,3}.[a-z]{2}))/ ;
		//return myRegExp.test(str);
		//var reg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/ ;
		//return reg.test(str);
	//}
			var msg = '${MSG}';
		    if(msg=='1'){
				alert("i18n_usi.message.success_n81i");
			}else if(msg=='2'){
				alert("i18n_usi.message.faild_n81i");
			}	
			
			function doUpdate(yhid,yhbh){
				var emailFlag=${session.emailFlag};
				if(emailFlag==0){
					if(yhForm.email.value!=""){
						if(!checkEmail(yhForm.email.value.toLowerCase())){
							$("#email").next().html('i18n_usi.message.email_n81i');
							yhForm.email.focus();
							return false;
						}
					}else{
						$("#email").next().html('i18n_usi.message.emailInput_n81i');
						return;
					}
				}
				
				if($("#y").attr('checked')==true){
					if($id("yhmm","","i18n_usi.text.yhmm_n81i")&&$id("confirm","","i18n_usi.text.confirm_n81i")){
				 		var yhmm = document.getElementById("yhmm").value;
						var confirm = document.getElementById("confirm").value;
						if(yhmm!=confirm){
							$("#confirm").next().html('i18n_usi.message.confirm_n81i');
							return;
						}else{
							document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateSelfInfo";
							document.yhForm.submit();
						}
					}
				}else{
					document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateSelfInfo";
					document.yhForm.submit();
				}
				
			}
			
			//验证非中文和特殊字符
	function containSpecial(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	}
	
	jQuery(function(){
		jQuery("tr[id=pwdUpdate]").hide();
		
		//-- 字段类型选择事件绑定
	 	jQuery("#y").click(function(){
	 		jQuery("tr[id=pwdUpdate]").show();
	 	});
	 	jQuery("#n").click(function(){
	 		jQuery("tr[id=pwdUpdate]").hide();
	 	});
	})
	
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="user.yhbh" value="${user.yhbh }" />
				
				<!--<div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 系统配置 -> 修改个人信息
				</div>
				<div style="clear: both"></div> -->
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="a">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_usi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="40%" align="right">
							i18n_usi.text.yhmc_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="user.yhmc" id="yhmc"
								value="${userInfo[0].yhmc }" disabled="disabled"/>
							<input type="hidden" name="user.yhmc"  value="${userInfo[0].yhmc }"/>
						</td>
					 </tr>
					 <tr>
						<td class="color_1" align="right" valign="top">
							i18n_usi.text.userRole_n81i：
						</td>
						<td class="color_6" align="left">
							<textarea rows="3" cols="40" name="user.userRole" id="userRole"
								disabled="disabled">${userInfo[0].userRole }</textarea>
								<input type="hidden" name="user.userRole"  value="${userInfo[0].userRole }"/>
						</td>
					</tr>
					<c:if test="${session.deptFlag==0 }">
					<tr>
						<td class="color_1" align="right">
							i18n_usi.text.userDept_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="user.userDept" id="userDept"
								value="${userInfo[0].userDept }" disabled="disabled" />
								<input type="hidden" name="user.userDept"  value="${userInfo[0].userDept }"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${session.emailFlag ==0}">
					<tr>
						<td class="color_1" align="right">
							E-mail：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="user.email" id="email"  value="${userInfo[0].email }" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_3" align="right">
							i18n_usi.text.emailRecive_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="user.isReceiveEmail" value="0"
							${userInfo[0].isReceiveEmail==0? "checked='checked' ":"" } />
							i18n_usi.message.Y_n81i
							<input type="radio" name="user.isReceiveEmail" value="1"
							${userInfo[0].isReceiveEmail==1? "checked='checked' ":"" } />
							i18n_usi.message.N_n81i
						</td>
					</tr>
					</c:if>
					<tr>
						<td class="color_1" align="right">
							i18n_usi.text.isUpdatePwd_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="isUpdatePwd" value="0" id="y"/>i18n_usi.message.Y_n81i
							<input type="radio" name="isUpdatePwd" value="1" id="n" checked="checked"/>i18n_usi.message.N_n81i
						</td>
					</tr>
					
					<tr id="pwdUpdate">
						<td class="color_1" align="right">
							i18n_usi.text.yhmm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="user.yhmm" id="yhmm" value=""/>
							<font color="red">*</font>
							<span style="color: red" id="password">i18n_uup.message.password_n81i</span>
						</td>
					</tr>
					<tr id="pwdUpdate">
						<td class="color_1" align="right">
							i18n_usi.text.confirm_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="password" name="confirm" id="confirm" value="" />
								<font color="red">*</font>
						</td>
					</tr>
					<tr>
									<td class="color_3" align="right">
										i18n_au.text.language_n81i：
									</td>
									<td class="color_6" align="left">
										 <select name="user.language">
											<option value="">--i18n_adepti.message.selectDefault_n81i--</option>
											<option value="en_US" ${userInfo[0].language=="en_US"? "selected='selected'":"" } >ENGLISH</option>
											<option value="zh_CN" ${userInfo[0].language=="zh_CN"? "selected='selected'":"" } >简体中文</option>
											<option value="ru_RU" ${userInfo[0].language=="ru_RU"? "selected='selected'":"" } >русский язык</option>
										</select> 
										<!-- <div id="flagstrap" data-input-name="user.language" ></div> 带有国旗的下拉选-->
									</td>
								</tr>
					<tr>
						<td class="color_7"  align=right colspan="2">
							&nbsp;
							<input type="button" class=btn3_mouseout id="tj"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="doUpdate('${userInfo[0].yhid }','${userInfo[0].yhbh}')" value="i18n_usi.button.submit_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['yhForm'].reset()" value="i18n_usi.button.reset_n81i"/>
							&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
