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
						<c:when test="${fn:length(checkTypeSetList) > 0}">
							<c:forEach items="${checkTypeSetList}" var="checkTypeSet" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr >
									<td class="${color }">
										<c:if test="${checkTypeSet.isSchedule=='0'}">
											<input type="checkbox" name="ids" id="ids"
													value="${checkTypeSet.id}" disabled="disabled"/>
										</c:if>
										<c:if test="${checkTypeSet.isSchedule=='2'}">
											<input type="checkbox" name="ids" id="ids"
													value="${checkTypeSet.id}" disabled="disabled"/>
										</c:if>
										<c:if test="${checkTypeSet.isSchedule=='1'}">
											<input type="checkbox" name="ids" id="ids" ${(ADMFlag && checkTypeSet.viewLevel ne 4) || (!ADMFlag && checkTypeSet.viewLevel eq 4) ? "disabled='disabled'":""}
													value="${checkTypeSet.id}"/>
										</c:if>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										<a href="javascript:showRecord('${checkTypeSet.id}')">${checkTypeSet.checkTypeName1}</a>
									</td>
									<td class="${color }">
										${checkTypeSet.checkTypeName}
									</td>
									<td class="${color }">
										${checkTypeSet.tableName}
									</td>
									<td class="${color }">
										${checkTypeSet.tableComments}
									</td>
									<td class="${color }">
										<c:if test="${checkTypeSet.isSchedule=='0'}">i18n_ctsilc.message.yes_n81i</c:if> 
										<c:if test="${checkTypeSet.isSchedule=='1'}">i18n_ctsilc.message.no_n81i</c:if>
										<c:if test="${checkTypeSet.isSchedule=='2'}">i18n_ctsilc.message.yes_n81i</c:if>
									</td>
									<td class="${color }">
										<c:if test="${checkTypeSet.isSnmp=='1'||checkTypeSet.isSnmp=='0'}">i18n_ctsilc.message.yes_n81i</c:if> 
										<c:if test="${checkTypeSet.isSnmp=='2'||checkTypeSet.isSnmp eq null}">i18n_ctsilc.message.no_n81i</c:if>
									</td>
									<td class="${color_end }">
										${checkTypeSet.checkRemark}
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
					</c:choose>
				
