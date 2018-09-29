<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@ include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_asi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
		
		
	function ajaxCheck(){
	   var type;
			$.ajax({
				url:"<%=path%>/serverManager/serverManager.do?action=AjaxCheck",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "error"){
						alert("i18n_asi.message.hasIp_n81i");
						type = false;
					}else if(data == "exception"){
						alert("i18n_asi.message.faild_n81i");
						type = false;
					}else if(data =="success"){
						type = true;
					}
				}
			}); 
			return type;  
	   }
   
			function add(){
				//去空格
				$("#serverName").val($.trim($("#serverName").val()));
	
				//验证不能空与长度限制
				if($id("serverName","","i18n_asi.text.serverName_n81i")
					&& $("#serverDesc").checkByteLength(256,"i18n_asi.text.serverDesc_n81i")
					&& $id("serverIp","ip","i18n_asi.text.serverIp_n81i")){
					if(checkSpecial($("#serverName").val())){
			    	 	$("#serverName").next().html("i18n_asi.message.serverName_n81i");
			    	 	return;
			    	}
			    	if(ajaxCheck()){
				    	document.Mkform.action="<%=path%>/serverManager/serverManager.do?action=doAdd";
						document.Mkform.submit();
			    	}
				}	
			}
			
			function goBack(){
				document.Mkform.action="<%=path%>/serverManager/serverManager.do?action=query";
				document.Mkform.submit();	
			}
			//删除文件
			$("#del_file_span").live("click",function(){
					$(this).parent().remove();
			});
			var s=0;
			function addIpSegment(){
				var startIP = $.trim($("#startIP").val());
				var endIP = $.trim($("#endIP").val());
				$("#startIP").val(startIP);
				$("#endIP").val(endIP);
				if(!$id("startIP","ip1","i18n_asi.text.startIP_n81i")|| !$id("endIP","ip1","i18n_asi.text.endIP_n81i")){
					return false;
				}
				var startIPSplit =startIP.split(".");
				var endIPSplit =endIP.split(".");
				var startIPN = startIPSplit[0]*256*256*256 
							+ startIPSplit[1]*256*256 
							+ startIPSplit[2]*256
							+ startIPSplit[3]*1;
				var endIPN = endIPSplit[0]*256*256*256 
							+ endIPSplit[1]*256*256 
							+ endIPSplit[2]*256
							+ endIPSplit[3]*1;
				//alert("start:"+startIPN);
				//alert("end:"+endIPN);
				if(startIPN-endIPN>0){
					$("#ipInfo").html("i18n_asi.message.ipRang_n81i");
					return false;
				}else{
					$("#ipInfo").html("");
				}
				if(!ipSegmentCheck(startIPN,endIPN)){
					return false;
				}
				//var  s = $("input[type='hidden'][name^=sisList]").size()/2;
				$("#configIp").prepend("<span ipns='"+startIPN+"' ipne='"+endIPN+"' title='"+startIP+" -- "+endIP+"'>"+startIP+" -- "+endIP+""
					+"<input type='hidden' name='sisList["+s+"].startIp' value='"+startIP+"' /><input type='hidden' name='sisList["+s+"].endIp' value='"+endIP+"' /><a id='del_file_span' href='#'>i18n_asi.message.delete_n81i</a><br /></span>");
				s++;
				return true;
			}
			
			function ipSegmentCheck(startIPN,endIPN){
				var falg = true;
				$("#contrastIp>div>span").each(function(i,n){
					var ipns = $(n).attr("ipns");
					var ipne = $(n).attr("ipne");
					if(Number(startIPN) > Number(ipne) || Number(endIPN) < Number(ipns)){
						return true;
					}else{
						alert($(n).attr("title")+": i18n_asi.message.ipRepeat.and_n81i "+$(n).text()+"i18n_asi.message.ipRepeat_n81i");
						falg = false;
						return false;
					}
				});
				if(!falg){
					return false;
				}
				$("#configIp>span").each(function(i,n){
					var ipns = $(n).attr("ipns");
					var ipne = $(n).attr("ipne");
					if(Number(startIPN) > Number(ipne) || Number(endIPN) < Number(ipns)){
						return true;
					}else{
						alert("i18n_asi.message.ipRepeat.with_n81i"+$(n).attr("title")+"i18n_asi.message.ipRepeat_n81i");
						falg = false;
						return false;
					}
				});
				
				
				return falg;
			}
			
		</script>
	</head>
	<body>
		<div class="middle_list">
			<div class="box_2">		
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_asi.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_asi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="30%" align="right">
							i18n_asi.text.serverName_n81i：
						</td>
						<td class="color_6" width="70%" align="left">
							<input type="text" name="serverTable.serverName" id="serverName" style="width: 155px;"/>
							<font color="red">*</font>
						</td>
					</tr>
					
					<tr>
						<td class="color_1" align="right">
							i18n_asi.text.serverDesc_n81i：
						</td>
						<td class="color_6" align="left">
							<textarea rows="5" cols="17" id="serverDesc" name="serverTable.serverDesc" ></textarea>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_asi.text.serverIp_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="serverTable.serverIp" value="" id="serverIp" style="width: 155px;"  />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_asi.text.configIp_n81i：
						</td>
						<td class="color_6"  align="left">
							<table border="1" class="table1">
								<tr>
									<th width="550px" align="center">i18n_asi.message.configIp_n81i</th>
									<th align="center">i18n_asi.message.getIp_n81i</th>
								</tr>
								<tr>
									<td id="configIp" valign="top">
										<input type="text" id ="startIP" name="startIP"  size="14"/>
										<font color="red"></font> --
										<input type="text"  id ="endIP" name="endIP"  size="14" />
										<font color="red"></font>
										<input type="button" value="i18n_asi.button.add_n81i" onclick="addIpSegment()"  class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" />
										<font color="red" id="ipInfo"></font>
									</td>
									<td id="contrastIp" align="center" valign="top">
										<div>
										<c:forEach items="${objsList}" var="obj" varStatus="vs">
											<span  id="${obj[0] }" title="${obj[2] } ${obj[3]==0 ? "i18n_asi.message.state0_n81i" : "i18n_asi.message.state1_n81i" }" sid="${obj[1] }" ipns="${obj[5] }" ipne="${obj[7] }">${obj[4] } -- ${obj[6] }</span><br />
										</c:forEach>	
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="2" align="right">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_asi.button.submit_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:document.forms['Mkform'].reset()"
									value="i18n_asi.button.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
