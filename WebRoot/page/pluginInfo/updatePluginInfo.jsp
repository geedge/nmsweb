<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_upi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery.form.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
	function goBack(){
		document.Mkform.action="<%=path%>/pluginManage/pluginManage.do?action=queryInfo";
		document.Mkform.submit();	
	}
	function add(){
			if($("#name").val()==''){
				$("#name").next().html("i18n_upi.message.name_n81i");
				return;
			}
			
			$.ajax({
				url : "<%=path%>/pluginManage/pluginManage.do?action=checkName",
				type : "POST",
				dataType : "text",
				data:{'name':$("#name").val(),"pluginId":${pluginInfo.id}},
					async:true,
				success : function(data,textStatus) {
					if(data != "" && data != null)
					{
						alert(data);
						return false;
					}else{
						document.Mkform.action="<%=path%>/pluginManage/pluginManage.do?action=doUpdate";
						document.Mkform.submit();
					}
				}
			})
	}
	
	$(function(){
		//下载附件
		$(".downloadA").click(function(){
			window.location="<c:url value='/pluginManage/pluginManage.do?action=downloadPlugin&ids="+${pluginId}+"'/>";
		})
		
		
		//删除文件
		$(".delUpload").live("click",function(){
			$(this).closest("DIV").remove();
		})
	})
</script>

	<body>
		<div class="middle_list">
			<div class="box_2">
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'" onclick="goBack()"
					value="i18n_upi.button.back_n81i" />
			</div>
			<input type="hidden" id="ctname1"
				value="${checkTypeInfo.checkTypeName1 }" />
			<form action="" name="Mkform" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="pluginInfo.id" value="${pluginInfo.id }" />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_upi.text.title_n81i<span style="color: red;">(i18n_upi.message.titleInfo_n81i)</span>
							</strong>
						</td>
					</tr>

					<tr>
						<td class="color_1" width="15%" align="right" nowrap="nowrap">
							i18n_upi.text.name_n81i
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text" name="pluginInfo.name" id="name"
								value="${pluginInfo.name }" />
							<font color="red">*</font>

						</td>

						<td class="color_1" width="20%" align="right" nowrap="nowrap">
							i18n_upi.text.myFile_n81i
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="button" value="i18n_upi.text.myFile_n81i" title="i18n_upi.text.myFile_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
							<input type="file" name="myFile" id="myFile" value="" onchange="javascript:setValue(this.value)"
								class="filebtn" style="width: 220px;" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="10%" align="right" nowrap="nowrap">
							i18n_upi.text.des_n81i
						</td>
						<td class="color_3" width="35%" align="left" colspan="3">
							<textarea name="pluginInfo.des" id="des" rows="3" cols="40">${pluginInfo.des }</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div style="font-size: 12px; padding: 5px;">
								<a title="i18n_upi.text.download_n81i" href="#" class="downloadA">${pluginInfo.fileName}</a>
								<span class="delUpload"
									style="border: gray 1px solid; padding: 5px 15px; background-color: #BABABA; color: #000fff;">i18n_upi.text.delete_n81i
									</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_upi.button.update_n81i" />
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()" value="i18n_upi.button.reset_n81i" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
