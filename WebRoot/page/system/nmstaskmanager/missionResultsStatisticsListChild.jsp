<%@ page language="java" import="java.util.*,java.math.BigInteger,java.text.NumberFormat" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
	<c:set var="index" value="${page.totalCount - (pageNo-1)*page.pageSize}" />
	<c:choose>
	<c:when test="${fn:length(loopInfolist)>0}">
		<c:forEach items="${loopInfolist }" var="objs" >
			<c:if test="${index%2 eq 1}">
				<c:set var="tdClass" value="color_1" />
				<c:set var="tdClassR" value="color_7" />
			</c:if>
			<c:if test="${index%2 eq 0}">
				<c:set var="tdClass" value="color_3" />
				<c:set var="tdClassR" value="color_6" />
			</c:if>
			<tr>
				<td class="${tdClass }"><a href="javaScript:searchResults(${objs[0] },${objs[1] })">i18n_mrslc.text.searchResults_n81i${index }i18n_mrslc.text.searchResults.cycle_n81i</a></td>
				<td class="${tdClass }"><a href="javaScript:searchResults(${objs[0] },${objs[1] })">${objs[2] }&nbsp;-&nbsp;${objs[3] }</a>
				</td>
				<td class="${tdClass }">${objs[6] }</td>
				<td class="${tdClass }">${objs[7] }</td>
				<td class="${tdClass }">${objs[8] }</td>
				<td class="${tdClass }">${objs[9] }</td>
				<td class="${tdClassR }">${objs[10] }</td>
			</tr>
			<c:set var="index" value="${index-1}" />
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td class="td_2" colspan="7" style="text-align: center">i18n_mrslc.text.noResult_n81i</td>
		</tr>
	</c:otherwise>
	</c:choose>
