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
		<link href="<c:url value='/js/dtree/css/dtree.css'/>" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="<c:url value='/css/jquery-ui.min.css' />"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/topo-edit.css' />"/>
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/MzTreeView10.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/dtree/js/dtree_checkbox_expand.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-ui.min.js' />"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jtopo-0.4.8_01-min.js' />"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/toolbar.js' />"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/layer.js'/>"></script>
	</head>
	
	<style>
		ul{list-style:none;padding:0;margin:0;}
		ul li{float:left;}
		ul li a{display:block;width:30px;height:30px;cursor:pointer;}
		ul li.none a{background:url(<c:url value='/images/topology/selected-grey.png'/>) center no-repeat;background-size:20px;}
		ul li.normal a{background:url(<c:url value='/images/topology/line11.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-v a{background:url(<c:url value='/images/topology/line13.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-h a{background:url(<c:url value='/images/topology/line12.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-v a{background:url(<c:url value='/images/topology/line14.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-h a{background:url(<c:url value='/images/topology/line15.png' />) center no-repeat;background-size:20px;}
		
		ul li.none a.selected{background:#666 url(<c:url value='/images/topology/selected-white.png' />) center no-repeat;background-size:20px;}
		ul li.normal a.selected{background:#666 url(<c:url value='/images/topology/line01.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-v a.selected{background:#666 url(<c:url value='/images/topology/line03.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-h a.selected{background:#666 url(<c:url value='/images/topology/line02.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-v a.selected{background:#666 url(<c:url value='/images/topology/line04.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-h a.selected{background:#666 url(<c:url value='/images/topology/line05.png' />) center no-repeat;background-size:20px;}
		
		ul li.none:hover a{background:#666 url(<c:url value='/images/topology/selected-grey.png' />) center no-repeat;background-size:20px;}
		ul li.normal:hover a{background:#666 url(<c:url value='/images/topology/line01.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-v:hover a{background:#666 url(<c:url value='/images/topology/line03.png' />) center no-repeat;background-size:20px;}
		ul li.brokenpoly-h:hover a{background:#666 url(<c:url value='/images/topology/line02.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-v:hover a{background:#666 url(<c:url value='/images/topology/line04.png' />) center no-repeat;background-size:20px;}
		ul li.secondarypoly-h:hover a{background:#666 url(<c:url value='/images/topology/line05.png' />) center no-repeat;background-size:20px;}	
	
		#nodeStyleTable tr td:first-child{
		    text-align:right;
		}
		
		#linkStyleTable tr td:first-child{
		    text-align:right;
		}
		
	</style>
	
		
	<script type="text/javascript">
		function selectNodeAndNodeGroup() {
			var nodeType = $('input[name="nodeType"]:checked').val();
			if(nodeType==2){
				$("#chooseType").val(1);
			}else{
				$("#chooseType").val(0);
			}
			var groupId = $('#setNodeGroupId').val();//选中节点组
			var nodeId = $('#setNodeId').val();//选中ip	
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
			document.getElementById("setNodeGroupName").value = nodeGroupNames;//节点组名称s
			document.getElementById("setNodeGroupId").value = nodeGroupIds;//节点组ids
			document.getElementById("setNodeName").value = nodeIps;//节点ips
			document.getElementById("setNodeId").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
		}	
		
		function chooseTopoNodeType(){
			var checkNodeType=$("input[name^='nodeType']:checked").val();
			if(checkNodeType==3){
				$("#setNode").hide();
				$("#setNodeGroup").hide();
				$("#setThresholdValue").hide();
				$("#setTopo").hide();
			}else if(checkNodeType==1){
				$("#setNode").hide();
				$("#setNodeGroup").show();
				$("#setThresholdValue").show();
				$("#setTopo").hide();
			}else if(checkNodeType==2){
				$("#setNode").show();
				$("#setNodeGroup").show();
				$("#setThresholdValue").hide();
				$("#setTopo").hide();
			}else if(checkNodeType==4){
				$("#setNode").hide();
				$("#setNodeGroup").hide();
				$("#setThresholdValue").hide();
				$("#setTopo").show();
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
	
	<body style='overflow-y:auto'>
		<input type='hidden' id='18language' value='${i18n_lang}'/>
		<input type='hidden' id='diffTopoFlag' value='${diffTopoFlag}'/>
		<input type='hidden' id="fw" value='topoManage'/>
		<input type='hidden' id="chooseType" value=''/>
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
			</table>
			</form>
				<div id="container" style='float: left; width: 79%; height: 100%;margin-left:10px;margin-top:10px;'>
			<div id="header" style='margin-left:10px'>
				<div class="jtopo_toolbar" style='margin-left: 20%'>
					<!-- <input type="radio" name="modeRadio" value="normal" checked=""
						id="r1"/> <label for="r1"> 默认&nbsp;<input
						type="radio" name="modeRadio" value="select" id="r2"/><label
						for="r2"> 框选&nbsp;
					<input type="radio" name="modeRadio"
						value="drag" id="r3"><label for="r3"> 平移&nbsp;<input
						type="radio" name="modeRadio" value="edit" id="r4"><label
						for="r4"> 编辑&nbsp;&nbsp; -->
					<input type="button" id="centerButton" value="i18n_topoManage.Centered_n81i"/><input
						type="button" id="fullScreenButton" value="i18n_topoManage.FullScreen_n81i"/><input
						type="button" id="zoomOutButton" value=" i18n_topoManage.Enlarge_n81i"/><input
						type="button" id="zoomInButton" value=" i18n_topoManage.Narrow_n81i "/>&nbsp;&nbsp;<input
						type="checkbox" id="zoomCheckbox"/><label>i18n_topoManage.MouseScaling_n81i</label>&nbsp;&nbsp;
						<!-- <input type="text" id="findText" value="" onkeydown="findButton.click()"/>
						<input type="button" id="findButton" value=" i18n_topoManage.Query_n81i"/>&nbsp;&nbsp; -->
					<!-- <input
						type="button" id="exportButton" value="导出PNG">  -->
					<div style='float: inherit; margin-top: -27px; margin-left: 600px'>
						<ul>
							<li class="none"><a id='noneLink' class="selected"
								onclick="switchLineType(this,'NoneLink','')"></a></li>
							<li class="normal"><a
								onclick="switchLineType(this,'Link','')"></a></li>
							<li class="brokenpoly-v"><a
								onclick="switchLineType(this,'FoldLink','vertical')"></a></li>
							<li class="brokenpoly-h"><a
								onclick="switchLineType(this,'FoldLink','horizontal')"></a></li>
							<li class="secondarypoly-v"><a
								onclick="switchLineType(this,'FlexionalLink','vertical')"></a></li>
							<li class="secondarypoly-h"><a
								onclick="switchLineType(this,'FlexionalLink','horizontal')"></a></li>
						</ul>
					</div>
				</div>
			</div>
			<div
				style='float: left; width: 20%; height: 100%; background-color: white;'>
				<div id='test' class="device_list">
					<c:if test="${fn:length(topoImgList)>0 }">
						<c:forEach items="${topoImgList }" var="topoImg">
							<div class="device ui-draggable ui-draggable-handle" id="${topoImg.id}"
							title="" topoImg='${topoImg.name}' topoImgId='${topoImg.id}'>
							<img src="${pageContext.request.contextPath}/images/newtopo/${topoImg.name}" width="56" height="56"
								draggable="false">
							<p class="overflow_text"></p>
					</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div id="main">
				<div class="content" style='margin-left:10px'>
					<canvas width="825" height="800" id="canvas"
						style="border: 1px solid #444;"/>
				
				</div>
			</div>
		</div>
			<div id='nodeStyle' style='margin-top:10px;display:none;'>
				<form id='nodeInfoForm'>
					<table id='nodeStyleTable' style='border-collapse:separate; border-spacing:0px 10px;'>
						<tr>
							<td>
								i18n_topoManage.topoNodeName_n81i &nbsp
							</td>
							<td>
								<input id='nodeNewName' type='text' onblur='changeNode()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.topoNodeNamePosition_n81i &nbsp
							</td>
							<td>
								<select id='nodePosition' onChange='changeNode8()'>
								<option value="Middle_Center">i18n_topoManage.MiddleCenter_n81i</option>  
								<option value="Middle_Left" >i18n_topoManage.MiddleLeft_n81i</option>  
								<option value="Middle_Right" >i18n_topoManage.MiddleRight_n81i</option>  
								<option value="Bottom_Center" selected='selected'>i18n_topoManage.BottomCenter_n81i</option>  
								<option value="Bottom_Left" >i18n_topoManage.BottomLeft_n81i</option>  
								<option value="Bottom_Right" >i18n_topoManage.BottomRight_n81i</option>  
								<option value="Top_Center" >i18n_topoManage.TopCenter_n81i</option>  
								<option value="Top_Left" >i18n_topoManage.TopLeft_n81i</option>  
								<option value="Top_Right" >i18n_topoManage.TopRight_n81i</option>  
								</select>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.FontColor_n81i  &nbsp
							</td>
							<td>
								<input id='nodeColor' type='color'/>
							</td>
						</tr>
						
						<!-- <input id='nodeFont' type='text' onblur='changeNode2()'/>字体  -->
						<tr>
							<td>
								i18n_topoManage.NodeWidth_n81i  &nbsp
							</td>
							<td>
								<input id='nodeWidth' type='text' onblur='changeNode3()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.NodeHeight_n81i&nbsp
							</td>
							<td>
								<input id='nodeHeight' type='text' onblur='changeNode4()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.NodeX_n81i &nbsp
							</td>
							<td>
								<input id='nodeX' type='text' onblur='changeNode5()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.NodeY_n81i &nbsp
							</td>
							<td>
								<input id='nodeY' type='text' onblur='changeNode6()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.topoNodeType_n81i &nbsp
							</td>
							<td>
								<input  name='nodeType' type='radio' onchange='chooseTopoNodeType()' value='1'/>i18n_topoManage.topoNodeGroup_n81i  </br>
								<input  name='nodeType' type='radio' onchange='chooseTopoNodeType()' value='2'/>i18n_topoManage.topoNode_n81i     </br>
								<input  name='nodeType' type='radio' onchange='chooseTopoNodeType()' value='4'/>i18n_topoManage.topoPicture_n81i </br>
								<input  name='nodeType' type='radio' onchange='chooseTopoNodeType()' value='3' checked="checked"/>i18n_topoManage.topoNone_n81i       
							</td>
						</tr>
						
						<tr id='setNodeGroup'>
							<td>
								i18n_topoManage.topoNodeGroup_n81i &nbsp
							</td>
							<td>
								<input type='hidden' value='' id="setNodeGroupId"/>
								<input readonly='readonly' value="" id="setNodeGroupName"/>
								<input type="button" value="i18n_adsi.button.select_n81i" onclick="selectNodeAndNodeGroup()"
												    class=btn3_mouseout
													onmouseover="this.className='btn3_mouseover'"
													onmouseout="this.className='btn3_mouseout'"
													onmousedown="this.className='btn3_mousedown'"
													onmouseup="this.className='btn3_mouseup'"
												/>
							</td>
						</tr>
											
						<tr id='setNode'>
							<td>
								i18n_topoManage.topoNode_n81i  &nbsp
							</td>
							<td>
								<input type='hidden' value='' id="setNodeId"/>
								<input readonly='readonly' value="" id="setNodeName"/>
							</td>
						</tr>
						
						<tr id='setThresholdValue'>
							<td>
								i18n_topoManage.AlarmThreshold_n81i &nbsp
							</td>
							<td>
								<input id='thresholdValue' type='text' value='80'/>
							</td>
						</tr>
						
						<tr id='setTopo'>
							<td>
								i18n_topoManage.topoPicture_n81i &nbsp
							</td>
							<td>
								<c:if test="${fn:length(allTopoInfoList)>0 }">
									<select id="chooseTopoInfo">
										<option selected="selected" value="-1">
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
						
						<tr>
							<td></td>
							<td colspan=2 align='center'>
								<input id='deleteNode' type='button' onclick='changeNode9()' value='i18n_topoManage.DeleteNode_n81i'/>
							</td>
						</tr>
						<!-- <input id='nodeRotate' type='text' onblur='changeNode7()'/>旋转 -->
					</table>	
				</form>
			</div>	
			
			<div id='linkStyle' style='display:none;margin-top:10px;'>
				<form id='linkInfoForm'>
					<table id='linkStyleTable' style='border-collapse:separate; border-spacing:0px 10px;'>
						<tr id='trLinkShu'> 
							<td>
								i18n_topoManage.LineDeflection_n81i  &nbsp
							</td>
							<td>
								<input id='linkShu' type='text' onblur='changeLink()'/>
							</td>
						</tr>
						
						<tr id='trLinkShu2'> 
							<td>
								i18n_topoManage.LineOffsetGap_n81i  &nbsp
							</td>
							<td>
								<input id='linkShu2' type='text' onblur='changeLink9()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.LineColor_n81i  &nbsp
							</td>
							<td>
								<input id='linkColor' type='color'/> 
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.LineWidth_n81i &nbsp
							</td>
							<td>
								<input id='linkShu3' type='text' onblur='changeLink3()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.LineArrowsRadius_n81i  &nbsp
							</td>
							<td>
								i18n_topoManage.True_n81i &nbsp<input id='linkShu4' name='linkTou' type='radio' onClick='changeLink4()' value='1'/> 
								i18n_topoManage.False_n81i &nbsp<input id='linkShu5' name='linkTou' type='radio' onClick='changeLink4()' value='0' checked='checked'/>
							</td>
						</tr>
						
						<tr id='testCu' style='display: none'>
							<td>
								i18n_topoManage.LineArrowsRadiusSize_n81i &nbsp
							</td>
							<td>
								<input id='linkShu6' type='text' onblur='changeLink5()'/>
							</td>
						</tr>
						
						<tr>
							<td>
								i18n_topoManage.LineDotted_n81i &nbsp
							</td>
							<td>
								i18n_topoManage.True_n81i &nbsp<input id='linkShu7' type='radio' name='linkSx' onClick='changeLink6()' value='1'/>
								i18n_topoManage.False_n81i &nbsp<input id='linkShu9' type='radio' name='linkSx' onClick='changeLink6()' checked='checked' value='0'/>
							</td>
						</tr>
						
						<tr id='testXu' style='display: none'>
							<td>
								i18n_topoManage.LineDottedSize_n81i &nbsp
							</td>
							<td>
								<input id='linkShu8' type='text' onblur='changeLink7()'/>
							</td>
						</tr>
						
						<tr>
							<td></td>
							<td colspan=2 align='center'>
								<input id='deleteLink' type='button' onclick='changeLink8()' value='i18n_topoManage.DeleteLine_n81i'/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			
			
			</div>
		</div>
	</body>
	
	<script type="text/javascript">
		var systemId=$("#system").val();
		var topoInfoId=$('#topo').val();
		var imgagePath="${pageContext.request.contextPath}/images/newtopo/";
		var dqLink = null;
		var dqNode = null;
		var canvas = document.getElementById('canvas');
		var stage = new JTopo.Stage(canvas);
		var scene = new JTopo.Scene(stage);
		var language18n=$('#18language').val();
		//显示工具栏
		showJTopoToobar(stage);

		function newNode(x, y, w, h, text, img,nodeId,imgId) {
			var node = new JTopo.Node(text);
			node.setImage(imgagePath+img, false);
			node.setLocation(x, y);
			node.setSize(w, h);
			node.fillColor='255,128,0';
			node.fontColor='0,0,0';
			node.font='15px 微软雅黑';
			node.addEventListener("mouseup", function(node) {
		    	$("#nodeX").val(parseInt(node.target.x));
		    	$("#nodeY").val(parseInt(node.target.y));
		    	$("#nodeWidth").val(parseInt(node.target.width));
		    	$("#nodeHeight").val(parseInt(node.target.height));
			});
			node.nodeId=nodeId;
			node.serializedProperties.push("nodeId");
			node.imgId=imgId;
			node.serializedProperties.push("imgId");
			scene.add(node);
			return node;
		}

		// 简单连线
		function newLink(nodeA, nodeZ, text,linkId,dashedPattern) {
			var link = new JTopo.Link(nodeA, nodeZ, text);
			link.lineWidth = 3; // 线宽
			link.bundleOffset = 60; // 折线拐角处的长度
			link.bundleGap = 20; // 线条之间的间隔
			link.textOffsetY = 3; // 文本偏移量（向下3个像素）
			link.dashedPattern = dashedPattern;
			link.linkType = "Link";    // 在创建节点的时候添加自定义属性   
			link.serializedProperties.push("linkType");
			link.linkId=linkId;
			link.serializedProperties.push("linkId");
			scene.add(link);
			return link;
		}

		function newFoldLink(nodeA, nodeZ, text,linkId, direction, dashedPattern) {
			var link = new JTopo.FoldLink(nodeA, nodeZ, text);
		    link.direction = direction || 'horizontal';
		    link.lineWidth = 2; // 线宽
		    link.bundleOffset = 40; // 折线拐角处的长度
		    link.bundleGap = 20; // 线条之间的间隔
		    link.textOffsetY = 3; // 文本偏移量（向下3个像素）
		    link.dashedPattern = dashedPattern; 
		    link.strokeColor = '0,0,0';
		    link.fontColor='0,0,0';
		    link.linkType = "FoldLink";    // 在创建节点的时候添加自定义属性   
		    link.serializedProperties.push("linkType");
		    link.linkId=linkId;
			link.serializedProperties.push("linkId");
		    scene.add(link);
		    return link;
		}

		function newFlexionalLink(nodeA, nodeZ, text,linkId, dashedPattern, direction) {
			 var link = new JTopo.FlexionalLink(nodeA, nodeZ, text);
		    link.lineWidth = 2; // 线宽
		    link.bundleGap = 15; // 线条之间的间隔
		    link.textOffsetY = 10; // 文本偏移量（向下15个像素）
		    link.dashedPattern = dashedPattern; 
		    link.direction=direction||'vertical';
		    link.strokeColor = '0,0,0';
		    link.fontColor='0,0,0';
		    link.linkType = "FlexionalLink";    // 在创建节点的时候添加自定义属性   
		    link.serializedProperties.push("linkType");
		    link.linkId=linkId;
			link.serializedProperties.push("linkId");
		    scene.add(link);
		    return link;
		}

		// 线条编辑选择相关
		var beginNode = null;
		var tempNodeA = new JTopo.Node('tempA');
		;
		tempNodeA.setSize(1, 1);
		var tempNodeZ = new JTopo.Node('tempZ');
		;
		tempNodeZ.setSize(1, 1);
		var link = null;
		var linkType = '';
		var lineDirection = '';
		function switchLineType(ele, lineType, direction) {
			if (link != null) {
				scene.remove(link);
			}
			$(ele).closest("ul").find("a").removeClass("selected");
			$(ele).addClass("selected");
			linkType = lineType;
			if (linkType == 'FoldLink') {
				modifyNodeInfo();
				link = new JTopo.FoldLink(tempNodeA, tempNodeZ, lineDirection);
				link.direction = direction;
			} else if (linkType == 'FlexionalLink') {
				modifyNodeInfo();
				link = new JTopo.FlexionalLink(tempNodeA, tempNodeZ, lineDirection);
				link.direction = direction;
			} else if (linkType == 'Link') {
				modifyNodeInfo();
				link = new JTopo.Link(tempNodeA, tempNodeZ);
				link.direction = direction;
			} else {
				link = null;
			}
			if (direction != "") {
				lineDirection = direction;
			}
		}
		
		
		<c:if test="${not empty requestScope.topoManageInfos}">
			//初始化节点
			<c:forEach items="${requestScope.topoManageInfos}" var="item">
		     	var node${item.topoNodeInfo.id} = newNode(${item.topoNodeInfo.x},${item.topoNodeInfo.y},${item.topoNodeInfo.width},${item.topoNodeInfo.height},'${item.topoNodeInfo.text}','${item.topoNodeInfo.topoImg.name}',${item.topoNodeInfo.id},${item.topoNodeInfo.topoImg.id});
		     	node${item.topoNodeInfo.id}.nodeGroupId='${item.nodeGroupId}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeGroupId");
		     	node${item.topoNodeInfo.id}.nodeGroupName='${item.nodeGroupName}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeGroupName");
		     	node${item.topoNodeInfo.id}.nodeType='${item.topoNodeInfo.type}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeType");
		     	node${item.topoNodeInfo.id}.nodeTypeId='${item.topoNodeInfo.typeId}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeTypeId");
		     	node${item.topoNodeInfo.id}.nodeIpName='${item.nodeName}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeIpName");
		     	node${item.topoNodeInfo.id}.nodeNmsId='${item.nodeId}';
		     	node${item.topoNodeInfo.id}.serializedProperties.push("nodeNmsId");
				//设置自己特定的class样式
				<c:if test="${not empty item.topoNodeInfo.topoNodeInfoClass}">
					var classJson=${item.topoNodeInfo.topoNodeInfoClass};
					for(var i=0;i<classJson.length;i++){
						for(var key in classJson[i]){
							node${item.topoNodeInfo.id}[key]=classJson[i][key];
						}
					}
				</c:if>
			</c:forEach>
			
			//初始化连线
			<c:forEach items="${requestScope.topoLineList}" var="item">
			<c:choose>
				<c:when test="${not empty item.topoLineInfoClass}">
					var link${item.id};
					var classJson=${item.topoLineInfoClass};
					for(var i=0;i<classJson.length;i++){
						for(var key in classJson[i]){
							if(key=='newLineMethod'){
								if(classJson[i][key]=='FoldLink'){
									link${item.id}=newFoldLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}',${item.id});
								}else if(classJson[i][key]=='FlexionalLink'){
									link${item.id}=newFlexionalLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}',${item.id});
								}else{
									var link${item.id} = newLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}',${item.id});
								}
							}else{
								link${item.id}[key]=classJson[i][key];
							}
						}
					}
				</c:when>
				<c:otherwise>
					var link${item.id} = newLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}',${item.id});
				</c:otherwise>
			</c:choose>
			</c:forEach>
			//缩放并居中显示
			stage.centerAndZoom();
		</c:if>
		
		

		// topo图拖拽相关
		$(function() {
			//绑定节点名称设置 回车换行的处理
			$("#nodeNewName").keypress(function (e) {
				var start=document.getElementById("nodeNewName").selectionStart;
				var end=document.getElementById("nodeNewName").selectionEnd;
                if (e.which == 13) {
                	var dqInput=$("#nodeNewName");
                	var dqInputVal=$("#nodeNewName").val();
                	var str=dqInputVal.substring(0,start)+"\\n"+dqInputVal.substring(end,dqInputVal.length);
                	$("#nodeNewName").val(str);
                }
			});
			
			$("#test div").draggable({
				appendTo : "body",
				helper : "clone",
				cursor : "pointer",
				cursorAt : {
					top : -5,
					left : -5
				}
			});
			$("#canvas").droppable({
				drop : function(event, ui) {
				scene.addEventListener("mousemove",function(e) {
						var mousePos = { // 鼠标在场景的位置
						x : e.x,
						y : e.y};
						var addNode=newNode(mousePos.x,mousePos.y,60,60,null,ui.draggable[0].attributes['topoImg'].value,null,ui.draggable[0].attributes['topoImgId'].value); //添加节点
						scene.removeEventListener("mousemove"); // 解绑事件
						scene.mousedown(function(e) {
							if (linkType == 'NoneLink'|| linkType == '') {
								return;
							}
							if (e.target == null|| e.target === beginNode|| e.target === link) {
								scene.remove(link);}
						});

						scene.mousemove(function(e) {
							if (linkType == 'NoneLink'|| linkType == '') {
								return;}
							tempNodeZ.setLocation(e.x,e.y);
						});
						if (link != null) {
							scene.remove(link);
						}
						$("#noneLink").click();
						beginNode = null;
						var newNodeInfo ={};
						var topoImg={};
						var topoInfo={};
						topoImg.id=ui.draggable[0].attributes['topoImgId'].value;
						topoInfo.id=topoInfoId;
						newNodeInfo.x=mousePos.x;
						newNodeInfo.y=mousePos.y
						newNodeInfo.width=60;
						newNodeInfo.height=60;
						newNodeInfo.type=3;
						newNodeInfo.topoImg=topoImg;
						newNodeInfo.topoInfo=topoInfo;
						$.ajax({
							type : "get",
							dataType:'json',
							url : "<%=path%>/sysManage/topoManage.do?action=addTopoNode",
							data:{'topoNodeData':JSON.stringify(newNodeInfo)},
							success:function(res){
								//给新增加的节点 赋值id属性
								addNode.nodeId=res;
								addNode.serializedProperties.push("nodeId");
							},
							error:function(){
								scene.remove(newNode);
								alert("i18n_topoManage.handleErrorInfo_n81i");
							}
						})
					});
				}
			});

			// 动态编辑连线相关
			scene.mouseup(function(e) {
				if(dqLink!=null){
					modifyLinkInfo();
				}
				console.log(e.target)
				$('#linkStyle').hide();
				$('#testCu').hide();
				$('#testXu').hide();
				document.getElementById("linkInfoForm").reset();
				$('#trLinkShu').show();
				$('#trLinkShu2').hide();
				if (linkType == 'NoneLink' || linkType == '') {
					if(e.target != null && e.target instanceof JTopo.Node){
						stage.mode='edit';
						dqNode=e.target;
						$('#chooseTopoInfo').val(-1);
						$("#nodeNewName").val(replaceEnter(e.target.text));
						$("#nodePosition").val(e.target.textPosition);
						$('#setNodeId').val(e.target.typeId);
						$('#setNodeName').val(e.target.nodeName);
						$("#setNodeGroupId").val(e.target.nodeGroupId);
						$("#setNodeGroupName").val(e.target.nodeGroupName);
						$("#setNodeId").val(e.target.nodeNmsId);
						$("#setNodeName").val(e.target.nodeIpName);
						//$("input[name^='nodeType']").val(e.target.type);
						$("input:radio[name^='nodeType'][value="+(parseInt(e.target.nodeType))+"]").click(); 
						if(e.target.nodeType==4){
							$('#chooseTopoInfo').val(parseInt(e.target.nodeTypeId))
						}
						chooseTopoNodeType();
						$('#nodeStyle').show();
					}else{
						stage.mode='normal';
						modifyNodeInfo();
					}
					if (e.target != null && e.target instanceof JTopo.Link) {
						dqLink = e.target;
						$('#linkShu').val(e.target.nodeIndex);
						$('#linkShu2').val(e.target.offsetGap);
						$('#linkShu3').val(e.target.lineWidth);
						if(e.target.arrowsRadius!=''&&e.target.arrowsRadius!=undefined){
							$("#linkShu4").attr("checked","checked");
							$("#linkShu5").removeAttr("checked");
							$("#linkShu6").val(e.target.arrowsRadius);
							$("#testCu").show();
						}else{
							$("#linkShu5").attr("checked","checked");
							$("#linkShu4").removeAttr("checked");
						}
						if(e.target.dashedPattern!=''&&e.target.dashedPattern!=undefined){
							$("#linkShu7").attr("checked","checked");
							$("#linkShu9").removeAttr("checked");
							$("#linkShu8").val(e.target.dashedPattern);
							$("#testXu").show();
						}else{
							$("#linkShu9").attr("checked","checked");
							$("#linkShu7").removeAttr("checked");
						}
						$('#linkStyle').show();
						if(e.target.linkType=='Link'){
							$('#trLinkShu').hide();
							$('#trLinkShu2').hide();
						}else if(e.target.linkType=='FoldLink'){
							$('#trLinkShu2').hide();
						}else{
							$('#trLinkShu2').show();
						}
						modifyNodeInfo();
						/* $('#nodeStyle').hide(); */
					}  
					return;
				}
				if (e.button == 2) {
					scene.remove(link);
					return;
				}
				if (e.target != null && e.target instanceof JTopo.Node) {
					if (beginNode == null) {
						beginNode = e.target;
						scene.add(link);
						tempNodeA.setLocation(e.x, e.y);
						tempNodeZ.setLocation(e.x, e.y);
					} else if (beginNode !== e.target) {
						var endNode = e.target;
						var l = null;
						if (linkType == 'FoldLink') {
							l = newFoldLink(beginNode, endNode);
							l.direction = lineDirection;
						} else if (linkType == 'FlexionalLink') {
							l = newFlexionalLink(beginNode, endNode);
							l.direction = lineDirection;
						} else if (linkType = 'Link') {
							l = newLink(beginNode, endNode);
							l.direction = lineDirection;
						} else {
							l = null;
						}
						scene.add(l);
						beginNode = null;
						scene.remove(link);
						//向数据库保存连线信息
						var newLinkInfo ={};
						var node1={};
						var node2={};
						var topoInfo={};
						var lineClassJson=[];
						var lineShu={};
						lineShu.newLineMethod=linkType;
						lineShu.direction=lineDirection;
						lineClassJson.push(lineShu);
						newLinkInfo.topoLineInfoClass=JSON.stringify(lineClassJson);
						topoInfo.id=topoInfoId;
						node1.id=l.nodeA.nodeId;
						node2.id=l.nodeZ.nodeId;
						newLinkInfo.topoNodeInfo1=node1;
						newLinkInfo.topoNodeInfo2=node2;
						newLinkInfo.topoInfo=topoInfo;
						newLinkInfo.flag=1;
						$.ajax({
							type : "get",
							dataType:'json',
							url : "<%=path%>/sysManage/topoManage.do?action=addTopoLine",
							data:{'topoLineData':JSON.stringify(newLinkInfo)},
							success:function(res){
								//将新的连线赋值id属性
								l.linkId=res;
								l.serializedProperties.push("linkId");
							},
							error:function(){
								scene.remove(newNode);
								alert("i18n_topoManage.handleErrorInfo_n81i");
							}
						})

					} else {
						beginNode = null;
					}
				} else {
					if (link != null) {
						scene.remove(link);
					}
					beginNode = null;
					dqLink = null;
					modifyNodeInfo();
				}
			});
		})
		
		//节点相关设置保存
		function modifyNodeInfo(){
			if(dqNode==null){
				$('#nodeStyle').hide();
				document.getElementById("nodeInfoForm").reset();
			}else{
				var typeResult=null;
				var nodeIds=$('#setNodeId').val();
				var groupIds=$('#setNodeGroupId').val();
				var selectTopoInfoId=$("#chooseTopoInfo").val();
				var radioValue=$("input[name^='nodeType']:checked").val();
				if(radioValue==2){
					typeResult=nodeIds;
					if(nodeIds==null||nodeIds==undefined||nodeIds==''){
						alert("i18n_topoManage.topoNodeError1_n81i");
						flag=false;
						dqNode=null;
						$('#nodeStyle').hide();
						document.getElementById("nodeInfoForm").reset();
						return;
					}else if(nodeIds.indexOf(',')!=-1){
						alert("i18n_topoManage.topoNodeError2_n81i");
						flag=false;
						dqNode=null;
						$('#nodeStyle').hide();
						document.getElementById("nodeInfoForm").reset();
						return;
					}
				}else if(radioValue==1){
					typeResult=groupIds;
					if(groupIds==null||groupIds==undefined||groupIds==''){
						alert("i18n_topoManage.topoNodeGroupError1_n81i");
						flag=false;
						dqNode=null;
						$('#nodeStyle').hide();
						document.getElementById("nodeInfoForm").reset();
						return;
					}else if(groupIds.indexOf(',')!=-1){
						alert("i18n_topoManage.topoNodeGroupError2_n81i");
						flag=false;
						dqNode=null;
						$('#nodeStyle').hide();
						document.getElementById("nodeInfoForm").reset();
						return;
					}
				}else if(radioValue==4){
					typeResult=selectTopoInfoId;
					if(selectTopoInfoId==null||selectTopoInfoId==undefined||selectTopoInfoId==''){
						alert("i18n_topoManage.topoNodeInfoError_n81i");
						flag=false;
						dqNode=null;
						$('#nodeStyle').hide();
						document.getElementById("nodeInfoForm").reset();
						return;
					}
				}
				
				// 修改节点属性
				var topoImg={};
				topoImg.id=dqNode.imgId;
				var topoInfo={};
				topoInfo.id=topoInfoId;
				var nodeClassJson={};
				nodeClassJson.textPosition=dqNode.textPosition;
				nodeClassJson.fontColor=dqNode.fontColor;
				var modifyNodeInfo={};
				modifyNodeInfo.id=dqNode.nodeId;
				modifyNodeInfo.topoImg=dqNode.topoImg;
				modifyNodeInfo.type=radioValue;
				modifyNodeInfo.typeId=typeResult;
				modifyNodeInfo.x=dqNode.x;
				modifyNodeInfo.y=dqNode.y;
				modifyNodeInfo.width=dqNode.width;
				modifyNodeInfo.height=dqNode.height;
				// dqNode的名称需要进行转义 不然topo图数据有问题 无法正常显示
				var newNodeName=replaceEnter(dqNode.text);
				modifyNodeInfo.text=newNodeName;
				modifyNodeInfo.topoNodeInfoClass=JSON.stringify(nodeClassJson);
				modifyNodeInfo.thresholdValue=$("#thresholdValue").val();
				modifyNodeInfo.topoImg=topoImg;
				modifyNodeInfo.topoInfo=topoInfo;
				$.ajax({
					type : "get",
					url : "<%=path%>/sysManage/topoManage.do?action=modifyTopoNode",
					data:{'topoNodeData':JSON.stringify(modifyNodeInfo)}
				})
				
				dqNode.nodeGroupName=$("#setNodeGroupName").val();
				dqNode.nodeGroupId=$("#setNodeGroupId").val();
				dqNode.nodeName=$('#setNodeName').val();
				dqNode.nodeId=$('#setNodeId').val();
				dqNode.nodeType=radioValue;
				dqNode.nodeTypeId=typeResult;
				dqNode=null;
				$('#nodeStyle').hide();
				document.getElementById("nodeInfoForm").reset();
			}
		}
		
		//连线相关设置保存
		function modifyLinkInfo(){
			var topoInfo={};
			topoInfo.id=topoInfoId;
			var lineClassJson=[];
			
			var lineShu={};
			lineShu.newLineMethod=dqLink.linkType;
			lineShu.strokeColor=dqLink.strokeColor;
			lineShu.nodeIndex=dqLink.nodeIndex;
			lineShu.offsetGap=dqLink.offsetGap;
			if(dqLink.arrowsRadius!=''&&dqLink.arrowsRadius!=undefined){
				lineShu.arrowsRadius=dqLink.arrowsRadius;
			}
			
			if(dqLink.dashedPattern!=''&&dqLink.dashedPattern!=undefined){
				lineShu.dashedPattern=dqLink.dashedPattern;
			}
			if(linkType!='Link'){
				lineShu.direction=dqLink.direction;
			}
			lineClassJson.push(lineShu);
			
			var modifyLineInfo={};
			var topoNodeInfo1={};
			topoNodeInfo1.id=dqLink.nodeA.nodeId;
			var topoNodeInfo2={};
			topoNodeInfo2.id=dqLink.nodeZ.nodeId;
			modifyLineInfo.topoNodeInfo1=topoNodeInfo1;
			modifyLineInfo.topoNodeInfo2=topoNodeInfo2;
			modifyLineInfo.topoLineInfoClass=JSON.stringify(lineClassJson);
			modifyLineInfo.topoInfo=topoInfo;
			modifyLineInfo.id=dqLink.linkId;
			modifyLineInfo.flag=1;
			$.ajax({
				type : "get",
				dataType : 'json',
				url : "<%=path%>/sysManage/topoManage.do?action=modifyTopoLine",
				data:{'topoLineData':JSON.stringify(modifyLineInfo)}
			})
			dqLink=null;
		}
		
		function changeLink() {
			var v = $('#linkShu').val();
			dqLink.nodeIndex = v;
		}

		document.querySelector("#linkColor").onchange = function() {
			document.getElementById('linkColor').click(); // 必须添加触发click事件否则不能通过点击确定按钮触发更改颜色
			dqLink.strokeColor = hexToRgba(this.value).rgb;
		}
	
		// 颜色数值转换为rgb
		var hexToRgba = function(hex, al) {
			var hexColor = /^#/.test(hex) ? hex.slice(1) : hex, alp = hex === 'transparent' ? 0
					: Math.ceil(al), r, g, b;
			hexColor = /^[0-9a-f]{3}|[0-9a-f]{6}$/i.test(hexColor) ? hexColor
					: 'fffff';
			if (hexColor.length === 3) {
				hexColor = hexColor.replace(/(\w)(\w)(\w)/gi, '$1$1$2$2$3$3');
			}
			r = hexColor.slice(0, 2);
			g = hexColor.slice(2, 4);
			b = hexColor.slice(4, 6);
			r = parseInt(r, 16);
			g = parseInt(g, 16);
			b = parseInt(b, 16);
			return {
				hex : '#' + hexColor,
				alpha : alp,
				rgb : r + ', ' + g + ', ' + b
			};
		};
		//修改线条宽度
		function changeLink3() {
			var v = $('#linkShu3').val();
			dqLink.lineWidth = v;
		}

		//设置线条箭头
		function changeLink4() {
			var v = $('input[name="linkTou"]:checked').val();
			if (v == 0) {
				dqLink.arrowsRadius = null;
				$('#testCu').hide();
			} else {
				$('#testCu').show();
				dqLink.arrowsRadius = 5;
				$('#linkShu6').val(5);
			}
		}
		//修改线条箭头
		function changeLink5() {
			var v = $('#linkShu6').val();
			dqLink.arrowsRadius = v;
		}
		//设置线条是否为虚线
		function changeLink6() {
			var v = $('input[name="linkSx"]:checked').val();
			if (v == 0) {
				$('#testXu').hide();
				dqLink.dashedPattern = null;
			} else {
				$('#testXu').show();
				dqLink.dashedPattern = 5;
				$('#linkShu8').val(5);
			}
		}
		//修改虚线长度
		function changeLink7() {
			var v = $('#linkShu8').val();
			dqLink.dashedPattern = v;
		}
		//删除当前连线
		function changeLink8() {
			$.ajax({
				type : "get",
				url : "<%=path%>/sysManage/topoManage.do?action=removeTopoLine",
				data:{'topoLineId':dqLink.linkId},
				success : function(res) {
					/* scene.remove(dqLink);
					$('#linkStyle').hide();
					$('#testCu').hide();
					$('#testXu').hide();
					document.getElementById("linkInfoForm").reset();
					$('#trLinkShu').show();
					$('#trLinkShu2').hide(); */
					location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
				},
				error:function(){
					alert("i18n_topoManage.handleErrorInfo_n81i");
				}
			})
		}
		//设置折线的偏转长度
		function changeLink9() {
			var v = $('#linkShu2').val();
			dqLink.offsetGap = parseInt(v);
		}
		//设置节点的名称
		function changeNode(){
			var nodeName=$("#nodeNewName").val();
			dqNode.text=nodeName;
		}
		//设置节点的颜色
		document.querySelector("#nodeColor").onchange = function() {
			document.getElementById('nodeColor').click(); // 必须添加触发click事件否则不能通过点击确定按钮触发更改颜色
			dqNode.fontColor = hexToRgba(this.value).rgb;
		}
		
		function changeNode2(){
				
		}
		//设置节点的宽度
		function changeNode3(){
			var nodeWidth=$("#nodeWidth").val();
			if(nodeWidth==null || nodeWidth==undefined || nodeWidth==''){
				return;
			}else{
				dqNode.width=parseInt(nodeWidth);
			}
		}
		//设置节点的高度
		function changeNode4(){
			var nodeHeight=$("#nodeHeight").val();
			if(nodeHeight==null || nodeHeight==undefined || nodeHeight==''){
				return;
			}else{
				dqNode.height=parseInt(nodeHeight);
			}
		}
		// 设置节点的X坐标
		function changeNode5(){
			var nodeX=parseInt($("#nodeX").val());
			var nodeY=parseInt($("#nodeY").val());
			dqNode.setLocation(nodeX,nodeY);
		}
		// 设置节点的Y坐标
		function changeNode6(){
			var nodeX=parseInt($("#nodeX").val());
			var nodeY=parseInt($("#nodeY").val());
			dqNode.setLocation(nodeX,nodeY);
		}
		
		function changeNode7(){
			
		}
		//设置节点文字位置
		function changeNode8(){
			var position=$('#nodePosition').val();
			dqNode.textPosition=position;
		}
		
		//删除节点
		function changeNode9(){
			$.ajax({
				type : "get",
				url : "<%=path%>/sysManage/topoManage.do?action=removeTopoNode",
				data:{'topoNodeId':dqNode.nodeId},
				success : function(res) {
					/* scene.remove(dqNode);
					$('#nodeStyle').hide();
					document.getElementById("nodeInfoForm").reset(); */
					location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
				},
				error:function(){
					alert("i18n_topoManage.handleErrorInfo_n81i");
				}
			})
		}
		
		//替换所有回车换行符 处理节点换行保存的问题
		function replaceEnter(str){
			if(str!=''&&str!=null&&str!=undefined){
				str=str.replace(/\r\n/g,"\\n")  
		        str=str.replace(/\n/g,"\\n"); 
				return str;
			}else{
				return '';
			}
		}

		$(function(){
			scene.mousedown(function(e) {
				if (linkType == 'NoneLink'|| linkType == '') {
					return;
				}
				if (e.target == null|| e.target === beginNode|| e.target === link) {
					scene.remove(link);}
			});

			scene.mousemove(function(e) {
				if (linkType == 'NoneLink'|| linkType == '') {
					return;}
				tempNodeZ.setLocation(e.x,e.y);
			});
			
			var msgWidth='auto';
			if(language18n!=null&&language18n!=''&&language18n!=undefined&&language18n=='ru_RU'){
				msgWidth='400px';
			}
			var diffTopoFlag=$("#diffTopoFlag").val();
			if(diffTopoFlag!=''&&diffTopoFlag==0){
				layer.msg('', {
			        time: 300000, //300s后自动关闭 并且重新返回自身业务系统所在的topo,
			        area:msgWidth,
					shade: 0.8,
			        btn: ['i18n_topoManage.TopoCover_n81i', 'i18n_topoManage.TopoCopy_n81i', 'i18n_topoManage.cancel_n81i'] ,
			        yes: function(index, layero){		        	
			        	layer.msg('',{
							time:20000,
							btn: ['i18n_topoManage.True_n81i', 'i18n_topoManage.False_n81i'],yes: function(index, layero){
								//发送ajax请求 重新处理数据
								$.ajax({
									type : "get",
									url : "<%=path%>/sysManage/topoManage.do?action=coverTopoManage",
									data:{'topoInfoId':topoInfoId,'systemId':systemId},
									success : function(res) {
										location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
									},
									error:function(){
										alert("i18n_topoManage.handleErrorInfo_n81i");
										layer.close(index);
									}
								})						
							  },btn2: function(index, layero){
								  location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
							  },end:function(){
								  location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
							  }
							}
			        	);
			  		}
			  		,btn2: function(index, layero){
						layer.msg('i18n_topoManage.TopoNameSetting_n81i: <input type="text" id="newTopoName"/>',{
							time:20000,
							btn: ['i18n_topoManage.True_n81i', 'i18n_topoManage.False_n81i'],
							yes: function(index, layero){
								//发送ajax请求 重新处理数据
								var newTopoName=$("#newTopoName").val();
								$.ajax({
									type : "get",
									url : "<%=path%>/sysManage/topoManage.do?action=copyTopoManage",
									data:{'topoInfoId':topoInfoId,'systemId':systemId,'newTopoName':newTopoName},
									success : function(res) {
										location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
									},
									error:function(){
										alert("i18n_topoManage.handleErrorInfo_n81i");
										layer.close(index);
									}
								})
							  }
							,btn2: function(index, layero){
								location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
							}
							,end:function(){
								location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
							}
						})
					}
			  		,btn3: function(index, layero){
			  			location.href='<%=path%>/sysManage/topoManage.do?action=query&systemId='+systemId;
					}
			      });
			}
		});
	</script>
</html>
