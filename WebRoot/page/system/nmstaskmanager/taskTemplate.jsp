<%@ page language="java" contentType="text/html; charset=utf-8"
	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
	type="text/css" />
	
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<!-- 任务一：文件推送模板定义 -->
<div id="paramM1Template" style="display: none">
	<div divType="file_div" id="file_div">
		<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
		<input type="button" value="i18n_tt.text.path_n81i" title="i18n_tt.text.path_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
		<input type="file" name="fileInfo" id="infoFile" value="" onchange="javascript:setValue(this.value)"/>
		<font color="red">*</font>(i18n_tt.message.path_n81i)
		<input type="hidden" name="[0]" id="index" />
		<span style="color: #000fff; cursor: hand; display: none;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	
		<table class="templateTable1">
			<tr>
				<td align="right" style="width: 10%">
					i18n_tt.text.destPath_n81i：
				</td>
				<td style="width: 25%">
					<input type="text" name="paramM1[0].destPath" id="destPath"
						value="" />
					<font color="red">* </font>
				</td>
				<td  align="right" style="width: 10%">
					i18n_tt.text.isCover_n81i：
				</td>
				<td >
					<input type="radio" name="paramM1[0].isCover" id="isCover"
						value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM1[0].isCover" id="isCover"
						value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right" >
					i18n_tt.text.username_n81i：
				</td>
				<td colspan="3">
					<input type="text" name="paramM1[0].username" id="username"
						value="" />
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.groupName_n81i：
				</td>
				<td>
					<input type="text" name="paramM1[0].groupName" id="groupName"
						value="" />
				</td>
				<td align="right" style="width: 100px">
					i18n_tt.text.permisson_n81i：
				</td>
				<td>
					<input type="text" name="paramM1[0].permisson" id="permisson"
						value="" />
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- 任务六：升级部署模板定义 -->
<div id="AgentUpgradeTemplate" style="display: none">
	<div divType="file_div" id="file_div" style="clear: left;">
		<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
		<input type="button" value="i18n_tt.text.path_n81i" title="i18n_tt.text.path_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
		<input type="file" name="fileInfo" id="infoFile" value="" onchange="javascript:setValue(this.value)"/>
		<font color="red">*</font>(i18n_tt.message.path_n81i)
		<input type="hidden" name="[0]" id="index" />
		<span style="color: #000fff; cursor: hand; display: none;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
		<table class="templateTable1">
			<tr>
				<td width="10%" align="right">
					i18n_tt.text.destPath_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM6[0].cover" id="cover" value="" />
					<font color="red"> * </font>
				</td>
				<td width="10%" align="right">
					i18n_tt.text.isCreateCover_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].isCreateCover"
						id="isCreateCover" value="Y" />
					i18n_tt.message.isCreateCoverY_n81i&nbsp;
					<input type="radio" name="paramM6[0].isCreateCover"
						id="isCreateCover" value="N" checked="checked" />
					i18n_tt.message.isCreateCoverN_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.username_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].username" id="username"
						value="" />
				</td>
				<td align="right">
					i18n_tt.text.decompression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].isAbs" id="isAbs" value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM6[0].isAbs" id="isAbs" value="N"
						checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.groupName_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].groupName" id="groupName"
						value="" />
				</td>
				<td align="right" rowspan="2">
					i18n_tt.text.deleteFile_n81i：
				</td>
				<td rowspan="2">
					<textarea name="paramM6[0].deleteTmpStr" id="deleteTmpStr" rows="3"
						cols="30"></textarea>
					<font color="red">i18n_tt.message.deleteFile_n81i</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.permisson_n81i：
				</td>
				<td colspan="3">
					<input type="text" name="paramM6[0].permisson" id="permisson"
						value="" />
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.backup_n81i：
				</td>
				<td colspan="3" id="backup_Td[0]">
					<span class="STYLE1" id="add_backup_span"
						style="color: #000fff; cursor: hand;">i18n_tt.message.addBackup_n81i</span>
				</td>
			</tr>
		</table>
	</div>
