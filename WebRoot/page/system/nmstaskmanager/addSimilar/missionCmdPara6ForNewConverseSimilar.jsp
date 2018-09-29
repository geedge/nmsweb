<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<c:if test="${missionparametertable6.commandEName=='upgrade_agent'}"><!-- Agent升级 -->
   <c:forEach var="paramMiss6" items="${paramM6}" varStatus="index">
	<!-- 任务六：升级部署模板定义 -->
		<div divType="file_div" id="file_div">
			<table class="templateTable1">
			<script type="text/javascript">
			$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
						$(".templateTable").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
						$(".templateTable").css({"display":"inline-block"});
					}
				});
				</script>
			    <tr>
					<td align="right" width="10%">
						i18n_mcpfncs.text.coverPath_n81i：
					</td>
					<td >
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfncs.text.username_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM6[${index.count-1}].username" id="username"
							value="${paramMiss6.username}" />
					</td>
				</tr>
			    <tr>
					<td align="right" width="10%">
						i18n_mcpfncs.text.recovery_n81i：
					</td>
					<td colspan="3" id="recovery_Td[${index.count-1}]">
					    <span class="STYLE1" id="add_recovery_span"  style="color: #000fff; cursor: hand;<c:if test='${fn:length(paramMiss6.recoverys)>0}'>display:none;</c:if>">i18n_mcpfncs.text.recoverySets_n81i</span>
					    <c:forEach var="recoveryParam" items="${paramMiss6.recoverys}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 恢复参数 -->
							        <input type="hidden" name="recoverys[${index2.count-1}]" id="recoveryIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfncs.text.source_n81i：
												</td>
												<td width="27%">
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].source" id="source"
														value="${recoveryParam.source}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfncs.text.decompression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${recoveryParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${recoveryParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="middle">
													i18n_mcpfncs.text.recoveryPath_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].cover" id="cover"
														value="${recoveryParam.cover}" />
													<font color="red"> * </font>
												</td>
												<td align="right">
													i18n_mcpfncs.text.deleteFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].recoverys[${index2.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30">${recoveryParam.deleteTmpStr}</textarea>
													<font color="red">i18n_mcpfncs.message.deleteFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; vertical-align: top; margin:0 0px 10px 0;"
				                                   id="del_recovery_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfncs.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]">
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;<c:if test='${fn:length(paramMiss6.backups)>0}'>display:none;</c:if>">i18n_mcpfncs.text.addBackupSets_n81i</span>
						<c:forEach var="backupParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 备份参数 -->
							        <input type="hidden" name="backups[${index2.count-1}]" id="backUpIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfncs.text.backupFiles_n81i：
												</td>
												<td width="40%">
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backup" id="backup"
														value="${backupParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfncs.text.compression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${backupParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${backupParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="top">
													i18n_mcpfncs.text.backupTo_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backupTo" id="backupTo"
														value="${backupParam.backupTo}" />
													<font color="red"> * i18n_mcpfncs.message.backupTo_n81i</font>
												</td>
												<td align="right">
													i18n_mcpfncs.text.exceptFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].backups[${index2.count-1}].exceptTmpStr" id="exceptTmpStr" rows="3" cols="30">${backupParam.exceptTmpStr}</textarea>
													<font color="red">i18n_mcpfncs.message.exceptFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
											id="del_backup_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
		</div>
   </c:forEach>
</c:if>
<c:if test="${missionparametertable6.commandEName=='upgrade_other' || missionparametertable6.commandEName=='upgrade_server'}"><!-- 第三方升级部署和Server升级 -->
   <c:forEach var="paramMiss6" items="${paramM6}" varStatus="index">
		<div divType="file_div" id="file_div">
			<table class="templateTable1">
			<script type="text/javascript">
				$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-table"});
					}
				});
			</script>
				<tr>
					<td align="right" width="10%">
						i18n_mcpfncs.text.coverPath_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right" width="10%">
						i18n_mcpfncs.text.startupFile_n81i：
					</td>
					<td width="33%">
						<input type="text" name="paramM6[${index.count-1}].startupFile" id="startupFile" value="${paramMiss6.startupFile}" />
						<font color="red"> * </font>
					</td>
					<td align="right" width="10%">
						i18n_mcpfncs.text.pidFile_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].pidFile" id="pidFile" value="${paramMiss6.pidFile}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfncs.text.username_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].username" id="username"
							value="${paramMiss6.username}" />
					</td>
					<td align="right" rowspan="2" width="10%">
						i18n_mcpfncs.text.execParams_n81i：
					</td>
					<td rowspan="2">
						<textarea name="paramM6[${index.count-1}].execParamsTmpStr" id="execParamsTmpStr" rows="4" cols="30">${paramMiss6.execParamsTmpStr}</textarea>
						<font color="red">i18n_mcpfncs.message.execParams_n81i</font>
					</td>
				</tr>
				<tr>	
					<td align="right">
						i18n_mcpfncs.message.maxWaitTime_n81i：
					</td>
					<td nowrap="nowrap">
						<input type="text" name="paramM6[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss6.maxWaitTime}" />i18n_mcpfncs.message.maxWaitTime_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfncs.text.recovery_n81i：
					</td>
					<td colspan="3" id="recovery_Td[${index.count-1}]">
					    <span class="STYLE1" id="add_recovery_span"  style="color: #000fff; cursor: hand;">i18n_mcpfncs.text.recoverySets_n81i</span>
					    <c:forEach var="recoveryParam" items="${paramMiss6.recoverys}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 恢复参数 -->
							        <input type="hidden" name="recoverys[${index2.count-1}]" id="recoveryIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfncs.text.source_n81i：
												</td>
												<td width="27%">
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].source" id="source"
														value="${recoveryParam.source}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfncs.text.decompression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${recoveryParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${recoveryParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="middle">
													i18n_mcpfncs.text.recoveryPath_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].cover" id="cover"
														value="${recoveryParam.cover}" />
													<font color="red"> * </font>
												</td>
												<td align="right">
													i18n_mcpfncs.text.deleteFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].recoverys[${index2.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30">${recoveryParam.deleteTmpStr}</textarea>
													<font color="red">i18n_mcpfncs.message.deleteFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; vertical-align: top; margin:0 0px 10px 0;"
				                                   id="del_recovery_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
				<tr>
				    <td align="right" >
						i18n_mcpfncs.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]" >
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;">i18n_mcpfncs.text.addBackupSets_n81i</span>
						<c:forEach var="backupParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 备份参数 -->
							        <input type="hidden" name="backups[${index2.count-1}]" id="backUpIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfncs.text.backupFiles_n81i：
												</td>
												<td width="40%">
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backup" id="backup"
														value="${backupParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfncs.text.compression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${backupParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${backupParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfncs.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="top">
													i18n_mcpfncs.text.backupTo_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backupTo" id="backupTo"
														value="${backupParam.backupTo}" />
													<font color="red"> * i18n_mcpfncs.message.backupTo_n81i</font>
												</td>
												<td align="right">
													i18n_mcpfncs.text.exceptFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].backups[${index2.count-1}].exceptTmpStr" id="exceptTmpStr" rows="3" cols="30">${backupParam.exceptTmpStr}</textarea>
													<font color="red">i18n_mcpfncs.message.exceptFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
											id="del_backup_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfncs.text.delete_n81i</span>
		</div>
	</c:forEach>
</c:if>
