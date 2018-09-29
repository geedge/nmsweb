<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<!-- 任务六：升级部署模板定义 -->
<div id="AgentUpgradeTemplate" style="display: none"> <!-- Agent升级 -->
	<c:forEach var="paramMiss6" items="${paramM6}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable" style="table-layout: fixed;">
				<tr>
				    <td width="10%" align="right" nowrap="nowrap">
						i18n_mcp6.text.fileName_n81i：
					</td>
					<td width="25%" class="td_4">
						${paramMiss6.fileName}&nbsp;
					</td>
					<td width="10%" align="right" nowrap="nowrap" >
						i18n_mcp6.text.cover_n81i：
					</td>
					<td width="35%" class="td_4">
						${paramMiss6.cover}&nbsp;
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap="nowrap">
						i18n_mcp6.text.isCreateCover_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss6.isCreateCover=='Y'}">
							i18n_mcp6.message.isCreateCoverY_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss6.isCreateCover=='N'}">
							i18n_mcp6.message.isCreateCoverN_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.permisson_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.permisson}&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.username_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.username}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.decompression_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss6.isAbs=='Y'}">
							i18n_mcp6.text.absolutePath_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss6.isAbs=='N'}">
							i18n_mcp6.text.relativePath_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.groupName_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.groupName}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.deleteFile_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.deleteTmpStr}&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" >
						i18n_mcp6.text.backup_n81i：
					</td>
					<td colspan="3" class="td_4">
                          <div id="upgradeBackupTemplate" style="display: inline"> <!-- 添加备份参数 -->
							    <c:forEach var="backupParam" items="${paramMiss6.backups}" >
									<div divType="file_div" id="file_div">
										<table class="templateTable" style="table-layout: fixed;">
											<tr>
												<td width="12%" align="right" nowrap="nowrap">
													i18n_mcp6.text.needBackupFile_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backup}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_mcp6.text.compression_n81i：
												</td>
												<td width="50%" class="td_4">
													<c:if test="${backupParam.isAbs=='Y'}">
														i18n_mcp6.text.absolutePath_n81i&nbsp;
													</c:if>
													<c:if test="${backupParam.isAbs=='N'}">
														i18n_mcp6.text.relativePath_n81i&nbsp;
													</c:if>
													&nbsp;
												</td>
											</tr>
											<tr>
												<td width="12%" align="right" valign="middle" nowrap="nowrap">
													i18n_mcp6.text.backupTo_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backupTo}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_mcp6.text.exceptFile_n81i：
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
							</div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>
<div id="OtherUpgradeTemplate" style="display: none"> <!-- 第三方升级部署+Server升级 -->
    <c:forEach var="paramMiss6" items="${paramM6}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable" >
			    <tr>
				    <td width="10%" align="right" nowrap="nowrap">
						i18n_mcp6.text.fileName_n81i：
					</td>
					<td width="90%" colspan="3" class="td_4">
					    ${paramMiss6.fileName}&nbsp;
					</td>
				</tr>
				<tr>
					
					<td align="right" width="10%" nowrap="nowrap">
						i18n_mcp6.text.isCreateCover_n81i：
					</td>
					<td class="td_4" width="35%" >
						<c:if test="${paramMiss6.isCreateCover=='Y'}">
							i18n_mcp6.message.isCreateCoverY_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss6.isCreateCover=='N'}">
							i18n_mcp6.message.isCreateCoverN_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
					<td align="right" nowrap="nowrap" width="10%" >
						i18n_mcp6.text.cover_n81i：
					</td>
					<td class="td_4" >
						${paramMiss6.cover}&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.startupFile_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.startupFile}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.decompression_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss6.isAbs=='Y'}">
							i18n_mcp6.text.absolutePath_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss6.isAbs=='N'}">
							i18n_mcp6.text.relativePath_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>	
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.pidFile_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.pidFile}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.forceExec_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss6.forceExec=='Y'}">
							i18n_mcp6.message.Y_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss6.forceExec=='N'}">
							i18n_mcp6.message.N_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.username_n81i：
					</td>
					<td class="td_4">
					    ${paramMiss6.username}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.permisson_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.permisson}&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.groupName_n81i：
					</td>
					<td class="td_4">
						${paramMiss6.groupName}&nbsp;
					</td>
					<td align="right" class="td_6" nowrap="nowrap">
						i18n_mcp6.text.maxWaitTime_n81i：
					</td>
					<td class="td_4">
					   <c:if test="${fn:length(paramMiss6.maxWaitTime)>0}">
							${paramMiss6.maxWaitTime}&nbsp;i18n_mcp6.text.second_n81i
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					
					<td align="right" nowrap="nowrap">
						i18n_mcp6.text.deleteFile_n81i：
					</td>
					<td colspan="3" class="td_4">
						<div style="word-break:break-all;word-wrap:break-word;"> 
				            ${paramMiss6.deleteTmpStr}&nbsp;
					     </div>
					</td>
				</tr>
				<tr>
				    <td align="right" nowrap="nowrap">
						i18n_mcp6.text.execParams_n81i：
					</td>
					<td colspan="3" class="td_4">
						 <div style="word-break:break-all;word-wrap:break-word;"> 
				            ${paramMiss6.execParamsTmpStr}&nbsp;
					     </div>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcp6.text.backup_n81i：
					</td>
					<td colspan="3" class="td_4">
                          <div id="upgradeBackupTemplate" style="display: inline"> <!-- 添加备份参数 -->
							    <c:forEach var="backupParam" items="${paramMiss6.backups}" >
									<div divType="file_div" id="file_div">
										<table class="templateTable" style="table-layout: fixed;">
											<tr>
												<td width="12%" align="right" nowrap="nowrap">
													i18n_mcp6.text.needBackupFile_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backup}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_mcp6.text.compression_n81i：
												</td>
												<td width="50%" class="td_4">
													<c:if test="${backupParam.isAbs=='Y'}">
														i18n_mcp6.text.absolutePath_n81i&nbsp;
													</c:if>
													<c:if test="${backupParam.isAbs=='N'}">
														i18n_mcp6.text.relativePath_n81i&nbsp;
													</c:if>
													&nbsp;
												</td>
											</tr>
											<tr>
												<td width="12%" align="right" valign="middle" nowrap="nowrap">
													i18n_mcp6.text.backupTo_n81i：
												</td>
												<td width="30%" class="td_4">
													${backupParam.backupTo}&nbsp;
												</td>
												<td width="8%" align="right" nowrap="nowrap">
													i18n_mcp6.text.exceptFile_n81i：
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
							</div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>

<script type="text/javascript">
    function getCommandType() {
		           var commandEName = "${missionparametertable6.commandEName}";//10:Agent升级，11:第三方升级部署，12：Server升级
		           if(commandEName=='upgrade_agent'){//10:Agent升级
		           		$("#OtherUpgradeTemplate").hide();//第三方升级部署+Server升级
				           $("#AgentUpgradeTemplate").show();//Agent升级
		           }else if(commandEName=='upgrade_other'){//11:第三方升级部署
		           		$("#OtherUpgradeTemplate").show();//第三方升级部署+Server升级
				           $("#AgentUpgradeTemplate").hide();//备份
		           }else if(commandEName=='upgrade_server'){//12：Server升级
		           		$("#OtherUpgradeTemplate").show();//第三方升级部署+Server升级
				           $("#AgentUpgradeTemplate").hide();//Agent升级
		           }
	}
    getCommandType();
</script>