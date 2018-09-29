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
		<title>i18n_umki.message.title_n81i</title>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/k.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>      

    </head>	

<script language="javascript" type="text/javascript">
	
	function $(name){
		return document.getElementById(name);
	}
	
	function update(){
		document.mkForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdate";
		document.mkForm.submit();
		/*window.location.href="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryMkInfo";*/
	}
	
	function goBack(){
		document.mkForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryMkInfo";
		document.mkForm.submit();	
	}
</script>
    <body>
		
			<input type="hidden" name="position" value="${position }" />
			<table width="80%" align="center" border="0" cellpadding="0" 
				cellspacing="1" class="ta_color">
				<div
					style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>

				<tr>
					<td height="20" class="td_color">
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;<strong>i18n_umki.text.title_n81i</strong></span>				
					</td>
				</tr>
				
				<tr>
					<td width="18%" bgcolor="#ffffff">
					<div style="height: 5px; width: 100%; margin: 0px auto; padding: 0px;"></div>
						
						<br>
						<form action="" name="mkForm" method="post">
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" >
							<input type="hidden" name="module.pid" value="${updateInfo[0].pid }">
								<tr>
									<td bgcolor="#FFFFFF" width="40%">
										<div align="right">
											<span class="STYLE1">i18n_umki.text.mkid_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text" name="module.id" value="${updateInfo[0].id }" readonly="readonly"
												style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />
										</div>
									</td>
								 </tr>
								 <tr>
									<td bgcolor="#FFFFFF">
										<div align="right">
											<span class="STYLE1">i18n_umki.text.mkmc_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<input type="text" name="module.mkmc" value="${updateInfo[0].mkmc }" 
												style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF">
										<div align="right">
											<span class="STYLE1">i18n_umki.text.mkurl_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
									   <div align="left">
											<input type="text" name="module.mkurl" value="${updateInfo[0].mkurl }"
												style="width: 155px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000" />
										</div>				
									</td>
								</tr>
								<tr>																
									<td bgcolor="#FFFFFF">
										<div align="right">
											<span class="STYLE1">i18n_umki.text.mkms_n81i：</span>
										</div>
									</td>
									<td height="28" bgcolor="#FFFFFF">
										<div align="left">
											<textarea rows="4" cols="40" name="module.mkms"
												style="width: 155px; height: 30px; background-color: #fff; border: solid 1px #77abc4; font-size: 12px; color: #000000">${updateInfo[0].mkms }</textarea>
										</div>
									</td>
								</tr>
							<tr>
								  <td  bgcolor="#FFFFFF">
								    <div align="right">
							          <span class="STYLE1">i18n_umki.text.state_n81i：</span>
							        </div>
						          </td>
						           <td height="28" bgcolor="#FFFFFF">
						            <div align="left">
						             <span class="STYLE1">
							       <input  type="radio" name="module.zxbz" value="0" <c:if test="${updateInfo[0].zxbz==0}"> checked</c:if> />i18n_umki.message.state0_n81i&nbsp;
								   <input  type="radio" name="module.zxbz" value="1"  <c:if test="${updateInfo[0].zxbz==1}"> checked</c:if> />i18n_umki.message.state1_n81i&nbsp;
							       </span>
							        </div>
						         </td>				         				        							
							</tr>																								
							</table>						
						</form>
					</div>
				</td>
			  </tr>

				<tr>
					<td height="20" class="td_color">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="td_color">
							<tr>
								<td width="92%" align=right>
									<img onclick="update()" src="<c:url value='/desktop/images/anniu/a_12${userBgColor }.gif'/>" 
										 border="0" align="middle" />&nbsp;
								</td>
								<td align=left>
									<img src="<c:url value='/desktop/images/anniu/a_39${userBgColor }.gif'/>" border="0" align="middle"
											onclick="javascript:document.forms['mkForm'].reset()" />&nbsp;
									
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
		
	</body>
</html>
