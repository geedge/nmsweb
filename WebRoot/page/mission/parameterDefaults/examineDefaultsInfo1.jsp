<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
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
		<title>i18n_edi1.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
			<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.tools.js"></script>
	</head>
	<script type="text/javascript">
	 var msg = '${MSG}';
	 if(msg.length>0){
	 	alert(msg);
	 }
	function add(){
		document.yhForm.action="<c:url value='/mission/missionParameterDefaults.do?action=insert'/>";
		document.yhForm.submit();
	 }
	jQuery(function(){
		//菜单流程
		$("tr[mt]").hide();	
		if($("#MSGFlag").val()==1){
			$("[mst]").removeAttr("disabled");
			$("tr[mt='"+$("#missionType").val()+"']").show();	
		}else{
			$("[mst]").attr("disabled",'disabled');
		}
		//系统和节点组 的 连动下拉菜单
		$("#systemId").data("nodes",$("#nodeId").clone());
		$("#systemId").bind("change",function(){
			$("#nodeId option[systems]").remove();
			if($(this).val()=="0"){
				$("#systemId").data("nodes").find("option[systems]").clone().appendTo("#nodeId");
			}else{
				$("#systemId").data("nodes").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#nodeId");
			}
			$("#nodeId").val(0);
		});
		//系统和用户组 的 连动下拉菜单
		$("#systemId").data("userGroup",$("#groupId").clone());
		$("#systemId").bind("change",function(){
			$("#groupId option[systems]").remove();
			if($(this).val()=="0"){
				$("#systemId").data("userGroup").find("option[systems]").clone().appendTo("#groupId");
			}else{
				$("#systemId").data("userGroup").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#groupId");
			}
			$("#groupId").val(0);
		});
		if($("#systemId").val()!=0){
			//节点组联动
			$("#nodeId option[systems]").remove();
			$("#systemId").data("nodes").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#nodeId");
			//用户组联动
			$("#groupId option[systems]").remove();
			$("#systemId").data("userGroup").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#groupId");
		}
		//任务类型名称和任务类型 值联动
		$("#missionTypeName").val($("#missionType option:selected").attr("viewValue"));
		$("#systemId,#missionType").bind('change',function(){
			$("#missionTypeName").val($("#missionType option:selected").attr("viewValue"));
			if($("#missionType").val()==0){
				$("#missionTypeName").val($("#missionType option:selected").attr("viewValue"));
				return;
			}
			if($("#systemId").val()==0){
				return;
			}
			$("#paramenterForm").attr("action","<c:url value='/mission/missionParameterDefaults.do?action=check'/>").submit();
		});
		$("input[type='radio'][id='loopFlag']").click(function(){
			if($("#loopFlag").val()){
				
			}else{
				
			}
		});
		//$("#checkValue").blur(function(){alert($(this).checkByteLength(100,"校验值信息"));});
	});
	function goBack(){
		document.yhForm.action="<c:url value='/mission/missionParameterDefaults.do?action=select'/>";
		document.yhForm.submit();	
	}

   </script>
	<body>
		<form action="" name="yhForm" id="paramenterForm" method="post">
			<input type="hidden" name="MSGFlag" id="MSGFlag" value="${MSGFlag }" />
			<table width="80%" align="center" border="0" cellpadding="0" cellspacing="1" class="ta_color" >
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_edi1.text.title_n81i</strong></span>				
					</td>
				</tr>
				<tr>
					<td bgcolor="#ffffff" align="center">
						<table width="80%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
							<tr><td colspan="4" style="height: 20px;"></td></tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.systemName_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										${sys.systemName }
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.missionType_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
											<c:forEach items="${mtList}" var="mt">
												<c:if test="${parameterDefaults.missionType eq mt[0] }"> >${mt[1] }</c:if>
											</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.nodeGroup_n81i：</span>
									</div>
								</td>
								
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										${nod.groupName}
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.missionTypeName_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										${parameterDefaults.missionTypeName }
									</div>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.viewLevel_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
											<c:forEach items="${vlList}" var="vl">
												<c:if test="${parameterDefaults.viewLevel eq vl[0] }"> ${vl[1] }</c:if>
												</c:forEach>
										</select>
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.userGroup_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										${xtj.jsmc }
									</div>
								</td>
							</tr>
															<tr>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.startTime_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" mst="mst"
<%--										 name="parameterDefaults.startTime"--%>
										  disabled="disabled" />
									</div>
								</td>
								<td bgcolor="#FFFFFF" width="20%">
									<div align="right">
										<span class="STYLE1">i18n_edi1.text.endTime_n81i：</span>
									</div>
								</td>
								<td height="28" bgcolor="#FFFFFF">
									<div align="left">
										<input type="text" mst="mst"
<%--										 name="parameterDefaults.endTime" --%>
										 disabled="disabled" />
									</div>
								</td>
							</tr>
							<tr><td colspan="4" style="height: 20px;"></td></tr>
					    </table>
					</td>
				</tr>
				<tr mt=1>
					<td bgcolor="#ffffff" align="center" >
							<table width="80%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
								<tr><td colspan="2" style="height: 20px;"></td></tr>
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.targetPath_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text" size="60" name="parameterDefaults.targetPath" />
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.checkValue_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<textarea rows="3" cols="47" id="checkValue" name="parameterDefaults.checkValue" ></textarea>
										</div>
									</td>
								</tr>
								<tr><td colspan="2" style="height: 20px;"></td></tr>
						    </table>
					</td>
				</tr>
					<tr mt=2>
					<td bgcolor="#ffffff" align="center" >
							<div style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>
							<table width="80%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.loopFlag_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF" colspan="3">
										<div align="left" class="STYLE1">
											<input type="radio" id='loopFlag' name="parameterDefaults.loopFlag" value="0" checked="checked" >i18n_edi1.message.untimed_n81i
											<input type="radio" id='loopFlag' name="parameterDefaults.loopFlag" value="1">i18n_edi1.message.timed_n81i
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.loopStartDate_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text" name="parameterDefaults.loopStartDate" />
										</div>
									</td>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.loopEndDate_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text"  name="parameterDefaults.loopEndDate" />
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.loopDelay_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF" colspan="3">
										<div align="left" >
											<input type="text"  name="parameterDefaults.loopDelay"/>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="20%">
										<div align="right">
											<span class="STYLE1">i18n_edi1.text.filterKeyword_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF" colspan="3">
										<div align="left" >
											<textarea rows="4" cols="40" name="parameterDefaults.filterKeyword"></textarea>
										</div>
									</td>
								</tr>
								<tr><td colspan="2" style="height: 20px;"></td></tr>
						    </table>
					</td>
				</tr>
				<tr>
					<td height="20" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="92%" align=right>
									<img onclick="add()" src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td width="1%" align=right>
									&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_21${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="goBack()" />&nbsp;
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
				<div style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>
		</form>
	</body>
</html>