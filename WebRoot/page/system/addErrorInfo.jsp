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
		<title>i18n_aei.message.title_n81i</title>
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
	    if($id("troubleCode","sz","i18n_aei.text.troubleCode_n81i")&& $id("troubleInfo","","i18n_aei.text.troubleInfo_n81i")){
	    	<c:if test="${ADMFlag eq true}" >
	    		if($("#sysid").val()==''){
	    			$('#group_red').html("i18n_aei.message.selectSystem_n81i");
	    			return;
	    		}
	    	</c:if>
	    	if(checkAjax()){
				document.Mkform.action = "<%=path%>/sysManage/sysErrorManage.do?action=addErrorInfo";
				document.Mkform.submit();	    	
	    	}
		}
	}
	
	function checkAjax(){
   		var type;
		$.ajax({
			url:"<%=path%>/sysManage/sysErrorManage.do?action=checkAjax",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "error"){
					alert("i18n_aei.message.MkformError_n81i");
					$("#troubleCode").focus();
					type = false;
				}else if(data == "exception"){
					alert("i18n_aei.message.MkformException_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		}); 
		return type;  
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
					onclick="goBack()" value="i18n_aei.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
			<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_aei.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_aei.text.troubleCode_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="troubleState.troubleCode" id="troubleCode"/>
						<font color="red">*</font>
								
					</td>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_aei.text.troubleInfo_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="troubleState.troubleInfo"
										id="troubleInfo"/>
						<font color="red">*</font>	
					</td>
				</tr>
				<c:if test="${ADMFlag }">
					<tr id="adm" >
						<td class="color_1" width="20%" align="right" valign="top" >
							i18n_aei.text.systeId_n81i
						</td>
						<td class="color_3" width="30%" align="left" valign="top" colspan="3">
							<select name="troubleState.system.systemId" id="sysid">
								<option selected="selected" value="">
									i18n_aei.message.systeId_n81i
								</option>
								<c:forEach items="${sysList}"  var="sys">
										<option   value="${sys.systemId}">
												${sys.systemName}
										</option>
								</c:forEach>
							</select>
							<font color="red" id="group_red">* </font>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_aei.text.troubleDescr_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<textarea rows="3" cols="50" name="troubleState.troubleDescr" id="troubleDescr"></textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_aei.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_aei.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
