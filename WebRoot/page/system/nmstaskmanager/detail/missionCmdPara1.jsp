<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<c:forEach var="paramMiss1" items="${paramM1}" >
	<div divType="file_div" id="file_div">
		<table class="templateTable" style="table-layout: fixed;">
			<tr>
			    <td width="10%" align="right"  nowrap="nowrap">
					i18n_mcp1.text.fileName_n81i：
				</td>
				<td width="25%" class="td_4">
					<div style="word-break:break-all;word-wrap:break-word;"> 
				        ${paramMiss1.fileName}&nbsp;
				    </div>
				</td>
				<td width="10%" align="right" nowrap="nowrap">
					i18n_mcp1.text.isCover_n81i：
				</td>
				<td width="25%" class="td_4">  
					<c:if test="${paramMiss1.isCover=='Y' || paramMiss1.isCover=='y'}">
					i18n_mcp1.message.Y_n81i&nbsp;
					</c:if>
					<c:if test="${paramMiss1.isCover=='N' || 'paramMiss1.isCover==n'}">
					i18n_mcp1.message.N_n81i&nbsp;
					</c:if>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td width="10%" align="right" nowrap="nowrap">
					i18n_mcp1.text.destPath_n81i：
				</td>
				<td width="25%" class="td_4" title="${paramMiss1.destPath}">
				   <div style="word-break:break-all;word-wrap:break-word;"> 
					${paramMiss1.destPath}&nbsp;
					</div>
				</td>
				<td align="right" nowrap="nowrap">
					i18n_mcp1.text.username_n81i：
				</td>
				<td width="25%" class="td_4">
					${paramMiss1.username}&nbsp;
				</td>
			</tr>
			<tr>
				<td align="right" nowrap="nowrap">
					i18n_mcp1.text.permisson_n81i：
				</td>
				<td class="td_4">
					${paramMiss1.permisson}&nbsp;
				</td>
				<td align="right" nowrap="nowrap">
					i18n_mcp1.text.groupName_n81i：
				</td>
				<td class="td_4">
					${paramMiss1.groupName}&nbsp;
				</td>
			</tr>
		</table>
	</div>
</c:forEach>