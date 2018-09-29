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
		<title>i18n_uei.message.title_n81i</title>
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
   
	function add(){
	    if($id("troubleInfo","","i18n_uei.text.troubleInfo_n81i")){
	    	<c:if test="${ADMFlag eq true}" >
	    		if($("#sysid").val()==''){
	    			$('#group_red').html("i18n_uei.message.systemId_n81i");
	    			return;
	    		}
	    	</c:if>
	    	document.Mkform.action = "<%=path%>/sysManage/sysErrorManage!execute.do?action=doUpdError";
			document.Mkform.submit();
		}	
	}
	
	function goBack(){
		window.location="<%=path%>/sysManage/sysErrorManage!execute.do?action=queryError";
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
					onclick="goBack()" value="i18n_uei.button.back_n81i"/>
			 </div>
			<input type="hidden" id="tna" value="${troubleState.troubleInfo }" />
			<form action="" name="Mkform" method="post">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="troubleState.id" value="${troubleState.id }" />
			<input type="hidden" name="sysId" value="${troubleState.system.systemId }" />
			<input type="hidden" name="troubleState.createUser.yhid" value="${troubleState.createUser.yhid }" />
			<input type="hidden" name="troubleState.createDate" value="${troubleState.createDate }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_uei.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_uei.text.troubleCode_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="troubleState.troubleCode" id="troubleCode" value="${troubleState.troubleCode }" disabled="disabled"/>
						<font id = "troubleCode"color="red">*</font>
						<input type="hidden" name="troubleState.troubleCode" value="${troubleState.troubleCode }"/>	
					</td>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_uei.text.troubleInfo_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="troubleState.troubleInfo"
										id="troubleInfo" value="${troubleState.troubleInfo }"/>
						<font id="troubleInfo" color="red">*</font>	
					</td>
				</tr>
				<c:if test="${ADMFlag }">	
					<tr id="adm" >
						<td class="color_1" width="20%" align="right" valign="top" >
							i18n_uei.text.systemId_n81i
						</td>
						<td class="color_3" width="30%" align="left" valign="top" colspan="3">
							<select name="troubleState.system.systemId" id="sysid">
								<option selected="selected" value="">
									i18n_uei.message.system_n81i
								</option>
								<c:forEach items="${sysList}"  var="sys">
									<option value="${sys.systemId}" <c:if test="${sys.systemId == troubleState.system.systemId }">selected="selected"</c:if>>
												${sys.systemName}
									</option>
								</c:forEach>
							</select>
							<font color="red" id="group_red">*</font>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_uei.text.troubleDescr_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<textarea rows="3" cols="50" name="troubleState.troubleDescr" id="troubleDescr">${troubleState.troubleDescr}</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_uei.text.troubleState_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
							<input type="radio" name="troubleState.state" id="state" value="0" 
							       <c:if test="${troubleState.state == 0}">checked="checked"</c:if>
							      />i18n_uei.message.troubleState0_n81i
							<input type="radio" name="troubleState.state" id="isSnmp2" value="1" 
							       <c:if test="${troubleState.state == 1}">checked="checked"</c:if>
							       />i18n_uei.message.troubleState1_n81i
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_uei.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_uei.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
