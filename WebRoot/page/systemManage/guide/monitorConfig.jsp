<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_mc.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/smart_wizard.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.smartWizard-2.0.js'/>"></script>
		<script type="text/javascript">
			$(function(){
				$("#wizard").smartWizard();
			})
			
			//点下一步时的验证
			function checkDate(curStepIdx){
				switch(curStepIdx){
					case 1:
						$("#I2").attr("src","<c:url value='/nodePosition/roomManage.do?action=query'/>");
						break;
					case 2:
						$("#I3").attr("src","<c:url value='/nodePosition/boxSet.do?action=query'/>");
						break;
					case 3:
						//$("#I4").attr("src","<c:url value='/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo&type=config'/>");
						break;
					case 4:
						var nodeGroupId = $("#nodeGroupId").val();
						var isValid = $("#isValid").val();
						if(nodeGroupId == "" || nodeGroupId == null){
							alert("i18n_mc.message.nodeGroupId_n81i");
							return false;
						}
						var src = "<c:url value='/nodeGroupManage/nodeGroupManage.do?action=nodeMgmt&type=config&ids="+nodeGroupId+"&isValid="+isValid+"'/>";
						$("#I5").attr("src",src);
						break;
					case 5:
						var nodeGroupId = $("#nodeGroupId").val();
						var flag = false;
						$.ajax({
						   type: "POST",
						   url: "<c:url value='/nodeGroupManage/nodeGroupManage!getNodeSize.do'/>",
						   data: {nodeGroupId:nodeGroupId},
						   success: function(data){
						     if( data == "" ||data == null ){
						     	flag = true;
						     }
						   }
						});
						if(!confirm("i18n_mc.message.sureNodeExists_n81i")){
							alert("i18n_mc.message.toAddNode_n81i");
							return false;
						}
						if(flag){
							alert("i18n_mc.message.toAddNode_n81i");
							return false;
						}
						$("#I6").attr("src","<c:url value='/detection/checkTypeSet.do?action=query'/>");
						break;
					case 6:
						$("#I7").attr("src","<c:url value='/detection/detectionSet.do?action=query'/>");
						break;
					case 7:
						$("#I8").attr("src","<c:url value='/detection/monitorData.do?action=query'/>");
						break;
				}
				return true;
			}
			function setParameter(nodeGroupId,isValid){
				//alert("nodeGroupId:"+nodeGroupId+"  isValid:"+isValid);
				$("#nodeGroupId").val(nodeGroupId);
				$("#isValid").val(isValid);
			}
			
		</script>
	</head>
	<body style="height: 96%">
		<table width="100%" align="center" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<input type="hidden" id="nodeGroupId" />
					<input type="hidden" id="isValid" />
					<!-- Smart Wizard -->
					<div id="wizard" class="swMain">
						<ul>
							<li>
								<a href="#step-1"> <label class="stepNumber">
										1
									</label> <span class="stepDesc"> i18n_mc.text.userGroup_n81i</span> </a>
							</li>
							<li>
								<a href="#step-2"> <label class="stepNumber">
										2
									</label> <span class="stepDesc"> i18n_mc.text.room_n81i</span> </a>
							</li>
							<li>
								<a href="#step-3"> <label class="stepNumber">
										3
									</label> <span class="stepDesc">i18n_mc.text.box_n81i</span> </a>
							</li>
							<li>
								<a href="#step-4"> <label class="stepNumber">
										4
									</label> <span class="stepDesc"> i18n_mc.text.nodeGroup_n81i</span> </a>
							</li>
							<li>
								<a href="#step-5"> <label class="stepNumber">
										5
									</label> <span class="stepDesc"> i18n_mc.text.node_n81i</span> </a>
							</li>
							<li>
								<a href="#step-6"> <label class="stepNumber">
										6
									</label> <span class="stepDesc"> i18n_mc.text.decateType_n81i</span> </a>
							</li>
							<li>
								<a href="#step-7"> <label class="stepNumber">
										7
									</label> <span class="stepDesc">i18n_mc.text.decateSets_n81i </span> </a>
							</li>
							<li>
								<a href="#step-8"> <label class="stepNumber">
										8
									</label> <span class="stepDesc">i18n_mc.text.decateDate_n81i </span> </a>
							</li>
						</ul>
						<div id="step-1" class="setp_content" style="display: none">
							<iframe name="I1" id="I1" width="99%" height="100%"
								src="<c:url value='/sysManage/userGroupPerssion.do?action=query'/>"
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-2" class="setp_content" style="display: none">
							<iframe name="I2" id="I2" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-3" class="setp_content" style="display: none">
							<iframe name="I3" id="I3" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-4" class="setp_content" style="display: none">
							<iframe name="I4" id="I4" width="99%" height="100%"
								src="<c:url value='/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo&type=config'/>"
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-5" class="setp_content" style="display: none">
							<iframe name="I5" id="I5" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-6" class="setp_content" style="display: none">
							<iframe name="I6" id="I6" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-7" class="setp_content" style="display: none">
							<iframe name="I7" id="I7" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
						<div id="step-8" class="setp_content" style="display: none">
							<iframe name="I8" id="I8" width="99%" height="100%"
								src=""
								border="0" frameborder="0" scrolling="auto">
								i18n_mc.message.brower_n81i
							</iframe>
						</div>
					</div>
					<!-- End SmartWizard Content -->

				</td>
			</tr>
		</table>
	</body>
</html>
