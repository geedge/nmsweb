<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>


<div id="backupTemplate" style="display: inline"><!-- 备份 -->
	<c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable" style="table-layout: fixed;">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.backup_n81i：
					</td>
					<td width="25%" class="td_4">
						${paramMiss4.backup}&nbsp;
					</td>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.backupTo_n81i：
					</td>
					<td class="td_4">
					   <div style="word-break:break-all;word-wrap:break-word;"> 
					       ${paramMiss4.backupTo}&nbsp;
					   </div>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top" nowrap="nowrap">
						i18n_mcp4.text.compression_n81i：
					</td>
					<td valign="top" class="td_4">
						<c:if test="${paramMiss4.isAbs=='Y'}">
							i18n_mcp4.text.absolutePath_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.isAbs=='N'}">
							i18n_mcp4.text.relativePath_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.exceptFile_n81i：
					</td>
					<td class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.exceptTmpStr}&nbsp;
					  </div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>
<div id="startTemplate" style="display: none"><!-- 启动和可执行命令 -->
	<c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.startFileOrExecCmd_n81i：
					</td>
					<td width="25%" class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.execCmd}&nbsp;
					  </div>
					</td>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.forceExec_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.forceExec=='Y'}">
							i18n_mcp4.message.Y_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.forceExec=='N'}">
							i18n_mcp4.message.N_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.username_n81i：
					</td>
					<td class="td_4">
						${paramMiss4.username}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.residentFlag_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.residentFlag=='Y'}">
							i18n_mcp4.message.Y_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.residentFlag=='N'}">
							i18n_mcp4.message.N_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.execResult_n81i：
					</td>
					<td class="td_4">
					   <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.execResult}&nbsp;
					   </div>
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.returnFlag_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.returnFlag=='Y'}">
							i18n_mcp4.message.Y_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.returnFlag=='N'}">
							i18n_mcp4.message.N_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.maxWaitTime_n81i：
					</td>
					<td id="maxWaitTime[0]"  class="td_4">
					   <c:if test="${fn:length(paramMiss4.maxWaitTime)>0}">
						${paramMiss4.maxWaitTime}&nbsp;i18n_mcp4.text.second_n81i
					   </c:if>
						&nbsp;
					</td>
					<c:if test="${paramMiss4.returnFlag=='Y'}">
							<td align="right" nowrap="nowrap">
								i18n_mcp4.text.returnPath_n81i：
							</td>
							<td class="td_4">
								${paramMiss4.returnPath}&nbsp;
							</td>
					</c:if>
					<c:if test="${paramMiss4.returnFlag=='N'}">
							<td align="right" nowrap="nowrap">
								i18n_mcp4.text.execParams_n81i：
							</td>
							<td  colspan="1" class="td_4">
							  <div style="word-break:break-all;word-wrap:break-word;"> 
								${paramMiss4.execParamsTmpStr}&nbsp;
							  </div>
							</td>
					</c:if>
					
				</tr>
				<c:if test="${paramMiss4.returnFlag=='Y'}">
						<tr>
							<td align="right" nowrap="nowrap">
								i18n_mcp4.text.execParams_n81i：
							</td>
							<td  colspan="1" class="td_4">
								<div style="word-break:break-all;word-wrap:break-word;"> 
									${paramMiss4.execParamsTmpStr}&nbsp;
								</div>
							</td>
						</tr>
				</c:if>
			</table>
		</div>
	</c:forEach>
</div>
<div id="SingleExecTemplate" style="display: none"><!-- 可执行命令 单次执行 -->
	<c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.execCmd_n81i：
					</td>
					<td width="25%" class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.execCmd}&nbsp;
					  </div>
					</td>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.returnFlag_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.returnFlag=='Y'}">
							i18n_mcp4.message.Y_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.returnFlag=='N'}">
							i18n_mcp4.message.N_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.username_n81i：
					</td>
					<td class="td_4">
						${paramMiss4.username}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.maxWaitTime_n81i：
					</td>
					<td class="td_4">
						<c:if test="${fn:length(paramMiss4.maxWaitTime)>0}">
						${paramMiss4.maxWaitTime}&nbsp;i18n_mcp4.text.second_n81i
					   </c:if>
						&nbsp;
					</td>
				</tr>
				<c:if test="${paramMiss4.returnFlag=='Y'}">
					<tr>
						<td align="right" nowrap="nowrap">
							i18n_mcp4.text.returnPath_n81i：
						</td>
						<td class="td_4"  colspan="3">
							${paramMiss4.returnPath}&nbsp;
						</td>
					</tr>	
				</c:if>
							
			</table>
		</div>
	</c:forEach>
</div>
<div id="updateTemplate" style="display: none"><!-- 覆盖更新 -->
    <c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.source_n81i：
					</td>
					<td width="25%" class="td_4">
						${paramMiss4.source}&nbsp;
					</td>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.decompression_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.isAbs=='Y'}">
							i18n_mcp4.text.absolutePath_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.isAbs=='N'}">
							i18n_mcp4.text.relativePath_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.cover_n81i：
					</td>
					<td class="td_4">
						${paramMiss4.cover}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.isCreateCover_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.isCreateCover=='Y'}">
							i18n_mcp4.message.isCreateCoverY_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.isCreateCover=='N'}">
							i18n_mcp4.message.isCreateCoverN_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.deleteFile_n81i：
					</td>
					<td  class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.deleteTmpStr}&nbsp;
					  </div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>
