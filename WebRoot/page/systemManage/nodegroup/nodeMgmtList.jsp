<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script>
	document.location.href= "<%=path%>/sysManage/nodeManage!executeAction.do?action=query&nodeGroupId=${nodeGroup.groupId }";
</script>

<!-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>节点组信息</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Nodeform.action="<%=path%>/sysManage/nodeGroupManage.do?action=query";
				document.Nodeform.submit();	
			}
			
			$(function(){
				$("#win").load(function(){
					$(this).height($(this).contents().height());
				});
				$(window).resize(function(){
					$("#win").height($("#win").contents().height());
				});
			})
			
			function iLoad(){
				$("#win").height($("#win").contents().height());
			}
			
		</script>
	</head>
	<body onload="iLoad();">
		<div class="middle_list">
			<form action="" name="Nodeform" method="post"
				style="margin: 0; padding: 0">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="nameVo" id="nameVo" value="${nameVo }" />
				<input type="hidden" name="descVo" id="descVo" value="${descVo }" />
			</form>
			<div style="clear: both" />
			<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td class="color_8">
							<strong>${nodeGroup.groupName }下的节点管理</strong>
						</td>
					</tr>
					<tr>
						<td class="color_6" align="center">
							<iframe name="win" scrolling="no" width="100%" 
								frameborder="0" marginwidth="0" id="win" 
								src="${pageContext.request.contextPath }/sysManage/nodeManage!executeAction.do?action=query&nodeGroupId=${nodeGroup.groupId }">
							</iframe>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="goBack()"
								value="返回" />
							&nbsp;
						</td>
					</tr>
				</table>
		</div>
	</body>
</html>
 -->