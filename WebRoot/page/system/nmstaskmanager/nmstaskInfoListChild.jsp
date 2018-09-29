<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:set var="index" value="${(pageNo-1)*page.pageSize+ 1}" />
<c:choose>
<c:when test="${fn:length(missionstateTableList) > 0}">
	<c:forEach items="${missionstateTableList}"	var="missionstatetable">
	<c:if test="${index%2 eq 1}">
		<c:set var="tdClass" value="color_1" />
		<c:set var="tdClassR" value="color_7" />
	</c:if>
	<c:if test="${index%2 eq 0}">
		<c:set var="tdClass" value="color_3" />
		<c:set var="tdClassR" value="color_6" />
	</c:if>
<tr>
	<td class="${tdClass }" nowrap="nowrap">
		<input type="hidden" id="yxbz${missionstatetable.missionId }" name="yxbz${missionstatetable.missionId }"	value="${missionstatetable.missionState}" />
		<input type="hidden" id="loopFlag${missionstatetable.missionId }" name="loopFlag${missionstatetable.missionId }" value="${missionstatetable.loopFlag}" />
		<input type="checkbox" name="pid" id="pid" value="${missionstatetable.missionId}"  ${ADMFlag ? "disabled='disabled'":""} />${index}
	</td>
	<td class="${tdClass }" nowrap="nowrap">
		<a href="javaScript:viewResultsStatistics('${missionstatetable.missionId}');">i18n_ntilc.text.resultView_n81i</a>
		<c:if test="${missionstatetable.userId eq loginUserId}">
		<a href="javaScript:editMissionViewLevel('${missionstatetable.missionId}');">i18n_ntilc.text.updateInfo_n81i</a>
		</c:if>
	</td>
	<td class="${tdClass }" nowrap="nowrap"><a href="javaScript:viewMissionInfo('${missionstatetable.missionId}');" title="点击查看任务信息">${missionstatetable.missionName}</a></td>
	<td class="${tdClass }" nowrap="nowrap">
		<c:if test="${missionstatetable.missionType eq 1}">
			i18n_ntilc.message.filePush_n81i
		</c:if>
		<c:if test="${missionstatetable.missionType eq 2}">
			i18n_ntilc.message.getNonStream_n81i
		</c:if>
		<c:if test="${missionstatetable.missionType eq 3}">
			i18n_ntilc.message.getStream_n81i
		</c:if>
		<c:if test="${missionstatetable.missionType eq 5}">
			i18n_ntilc.message.shellRegist_n81i
		</c:if>
		<c:if test="${missionstatetable.missionType eq 4}">
			i18n_ntilc.message.commandExec_n81i
		</c:if>
		<c:if test="${missionstatetable.missionType eq 6}">
			i18n_ntilc.message.upgradeDeployment_n81i
		</c:if>
	</td>
	<td class="${tdClass }" nowrap="nowrap">
		<c:if test="${missionstatetable.loopFlag eq 1}">i18n_ntilc.message.Y_n81i</c:if>
		<c:if test="${missionstatetable.loopFlag eq 0}">i18n_ntilc.message.N_n81i</c:if>
	</td>
	<td class="${tdClass }" nowrap="nowrap">
		<c:if test="${missionstatetable.missionState eq 1}">i18n_ntilc.message.missionCreated_n81i</c:if>
		<c:if test="${missionstatetable.missionState eq 2}">i18n_ntilc.message.taskExec_n81i</c:if>
        <c:if test="${missionstatetable.missionState eq 3 }"><font color="blue">i18n_ntilc.message.completed_n81i</font></c:if>	
                       <c:if test="${missionstatetable.missionState eq 30}"><font color="green">i18n_ntilc.message.allSuccess_n81i</font></c:if>
		<c:if test="${missionstatetable.missionState eq 32}"><font color="#e47833">i18n_ntilc.message.partiallySuccess_n81i</font></c:if>
		<c:if test="${missionstatetable.missionState eq 31}"><font color="red">i18n_ntilc.message.allFailed_n81i</font></c:if>
		<c:if test="${missionstatetable.missionState eq 4}">i18n_ntilc.message.teskFailedExec_n81i</c:if>
		<c:if test="${missionstatetable.missionState eq 5}">i18n_ntilc.message.revocation_n81i</c:if>
		<c:if test="${missionstatetable.missionState eq 6}">i18n_ntilc.message.cancellation_n81i</c:if>
		<c:if test="${missionstatetable.missionState eq 7}">i18n_ntilc.message.cancelled_n81i</c:if>
		
	</td>
	<td class="${tdClass }" nowrap="nowrap">	
	    ${missionstatetable.missionStateDesc}
	</td>
	<td class="${tdClass }" nowrap="nowrap">${missionstatetable.systemIdName}</td>
	<td class="${tdClass }" nowrap="nowrap">${missionstatetable.groupIdName}</td>
	<td class="${tdClass }" nowrap="nowrap">
		<c:if test="${missionstatetable.viewLevel eq 1}">i18n_ntilc.message.publisher_n81i</c:if> 
		<c:if test="${missionstatetable.viewLevel eq 2}">i18n_ntilc.message.publisherGroup_n81i</c:if> 
		<c:if test="${missionstatetable.viewLevel eq 3}">i18n_ntilc.message.allInSys_n81i</c:if>
	</td>
	<td class="${tdClass }" nowrap="nowrap">${missionstatetable.userIdName}</td>
	<td class="${tdClassR }" nowrap="nowrap"><fmt:formatDate value="${missionstatetable.createTime}" type="both" /></td>
       </tr>
	<c:set var="index" value="${index + 1}" />
</c:forEach>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>