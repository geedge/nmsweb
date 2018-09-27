<%@ page language="java" contentType="text/html; charset=utf-8"
	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
	type="text/css" />
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<!-- 任务六：升级部署模板定义 -->
<div id="AgentUpgradeTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td align="right" width="10%">
					i18n_ctt.text.recovery_n81i：
				</td>
				<td colspan="3" id="recovery_Td[0}]">
					<span class="STYLE1" id="add_recovery_span"
						style="color: #000fff; cursor: hand;">i18n_ctt.text.recoverySets_n81i</span>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_ctt.text.backup_n81i：
				</td>
				<td colspan="3" id="backup_Td[0]">
					<span class="STYLE1" id="add_backup_span"
						style="color: #000fff; cursor: hand;">i18n_ctt.text.backupSets_n81i</span>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin: 0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_ctt.text.delete_n81i</span>
	</div>
</div>
<div id="OtherUpgradeTemplate" style="display: none">
	<div divType="file_div" id="file_div">
		<input type="hidden" name="[0]" id="index" />
		<table class="templateTable1">
			<tr>
				<td align="right" width="10%">
					i18n_ctt.text.startupFile_n81i：
				</td>
				<td width="33%">
					<input type="text" name="paramM6[0].startupFile" id="startupFile"
						value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_ctt.text.pidFile_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].pidFile" id="pidFile" value="" />
					<font color="red"> * </font>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_ctt.text.username_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].username"
						id="username" value="" />
				</td>
				<td align="right" rowspan="2" width="10%">
					i18n_ctt.text.execParams_n81i：
				</td>
				<td rowspan="2">
					<textarea name="paramM6[0].execParamsTmpStr" id="execParamsTmpStr"
						rows="4" cols="30"></textarea>
					<font color="red">i18n_ctt.message.execParams_n81i</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_ctt.text.maxWaitTime_n81i：
				</td>
				<td nowrap="nowrap">
					<input type="text" name="paramM6[0].maxWaitTime" id="maxWaitTime"
						value="" />
					i18n_ctt.message.maxWaitTime_n81i
				</td>
			</tr>
			<tr>
				<td align="right" width="10%">
					i18n_ctt.text.recovery_n81i：
				</td>
				<td colspan="3" id="recovery_Td[0]">
					<span class="STYLE1" id="add_recovery_span"
						style="color: #000fff; cursor: hand;">i18n_ctt.text.recoverySets_n81i</span>
				</td>
			</tr>
			<tr>
				<td align="right">
					i18n_ctt.text.backup_n81i：
				</td>
				<td colspan="3" id="backup_Td[0]">
					<span class="STYLE1" id="add_backup_span"
						style="color: #000fff; cursor: hand;">i18n_ctt.text.backupSets_n81i</span>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin: 0 0px 10px 0;"
			id="del_file_span">&nbsp;i18n_ctt.text.delete_n81i</span>
	</div>
</div>
<div id="upgradeBackupTemplate" style="display: none">
	<!-- 备份模板 -->
	<div divType="file_div" id="file_div">
		<input type="hidden" name="backups[0]" id="backUpIndex" />
		<table class="templateTable" style="width: 95%">
			<tr>
				<td width="13%" align="right">
					i18n_ctt.text.backupFile_n81i：
				</td>
				<td width="40%">
					<input type="text" name="paramM6[0].backups[0].backup" id="backup"
						value="" />
					<font color="red"> * </font>
				</td>
				<td width="10%" align="right">
					i18n_ctt.text.compression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].backups[0].isAbs" id="isAbs"
						value="Y" />
					i18n_ctt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM6[0].backups[0].isAbs" id="isAbs"
						value="N" checked="checked" />
					i18n_ctt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right" valign="">
					i18n_ctt.text.backupTo_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].backups[0].backupTo"
						id="backupTo" value="" />
					<font color="red"> * i18n_ctt.message.backupTo_n81i</font>
				</td>
				<td align="right">
					i18n_ctt.text.exceptFile_n81i：
				</td>
				<td>
					<textarea name="paramM6[0].backups[0].exceptTmpStr"
						id="exceptTmpStr" rows="3" cols="30"></textarea>
					<font color="red">i18n_ctt.message.exceptFile_n81i</font>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin: 0 0px 10px 0;"
			id="del_backup_span">&nbsp;i18n_ctt.text.delete_n81i</span>
	</div>
</div>
<div id="upgradeRecoveryTemplate" style="display: none">
	<!-- 恢复模板 -->
	<div divType="file_div" id="file_div">
		<!-- 恢复参数 -->
		<input type="hidden" name="recoverys[0]" id="recoveryIndex" />
		<table class="templateTable" style="width: 95%;">
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
					i18n_ctt.text.source_n81i：
				</td>
				<td width="27%">
					<input type="text" name="paramM6[0].recoverys[0].source"
						id="source" value="" />
					<font color="red"> * </font>
				</td>
				<td width="10%" align="right">
					i18n_ctt.text.decompression_n81i：
				</td>
				<td>
					<input type="radio" name="paramM6[0].recoverys[0].isAbs" id="isAbs"
						value="Y" />
					i18n_ctt.text.absolutePath_n81i&nbsp;
					<input type="radio" name="paramM6[0].recoverys[0].isAbs" id="isAbs"
						value="N" checked="checked" />
					i18n_ctt.text.relativePath_n81i
				</td>
			</tr>
			<tr>
				<td align="right" valign="middle">
					i18n_ctt.text.recoveryFile_n81i：
				</td>
				<td>
					<input type="text" name="paramM6[0].recoverys[0].cover" id="cover"
						value="" />
					<font color="red"> * </font>
				</td>
				<td align="right">
					i18n_ctt.text.deleteFile_n81i：
				</td>
				<td>
					<textarea name="paramM6[0].recoverys[0].deleteTmpStr"
						id="deleteTmpStr" rows="3" cols="30"></textarea>
					<font color="red">i18n_ctt.message.deleteFile_n81i</font>
				</td>
			</tr>
		</table>
		<span
			style="color: #000fff; cursor: hand; display: none; vertical-align: top; margin: 0 0px 10px 0;"
			id="del_recovery_span">&nbsp;i18n_ctt.text.delete_n81i</span>
	</div>
</div>