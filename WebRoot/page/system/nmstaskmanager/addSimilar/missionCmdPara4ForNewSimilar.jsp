<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<c:if test="${missionparameteriable4.commandEName=='upgrade_backup'}"><!-- 备份 -->
   <c:forEach var="paramMiss4" items="${paramM4}" varStatus="index">
	<!-- 任务四：命令执行模板定义 -->
		<div divType="file_div" id="file_div">
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			<table class="templateTable1">
			<script type="text/javascript">
				$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
					}
				});
			</script>
				<tr>
					<td width="13%" align="right">
						i18n_mcpfns4.text.backupFile_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM4[${index.count-1}].backup" id="backup"
							value="${paramMiss4.backup}" />
						<font color="red"> * </font>
					</td>
					<td width="13%" align="right">
						i18n_mcpfns4.text.backupTo_n81i：
					</td>
					<td>
						<input type="text" name="paramM4[${index.count-1}].backupTo" id="backupTo"
							value="${paramMiss4.backupTo}" />
						<font color="red"> * i18n_mcpfns4.message.backupTo_n81i</font>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top">
						i18n_mcpfns4.text.compression_n81i：
					</td>
					<td valign="top">
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="Y" 
						        <c:if test="${paramMiss4.isAbs=='Y'}"> checked="checked"</c:if>      />
						i18n_mcpfns4.text.absolutePath_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="N" 
                                <c:if test="${paramMiss4.isAbs=='N'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.text.relativePath_n81i
					</td>
					<td align="right">
						i18n_mcpfns4.text.exceptFile_n81i：
					</td>
					<td>
						<textarea name="paramM4[${index.count-1}].exceptTmpStr" id="exceptTmpStr" rows="3" cols="40">${paramMiss4.exceptTmpStr}</textarea>
						<font color="red">i18n_mcpfns4.message.exceptFile_n81i</font>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfns4.text.delete_n81i</span>
		</div>
   </c:forEach>
</c:if>

<c:if test="${missionparameteriable4.commandEName=='upgrade_start'||missionparameteriable4.commandEName=='upgrade_exec'}"><!-- 启动和可执行命令 -->
     <c:forEach var="paramMiss4" items="${paramM4}"  varStatus="index">
		<div divType="file_div" id="file_div">
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			<table class="templateTable1">
			<script type="text/javascript">
			$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
					}
				});
				</script>
				<tr>
					<td width="13%" align="right">
						i18n_mcpfns4.text.startFileOrexecCmd_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM4[${index.count-1}].execCmd" id="execCmd" value="${paramMiss4.execCmd}" /><font color="red"> * </font>
					</td>
					<td width="13%" align="right">
						i18n_mcpfns4.text.forceExec_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].forceExec" id="forceExec" value="Y" 
						          <c:if test="${paramMiss4.forceExec=='Y'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.Y_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].forceExec" id="forceExec" value="N"
							      <c:if test="${paramMiss4.forceExec=='N'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.N_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.execResult_n81i：
					</td>
					<td>
						<input type="text" name="paramM4[${index.count-1}].execResult" id="execResult" value="${paramMiss4.execResult}" /><font color="red"> * </font>
					</td>
					<td align="right">
						i18n_mcpfns4.text.residentFlag_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].residentFlag" id="residentFlag" value="Y" 
						         <c:if test="${paramMiss4.residentFlag=='Y'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.Y_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].residentFlag" id="residentFlag" value="N"
							     <c:if test="${paramMiss4.residentFlag=='N'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.N_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
							i18n_mcpfns4.text.maxWaitTime_n81i：
						</td>
						<td nowrap="nowrap">
							<input type="text" name="paramM4[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss4.maxWaitTime}" />秒（为空则默认等待3秒）
						</td>
					<td align="right">
						i18n_mcpfns4.text.returnFlag_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].returnFlag" id="returnFlag" value="Y" 
						         <c:if test="${paramMiss4.returnFlag=='Y'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.message.Y_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].returnFlag" id="returnFlag" value="N"
							     <c:if test="${paramMiss4.returnFlag=='N'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.N_n81i
					</td>
				</tr>
				<tr>
					<c:if test="${paramMiss4.returnFlag=='Y'}">
						<td align="right">
							i18n_mcpfns4.text.username_n81i：
						</td>
						<td id="maxWaitTime[${index.count-1}]">
							<input type="text" name="paramM4[${index.count-1}].username" id="username" value="${paramMiss4.username}" />
						</td>
						<td align="right" id="returnfile[${index.count-1}]" >
							i18n_mcpfns4.text.returnPath_n81i：
						</td>
						<td id="returnfile[${index.count-1}]" >
							<input type="text" name="paramM4[${index.count-1}].returnPath" id="returnPath"
								value="${paramMiss4.returnPath}" />
						</td>
					</c:if>
					<c:if test="${paramMiss4.returnFlag=='N'}">
						<td align="right">
							i18n_mcpfns4.text.username_n81i：
						</td>
						<td id="maxWaitTime[${index.count-1}]" colspan="3">
							<input type="text" name="paramM4[${index.count-1}].username" id="username" value="${paramMiss4.username}" />
						</td>
						<td align="right" id="returnfile[${index.count-1}]" style="display:none;">
							i18n_mcpfns4.text.returnPath_n81i：
						</td>
						<td id="returnfile[${index.count-1}]" style="display:none;">
							<input type="text" name="paramM4[${index.count-1}].returnPath" id="returnPath"
								value="${paramMiss4.returnPath}" />
						</td>
					</c:if>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.execParams_n81i：
					</td>
					<td colspan="3">
						<textarea name="paramM4[${index.count-1}].execParamsTmpStr" id="execParamsTmpStr" rows="3" cols="50">${paramMiss4.execParamsTmpStr}</textarea>
						<font color="red">i18n_mcpfns4.message.execParams_n81i</font>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfns4.text.delete_n81i</span>
		</div>
  </c:forEach>
