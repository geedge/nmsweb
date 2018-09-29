<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_gnl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script type="text/javascript">
			$(function(){
				$(window.parent.document.getElementsByName(window.name)).height(0);
				var documentHeight = $(document).height();
				window.parent.changeHeight(documentHeight,window.name);
			});
		</script>
	</head>
	<body bgcolor="#EBECEB">
		<div class="middle_list1">
			<!--中间部分右边开始-->
			<form name=form1 id="from1"
				action="<c:url value='/sysManage/systemManage!getGroupNode.do'/>"
				method="post" style="margin: 0; padding: 0">
				<input type="hidden" name="position" value="${position }">
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }">
				<table border="0" cellpadding="0" cellspacing="0" class="table1" align="center">
					<tr>
						<td width="4%" class="color_1">
							i18n_gnl.text.index_n81i
						</td>
						<td width="10%" class="color_1">
							i18n_gnl.text.nodeIp_n81i
						</td>
						<td width="15%" class="color_1">
							i18n_gnl.text.nodeName_n81i
						</td>
						<td width="30%" class="color_1">
							i18n_gnl.text.nodeDesc_n81i
						</td>
						<td width="13%" class="color_1">
							i18n_gnl.text.createTime_n81i
						</td>
						<td width="8%" class="color_7">
							i18n_gnl.text.nodeState_n81i
						</td>
					</tr>
					<c:choose>
						<c:when test="${fn:length(nodeList) > 0}">
							<c:forEach items="${nodeList}" var="node" varStatus="nodeVar">

								<tr>
									<td class="color_3">
										${nodeVar.count + (pageNo-1)*pageSize}
									</td>
									<td class="color_3">
										${node.nodeIp}
									</td>
									<td class="color_3">
										${node.nodeName}
									</td>
									<td class="color_3">		
										<c:if test="${fn:length(node.nodeDesc) >= 12}">
											<c:out value="${fn:substring(node.nodeDesc,0,12)}..." default=""/>
										</c:if>
										<c:if test="${fn:length(node.nodeDesc) < 12}">
											<c:out value="${node.nodeDesc}" default=""/>&nbsp;
										</c:if>
									</td>
									<td class="color_3">
										<fmt:formatDate value="${node.nodeCreatetime}" type="both" />
									</td>
									<td class="color_6">
										<c:if test="${node.nodeState==0 }">i18n_gnl.message.nodeState0_n81i</c:if>
										<c:if test="${node.nodeState==1 }">i18n_gnl.message.nodeState1_n81i</c:if>
									</td>
								</tr>
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" height="20" align="center" class="color_6">
									i18n_gnl.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${!empty nodeList}">
				<jsp:include page="/common/page.jsp" />
				</c:if>
			</form>
		</div>
	</body>
</html>

