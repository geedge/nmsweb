<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>i18n_gi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
 		<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script type="text/javascript" src="<%=path%>/js/ui/jquery-ui.min.js"></script>
	<script language="javascript" type="text/javascript">	
	
	//goto业务系统管理
	 function gotoYwxt(){		 	
		document.form3.action ="<%=path%>/sysManage/systemManage.do?action=query";
		document.form3.submit();
	 } 
	//goto用户组
	 function gotoYhz(){		 	
		document.form3.action ="<%=path%>/sysManage/userGroupPerssion.do?action=query";
		document.form3.submit();
	 } 
	//goto机房
	 function gotoJf(){		 	
		document.form3.action ="<%=path%>/nodePosition/roomManage.do?action=query";
		document.form3.submit();
	 } 
	 //goto机柜
	 function gotoJg(){		 	
		document.form3.action ="<%=path%>/nodePosition/boxSet.do?action=query";
		document.form3.submit();
	 } 
	//goto节点组
	 function gotoJdz(){		 	
		document.form3.action ="<%=path%>/nodeGroupManage/nodeGroupManage.do?action=queryNodeGroupInfo";
		document.form3.submit();
	 } 
	 //goto任务
	 function gotoRw(){		 	
		document.form3.action ="<%=path%>/nmstaskManager/nmsTaskManager.do?action=query";
		document.form3.submit();
	 } 
	 //goto监测类别
	 function gotoJclb(){		 	
		document.form3.action ="<%=path%>/detection/checkTypeSet.do?action=query";
		document.form3.submit();
	 } 
	 //goto监测设置
	 function gotoJcsz(){		 	
		document.form3.action ="<%=path%>/detection/detectionSet.do?action=query";
		document.form3.submit();
	 } 
		
	$(function(){
		
		
	});
</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<!--中间部分右边开始-->
			<form name=form3 id="frmArticleType" action="" method="post">
			<input type="hidden" name="fromWhere" value="formGuide"/>
			
			<input type="hidden" name="ywxtCom" value="${ywxtCom }"/>
			<input type="hidden" name="yhzCom" value="${yhzCom }"/>
			<input type="hidden" name="jfCom" value="${jfCom }"/>
			<input type="hidden" name="jdzCom" value="${jdzCom }"/>
			<input type="hidden" name="jgCom" value="${jgCom }"/>
			<input type="hidden" name="rwCom" value="${rwCom }"/>
			<input type="hidden" name="jclbCom" value="${jclbCom }"/>
			<input type="hidden" name="jcszCom" value="${jcszCom }"/>
				<div id="maindiv" style=" width: 100%; height: 98%">
					 i18n_gi.text.title_n81i
					<table>
						<tr>
							<td><!-- 业务系统 -->
								<c:if test="${isywxt == 'yes' }">
									<div style="background-image: url('../images/guide/1.jpg'); width: 96px;height: 58px; text-align: center"  onclick="gotoYwxt();">
										<c:if test="${ywxtCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png"/>" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isywxt != 'yes' }">
									<div style="background-image: url('../images/guide/1-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
								
							</td>
							<td>
								<img src="<c:url value="/images/guide/right.png" />" class="img_middle"/>
							</td>
							<td><!-- 用户组 -->
								<c:if test="${isyhz == 'yes' }">
									<div style="background-image: url('../images/guide/2.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoYhz();">
										<c:if test="${yhzCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isyhz != 'yes' }">
									<div style="background-image: url('../images/guide/2-1.jpg'); width: 96px;height: 58px; text-align: center"></div>
								</c:if>
							</td>
							<td>
								<img src="<c:url value="/images/guide/right.png" />" class="img_middle"/>
							</td>
							<td><!-- 机房 -->
								<c:if test="${isjf == 'yes' }">
									<div style="background-image: url('../images/guide/3.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJf();">
										<c:if test="${jfCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjf != 'yes' }">
									<div style="background-image: url('../images/guide/3-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td align="center"><img src="<c:url value="/images/guide/down.png" />" class="img_middle"/></td>
						</tr>
						<tr>
							<td><!-- 节点 -->
								<c:if test="${isjdz == 'yes' }">
									<div style="background-image: url('../images/guide/4.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJdz();">
										<c:if test="${jdCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjdz != 'yes' }">
									<div style="background-image: url('../images/guide/4-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
							<td>
								<img src="<c:url value="/images/guide/left.png" />" class="img_middle"/>
							</td>
							<td><!-- 节点组 -->
								<c:if test="${isjdz == 'yes' }">
									<div style="background-image: url('../images/guide/5.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJdz();">
										<c:if test="${jdzCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjdz != 'yes' }">
									<div style="background-image: url('../images/guide/5-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
							<td>
								<img src="<c:url value="/images/guide/left.png" />" class="img_middle"/>
							</td>
							<td><!-- 机柜 -->
								<c:if test="${isjg == 'yes' }">
									<div style="background-image: url('../images/guide/6.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJg();">
										<c:if test="${jgCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjg != 'yes' }">
									<div style="background-image: url('../images/guide/6-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<img src="<c:url value="/images/guide/doubleDown.png" />" class="img_middle"/>
							</td>
							<td colspan="2">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td><!-- 任务 -->
								<c:if test="${isrw == 'yes' }">
									<div style="background-image: url('../images/guide/7.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoRw();">
										<c:if test="${rwCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isrw != 'yes' }">
									<div style="background-image: url('../images/guide/7-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
							<td>
								&nbsp;
							</td>
							<td><!-- 监测类别-->
								<c:if test="${isjclb == 'yes' }">
									<div style="background-image: url('../images/guide/8.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJclb();">
										<c:if test="${jclbCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjclb != 'yes' }">
									<div style="background-image: url('../images/guide/8-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
							<td>
								<img src="<c:url value="/images/guide/right.png" />" class="img_middle"/>
							</td>
							<td><!-- 监测类别元数据 -->
								<c:if test="${isjclb == 'yes' }">
									<div style="background-image: url('../images/guide/9.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJclb();">
										<c:if test="${jclbSourceCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjclb != 'yes' }">
									<div style="background-image: url('../images/guide/9-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								&nbsp;
							</td>
							<td align="center">
								<img src="<c:url value="/images/guide/down.png" />" class="img_middle"/>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><!-- 监测设置 -->
								<c:if test="${isjcsz == 'yes' }">
									<div style="background-image: url('../images/guide/10.jpg'); width: 96px;height: 58px; text-align: center" onclick="gotoJcsz();">
										<c:if test="${jcszCom == 'y' }">
											<img src="<c:url value="/images/guide/duigou.png" />" 
												height="14px" width="14px" align="middle" style="margin-top: 43px;"/>
										</c:if>
									</div>
								</c:if>
								<c:if test="${isjcsz != 'yes' }">
									<div style="background-image: url('../images/guide/10-1.jpg'); width: 96px;height: 58px;"></div>
								</c:if>
								
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
