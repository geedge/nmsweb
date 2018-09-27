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
		<title>i18n_udi.message.title_n81i</title>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
	</head>
	<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>
    <script language="javascript" type="text/javascript">
	//new alignWindowObject(window.opener.winObj.width,window.opener.winObj.height).alignCenter();
	function $(name){
		return document.getElementById(name);
	}
	
	function doUpdate(deptid){
		if($id("deptname","","i18n_udi.text.deptname_n81i")){
			for(var i = 0 ;i<document.all.deptlayer.length;i++){
				if(document.all.deptlayer[i].checked){
					if((document.all.deptlayer[i].value==1 || document.all.deptlayer[i].value==2) && document.getElementById("upperlayer").value==-1){
						alert('i18n_udi.message.deptname_n81i');
						return false;
					}else{
						document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateDeptInfo&deptid="+deptid;
						document.yhForm.submit();
					}
				}
			}	 		
		}
	}
	
	 function goBack(){		
		document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryDeptInfo";
		document.yhForm.submit();	
	}
	
</script>

   
	<body>
		<form action="" name="yhForm" method="post">
			<input type="hidden" name="position" value="${position }">
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_udi.text.title_n81i</strong></span>				
					</td>
				</tr>
				<tr>
					<td width="18%" bgcolor="#ffffff" >
					<div style="height: 20px; width: 100%; margin: 0px auto; padding: 0px;"></div>
						
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px;padding-right: 5px;">
								
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_udi.text.deptname_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text" name="dept.deptname" id="deptname" value="${deptList[0].deptname }" 
												style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF">
										<div align="right">
											<span class="STYLE1">i18n_udi.text.deptlayer_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left"><span class="STYLE1">
											<input type="radio" name="dept.deptlayer" id="deptlayer" value="0"  <c:if test="${deptList[0].deptlayer==0 }">checked="checked" </c:if> />i18n_udi.text.deptlayer.generalTeam_n81i
											<input type="radio" name="dept.deptlayer" id="deptlayer" value="1"  <c:if test="${deptList[0].deptlayer==1 }">checked="checked" </c:if> />i18n_udi.text.deptlayer.detachment_n81i
											<input type="radio" name="dept.deptlayer" id="deptlayer" value="2"  <c:if test="${deptList[0].deptlayer==2 }">checked="checked" </c:if> />i18n_udi.text.deptlayer.team_n81i	
										</span>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF">
										<div align="right">
											<span class="STYLE1">i18n_udi.text.upperlayer_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<select name="dept.upperlayer" id="upperlayer" 
												style="width: 160px; height: 20px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000">
												<option value="-1">
													i18n_udi.message.default_n81i
												</option>
												<c:forEach items="${listDeptInfo}" var="deptInfo">
													<option value="${deptInfo.deptid}" <c:if test="${deptList[0].upperlayer==deptInfo.deptid }">selected="selected"</c:if>>
														${deptInfo.deptname}
													</option>
												</c:forEach>
											</select>
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
									<img onclick="doUpdate('${deptList[0].deptid }','${deptList[0].deptid}')" src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_39${userBgColor }.gif'/>"
											 border="0" align="middle"
											onclick="javascript:document.forms['yhForm'].reset()" />&nbsp;
									
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
		</form>
	</body>
<script>
function selectUpper(opt){
	if(opt==0){
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].value="-1";
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].text="i18n_udi.message.upperlayer_n81i";
		document.getElementById("upperlayer").disabled=true;
		//alert(document.getElementById("upperlayer").value);
	}else{
		document.getElementById("upperlayer").disabled=false;
	}
}
</script>
</html>
