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
		<title>i18n_emi2.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
	</head>
	<script type="text/javascript">
	 
	 function goBack(){
		document.yhForm.action="<c:url value='/mission/simpleMission.do?action=select'/>";
		document.yhForm.submit();
	}

   </script>
	<body>
		<form action="" name="yhForm" method="post">
			<input type="hidden" id="missionType" name="missionState.missionType" value="${missionState.missionType }" />
<%--			<input type="hidden" name="missionState.missionType" value="1" />--%>
			<c:forEach items="${list }" var="obs">
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
					<tr>
						<td height="20" colspan="4" class="td_color">
							<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_emi2.text.title_n81i</strong></span>				
						</td>
					</tr>
					<tr>
						<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.missionName_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[1] }
							</div>
						</td>
						<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.createTime_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${obs[2]}" />
							</div>
						</td>
					</tr>
					<tr>
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.missionState_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[4] }
							</div>
						</td>
						<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.viewLevel_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
								<c:forEach items="${vlList }" var="vl" >
									<c:if test="${vl[0] eq obs[5] }">${vl[1] }</c:if>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.addUser_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[8] }
							</div>
						</td>
						<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.userGroup_n81i：</span>
							</div>
						</td>
						<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[10] }
							</div>
						</td>
					</tr>
					<tr >
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.nodeGroup_n81i：</span>
							</div>
						</td>
						<td height="28" colspan="3" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[14] }
							</div>
						</td>
					</tr>
					<tr>
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.isFilter_n81i：</span>
							</div>
						</td>
						<td height="28" colspan="3" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[15] }
							</div>
						</td>
					</tr>
					<tr >
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.filterValue_n81i：</span>
							</div>
						</td>
						<td height="28" colspan="3" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							<textarea rows="4" cols="50" disabled="true" s readonly="readonly">${obs[16] }</textarea>
							
							</div>
						</td>
					</tr>
					<tr >
					<td  class="td_color" width="20%">
							<div align="right">
								<span class="STYLE1">i18n_emi2.text.missionComments_n81i：</span>
							</div>
						</td>
					<td height="28" colspan="3" bgcolor="#FFFFFF">
						<div align="left" class="STYLE1">
						${obs[17] }
						</div>
					</td>
				</tr>
				<c:if test="${obs[17] eq 1}">
					<tr >
						<td  class="td_color" width="20%">
								<div align="right">
									<span class="STYLE1">i18n_emi2.text.startTime_n81i：</span>
								</div>
							</td>
							<td height="28" bgcolor="#FFFFFF">
								<div align="left" class="STYLE1">
								<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${obs[18]}" />
								</div>
							</td>
							<td  class="td_color" width="20%">
								<div align="right">
									<span class="STYLE1">i18n_emi2.text.endTime_n81i：</span>
								</div>
							</td>
							<td height="28" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${obs[19]}" />
							</div>
						</td>
						</tr>
						<tr >
						<td  class="td_color" width="20%">
								<div align="right">
									<span class="STYLE1">i18n_emi2.text.cycle_n81i：</span>
								</div>
							</td>
						<td height="28" colspan="3" bgcolor="#FFFFFF">
							<div align="left" class="STYLE1">
							${obs[20]}
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<td height="20" colspan="4" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="88%" align=right>
									&nbsp;
								</td>
								<td align=left  width="4%">
									<img src="<c:url value='/desktop/images/anniu/a_40${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;
									
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
			</c:forEach>
			<div style="height:22px;" mt='2'>&nbsp;</div>
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
							<tr>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.sets_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.nodeNum_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.nodeList_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.exportNode_n81i</span>
						</div>
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.context1_n81i</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">2</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1" mt=1></span>
						<span class="STYLE1" mt=2>i18n_emi2.text.nodes_n81i1:10.2.3.1<br/>i18n_emi2.text.nodes_n81i2:10.2.3.2<br>i18n_emi2.text.nodes_n81i3:10.2.3.3</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1" mt=1></span>
						<span class="STYLE1" mt=2>
						<img src="<c:url value='/desktop/images/anniu/a_41${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;
						</span>
					</div>
					</td>
				</tr>
								<tr>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.context1_n81i</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">2</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1" mt=1></span>
						<span class="STYLE1" mt=2>i18n_emi2.text.nodes_n81i1:10.2.3.1<br/>i18n_emi2.text.nodes_n81i2:10.2.3.2<br>i18n_emi2.text.nodes_n81i3:10.2.3.3</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1" mt=1></span>
						<span class="STYLE1" mt=2><img src="<c:url value='/desktop/images/anniu/a_41${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;</span>
					</div>
					</td>
				</tr>
				<tr>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.faildCause_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.nodeNum_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.nodeList_n81i</span>
						</div>
					</td>
					<td class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_emi2.text.exportNode_n81i</span>
						</div>
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.unkownException_n81i</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">3</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.nodes_n81i4:10.4.20.106<br>i18n_emi2.text.nodes_n81i5:10.4.20.109</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1"><img src="<c:url value='/desktop/images/anniu/a_41${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;</span>
					</div>
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.runtimeError_n81i</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">2</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.nodes_n81i4:10.4.20.106<br>i18n_emi2.text.nodes_n81i5:10.4.20.109</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1"><img src="<c:url value='/desktop/images/anniu/a_41${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;</span>
					</div>
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.connectNodeFaild_n81i</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">2</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1">i18n_emi2.text.nodes_n81i4:10.4.20.106<br>i18n_emi2.text.nodes_n81i5:10.4.20.109</span>
					</div>
					</td>
					<td bgcolor="#FFFFFF" class="STYLE1">
					<div align="center" class="STYLE1">
						<span class="STYLE1"><img src="<c:url value='/desktop/images/anniu/a_41${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;</span>
					</div>
					</td>
				</tr>
			</table>
			
			<div style="height:22px;">&nbsp;</div>
		</form>
		<form action="" name="yhForm2" method="post"
		<c:if test="${missionState.missionType ne 2}">
		style="display:none;"
		</c:if>
		>		
			<input type="hidden" name="missionState.missionType" value="${missionState.missionType }" />
		
		</form>
	</body>
</html>