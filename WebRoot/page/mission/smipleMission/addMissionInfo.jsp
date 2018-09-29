<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
	</head>
	<script type="text/javascript">

	function add(){
 		var $form = $("form:visible").first();
		if($form.find("#upFile").size() > 0){
			if($("#systemId1").val()==0){alert("i18n_ami.message.selectSystem_n81i");return null;}
			if($("#nodeList").val()==0){alert("i18n_ami.message.selectMK_n81i");return null;}
		 	if(!$id("upFile","","i18n_ami.text.upFile_n81i")){return;}
			$form[0].action="<c:url value='/mission/simpleMission.do?action=insert'/>";
			$form[0].submit();
		}
		if($form.find("#systemId2").size()>0){
			if($("#systemId2").val()==0){alert("i18n_ami.message.selectSystem_n81i");return null;}
			if($("#filePath").val()==0){alert("i18n_ami.message.filePath_n81i");return null;}
			if($("#sets").val()==0){alert("i18n_ami.message.sets_n81i");return null;}
			$form[0].action="<c:url value='/mission/simpleMission.do?action=insert'/>";
			$form[0].submit();
		}
	 }
	 jQuery(function(){
	 	$("#sets").change(function(){
	 		$("#startFlag").val($("#sets option:selected").attr("startFlag"));
	 		$("#endFlag").val($("#sets option:selected").attr("endFlag"));
	 	});
	 });
	 function goBack(){
		document.yhForm.action="<c:url value='/mission/simpleMission.do?action=select'/>";
		document.yhForm.submit();
	}

   </script>
	<body>
		<form action="" name="yhForm" method="post" enctype="multipart/form-data"
		<c:if test="${missionState.missionType ne 1}">
		style="display:none;"
		</c:if>
		>
			<input type="hidden" name="missionState.missionType" value="${missionState.missionType }" />
<%--			<input type="hidden" name="missionState.missionType" value="1" />--%>
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
				
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_ami.text.title_n81i</strong></span>				
					</td>
				</tr>
				<tr>
					<td width="18%" bgcolor="#ffffff">					
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
								<div style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>	
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.systemName_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<select name="missionState.systemId" id="systemId1" style="display: none">
												<option value="0">i18n_ami.message.selectDefault_n81i..</option>
												<c:forEach items="${sysList}" var="sys">
													<option value='${sys[0] }'<c:if test="${sys[0] eq missionState.systemId }">selected="selected"</c:if> >${sys[1] }</option>
												</c:forEach>
											</select>
											<c:forEach items="${sysList}" var="sys">
													<c:if test="${sys[0] eq missionState.systemId }">${sys[1] }</c:if>
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.module_n81i：<div style="display: none;">i18n_ami.text.deployedNodeGroup_n81i，node_List_id</div></span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<select name="missionParameter1.nodeListId" id="nodeList">
												<option value="0">i18n_ami.message.selectDefault_n81i..</option>
												<option value='10'>i18n_ami.message.selectMK10_n81i</option>
												<option value='11'>i18n_ami.message.selectMK11_n81i</option>
												<option value='12'>i18n_ami.message.selectMK12_n81i</option>
												<option value='13'>i18n_ami.message.selectMK13_n81i</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.message.selectUpFile_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="button" value="i18n_ami.message.selectUpFile_n81i" title="i18n_ami.message.selectUpFile_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
											<input type="file" onchange="javascript:setValue(this.value)" name="upload" id="upFile" style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" /> 
										</div>
									</td>
								</tr>
								<tr><td colspan="2" style="height: 20px;"></td></tr>																					
						    </table>
						
					</td>
				</tr>
				<tr>
					<td height="20" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="92%" align=right>
									<img onclick="add()" src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td width="1%" align=right>
									&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<form action="" name="yhForm2" method="post" 
<%--		enctype="multipart/form-data"--%>
		<c:if test="${missionState.missionType ne 2}">
		style="display:none;"
		</c:if>
		>
			<input type="hidden" name="missionState.missionType" value="2" />
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_ami.text.checkSets_n81i</strong></span>				
					</td>
				</tr>
				<tr>
					<td width="18%" bgcolor="#ffffff">					
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
								<div style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>	
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.systemName_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<select name="missionState.systemId" id="systemId2" style="display: none">
												<option value="0">i18n_ami.message.selectDefault_n81i..</option>
												<c:forEach items="${sysList}" var="sys">
													<option value='${sys[0] }'<c:if test="${sys[0] eq missionState.systemId }">selected="selected"</c:if> >${sys[1] }</option>
												</c:forEach>
											</select>
											<c:forEach items="${sysList}" var="sys">
													<c:if test="${sys[0] eq missionState.systemId }">${sys[1] }</c:if>
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.filePath_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
<%--											<input type="file" name="upload" id="upFile2"/> --%>
											<select name="missionParameter2.filePath" id="filePath">
												<option value="0">i18n_ami.message.selectDefault_n81i..</option>
												<option value="main.conf">main.conf</option>
												<option value="cpp.conf">cpp.conf</option>
												<option value="test.conf">test.conf</option>
												<option value="deploy.conf">deploy.conf</option>
												<option value="head.conf">head.conf</option>
											</select>
										</div>
									</td>
								</tr>
									<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.sets_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<select name="sets" id="sets">
												<option value="0" startFlag="" endFlag="" >i18n_ami.message.selectDefault_n81i..</option>
												<option value="1" startFlag="i18n_ami.message.passback_n81iAA" endFlag="i18n_ami.message.passback_n81iBB" >i18n_ami.message.passback_n81i</option>
												<option value="2" startFlag="i18n_ami.message.flyer_n81iA" endFlag="i18n_ami.message.flyer_n81iB" >i18n_ami.message.flyer_n81i</option>
												<option value="3" startFlag="i18n_ami.message.presetInfo_n81i1" endFlag="i18n_ami.message.presetInfo_n81i2" >i18n_ami.message.presetInfo_n81i</option>
												<option value="4" startFlag="i18n_ami.message.testNetwork_n81i1" endFlag="i18n_ami.message.testNetwork_n81i1" >i18n_ami.message.testNetwork_n81i</option>
											</select>
											<input type="hidden" name="missionParameter2.startFlag" id="startFlag"/>
											<input type="hidden" name="missionParameter2.endFlag" id="endFlag"/>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_ami.text.filterFlag_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<span class="STYLE1"><input type="radio" value="0" name="filterFlag" id="filterFlag" checked="checked">i18n_ami.message.yes_n81i 
										&nbsp;&nbsp;&nbsp;<input type="radio"value="1"  name="filterFlag" id="filterFlag" >i18n_ami.message.no_n81i 
										</span>
<%--										<textarea rows="4" cols="40" id="keyFilter" name="missionParameter2.filterKeyword"></textarea>--%>
									</td>
								</tr>
								<tr><td colspan="2" style="height: 20px;"></td></tr>																					
						    </table>
					</td>
				</tr>

				<tr>
					<td height="20" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="92%" align=right>
									<img onclick="add()" src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td width="1%" align=right>
									&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>