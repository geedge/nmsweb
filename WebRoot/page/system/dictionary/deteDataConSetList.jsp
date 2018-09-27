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
		<title>i18n_ddcsl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<script type="text/javascript">
			
			function updateRecord(id){
				document.form1.action = "<%=path%>/sysManage/dataDictionary.do?action=toUpdateDetectConditionSet&setId="+id;
				document.form1.submit();
		    }
		  
		</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<form name=form1 id="form1" action="<c:url value='/sysManage/dataDictionary.do?action=queryDetectConditionSet'/>" method="post" >
				<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td class="color_top" width="4%">
							i18n_ddcsl.text.index_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_ddcsl.text.menuName_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_ddcsl.text.policeEmergent_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_ddcsl.text.policeLevel_n81i
						</td>
						<td class="color_8" width="8%">
							i18n_ddcsl.text.opration_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(setDetDataConList) > 0}">
							<c:forEach items="${setDetDataConList}" var="aui" varStatus="vs">
								<input type="hidden" id="erbh${aui.id }"
									name="erbh${aui.id }" value="${aui.id}" />
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
									    ${aui.menuName}
									</td>
									<td class="${color }">
										${aui.policeEmergentFowShow}
									</td>
									<td class="${color }">
										${aui.policeLevelForShow}
									</td>
									<td class="${color_end }">
										<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<a href="javascript:updateRecord('${aui.id}')">i18n_ddcsl.text.editInfo_n81i</a>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" height="35" class="color_6" align="center">
									i18n_ddcsl.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				</div>
				<c:if test="${!empty typeTableList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
