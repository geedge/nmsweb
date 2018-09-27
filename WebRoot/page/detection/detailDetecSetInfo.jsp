<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_ddsi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
	
	function goBack(){
		document.Mkform.action="<%=path%>/detection/detectionSet.do?action=query";
		document.Mkform.submit();	
	}

	$(function(){
		//下载附件
		$(".downloadA").click(function(){
			window.location="<%=path%>/detection/detectionSet.do?action=downloadScript&myFileFileName=${myFileFileName}";
		});
	});
</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_ddsi.button.back_n81i"/>
			 </div>
			 <div style="height: 25px"></div>
			<form action="" name="Mkform" method="post">
				<input type="hidden" name="ip" id="ip" value="${ip }" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="pIden" id="pIden" value="${pIden }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<table border="0" cellpadding="0" cellspacing="0" class="table" style="table-layout: fixed;word-wrap:break-word;">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_ddsi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.processIdenName_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${detectionSetInfo.processIdenName }
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.processIden_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${detectionSetInfo.processIden }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.nodeGroup_n81i：
						</td>
						<td class="color_6" align="left" width="20%">
							${detectionSetInfo.nodeGroupsName }
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.nodeIp_n81i：
						</td>
						<td class="color_3" align="left" width="20%" >
							${detectionSetInfo.nodeIpsName }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.checkTypeName_n81i：
						</td>
						<td class="color_6" align="left" width="20%">
							${detectionSetInfo.checkTypeInfo.checkTypeName1 }
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_ddsi.text.checkType_n81i：
						</td>
						<td class="color_6" align="left" width="20%">
							${detectionSetInfo.checkTypeInfo.checkTypeName }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
						i18n_ddsi.text.checkWay_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.checkWay == '1' }">i18n_ddsi.message.passive_n81i</c:if>
							<c:if test="${detectionSetInfo.checkWay == '0' }">i18n_ddsi.message.active_n81i</c:if>
						</td>
						<td class="color_1" align="right">
							i18n_ddsi.text.detectionSetState_n81i：
						</td>
						<td class="color_6" align="left">
							<c:if test="${detectionSetInfo.detectionSetState == '1' }">i18n_ddsi.message.valid_n81i</c:if> 
							<c:if test="${detectionSetInfo.detectionSetState == '0' }">i18n_ddsi.message.invalid_n81i</c:if> 
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ddsi.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.viewLevel=='1' }">i18n_ddsi.message.publisher_n81i</c:if> 
							<c:if test="${detectionSetInfo.viewLevel=='2' }">i18n_ddsi.message.publisherGroup_n81i</c:if>
							<c:if test="${detectionSetInfo.viewLevel=='3' }">i18n_ddsi.message.allInSys_n81i</c:if> 
							<c:if test="${detectionSetInfo.viewLevel=='4' }">i18n_ddsi.message.unlimited_n81i</c:if>
						</td>
						<td class="color_1" align="right">
							i18n_ddsi.text.isSchedule_n81i：
						</td>
						<td class="color_6" align="left" >
							<c:if test="${detectionSetInfo.checkTypeInfo.isSchedule=='0' }">i18n_ddsi.message.isSchedule0_n81i</c:if> 
							<c:if test="${detectionSetInfo.checkTypeInfo.isSchedule=='1' }">i18n_ddsi.message.isSchedule1_n81i</c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ddsi.text.checkGap_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionSetInfo.checkGap }
						</td>
						<!-- 
						<td class="color_1" align="right">
							上传监测数据时间间隔(分钟)：
						</td>
						<td class="color_6" align="left">
							${detectionSetInfo.uploadGap }
						</td>
						 -->
						 <td class="color_1" align="right">
							i18n_ddsi.text.checkOutTime_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionSetInfo.checkOutTime }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ddsi.text.planCheckTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right">
							i18n_ddsi.text.checkMaxTimes_n81i：
						</td>
						<td class="color_6" align="left">
							${detectionSetInfo.checkMaxTimes }
						</td>
					</tr>
					<%-- 1. 系统预置监测 --%>
					<c:if test="${detectionSetInfo.id < 8}">
					<tr>
						<td class="color_1" align="right">
							i18n_ddsi.text.processFile_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionSetInfo.processFile }
						</td>
						<td class="color_1" align="right">
							i18n_ddsi.text.processPath_n81i：
						</td>
						<td class="color_6" align="left">
							${detectionSetInfo.processPath }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ddsi.text.isControlStart_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.id < 8}">i18n_ddsi.text.ncStartup_n81i</c:if>
							<c:if test="${detectionSetInfo.id >= 8}">
								<c:if test="${detectionSetInfo.isControlStart=='0' }">i18n_ddsi.message.manually_n81i</c:if> 
								<c:if test="${detectionSetInfo.isControlStart=='1' }">i18n_ddsi.message.singleStart_n81i</c:if>
								<c:if test="${detectionSetInfo.isControlStart=='2' }">i18n_ddsi.message.cycleStart_n81i</c:if>
							</c:if>
						</td>
						<td class="color_1" align="right">
							i18n_ddsi.text.controlStartTime_n81i：
						</td>
						<td class="color_6" align="left">
							<fmt:formatDate value="${detectionSetInfo.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					</c:if><%-- end of 1 --%>
					<%-- 2.1 第三方监测手动启动 --%>
					<c:if test="${detectionSetInfo.id >= 8 and detectionSetInfo.isControlStart == '0'}">
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.processFile_n81i：</td>
						<td class="color_3" align="left">${detectionSetInfo.processFile }</td>
						<td class="color_1" align="right">i18n_ddsi.text.processSearchCode_n81i：</td>
						<td class="color_6" align="left">${detectionSetInfo.processSearchCode }</td>
					</tr>
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.isControlStart_n81i：</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.isControlStart=='0' }">i18n_ddsi.message.manually_n81i</c:if> 
							<c:if test="${detectionSetInfo.isControlStart=='1' }">i18n_ddsi.message.singleStart_n81i</c:if>
							<c:if test="${detectionSetInfo.isControlStart=='2' }">i18n_ddsi.message.cycleStart_n81i</c:if>
						</td>
						<td class="color_1" align="right"></td>
						<td class="color_6" align="left"></td>
					</tr>
					</c:if><%-- end of 2.1 --%>
					<%-- 2.2 第三方监测NC单次启动 --%>
					<c:if test="${detectionSetInfo.id >= 8 and detectionSetInfo.isControlStart == '1'}">
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.isControlStart_n81i：</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.isControlStart=='0' }">i18n_ddsi.message.manually_n81i</c:if> 
							<c:if test="${detectionSetInfo.isControlStart=='1' }">i18n_ddsi.message.singleStart_n81i</c:if>
							<c:if test="${detectionSetInfo.isControlStart=='2' }">i18n_ddsi.message.cycleStart_n81i</c:if>
						</td>
						<td class="color_1" align="right">i18n_ddsi.text.controlStartTime_n81i：</td>
						<td class="color_6" align="left">
							<fmt:formatDate value="${detectionSetInfo.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.processFile_n81i：</td>
						<td class="color_3" align="left">${detectionSetInfo.processFile }</td>
						<td class="color_1" align="right">i18n_ddsi.text.processSearchCode_n81i：</td>
						<td class="color_6" align="left">${detectionSetInfo.processSearchCode }</td>
					</tr>
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.processPath_n81i：</td>
						<td class="color_3" align="left">${detectionSetInfo.processPath }</td>
						<td class="color_1" align="right"></td>
						<td class="color_6" align="left"></td>
					</tr>
					</c:if><%-- end of 2.2 --%>
					<%-- 2.3 第三方监测NC周期启动类型 --%>
					<c:if test="${detectionSetInfo.id >= 8 and detectionSetInfo.isControlStart == '2'}">
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.isControlStart_n81i：</td>
						<td class="color_3" align="left">
							<c:if test="${detectionSetInfo.isControlStart=='0' }">i18n_ddsi.message.manually_n81i</c:if> 
							<c:if test="${detectionSetInfo.isControlStart=='1' }">i18n_ddsi.message.singleStart_n81i</c:if>
							<c:if test="${detectionSetInfo.isControlStart=='2' }">i18n_ddsi.message.cycleStart_n81i</c:if>
						</td>
						<td class="color_1" align="right">i18n_ddsi.text.controlStartTime_n81i：</td>
						<td class="color_6" align="left">
							<fmt:formatDate value="${detectionSetInfo.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">i18n_ddsi.text.myFileFile_n81i：</td>
						<td class="color_3" align="left">
							<a title="点击下载" href="#" class="downloadA" id="scriptFile">${myFileFileName}</a>
						</td>
						<td class="color_1" align="right"></td>
						<td class="color_6" align="left"></td>
					</tr>
					</c:if><%-- end of 2.3 --%>
				</table>		
			</form>
		</div>
	</body>
</html>
