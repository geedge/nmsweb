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
		<title>i18n_ubi.message.title_n81i</title>
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
	    if($id("brandName","","i18n_ubi.text.brandName_n81i")){
			document.Brandform.action="<%=path%>/sysManage/brandManage.do?action=updateBrand";
			document.Brandform.submit();
        }	
	}
	
	function goBack(){
		document.Brandform.action="<%=path%>/sysManage/brandManage.do?action=queryBrandInfo";
		document.Brandform.submit();	
	}
</script>
	<body>
		<div class="middle_list" >
			<form action="" name="Brandform" method="post">
			<input type="hidden" name="brand.id" id="brandId" value="${brand.id}" />
			<input type="hidden" name="brandNameForSearch" id="brandNameForSearch" value="${brandNameForSearch}" />
			<jsp:include page="/common/transferHiddenParameter.jsp" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_ubi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ubi.text.brandName_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="brand.brandName" id="brandName" size="30" value="${brand.brandName}"/>
						<font id = "ctypeName"color="red">*</font>
					</td>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_ubi.text.brandOid_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="brand.brandOid" id="brandOid" value="${brand.brandOid}" size="30"/>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_ubi.text.brandDesc_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<textarea type="text" name="brand.brandDesc" id="brandDesc" rows="3" cols="50">${brand.brandDesc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="update()"
								value="i18n_ubi.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Brandform'].reset()"
								value="i18n_ubi.button.reset_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_ubi.button.back_n81i"/>
						&nbsp;
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
