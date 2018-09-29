<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>


<c:forEach var="paramMiss6" items="${paramM6}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable" style="table-layout: fixed;">
				<c:if test="${missionparametertable6.commandEName=='upgrade_agent'}"><!-- Agent升级 -->
					<tr>
						<td align="right" width="10%">
							i18n_cmcp.text.coverPath_n81i：
						</td>
						<td class="td_4">
							${paramMiss6.cover} &nbsp;
						</td>
						<td align="right" nowrap="nowrap" width="35%">
							i18n_cmcp.text.username_n81i：
						</td>
						<td class="td_4">
							${paramMiss6.username}&nbsp;
						</td>
					</tr>
				</c:if>
				<c:if test="${missionparametertable6.commandEName=='upgrade_other'||missionparametertable6.commandEName=='upgrade_server'}"><!-- 第三方升级部署逆向任务参数-->
						<tr>
							<td align="right" width="10%">
								i18n_cmcp.text.coverPath_n81i：
							</td>
							<td class="td_4">
								${paramMiss6.cover}
								&nbsp;
							</td>
							<td align="right" width="10%">
								i18n_cmcp.text.pidFile_n81i：
							</td>
							<td class="td_4">
								${paramMiss6.pidFile}&nbsp;
							</td>
						</tr>
						<tr>
							<td align="right" width="10%">
								i18n_cmcp.text.startupFile_n81i：
							</td>
							<td class="td_4">
								${paramMiss6.startupFile}&nbsp;
							</td>
							<td align="right" class="td_6" nowrap="nowrap" rowspan="3">
								i18n_cmcp.text.execParams_n81i：
							</td>
							<td class="td_4" rowspan="3">
							    <div style="word-break:break-all;word-wrap:break-word;"> 
						            ${paramMiss6.execParamsTmpStr}&nbsp;
						        </div>
							</td>
						</tr>
						<tr>
							<td align="right" nowrap="nowrap">
								i18n_cmcp.text.username_n81i：
							</td>
							<td class="td_4">
							   ${paramMiss6.username}&nbsp;
							</td>
						</tr>
						<tr>	
							<td align="right" nowrap="nowrap" width="10%">
								i18n_cmcp.text.maxWaitTime_n81i：
							</td>
							<td class="td_4">
							   <c:if test="${fn:length(paramMiss6.maxWaitTime)>0}">
									${paramMiss6.maxWaitTime}&nbsp;i18n_cmcp.text.second_n81i
								</c:if>
								&nbsp;
							</td>
						</tr>
				</c:if>
				<tr>
					<td align="right">
						i18n_cmcp.text.backups_n81i：
					</td>
					<td colspan="3" class="td_4">
                          <!-- 备份参数 -->
							    <c:forEach var="backupParam" items="${paramMiss6.backups}" >
									<div divType="file_div" id="file_div">
										<table class="templateTable" style="table-layout: fixed;">
											<tr>
												<td width="12%" align="right" nowrap="nowrap">
													i18n_cmcp.text.backupFile_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backup}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_cmcp.text.compression_n81i：
												</td>
												<td width="50%" class="td_4">
													<c:if test="${backupParam.isAbs=='Y'}">
														i18n_cmcp.text.absolutePath_n81i&nbsp;
													</c:if>
													<c:if test="${backupParam.isAbs=='N'}">
														i18n_cmcp.text.relativePath_n81i&nbsp;
													</c:if>
													&nbsp;
												</td>
											</tr>
											<tr>
												<td width="12%" align="right" valign="middle" nowrap="nowrap">
													i18n_cmcp.text.backupTo_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backupTo}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_cmcp.text.exceptFile_n81i：
												</td>
												<td width="50%" class="td_4" >
												       <div style="word-break:break-all;word-wrap:break-word;"> 
													    ${backupParam.exceptTmpStr}&nbsp;
													   </div>
												</td>
											</tr>
										</table>
									</div>
							</c:forEach>
							<c:if test="${fn:length(paramMiss6.backups)==0}">&nbsp;</c:if><!-- 当没有内容时，防止边框不显示 -->
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_cmcp.text.recovery_n81i：
					</td>
					<td colspan="3" class="td_4">
                          <!-- 恢复参数 -->
							    <c:forEach var="recoveryParam" items="${paramMiss6.recoverys}" >
									<div divType="file_div" id="file_div">
										<table class="templateTable" style="table-layout: fixed;">
											<tr>
												<td width="12%" align="right" nowrap="nowrap">
													i18n_cmcp.text.source_n81i：
												</td>
												<td width="30%" class="td_4">
													${recoveryParam.source}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_cmcp.text.decompression_n81i：
												</td>
												<td width="50%" class="td_4">
													<c:if test="${recoveryParam.isAbs=='Y'}">
														i18n_cmcp.text.absolutePath_n81i&nbsp;
													</c:if>
													<c:if test="${recoveryParam.isAbs=='N'}">
														i18n_cmcp.text.relativePath_n81i&nbsp;
													</c:if>
													&nbsp;
												</td>
											</tr>
											<tr>
												<td width="12%" align="right" valign="middle" nowrap="nowrap">
													i18n_cmcp.text.coverFile_n81i：
												</td>
												<td width="30%" class="td_4">
													${recoveryParam.cover}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_cmcp.text.deleteFile_n81i：
												</td>
												<td width="50%" class="td_4" >
												       <div style="word-break:break-all;word-wrap:break-word;"> 
													    ${recoveryParam.deleteTmpStr}&nbsp;
													   </div>
												</td>
											</tr>
										</table>
									</div>
						       </c:forEach>
						       <c:if test="${fn:length(paramMiss6.recoverys)==0}">&nbsp;</c:if><!-- 当没有内容时，防止边框不显示 -->
					</td>
				</tr>
			</table>
		</div>
</c:forEach>
