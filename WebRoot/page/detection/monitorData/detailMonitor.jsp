<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dm.message.title_n81i</title>
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
		var action ="<c:url value='/detection/monitorData.do?action=query'/>";		
		if($("#type").val()== "1"){
			action ="<c:url value='/detection/monitorData.do?action=queryNE'/>";
		}else if($("#type").val()== "2"){
			action ="<c:url value='/detection/monitorData.do?action=queryAbnormalSet'/>";
		} 
		if($("#flag").val()== "newTopo"){
			action ="<c:url value='/detection/monitorData.do?action=query&nodeType=${nodeType}&nodeId=${nodeId}'/>";
		}
		document.Mkform.action=action;
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
			<form action="<%=path%>/detection/monitorData!executeAction.do?action=detail" name="Mkform" method="post">
				<input type="hidden" name="flag" value="${flag }" id='flag'/>
				<input type="hidden" name="cip" id="cip" value="${cip }" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="stateInfo" id="stateInfo" value="${stateInfo}" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="checkType" value="${checkType }" />
				<input type="hidden" name="netElementType" value="${netElementType }" />
				<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
				<input type="hidden" value="${type }" name="type" id="type" />
				<c:forEach items="${ids}" var="ids" varStatus="vs">
					<input type="hidden" name="ids" id="ids" value="${ids}"/>
				</c:forEach>
				
				<!-- 是否为特种设备进入此页面 -->
				<input type="hidden" name="entry" id="entry" value="${entry }"/>
				<input type="hidden" name="detectId" id="detectId" value="${detectId }"/>
				<input type="hidden" name="seqId" id="seqId" value="${seqId }"/>
				<input type="hidden" name="ip" id="ip" value="${ip }"/>
				<input type="hidden" name="pid" id="pid" value="${pid }"/>
				<input type="hidden" name="nodeIpRange" id="nodeIpRange" value="${nodeIpRange }"/>
				<input type="hidden" name="nodeGroupStr" id="nodeGroupStr" value="${nodeGroupStr }"/>
				
				<!-- 来源于拓扑图 begin -->
				<input type="hidden" name="requestType" value="${requestType }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<!-- 来源于拓扑图 end -->
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				<div class="box_2">
					<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="goBack()" value="i18n_dm.button.back_n81i"/>
						&nbsp;	
				</div>
				<div style="height: 10px">
				</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_dm.text.detecationInfo_n81i</strong>
						</td>
					</tr>
					
					<c:if test="${nodeTable.nodeType==0&&not empty nodeTable.specialServerType}">
						<tr>
							<td colspan="4">
							<c:if test="${nodeTable.specialServerType==1}">
								<img src="<c:url value='/images/newtopo/ADC-A016-FRONT.png'/>">
							</c:if>
							<c:if test="${nodeTable.specialServerType==2}">
								<img src="<c:url value='/images/newtopo/ASEM-T102-FRONT.png'/>">
							</c:if>
							
							<c:if test="${nodeTable.specialServerType==1}">
								<img src="<c:url value='/images/newtopo/ADC-A016-BACK.png'/>">
							</c:if>
							<c:if test="${nodeTable.specialServerType==2}">
								<img src="<c:url value='/images/newtopo/ASEM-T102-BACK.png'/>">
							</c:if>
							</td>
						</tr>
					</c:if>
					
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_dm.text.processIdenName_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${detectionInfoNew.detectionSetInfo.processIdenName}	
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_dm.text.nodeIp_n81i：
						</td>
						<td class="color_3" align="left" width="20%">
							${nodeIp}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" >
							i18n_dm.text.datecationState_n81i：
						</td>
						<td class="color_3" align="left" >
						<!-- 
							<c:if test="${detectionInfoNew.detectionedState=='0' }"><FONT color="red">不正常</FONT></c:if> 
						 -->
						 	
							<c:if test="${detectionInfoNew.detectionedState == '1' }">i18n_dm.message.normal_n81i</c:if>	
							<c:if test="${detectionInfoNew.detectionedState != 1 }"><FONT color="red">i18n_dm.message.abnormal_n81i</FONT></c:if>	
						</td>
						<td class="color_1" align="right">
							i18n_dm.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${detectionInfoNew.detectionSetInfo.viewLevel=='1' }">i18n_dm.message.publisher_n81i</c:if> 
							<c:if test="${detectionInfoNew.detectionSetInfo.viewLevel=='2' }">i18n_dm.message.publisherGroup_n81i</c:if>
							<c:if test="${detectionInfoNew.detectionSetInfo.viewLevel=='3' }">i18n_dm.message.allInSys_n81i</c:if> 
							<c:if test="${detectionInfoNew.detectionSetInfo.viewLevel=='4' }">i18n_dm.message.unlimited_n81i</c:if>
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dm.text.detectionStateInfo_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${fn:replace(fn:replace(detectionInfoNew.detectionStateInfo,vEnter,'$@$'),'$@$','<br/>')}
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dm.text.performaceData_n81i：
						</td>
						<td class="color_3" align="left" colspan="3">
							${fn:replace(fn:replace(detectionInfoNew.performaceData,vEnter,'$@$'),'$@$','<br/>')}
						</td>
					</tr>
					<!-- 
					<tr>
						<td class="color_1" align="right">
							监测首次执行时间：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoNew.detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right">
							上传监测数据时间间隔(分钟)：
						</td>
						<td class="color_3" align="left">
							${detectionInfoNew.detectionSetInfo.uploadGap}
						</td>
					</tr>
					 -->
					<tr>
						<td class="color_1" align="right">
							i18n_dm.text.checkGap_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionInfoNew.detectionSetInfo.checkGap}
						</td>
						<td class="color_1" align="right">
							i18n_dm.text.currentTimes_n81i：
						</td>
						<td class="color_3" align="left">
							${detectionInfoNew.currentTimes }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_dm.text.nextCheckTime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${detectionInfoNew.nextCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right" >
							i18n_dm.text.dataArriveTime_n81i：
						</td>
						<td class="color_3" align="left" >
							<fmt:formatDate value="${detectionInfoNew.dataArriveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					
					<tr>
						<td class="color_1" align="right" >
							i18n_dm.text.datacheckTime_n81i：
						</td>
						<td class="color_3" align="left" >
							<fmt:formatDate value="${detectionInfoNew.datacheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td class="color_1" align="right">
							i18n_dm.text.checkWay_n81i：
						</td>
						<td class="color_3" align="left" >
							<c:if test="${detectionInfoNew.detectionSetInfo.checkWay=='0' }">i18n_dm.message.active_n81i</c:if> 
							<c:if test="${detectionInfoNew.detectionSetInfo.checkWay=='1' }">i18n_dm.message.passive_n81i</c:if>
						</td>
						
					</tr>
					<c:if test="${checkId eq '0' }">
					<tr>
						<td colspan="4" align="center">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
							<tr>
								<td colspan="4" class="color_top">
									<strong>i18n_dm.text.nodeSytemInfo_n81i</strong>
								</td>
							</tr>
							<c:if test="${dsinfo eq null }">
								<tr>
									<td colspan="4" class="color_1">
										<font color="red" >
											<c:if test="${nodeTable.nodeType==0 }">i18n_dm.message.noDataCollect_n81i</c:if>
											<c:if test="${nodeTable.nodeType==1 }">i18n_dm.message.noDataForSwitch_n81i</c:if>
										</font>
									</td>
								</tr>
							</c:if>
							<c:if test="${dsinfo ne null }">
								<tr>
									<td class="color_1" width="20%" align="right">
										i18n_dm.text.hostName_n81i：
									</td>
									<td class="color_3" width="30%" align="left">
										${dsinfo.hostName }
									</td>
									<td class="color_1" width="20%" align="right">
										i18n_dm.text.operateSystem_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.operateSystem }
									</td>
								</tr>
								<tr>
									<td class="color_1" width="20%" align="right">
										i18n_dm.text.cpuCnt_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.cpuCnt }
									</td>
									<td class="color_1" align="right">
										i18n_dm.text.cpuMhz_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.cpuMhz }
									</td>
								</tr>
								<tr>
									<td class="color_1" align="right">
										i18n_dm.text.memorySize_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.memorySize }
									</td>
									<td class="color_1" align="right" >
										i18n_dm.text.diskSize_n81i：
									</td>
									<td class="color_3" align="left" >
										${dsinfo.diskSize }
									</td>
									
								</tr>
								<tr>
									<td class="color_1" align="right">
										i18n_dm.text.swapSize_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.swapSize }
									</td>
									<td class="color_1" align="right" >
										i18n_dm.text.netCnt_n81i：
									</td>
									<td class="color_3" align="left" >
										${dsinfo.netCnt }
									</td>
									
								</tr>
								<tr>
									<td class="color_1" align="right">
										i18n_dm.text.dataCheckTime_n81i：
									</td>
									<td class="color_6" align="left">
										${dsinfo.dataCheckTimeStr }
									</td>
									<td class="color_1" align="right" >
										i18n_dm.text.dataArriveTime_n81i：
									</td>
									<td class="color_3" align="left" >
										${dsinfo.dataArriveTimeStr }
									</td>
								</tr>
								<tr>
									<td colspan="4" class="color_top">
										<strong>i18n_dm.text.diskInfo_n81i</strong>
									</td>
								</tr>
								<c:if test="${fn:length(dsiDiskList) eq 0}">
								<tr>
									<td colspan="4" class="color_1">
										<font color="red" >
											i18n_dm.message.diskInfo_n81i
										</font>
									</td>
								</c:if>
								<c:if test="${fn:length(dsiDiskList) > 0}">
								<tr>
									<td colspan="4">
										<table border="0" cellpadding="0" cellspacing="0" class="table1">
											<tr>
												<td class="color_top" width="10%">
													i18n_dm.text.index_n81i
												</td>
												<td class="color_top" width="45%">
													i18n_dm.text.diskRang_n81i
												</td>
												<td class="color_top" width="45%">
													i18n_dm.text.rangSize_n81i
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
										<strong>i18n_dm.text.netCardInfo_n81i</strong>
									</td>
								</tr>
								<c:if test="${fn:length(dsiNetList) eq 0}">
								<tr>
									<td colspan="4" class="color_1">
										<font color="red" >
											i18n_dm.message.netCardInfo_n81i
										</font>
									</td>
								</c:if>
								<c:if test="${fn:length(dsiNetList) > 0}">
								<tr>
									<td colspan="4">
										<table border="0" cellpadding="0" cellspacing="0" class="table1">
											<tr>
												<td class="color_top" width="4%">
													i18n_dm.text.index_n81i
												</td>
												<td class="color_top" width="8%">
													i18n_dm.text.netName_n81i
												</td>
												<td class="color_top" width="8%">
													i18n_dm.text.netState_n81i
												</td>
												<td class="color_top" width="8%">
													i18n_dm.text.netSpeed_n81i
												</td>
												<td class="color_top" width="8%">
													IP
												</td>
												<td class="color_top" width="8%">
													i18n_dm.text.netSubmask_n81i
												</td>
												<td class="color_top" width="8%">
													i18n_dm.text.netGateway_n81i
												</td>
												<td class="color_8" width="10%">
													i18n_dm.text.netMac_n81i
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
						</td>
					</tr>
					</c:if>
					<tr>
						<td colspan="4" align="center" class="color_8">
							<strong>i18n_dm.text.detecationData_n81i</strong>
						</td>
					</tr>
				</table>
					
					<div style="width: 100%;overflow:auto;">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table">
						<tr>
							<td align="center" colspan="4" class="color_6">
								<c:if test="${!empty titleList}">
									<table align="center" border="0" cellpadding="0" cellspacing="0" class="table1" id="t1">
										<tr><!-- 列表标题 -->
											<td  align="center" class="color_1">i18n_dm.text.index_n81i</td>
											<c:forEach items="${titleList}" var="title" varStatus="index">
													<td  align="center"
													     <c:if test="${(index.count)==fn:length(titleList)}"> class="color_7" </c:if>
													     <c:if test="${(index.count)!=fn:length(titleList)}"> class="color_1" </c:if> >
														${title.filedComments}
													</td>
											</c:forEach>
										</tr>
										
										<c:if test="${!empty infoMapList}"><!-- 数据 -->
											<c:forEach items="${infoMapList}" var="map" varStatus="index2">
											   <tr>
											   	   <td  align="center" class="color_3">${index2.count}</td>
												   <c:forEach items="${map}" var="datarow" >
														<td  class="color_3"  id="${datarow.key}">
															${datarow.value}
															<c:if test="${datarow.value == null }">&nbsp;</c:if>
														</td>
												   </c:forEach>
											   </tr>
											</c:forEach>
										</c:if>	
										
									</table>
								</c:if>						
								
								<c:if test="${empty infoMapList}">i18n_dm.text.noRecord_n81i</c:if>
							</td>
						</tr>
					    </table>
				    </div>
			</form>
		</div>
	</body>
</html>
