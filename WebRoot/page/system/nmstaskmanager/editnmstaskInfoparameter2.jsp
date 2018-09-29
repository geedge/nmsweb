<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_entip2.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>"
			rel="stylesheet" type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>"
			type="text/javascript"></script>
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
	</head>
	<script type="text/javascript">
	function $(name){
		return document.getElementById(name);
	}
	function toreset(){
		jQuery("#nodegroupid").empty();
		jQuery("#monfenfuenfefef").empty();
		if(jQuery("#nodegroupid")!=null){
			jQuery("#nodegroupid").append("<option value=''>i18n_entip2.message.nodegroupid_n81i</option>");
		}
		
		if(jQuery("#monfenfuenfefef")!=null){
			jQuery("#monfenfuenfefef").append("<option value=''>i18n_entip2.message.monfenfuenfefef_n81i</option>");
		}
		document.forms['yhForm'].reset();
	}
	
	function checkValue(){
		var missionval =  document.getElementById("missionstatetable.missionName").value;
		var obtargetPath =  jQuery("#missionstatetable.missionName").val();
		if(missionval==null||missionval==""){
			alert("i18n_entip2.message.missionName_n81i");
			return ;
		}
		if(jQuery("[name=missionstatetable.systemId]  >option:selected").val()=="") {
			alert("i18n_entip2.message.missionType_n81i");
			return false;
		}
		if(jQuery("#usergroupid >option:selected").val()==""){
			alert("i18n_entip2.message.userGroup_n81i");
			return false;
		}
		if(jQuery("[name=missionstatetable.missionType]:checked").val()==1){
			var obsourcePath =  jQuery("#sourcePath").val();
			if(obsourcePath==null||obsourcePath==""){
				alert("i18n_entip2.message.sourcePath_n81i");
				return ;
			}
			var obtargetPath = document.getElementById("missionparametertable1.targetPath").value;
			if(obtargetPath==null||obtargetPath=="") {
				alert("i18n_entip2.message.targetPath_n81i");
				return;
			}  
		}
		if(jQuery("[name=missionstatetable.missionType]:checked").val()==2){
			var obsourcePath =  document.getElementById("monfenfuenfefef").value;
			if(obsourcePath==null||obsourcePath==""){
				alert("i18n_entip2.message.file_n81i");
				return ;
			}
		}
			else{
			return true;
		}
	}
	
	
	function update(){
			if(checkValue()){
				document.yhForm.action="<%=basePath%>/nmstaskManager/nmsTaskManager!executeAction.do?action=update";
				document.yhForm.submit();		
			}
	 }
	 
	 function showInfotag(tasktype){
	 	if('1'==tasktype){
	 		for(var i=1;i<10;i++){
		 		if(document.getElementById('tsfile'+i)!=null){
		 			document.getElementById('tsfile'+i).style.display="";
		 		}
		 		if(document.getElementById('unstream'+i)!=null){
		 			document.getElementById('unstream'+i).style.display="none";
		 		}
	 		}
	 	}
	 	if('2'==tasktype){
	 		for(var i=1;i<10;i++){
	 			if(document.getElementById('unstream'+i)!=null){
	 				document.getElementById('unstream'+i).style.display="";
	 			}
	 			if(document.getElementById('tsfile'+i)!=null){
	 				document.getElementById('tsfile'+i).style.display="none";
	 			}
	 		}
	 	}
	 }
	 
	//取的系统下面的节点组 ajaxtype为1是查询节点组，ajaxtype为2是查询用户组下面的用户
	function getdownnodegroup(systemid,id,ajaxtype){
				 jQuery("#"+id+1).empty();
				  jQuery("#"+id+2).empty();
				jQuery.ajax({
					   dataType:"xml",
					   type: "POST",
					   cache: false,
					   url: "<%=basePath%>/nmstaskManager/nmsTaskManager!executeAction.do?action=ajax",
					   data: "systemid="+systemid+"&ajaxtype="+ajaxtype,
					   success: function(msg){
						   jQuery(msg).find("filed").each(function(){
							   	jQuery("#"+id).append("<option value="+jQuery(this).find("id").text()+">"+jQuery(this).find("name").text()+"</option>");
							   	 jQuery("#"+id+1).append("<option value="+jQuery(this).find("id").text()+">"+jQuery(this).find("name").text()+"</option>");
						   	 	 jQuery("#"+id+2).append("<option value="+jQuery(this).find("id").text()+">"+jQuery(this).find("name").text()+"</option>");
						   })
						   if(ajaxtype=='1'){
						  		jQuery("#monfenfuenfefef").empty();
							   	 jQuery(msg).find("paramfiled").each(function(){
							   	 jQuery("#monfenfuenfefef").append("<option value="+jQuery(this).find("id").text()+">"+jQuery(this).find("name").text()+"</option>");
						   		}
						   		)
						   		 jQuery(msg).find("usergroupfiled").each(function(){
							   	 jQuery("#usergroupid").append("<option value="+jQuery(this).find("id").text()+">"+jQuery(this).find("name").text()+"</option>");
						   		}
						   		)
						   }
					   }
					});
		}
		function showloopDelay(istask){
		if(istask==0){
			jQuery("#unstream10").css("display","");
		}
		else{
			jQuery("#unstream10").css("display","none");
		}
	}
   </script>
	<body>
		<form action="" name="yhForm" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="position" value="${position }">
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color">
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_entip2.text.addMissionInfo_n81i</strong>
						</span>
					</td>
				</tr>
				<tr>
					<td width="18%" bgcolor="#ffffff">
						<table width="100%" align="center" border="0" cellpadding="0"
							cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
							<div
								style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.missionName_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" name="missionstatetable.missionName"
											id="missionName" value="${missionstatetable.missionName}"
											style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />
										<font color="red"><span class="STYLE1">*</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.missionType_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"> <input type="hidden"
												name="missionstatetable.missionType" id="missionType"
												value="${missionstatetable.missionType}"/>
												<input type="hidden"
												name="missionstatetable.missionId" id="missionId"
												value="${missionstatetable.missionId}" />
												i18n_entip2.text.getDate_n81i </span>
										<font color="red"><span class="STYLE1">*</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.System_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<select name="missionstatetable.systemId"
												onchange="getdownnodegroup(this.value,'nodegroupid','1');"
												style="width: 155px;">
												<option value="">
													<span class="STYLE1">i18n_entip2.text.selectSystem_n81i</span>
												</option>
												<c:forEach items="${systemtablelist}" var="systemtable">
													<option value="${systemtable.systemId}"
														<c:if test="${missionstatetable.systemId eq systemtable.systemId}"> selected="selected"</c:if>>
														<span class="STYLE1">${systemtable.systemName}</span>
													</option>
												</c:forEach>
											</select>
											<font color="red"><span class="STYLE1">*</span> </font>
										</div>
									</td>
							</tr>
							<tr id="unstream5">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.groupId_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<select name="missionparameteriable2.nodeListId"
											id="nodegroupid1" style="width: 155px;">
											<option selected="selected" value="${nodegrouptable.groupId}">
												${nodegrouptable.groupName}
											</option>
										</select>
									</div>
								</td>
							</tr>
							<tr id="unstream6">
								<td height="20" bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.missionDesc_n81i：</span>
									</div>
								</td>
								<td height="20" bgcolor="#FFFFFF">
									<div align="left">
										<textarea name="missionparameteriable2.missionDesc"
											id="missionparameteriable2.missionDesc" rows="4" cols="40"
											style="width: 400px; height: 80px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000">${missionparameteriable2.missionDesc}</textarea>
									</div>
								</td>
							</tr>
							<!-- 非流文本数据获取部分 -->
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.viewLevel_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"> <input type="radio"
												name="missionstatetable.viewLevel" id="" value="1"
												<c:if test="${missionstatetable.viewLevel eq 1}">checked="checked"</c:if> />i18n_entip2.message.publisher_n81i
											<input type="radio" name="missionstatetable.viewLevel" id=""
												value="2"
												<c:if test="${missionstatetable.viewLevel eq 2}">checked="checked"</c:if> />i18n_entip2.message.publisherGroup_n81i
											<input type="radio" name="missionstatetable.viewLevel" id=""
												<c:if test="${missionstatetable.viewLevel eq 3}">checked="checked"</c:if>
												value="3" />i18n_entip2.message.allInSys_n81i </span>
										<font color="red"><span class="STYLE1">*</span> </font>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.userGroup_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<select name="missionstatetable.groupId" id="usergroupid"
											style="width: 155px;">
											<option selected="selected" value="${xtjsjbxx.jsbh}">
												${xtjsjbxx.jsmc}
											</option>
										</select>
										<font color="red"><span class="STYLE1">*</span> </font>
									</div>
								</td>
							</tr>
							<tr id="unstream1">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.loopFlag_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"> <input type="radio"
												name="missionparameteriable2.loopFlag" id="_type" value="0" <c:if test="${missionparameteriable2.loopFlag eq 0}">checked="checked"</c:if>
												 onclick="showloopDelay(this.value);" />i18n_entip2.message.Y_n81i <input
												type="radio" name="missionparameteriable2.loopFlag"  <c:if test="${missionparameteriable2.loopFlag eq 1}">checked="checked"</c:if>
												id="_type" value="1" onclick="showloopDelay(this.value);" />i18n_entip2.message.N_n81i
										</span>
									</div>
								</td>
							</tr>
							<tr id="unstream10">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.cycle_n81i:</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<span class="STYLE1"> <input type="text"
												name="missionparameteriable2.loopDelay" id="zhouqi" value="${missionparameteriable2.loopDelay}"
												style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />i18n_entip2.text.minute_n81i
										</span>
									</div>
								</td>
							</tr>
							<tr id="unstream3">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.selectFile_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<select name="missionparameteriable2.filePath"
											id="monfenfuenfefef"
											style="width: 160px; height: 20px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000">
											<option value="${mossionparameterdefault.id}">
												${mossionparameterdefault.missionTypeName}
											</option>
										</select>
										<font color="red"><span class="STYLE1">*</span>
										</font>
									</div>
								</td>
							</tr>
							<tr id="unstream4">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.filterKeyword_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" name="missionparameteriable2.filterKeyword" value="${missionparameteriable2.filterKeyword}">
									</div>
								</td>
							</tr>
							<tr id="unstream7">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.startFlag_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" name="missionparameteriable2.startFlag" value="${missionparameteriable2.startFlag}">
									</div>
								</td>
							</tr>
							<tr id="unstream8">
								<td bgcolor="#FFFFFF">
									<div align="right">
										<span class="STYLE1">i18n_entip2.text.endFlag_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" name="missionparameteriable2.endFlag" value="${missionparameteriable2.endFlag}">
									</div>
								</td>
							</tr>
							<!-- 非流文本数据获取部分结束 -->
							<tr>
								<td colspan="2" style="height: 20px;"></td>
							</tr>
						</table>

					</td>
				</tr>

					<tr>
					<td height="20" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="td_color">
							<tr>
								<td width="92%" align=right>
									<img onclick="update()"  src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_39${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="javascript:toreset()" />&nbsp;
									
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="javascript:history.go(-1);" />&nbsp;
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<script>
</script>