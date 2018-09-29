<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@ include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_ani.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
			function add(){
				//去空格
			    $("#nodeIp").val($.trim($("#nodeIp").val()));
				$("#nodeName").val($.trim($("#nodeName").val()));
				//验证不能空与长度限制
			    if($id("nodeIp","ip","i18n_ani.text.nodeIp_n81i") && $("#nodeIp").checkByteLength(64,"i18n_ani.text.nodeIp_n81i")
			    	 && $id("nodeName","","i18n_ani.text.nodeName_n81i") && $("#nodeName").checkByteLength(64,"i18n_ani.text.nodeName_n81i") ){
					document.Nodeform.action="<%=path%>/sysManage/nodeManage!executeAction.do?action=doAdd";
					document.Nodeform.submit();	
				}	
			}
			
			function goBack(){
				document.Nodeform.action="<%=path%>/sysManage/nodeManage!executeAction.do?action=query";
				document.Nodeform.submit();	
			}
			
			function nodeTypeChange(){
				var ftType = document.getElementById('nodeType').value;
				if(ftType=='1'){
					document.getElementById('unode').style.display='block';
				}else{
					document.getElementById('unode').style.display='none';
				}
			}
			
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="Nodeform" method="post" style="border:0px;">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<table border="0" cellpadding="0" cellspacing="0" class="table1">
					<tr>
						<td colspan="4" class="color_7">
							<strong>i18n_ani.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_ani.text.nodeIp_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text" name="nodeTable.nodeIp" id="nodeIp"
								style="width: 155px;"  />
								<font color="red">*</font>
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_ani.text.nodeName_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="nodeTable.nodeName" id="nodeName"
								style="width: 155px;"  />
								<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ani.text.nodeType_n81i：
						</td>
						<td class="color_6" align="left">
							<select name="nodeTable.nodeType" id="nodeType"
								style="width: 155px;" >
								<option value="0">
									i18n_ani.message.computer_n81i
								</option>
							</select>
						</td>
						<td class="color_1" align="right">
							i18n_ani.text.nodeUType_n81i：
						</td>
						<td class="color_6" align="left">
							<select name="nodeTable.nodeUType" id="nodeUType"
								style="width: 155px;" >
								<option value="1">
									1U
								</option>
								<option value="2">
									2U
								</option>
								<option value="3">
									3U
								</option>
								<option value="4">
									4U
								</option>
								<option value="5">
									5U
								</option>
								<option value="6">
									6U
								</option>
								<option value="7">
									7U
								</option>
								<option value="8">
									8U
								</option>
								<option value="9">
									9U
								</option>
								<option value="10">
									10U
								</option>
								<option value="11">
									11U
								</option>
								<option value="12">
									12U
								</option>
								<option value="13">
									13U
								</option>
								<option value="14">
									14U
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ani.text.nodeDesc_n81i：
						</td>
						<td class="color_3" align="left">
							<textarea rows="4" cols="40" name="nodeTable.nodeDesc"
								id="nodeDesc" style="width: 155px; height: 50px;"
								></textarea>
						</td>
						<td class="color_1" align="right">
							i18n_ani.text.nodeState_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="nodeTable.nodeState" id="nodeState"
								value="0" checked />i18n_ani.message.nodeState0_n81i
							<input type="radio" name="nodeTable.nodeState" id="nodeState"
								value="1" /><font color="red">i18n_ani.message.nodeState1_n81i</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ani.text.snmpVersion_n81i：
						</td>
						<td class="color_6" colspan="3" align="left">
							<input type="radio" name="nodeTable.snmpVersion" value="1"  checked="checked"/>VERSION2C&nbsp;
							<input type="radio" name="nodeTable.snmpVersion" value="3" />VERSION3 
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="add()" value="i18n_ani.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Mkform'].reset()"
											value="i18n_ani.text.reset_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="goBack()" value="i18n_ani.text.back_n81i"/>
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
