<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dwi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
	
	function goBack(){
		var nodeType='${nodeType}';
		var url;
		if("${type}"=="3Droom"){
			url="<c:url value='/detection/detectionWarning.do?action=queryAll'/>";
		}else if(nodeType == '0'){
			url="<c:url value='/detection/detectionWarning.do?action=query'/>";
		}else if(nodeType == '1'){
			url="<c:url value='/detection/detectionWarning.do?action=queryNE'/>";
		}else{
			url="<c:url value='/detection/detectionWarning.do?action=queryAllConfigLevel'/>";//告警信息
		}
		document.Mkform.action=url;
		document.Mkform.submit();	
	}


</script>
	<body>
	<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_dwi.button.back_n81i"/>
			 </div>
			 <div style="height: 25px"></div>
			<form action="" name="Mkform" method="post">
			<!-- 查询页面查询条件 Start -->
				<input type="hidden" name="police_level" value="${police_level }">
				<input type="hidden" name="ctn" value="${ctn }" />
				<input type="hidden" name="ip" value="${ip }" />
				<input type="hidden" name="dct" value="${dct }" />
				<input type="hidden" name="stateInfo" id="stateInfo" value="${stateInfo }" />
				<input type="hidden" name="pIden" value="${pIden }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="timeoutDetecFilter" value="${timeoutDetecFilter}" />
				<!-- 从监测网元信息进入的参数 -->
				<input type="hidden" name="entry" value="${entry}"/>
				<input type="hidden" name="detectId" value="${detectId}"/>
				<input type="hidden" name="seqId" value="${seqId}"/>
				<input type="hidden" name="police_emergent" value="${police_emergent}"/>
				<input type="hidden" name="nodeIpRange" value="${nodeIpRange}"/>
				
				<input type="hidden" name="nodeType" value="${nodeType}"/>
				<input type="hidden" name="type" value="${type}"/>
				
	        <input type="hidden" name="nameFlag" value="${nameFlag}"/>
				<input type="hidden" name="pid" value="${pid}"/>
				<input type="hidden" name="isLeaf" value="${isLeaf}"/>
				<input type="hidden" name="picId" value="${picId}"/>
				<input type="hidden" name="queryParConditionDisplay" value="${queryParConditionDisplay}"/>
				<input type="hidden" name="queryChildConditionDisplay" value="${queryChildConditionDisplay}"/>   	
			
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
			<!-- 查询页面查询条件 end -->
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_dwi.message.warningInfo_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_dwi.text.processIdenName_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${detectionWarningInfo.detectionSetInfo.processIdenName}	
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_dwi.text.nodeIp_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${nodeIp}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" >
							i18n_dwi.text.detecationState_n81i：
						</td>
						<td class="color_3" align="left" >
							<c:if test="${detectionWarningInfo.detectionedState=='0' }"><font color="#FF0000">i18n_dwi.message.abnormal_n81i</font></c:if> 
							<c:if test="${detectionWarningInfo.detectionedState=='1' }">i18n_dwi.message.normal_n81i</c:if>
							<c:if test="${detectionWarningInfo.detectionedState=='-1' }"><font color="#FF0000">i18n_dwi.message.execFailed_n81i</font></c:if>
						</td>
						<td class="color_1" align="right">
							i18n_dwi.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionWarningInfo.detectionSetInfo.viewLevel=='1' }">i18n_dwi.message.publisher_n81i</c:if> 
							<c:if test="${detectionWarningInfo.detectionSetInfo.viewLevel=='2' }">i18n_dwi.message.publisherGroup_n81i</c:if>
							<c:if test="${detectionWarningInfo.detectionSetInfo.viewLevel=='3' }">i18n_dwi.message.allInSys_n81i</c:if> 
							<c:if test="${detectionWarningInfo.detectionSetInfo.viewLevel=='4' }">i18n_dwi.message.unlimited_n81i</c:if>
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dwi.text.stateInfo_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${fn:replace(fn:replace(detectionWarningInfo.detectionStateInfo,vEnter,'$@$'),'$@$','<br/>')}
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dwi.text.performaceData_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${fn:replace(fn:replace(detectionWarningInfo.performaceData,vEnter,'$@$'),'$@$','<br/>')}
						</td>
					</tr>
<%--					<tr>--%>
<%--						<td class="color_1" align="right">--%>
<%--							监测首次执行时间：--%>
<%--						</td>--%>
<%--						<td class="color_3" align="left">--%>
<%--							<fmt:formatDate value="${detectionWarningInfo.detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
<%--						</td>--%>
<%--						<td class="color_1" align="right">--%>
<%--							上传监测数据时间间隔(分钟)：--%>
<%--						</td>--%>
<%--						<td class="color_3" align="left">--%>
<%--							${detectionWarningInfo.detectionSetInfo.uploadGap}--%>
<%--						</td>--%>
<%--					</tr>--%>
					<tr>						
						<td class="color_1" align="right">
							i18n_dwi.text.checkGap_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionWarningInfo.detectionSetInfo.checkGap}
						</td>
						<td class="color_1" align="right">
							i18n_dwi.text.currentTimes_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionWarningInfo.currentTimes }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dwi.text.nextCheckTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionWarningInfo.nextCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right" >
							i18n_dwi.text.dataArriveTime_n81i：
						</td>
						<td class="color_3" align="left" >
							<fmt:formatDate value="${detectionWarningInfo.dataArriveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					
					<tr>
						<td class="color_1" align="right" >
							i18n_dwi.text.dataCheckTime_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							<fmt:formatDate value="${detectionWarningInfo.dataCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<!-- 
						<td class="color_1" align="right">
							监测方式：
						</td>
						<td class="color_3" align="left" >
							<c:if test="${detectionWarningInfo.detectionSetInfo.checkWay == '0'}">主动</c:if> 
							<c:if test="${detectionWarningInfo.detectionSetInfo.checkWay == '1'}">被动</c:if>
						</td>
						 -->
					</tr>
					<tr>
						<td colspan="4" align="center" class="color_8">
							<strong>i18n_dwi.text.warningInfo_n81i</strong>
						</td>
					</tr>
					<tr>
						<td  align="center" colspan="4" class="color_6">
							<c:if test="${!empty infoMap}">
								<table align="center" border="0" cellpadding="0" cellspacing="1" >
									<c:forEach items="${infoMap}" var="datarow" >
										<tr>
											<td class="color_1" width="30%" align="right">
												${datarow.key}：
											</td>
											<td class="color_3" width="30%" align="left">
												${datarow.value}
											</td>
										</tr>
									</c:forEach>
								</table>
							</c:if>
							<c:if test="${empty infoMap}">i18n_dwi.text.noRecord_n81i</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
