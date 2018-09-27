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
		<title>i18n_ud.message.title_n81i</title>
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
   function checkDictionary(){
   var type;
		$.ajax({
			url:"<%=path%>/sysManage/dataDictionary.do?action=updateCheck",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "error"){
					alert("i18n_ud.message.MkformError_n81i");
					$("#typeName").focus();
					type = false;
				}else if(data == "exception"){
					alert("i18n_ud.message.MkformException_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		}); 
		return type;  
   }
	function sub(){
	    if($id("showNum","sz","i18n_ud.text.showNum_n81i")&& $id("typeName","","i18n_ud.text.typeName_n81i")&& $id("typeIdentity","","i18n_ud.text.typeIdentity_n81i")){
	    	if(checkDictionary()){
				document.Mkform.action = "<%=path%>/sysManage/dataDictionary.do?action=doUpdate";
				document.Mkform.submit();	    	
	    	}
		}	
	}
	
	function goBack(){
		window.location="<%=path%>/sysManage/dataDictionary.do?action=query";
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
					onclick="goBack()" value="i18n_ud.buttone.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="typeTable.id" value="${typeTable.id }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_ud.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ud.text.showNum_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.showNum" id="showNum" value="${typeTable.showNum }"/>
						<font id="oidFont" color="red">*</font>
								
					</td>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ud.text.typeName_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.typeName" id="typeName" value="${typeTable.typeName }"/>
						<font color="red">*</font>	
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ud.text.typeState_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<input type="radio" name="typeTable.typeState" id="typeState" value="0"
							<c:if test="${typeTable.typeState == '0' }">checked="checked"</c:if> />i18n_ud.message.enable_n81i
						<input type="radio" name="typeTable.typeState" id="typeState" value="1" 
							<c:if test="${typeTable.typeState == '1' }">checked="checked"</c:if> />i18n_ud.message.disable_n81i 
					</td>
					<%--<td class="color_1" width="20%" align="right" nowrap="nowrap">
						字典标识
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.typeIdentity" value="${typeTable.typeIdentity }"
										id="typeIdentity"/>
						<font color="red">*</font>	
					</td>
				--%></tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ud.text.typeDesc_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<textarea rows="3" cols="50" name="typeTable.typeDesc" id="typeDesc">${typeTable.typeDesc }</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="sub()"
								value="i18n_ud.buttone.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_ud.buttone.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
