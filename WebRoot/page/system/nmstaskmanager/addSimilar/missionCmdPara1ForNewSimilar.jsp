<%@ page language="java" contentType="text/html; charset=utf-8"	autoFlush="true" buffer="0kb" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
<%
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>

<c:forEach var="paramMiss1" items="${paramM1}" varStatus="index">
	<!-- 任务一：文件推送模板定义 -->
		<div divType="file_div" id="file_div">
			<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
			<input type="button" value="i18n_mcpfns1.text.filePath_n81i" title="i18n_mcpfns1.text.filePath_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
			<input type="file" name="fileInfo" id="infoFile"  value="${paramMiss1.fileName}" onchange="javascript:setValue(this.value)"/>
			<font color="red">*</font>(i18n_mcpfns1.message.filePath_n81i)
			<input type="hidden" name="[${index.count-1}]" id="index"  />
			<span style="color: #000fff; cursor: hand; display: none;"
				id="del_file_span">&nbsp;i18n_mcpfns1.text.delete_n81i</span>
			<table class="templateTable1">
				<tr>
					<td width="10%" align="right">
						i18n_mcpfns1.text.destPath_n81i：
					</td>
					<td width="25%">
						<input type="text" name="paramM1[${index.count-1}].destPath" id="destPath"
							value="${paramMiss1.destPath}" />
						<font color="red">* </font>
					</td>
					<td width="10%" align="right">
						i18n_mcpfns1.text.isCover_n81i：
					</td>
					<td>
						<input type="radio" name="paramM1[${index.count-1}].isCover" id="isCover"	value="Y"
						        <c:if test="${paramMiss1.isCover=='Y' || paramMiss1.isCover=='y'}"> checked="checked"</c:if>  />
						i18n_mcpfns1.message.isCoverY_n81i&nbsp;
						<input type="radio" name="paramM1[${index.count-1}].isCover" id="isCover"	value="N" 
                                <c:if test="${paramMiss1.isCover=='N' || paramMiss1.isCover=='n'}"> checked="checked"</c:if>  />
						i18n_mcpfns1.message.isCoverN_n81i&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right">
						i18n_mcpfns1.text.username_n81i：
					</td>
					<td colspan="3">
						<input type="text" name="paramM1[${index.count-1}].username" id="username"
							value="${paramMiss1.username}" />
					</td>
					<!-- 
					<td align="right">
						属主*密码：
					</td>
					<td>
						<input type="password" name="paramM1[${index.count-1}].param1"
							id="param1" value="" style="width: 200px" />
					</td>
					 -->
			</tr>
				<tr>
					<td align="right">
						i18n_mcpfns1.text.groupName_n81i：
					</td>
					<td>
						<input type="text" name="paramM1[${index.count-1}].groupName" id="groupName"
							value="${paramMiss1.groupName}" />
					</td>
					<td align="right">
						i18n_mcpfns1.text.permisson_n81i：
					</td>
					<td>
						<input type="text" name="paramM1[${index.count-1}].permisson" id="permisson"
							value="${paramMiss1.permisson}" />
					</td>
				</tr>
			</table>
		</div>
</c:forEach>
<script type="text/javascript">

</script>