<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(nodeIpGroupListNew) > 0}">
		<c:forEach items="${nodeIpGroupListNew}" var="detecInfoList">
			<c:forEach items="${detecInfoList}" var="rowData" varStatus="vs">
				<c:if test="${vs.index==0}" var="flag">
					<tr>
						<c:forEach items="${rowData}" var="cellData" varStatus="ind"
							begin="2" end="9">
							<c:set var="dniId" value="${rowData[1] }" />
							<c:set var="ctiId" value="${rowData[12] }" />
							<c:set var="dsiId" value="${rowData[11] }" />
							<c:set var="nodeIp" value="${rowData[2] }" />
							<c:set var="sqId" value="${rowData[13] }" />
							<c:set var="nodeSysType" value="${rowData[14] }" />
							<c:set var="charStateNum" value="${rowData[15] }" />
							<c:set var="nodeType" value="${rowData[16] }" />
							<c:choose>
								<c:when test="${ind.index eq 2}">
									<td class="color_1_1" rowspan="${fn:length(detecInfoList)}"
										valign="top">
										<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
										<a
											href="javascript:void(0);"
											onclick="remoteConn('${nodeSysType }','${cellData}','${nodeType }', this)"><c:out
												value="${cellData}" default="" /> </a>
										
									</td>
								</c:when>
								<c:when test="${ind.index eq 3}">
									<td class="color_1_1">
										<a href="javascript:showRecord('${dniId }','${ctiId }')">
											<c:out value="${cellData}" default="" /> </a>&nbsp;
									</td>
								</c:when>
								<c:when test="${ind.index eq 4}">
									<td class="color_1_1">
										<c:out value="${cellData}" default="" />
										<c:if test="${charStateNum>0}">
											<a
												href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
												<img
													src="${pageContext.request.contextPath }/images/action.png"
													border=0 height="15" width="15" alt="" /> </a>
										</c:if>
									</td>
								</c:when>
								<c:when test="${ind.index eq 5}">
									<td class="color_1_1">
										<c:if test="${fn:trim(cellData)=='1'}">
											<img src="<c:url value='/images/yes.gif'/>" border="0"
												align="middle" />
										</c:if>
										<c:if test="${fn:trim(cellData) ne '1'}">
											<img src="<c:url value='/images/no.gif'/>" border="0"
												align="middle" />
										</c:if>
									</td>
								</c:when>
								<c:when test="${ind.index eq 6}">
									<td class="color_1_1">
										<c:out value="${cellData}" default="" />
									</td>
								</c:when>
								<c:when test="${ind.index eq 9}">
									<c:set value="${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
									<td class="color_7_1" >
										 <c:set value="${fn:replace(fn:replace(cellData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
										<span onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" >
											<%-- <c:if test="${fn:length(stateInfo) >= 50}">
												${fn:substring(stateInfo,0,50)}...
											</c:if>
											<c:if test="${fn:length(stateInfo) < 50}">
												${stateInfo}
											</c:if> --%>
											<span class="stateInfoVal">${stateInfo}</span>
											<span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span>
										</span>
									</td>							
									
								</c:when>
								<c:otherwise>
									<td class="color_1_1">
										<span class="STYLE1" style="word-break: break-all">
											${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')} </span>										
									</td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${!flag}">
					<tr>
						<c:forEach items="${rowData}" var="cellData" varStatus="ind"
							begin="2" end="9">
							<c:set var="dniId" value="${rowData[1] }" />
							<c:set var="ctiId" value="${rowData[12] }" />
							<c:set var="dsiId" value="${rowData[11] }" />
							<c:set var="nodeIp" value="${rowData[2] }" />
							<c:set var="sqId" value="${rowData[13] }" />
							<c:set var="charStateNum" value="${rowData[15] }" />
							<c:choose>
								<c:when test="${ind.index eq 2}">
								</c:when>
								<c:when test="${ind.index eq 3}">
									<td class="color_1_1">
										<a href="javascript:showRecord('${dniId }','${ctiId }')">
											<c:out value="${cellData}" default="" /> </a>&nbsp;
									</td>
								</c:when>
								<c:when test="${ind.index eq 4}">
									<td class="color_1_1">
										<c:out value="${cellData}" default="" />
										<c:if test="${charStateNum>0}">
											<a
												href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
												<img
													src="${pageContext.request.contextPath }/images/action.png"
													border=0 height="15" width="15" alt="" /> </a>
										</c:if>
									</td>
								</c:when>
								<c:when test="${ind.index eq 5}">
									<td class="color_1_1">
										<c:if test="${fn:trim(cellData)=='1'}">
											<img src="<c:url value='/images/yes.gif'/>" border="0"
												align="middle" />
										</c:if>
										<c:if test="${fn:trim(cellData) ne '1'}">
											<img src="<c:url value='/images/no.gif'/>" border="0"
												align="middle" />
										</c:if>
									</td>
								</c:when>
								<c:when test="${ind.index eq 6}">
									<td class="color_1_1" nowrap="nowrap">
										<c:out value="${cellData}" default="" />
									</td>
								</c:when>
								<c:when test="${ind.index eq 9}">
									<c:set value="${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
									<td class="color_7_1" >
										<c:set value="${fn:replace(fn:replace(cellData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
										<span onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" >
											<%-- <c:if test="${fn:length(stateInfo) >= 50}">
												${fn:substring(stateInfo,0,50)}...
											</c:if>
											<c:if test="${fn:length(stateInfo) < 50}">
												${stateInfo}
											</c:if>		 --%>
											<span class="stateInfoVal">${stateInfo}</span>
											<span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span>	
										</span>		
									</td>
								
								</c:when>
								<c:otherwise>
									<td class="color_1_1">
									    ${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}
									</td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tr>
				</c:if>
			</c:forEach>
		</c:forEach>
	</c:when>
</c:choose>
<script type="text/javascript" >
/*--------------控制表格输出长度--------------------*/
$(function(){
		var stateInfos=$(".stateInfoVal");
		for(var i=0;i<stateInfos.length;i++){
			var infoVal=$(stateInfos[i]).text().trim();
			if(infoVal.length>50){
				$(stateInfos[i]).text(infoVal.substring(0,50)).append("...");
			}else{
				$(stateInfos[i]).text(infoVal);
			}
		}
	});

</script>
