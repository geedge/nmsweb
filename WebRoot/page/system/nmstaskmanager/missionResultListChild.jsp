<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.hibernate.lob.SerializableClob"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
	request.setAttribute("vEnter","\n");
%>
			<c:set var="rowN" value="${rowN}" />
			<%
				List resultList =(List) request.getAttribute("resultObjects");
				if(resultList!=null){
					Iterator ite = resultList.iterator();
					for(;ite.hasNext();){
						Object[] result =(Object[])ite.next();
						SerializableClob clob = (SerializableClob)result[3];
						pageContext.setAttribute("result",result);
						String desc = (clob==null || clob.length()==0)?"":clob.getSubString(1,Integer.parseInt(clob.length()+""));
						pageContext.setAttribute("desc",desc);
			 %>
				<c:if test="${rowN % 2 eq 1}"><c:set var="color" value="color_1" /></c:if>
				<c:if test="${rowN % 2 eq 0}"><c:set var="color" value="color_3" /></c:if>
			<tr>
				<td class="${color }" >
				<!--周期任务-->
				<c:if test="${missionstatetable.loopFlag eq 1}">
					<input type="checkbox" id="ids" name="curid_ids"  value="${result[8]}_${result[6]}" />${rowN }
					<input type="hidden" value="${rowN }">
				</c:if>
				<!--非周期任务-->
				<c:if test="${missionstatetable.loopFlag ne 1}">
					<input type="checkbox" id="ids" name="ids" value="${result[6]}" />${rowN }
					<input type="hidden" value="${rowN }">
				</c:if>
				</td>
				<td class="${color }">${result[0]}</td>
				<td class="${color }">
					<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
					<a href="javascript:void(0);"
					   onclick="remoteConn('${result[4] }','${result[1]}','${result[5] }', this)">
					   ${result[1]}
					</a>
				</td>
				<td class="${color }">
					<c:if test="${result[2] eq 3}">i18n_mrlchild.message.underDelivery_n81i</c:if>
					<c:if test="${result[2] eq 40}">i18n_mrlchild.message.deliveredSuccess_n81i</c:if>
					<c:if test="${result[2] eq 50}">i18n_mrlchild.message.processStop_n81i</c:if>
					<c:if test="${result[2] eq 60}">i18n_mrlchild.message.fileBackup_n81i</c:if>
					<c:if test="${result[2] eq 70}">i18n_mrlchild.message.fileUpdate_n81i</c:if>
					<c:if test="${result[2] eq 80}">i18n_mrlchild.message.commandSuccess_n81i</c:if>
					<c:if test="${result[2] eq 81}">i18n_mrlchild.message.commandFailed_n81i</c:if>
					<c:if test="${result[2] eq 0}">i18n_mrlchild.message.success_n81i</c:if>
					<c:if test="${result[2] eq 1}">i18n_mrlchild.message.failed_n81i</c:if>
					<c:if test="${result[2] eq 5}">i18n_mrlchild.message.withDraw_n81i</c:if>
					<c:if test="${result[2] eq 6}">i18n_mrlchild.message.undo_n81i</c:if>
					<c:if test="${result[2] eq 7}">i18n_mrlchild.message.undoComplete_n81i</c:if>
					<c:if test="${result[2] eq -1}">i18n_mrlchild.message.decisionFailed_n81i</c:if>
				</td>
				<td class="${color }">
				<textarea cols="50" rows="4" readonly="readonly">${desc }</textarea>
				</td>
				<c:if test="${missionstatetable.missionType eq 4}">
				    <c:if test="${missionparameteriable4.commandEName=='upgrade_start' || missionparameteriable4.commandEName=='upgrade_exec' || missionparameteriable4.commandEName=='single_exec'}">
						<td class="${color }" width="200px">
						<c:forEach items="${fn:split(result[7],'@@@')}" var="result0" >
							<a href="javascript:uploadfile('${result0}')">${result0}</a><br />
						</c:forEach>
						</td>
					</c:if>
				</c:if>
			</tr>
			<c:set var="rowN" value="${rowN+1}" />
		<%}} %>