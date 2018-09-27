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
		<title>i18n_vil.message.title_n81i</title>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>"
			rel="stylesheet" type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>"
			type="text/javascript"></script>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />

		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>
		<script type="text/javascript" src="<%=path%>/templates/js/common.js"></script>
		<script src="<c:url value='/js/jquery.js'/>" type="text/javascript"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js' />"></script>

	</head>

	<script language="javascript" type="text/javascript">	
     
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/detection/monitorData.do?action=query";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(monid){
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=detail&ids="+monid;
		document.form3.submit();		
	}
		//绘制折线图
	 function drawPic(ctid,dsiId,ip){
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=drawPic&checkTypeId="+ctid+"&dsiId="+dsiId+"&ip="+ip;
		document.form3.submit();		
	}
	//parent.document.all("listFrame").style.height = document.body.scrollHeight + 16;
	
	
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
		if(parent.document.getElementById("lianxiangStatus").value=="2")
		{
			if(jQuery.trim(ajaxValue1)=="") return false;
			
			ajaxProperties = ajaxProperties1;
			ajaxTableName = ajaxTableName1;
			ajaxType = ajaxType1;
			id = id1;
			returnDiv = returnDiv1;
			
			ajaxValue = ajaxValue1;
			clearTimeout(set_Id);
			set_Id = setTimeout(ajaxForLianxiang,500);
		}
	}
	
	function ajaxForLianxiang() 
	{
		jQuery.post("<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
		{
			var lianxiangList = data.split(",");
			jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
		});
	}
    </script>


	<body>
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/monitorData.do'/>" method="post">
			<table width="99%" align="center" align="center" cellpadding="0"
				cellspacing="1" class="ta_color">
				<div style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>

				<tr>
					<td colspan="10">
						<table width="100%" border="0" cellpadding="0" cellspacing="1"
							class="ta_color">
							<tr class="td_color">
								<jsp:include page="/include/include.jsp"></jsp:include>
							</tr>
							<tr align="left">

								<td height="20" class="td_color" nowrap>
									<div align="left">
										<span class="STYLE1">&nbsp;&nbsp;i18n_vil.text.hostName_n81i : </span>
									</div>
								</td>

								<td height="20" bgcolor="#FFFFFF" nowrap>
									<div align="left">
										<span class="STYLE1"> &nbsp;&nbsp;<input type="text"
												id="nodeIp"
												onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
												name="nodeIp" title="i18n_vil.message.hostName_n81i" value="${nodeIp}" size="20" />
										</span>
										<div id='suggest1' class="ac_results"></div>
									</div>
								</td>

								<td height="20" class="td_color" nowrap>
									<div align="left">
										<span class="STYLE1">&nbsp;&nbsp;i18n_vil.text.checkType_n81i : </span>
									</div>
								</td>

								<td height="20" bgcolor="#FFFFFF" nowrap>
									<div align="left">
										<span class="STYLE1"> 
											&nbsp;&nbsp;
											<input type="text" id="checkTypeName" 
												onkeyup="lianxiangkeyup('checkTypeName', 'CheckTypeInfo', 'String', 'checkTypeName','suggest2', this.value);"
												name="checkTypeName"
												title="i18n_vil.message.checkType_n81i" 
												value="${checkTypeName}" size="20" />
										</span>
										<div id='suggest2' class="ac_results"></div>
									</div>
								</td>

								<td height="20" class="td_color">
									<div align="center">
										<img src="<c:url value='/desktop/images/anniu/anniu_3${userBgColor }.png'/>" 
											align="center" onclick="javascript:qry()"
											border="0" />
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="10%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_vil.text.hostName_n81i</span>
						</div>
					</td>
					<td width="8%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_vil.text.checkType_n81i</span>
						</div>
					</td>
					<td width="8%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_vil.text.processIdenName_n81i</span>
						</div>
					</td>
					<td width="5%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_vil.text.state_n81i</span>
						</div>
					</td>
					<td width="10%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_vil.text.dataCheckTime_n81i</span>
						</div>
					</td>
					<td width="10%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_vil.text.persistTime_n81i</span>
						</div>
					</td>
					<td width="5%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_vil.text.tryTimes_n81i</span>
						</div>
					</td>
					<td width="22%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_vil.text.stateInfo_n81i</span>
						</div>
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
					<c:when test="${fn:length(vnodeIpGroupList) > 0}">
						<c:forEach items="${vnodeIpGroupList}" var="detecInfoList">
							<c:forEach items="${detecInfoList}" var="detecNewInfo"
								varStatus="vs">
								<c:if test="${vs.index==0}" var="flag">
									<tr>
										<td bgcolor="#FFFFFF" rowspan="${fn:length(detecInfoList)}" valign="top">
											<div align="center" class="STYLE1">
											<span class="STYLE1">
												<c:if test="${detecNewInfo.nodeIp != null }">${detecNewInfo.nodeIp}</c:if>
												<c:if test="${detecNewInfo.nodeIp == null }">&nbsp;</c:if>
											</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1"> <a
													href="javascript:showRecord('${detecNewInfo.id }')">${detecNewInfo.detectionSetInfo.checkTypeInfo.checkTypeName}</a>&nbsp;&nbsp;
													<a
													href="javascript:drawPic('${detecNewInfo.detectionSetInfo.checkTypeInfo.id }','${detecNewInfo.detectionSetInfo.id }','${detecNewInfo.nodeIp}')"><img
															src="${pageContext.request.contextPath }/img/action.gif"
															border=0 height="15" width="15" alt=""> </a> </span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.detectionSetInfo.processIden}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">
													<c:if test="${fn:trim(detecNewInfo.detectionedState)=='1'}"><img src="<c:url value='/desktop/images/desktop/yes.gif'/>"
									border="0" align="middle" /></c:if>
													<c:if test="${fn:trim(detecNewInfo.detectionedState) ne '1'}"><img src="<c:url value='/desktop/images/desktop/no.gif'/>"
									border="0" align="middle" /></c:if>
												</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1"><fmt:formatDate value="${detecNewInfo.datacheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
												</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.persistTime}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.currentTimes}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.detectionStateInfo}</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:if test="${!flag}">
									<tr>
										<!-- 
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<input type="checkbox" name="ids" id="ids"
													value="${detecNewInfo.id}" />
												<span class="STYLE1">${index+(pageNo-1)*pageSize}</span>
											</div>
										</td>
										 -->
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1"> <a
													href="javascript:showRecord('${detecNewInfo.id }')">${detecNewInfo.detectionSetInfo.checkTypeInfo.checkTypeName}</a>&nbsp;&nbsp;
													<a href="javascript:drawPic('${detecNewInfo.detectionSetInfo.checkTypeInfo.id }','${detecNewInfo.detectionSetInfo.id }','${detecNewInfo.nodeIp}')">
													<img src="${pageContext.request.contextPath }/img/action.gif" border=0 height="15" width="15" alt=""> </a> </span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.detectionSetInfo.processIden}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">
													<c:if test="${fn:trim(detecNewInfo.detectionedState)=='0'}"><img src="<c:url value='/desktop/images/desktop/no.gif'/>"
									border="0" align="middle" /></c:if>
													<c:if test="${fn:trim(detecNewInfo.detectionedState)=='1'}"><img src="<c:url value='/desktop/images/desktop/yes.gif'/>"
									border="0" align="middle" /></c:if>
													<c:if test="${fn:trim(detecNewInfo.detectionedState)=='-1'}"><img src="<c:url value='/desktop/images/desktop/no.gif'/>"
									border="0" align="middle" /></c:if>
												</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1"><fmt:formatDate value="${detecNewInfo.datacheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.persistTime}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.currentTimes}</span>
											</div>
										</td>
										<td bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<span class="STYLE1">${detecNewInfo.detectionStateInfo}</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10" height="20" bgcolor="#FFFFFF">
								<div align="center">
									<span class="STYLE1">i18n_vil.text.noRecord_n81i${fn:length(vnodeIpGroupList)}</span>
								</div>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<td height="20" colspan="10" class="td_color">
						<jsp:include page="/common/page.jsp" /></td>
				</tr>

			</table>
		</form>
		<br />
	</body>
</html>

