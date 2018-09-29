<%@ page language="java"  pageEncoding="UTF-8"%>
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
		<title>i18n_aui.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script type="text/javascript">
			function add(){
			 	if($id("yhmc","","i18n_aui.text.yhmc_n81i")&&$id("yhbh","","i18n_aui.text.yhbh_n81i")&&$id("yhmm","","i18n_aui.text.yhmm_n81i")&&$id("confirm","","i18n_aui.text.confirm_n81i")&&$id("email","","E-mail")){
			 		if(yhForm.email.value!=""){
						if(!checkEmail(yhForm.email.value.toLowerCase())){
							alert('i18n_aui.message.email_n81i');
							yhForm.email.focus();
							return false;
						}
					}
			 		if(!isRigthCheck("jsbh", "remove")){
						alert("i18n_aui.message.jsbh_n81i");
						return;
					}else{
						if(!isRigthCheck("deptid", "remove")){
							alert("i18n_aui.message.deptid_n81i");
							return;
						}else{
							var yhmm = document.getElementById("yhmm").value;
							var confirm = document.getElementById("confirm").value;
							if(yhmm!=confirm){
								alert('i18n_aui.message.confirm_n81i');
							}else{
								document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=addUserInfo";
								document.yhForm.submit();
							}
						}
						
					}
			 	}		
			 }
			 
			 function goBack(){
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryUserInfo";
				document.yhForm.submit();	
			}
			function checkZF(id){
				if(containSpecial($("#"+id).val())){
					alert('i18n_aui.message.inputInfo_n81i');
					$("#"+id).val('');
					return;
				}
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<!-- <div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 系统配置 —> 用户管理 —> 添加用户信息
				</div> -->
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_aui.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="15%">
							<strong>i18n_aui.text.baseInfo_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_3" width="15%" align="right">
										i18n_aui.text.yhbh_n81i：
									</td>
									<td class="color_6" width="50%" align="left">
										<input type="text" name="user.yhbh" id="yhbh" />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_aui.text.yhmc_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="user.yhmc" id="yhmc"  />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_aui.text.yhmm_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="password" name="user.yhmm" id="yhmm"  />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_aui.text.confirm_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="password" name="confirm" id="confirm"  />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										E-mail：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="email" id="email"  />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							<strong>i18n_aui.text.selectDept_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_aui.text.select_n81i</strong>
									</td>
									<td class="color_7" width="38%">
										<strong>i18n_aui.text.dept_n81i</strong>
									</td>
								</tr>
								<c:forEach var="dept" items="${listDeptInfo}">
									<tr>
										<td class="color_3">
											<input type="checkbox" name="deptid" value="${dept.deptid }" />
										</td>
										<td class="color_6">
											${dept.deptname}
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							<strong>i18n_aui.text.selectJs_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_aui.text.select_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_aui.text.jsbh_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_aui.text.jsmc_n81i</strong>
									</td>
									<td class="color_7" width="8%">
										<strong>i18n_aui.text.state_n81i</strong>
									</td>
								</tr>
								<c:forEach var="lji" items="${allJsInfo}">
									<tr>
										<td class="color_3">
											<input type="checkbox" name="jsbh" value="${lji.jsbh }" />
										</td>
										<td class="color_3">
											${lji.jsbh }
										</td>
										<td class="color_3">
											${lji.jsmc }
										</td>
										<td class="color_6">
											<c:if test="${lji.zxbz==0}">
												i18n_aui.message.state0_n81i
											</c:if>
											<c:if test="${lji.zxbz==1}">
												<font color="red">i18n_aui.message.state1_n81i</font>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							<strong>i18n_aui.text.selectUserGroup_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_aui.text.select_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_aui.text.userGroupId_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_aui.text.userGroup_n81i</strong>
									</td>
									<td class="color_7" width="8%">
										<strong>i18n_aui.text.state_n81i</strong>
									</td>
								</tr>
								<c:forEach var="aji" items="${yhzList}">
									<tr>
										<td class="color_3">
											<input type="checkbox" name="yhzbh" value="${aji.jsbh }" />
											<input type="hidden" name="type" value="${aji.type}" />
										</td>
										<td class="color_3">
											${aji.jsbh }
										</td>
										<td class="color_3">
											${aji.jsmc }
										</td>
										<td class="color_6">
											<c:if test="${aji.zxbz==0}">
												i18n_aui.message.state0_n81i
											</c:if>
											<c:if test="${aji.zxbz==1}">
												<font color="red">i18n_aui.message.state1_n81i</font>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="add()" value="i18n_aui.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" value="i18n_aui.button.reset_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="goBack()" value="i18n_aui.button.back_n81i"/>
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
