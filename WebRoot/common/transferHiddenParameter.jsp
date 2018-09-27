<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>
<!-- 页面需要传递的隐藏参数 -->
<input type="hidden" name="pageNo" value="${pageNo}" /><!-- 列表当前页数 -->
<input type="hidden" name="pageSize" value="${pageSize}" /><!-- 列表当前页数 -->

		
	