</div>
<div id="OtherUpgradeTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
		<input type="button" value="i18n_tt.text.path_n81i" title="i18n_dsil.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
		<input type="file" name="fileInfo" id="infoFile" value="" onchange="javascript:setValue(this.value)"/>
		<font color="red">*</font>(i18n_tt.message.path_n81i)
		<input type="hidden" name="[0]" id="index" />
		<span style="color: #000fff; cursor: hand; display: none;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
		<table class="templateTable1">
			<tr>
				<td width="10%" align="right">
					i18n_tt.text.coverPath_n81i：
				</td>
				<td width="35%">
					<input type="text" name="paramM6[0].cover" id="cover" value="" />
					<font color="red"> * </font>
				</td>
				<td width="10%" align="right">
					i18n_tt.text.isCreateCover_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].isCreateCover"
						id="isCreateCover" value="Y" />
					i18n_tt.message.isCreateCoverY_n81i&nbsp;
					<input type="radio" name="paramM6[0].isCreateCover"
						id="isCreateCover" value="N" checked="checked" />
					i18n_tt.message.isCreateCoverN_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.execCmd_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].startupFile" id="startupFile"
						value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_tt.text.decompression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].isAbs" id="isAbs" value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM6[0].isAbs" id="isAbs" value="N"
						checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.pidFile_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].pidFile" id="pidFile" value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_tt.text.forceExec_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].forceExec" id="forceExec"
						value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM6[0].forceExec" id="forceExec"
						value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.username_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].username" id="username"
						value="" />
				</td>
				<td align="right" rowspan="2">
					i18n_tt.text.execParams_n81i：
				</td>
				<td rowspan="2">
					<textarea name="paramM6[0].execParamsTmpStr" id="execParamsTmpStr"
						rows="3" cols="25"></textarea>
					<font color="red">i18n_tt.message.deleteFile_n81i</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.groupName_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].groupName" id="groupName"
						value="" />
				</td>
			</tr>
			<tr>
				<td align="right" rowspan="2">
					i18n_tt.text.deleteFile_n81i：
				</td>
				<td rowspan="2" >
					<textarea name="paramM6[0].deleteTmpStr" id="deleteTmpStr" rows="3"
						cols="25"></textarea>
					<font color="red">i18n_tt.message.deleteFile_n81i</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.permisson_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].permisson" id="permisson"
						value="" />
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.maxWaitTime_n81i：
				</td>
				<td nowrap="nowrap">
				<!-- <td colspan="3"> -->
					<input type="text" name="paramM6[0].maxWaitTime" id="maxWaitTime"
						value="3" /><font color="red"></font>
					i18n_tt.message.maxWaitTime_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.backup_n81i：
				</td>
				<td colspan="3" id="backup_Td[0]">
					<span class="STYLE1" id="add_backup_span"
						style="color: #000fff; cursor: hand;">i18n_tt.message.addBackup_n81i</span>
				</td>
			</tr>
		</table>
	</div>
</div>
<div id="upgradeBackupTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<input type="hidden" name="backups[0]" id="backUpIndex" />
		<table class="templateTable1" style="width: 95%;">
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
				<td width="13%" align="right">
					i18n_tt.text.backupFile_n81i：
				</td>
				<td width="40%">
					<input type="text" name="paramM6[0].backups[0].backup" id="backup"
						value="" />
					<font color="red"> * </font>
				</td>
				<td width="10%" align="right">
					i18n_tt.text.compression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].backups[0].isAbs" id="isAbs"
						value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM6[0].backups[0].isAbs" id="isAbs"
						value="N" checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right" valign="top">
					i18n_tt.text.backupTo_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].backups[0].backupTo"
						id="backupTo" value="" />
					<font color="red"> * i18n_tt.message.backupTo_n81i</font>
				</td>
				<td align="right">
					i18n_tt.text.exceptFile_n81i：
				</td>
				<td>
					<textarea name="paramM6[0].backups[0].exceptTmpStr"
						id="exceptTmpStr" rows="3" cols="30"></textarea>
					<font color="red">i18n_tt.message.exceptFile_n81i</font>
				</td>
			</tr>
		</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
											id="del_backup_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<!-- 任务四：命令执行模板定义 -->
<style type="text/css">
	.templateTable1 td{
		vertical-align: middle;
	}
