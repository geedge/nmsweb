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
		<title>i18n_ddti.message.title_n81i</title>
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
    $(function(){
    	 
    });
	
	function goBack(){
		document.Brandform.action="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';
		document.Brandform.submit();	
	}

	
	function isNotBlank(obj) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		return true;
	     	}else {
	     		return false;
	     	}
    }
	
	function downLoadDevPic(fileName) {
		document.Brandform.action="<%=basePath%>/download/downLoadFile!downloadDevPic.do?file="+fileName+"&backPathStr=<%=basePath%>/sysManage/deviceBrandManage.do?action=detailDevType%26devId=${devType.id}";
		document.Brandform.submit();	
	}
</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">		
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_ddti.button.back_n81i"/>
			 </div>
			<form action="" name="Brandform" method="post" enctype="multipart/form-data">
			<input  type="hidden" name="devTypeCodeForSearch" id="devTypeCodeForSearch" value="${devTypeCodeForSearch}" />
			<input  type="hidden" name="devRandCodeForSearch" id="devRandCodeForSearch" value="${devRandCodeForSearch}" />
			<input  type="hidden" name="parDevId" id="parDevId" value="${parDevId}" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_ddti.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.deviceRandCode_n81i
					</td>
					<td class="color_3" align="left">
						${devType.deviceRandCode}
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.deviceTypeCode_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.deviceTypeCode}
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.maxDeviceNum_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.maxDeviceNum}
					</td>
				</tr>
				<tr id="parDevCode" <c:if test="${devType.deviceRandCode==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.pid_n81i
					</td>
					<td class="color_3" align="left">
							<c:forEach items="${devTypeListInfo}" var="type" ><!-- 共选择的只有当前品牌的型号 -->
							  	<c:if test="${type.id==devType.pid}">
								  		${type.deviceTypeCode}
							  	</c:if>
							</c:forEach>
					</td>
				</tr>
				<tr id="devShowIndex" <c:if test="${devType.pid==0}">style="display: none;"</c:if>>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.index_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.showIndex}
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.figureFill_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<a href="javascript:downLoadDevPic('/images/svg/upload/${devType.figureFill}');">${devType.figureFill}</a>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.nameFormat_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.nameFormat}
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.diTableName_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						   	${devType.diTableName}
					</td>
				</tr>
				<tr id="tableLinkField" <c:if test="${devType.diTableName==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.indexFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.indexFiled}
					</td>
				</tr>
				<tr  id="tableStatusField" <c:if test="${devType.diTableName==null}">style="display: none;"</c:if>>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.statusFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.statusFiled}
					</td>
				</tr>
				<tr id="tableSymbols" <c:if test="${devType.statusFiled==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.statusSymbols_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.statusSymbols}
					</td>
				</tr>
				<tr id="tableStatusValue"  <c:if test="${devType.statusFiled==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ddti.text.statusSymbols_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						${devType.statusValue}
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ddti.text.deviceDesc_n81i
					</td>
					<td class="color_3"  align="left" >
						${devType.deviceDesc}
					</td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>
