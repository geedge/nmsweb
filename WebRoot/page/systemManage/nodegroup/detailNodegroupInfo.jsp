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
		<title>i18n_dngi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Nodeform.action="<%=path%>/sysManage/nodeGroupManage.do?action=query";
				document.Nodeform.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="Nodeform" method="post"
				style="margin: 0; padding: 0">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="nameVo" id="nameVo" value="${nameVo }" />
				<input type="hidden" name="descVo" id="descVo" value="${descVo }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<div style="clear: both" />
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_dngi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_dngi.text.groupName_n81i：
						</td>
						<td class="color_3" align="left"  width="30%">
							${nodeGroup.groupName }
						</td>
						<td class="color_1" align="right"  width="20%">
							i18n_dngi.text.groupType_n81i：
						</td>
						<td class="color_6" align="left">
							<c:if test="${nodeGroup.groupType==0 }">i18n_dngi.message.groupType0_n81i</c:if>
							<c:if test="${nodeGroup.groupType==1 }">i18n_dngi.message.groupType1_n81i</c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dngi.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${nodeGroup.viewLevel==1 }">i18n_dngi.message.publisher_n81i</c:if>
							<c:if test="${nodeGroup.viewLevel==2 }">i18n_dngi.message.publisherGroup_n81i</c:if>
							<c:if test="${nodeGroup.viewLevel==3 }">i18n_dngi.message.allInSys_n81i</c:if>
						</td>
						<td class="color_1" align="right">
							i18n_dngi.text.isValid_n81i：
						</td>
						<td class="color_6" align="left">
							<c:if test="${nodeGroup.isValid==1 }">i18n_dngi.message.valid_n81i</c:if>
							<c:if test="${nodeGroup.isValid==0 }"><font color="red">i18n_dngi.message.invalid_n81i</font></c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dngi.text.systemId_n81i：
						</td>
						<td class="color_3" align="left">
							${nodeGroup.systemIdName }
						</td>
						<td class="color_1" align="right">
							i18n_dngi.text.createTime_n81i：
						</td>
						<td class="color_6" align="left">
							<fmt:formatDate value='${nodeGroup.groupCreatetime}' type='both' />
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dngi.text.userGroupIdName_n81i：
						</td>
						<td class="color_3" align="left">
							${nodeGroup.userGroupIdName }
						</td>
						<td class="color_1" align="right">
							i18n_dngi.text.groupDesc_n81i：
						</td>
						<td class="color_6" align="left">
							${nodeGroup.groupDesc }
						</td>
					</tr>
					<tr>
						<td class="color_9" colspan="4">
							<strong>i18n_dngi.text.nodeList_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" colspan="4">
							<table width="100%" align="center" border="0" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="4%" class="color_1">
										i18n_dngi.text.index_n81i
									</td>
									<td width="10%" class="color_1">
										i18n_dngi.text.nodeIp_n81i
									</td>
									<td width="15%" class="color_1">
										i18n_dngi.text.nodeName_n81i
									</td>
									<td width="20%" class="color_1">
										i18n_dngi.text.nodeDesc_n81i
									</td>
									<td width="12%" class="color_1">
										i18n_dngi.text.createTime_n81i
									</td>
									<td width="8%" class="color_7">
										i18n_dngi.text.nodeState_n81i
									</td>
								</tr>
								<c:choose>
									<c:when test="${fn:length(nodeList) > 0}">
										<c:forEach items="${nodeList}" var="node" varStatus="nodeVar">

											<tr>
												<td class="color_3">
													${nodeVar.count}
												<br /></td>
												<td class="color_3">
													${node.nodeIp}
												<br /></td>
												<td class="color_3">
													${node.nodeName}
												<br /></td>
												<td class="color_3">
													<c:if test="${fn:length(node.nodeDesc)>16}">
														${fn:substring(node.nodeDesc,0,16) }...
													</c:if>
													<c:if test="${fn:length(node.nodeDesc)<=16}">
														${node.nodeDesc }
													</c:if>
													&nbsp;
												<br /></td>
												<td class="color_3">
													<fmt:formatDate value="${node.nodeCreatetime}" type="both" />
												</td>
												<td class="color_6">
													<c:if test="${node.nodeState==0 }">i18n_dngi.message.nodeState0_n81i</c:if>
													<c:if test="${node.nodeState==1 }"><font color="red">i18n_dngi.message.nodeState1_n81i</font></c:if>
												</td>
											</tr>
										</c:forEach>

									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" height="20" align="center" class="color_6">
												i18n_dngi.text.noRecord_n81i
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="goBack()" value="i18n_dngi.text.back_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>