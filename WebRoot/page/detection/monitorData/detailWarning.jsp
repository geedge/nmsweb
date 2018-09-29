<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dw.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
	
	function goBack(){
		document.Mkform.action="<c:url value='/detection/monitorData.do?action=showDetectionInfo'/>";
		document.Mkform.submit();	
	}

	$(function(){
		<c:if test="${dictionMap ne null}">
			<c:forEach items="${dictionMap}" var="dmap" >
				$("#t1").find("td[id=${dmap.key}]").each(function(){
					var $ttd = $(this);
					<c:if test="${!empty (dmap.value)}">//VO
						<c:forEach items="${dmap.value.listOT}" var="op">
							if(${op.typeCode} == $ttd.text()){
								$ttd.text("${op.typeValue}");
							}
						</c:forEach>
					</c:if>	
				});
			</c:forEach>
		</c:if>
	});
	
</script>
	<body>
		<div class="middle_list">
			<form
				action="<%=path%>/detection/monitorData!executeAction.do?action=detail"
				name="Mkform" method="post">
				<input type="hidden" name="cip" id="cip" value="${cip }" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
				<input type="hidden" value="${type }" name="type" id="type" />
				<c:forEach items="${ids}" var="ids" varStatus="vs">
					<input type="hidden" name="ids" id="ids" value="${ids}" />
				</c:forEach>

				<!-- 是否为特种设备进入此页面 -->
				<input type="hidden" name="entry" id="entry" value="${entry }" />
				<input type="hidden" name="detectId" id="detectId"
					value="${detectId }" />
				<input type="hidden" name="seqId" id="seqId" value="${seqId }" />
				<input type="hidden" name="ip" id="ip" value="${ip }" />
				<input type="hidden" name="pid" id="pid" value="${pid }" />

				<!-- 来源于拓扑图 begin -->
				<input type="hidden" name="requestType" value="${requestType }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<!-- 来源于拓扑图 end -->
				<!-- 查看监测设置历史记录 begin -->
				<input type="hidden"  name ="dsiId" value="${dsiId }"/>
				<input type="hidden" name="sqId" value="${sqId }" />
				<input type="hidden" name="sTime" value="${sTime }" />
				<input type="hidden" name="eTime" value="${eTime }" />
				<input type="hidden" name="status" value="${status }" />
				<input type="hidden" name="showHistory" value="${showHistory }" />
				<!-- 查看监测设置历史记录 end -->
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				<div class="box_2">
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'" onclick="goBack()"
						value="i18n_dw.button.back_n81i" />
					&nbsp;
				</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_dw.message.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_dw.text.processIdenName_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${detectionInfoWarning.detectionSetInfo.processIdenName}
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_dw.text.nodeIp_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${nodeIp}
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.detectionedState_n81i：
						</td>
						<td class="color_3" align="left">
							<!-- 
							<c:if test="${detectionInfoWarning.detectionedState=='0' }"><FONT color="red">i18n_dw.message.abnormal_n81i</FONT></c:if> 
						 -->

							<c:if test="${detectionInfoWarning.detectionedState == '1' }">i18n_dw.message.normal_n81i</c:if>
							<c:if test="${detectionInfoWarning.detectionedState != 1 }">
								<FONT color="red">i18n_dw.message.abnormal_n81i</FONT>
							</c:if>
						</td>
						<td class="color_1" align="right">
							i18n_dw.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionInfoWarning.detectionSetInfo.viewLevel=='1' }">i18n_dw.message.publisher_n81i</c:if>
							<c:if test="${detectionInfoWarning.detectionSetInfo.viewLevel=='2' }">i18n_dw.message.publisherGroup_n81i</c:if>
							<c:if test="${detectionInfoWarning.detectionSetInfo.viewLevel=='3' }">i18n_dw.message.allInSys_n81i</c:if>
							<c:if test="${detectionInfoWarning.detectionSetInfo.viewLevel=='4' }">i18n_dw.message.unlimited_n81i</c:if>
						</td>

					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.detectionStateInfo_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${detectionInfoWarning.detectionStateInfo }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.performaceData_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${detectionInfoWarning.performaceData }
						</td>
					</tr>
					<!-- 
					<tr>
						<td class="color_1" align="right">
							监测首次执行时间：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoWarning.detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right">
							上传监测数据时间间隔(分钟)：
						</td>
						<td class="color_3" align="left">
							${detectionInfoWarning.detectionSetInfo.uploadGap}
						</td>
					</tr>
					 -->
					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.checkGap_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionInfoWarning.detectionSetInfo.checkGap}
						</td>
						<td class="color_1" align="right">
							i18n_dw.text.currentTimes_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionInfoWarning.currentTimes }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.nextCheckTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoWarning.nextCheckTime}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td class="color_1" align="right">
							i18n_dw.text.dataArriveTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoWarning.dataArriveTime}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>

					<tr>
						<td class="color_1" align="right">
							i18n_dw.text.dataCheckTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoWarning.dataCheckTime}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td class="color_1" align="right">
							i18n_dw.text.checkWay_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionInfoWarning.detectionSetInfo.checkWay=='0' }">i18n_dw.message.active_n81i</c:if>
							<c:if test="${detectionInfoWarning.detectionSetInfo.checkWay=='1' }">i18n_dw.message.passive_n81i</c:if>
						</td>

					</tr>
					<c:if test="${checkId eq '0' }">
						<tr>
							<td colspan="4" align="center">
								<table border="0" cellpadding="0" cellspacing="0" class="table1">
									<tr>
										<td colspan="4" class="color_top">
											<strong>i18n_dw.text.nodeSystemInfo_n81i</strong>
										</td>
									</tr>
									<c:if test="${dsinfo eq null }">
										<tr>
											<td colspan="4" class="color_1">
												<font color="red"> <c:if
														test="${nodeTable.nodeType==0 }">i18n_dw.message.nodeType0_n81i</c:if> <c:if
														test="${nodeTable.nodeType==1 }">i18n_dw.message.nodeType1_n81i</c:if> </font>
											</td>
										</tr>
									</c:if>
									<c:if test="${dsinfo ne null }">
										<tr>
											<td class="color_1" width="20%" align="right">
												i18n_dw.text.hostName_n81i：
											</td>
											<td class="color_3" width="30%" align="left">
												${dsinfo.hostName }
											</td>
											<td class="color_1" width="20%" align="right">
												i18n_dw.text.operateSystem_n81i：
											</td>
											<td class="color_6" align="left">
												${dsinfo.operateSystem }
											</td>
										</tr>
										<tr>
											<td class="color_1" width="20%" align="right">
												i18n_dw.text.cpuCnt_n81i：
											</td>
											<td class="color_6" align="left">
												${dsinfo.cpuCnt }
											</td>
											<td class="color_1" align="right">
												CPU主频(MHz)：
											</td>
											<td class="color_6" align="left">
												${dsinfo.cpuMhz }
											</td>
										</tr>
										<tr>
											<td class="color_1" align="right">
												i18n_dw.text.cpuMhz_n81i：
											</td>
											<td class="color_6" align="left">
												${dsinfo.memorySize }
											</td>
											<td class="color_1" align="right">
												i18n_dw.text.diskSize_n81i：
											</td>
											<td class="color_3" align="left">
												${dsinfo.diskSize }
											</td>

										</tr>
										<tr>
											<td class="color_1" align="right">
												SWAP大小(G)：
											</td>
											<td class="color_6" align="left">
												${dsinfo.swapSize }
											</td>
											<td class="color_1" align="right">
												i18n_dw.text.swapSize_n81i：
											</td>
											<td class="color_3" align="left">
												${dsinfo.netCnt }
											</td>

										</tr>
										<tr>
											<td class="color_1" align="right">
												i18n_dw.text.dataCheckTime_n81i：
											</td>
											<td class="color_6" align="left">
												${dsinfo.dataCheckTimeStr }
											</td>
											<td class="color_1" align="right">
												i18n_dw.text.dataStorageTime_n81i：
											</td>
											<td class="color_3" align="left">
												${dsinfo.dataArriveTimeStr }
											</td>
										</tr>
										<tr>
											<td colspan="4" class="color_top">
												<strong>i18n_dw.text.diskInfo_n81i</strong>
											</td>
										</tr>
										<c:if test="${fn:length(dsiDiskList) eq 0}">
											<tr>
												<td colspan="4" class="color_1">
													<font color="red"> i18n_dw.message.diskInfo_n81i </font>
												</td>
										</c:if>
										<c:if test="${fn:length(dsiDiskList) > 0}">
											<tr>
												<td colspan="4">
													<table border="0" cellpadding="0" cellspacing="0"
														class="table1">
														<tr>
															<td class="color_top" width="10%">
																i18n_dw.text.index_n81i
															</td>
															<td class="color_top" width="45%">
																i18n_dw.text.diskRang_n81i
															</td>
															<td class="color_top" width="45%">
																i18n_dw.text.rangSize_n81i
															</td>
														</tr>
														<c:forEach items="${dsiDiskList}" var="disk"
															varStatus="diskIndex">
															<c:set var="color" value="color_1" />
															<c:set var="color_end" value="color_7" />
															<c:if test="${diskIndex.index%2!=0 }">
																<c:set var="color" value="color_3" />
																<c:set var="color_end" value="color_6" />
															</c:if>
															<tr>
																<td class="${color }">
																	${diskIndex.index+1 }
																</td>
																<td class="${color }">
																	${disk.diskRang }
																</td>
																<td class="${color }">
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
												<strong>i18n_dw.text.netInfo_n81i</strong>
											</td>
										</tr>
										<c:if test="${fn:length(dsiNetList) eq 0}">
											<tr>
												<td colspan="4" class="color_1">
													<font color="red"> i18n_dw.message.netInfo_n81i </font>
												</td>
										</c:if>
										<c:if test="${fn:length(dsiNetList) > 0}">
											<tr>
												<td colspan="4">
													<table border="0" cellpadding="0" cellspacing="0"
														class="table1">
														<tr>
															<td class="color_top" width="4%">
																i18n_dw.text.index_n81i
															</td>
															<td class="color_top" width="8%">
																i18n_dw.text.netName_n81i
															</td>
															<td class="color_top" width="8%">
																i18n_dw.text.netState_n81i
															</td>
															<td class="color_top" width="8%">
																i18n_dw.text.netSpeed_n81i
															</td>
															<td class="color_top" width="8%">
																IP
															</td>
															<td class="color_top" width="8%">
																i18n_dw.text.netSubmask_n81i
															</td>
															<td class="color_top" width="8%">
																i18n_dw.text.netGateway_n81i
															</td>
															<td class="color_8" width="10%">
																i18n_dw.text.netMac_n81i
															</td>
														</tr>
														<c:forEach items="${dsiNetList}" var="net"
															varStatus="netIndex">
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
							</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="4" align="center" class="color_8">
							<strong>i18n_dw.text.detecationData_n81i</strong>
						</td>
					</tr>
				</table>

				<div style="width: 100%; overflow: auto;">
					<table border="0" cellpadding="0" cellspacing="0" width="100%"
						class="table">
						<tr>
							<td align="center" colspan="4" class="color_6">
								<c:if test="${!empty titleList}">
									<table align="center" border="0" cellpadding="0"
										cellspacing="0" class="table1" id="t1">
										<tr>
											<!-- 列表标题 -->
											<td align="center" class="color_1">
												i18n_dw.text.index_n81i
											</td>
											<c:forEach items="${titleList}" var="title" varStatus="index">
												<td align="center"
													<c:if test="${(index.count)==fn:length(titleList)}"> class="color_7" </c:if>
													<c:if test="${(index.count)!=fn:length(titleList)}"> class="color_1" </c:if>>
													${title.filedComments}
												</td>
											</c:forEach>
										</tr>

										<c:if test="${!empty infoMapList}">
											<!-- 数据 -->
											<c:forEach items="${infoMapList}" var="map"
												varStatus="index2">
												<tr>
													<td align="center" class="color_3">
														${index2.count}
													</td>
													<c:forEach items="${map}" var="datarow">
														<td class="color_3" id="${datarow.key}">
															${datarow.value}
															<c:if test="${datarow.value == null }">&nbsp;</c:if>
														</td>
													</c:forEach>
												</tr>
											</c:forEach>
										</c:if>

									</table>
								</c:if>

								<c:if test="${empty infoMapList}">i18n_dw.text.noRecord_n81i</c:if>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
