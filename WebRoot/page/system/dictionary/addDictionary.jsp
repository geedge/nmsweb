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
		<title>i18n_ad.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
   function checkDictionary(){
   var type;
		$.ajax({
			url:"<%=path%>/sysManage/dataDictionary.do?action=checkDictionary",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "error1"){
					alert("i18n_ad.message.dictTypeNameExists_n81i");
					$("#typeName").focus();
					type = false;
				}else if(data == "error2"){
					alert("i18n_ad.message.identifierExists_n81i");
					$("#typeIdentity").focus();
					type = false;
				}else if(data == "exception"){
					alert("i18n_ad.message.faild_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		}); 
		return type;  
   }
   
	function add(){
	    if($id("sn","sz","i18n_ad.text.sn_n81i")&& $id("typeName","","i18n_ad.text.typeName_n81i")&& $id("typeIdentity","","i18n_ad.text.typeIdentity_n81i")){
	    	if(checkDictionary()){
		    	document.Mkform.action = "<%=path%>/sysManage/dataDictionary.do?action=doAdd";
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
					onclick="goBack();" value="i18n_ad.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_ad.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ad.text.sn_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.showNum" id="sn"/>
						<font color="red">*</font>
					</td>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ad.text.typeName_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.typeName"
										id="typeName"/>
						<font color="red">*</font>	
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ad.text.typeIdentity_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="typeTable.typeIdentity"
										id="typeIdentity"/>
						<font color="red">*</font>	
					</td>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ad.text.typeDesc_n81i
					</td>
					<td class="color_3"  align="left">
						<textarea rows="3" cols="50" name="typeTable.typeDesc" id="typeDesc"></textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add();"
								value="i18n_ad.button.add_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset();"
								value="i18n_ad.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
