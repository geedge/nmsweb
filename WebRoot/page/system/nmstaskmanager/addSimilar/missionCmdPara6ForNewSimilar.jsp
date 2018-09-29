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
			<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
			<input type="button" value="i18n_mcpfns6.text.path_n81i" title="i18n_mcpfns6.text.path_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
			<input type="file" name="fileInfo" id="infoFile" value="" onchange="javascript:setValue(this.value)"/>
			<font color="red">*</font>(i18n_mcpfns6.message.path_n81i)
			<input type="hidden" name="[${index.count-1}]" id="index"  />
			<span style="color: #000fff; cursor: hand; display: none;"
				id="del_file_span">&nbsp;i18n_mcpfns6.text.delete_n81i</span>
			<table class="templateTable1">
				<tr>
					<td width="10%" align="right">
						i18n_mcpfns6.text.coverPath_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
					<td width="10%" align="right">
						i18n_mcpfns6.text.isCreateCover_n81i：
					</td>
					<td>
						<input type="radio" name="paramM6[${index.count-1}].isCreateCover" id="isCreateCover" value="Y" 
						             <c:if test="${paramMiss6.isCreateCover=='Y'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.message.isCreateCoverY_n81i&nbsp;
						<input type="radio" name="paramM6[${index.count-1}].isCreateCover" id="isCreateCover" value="N" 
						             <c:if test="${paramMiss6.isCreateCover=='N'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.message.isCreateCoverN_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.username_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].username" id="username" value="${paramMiss6.username}" />
					</td>
					<td align="right">
						i18n_mcpfns6.text.decompression_n81i：
					</td>
					<td>
						<input type="radio" name="paramM6[${index.count-1}].isAbs" id="isAbs" value="Y" 
						            <c:if test="${paramMiss6.isAbs=='Y'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.text.absolutePath_n81i&nbsp;
						<input type="radio" name="paramM6[${index.count-1}].isAbs" id="isAbs" value="N" 
						            <c:if test="${paramMiss6.isAbs=='N'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.text.relativePath_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.groupName_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].groupName" id="groupName"
							value="${paramMiss6.groupName}" />
					</td>
					<td align="right" rowspan="1">
						i18n_mcpfns6.text.deleteFile_n81i：
					</td>
					<td rowspan="1">
						<textarea name="paramM6[${index.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30">${paramMiss6.deleteTmpStr}</textarea>
						<font color="red">i18n_mcpfns6.message.deleteFile_n81i</font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.permisson_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM6[${index.count-1}].permisson" id="permisson"
							value="${paramMiss6.permisson}" />
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]">
					
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;<c:if test='${fn:length(paramMiss6.backups)>0}'>display:none;</c:if>">添加备份参数</span>
						<c:forEach var="backupParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 备份参数 -->
							        <input type="hidden" name="backups[${index2.count-1}]" id="backUpIndex"  />
										<table class="templateTable" style="width:95%">
											<tr>
												<td width="13%" align="right">
													i18n_mcpfns6.text.backupFiles_n81i：
												</td>
												<td width="40%">
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backup" id="backup"
														value="${backupParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfns6.text.compression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${backupParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfns6.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${backupParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfns6.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="top">
													i18n_mcpfns6.text.backupTo_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backupTo" id="backupTo"
														value="${backupParam.backupTo}" />
													<font color="red"> * i18n_mcpfns6.message.backupTo_n81i</font>
												</td>
												<td align="right">
													i18n_mcpfns6.text.exceptFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].backups[${index2.count-1}].exceptTmpStr" id="exceptTmpStr" rows="3" cols="30">${backupParam.exceptTmpStr}</textarea>
													<font color="red">i18n_mcpfns6.message.exceptFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
											id="del_backup_span">&nbsp;i18n_mcpfns6.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
			</table>
		</div>
   </c:forEach>
