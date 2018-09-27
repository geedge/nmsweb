<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_sie.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript">
		  	function goBack(){
				window.history.go(-1);
			}
		</script>
	</head>
	<body>	
		<div class="middle_list">
			<!--中间部分右边开始-->
			<form action="" name="form1" id="form1" method="post">
			<c:if test="${fn:length(headerList) > 0}">
				<table align="center" border="0" cellpadding="0" cellspacing="0"
					class="table1">
					<tr>
						<td height="30" class="color_7" colspan="${fn:length(headerList)}">
							<strong>i18n_sie.text.errorMessage_n81i</strong>
						</td>
					</tr>
					<tr>
						<c:forEach items="${headerList}" var="head">
							<td class="color_1">
								${head}
							</td>
						</c:forEach>
					</tr>
					<c:forEach items="${rowList}" var="errorList">
						<tr>
							<c:forEach items="${errorList}" var="error" varStatus="status">
								<c:choose>
									<c:when test="${status.last}">
										<td class="color_6">
											${error}
										</td>
									</c:when>
									<c:otherwise>
										<td class="color_3">
											${error}
										</td>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${fn:length(rowList1) > 0}">
				<table align="center" border="0" cellpadding="0" cellspacing="0"
					class="table1">
					<tr>
						<td height="30" class="color_7" colspan="${fn:length(headerList1)}">
							<strong>${errorTheme }</strong>
						</td>
					</tr>
					<tr>
						<c:forEach items="${headerList1}" var="head">
							<td class="color_1">
								${head}
							</td>
						</c:forEach>
					</tr>
					<c:forEach items="${rowList1}" var="errorList">
						<tr>
							<c:forEach items="${errorList}" var="error" varStatus="status">
								<c:choose>
									<c:when test="${status.last}">
										<td class="color_6">
											${error}
										</td>
									</c:when>
									<c:otherwise>
										<td class="color_3">
											${error}
										</td>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<div class="color_7" style="text-align:center;">
			<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'" onclick="javascript:window.location='${header.referer }'"
							value="i18n_sie.button.back_n81i" /></div>
			</form>
			<!--中间部分右边结束-->
		</div>
	</body>
</html>