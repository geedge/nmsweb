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
		<title>i18n_uddc.message.title_n81i</title>
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
   
	function sub(){
    	document.Mkform.action = "<%=path%>/sysManage/dataDictionary.do?action=updateDetectConditionSet";
		document.Mkform.submit(); 
	}
	
	function goBack(){
		window.location="<%=path%>/sysManage/dataDictionary.do?action=queryDetectConditionSet";
	}
	
	$(function() {
		//选中非紧急，显示级别选择
		var emergentVal = jQuery('#policeEmergent1').attr('checked');
		if(emergentVal) {
			jQuery('#nonEmergentTr').show();
		}
	});
	
	function nonEmergentChange(){
		var emergentVal = jQuery('#policeEmergent1').attr('checked');
		if(emergentVal) {
			jQuery('#nonEmergentTr').show();
		}else {
			jQuery('#nonEmergentTr').hide();
		}
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
					onclick="goBack()" value="i18n_uddc.button.back_n81i"/>
			 </div>	
			<form action="" name="Mkform" method="post">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="detDataConSet.id" value="${detDataConSet.id }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_uddc.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_uddc.text.menuName_n81i
					</td>
					<td class="color_3" width="30%" align="left" colspan="3">
						${detDataConSet.menuName }
								
					</td>
				</tr>  
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_uddc.text.policeEmergent_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<input type="checkbox" name="detDataConSet.policeEmergent" id="policeEmergent0" value="0"
							<c:if test="${fn:contains(detDataConSet.policeEmergent,',0,')}">checked="checked"</c:if> />i18n_uddc.message.emergent_n81i
						<input type="checkbox" name="detDataConSet.policeEmergent" id="policeEmergent1" value="1"  onclick="nonEmergentChange();"
							<c:if test="${fn:contains(detDataConSet.policeEmergent,',1,')}">checked="checked"</c:if> />i18n_uddc.message.nonEmergent_n81i
							
					</td>
				</tr>
				<tr id="nonEmergentTr" style="display: none;">
					<td class="color_1"  align="right" v   align="top" nowrap="nowrap">
						i18n_uddc.text.policeLevel_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<input type="checkbox" name="detDataConSet.policeLevel" id="policeLevel1" value="1"
							<c:if test="${fn:contains(detDataConSet.policeLevel,',1,')}">checked="checked"</c:if> />i18n_uddc.message.policeLevel1_n81i
						<input type="checkbox" name="detDataConSet.policeLevel" id="policeLevel2" value="2" 
							<c:if test="${fn:contains(detDataConSet.policeLevel,',2,')}">checked="checked"</c:if> />i18n_uddc.message.policeLevel2_n81i
						<input type="checkbox" name="detDataConSet.policeLevel" id="policeLevel3" value="3"
							<c:if test="${fn:contains(detDataConSet.policeLevel,',3,')}">checked="checked"</c:if> />i18n_uddc.message.policeLevel3_n81i
						<input type="checkbox" name="detDataConSet.policeLevel" id="policeLevel4" value="4" 
							<c:if test="${fn:contains(detDataConSet.policeLevel,',4,')}">checked="checked"</c:if> />i18n_uddc.message.policeLevel4_n81i
						<input type="checkbox" name="detDataConSet.policeLevel" id="policeLevel5" value="5" 
							<c:if test="${fn:contains(detDataConSet.policeLevel,',5,')}">checked="checked"</c:if> />i18n_uddc.message.policeLevel5_n81i
					</td>
					
				</tr>
				<tr >
					<td class="color_1"  align="right" v   align="top" nowrap="nowrap">
						i18n_uddc.text.remark_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						i18n_uddc.text.selectNull_n81i
					</td>
					
				</tr>
				
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="sub()"
								value="i18n_uddc.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_uddc.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