</style>
<script type="text/javascript">
</script>	
<div id="backupTemplate" style="display: none">
	<div divType="file_div" id="file_div" >
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td width="13%" align="right">
					i18n_tt.text.backupFile_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM4[0].backup" id="backup" value="" />
					<font color="red"> * </font>
				</td>
				<td width="13%" align="right">
					i18n_tt.text.backupTo_n81i：
				</td>
				<td>
					<input type="text" name="paramM4[0].backupTo" id="backupTo"
						value="" />
					<font color="red"> * i18n_tt.message.backupTo_n81i</font>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top">
					i18n_tt.text.compression_n81i：
				</td>
				<td valign="top">
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="N"
						checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
				<td align="right">
					i18n_tt.text.exceptFile_n81i：
				</td>
				<td>
					<textarea name="paramM4[0].exceptTmpStr" id="exceptTmpStr" rows="3"
						cols="40"></textarea>
					<font color="red">i18n_tt.message.exceptFile_n81i</font>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top;margin:0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<div id="startTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td width="13%" align="right">
					i18n_tt.text.execCmd_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM4[0].execCmd" id="execCmd" value="" />
					<font color="red"> * </font>
				</td>
				<td width="13%" align="right">
					i18n_tt.text.forceExec_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].forceExec" id="forceExec"
						value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM4[0].forceExec" id="forceExec"
						value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.execResult_n81i：
				</td>
				<td>
					<input type="text" name="paramM4[0].execResult" id="execResult"
						value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_tt.text.residentFlag_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].residentFlag"
						id="residentFlag" value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM4[0].residentFlag"
						id="residentFlag" value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.maxWaitTime1_n81i：
				</td>
				<td nowrap="nowrap">
					<input type="text" name="paramM4[0].maxWaitTime" id="maxWaitTime"
						value="3" /><font color="red"></font>
					i18n_tt.message.maxWaitTime_n81i
				</td>
				<td align="right">
					i18n_tt.text.returnFlag_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].returnFlag" id="returnFlag"
						value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM4[0].returnFlag" id="returnFlag"
						value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.username_n81i：
				</td>
				<td id="maxWaitTime[0]" colspan="3">
					<input type="text" name="paramM4[0].username" id="username"
						value="" />
				</td>
				<td align="right" id="returnfile[0]" style="display: none;">
					i18n_tt.text.backFile_n81i：
				</td>
				<td id="returnfile[0]" style="display: none;">
					<input type="text" name="paramM4[0].returnPath" id="returnPath"
						value="" />
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top">
					i18n_tt.text.execParams_n81i：
				</td>
				<td colspan="3">
					<textarea name="paramM4[0].execParamsTmpStr" id="execParamsTmpStr"
						rows="3" cols="50"></textarea>
					<font color="red">i18n_tt.message.execParams_n81i</font>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none;vertical-align: top;margin:0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<div id="updateTemplate" style="display: none">
	<div divType="file_div" id="file_div" >
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td width="13%" align="right">
					i18n_tt.text.source_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM4[0].source" id="source" value="" />
					<font color="red"> * </font>
				</td>
				<td width="13%" align="right">
					i18n_tt.text.decompression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="N"
						checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.coverPath_n81i：
				</td>
				<td>
					<input type="text" name="paramM4[0].cover" id="cover" value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_tt.text.isCreateCover_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].isCreateCover"
						id="isCreateCover" value="Y" />
					i18n_tt.message.isCreateCoverY_n81i&nbsp;
					<input type="radio" name="paramM4[0].isCreateCover"
						id="isCreateCover" value="N" checked="checked" />
					i18n_tt.message.isCreateCoverN_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.deleteFile_n81i：
				</td>
				<td colspan="3">
					<textarea name="paramM4[0].deleteTmpStr" id="deleteTmpStr" rows="3"
						cols="70"></textarea>
					<font color="red">i18n_tt.message.deleteFile_n81i</font>
				</td>
			</tr>
		</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;"
				id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<div id="recoverTemplate" style="display: none">
	<div divType="file_div" id="file_div" >
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td width="13%" align="right">
					i18n_tt.text.source_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM4[0].source" id="source" value="" />
					<font color="red"> * </font>
				</td>
				<td width="13%" align="right">
					i18n_tt.text.decompression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="Y" />
					i18n_tt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM4[0].isAbs" id="isAbs" value="N"
						checked="checked" />
					i18n_tt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.coverPath_n81i：
				</td>
				<td>
					<input type="text" name="paramM4[0].cover" id="cover" value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_tt.text.deleteFile_n81i：
				</td>
				<td>
					<textarea name="paramM4[0].deleteTmpStr" id="deleteTmpStr" rows="3"
						cols="30"></textarea>
					<font color="red">i18n_tt.message.deleteFile_n81i</font>
				</td>
			</tr>
		</table>
			<span style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin:0 0px 10px 0;" 
				id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<div id="killProcessTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="hidden" name="[0]" id="index" />
		i18n_ctt.text.pidFile_n81i：&nbsp;
		<input type="text" name="paramM4[0].pidFile" id="pidFile" value="" />
		<font color="red">*</font>
		<span
			style="color: #000fff; cursor: hand; display: none; margin: 0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>
<div id="SingleExecTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<input type="hidden" name="[0]" id="index" />
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
				<td width="13%" align="right">
					i18n_tt.text.execcommand_n81i：
				</td>
				<td width="25%">
					<input type="text" name="paramM4[0].execCmd" id="execCmd" value="" />
					<font color="red"> * </font>
				</td>
				<td width="13%" align="right">
					i18n_tt.text.returnFlag_n81i：
				</td>
				<td>
					<input type="radio" name="paramM4[0].returnFlag" id="returnFlag"
						value="Y" />
					i18n_tt.message.Y_n81i&nbsp;
					<input type="radio" name="paramM4[0].returnFlag" id="returnFlag"
						value="N" checked="checked" />
					i18n_tt.message.N_n81i
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.username_n81i：
				</td>
				<td colspan="3">
					<input type="text" name="paramM4[0].username" id="username"
						value="" />
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_tt.text.maxWaitTime1_n81i：
				</td>
				<td id="maxWaitTime[0]" colspan="3" nowrap="nowrap">
					<input type="text" name="paramM4[0].maxWaitTime" id="maxWaitTime"
						value="3" /><font color="red"></font>
					i18n_tt.message.maxWaitTime_n81i
				</td>
				<td align="right" id="returnfile[0]" style="display: none;">
					i18n_tt.text.backFile_n81i：
				</td>
				<td id="returnfile[0]" style="display: none;">
					<input type="text" name="paramM4[0].returnPath" id="returnPath"
						value="" />
					<font color="red">*</font>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin: 0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_tt.text.delete_n81i</span>
	</div>
</div>