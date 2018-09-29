<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(nodeFigureInfoList) > 0}">
		<c:forEach items="${nodeFigureInfoList}" var="nodeFigureInfo" varStatus="vs">
			<c:set var="color" value="color_1" />
			<c:if test="${vs.count%2!=0 }">
				<c:set var="color" value="color_3" />
			</c:if>
			<tr>
				<td class="${color }">
					${index+(pageNo-1)*pageSize}
				</td>
				<td class="${color }">
					${nodeFigureInfo.nameFlag}
				</td>
				<td class="${color }">
					<input type="hidden" name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].id"
						value="${nodeFigureInfo.id }" />
					<input type="radio"
						name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].portsetState" value="1"
						<c:if test="${nodeFigureInfo.portsetState !=2 }">checked</c:if> />
					<font color="green">UP</font>
					<input type="radio"
						name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].portsetState" value="2"
						<c:if test="${nodeFigureInfo.portsetState ==2 }">checked</c:if> />
					<font color="red">DOWN</font>
				</td>
				<td class="${color }">
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:save('${index+(pageNo-1)*pageSize}');" value="i18n_tcpc.button.save_n81i" />
				</td>
			</tr>
		<c:set var="index" value="${index + 1}" />
		</c:forEach>
	</c:when>
</c:choose>