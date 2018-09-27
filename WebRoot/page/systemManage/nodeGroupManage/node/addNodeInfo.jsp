<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>i18n_addNodeInfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript" 
			src="<c:url value='/js/jquery.js' />"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/j.suggest.js'/>"></script>
		<script type="text/javascript">
			var vstart;
			function add(){
				//去空格
			    $("#nodeIp").val($.trim($("#nodeIp").val()));
				$("#nNa").val($.trim($("#nNa").val()));				

			    if($id("nodeIp","ip","i18n_addNodeInfo.text.nodeIp_n81i") && $("#nodeIp").checkByteLength(64,"i18n_addNodeInfo.text.nodeIp_n81i")
			    	 && $id("nodeMac","","i18n_addNodeInfo.text.nodeMac_n81i") && $("#nodeMac").checkByteLength(100,"i18n_addNodeInfo.text.nodeMac_n81i")
			    	 && $id("nNa","","i18n_addNodeInfo.text.nNa_n81i") && $("#nNa").checkByteLength(64,"i18n_addNodeInfo.text.nNa_n81i")
			    	 && $id("nodeBoxIspn","","i18n_addNodeInfo.text.nodeBoxIspn_n81i") && $id("nodeUType","sz","i18n_addNodeInfo.text.nodeUType_n81i") 
			    	 && $id("nodeBeginUType","xz","i18n_addNodeInfo.text.nodeBeginUType_n81i")){
			    	 if($("#nodeType").val() == "1"){
			    	 	if($("#networElementType").val() == ""){
			    	 		alert("i18n_addNodeInfo.message.nodeBeginUType_n81i");
			    	 		return false;
			    	 	}
			    	 }else if($("#nodeType").val()==0&&(!$("#specialServerTypeTR").is(":hidden"))){
			    		 if($("#specialServerType").val() == ""){
				    	 		alert("i18n_addNodeInfo.message.nodeSpecialServerType_n81i");
				    	 		return false;
				    	 }
			    		 $("#version2").val("");
			    		 $("#version3").val("");
			    		 $("#networElementType").val("");
			    	 }else{
			    		 $("#version2").val("");
			    		 $("#version3").val("");
			    		 $("#specialServerType").val("");
			    		$("#networElementType").val("");
			    	 }
					document.Nodeform.action="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=doAdd";
					document.Nodeform.submit();	
				}	
			}
			
			function goBack(){
				document.Nodeform.action="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
				document.Nodeform.submit();	
			}
			
			function nodeTypeChange(){
				var nodeType = $("#nodeType").val();
				if(nodeType=='1'){
					$("#networElementTypeTR").show();
					$(".snmpVersionType").show();
				}else{
					$("#networElementTypeTR").hide();
					$(".snmpVersionType").hide();
				}
				var nodeTypeIndex=$("#nodeType option").index($('#nodeType option:selected'));
				if(nodeTypeIndex==2){
					$("#specialServerTypeTR").show();
				}else{
					$("#specialServerTypeTR").hide();
				}
			}
			
			//-- 节点IP 失去焦点事件绑定 自动匹配该节点是否已存在某机柜
	 		function nodeIpChange(){
	 				$.post("<c:url value='/nodeGroupManage/nodeManage!getNodeBox.do'/>",
		 					{nodeIp:$("#nodeIp").val()},
		 					function(data){
		 						if(data!=null && data!=""){
			 						$("#nodeBoxIspn").val(data.nodeBoxIspn);
		 							$("#nodeUType").val(data.nodeUType);
			 						if(data.nodeUType!=null){
			 							vstart =data.nodeBeginUType;//保留节点在机柜已有起始U位
			 							//$("#nodeUType").trigger("blur");//触发节点厚度（U位）的绑定事件，即获取机柜的空闲位置（可选起始U位选项）
			 							$("#nodeUType").trigger("onchange");//触发节点厚度（U位）的绑定事件，即获取机柜的空闲位置（可选起始U位选项）
			 						}
		 						}else{
		 							vstart = null;
		 							$("#nodeBoxIspn").val("");//Ispn的值改变会触发它自己绑定的事件，即把nodeUType和nodeBeginUType清空
		 						}
		 					}, "json");
	 		}
	 		
	 		function checkNodeIp(){
				$.post("<c:url value='/nodeGroupManage/nodeManage!checkNodeIp.do'/>",
						{nodeIp:$("#nodeIp").val(),nodeGroupId:$("#nodeGroupId").val()},
						function(data){
							if(data!=null && data!=""){
								//同一节点组存在相同的IP
								if(data.isExist !=null){
									alert("i18n_addNodeInfo.message.nodeGroup_n81i");
									$("#nodeIp").val("");
									clearInfo();
								}else{
									//其它节点组存在相同IP
									if(data.nodeIp !=null){
										//设置Mac
										$("#nodeMac").val(data.nodeMac);
										//设置节点名称
										$("#nNa").val(data.nodeName);
										//设置节点类型
										if(data.nodeType==1){
											$("#nodeType").val(data.nodeType);
											$("#networElementTypeTR").show();
											//设置SNMP版本
											$(".snmpVersionType").show();
											if(data.snmpVersion == "1"){
												$("#version2").attr("checked","checked");
											}else if(data.snmpVersion == "3"){
												$("#version3").attr("checked","checked");
											}
										}else{
											$("#networElementTypeTR").hide();
										}
										if(data.nodeType==0&&data.specialServerType!=0){
											$("#nodeType option:last").attr("selected","selected");
											$("#specialServerTypeTR").show();
											$("#specialServerType").val(data.specialServerType);
										}else{
											$("#nodeType option:first").val(data.nodeType);
											$("#specialServerTypeTR").hide();
										}
										//设置网元类型
										 $("#networElementType").val(data.networElementType);
										//设置用户名
										$("#nodeUserName").val(data.nodeUserName);
										//设置密码
										$("#nodePassword").val(data.nodePassword);
										//设置机柜编号
										 $("#nodeBoxIspn").val(data.nodeBoxIspn);
										//设置机柜起始U位
										vstart = data.nodeBeginUType
										//设置节点厚度
										$("#nodeUType").val(data.nodeUType);	
										/* $("#nodeUType").trigger("onchange"); */
										nodeUTypeChange()
										//设置节点IP信息
										 $("#nodeIpInfo").val(data.nodeIpInfo);
										//设置节点描述
										$("#nodeDesc").val(data.nodeDesc);
										$("#nodeIp").next().html("i18n_addNodeInfo.message.nodeIp_n81i");
									}
								}
							}else{
								clearInfo();
							}
						},
						"json"
					);
			}
			
			function clearInfo(){
				$("#nodeMac").val("");
				$("#nNa").val("");
				/* $("#nodeType").val(0); */
				$("#nodeType option:first").attr("selected","selected");
				$("#networElementTypeTR").hide();
				$("#networElementType").val("");
				$("#nodeUserName").val("");
				$("#nodePassword").val("");
				$("#nodeBoxIspn").val("");
				$("#version2").attr("checked","checked");
				$("#nodeUType").val("");	
				$("#nodeBeginUType").empty();
	 			$("#nodeBeginUType").append("<option value=''>i18n_addNodeInfo.message.selectDefault_n81i</option>");
				$("#nodeIpInfo").val("");
				$("#nodeDesc").val("");
				$("#nodeIp").next().html("");
			}
			//-- 节点厚度（U位） 事件绑定 由节点厚度（U位）决定起始U位的可选项
	 			function nodeUTypeChange(){
	 				if(isNaN($("#nodeUType").val())){
	 					alert("i18n_addNodeInfo.message.nodeUType_n81i");
	 					$("#nodeUType").val("");
	 					$("#nodeBeginUType").empty();
	 					$("#nodeBeginUType").append("<option value=''>i18n_addNodeInfo.message.selectDefault_n81i</option>");
	 					$("#nodeUType").focus();
	 					return;
	 				}
	 				$("#nodeBeginUType").empty();
	 				$("#nodeBeginUType").append("<option value=''>i18n_addNodeInfo.message.selectDefault_n81i</option>");
	 				var boxIspn = $("#nodeBoxIspn").val();
	 				var nodeIp = $("#nodeIp").val();
	 				var curVal = $("#nodeUType").val();
	 				if(curVal!=""){
		 				$.post("<c:url value='/nodeGroupManage/nodeManage!getBoxFreePosition.do'/>",
		 					{"nodeBoxIspn":boxIspn,"nodeIp":nodeIp,"nodeUType":curVal},
		 					function(data){
		 						// 追加option元素
		 						if(data!=null && data!=""){
		 							var optionStr="";
			 						$.each(data, function(i,val){
			 							if(i==0){
			 								optionStr = "<option selected='selected' value='"+val+"'>" + val + "</option>"
			 							}else{
			 								optionStr = "<option value='"+val+"'>" + val + "</option>"
			 							}
			 							$("#nodeBeginUType").append(optionStr);
			 						});
		 						}
		 						// 自动匹配位置
		 						if(vstart!=null && vstart!=""){
			 						$("#nodeBeginUType >option[value='"+vstart+"']").attr("selected",true);
			 						vstart = null;//该值改变后只能使用一次，所以一经调用就将其清空
		 						}
		 					}, "json");
		 			}
	 			}
			
			// -----界面机柜及位置相关处理
			$(function(){
				//-- 机柜 事件绑定 清空节点起始U位和节点厚度（U位）
	 			$("#nodeBoxIspn").bind("input",function(){
	 				$("#nodeBeginUType").empty();
	 				$("#nodeBeginUType").append("<option value=''>i18n_addNodeInfo.message.selectDefault_n81i</option>");
	 				$("#nodeUType").val("");
	 			});
	 			
	 			//联想查询修改成列表形式
	 			jQuery.post("<c:url value='/nodePosition/boxSet!getAllBoxsIspn.do' />",{},function(data,textStatus){
					var everyItems=data.split(";");
					var allName=new Array();			
					for(var j=0;j<everyItems.length;j++){	
						if(j!=(everyItems.length-1)){											
							var getN=everyItems[j];					
							allName[j]=new Array('',getN,'');
						}						
					}	
					jQuery("#nodeBoxIspn").suggest(allName,{hot_list:allName,attachObject:"#suggest1"});								
				});
			});
			
		</script>
	</head>
	<body>
		<div class="middle_list">
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_addNodeInfo.button.back_n81i"/>
			 </div>	
			 <div style="height: 25px"></div>
			<form action="" name="Nodeform" method="post" style="border:0px;">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" id="nodeGroupId"/>
				<input type="hidden" name="fromWhere" value="${fromWhere }"/>
				<input type="hidden" name="type" value="${type }"/>
				<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
				<input type="hidden" name="isValid" value="${isValid }" />
				<table border="0" cellpadding="0" cellspacing="0" class="table1">
					<tr>
						<td colspan="4" class="color_7">
							<strong>i18n_addNodeInfo.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nodeIp_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text" name="nodeTable.nodeIp" id="nodeIp"
								style="width: 155px;" onchange="checkNodeIp()" />
								<font color="red">*</font>
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nodeMac_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="nodeTable.nodeMac" id="nodeMac"
								style="width: 155px;"  />
								<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nNa_n81i：
						</td>
						<td class="color_6" align="left" >
							<input type="text" name="nodeTable.nodeName" id="nNa"
								style="width: 155px;"  />
								<font color="red">*</font>
						</td>
						
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nodeType_n81i：
						</td>
						<td class="color_6" align="left">
							<select name="nodeTable.nodeType" id="nodeType" onchange="nodeTypeChange()"
								style="width: 161px;" >
								<option value="0">
									i18n_addNodeInfo.message.nodeType0_n81i
								</option>
								<option value="1">
									i18n_addNodeInfo.message.nodeType1_n81i
								</option>
								<option value="0">
									i18n_addNodeInfo.message.nodeType2_n81i
								</option>
							</select>
						</td>
					</tr>
					<tr id="networElementTypeTR" style="display: none;">
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.networElementType_n81i：
						</td>
						<td class="color_6" align="left" colspan="3">
							<select name="nodeTable.networElementType" id="networElementType"
								style="width: 161px;" >
								<option value="">i18n_addNodeInfo.message.selectDefault_n81i</option>
								<c:forEach items="${optionList}"  var="optionTable" >
									<option value="${optionTable.typeCode}" <c:if test="${optionTable.typeCode == nodeTable.networElementType}">selected="selected"</c:if>>
										${optionTable.typeValue}
									</option>
								</c:forEach>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr id="specialServerTypeTR" style="display: none;">
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.specialServerType_n81i：
						</td>
						<td class="color_6" align="left" colspan="3">
							<select name="nodeTable.specialServerType" id="specialServerType"
								style="width: 161px;" >
								<option value="">i18n_addNodeInfo.message.selectDefault_n81i</option>
								<c:forEach items="${optionList2}"  var="optionTable" >
									<option value="${optionTable.typeCode}" <c:if test="${optionTable.typeCode == nodeTable.specialServerType}">selected="selected"</c:if>>
										${optionTable.typeValue}
									</option>
								</c:forEach>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nodeUserName_n81i：
						</td>
						<td class="color_6" width="30%" align="left">
							<input type="text" name="nodeTable.nodeUserName"  id="nodeUserName"
								style="width: 155px;" />
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_addNodeInfo.text.nodePassword_n81i：
						</td>
						<td class="color_6" align="left">
							<c:choose>
								<c:when test="${jsbh}">
									<input type="text" name="nodeTable.nodePassword"  id="nodePassword"
								style="width: 155px;"  />
								</c:when>
								<c:otherwise>
									<input type="password" name="nodeTable.nodePassword"  id="nodePassword"
								style="width: 155px;"  />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.nodeBoxIspn_n81i：
						</td>
						<td class="color_6" align="left">
							<input name="nodeTable.nodeBoxIspn" id="nodeBoxIspn" style="width: 156px;" title="i18n_addNodeInfo.message.nodeBoxIspn_n81i"/>
							<font color="red">*</font>
							<div id='suggest1' class="ac_results"></div>
						</td>
						<td class="color_1 snmpVersionType" align="right" style="display: none;">
							i18n_addNodeInfo.text.snmpVersion_n81i：
						</td>
						<td class="color_6 snmpVersionType" align="left" style="display: none;">
							<input type="radio" name="nodeTable.snmpVersion" value="1"  id="version2" checked="checked"/>VERSION2C&nbsp;
							<input type="radio" name="nodeTable.snmpVersion" value="3"  id="version3"/>VERSION3 
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.nodeUType_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="text" name="nodeTable.nodeUType" id="nodeUType"
								style="width: 155px;"  oninput="nodeUTypeChange()"/>
							<font color="red">*</font>
						</td>
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.nodeBeginUType_n81i：
						</td>
						<td class="color_3" align="left">
							<select name="nodeTable.nodeBeginUType" id="nodeBeginUType"
								style="width: 161px;" >
								<option value="">
									i18n_addNodeInfo.message.selectDefault_n81i
								</option>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.nodeIpInfo_n81i：
						</td>
						<td class="color_6" align="left">
							<textarea rows="4" cols="40" name="nodeTable.nodeIpInfo"
								id="nodeIpInfo" style="width: 155px; height: 50px;"
								></textarea>
						</td>
						<td class="color_1" align="right">
							i18n_addNodeInfo.text.nodeDesc_n81i：
						</td>
						<td class="color_3" align="left" >
							<textarea rows="4" cols="40" name="nodeTable.nodeDesc"
								id="nodeDesc" style="width: 155px; height: 50px;"
								></textarea>
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
											onclick="add()" value="i18n_addNodeInfo.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Nodeform'].reset()"
											value="i18n_addNodeInfo.button.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
