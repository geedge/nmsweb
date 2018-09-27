<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_usdti.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
            src="<c:url value='/js/WebCalendar.js' />"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
	function update(){
	    if($id("sortName","","i18n_usdti.text.sortName_n81i")){
			document.Sortform.action="<%=path%>/sysManage/snmpDetectManage.do?action=updateSnmpDetectType";
			document.Sortform.submit();
        }	
	}
	
	function goBack(){
		document.Sortform.action="<%=path%>/sysManage/snmpDetectManage.do?action=querySnmpDetectTypeInfo";
		document.Sortform.submit();	
	}
</script>
	<body>
		<div class="middle_list" >
			<form action="" name="Sortform" method="post">
			<input type="hidden" name="sortInfo.id" id="sortInfoId" value="${sortInfo.id}" />
			<input type="hidden" name="sortNameForSearch" id="sortNameForSearch" value="${sortNameForSearch}" />
			<jsp:include page="/common/transferHiddenParameter.jsp" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_usdti.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_usdti.text.sortName_n81i
					</td>
					<td class="color_3" align="left" >
						<input type="text" name="sortInfo.sortName" id="sortName" size="30" value="${sortInfo.sortName}"/>
						<font id = "ctypeName"color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1"  width="15%" align="right" valign="top" nowrap="nowrap">
						i18n_usdti.text.sortTypeDesc_n81i
					</td>
					<td class="color_3"  align="left" >
						<textarea type="text" name="sortInfo.sortDesc" id="sortDesc" rows="3" cols="50">${sortInfo.sortDesc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="update()"
								value="i18n_usdti.text.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Sortform'].reset()"
								value="i18n_usdti.text.reset_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_usdti.text.back_n81i"/>
						&nbsp;
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
