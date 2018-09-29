<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

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
		<title>i18n_nili.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script type="text/javascript">
	//查询记录
	 function qry(){
		document.form3.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=queryChild";
		document.form3.submit();		
	}	
	
	var set_Id;
	var ajaxProperties = "";
	var ajaxTableName = "";
	var ajaxType = "";
	var id = "";
	var returnDiv = "";
	var ajaxValue = "";
	
	function lianxiangkeydown() {
		clearTimeout(set_Id);
	}
	
	function lianxiangkeyup(ajaxProperties1,ajaxTableName1,ajaxType1,id1,returnDiv1,ajaxValue1) {
		if(parent.parent.document.getElementById("lianxiangStatus").value=="2")
		{
			if(jQuery.trim(ajaxValue1)=="") return false;
			ajaxProperties = ajaxProperties1;
			ajaxTableName = ajaxTableName1;
			ajaxType = ajaxType1;
			id = id1;
			returnDiv = returnDiv1;
			
			if(!checkStrNoDian(ajaxValue1)){
				ajaxValue = ajaxValue1;
			}else{
				clearTimeout(set_Id);
				alert('i18n_nili.message.inputInfo_n81i');
				$("#"+id).val('');
				return;
			}
			clearTimeout(set_Id);
			set_Id = setTimeout(ajaxForLianxiang,500);
		}
	}
	
	function ajaxForLianxiang() 
	{
		if(ajaxProperties == 'nodeIp'){
			url = "<%=path%>/nodeGroupManage/nodeManage!queryInfoForAjax.do";
		}else{
			url = "<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do";
		}
		jQuery.post(url,
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
		{
			var lianxiangList = data.split(",");
			jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
		});
	}
	function ieBrowser(){
		if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		}
	}
	$(function(){
		/*
		var dh = document.body.clientHeight; 
		var dhh = dh-60+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-60){
			$("#maindiv").attr("style","margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
			if(ieBrowser()){
				$("#info").attr("style","width:100%;");
			}else{
				$("#info").attr("style","width:98.5%;");
			}
		}else{
			$("#maindiv").attr("style","margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;");
		}
		*/
		
		$("#info").floatHeaderDiv();
		
		
		//--同步本页面高度到父页面
		var $iframe = $("#Ich",window.parent.document)
		if($iframe != null){
			//alert($iframe.css('height'));
			$iframe.css('height',document.body.scrollHeight);
			//
			window.parent.resetHeight();
		}else{
			//alert('未找到父项');
		}
	});
	
	function downloadfile(fileName){
			document.form3.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.form3.submit();				
	}
</script>
	</head>
	<body id="nodeBody">
		<div class="middle_list" id="box" style="overflow: hidden;">
			<!--中间部分右边开始-->
				<form name=form3 id="form3" action="<c:url value='nodeManage!queryNodeInfoChild.do'/>" method="post">
					<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
					<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
					<input type="hidden" name="fromWhere" value="${fromWhere }"/>
					<div class="box_1">
						 <label class="divTopText"><font class="selectText">i18n_nili.text.nodeState_n81i</font>
						<select name="nodeStateVo">
							<option value="">i18n_nili.message.selectDefault_n81i</option>
							<option value="0" <c:if test="${nodeStateVo==0}">selected=selected</c:if> >i18n_nili.message.online_n81i</option>
							<option value="1" <c:if test="${nodeStateVo==1}">selected=selected</c:if> >i18n_nili.message.downline_n81i</option>
						</select></label>
						 <label class="divTopText"><font class="selectText">i18n_nili.text.nodeIp_n81i</font>
						<input  type="text" id="nodeIpVo"
							onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIpVo','suggest3',this.value);"
							name="nodeIpVo" title="i18n_nili.message.nodeIp_n81i" value="${nodeIpVo}" size="20" />
						<div id='suggest3' class="ac_results"></div></label>
						 <label class="divTopText"><font class="selectText">i18n_nili.text.nodeName_n81i</font>
						<input  type="text" id="nodeNameVo"
							onkeyup="lianxiangkeyup('nodeName','NodeTable','String','nodeNameVo','suggest1',this.value);"
							name="nodeNameVo" title="i18n_nili.message.nodeName_n81i" value="${nodeNameVo}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>
				<div id="maindiv" style="clear: left;">
				<table border="0" cellpadding="0" cellspacing="0" class="table" align="center" id="info">
					<tr>
						<td class="color_top" width="6%">
							i18n_nili.text.index_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_nili.text.nodeIp_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_nili.text.nodeName_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_nili.text.nodeType_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_nili.text.nodeHight_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_nili.text.systemId_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_nili.text.nodeGroup_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_nili.text.nodeState_n81i
						</td>
						<td class="color_top" width="15%">
							i18n_nili.text.createTime_n81i
						</td>
					</tr>
					<!-- 1、远程连接引入页面 -->
					<jsp:include page="/common/remoteConn.jsp" />
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(nodeList) > 0}">
							<c:forEach items="${nodeList}" var="node" varStatus="vs">
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
										<a  href="javascript:void(0);"
											onclick="remoteConn('${node.nodeSystemType }','${node.nodeIp}','${node.nodeType }', this)" >
												${node.nodeIp}
										</a>
									</td>
									<td class="${color }">
										${node.nodeName}
									</td>
									<td class="${color }">
										<c:if test="${node.nodeType==1}">
											<c:if test="${node.networElementType==1}">
												i18n_nili.message.specialDevice_n81i
											</c:if>
											<c:if test="${node.networElementType==2}">
												i18n_nili.message.diskArray_n81i
											</c:if>
											<c:if test="${node.networElementType==3}">
												i18n_nili.message.blockRouter_n81i
											</c:if>
											<c:if test="${node.networElementType==4}">
												i18n_nili.message.netElements_n81i
											</c:if>
										</c:if>
										<c:choose>
											<c:when test="${node.nodeType==0 && not empty node.specialServerType}">i18n_nili.text.specialServer_n81i</c:when>
											<c:when test="${node.nodeType==0}">i18n_nili.text.server_n81i</c:when>
										</c:choose>
									</td>
									<td class="${color }">
										${node.nodeUType}U
									</td>
									<td class="${color }">
										${node.systemIdName}
									</td>
									<td class="${color }">
										${node.groupIdName}
									</td>
									<td class="${color }">
										<c:if test="${node.nodeState=='1'}">i18n_nili.message.downline_n81i</c:if>
										<c:if test="${node.nodeState=='0'}">i18n_nili.message.online_n81i</c:if>
									</td>
									<td class="${color }">
										<fmt:formatDate value="${node.nodeCreatetime}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" height="35" class="color_6" align="center">
									i18n_nili.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				</div>
				<c:if test="${!empty nodeList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
