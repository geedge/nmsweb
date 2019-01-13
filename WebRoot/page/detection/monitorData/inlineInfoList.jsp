<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
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
		<title>inline device info</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.suggest.js'/>"></script>
	</head>

	<script language="javascript" type="text/javascript">	
		var msg = '${MSG}';
			if(msg=='1'){
			alert("i18n_bril.message.success_n81i");
		}else if(msg=='2'){
			alert("i18n_bril.message.faild_n81i");
		}	 
	 	//查询记录
		function qry(){
			document.form3.action = "<%=path%>/detection/inlineDevice.do?action=query";
			document.form3.submit();		
		}
	 	
		jQuery(function(){
			$("#info").floatHeaderDiv();
		})
    </script>

	<body>
	<div class="middle_list">
		<form name="form3" id="frmArticleType"
			action="<c:url value='/detection/inlineDevice.do?action=query'/>" method="post">
			<div class="box_1">		 
					<label class="divTopText"><font class="selectText">IP</font>
					<input  style="width:140px;" name="nodeIp" id="nodeIp" value="${nodeIp}"></label>&nbsp;
					<label class="divTopText"><font class="selectText">i18n_addr_n81i</font>
					<select name="addrCode">
						<option value="" selected="selected">i18n_dil.message.statusDefault_n81i</option>
						<c:forEach items="${addrList }" var="addr">
							<option value="${addr['addr_code']}" <c:if test="${ addr['addr_code'] == addrCode}">selected="selected"</c:if>>${addr['addr_name'] }</option>
						</c:forEach>
					</select></label>&nbsp;
					<label class="divTopText"><font class="selectText">i18n_isp_n81i</font><!-- isp -->
					<select name="ispKeyCode">
						<option value="" selected="selected">i18n_dil.message.statusDefault_n81i</option>
						<c:forEach items="${ispList }" var="isp">
						
							<option value="${isp['isp_key_code']}" <c:if test="${ isp['isp_key_code'] == ispKeyCode}">selected="selected"</c:if>>${isp['isp_key_name'] }</option>
						</c:forEach>
					</select></label>&nbsp;
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
			</div>
			<div class="box_2"><jsp:include page="/include/include.jsp" /></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td width="5%" class="color_top">
						IP
					</td>
					<td width="5%" class="color_top">
						i18n_deviceType_n81i
					</td>
					<td width="5%" class="color_top">
						i18n_addr_n81i
					</td>
					<td width="5%" class="color_top">
						i18n_isp_n81i
					</td>
					<td width="5%" class="color_top">
						pass status
					</td>

					<td width="10%" class="color_top"><!-- 输入速度 mbps -->
						i18n_sdigp.text.inoctetsspeed_n81i
					</td> 
					<td width="10%" class="color_top"><!-- 输入包速率 pps -->
						i18n_sdigp.text.inpktsspeed_n81i
					</td> 
					<td width="10%" class="color_8">
						<!-- 更新时间 -->i18n_dclwl.text.dataCheckTime_n81i
					</td>
				</tr>
				<c:choose>
					<c:when test="${fn:length(page.result) > 0}">
						<c:forEach items="${page.result}" var="item" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
							</c:if>
							<tr>
								<td class="${color }">
									${item['ip_addr']}
								</td>
								<td class="${color }">
									${item['device_type']}
								</td>
								<td class="${color }">
									${item['addr_name']}
								</td>
								<td class="${color }">
									${item['isp_key_name']}
								</td>
								<td class="${color }">
									${item['propmStatus']}
								</td>
								<td class="${color }">
									${item['INOCTETSSPEED']}
								</td>
								<td class="${color }">
									${item['INPKTSSPEED']}
								</td>
								<td class="${color }">
									${item['DATA_CHECK_TIME']}
								</td>
							<tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10" height="20" align="center" class="color_6">
								i18n_mil.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<c:if test="${!empty page.result}">
				<jsp:include page="/common/page.jsp" />
			</c:if>
		</form>
		</div>
	</body>
</html>

