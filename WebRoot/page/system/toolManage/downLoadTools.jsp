<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/jstl/c" prefix="c" %>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dlt.message.title_n81i</title>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
	</head>

<body>
<table width="50%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color">
  <div
					style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>
				<tr>
					<td height="20" class="td_color" align="left" valign="middle" colSpan=2>
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_dlt.text.title_n81i</strong></span>				
					</td>
				</tr>
				
				<tr height="20">
				<td width="25%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_dlt.text.toolName_n81i</span>
						</div>
				</td>
				 
					<td width="25%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_dlt.text.operation_n81i</span>
						</div>
					</td>					
				</tr>
				
				<tr height="20">
				<td width="4%" bgcolor="#FFFFFF">
						<div align="center">
							<span class="STYLE1">IE8</span>
						</div>
				</td>
				 
					<td width="30%" bgcolor="#FFFFFF" nowrap>
						<div align="center">
							<span class="STYLE1"><a href="<c:url value='/sysManage/sysPopedomManage!downLoad.do?downLoadPath=IE8-WindowsXP-x86-CHS.exe'/>">下载并安装工具</a></span>
						</div>
					</td>					
				</tr>
				
  
  
</table>
</body>
</html>
