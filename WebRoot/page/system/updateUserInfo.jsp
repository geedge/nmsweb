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
		<title>i18n_uui.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
			function doUpdate(yhid,yhbh){
				//alert(yhid);
				if($id("yhmc","","i18n_uui.text.yhmc_n81i") && $id("email","","E-mail")){
			 		if(!isRigthCheck("jsbh", "remove")){
						alert("i18n_uui.message.selectRole_n81i");
						return;
					}else {
						if(!isRigthCheck("deptid", "remove")){
						alert("i18n_uui.message.deptid_n81i");
						return;
						}else{
							document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateUserInfo&yhid="+yhid+"&yhbh="+encodeURI(yhbh);
							document.yhForm.submit();				
						}
					}
				}
			}
			
			function goBack(){
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryUserInfo";
				document.yhForm.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<!-- <div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 系统配置 —> 用户管理 —> 修改用户信息
				</div> -->
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_uui.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="15%">
							<strong>i18n_uui.text.baseInfo_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_3" width="15%" align="right">
										i18n_uui.text.yhbh_n81i：
									</td>
									<td class="color_6" width="50%" align="left">
										<input type="text" name="user.yhbh" id="yhbh"
											value="${userInfo[0].yhbh }"  readonly="readonly" />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_uui.text.yhmc_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="user.yhmc" id="yhmc"
											value="${userInfo[0].yhmc }"  />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										E-mail：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="user.email" id="email" value="${userInfo[0].email }"  />
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_uui.text.state_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="radio" name="user.zxbz" value="0"
											${userInfo[0].zxbz==0? "checked='checked' ":"" } />
										i18n_uui.message.state0_n81i
										<input type="radio" name="user.zxbz" value="1"
											${userInfo[0].zxbz==1? "checked='checked' ":"" }/>
										i18n_uui.message.state1_n81i
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							<strong>i18n_uui.text.selectDept_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_uui.message.select_n81i</strong>
									</td>
									<td class="color_7" width="38%">
										<strong>i18n_uui.text.deptName_n81i</strong>
									</td>
								</tr>
								<c:forEach var="dept" items="${listDeptInfo}">
									<tr>
										<td class="color_3">
											<c:if test="${dept.isChecked!=null}">
												<input type="checkbox" name="deptid" value="${dept.deptid}"
													checked="checked" />
											</c:if>
											<c:if test="${dept.isChecked==null}">
												<input type="checkbox" name="deptid" value="${dept.deptid}" />
											</c:if>
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
							<strong>i18n_uui.text.selectRole_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_uui.message.select_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_uui.text.roleId_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_uui.text.roleName_n81i</strong>
									</td>
									<td class="color_7" width="8%">
										<strong>i18n_uui.text.state_n81i</strong>
									</td>
								</tr>
								<c:forEach var="lji" items="${listJsInfo}">
									<tr>
										<td class="color_3">
											<c:if test="${lji.isChecked!=null}">
												<input type="checkbox" name="jsbh" value="${lji.jsbh }"
													checked="checked" />
											</c:if>
											<c:if test="${lji.isChecked==null}">
												<input type="checkbox" name="jsbh" value="${lji.jsbh }" />
											</c:if>
										</td>
										<td class="color_3">
											${lji.jsbh }
										</td>
										<td class="color_3">
											${lji.jsmc }
										</td>
										<td class="color_6">
											<c:if test="${lji.zxbz==0}">
												i18n_uui.message.state0_n81i
											</c:if>
											<c:if test="${lji.zxbz==1}">
												<font color="red">i18n_uui.message.state1_n81i</font>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							<strong>i18n_uui.text.selectUserGroup_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_1" width="6%">
										<strong>i18n_uui.message.select_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_uui.text.userGroupId_n81i</strong>
									</td>
									<td class="color_1" width="15%">
										<strong>i18n_uui.text.userGroup_n81i</strong>
									</td>
									<td class="color_7" width="8%">
										<strong>i18n_uui.text.state_n81i</strong>
									</td>
								</tr>
								<c:forEach var="aji" items="${yhzList}">
									<tr>
										<td class="color_3">
											<c:if test="${aji.isChecked!=null}">
												<input type="checkbox" name="yhzbh" value="${aji.jsbh }"
													checked="checked" />
											</c:if>
											<c:if test="${aji.isChecked==null}">
												<input type="checkbox" name="yhzbh" value="${aji.jsbh }" />
											</c:if>
										</td>
										<td class="color_3">
											${aji.jsbh }
										</td>
										<td class="color_3">
											${aji.jsmc }
										</td>
										<td class="color_6">
											<c:if test="${aji.zxbz==0}">
												i18n_uui.message.state0_n81i
											</c:if>
											<c:if test="${aji.zxbz==1}">
												<font color="red">i18n_uui.message.state1_n81i</font>
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
											onclick="doUpdate('${userInfo[0].yhid }','${userInfo[0].yhbh}')" 
											value="i18n_uui.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" 
											value="i18n_uui.text.reset_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" onclick="goBack()" 
											value="i18n_uui.text.back_n81i"/>
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
