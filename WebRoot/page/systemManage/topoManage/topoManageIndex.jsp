<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@include file="/common/taglib.jsp"%>

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
		<title>i18n_nginfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/MzTreeView10.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/dtree/js/dtree_checkbox_expand.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
	</head>
	
	<script type="text/javascript">
		//页面初始化 回显节点对应信息
		$(function(){
			$("input[name^='topoNodeType']:checked").each(function(index,data){
				var radioValue=$(data).val();
				if(radioValue==1){
					$("#topoInfo"+index).hide();
					$("#chooseGroupNode"+index).show();
					$("#topoNodeOne"+index).show();
					$("#topoNodeTwo"+index).show();
					$("#chooseType").val(1);
					$('#chooseIndex').val(index);
				}else if(radioValue==2){
					$("#topoInfo"+index).hide();
					$("#chooseGroupNode"+index).show();
					$("#topoNodeOne"+index).hide();
					$("#topoNodeTwo"+index).hide();
					$("#chooseType").val(0);
					$('#chooseIndex').val(index);
				}else if(radioValue==4){
					$("#topoInfo"+index).show();
					$("#chooseGroupNode"+index).hide();
					$("#topoNodeOne"+index).hide();
					$("#topoNodeTwo"+index).hide();
					$("#chooseType").val(0);
					$('#chooseIndex').val(index);
				}else{
					$("#topoInfo"+index).hide();
					$("#chooseGroupNode"+index).hide();
					$("#topoNodeOne"+index).hide();
					$("#topoNodeTwo"+index).hide();
					$("#chooseType").val(0);
					$('#chooseIndex').val(index);
				}
			})	
		})
	
		function selectNodeAndNodeGroup(index) {
			var groupId = $('#nodeGroupId'+index).val();//选中节点组
			var nodeId = $('#nodeId'+index).val();//选中ip	
			var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&type=topoManage&groupId="+groupId+"&nodeId="+nodeId; //转向网页的地址;
			var name; 
			//改为layer-20180831-chenjs---
			parent.layer.open({
				type: 2,
				title: "i18n_tsnang.text.selectNodeGroup_n81i",
				area:['850px', '610px'],
				shade: 0.6,
				closeBtn: 1,
				maxmin:true,
				content: url
			});
		}
		
		//弹窗设置的节点信息  在弹窗关闭后设置在页面
		function reciveTopoNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps){
			var index=$('#chooseIndex').val();
			document.getElementById("nodeGroupName"+index).value = nodeGroupNames;//节点组名称s
			document.getElementById("nodeGroupId"+index).value = nodeGroupIds;//节点组ids
			document.getElementById("nodeName"+index).value = nodeIps;//节点ips
			document.getElementById("nodeId"+index).value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
		}	
		
		//选择不同type类型后 切换页面显示
		function chooseTopoNodeType(data){
			var value=$(data).val();
			var index=$(data).attr('status');
			if(value==4){
				$("#topoInfo"+index).show();
				$("#chooseGroupNode"+index).hide();
				$("#topoNodeOne"+index).hide();
				$("#topoNodeTwo"+index).hide();
				$("#chooseType").val(0);
				$('#chooseIndex').val(index);
			}else if(value==3){
				$("#topoInfo"+index).hide();
				$("#chooseGroupNode"+index).hide();
				$("#topoNodeOne"+index).hide();
				$("#topoNodeTwo"+index).hide();
				$("#chooseType").val(0);
				$('#chooseIndex').val(index);
			}else if(value==2){
				$("#topoInfo"+index).hide();
				$("#chooseGroupNode"+index).show();
				$("#topoNodeOne"+index).hide();
				$("#topoNodeTwo"+index).hide();
				$("#chooseType").val(0);
				$('#chooseIndex').val(index);
			}else{
				$("#topoInfo"+index).hide();
				$("#chooseGroupNode"+index).show();
				$("#topoNodeOne"+index).show();
				$("#topoNodeTwo"+index).show();
				$("#chooseType").val(1);
				$('#chooseIndex').val(index);
			}
		}
		
		//点击提交后 执行操作结果
		function commitAdd(){
			var flag=true;
			var topoManageInfos=new Array();
			$("input[name^='topoNodeType']:checked").each(function(index,data){
				var nodeIds=$('#nodeId'+index).val();
				var groupIds=$('#nodeGroupId'+index).val();
				var selectTopoInfoId=$("#chooseTopoInfo"+index).val();
				var radioValue=$(data).val();
				// 拼接json数据
				var topoManageInfo={};
				var data={};
				topoManageInfo.nodeId=$('#topoNodeInfoId'+index).val();
				topoManageInfo.nodeType=radioValue;
				if(radioValue==1){
					if(nodeIds==null||nodeIds==undefined||nodeIds==''){
						alert("i18n_topoManage.topoNodeError1_n81i");
						flag=false;
						return;
					}else if(nodeIds.indexOf(',')!=-1){
						alert("i18n_topoManage.topoNodeError2_n81i");
						flag=false;
						return;
					}
					topoManageInfo.nodeTypeId=nodeIds;
				}else if(radioValue==2){
					if(groupIds==null||groupIds==undefined||groupIds==''){
						alert("i18n_topoManage.topoNodeGroupError1_n81i");
						flag=false;
						return;
					}else if(groupIds.indexOf(',')!=-1){
						alert("i18n_topoManage.topoNodeGroupError2_n81i");
						flag=false;
						return;
					}
					topoManageInfo.nodeTypeId=groupIds;
				}else if(radioValue==4){
					if(selectTopoInfoId==null||selectTopoInfoId==undefined||selectTopoInfoId==''){
						alert("i18n_topoManage.topoNodeInfoError_n81i");
						flag=false;
						return;
					}
					topoManageInfo.nodeTypeId=selectTopoInfoId;
				}
				//data.topoManageInfo=topoManageInfo;
				topoManageInfos.push(topoManageInfo);
			});
			console.log(topoManageInfos)
			var systemId=$('#system').val();
			var topoInfoId=$('#topo').val();
			if(flag){
				$.ajax({
					type : "get",
					dataType : 'json',
					url : "<%=path%>/sysManage/topoManage.do?action=modify",
					data:{'datas':JSON.stringify(topoManageInfos),'topoInfoId':topoInfoId,'systemId':systemId},
					success : function(res) {
						alert("i18n_topoManage.handleSuccessInfo_n81i");
						location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId+'&topoInfoId='+topoInfoId;
					},
					error:function(){
						alert("i18n_topoManage.handleErrorInfo_n81i");
					}
				})
			}
		}
		
		//业务系统下拉框改变时操作
		function selectSystem(data){
			var systemId=$(data).val();
			location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
		}
		
		//选择topo图时操作
		function selectTopo(data){
			var systemId=$('#system').val();
			var topoInfoId=$(data).val();
			location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId+'&topoInfoId='+topoInfoId;
		}
		
	</script>
	
	<body>
		<input type='hidden' id="fw" value='topoManage'/>
		<div class="middle_list" style="overflow: hidden;">
			<div id="maindiv" style="clear:both;">
			<form action="" name="nodeGroupForm" id="nodeGroupForm" method="post" >
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info" style="">
					<tr>
						<td class="color_8">i18n_topoManage.topoInformation_n81i</td>
					</tr>
					<tr>
						<td class="color_3" align="left" valign="top">
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
								<tr type='form'>
									<td class="color_1" width="13%" align="right">
										i18n_topoManage.system_n81i：
									</td>
									<td class="color_6" align="left">
										<select name='systemId' id='system' onchange='selectSystem(this)'>
											<c:if test="${fn:length(sysList)>0 }">
												<c:forEach items="${sysList }" var="system">
													<c:choose>
														<c:when test="${system.systemId==systemId}">
															<option value="${system.systemId}" selected='selected'>
																${system.systemName}
															</option>
														</c:when>
														<c:otherwise>
															<option value="${system.systemId}">
																${system.systemName}
															</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:if>
										</select>
									</td>
									<td class="color_1" width="13%" align="right">
										i18n_topoManage.topoPicture_n81i：
									</td>
									<td class="color_3" width="37%" align="left">
										<select name='topoInfoId' id='topo' onchange='selectTopo(this)'>
											<c:if test="${fn:length(allTopoInfoList)>0 }">
												<option selected="selected" value="">
													i18n_topoManage.chooseTopoMessage_n81i
												</option>
												<c:forEach items="${allTopoInfoList }" var="topoInfo">
													<c:choose>
														<c:when test="${topoInfo.id==topoInfoId}">
															<option value="${topoInfo.id }" selected='selected'>
																${topoInfo.name}
															</option>
														</c:when>
														<c:otherwise>
															<option value="${topoInfo.id }">
																${topoInfo.name}
															</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:if>
										</select>
									</td>
								</tr>
							</table>
					</td>
				</tr>
				<c:if test="${fn:length(topoManageInfos)>0 }">
					<tr>
						<td class="color_8">i18n_topoManage.TopoNodeMessage_n81i</td>
					</tr>
					<tr>
						<td class="color_3" align="left" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" class="table" id="info2" style="">
									<c:forEach items="${topoManageInfos }" var="topoManageInfo" varStatus='status'>
										 <input type='hidden' id="chooseType" value=''/>
										 <input type='hidden' id="chooseIndex" value=''/>
										 <tr type='form'>
											<td class="color_1"  align="right">
											i18n_topoManage.topoNodeName_n81i：
											</td>
											<td class="color_6"  align="left">
												<input name='topoManageInfo.topoNodeInfo.id' type='hidden' value='${topoManageInfo.topoNodeInfo.id}' id="topoNodeInfoId${status.index}"/>
												<input readonly='readonly' value="${topoManageInfo.topoNodeInfo.text}" style='width:300px'/>
											</td>
											<td class="color_1"  align="right">
											i18n_topoManage.topoNodeType_n81i：
											</td>
											<td class="color_6"  align="left">
												<c:forEach items="${typeList}" var="type">
													<c:choose>
														<c:when test='${type==topoManageInfo.topoNodeInfo.type}'>
															<input type='radio' status='${status.index}' value='${type}' name='topoNodeType${status.index}' checked='checked'  onchange="chooseTopoNodeType(this)"/><c:if test='${type==1}'>i18n_topoManage.topoNode_n81i</c:if><c:if test='${type==2}'>i18n_topoManage.topoNodeGroup_n81i</c:if><c:if test='${type==3}'>i18n_topoManage.topoNone_n81i</c:if><c:if test='${type==4}'>i18n_topoManage.topoPicture_n81i</c:if>
														</c:when>
														<c:otherwise>
															<input type='radio' status='${status.index}' name='topoNodeType${status.index}' value='${type}' onchange="chooseTopoNodeType(this)"/><c:if test='${type==1}'>i18n_topoManage.topoNode_n81i</c:if><c:if test='${type==2}'>i18n_topoManage.topoNodeGroup_n81i</c:if><c:if test='${type==3}'>i18n_topoManage.topoNone_n81i</c:if><c:if test='${type==4}'>i18n_topoManage.topoPicture_n81i</c:if>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</td>
										</tr>
										<tr id='topoInfo${status.index}'>
											<td class="color_1" align="right">i18n_topoManage.topoPicture_n81i:</td>
											<td class="color_6"  align="left" colspan='3'>
												<c:if test="${fn:length(allTopoInfoList)>0 }">
													<select id="chooseTopoInfo${status.index}">
														<option selected="selected" value="">
															i18n_topoManage.chooseTopoMessage_n81i
														</option>
														<c:forEach items="${allTopoInfoList }" var="allTopoInfo">
															<c:choose>
																<c:when test='${allTopoInfo.id==topoManageInfo.topoNodeInfo.typeId}'>
																	<option value="${allTopoInfo.id}" name='selectTopoInfoId' selected='selected'/> ${allTopoInfo.name}</option>
																</c:when>
																<c:otherwise>
																	<option value="${allTopoInfo.id}" name='selectTopoInfoId'/> ${allTopoInfo.name}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												</c:if>
											</td>
										</tr>
										<tr id="chooseGroupNode${status.index}" style='display:none'>
											<td class="color_1" width="20%" align="right">
												i18n_topoManage.topoNodeGroup_n81i:
											</td>
											<td class="color_6" width="30%" align="left">
												<input type="text" name="nodeGroupName${status.index}" id='nodeGroupName${status.index }' readonly="readonly" value="${topoManageInfo.nodeGroupName}"/>&nbsp;
												<input type="hidden" name="nodeGroupId${status.index }" id='nodeGroupId${status.index }'  value="${topoManageInfo.nodeGroupId}"/>&nbsp;
												<input type="button" value="i18n_adsi.button.select_n81i" onclick="selectNodeAndNodeGroup(${status.index})"
												    class=btn3_mouseout
													onmouseover="this.className='btn3_mouseover'"
													onmouseout="this.className='btn3_mouseout'"
													onmousedown="this.className='btn3_mousedown'"
													onmouseup="this.className='btn3_mouseup'"
												/>
											</td>
											<td class="color_1" id='topoNodeOne${status.index}'  width="20%" align="right" style='display:none'>
												i18n_topoManage.topoNode_n81i:
											</td>
											<td class="color_6" id='topoNodeTwo${status.index}' width="30%" align="left" style='display:none'>
												<input type="text" name="nodeName${status.index }" id='nodeName${status.index }' readonly="readonly" value="${topoManageInfo.nodeName}"/>&nbsp;
												<input type="hidden" id='nodeId${status.index}' name="nodeId${status.index}"  value="${topoManageInfo.nodeId}"/>&nbsp;
											</td>
										</tr>
									</c:forEach>
									<tr>
									<td colspan="4" align="right" class="td_1" >&nbsp;
										<div id="buttons_add">
											<input type="button" value="i18n_nginfo.button.submit_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitAdd()"/>
											<input type="reset" value="i18n_nginfo.button.reset_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"/>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</c:if>
			</table>
			</form>
			</div>
		</div>
	</body>
</html>