</c:if>

<c:if test="${missionparameteriable4.commandEName=='single_exec'}"><!-- 单次执行命令 -->
     <c:forEach var="paramMiss4" items="${paramM4}"  varStatus="index">
		<div divType="file_div" id="file_div">
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			<table class="templateTable1">
			<script type="text/javascript">
			$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
					}
				});
				</script>
				<tr>
					<td width="13%" align="right">
						i18n_mcpfns4.text.execCmd_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM4[${index.count-1}].execCmd" id="execCmd" value="${paramMiss4.execCmd}" /><font color="red"> * </font>
					</td>
					<td width="13%" align="right">
						i18n_mcpfns4.text.returnFlag_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].returnFlag" id="returnFlag" value="Y" 
						         <c:if test="${paramMiss4.returnFlag=='Y'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.message.Y_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].returnFlag" id="returnFlag" value="N"
							     <c:if test="${paramMiss4.returnFlag=='N'}"> checked="checked"</c:if>       />
						i18n_mcpfns4.message.N_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.username_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM4[${index.count-1}].username"
							id="username" value="${paramMiss4.username}" />
					</td>
				</tr>
				<tr>
					<c:if test="${paramMiss4.returnFlag=='Y'}">
						<td align="right">
							i18n_mcpfns4.text.maxWaitTime_n81i：
						</td>
						<td  id="maxWaitTime[${index.count-1}]" nowrap="nowrap">
							<input type="text" name="paramM4[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss4.maxWaitTime}" />秒（为空则默认等待3秒）
						</td>
						<td align="right" id="returnfile[${index.count-1}]" >
							i18n_mcpfns4.text.returnPath_n81i：
						</td>
						<td id="returnfile[${index.count-1}]" >
							<input type="text" name="paramM4[${index.count-1}].returnPath" id="returnPath"
								value="${paramMiss4.returnPath}" />
						</td>
					</c:if>
					<c:if test="${paramMiss4.returnFlag=='N'}">
					    <td align="right">
							i18n_mcpfns4.text.maxWaitTime_n81i：
						</td>
						<td  id="maxWaitTime[${index.count-1}]" colspan="3" nowrap="nowrap">
							<input type="text" name="paramM4[${index.count-1}].maxWaitTime" id="maxWaitTime" value="${paramMiss4.maxWaitTime}" />秒（为空则默认等待3秒）
						</td>
						<td align="right" id="returnfile[${index.count-1}]" style="display:none;">
							i18n_mcpfns4.text.returnPath_n81i：
						</td>
						<td id="returnfile[${index.count-1}]" style="display:none;">
							<input type="text" name="paramM4[${index.count-1}].returnPath" id="returnPath"
								value="${paramMiss4.returnPath}" />
						</td>
					</c:if>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfns4.text.delete_n81i</span>
		</div>
  </c:forEach>
</c:if>

