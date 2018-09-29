<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(devTypeListInfo) > 0}">
		<c:forEach items="${devTypeListInfo}" var="devType" varStatus="vs">
			<c:set var="color" value="color_1" />
			<c:set var="color_end" value="color_7" />
			<c:if test="${vs.count%2!=0 }">
				<c:set var="color" value="color_3" />
				<c:set var="color_end" value="color_6" />
			</c:if>
			<tr>
				<td class="${color }">
					<input type="checkbox" name="ids" id="ids" value="${devType.id}"
						<c:if test="${devType.hasInstance==1}">disabled="disabled"</c:if> />
					${index+(pageNo-1)*pageSize}
				</td>
				<td class="${color }">
					${devType.deviceTypeCode}
				</td>
				<td class="${color }">
					${devType.deviceRandCode}
				</td>
				<td class="${color }">
					${devType.deviceDesc}
				</td>
				<td class="${color}">
					${devType.parDevCode}
				</td>
				<td class="${color}">
					<fmt:formatDate value="${devType.addTime}" type="both" />
				</td>
				<td class="${color_end}">
					<a href="javascript:detailDev('${devType.id}');">i18n_dtilc.text.detailDev_n81i</a>
					<c:if test="${devType.pid==0 && devType.isPositionDev!=1}">
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:toAddPosDevType('${devType.id}');">i18n_dtilc.text.toAddPosDevType_n81i</a>
					</c:if>
					<c:if test="${devType.figureFill !=null && devType.isLeaf==0 && devType.isPositionDev!=1}">
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:toConfDevPos('${devType.id}');">i18n_dtilc.text.toConfDevPos_n81i</a>
					</c:if>
				</td>
			</tr>
			<c:set var="index" value="${index + 1}" />
		</c:forEach>
	</c:when>
</c:choose>

