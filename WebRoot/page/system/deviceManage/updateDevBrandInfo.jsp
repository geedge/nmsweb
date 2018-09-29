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
		<title>i18n_udbi.message.title_n81i</title>
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
   //判断品牌编号是否重复
	function hasDevBrandCode(){
		var hasDevCode = false;
	    $.ajaxSettings.async = false;//设置同步
		//先判断任务编号是否存在，不存在不查询
		var deviceBrandCode = jQuery.trim(jQuery("#deviceRandCode").val());
		if(deviceBrandCode!='') {
			$.getJSON("<%=path%>/sysManage/deviceBrandManage!execute.do?action=hasDevBrand&devRandCodeForSearch="+deviceBrandCode,
	             {}, function(data){
					 if(data!=null&&data!=""&&data.result=='success') {//设备型号已存在
					 	var tip = data.tip;
					 	$("#deviceRandCode").next().html(tip);
					 	hasDevCode = true;
					 	return true;
					 }else {
					 	$("#deviceRandCode").next().html(tip);
					 	hasDevCode = false;
					 	return false;
					 }
			});  	
		}
		return hasDevCode;
	}
   
   
	function update(){
	    if($id("deviceRandCode","","i18n_udbi.text.deviceRandCode_n81i")&& !hasDevBrandCode()){
			document.Brandform.action="<%=path%>/sysManage/deviceBrandManage.do?action=updateDevBrand";
			document.Brandform.submit();
			
			jQuery("#addButton").attr("disabled","true");  
			jQuery("#resetButton").attr("disabled","true");  
			jQuery("#backButton").attr("disabled","true");
        }	
	}
	
	function goBack(){
		document.Brandform.action="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
		document.Brandform.submit();	
	}
</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">		
				<input type="button" class=btn3_mouseout   id="backButton"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_udbi.button.back_n81i"/>
			 </div>
			<form action="" name="Brandform" method="post">
			<input type="hidden" name="devBrand.id" id="brandId" value="${devBrand.id}" />
			<input type="hidden" name="brandNameForSearch" id="brandNameForSearch" value="${brandNameForSearch}" />
			<jsp:include page="/common/transferHiddenParameter.jsp" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_udbi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udbi.text.deviceRandCode_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devBrand.deviceRandCode" id="deviceRandCode" size="30" value="${devBrand.deviceRandCode}" />
						<font id = "deviceRandCode" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udbi.text.deviceRandName_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="devBrand.deviceRandName" id="deviceRandName" value="${devBrand.deviceRandName}" size="30"/>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_udbi.text.deviceBrandDesc_n81i
					</td>
					<td class="color_3"  align="left" colspan="1">
						<textarea type="text" name="devBrand.deviceBrandDesc" id="deviceBrandDesc" rows="3" cols="50">${devBrand.deviceBrandDesc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout id="addButton"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="update()"
								value="i18n_udbi.button.update_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout id="resetButton"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Brandform'].reset()"
								value="i18n_udbi.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
