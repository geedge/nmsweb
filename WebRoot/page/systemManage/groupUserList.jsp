<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_gul.message.title_n81i</title>
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
			<form name=form1 id="from1"
				action="<c:url value='/sysManage/systemManage!getGroupUser.do'/>"
				method="post" style="margin: 0; padding: 0">
				<input type="hidden" name="position" value="${position }">
				<input type="hidden" name="userGroupId" value="${userGroupId }">
				<table border="0" cellpadding="0" cellspacing="0" class="table1" align="center">
					<tr>
						<td width="4%" class="color_1">
							i18n_gul.text.index_n81i
						</td>

						<td width="10%" class="color_1">
							i18n_gul.text.userId_n81i
						</td>
						<td width="15%" class="color_1">
							i18n_gul.text.username_n81i
						</td>
						<td width="12%" class="color_1">
							i18n_gul.text.createTime_n81i
						</td>
						<td width="5%" class="color_7">
							i18n_gul.text.isVaild_n81i
						</td>
					</tr>
					<c:choose>
						<c:when test="${fn:length(userList) > 0}">
							<c:forEach items="${userList}" var="user" varStatus="userVar">

								<tr>
									<td class="color_3">
										${userVar.count + (pageNo-1)*pageSize}
									</td>
									<td class="color_3">
										${user.yhbh}
									</td>
									<td class="color_3">
										${user.yhmc}
									</td>
									<td class="color_3">
										<fmt:formatDate value="${user.ctime}" type="both" />
									</td>
									<td class="color_6">
										<c:if test="${user.zxbz==0}" var="flag">i18n_gul.message.isVaild0_n81i</c:if>
										<c:if test="${!flag}">i18n_gul.message.isVaild1_n81i</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" height="20" align="center" class="color_6">
									i18n_gul.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${!empty userList}">
					<jsp:include page="/common/page.jsp" />
				</c:if>
			</form>
		</div>
	</body>
</html>

