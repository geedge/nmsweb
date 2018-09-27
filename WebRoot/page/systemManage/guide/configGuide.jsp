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
		<title>i18n_cg.message.title_n81i</title>
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
			
		</script>
	</head>
	<body>
		<table width="100%" align="center" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<!-- Smart Wizard -->
					<div id="wizard" class="swMain">
						<ul>
							<li>
								<a href="#step-1"> <label class="stepNumber">
										1
									</label> <span class="stepDesc"> i18n_cg.text.userGroup_n81i</span> </a>
							</li>
							<li>
								<a href="#step-2"> <label class="stepNumber">
										2
									</label> <span class="stepDesc"> i18n_cg.text.room_n81i</span> </a>
							</li>
							<li>
								<a href="#step-3"> <label class="stepNumber">
										3
									</label> <span class="stepDesc"> i18n_cg.text.box_n81i</span> </a>
							</li>
							<li>
								<a href="#step-4"> <label class="stepNumber">
										4
									</label> <span class="stepDesc"> i18n_cg.text.box_n81i<br /> 
									<small>i18n_cg.text.indecate_n81i</small> </span> </a>
							</li>
							<li>
								<a href="#step-5"> <label class="stepNumber">
										5
									</label> <span class="stepDesc"> i18n_cg.text.mission_n81i</span> </a>
							</li>
							<li>
								<a href="#step-6"> <label class="stepNumber">
										6
									</label> <span class="stepDesc"> i18n_cg.text.decateType_n81i</span> </a>
							</li>
							<li>
								<a href="#step-7"> <label class="stepNumber">
										7
									</label> <span class="stepDesc"> i18n_cg.text.decateDate_n81i</span> </a>
							</li>
							<li>
								<a href="#step-8"> <label class="stepNumber">
										8
									</label> <span class="stepDesc"> i18n_cg.text.decateSets_n81i</span> </a>
							</li>
						</ul>
						<div id="step-1" class="setp_content">
							<iframe name="I1" width="100%" height="100%"
								src="<c:url value='/sysManage/userGroupPerssion.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-2" class="setp_content">
							<iframe name="I2" width="100%" height="100%"
								src="<c:url value='/nodePosition/roomManage.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-3" class="setp_content">
							<iframe name="I3" width="100%" height="100%"
								src="<c:url value='/nodePosition/boxSet.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-4" class="setp_content">
							<iframe name="I4" width="100%" height="100%"
								src="<c:url value='/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-5" class="setp_content">
							<iframe name="I5" width="100%" height="100%"
								src="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-6" class="setp_content">
							<iframe name="I6" width="100%" height="100%"
								src="<c:url value='/detection/checkTypeSet.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-7" class="setp_content">
							<iframe name="I7" width="100%" height="100%"
								src="<c:url value='/detection/monitorData.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
						<div id="step-8" class="setp_content">
							<iframe name="I8" width="100%" height="100%"
								src="<c:url value='/detection/detectionSet.do?action=query'/>"
								border="0" frameborder="0" scrolling="no">
								i18n_cg.message.brower_n81i
							</iframe>
						</div>
					</div>
					<!-- End SmartWizard Content -->

				</td>
			</tr>
		</table>
	</body>
</html>