<c:if test="${missionparameteriable4.commandEName=='upgrade_update'}"><!-- 覆盖更新 -->
     <c:forEach var="paramMiss4" items="${paramM4}"  varStatus="index">
		<div divType="file_div" id="file_div">
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			<table class="templateTable1">
			<script type="text/javascript">
				$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
					}
				});
				</script>
				<tr>
					<td width="13%" align="right">
						i18n_mcpfns4.text.source_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM4[${index.count-1}].source" id="source" value="${paramMiss4.source}" />
						<font color="red"> * </font>
					</td>
					<td width="13%" align="right">
						i18n_mcpfns4.text.decompression_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="Y" 
						             <c:if test="${paramMiss4.isAbs=='Y'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.text.absolutePath_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="N" 
                                     <c:if test="${paramMiss4.isAbs=='N'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.text.relativePath_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.coverPath_n81i：
					</td>
					<td>
						<input type="text" name="paramM4[${index.count-1}].cover" id="cover" value="${paramMiss4.cover}" />
						<font color="red"> * </font>
					</td>
					<td align="right">
						i18n_mcpfns4.text.isCreateCover_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].isCreateCover"	id="isCreateCover" value="Y"
						         <c:if test="${paramMiss4.isCreateCover=='Y'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.message.isCreateCoverY_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].isCreateCover"	id="isCreateCover" value="N" 
                                 <c:if test="${paramMiss4.isCreateCover=='N'}"> checked="checked"</c:if>        />
						i18n_mcpfns4.message.isCreateCoverN_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.deleteFile_n81i：
					</td>
					<td colspan="3">
						<textarea name="paramM4[${index.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="70">${paramMiss4.deleteTmpStr}</textarea>
						<font color="red">i18n_mcpfns4.message.deleteFile_n81i</font>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_mcpfns4.text.delete_n81i</span>
		</div>
  </c:forEach>
</c:if>

<c:if test="${missionparameteriable4.commandEName=='upgrade_recover'}"><!-- 恢复 -->
     <c:forEach var="paramMiss4" items="${paramM4}"  varStatus="index">
		<div divType="file_div" id="file_div">
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			<table class="templateTable1">
			<script type="text/javascript">
			$(function(){
					if(navigator.userAgent.indexOf("MSIE")>0) {  
						$(".templateTable1").css({"display":"inline"});
					}else{
						$(".templateTable1").css({"display":"inline-block"});
					}
				});
				</script>
				<tr>
					<td width="13%" align="right">
						i18n_mcpfns4.text.source_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM4[${index.count-1}].source" id="source" value="${paramMiss4.source}" />
						<font color="red"> * </font>
					</td>
					<td width="13%" align="right">
						i18n_mcpfns4.text.decompression_n81i：
					</td>
					<td>
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="Y" 
						           <c:if test="${paramMiss4.isAbs=='Y'}"> checked="checked"</c:if>      />
						i18n_mcpfns4.text.absolutePath_n81i&nbsp;
						<input type="radio" name="paramM4[${index.count-1}].isAbs" id="isAbs" value="N"
							       <c:if test="${paramMiss4.isAbs=='N'}"> checked="checked"</c:if>      />
						i18n_mcpfns4.text.relativePath_n81i
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns4.text.coverPath_n81i：
					</td>
					<td>
						<input type="text" name="paramM4[${index.count-1}].cover" id="cover" value="${paramMiss4.cover}" />
						<font color="red"> * </font>
					</td>
					<td align="right">
						i18n_mcpfns4.text.deleteFile_n81i：
					</td>
					<td><textarea name="paramM4[${index.count-1}].deleteTmpStr" id="deleteTmpStr" rows="3" cols="30">${paramMiss4.deleteTmpStr}</textarea>
						<font color="red">i18n_mcpfns4.message.deleteFile_n81i</font>
					</td>
				</tr>
			</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;" 
				id="del_file_span">&nbsp;i18n_mcpfns4.text.delete_n81i</span>
		</div>
   </c:forEach>
</c:if>

<c:if test="${missionparameteriable4.commandEName=='upgrade_kill_process'}"><!-- 停用进程 -->
     <c:forEach var="paramMiss4" items="${paramM4}"  varStatus="index">
		<div divType="file_div" id="file_div">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="hidden" name="[${index.count-1}]" id="index"  />
			i18n_mcpfncs.text.pidFile_n81i：&nbsp;<input type="text" name="paramM4[${index.count-1}].pidFile" id="pidFile" value="${paramMiss4.pidFile}"/>
						<font color="red">*</font>
					<span style="color: #000fff; cursor: hand; display: none; margin:0 0px 10px 0;" id="del_file_span">&nbsp;删除</span>
		</div>
     </c:forEach>
</c:if>
