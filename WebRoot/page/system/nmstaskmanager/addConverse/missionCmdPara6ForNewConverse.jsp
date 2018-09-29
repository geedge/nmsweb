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
			    <tr>
					<td align="right" width="10%">
						i18n_mcpfnc.text.coverPath_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfnc.text.username_n81i：
					</td>
					<td width="33%" colspan="3">
						<input type="text" name="paramM6[${index.count-1}].username" id="username"
							value="${paramMiss6.username}" />
					</td>
					<!-- 
					<td align="right" width="10%">
						属主*密码：
					</td>
					<td>
						<input type="password" name="paramM6[${index.count-1}].param1"
							id="param1" value="" style="width: 200px" />
					</td>
					 -->
				</tr>
			    <tr>
					<td align="right" width="10%">
						i18n_mcpfnc.text.recovery_n81i：
					</td>
					<td colspan="3" id="recovery_Td[${index.count-1}]">
					    <span class="STYLE1" id="add_recovery_span"  style="color: #000fff; cursor: hand;<c:if test='${fn:length(paramMiss6.backups)>0}'>display:none;</c:if>">添加恢复参数</span>
					    <c:forEach var="recoveryParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 恢复参数 -->
							        <input type="hidden" name="recoverys[${index2.count-1}]" id="recoveryIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfnc.text.sourcePath_n81i：
												</td>
												<td width="27%">
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].source" id="source"
														value="${recoveryParam.backupTo}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfnc.text.decompression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${recoveryParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfnc.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${recoveryParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfnc.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="middle">
													i18n_mcpfnc.text.recoveryFile_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].cover" id="cover"
														value="${recoveryParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td align="right">
													i18n_mcpfnc.text.deleteFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].recoverys[${index2.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30"></textarea>
													<font color="red">i18n_mcpfnc.message.deleteFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; vertical-align: top; margin:0 0px 10px 0;"
				                                   id="del_recovery_span">&nbsp;i18n_mcpfnc.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfnc.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]">
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;">i18n_mcpfnc.text.backupSets_n81i</span>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfnc.text.delete_n81i</span>
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
						$(".templateTable").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-table"});
						$(".templateTable").css({"display":"inline-table"});
					}
				});
				</script>
				<tr>
					<td align="right" width="10%">
						i18n_mcpfnc.text.coverPath_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right" width="10%">
						i18n_mcpfnc.text.startupFile_n81i：
					</td>
					<td width="33%">
						<input type="text" name="paramM6[${index.count-1}].startupFile" id="startupFile" value="${paramMiss6.startupFile}" />
						<font color="red"> * </font>
					</td>
					<td align="right" width="10%">
						i18n_mcpfnc.text.pidFile_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].pidFile" id="pidFile" value="${paramMiss6.pidFile}" />
						<font color="red"> * </font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfnc.text.username_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].username" id="username"
							value="${paramMiss6.username}" />
					</td>
					<td align="right" rowspan="2" width="10%">
						i18n_mcpfnc.text.startupParam_n81i：
					</td>
					<td rowspan="2">
						<textarea name="paramM6[${index.count-1}].execParamsTmpStr" id="execParamsTmpStr" rows="4" cols="30">${paramMiss6.execParamsTmpStr}</textarea>
						<font color="red">i18n_mcpfnc.message.sepParam_n81i</font>
					</td>
				</tr>
				<!-- 
				<tr>	
					<td align="right">
						属主*密码：
					</td>
					<td>
						<input type="password" name="paramM6[${index.count-1}].param1"
							id="param1" value="" style="width: 200px" />
					</td>
				</tr>
				 -->
				<tr>	
					<td align="right">
						i18n_mcpfnc.text.maxWaitTime_n81i：
					</td>
					<td nowrap="nowrap">
						<input type="text" name="paramM6[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss6.maxWaitTime}" />秒（为空则默认等待3秒）
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfnc.text.recovery_n81i：
					</td>
					<td colspan="3" id="recovery_Td[${index.count-1}]">
					    <span class="STYLE1" id="add_recovery_span"  style="color: #000fff; cursor: hand;">i18n_mcpfnc.text.recoverySets_n81i</span>
					    <c:forEach var="recoveryParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 恢复参数 -->
							        <input type="hidden" name="recoverys[${index2.count-1}]" id="recoveryIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfnc.text.sourcePath_n81i：
												</td>
												<td width="27%">
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].source" id="source"
														value="${recoveryParam.backupTo}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfnc.text.decompression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${recoveryParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfnc.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${recoveryParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfnc.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="middle">
													i18n_mcpfnc.text.recoveryFile_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].recoverys[${index2.count-1}].cover" id="cover"
														value="${recoveryParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td align="right">
													i18n_mcpfnc.text.deleteFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].recoverys[${index2.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30"></textarea>
													<font color="red">i18n_mcpfnc.message.deleteFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; vertical-align: top; margin:0 0px 10px 0;"
				                                   id="del_recovery_span">&nbsp;i18n_mcpfnc.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
				<tr>
				    <td align="right" >
						i18n_mcpfnc.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]" >
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;">i18n_mcpfnc.text.backupSets_n81i</span>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfnc.text.delete_n81i</span>
		</div>
	</c:forEach>
</c:if>



