<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
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
		<title>i18n_mspm2.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>"
			rel="stylesheet" type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>"
			type="text/javascript"></script>
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
		<link rel="stylesheet" href="<c:url value='/desktop/css/themes/base/jquery.ui.all.css'/>">
		<script type="text/javascript"
			src="<c:url value='/desktop/ui/jquery.ui.core.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/desktop/ui/jquery.ui.widget.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/desktop/ui/jquery.ui.tabs.js'/>"></script>
		<style type="text/css">
			.ui-widget-content { border: 0px; margin:0px; padding:0px}
			.ui-widget-header { border: 1px solid #d7fcfe; filter:glow(color=red,strength=10); background: #d7fcfe url(images/ui-bg_highlight-soft_33_3a8104_1x100.png) 50% 50% repeat-x; color: #ffffff; font-weight: bold; }
		</style>
		<script type="text/javascript">
			$(function() {
				$( "#tabs" ).tabs({
				});
			});
	   </script>
	</head>
	<body>
		<form action="" name="yhForm" method="post">
			<input type="hidden" name="position" value="${position }">
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color">
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_mspm2.text.title_n81i</strong>
						</span>
					</td>
				</tr>
				<tr>
					<td width="18%" bgcolor="#ffffff">
						<table width="100%" align="center" border="0" cellpadding="0"
							cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
							<div
								style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>
							<tr>
								<td bgcolor="#FFFFFF" width="20%" nowrap="nowrap">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.missionName_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionstatetable.missionName}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.missionType_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"><c:if
												test="${missionstatetable.missionType eq 1}">i18n_mspm2.message.missionType1_n81i</c:if> <c:if
												test="${missionstatetable.missionType eq 2}">i18n_mspm2.message.missionType2_n81i</c:if>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.systemIdName_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionstatetable.systemIdName}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.filePath_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionparameteriable2.filePath}</span>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%" nowrap="nowrap">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.missionDesc_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionparameteriable2.missionDesc}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.viewLevel_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"><c:if
												test="${missionstatetable.viewLevel eq 1}">i18n_mspm2.message.publisher_n81i</c:if> <c:if
												test="${missionstatetable.viewLevel eq 2}">i18n_mspm2.message.publisherGroup_n81i</c:if> <c:if
												test="${missionstatetable.viewLevel eq 3}">i18n_mspm2.message.allInSys_n81i</c:if>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.message.user_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionstatetable.userIdName}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.message.filterCode_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionparameteriable2.filterKeyword}</span>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.startTime_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"><fmt:formatDate value="${missionstatetable.startTime}" type="both"/></span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.endTime_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"><fmt:formatDate value="${missionstatetable.endTime}" type="both"/></span>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.startFlag_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionparameteriable2.startFlag}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_mspm2.text.endFlag_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1">${missionparameteriable2.endFlag}</span>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<table width="80%" align="center" align="center" cellpadding="0" cellspacing="1" class="ta_color">
					<div
						style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>
					<tr>
						<td>
							<div id="tabs">
								<ul>
									<li><a href="#tabs-1">
										<span class="STYLE1"><strong>i18n_mspm2.text.totalChart_n81i</strong></span>
										</a>
									</li>
									<c:if test="${missionstatetable.loopFlag==1}">
										<li><a href="#tabs-2">
											<span class="STYLE1"><strong>i18n_mspm2.text.lineChart_n81i</strong></span>
											</a>
										</li>
										<li><a href="#tabs-3">
											<span class="STYLE1"><strong>i18n_mspm2.text.columnarChart_n81i</strong></span>
											</a>
										</li>
									</c:if>
								</ul>
								<div id="tabs-1" align="center">
									<iframe name="I1" width="800px"  height="380px"
										src="nmsTaskManager!executeAction.do?action=resultChart&type=pie&missionId=${missionstatetable.missionId}"  
										allowtransparency="true"  border="0" frameborder="0" scrolling="no" >
		 								i18n_mspm2.text.browerInfo_n81i
		 							</iframe>
								</div>
								<c:if test="${missionstatetable.loopFlag==1}">
									<div id="tabs-2" align="center">
										<iframe name="I1"  width="800px"  height="380px"
											src="nmsTaskManager!executeAction.do?action=resultChart&type=line&missionId=${missionstatetable.missionId}"  
											allowtransparency="true"  border="0" frameborder="0" scrolling="no" >
			 								i18n_mspm2.text.browerInfo_n81i
			 							</iframe>
									</div>
									<div id="tabs-3" align="center">
										<iframe name="I1"  width="800px"  height="380px"
											src="nmsTaskManager!executeAction.do?action=resultChart&type=column&missionId=${missionstatetable.missionId}"  
											allowtransparency="true"  border="0" frameborder="0" scrolling="no" >
			 								i18n_mspm2.text.browerInfo_n81i
			 							</iframe>
									</div>
								</c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_color" align="center" height="35px">
							<img src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
								border="0" align="middle" onclick="javascript:history.go(-1);" />
						</td>
					</tr>
				</table>
				
				<table width="80%" align="center" align="center" cellpadding="0"
					cellspacing="1" class="ta_color">
					<div
						style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>

				<tr>
						<td width="10%" class="td_color">
							<div align="center">
								<span class="STYLE1">i18n_mspm2.text.missionName_n81i</span>
							</div>
						</td>
						<td width="10%" class="td_color">
							<div align="center">
								<span class="STYLE1">i18n_mspm2.text.nodeIp_n81i</span>
							</div>
						</td>
						<td width="10%" class="td_color" nowrap>
							<div align="center">
								<span class="STYLE1">i18n_mspm2.text.returnResult_n81i</span>
							</div>
						</td>
						<td width="10%" class="td_color">
							<div align="center">
								<span class="STYLE1">i18n_mspm2.text.result_n81i</span>
							</div>
						</td>
					</tr>
					<c:forEach items="${resultObjects}" var="result">
						<tr>
							<td bgcolor="#FFFFFF">
								<div align="center" class="STYLE1">
									<span class="STYLE1">${result[0]}</span>
								</div>
							</td>
							<td bgcolor="#FFFFFF">
								<div align="center" class="STYLE1">
									<span class="STYLE1">${result[1]}</span>
								</div>
							</td>
							<td bgcolor="#FFFFFF">
								<div align="center" class="STYLE1">
									<span class="STYLE1"><c:if test="${result[1] eq  0}">i18n_mspm2.message.success_n81i</c:if>
									<c:if test="${result[1] ne  0}">i18n_mspm2.message.faile_n81i</c:if></span>
								</div>
							</td>
							<td bgcolor="#FFFFFF">
								<div align="center" class="STYLE1">
									<span class="STYLE1">${result[3]}</span>
								</div>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="4" class="td_color">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								class="td_color">
									<tr>
											<td colspan="1">
												<button    style="border-style: none;background-color: transparent;background-image: url(<c:url value='/desktop/images/anniu/button${userBgColor }.png'/>);vertical-align: middle;" onmouseover="this.className='hover';"
													onmouseout="this.className='normal';">
													i18n_mspm2.button.exportFaildNode_n81i
												</button>
											</td>
											<td colspan="2">
												<img
													src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
													border="0" align="middle"
													onclick="javascript:history.go(-1);" />
											</td>
										</tr>
							</table>
						</td>
					</tr>
				</table>
			</table>
		</form>
	</body>
</html>
<script>
function selectUpper(opt){
	if(opt==0){
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].value="-1";
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].text="i18n_mspm2.text.select_n81i";
		document.getElementById("upperlayer").disabled=true;
		//alert(document.getElementById("upperlayer").value);
	}else{
		document.getElementById("upperlayer").disabled=false;
	}
}
</script>