<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
					<c:choose>
							<c:when test="${fn:length(datasList) > 0}">
								<c:forEach items="${datasList}" var="typeData">
									<c:forEach items="${typeData}" var="rowData" varStatus="vs">
										<c:if test="${vs.index==0}" var="flag">
											<tr>
												<c:forEach items="${rowData}" var="cellData" varStatus="ind"
													begin="3" end="8">
													<c:set var="dsiId" value="${rowData[1] }" />
													<c:set var="seqId" value="${rowData[2] }" />
													<c:set var="nodeIp" value="${rowData[4] }" />
													<c:set var="checkDate" value="${rowData[9] }" />
													<c:choose>
														<c:when test="${ind.index eq 3}">
															<td class="color_1_1" rowspan="${fn:length(typeData)}"
																valign="top">
																<c:out value="${cellData}" default="" />
															</td>
														</c:when>


														<c:otherwise>
															<td class="color_1_1">
																<span class="STYLE1" style="word-break: break-all">
																	<c:out value="${cellData}" default="" /> </span>
															</td>
														</c:otherwise>
													</c:choose>

												</c:forEach>
												<td class="color_1_1">
													<a href='##showGrap'
														onclick="javascript:showGrap('${dsiId}','${seqId}','${nodeIp}');">
														i18n_sitlc.text.showGrap_n81i</a>
													<a
														href='<c:url value="/detection/switchDetection.do?action=singleSwitchInfo" />&detectId= ${dsiId}&seqId=${seqId}&checkDate=${checkDate}'>
														i18n_sitlc.text.showList_n81i </a>
												</td>
											</tr>
										</c:if>
										<c:if test="${!flag}">
											<tr>
												<c:forEach items="${rowData}" var="cellData" varStatus="ind"
													begin="3" end="8">
													<c:set var="dsiId" value="${rowData[1] }" />
													<c:set var="seqId" value="${rowData[2] }" />
													<c:set var="nodeIp" value="${rowData[4] }" />
													<c:set var="checkDate" value="${rowData[9] }" />
													<c:choose>
														<c:when test="${ind.index eq 3}">
														</c:when>
														<c:otherwise>
															<td class="color_1_1">
																<span class="STYLE1" style="word-break: break-all">
																	<c:out value="${cellData}" default="" /> </span>
															</td>
														</c:otherwise>
													</c:choose>

												</c:forEach>
												<td class="color_1_1">
													<a href='##showGrap'
														onclick="javascript:showGrap('${dsiId}','${seqId}','${nodeIp}');">
														i18n_sitlc.text.showGrap_n81i </a>
													<a
														href='<c:url value="/detection/switchDetection.do?action=singleSwitchInfo" />&detectId= ${dsiId}&seqId=${seqId}&checkDate=${checkDate}'>
														i18n_sitlc.text.showList_n81i</a>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:when>
						</c:choose>

