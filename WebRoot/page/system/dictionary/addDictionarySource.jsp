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
		<title>i18n_ads.message.title_n81i</title>
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
   
	function add(){
	    if($id("typeCode","","i18n_ads.text.typeCode_n81i")&& $id("typeValue","","i18n_ads.text.typeValue_n81i")&&$id("showNum","sz","i18n_ads.text.showNum_n81i")&& (checkNumber("delayTime")||$id("delayTime","sz","i18n_ads.text.delayTime_n81i") )){
	    	if(ajaxCheck()){
				document.Mkform.action = "<%=path%>/sysManage/dataDictionary.do?action=doAddSource&did="+'${did}';
				document.Mkform.submit();
	    	}
		}	
	}
	function ajaxCheck(){
	var type;
		$.ajax({
			url:"<%=path%>/sysManage/dataDictionary.do?action=checkAjax",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "error"){
					alert("i18n_ads.text.MkformError_n81i");
					type = false;
				}else if(data == "exception"){
					alert("i18n_ads.text.MkformException_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		});
		return type;
	}
	function checkNumber(id) {
		if($("#"+id+"").val()==-1){
			$("#"+id+"").next().html("");
			return true;
		}else{
			return false;
		}
	}
	function goBack(){
		var iid = $("#tid").val();
		window.location="<%=path%>/sysManage/dataDictionary.do?action=querySouce&ddid="+iid+"&did="+'${did}';
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
					onclick="goBack()" value="i18n_ads.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
			<input type="hidden" name="ddid" value="${typeTable.typeIdentity}" id="tid"/>
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_ads.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ads.text.typeCode_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="optionTable.typeCode" id="typeCode"/>
						<font id="oidFont" color="red">*</font>	
					</td>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_ads.text.typeValue_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="optionTable.typeValue"
										id="typeValue"/>
						<font color="red">*</font>	
					</td>
				</tr>
				<tr>
				<c:choose>
				<c:when test="${typeTable.id ne 81}">
				<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ads.text.showNum_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<input type="text" name="optionTable.showNum"
										id="showNum"/>
						<font color="red">*</font>	
					</td>
				</c:when>
				<c:when test="${typeTable.typeIdentity eq 'emergent'}">
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ads.text.showNum_n81i
					</td>
					<td class="color_3"  align="left">
						<input type="text" name="optionTable.showNum"
										id="showNum"/>
						<font color="red">*</font>	
					</td>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ads.text.delayTime1_n81i
					</td>
					<td class="color_3"  align="left">
						<input type="text" name="optionTable.delayTime"
										id="delayTime"/>
					<font color="red">*</font>	
					</td>
				</c:when>
				</c:choose>					
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_ads.button.add_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_ads.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
