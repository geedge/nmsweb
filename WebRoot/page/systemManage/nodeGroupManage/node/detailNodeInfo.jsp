<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>i18n_dni.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript" 
			src="<c:url value='/js/jquery.js' />"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/j.suggest.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Nodeform.action="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
				document.Nodeform.submit();	
			}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_dni.button.back_n81i"/>
			 </div>	
			 <div style="height: 25px"></div>
			<form action="" name="Nodeform" method="post" style="border:0px;">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<input type="hidden" name="fromWhere" value="${fromWhere }"/>
				<input type="hidden" name="type" value="${type }"/>
				<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
				<input type="hidden" name="isValid" value="${isValid }" />
				<input type="hidden" name="nodeIpVo" value="${nodeIpVo }" />
				<input type="hidden" name="nodeNameVo" value="${nodeNameVo }" />
				<table border="0" cellpadding="0" cellspacing="0" class="table1">
				<tr>
					<td colspan="4" class="color_top">
						<strong>i18n_dni.text.title_n81i</strong>
					</td>
				</tr>
				<c:if test="${dsinfo eq null }">
					<tr>
						<td colspan="4" class="color_1">
							<font color="red" >
								<c:if test="${nodeTable.nodeType==0 }">i18n_dni.message.nodeType0_n81i</c:if>
								<c:if test="${nodeTable.nodeType==1 }">i18n_dni.message.nodeType1_n81i</c:if>
							</font>
						</td>
					</tr>
				</c:if>
				<c:if test="${dsinfo ne null }">
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_dni.text.hostName_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							${dsinfo.hostName }
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_dni.text.operateSystem_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.operateSystem }
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_dni.text.cpuCnt_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.cpuCnt }
						</td>
						<td class="color_1" align="right">
							i18n_dni.text.cpuMhz_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.cpuMhz }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dni.text.memorySize_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.memorySize }
						</td>
						<td class="color_1" align="right" >
							i18n_dni.text.diskSize_n81i：
						</td>
						<td class="color_3" align="left" >
							${dsinfo.diskSize }
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dni.text.swapSize_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.swapSize }
						</td>
						<td class="color_1" align="right" >
							i18n_dni.text.netCnt_n81i：
						</td>
						<td class="color_3" align="left" >
							${dsinfo.netCnt }
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dni.text.dataCheckTime_n81i：
						</td>
						<td class="color_6" align="left">
							${dsinfo.dataCheckTimeStr }
						</td>
						<td class="color_1" align="right" >
							i18n_dni.text.dataArriveTime_n81i：
						</td>
						<td class="color_3" align="left" >
							${dsinfo.dataArriveTimeStr }
						</td>
					</tr>
					<tr>
						<td colspan="4" class="color_top">
							<strong>i18n_dni.text.diskInfo_n81i</strong>
						</td>
					</tr>
					<c:if test="${fn:length(dsiDiskList) eq 0}">
					<tr>
						<td colspan="4" class="color_1">
							<font color="red" >
								i18n_dni.message.noDataGetFromDisk_n81i
							</font>
						</td>
					</c:if>
					<c:if test="${fn:length(dsiDiskList) > 0}">
					<tr>
						<td colspan="4">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_top" width="10%">
										i18n_dni.text.index_n81i
									</td>
									<td class="color_top" width="45%">
										i18n_dni.text.diskRang_n81i
									</td>
									<td class="color_top" width="45%">
										i18n_dni.text.rangSize_n81i
									</td>
								</tr>
								<c:forEach items="${dsiDiskList}" var="disk" varStatus="diskIndex"   >
									<c:set var="color" value="color_1" />
									<c:set var="color_end" value="color_7" />
									<c:if test="${diskIndex.index%2!=0 }">
										<c:set var="color" value="color_3" />
										<c:set var="color_end" value="color_6" />
									</c:if>
									<tr>
										<td class="${color }"  >
											${diskIndex.index+1 }
										</td>
										<td class="${color }" >
											${disk.diskRang }
										</td>
										<td class="${color }"  >
											${disk.diskSize }
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					</c:if>
					<tr>
						<td colspan="4" class="color_top">
							<strong>i18n_dni.text.netInfo_n81i</strong>
						</td>
					</tr>
					<c:if test="${fn:length(dsiDiskList) eq 0}">
					<tr>
						<td colspan="4" class="color_1">
							<font color="red" >
								i18n_dni.message.noDataGetFromNet_n81i
							</font>
						</td>
					</c:if>
					<c:if test="${fn:length(dsiDiskList) > 0}">
					<tr>
						<td colspan="4">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_top" width="4%">
										i18n_dni.text.index_n81i
									</td>
									<td class="color_top" width="8%">
										i18n_dni.text.netName_n81i
									</td>
									<td class="color_top" width="8%">
										i18n_dni.text.netState_n81i
									</td>
									<td class="color_top" width="8%">
										i18n_dni.text.netSpeed_n81i
									</td>
									<td class="color_top" width="8%">
										IP
									</td>
									<td class="color_top" width="8%">
										i18n_dni.text.netSubmask_n81i
									</td>
									<td class="color_top" width="8%">
										i18n_dni.text.netGateway_n81i
									</td>
									<td class="color_8" width="10%">
										i18n_dni.text.netMac_n81i
									</td>
								</tr>
								<c:forEach items="${dsiNetList}" var="net" varStatus="netIndex" >
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${netIndex.index%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										${netIndex.index+1}
									</td>
									<td class="${color }">
										${net.netName}
									</td>
									<td class="${color }">
										${net.netState}
									</td>
									<td class="${color }">
										${net.netSpeed}
									</td>
									<td class="${color }">
										${net.netIp}
									</td>
									<td class="${color }">
										${net.netSubmask}
									</td>
									<td class="${color }">
										${net.netGateway}
									</td>
									<td class="${color }">
										${net.netMac}
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
								</c:forEach>
							</table>
						</td>
					</tr>
					</c:if>		
				</c:if>
				</table>
			</form>
		</div>
	</body>
</html>
