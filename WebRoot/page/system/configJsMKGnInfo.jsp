<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i18n_cjsmkgi.message.title_n81i</title>
<link href="<%=path%>/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
<link rel="StyleSheet" href="<%=path%>/js/dtree/css/dtree.css" type="text/css" />
<script type="text/javascript">
	new alignWindowObject(window.opener.winObj.width,window.opener.winObj.height).alignCenter();
</script>
</head>
<body>
	<form action="" method="post">
	<table width="100%" align="center" border="0" cellpadding="0"
				cellspacing="0" background="<%=path%>/templates/img/query_01.gif" style="font-size: 12px;">
				<tr>
					<td height="20"></td>
				</tr>
				<tr>
					<td>
			<fieldset>
				<legend>
					i18n_cjsmkgi.text.baseInfo_n81i
				</legend>
				<br/>
				<table width="98%" align="center" border="1" cellpadding="0"
					cellspacing="0" class="blue-border" bordercolor="#CCCCCC">					
					<tr height="25" bgcolor="#F2F2F2" align="center">
						<th nowrap="nowrap">
							i18n_cjsmkgi.text.jsbh_n81i
						</th>
						<th nowrap="nowrap">
							i18n_cjsmkgi.text.jsmc_n81i
						</th>
						<th nowrap="nowrap">
							i18n_cjsmkgi.text.state_n81i
						</th>
					</tr>
					<tr height="25" align="center"  >
						<td nowrap="nowrap">${listJsInfo[0].jsbh }</td >
						<td nowrap="nowrap">${listJsInfo[0].jsmc }</td >
						<td nowrap="nowrap">
							<c:if test="${listJsInfo[0].ZXBZ==0}">i18n_cjsmkgi.message.state0_n81i</c:if>
							<c:if test="${listJsInfo[0].ZXBZ==1}">
								<font color="red">i18n_cjsmkgi.message.state1_n81i</font>
							</c:if>
						</td>
					</tr>
				</table>
				<br/>
			</fieldset>
			</td>
			</tr>
			</table>
			<br/>
			<fieldset>
				<legend>
					i18n_cjsmkgi.text.mkpromission_n81i
				</legend>
				<br/>
				<table width="98%" height="350px" align="center" border="1"
					cellpadding="0" cellspacing="0" class="blue-border" bordercolor="#CCCCCC">
					<tr align="center">
						<td valign="top" align="left" width="200px;">
							<div class="dtree" style="text-align: center;">
								<a href="javascript: d.openAll();">i18n_cjsmkgi.message.openAll_n81i</a> |
								<a href="javascript: d.closeAll();">i18n_cjsmkgi.message.closeAll_n81i</a>
								<br/>
							</div>
							<div id="treeList" style="height:360px;OVERFLOW-Y:auto;WIDTH:200px;TEXT-ALIGN:left;">
								
							</div>
						</td>
						<td valign="top" height="350px;" width="600px;" style="font-size: 12px;" align="left" >
							<iframe style=" width:100%;height: 100%" frameborder=0 name="jsMkGnFrame" id="jsMkGnFrame" src="<%=path%>/back.jsp"></iframe>
						</td>
					</tr>
				</table>
				<!-- 模块权限结束 -->
			</fieldset>
			<input type="hidden" name="jsbh" value="${listJsInfo[0].jsbh }"/>
		</form>
</body>
<script type="text/javascript" src="<%=path%>/js/dtree/js/dtree.js"></script>
<script language="javascript">
	//显示左侧树
	function showLeftTree(){
		var treeObject = new createTreeObject("treeList");
		treeObject.loadXML("<%=path%>/SysPopedomManage!execute.do?action=configJsMkGnTreeXml&jsbh=${listJsInfo[0].jsbh}");
		var list = treeObject.getNodesList();
		treeObject.setRootNode("i18n_cjsmkgi.text.mkList_n81i");
		treeObject.addItems(treeObject,list);
		treeObject.showTree();
	}
	showLeftTree();
	//根据模块编号查询功能信息
	function queryMkGnInfo(mkbh){
		jsMkGnFrame.location="<%=path%>/SysPopedomManage!execute.do?action=configJsMkGnListInfo&mkbh="+mkbh+"&jsbh=${listJsInfo[0].jsbh }";
	}
</script>
</html>

