<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
				<c:set var="index" value="${1}" />
				<c:choose>
					<c:when test="${fn:length(detecSetList) > 0}">
						<c:forEach items="${detecSetList}" var="detecSet" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
							<tr>
								<td class="${color }">
										<input type="checkbox" name="ids" id="ids" ${(ADMFlag && detecSet.viewLevel ne 4) || (!ADMFlag && detecSet.viewLevel eq 4) ? "disabled='disabled'":""}
											value="${detecSet.id}" />
										<input type="hidden" id="yxbz${detecSet.id }"
										    name="yxbz${detecSet.id }" value="${detecSet.detectionSetState}" />
										${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }" >
									${detecSet.nodeGroupsName}
								</td>
								<td class="${color }">
									${detecSet.nodeIpsName}
								</td>
								<td class="${color }">
									<a href="javascript:showRecord('${detecSet.id }')">${detecSet.checkTypeInfo.checkTypeName1}</a>
								</td>
								<!-- 
								<td class="${color }">
									<c:if test="${detecSet.checkWay=='0' }">主动</c:if>
									<c:if test="${detecSet.checkWay=='1' }">被动</c:if>
								</td>
								 -->
								<td class="${color }">
									${detecSet.checkGap}
								</td>
								<td class="${color }">
									${detecSet.checkMaxTimes}
								</td>
								<td class="${color }">
									${detecSet.checkOutTime}
								</td>
								<td class="${color }">
									<fmt:formatDate value="${detecSet.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td class="${color }">
									${detecSet.processIdenName}
								</td>
								<td class="${color }" style="word-break:break-all">
									${detecSet.processFile}
								</td>
								<td class="${color }" style="word-break:break-all">
									${detecSet.processPath}
								</td>
								<td class="${color }">
									<c:if test="${detecSet.isControlStart=='0' }">i18n_dsilc.message.manually_n81i</c:if> 
									<c:if test="${detecSet.isControlStart=='1' }">i18n_dsilc.message.NCStart_n81i</c:if>
								</td>
								<td class="${color }">
									<fmt:formatDate value="${detecSet.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td class="${color }">
									<c:if test="${detecSet.checkTypeInfo.isSchedule=='0' }">i18n_dsilc.message.yes_n81i</c:if> 
									<c:if test="${detecSet.checkTypeInfo.isSchedule=='1' }">i18n_dsilc.message.no_n81i</c:if>
								</td>
								<td class="${color_end }">
									<c:if test="${detecSet.detectionSetState=='0' }"><font color="#FF0000">i18n_dsilc.message.invalid_n81i</font></c:if> 
									<c:if test="${detecSet.detectionSetState=='1' }">i18n_dsilc.message.valid_n81i</c:if>
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>

					</c:when>
				</c:choose>

