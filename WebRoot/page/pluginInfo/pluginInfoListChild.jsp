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
						<c:when test="${fn:length(pluginList) > 0}">
							<c:forEach items="${pluginList}" var="plugin" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr >
									<td class="${color }">										
										<input type="checkbox" name="ids" id="ids"
												value="${plugin.id}"/>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										${plugin.name}
									</td>
									<td class="${color }">
										${plugin.des}
									</td>
									<td class="${color }">
										${plugin.fileName}
									</td>
									<td class="${color }">
										${plugin.creatUserName}
									</td>
									<td class="${color }">
									 	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${plugin.creatTime}"  />
									</td>
									<td class="${color }">
										${plugin.updateUserName}
									</td>
									<td class="${color_end }">
									 	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${plugin.updateTime}"  />
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
					</c:choose>
				
