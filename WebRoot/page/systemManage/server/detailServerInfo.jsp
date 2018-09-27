<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@ include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_dsi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Mkform.action="<%=path%>/serverManager/serverManager.do?action=query";
				document.Mkform.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<div class="box_2">		
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_dsi.button.back_n81i"/>
			</div>
			<form action="" name="Mkform" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="serverTable.id" value="${serverTable.id }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />	
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_dsi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="30%" align="right">
							i18n_dsi.text.serverName_n81i：
						</td>
						<td class="color_6" width="70%" align="left">
							${serverTable.serverName }
						</td>
					</tr>
					
					<tr>
						<td class="color_1" align="right">
							i18n_dsi.text.serverDesc_n81i：
						</td>
						<td class="color_6" align="left">
							<c:out value="${serverTable.serverDesc }"></c:out>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dsi.text.serverIp_n81i：
						</td>
						<td class="color_6" align="left">
							${serverTable.serverIp }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dsi.text.serverState_n81i：
						</td>
						<td class="color_3" align="left">
							${serverTable.serverState eq 0? "i18n_dsi.message.serverState0_n81i":"i18n_dsi.message.serverState1_n81i" }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dsi.text.configIp_n81i：
						</td>
						<td class="color_6"  align="left">
							<c:forEach items="${objsList }" var="obj" varStatus="vs">
								<span id="${obj[0] }" sid="${obj[1] }" ipns="${obj[5] }" ipne="${obj[7] }" title='${obj[4] } -- ${obj[6] }' flag="1" >${obj[4] } -- ${obj[6] }<br /></span>
							</c:forEach>	
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
