<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter", "\n");
%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(detectionInfoWarningList) > 0}">
		<c:forEach items="${detectionInfoWarningList}" var="detectionInfo"
			varStatus="index">
			<c:set var="color" value="color_1" />
			<c:set var="color_end" value="color_7" />
			<c:if test="${vs.count%2!=0 }">
				<c:set var="color" value="color_3" />
				<c:set var="color_end" value="color_6" />
			</c:if>
			<tr>
				<td class="${color }">
					<c:out value="${detectionInfo[0]}" />
				</td>
				<td class="${color }">
					<c:out value="${detectionInfo[1]}" />
				</td>
				<td class="${color }">
					<c:out value="${detectionInfo[2]}" />
				</td>
				<td class="${color }">
					<c:if test="${fn:trim(detectionInfo[3])=='1'}">
						<img src="<c:url value='/images/yes.gif'/>" border="0"
							align="middle" />
					</c:if>
					<c:if
						test="${fn:trim(detectionInfo[3]) == '0' ||fn:trim(detectionInfo[3]) == '-1'}"
						var="handshakeEr">
						<img src="<c:url value='/images/no.gif'/>" border="0"
							align="middle" />
					</c:if>
				</td>
				<td class="${color }">
					<c:out value="${detectionInfo[4]}" />
				</td>
				<td class="${color }">
					<c:out value="${detectionInfo[5]}" />
				</td>
				<td class="${color_end }">
					<div class="pop-content">
						${fn:replace(fn:replace(detectionInfo[6],vEnter,'$@$'),'$@$','<br/>')}
					</div>
				</td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>