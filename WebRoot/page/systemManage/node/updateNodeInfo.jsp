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
		<title>i18n_uni.message.title_n81i</title>
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
			    if($id("nodeIp","ip","i18n_uni.text.nodeIp_n81i") && $("#nodeIp").checkByteLength(64,"i18n_uni.text.nodeIp_n81i")
			    	 && $id("nodeName","","i18n_uni.text.nodeName_n81i") && $("#nodeName").checkByteLength(64,"i18n_uni.text.nodeName_n81i") ){
					document.Nodeform.action="<%=path%>/sysManage/nodeManage!executeAction.do?action=doUpdate";
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
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="nodeTable.nodeId"
					value="${nodeTable.nodeId }" />
				<input type="hidden" name="nodeNameVo" id="nodeNameVo"
					value="${nodeNameVo }" />
				<input type="hidden" name="nodeDescVo" id="nodeDescVo"
					value="${nodeDescVo }" />
				<input type="hidden" name="nodeTable.seqId"
					value="${nodeTable.seqId }" />
				<input type="hidden" name="oldNodeIp" value="${nodeTable.nodeIp }" />
				<table border="0" cellpadding="0" cellspacing="0" class="table1">
					<tr>
						<td colspan="4" class="color_7">
							<strong>i18n_uni.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_uni.text.nodeIp_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text" name="nodeTable.nodeIp" id="nodeIp"
								value="${nodeTable.nodeIp }" style="width: 155px;"  />
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_uni.text.nodeName_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="nodeTable.nodeName" id="nodeName"
								value="${nodeTable.nodeName }" style="width: 155px;"  />
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_uni.text.nodeType_n81i：
						</td>
						<td class="color_6" align="left">
							<select name="nodeTable.nodeType" id="nodeType"
								style="width: 155px;" >
								<option value="0" <c:if test="${nodeTable.nodeType==0 }">selected</c:if>>
									i18n_uni.message.computer_n81i
								</option>
							</select>
						</td>
						<td class="color_1" align="right">
							i18n_uni.message.nodeUType_n81i：
						</td>
						<td class="color_6"  align="left">
							<select name="nodeTable.nodeUType" id="nodeUType"
								style="width: 155px;" >
								<option value="1" <c:if test="${nodeTable.nodeUType == '1'}">selected="selected"</c:if>>
									1U
								</option>
								<option value="2" <c:if test="${nodeTable.nodeUType == '2'}">selected="selected"</c:if>>
									2U
								</option>
								<option value="3" <c:if test="${nodeTable.nodeUType == '3'}">selected="selected"</c:if>>
									3U
								</option>
								<option value="4" <c:if test="${nodeTable.nodeUType == '4'}">selected="selected"</c:if>>
									4U
								</option>
								<option value="5" <c:if test="${nodeTable.nodeUType == '5'}">selected="selected"</c:if>>
									5U
								</option>
								<option value="6" <c:if test="${nodeTable.nodeUType == '6'}">selected="selected"</c:if>>
									6U
								</option>
								<option value="7" <c:if test="${nodeTable.nodeUType == '7'}">selected="selected"</c:if>>
									7U
								</option>
								<option value="8" <c:if test="${nodeTable.nodeUType == '8'}">selected="selected"</c:if>>
									8U
								</option>
								<option value="9" <c:if test="${nodeTable.nodeUType == '9'}">selected="selected"</c:if>>
									9U
								</option>
								<option value="10" <c:if test="${nodeTable.nodeUType == '10'}">selected="selected"</c:if>>
									10U
								</option>
								<option value="11" <c:if test="${nodeTable.nodeUType == '11'}">selected="selected"</c:if>>
									11U
								</option>
								<option value="12" <c:if test="${nodeTable.nodeUType == '12'}">selected="selected"</c:if>>
									12U
								</option>
								<option value="13" <c:if test="${nodeTable.nodeUType == '13'}">selected="selected"</c:if>>
									13U
								</option>
								<option value="14" <c:if test="${nodeTable.nodeUType == '14'}">selected="selected"</c:if>>
									14U
								</option>
							</select>
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_uni.text.nodeDesc_n81i：
						</td>
						<td class="color_3" align="left">
							<textarea rows="4" cols="40" name="nodeTable.nodeDesc"
								id="nodeDesc" style="width: 155px; height: 50px;"
								>${nodeTable.nodeDesc }</textarea>
						</td>
						<td class="color_1" align="right">
							i18n_uni.text.nodeState_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="nodeTable.nodeState" id="nodeState"
								value="0" <c:if test="${nodeTable.nodeState==0 }">checked</c:if> />
							i18n_uni.message.nodeState0_n81i
							<input type="radio" name="nodeTable.nodeState" id="nodeState"
								value="1" <c:if test="${nodeTable.nodeState==1 }">checked</c:if> />
								i18n_uni.message.nodeState1_n81i
							
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_uni.text.snmpVersion_n81i：
						</td>
						<td class="color_6" colspan="3" align="left">
							<input type="radio" name="nodeTable.snmpVersion" value="1" <c:if test="${nodeTable.snmpVersion==1 }">checked="checked"</c:if> />VERSION2C&nbsp;
							<input type="radio" name="nodeTable.snmpVersion" value="3" <c:if test="${nodeTable.snmpVersion==3 }">checked="checked"</c:if>  />VERSION3 
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4"  align="right">
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="add()" value="i18n_uni.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Mkform'].reset()"
											value="i18n_uni.text.reset_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="goBack()" value="i18n_uni.text.back_n81i"/>
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