</c:if>
<c:if test="${missionparametertable6.commandEName=='upgrade_other' || missionparametertable6.commandEName=='upgrade_server'}"><!-- 第三方升级部署和Server升级 -->
   <c:forEach var="paramMiss6" items="${paramM6}" varStatus="index">
		<div divType="file_div" id="file_div">
			<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
			<input type="button" value="i18n_mcpfns6.text.path_n81i" title="i18n_mcpfns6.text.path_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
			<input type="file" name="fileInfo" id="infoFile" value="" onchange="javascript:setValue(this.value)"/>
			<font color="red">*</font>(i18n_mcpfns6.message.path_n81i)
			<input type="hidden" name="[${index.count-1}]" id="index"  />
			<span style="color: #000fff; cursor: hand; display: none;"
				id="del_file_span">&nbsp;i18n_mcpfns6.text.delete_n81i</span>
			<table class="templateTable1">
				<tr>
					<td width="10%" align="right">
						i18n_mcpfns6.text.coverPath_n81i：
					</td>
					<td width="35%">
						<input type="text" name="paramM6[${index.count-1}].cover" id="cover" value="${paramMiss6.cover}" />
						<font color="red"> * </font>
					</td>
					<td width="10%" align="right">
						i18n_mcpfns6.text.isCreateCover_n81i：
					</td>
					<td>
						<input type="radio" name="paramM6[${index.count-1}].isCreateCover"	id="isCreateCover" value="Y" 
						          <c:if test="${paramMiss6.isCreateCover=='Y'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.message.isCreateCoverY_n81i&nbsp;
						<input type="radio" name="paramM6[${index.count-1}].isCreateCover"	id="isCreateCover" value="N" 
                                  <c:if test="${paramMiss6.isCreateCover=='N'}"> checked="checked"</c:if>   />
						i18n_mcpfns6.message.isCreateCoverN_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.startupFile_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].startupFile" id="startupFile" value="${paramMiss6.startupFile}" />
						<font color="red"> * </font>
					</td>
					<td align="right">
						i18n_mcpfns6.text.decompression_n81i：
					</td>
					<td>
						<input type="radio" name="paramM6[${index.count-1}].isAbs" id="isAbs" value="Y" 
						     <c:if test="${paramMiss6.isAbs=='Y'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.text.absolutePath_n81i&nbsp;
						<input type="radio" name="paramM6[${index.count-1}].isAbs" id="isAbs" value="N"
							<c:if test="${paramMiss6.isAbs=='N'}"> checked="checked"</c:if> />
						i18n_mcpfns6.text.relativePath_n81i
					</td>
				</tr>
				<tr>	
					<td align="right">
						i18n_mcpfns6.text.pidFile_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].pidFile" id="pidFile" value="${paramMiss6.pidFile}" />
						<font color="red"> * </font>
					</td>
					<td align="right">
						i18n_mcpfns6.text.forceExec_n81i：
					</td>
					<td>
						<input type="radio" name="paramM6[${index.count-1}].forceExec" id="forceExec" value="Y" 
						            <c:if test="${paramMiss6.forceExec=='Y'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.message.Y_n81i&nbsp;
						<input type="radio" name="paramM6[${index.count-1}].forceExec" id="forceExec" value="N"
							        <c:if test="${paramMiss6.forceExec=='N'}"> checked="checked"</c:if>  />
						i18n_mcpfns6.message.N_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.username_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].username" id="username" value="${paramMiss6.username}" />
					</td>
					<td align="right" rowspan="2">
						i18n_mcpfns6.text.execParams_n81i：
					</td>
					<td rowspan="2">
						<textarea name="paramM6[${index.count-1}].execParamsTmpStr" id="execParamsTmpStr" rows="3" cols="25">${paramMiss6.execParamsTmpStr}</textarea>
						<font color="red">i18n_mcpfns6.message.execParams_n81i</font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.groupName_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].groupName" id="groupName"
							value="${paramMiss6.groupName}" />
					</td>
				</tr>
				<tr>
					 <td align="right">
						i18n_mcpfns6.text.permisson_n81i：
					</td>
					<td>
						<input type="text" name="paramM6[${index.count-1}].permisson" id="permisson"
							value="${paramMiss6.permisson}" />
					</td>
					<td align="right" rowspan="1">
						i18n_mcpfns6.text.deleteFile_n81i：
					</td>
					<td rowspan="1" colspan="3">
						<textarea name="paramM6[${index.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="25">${paramMiss6.deleteTmpStr}</textarea>
						<font color="red">i18n_mcpfns6.message.deleteFile_n81i</font>
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.maxWaitTime_n81i：
					</td>
					<td colspan="3" nowrap="nowrap">
						<input type="text" name="paramM6[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss6.maxWaitTime}" />i18n_mcpfncs.message.maxWaitTime_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns6.text.backup_n81i：
					</td>
					<td colspan="3" id="backup_Td[${index.count-1}]">
						<span class="STYLE1" id="add_backup_span"  style="color: #000fff; cursor: hand;">i18n_mcpfns6.text.addBackupSets_n81i</span>
					    <c:forEach var="backupParam" items="${paramMiss6.backups}"  varStatus="index2">
							        <div divType="file_div" id="file_div"><!-- 备份参数 -->
							        <input type="hidden" name="backups[${index2.count-1}]" id="backUpIndex"  />
										<table class="templateTable" style="width:95%">
											<script type="text/javascript">
												$(function(){
													if(navigator.userAgent.indexOf("MSIE")>0) {  
														$(".templateTable").css({"display":"inline"});
													}else{
														$(".templateTable").css({"display":"inline-table"});
													}
												});
											</script>
											<tr>
												<td width="13%" align="right">
													i18n_mcpfns6.text.backupFile_n81i：
												</td>
												<td width="40%">
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backup" id="backup"
														value="${backupParam.backup}" />
													<font color="red"> * </font>
												</td>
												<td width="10%" align="right">
													i18n_mcpfns6.text.compression_n81i：
												</td>
												<td>
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="Y" 
													          <c:if test="${backupParam.isAbs=='Y'}"> checked="checked"</c:if>  />
													i18n_mcpfns6.text.absolutePath_n81i&nbsp;
													<input type="radio" name="paramM6[${index.count-1}].backups[${index2.count-1}].isAbs" id="isAbs" value="N" 
                                                               <c:if test="${backupParam.isAbs=='N'}"> checked="checked"</c:if>  />
													i18n_mcpfns6.text.relativePath_n81i
												</td>
											</tr>
											<tr>
												<td align="right" valign="top">
													i18n_mcpfns6.text.backupTo_n81i：
												</td>
												<td>
													<input type="text" name="paramM6[${index.count-1}].backups[${index2.count-1}].backupTo" id="backupTo"
														value="${backupParam.backupTo}" />
													<font color="red"> * i18n_mcpfns6.message.backupTo_n81i</font>
												</td>
												<td align="right">
													i18n_mcpfns6.text.exceptFile_n81i：
												</td>
												<td>
													<textarea name="paramM6[${index.count-1}].backups[${index2.count-1}].exceptTmpStr" id="exceptTmpStr" rows="3" cols="30">${backupParam.exceptTmpStr}</textarea>
													<font color="red">i18n_mcpfns6.message.exceptFile_n81i</font>
												</td>
											</tr>
										</table>
										<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
											id="del_backup_span">&nbsp;i18n_mcpfns6.text.delete_n81i</span>
									</div>
						 </c:forEach>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</c:if>
