<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>i18n_eid.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript" 
			src="<c:url value='/js/jquery.js' />"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/j.suggest.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Nodeform.action="<%=path%>/nmsError/nmsErrorInfo.do?action=query";
				document.Nodeform.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="Nodeform" method="post" style="border:0px;">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				
				<input type="hidden" name="errorCodeStr" value="${errorCodeStr }" />
				<input type="hidden" name="errorIp" value="${errorIp }"/>
				<input type="hidden" name="eiState" value="${eiState }"/>
				<table border="0" cellpadding="0" cellspacing="0" class="table1">
				<tr>
					<td colspan="4" class="color_top">
						<strong>i18n_eid.text.title_n81i</strong>
					</td>
				</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_eid.text.errorName_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							${errorCode.errorName }
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_eid.text.errorCode_n81i：
						</td>
						<td class="color_6" align="left">
							${errorCode.errorCode }
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_eid.text.errortIp_n81i：
						</td>
						<td class="color_6" align="left">
							${errorInfo.errortIp }
						</td>
						<td class="color_1" align="right">
							i18n_eid.text.errortGetip_n81i：
						</td>
						<td class="color_6" align="left">
							${errorInfo.errortGetip }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_eid.text.errorTime_n81i：
						</td>
						<td class="color_6" align="left">
							<fmt:formatDate type="both" value="${errorInfo.errorTime }" />
						</td>
						<td class="color_1" align="right" >
							i18n_eid.text.errorState_n81i：
						</td>
						<td class="color_3" align="left" >
							<font color="${errorInfo.errorState==1 ? "red" : "green"}">
										${errorInfo.errorState==0 ? "i18n_eid.message.resolved_n81i" : errorInfo.errorState==2?"i18n_eid.message.recovered_n81i":"i18n_eid.message.unresolved_n81i"}
										</font>
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_eid.text.yhmc_n81i：
						</td>
						<td class="color_6" align="left">
							${yhJbxx.yhmc }
						</td>
						<td class="color_1" align="right" >
							i18n_eid.text.stateUpdateTime_n81i：
						</td>
						<td class="color_3" align="left" >
							<fmt:formatDate type="both" value="${errorInfo.stateUpdateTime }" />
						</td>
						
					</tr>
					<tr>
						<td class="color_7" colspan="4"  align="right">&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_eid.button.back_n81i"/>
								&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
