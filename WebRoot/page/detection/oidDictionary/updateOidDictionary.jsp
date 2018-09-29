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
		<title>i18n_uod.message.title_n81i</title>
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
   
	function sub(){
	    if($id("oid","","OID")&& $id("desc","","i18n_uod.message.oiddesc_n81i")){
	    	if(checkOID($("#oid").val())){//验证code是否为数字
	    		document.Mkform.action = "<%=path%>/detection/oidDictionary.do?action=doUpdate";
			    document.Mkform.submit();
		    }else{
		    	$("#oidFont").text("i18n_uod.message.oidFont_n81i");
		    	$("#oid").val("");
		    	$("#oid").focus();
		    	return;
		    }
		}	
	}
	
	function goBack(){
		document.Mkform.action="<%=path%>/detection/oidDictionary.do?action=query";
		document.Mkform.submit();
	}
	
	//验证oid
	function checkOID(oid){
		var cs = /^[1-9]([\d\.]+\d)?$/;
		var resu = cs.test(oid);
		return resu;
	}

</script>
	<body>
		<div class="middle_list" >
			<form action="" name="Mkform" method="post">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="od.id" value="${od.id }" />
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_uod.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						OID
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="od.oid" id="oid" value="${od.oid }"/>
						<font id="oidFont" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_uod.message.oiddesc_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="od.oidDesc"
										id="desc" value="${od.oidDesc}"/>
						<font id="troubleInfo" color="red">*</font>	
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="sub()"
								value="i18n_uod.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_uod.button.reset_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_uod.button.back_n81i"/>
						&nbsp;
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
