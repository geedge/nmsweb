<%@ page language="java" pageEncoding="UTF-8"%>
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
				document.form1.action="<%=path%>/nodePosition/boxSet.do?action=query";
				document.form1.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<!--中间部分右边开始-->
			<form action="" name="form1" id="form1" method="post">
				<input type="hidden" name="isComplete" value="${isComplete }" />
				<input type="hidden" name="ispnNum" value="${ispnNum }" />
				<table align="center" border="0" cellpadding="0"
					cellspacing="0" class="table1">
					<tr>
						<td height="30" class="color_7" colspan="6">
							<strong>i18n_sie.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1">
							i18n_sie.text.index_n81i
						</td>
						<td class="color_1">
							i18n_sie.text.U_n81i
						</td>
						<td class="color_1">
							i18n_sie.text.roomIspn_n81i
						</td>
						<td class="color_1">
							i18n_sie.text.roomRowPosition_n81i
						</td>
						<td class="color_1">
							i18n_sie.text.roomColPosition_n81i
						</td>
						<td class="color_7">
							i18n_sie.text.errorInfo_n81i
						</td>
					</tr>
					<c:forEach items="${errorList}" var="info">
						<tr>
							<td class="color_3">
								${info.ispn }
							</td>
							<td class="color_3">
								${info.boxUType }
							</td>
							<td class="color_3">
								${info.roomIspn }
							</td>
							<td class="color_3">
								${info.roomRowPosition }
							</td>
							<td class="color_3">
								${info.roomColPosition }
							</td>
							<td class="color_6">
								${info.showError }
							</td>
						</tr>
					</c:forEach>

					<tr>
						<td class="color_7" colspan="6">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="goBack()" value="i18n_sie.button.back_n81i"/>
							&nbsp;
						</td>
					</tr>
				</table>
			</form>
			<!--中间部分右边结束-->
		</div>
	</body>
</html>