<div id="recoverTemplate" style="display: none"><!-- 恢复 -->
    <c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
			<table class="templateTable">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.source_n81i：
					</td>
					<td width="25%" class="td_4">
						${paramMiss4.source}&nbsp;
					</td>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.decompression_n81i：
					</td>
					<td class="td_4">
						<c:if test="${paramMiss4.isAbs=='Y'}">
							i18n_mcp4.text.absolutePath_n81i&nbsp;
						</c:if>
						<c:if test="${paramMiss4.isAbs=='N'}">
							i18n_mcp4.text.relativePath_n81i&nbsp;
						</c:if>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.cover_n81i：
					</td>
					<td class="td_4">
						${paramMiss4.cover}&nbsp;
					</td>
					<td align="right" nowrap="nowrap">
						i18n_mcp4.text.deleteFile_n81i：
					</td>
					<td class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.deleteTmpStr}&nbsp;
					  </div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>
<div id="killProcessTemplate" style="display: none"><!-- 停用进程 -->
    <c:forEach var="paramMiss4" items="${paramM4}" >
		<div divType="file_div" id="file_div">
            <table class="templateTable">
				<tr>
					<td width="13%" align="right" nowrap="nowrap">
						i18n_mcp4.text.pidFile_n81i：
					</td>
					<td class="td_4">
					  <div style="word-break:break-all;word-wrap:break-word;"> 
						${paramMiss4.pidFile}&nbsp;
					  </div>
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</div>

<script type="text/javascript">
    function getCommandType() {
		       var commandType = ${missionparameteriable4.commandType};		       
		           var commandEName = "${missionparameteriable4.commandEName}";//2:停用进程，3：备份，4：覆盖更新，5：启动，6：恢复
		           // alert("pass!"+commandEName);
		       if(commandType=="1") {//Agent原生支持命令		          
		           if(commandEName=='upgrade_kill_process'){//2:停用进程
		           //alert("pass1");
		           		$("#startTemplate").hide();//启动和可执行命令					           
		       	   		$("#SingleExecTemplate").hide();//单次执行命令 
				        $("#backupTemplate").hide();//备份
				        $("#updateTemplate").hide();//覆盖更新
				        $("#recoverTemplate").hide();//恢复
				        $("#killProcessTemplate").show();//停用进程
		           }else if(commandEName=='upgrade_backup'){//3：备份
		          // alert("pass2");
		           		$("#startTemplate").hide();//启动和可执行命令					           
		       	   		$("#SingleExecTemplate").hide();//单次执行命令 
				           $("#backupTemplate").show();//备份
				           $("#updateTemplate").hide();//覆盖更新
				           $("#recoverTemplate").hide();//恢复
				           $("#killProcessTemplate").hide();//停用进程
		           }else if(commandEName=='upgrade_update'){//4：覆盖更新		           
		          // alert("pass3");
		           $("#startTemplate").hide();//启动和可执行命令					           
		       	   $("#SingleExecTemplate").hide();//单次执行命令 
				           $("#backupTemplate").hide();//备份
				           $("#updateTemplate").show();//覆盖更新
				           $("#recoverTemplate").hide();//恢复
				           $("#killProcessTemplate").hide();//停用进程
		           }else if(commandEName=='upgrade_start' || commandEName=='upgrade_exec'){//5：启动
		           //alert("pass4");
		           $("#startTemplate").show();//启动和可执行命令					           
		       	   $("#SingleExecTemplate").hide();//单次执行命令 
				           $("#backupTemplate").hide();//备份
				           $("#updateTemplate").hide();//覆盖更新
				           $("#recoverTemplate").hide();//恢复
				           $("#killProcessTemplate").hide();//停用进程
		           }else if(commandEName=='upgrade_recover'){//6：恢复		           
		           //alert("pass5");
		           $("#startTemplate").hide();//启动和可执行命令					           
		       	   $("#SingleExecTemplate").hide();//单次执行命令 
				           $("#backupTemplate").hide();//备份
				           $("#updateTemplate").hide();//覆盖更新
				           $("#recoverTemplate").show();//恢复
				           $("#killProcessTemplate").hide();//停用进程
		           }
		       }
		       if(commandType=="2") {//脚本:可执行命令
		       		if(commandEName=='single_exec'){
		       		 	$("#SingleExecTemplate").show();//单次执行命令 
		       		 	$("#startTemplate").hide();//启动和可执行命令
			           $("#backupTemplate").hide();//备份
			           $("#updateTemplate").hide();//覆盖更新
			           $("#recoverTemplate").hide();//恢复
			           $("#killProcessTemplate").hide();//停用进程
		       		}else{
			           $("#startTemplate").show();//启动和可执行命令
			           $("#SingleExecTemplate").hide();//单次执行命令
			           $("#backupTemplate").hide();//备份
			           $("#updateTemplate").hide();//覆盖更新
			           $("#recoverTemplate").hide();//恢复
			           $("#killProcessTemplate").hide();//停用进程
		           }
		       }
	}
    getCommandType();
</script>