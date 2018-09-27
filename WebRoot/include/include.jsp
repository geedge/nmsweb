<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>
<c:forEach var="item" items="${buttonBean}" varStatus="bean">
	<!-- <input type="button" style="border-style: none;background-color: transparent;height: 18px;vertical-align: middle;" onmouseover="this.className='hover';"
		onmouseout="this.className='normal';"
		onclick="<c:if test="${item.istype==true}">javascript:${item.func}();</c:if>" value="${item.fext}" /> -->
	<input class=btn3_mouseout type="button" 
		onmouseover="this.className='btn3_mouseover'"
		onmouseout="this.className='btn3_mouseout'"
		onmousedown="this.className='btn3_mousedown'"
		onmouseup="this.className='btn3_mouseup'"
		onclick="<c:if test="${item.istype==true}">javascript:${item.func}();</c:if>" value="${item.fext}"/>
</c:forEach>

