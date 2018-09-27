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
		<title>i18n_detailsys.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree.js'/>"></script>
		<script type="text/javascript">
			function goBack(){
				document.Mkform.action="<%=path%>/sysManage/systemManage.do?action=query";
				document.Mkform.submit();	
			}
			function changeHeight(height,iframeName){
				$("iframe[name="+iframeName+"]").height(height);
			}
			function showTipMsg(msg) {
				var tipMsg = ["<html >"];
				tipMsg.push("<body style='background:#EBECEB;font-size:12px;'>");				
				tipMsg.push("<head>");
		        tipMsg.push("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />");//防止显示中文时的乱码
				tipMsg.push("</head>");		        		
				tipMsg.push("<div align='left'>");
				tipMsg.push(msg);
				tipMsg.push("</div>");
				tipMsg.push("</body>");
				tipMsg.push("</html>");
				return tipMsg.join("");			
			}
		</script>
	</head>
	<body >
		<div class="box_2">		
			<input type="button" class=btn3_mouseout
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="goBack()" value="i18n_detailsys.button.back_n81i"/>
		 </div>
			<form action="" name="Mkform" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="sysName" id="sysName" value="${sysName }" />
				<input type="hidden" name="sysDesc" id="sysDesc" value="${sysDesc }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<div style="clear: both" />
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_detailsys.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_detailsys.text.systemName_n81i：
						</td>
						<td class="color_3" align="left" width="30%">
							${system.systemName }
						</td>
						<td class="color_1" align="right" width="20%">
							i18n_detailsys.text.systemDesc_n81i：
						</td>
						<td class="color_3" align="left">
							${system.systemDesc }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_detailsys.text.systemCreatetime_n81i：
						</td>
						<td class="color_3" align="left">
							<fmt:formatDate value="${system.systemCreatetime}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td class="color_1" align="right">
							i18n_detailsys.text.systemState_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${system.systemState=='0' }">i18n_detailsys.message.systemState0_n81i</c:if>
							<c:if test="${system.systemState=='1' }">i18n_detailsys.message.systemState1_n81i</c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_detailsys.text.isMaster_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${system.isMaster=='2' }">i18n_addsysinfo.text.slave_n81i</c:if>
							<c:if test="${system.isMaster=='1' }">i18n_addsysinfo.text.master_n81i</c:if>
						</td>
						<td class="color_1" align="right">
							&nbsp;
						</td>
						<td class="color_3" align="left">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="color_1" valign="top" align="left">
							<strong>i18n_addsysinfo.text.sysUserGroup_n81i</strong>
							<div class="dtree"
								style="OVERFLOW-Y: none; width: 100%;">
								<a href="javascript: d1.openAll();">i18n_addsysinfo.text.openAll_n81i</a> |
								<a href="javascript: d1.closeAll();">i18n_addsysinfo.text.closeAll_n81i</a>
								<script type="text/javascript">
									d1 = new dTree('d1');
							        <%
							        	List userTreeList = (List)request.getAttribute("userResTree");
							        	List userList = MakeTree.getAllResourceList(userTreeList);
							        	if(userList != null && userList.size() > 0){
							       			Resource res = new Resource();
							       			for( int i = 0 ; i < userList.size() ; i++ ){
							        			res = (Resource) userList.get(i);
										        if(res.getRsaddress() == null || "".equals(res.getRsaddress())){
						        	%>
						        					d1.add('<%=res.getRsCode()%>','<%=res.getParRsCode()%>','<%=res.getRsname()%>','');
						        	<%
						        				}else{
						        	%>
						        					d1.add('<%=res.getRsCode()%>','<%=res.getParRsCode()%>','<%=res.getRsname()%>','<%=path%><%=res.getRsaddress()%>','','I1');
						        	<%			}
						        			}
							        	}
							        %>
							       document.write(d1);
								</script>
							</div>
							<br />
						</td>
						<td bgcolor="#EBECEB" colspan="3" align="center" valign="top" class="color_10">
						<iframe name="I1" height="100%" width="100%" border="0"
								frameborder="0" src="javascript:parent.showTipMsg('
																			i18n_addsysinfo.message.showTipMsg_n81i
																');" scrolling="no">
								i18n_addsysinfo.message.brower_n81i
							</iframe>
						</td>
					</tr>
					<tr>
						<td class="color_1" valign="top"  align="left">
							<strong>i18n_addsysinfo.text.sysUserGroup_n81i</strong>
							<div class="dtree"
								style="OVERFLOW-Y: none; width: 100%;">
								<!--<a href="javascript: d.openAll();">打开所有</a> | <a href="javascript: d.closeAll();">关闭所有</a>  -->
								<script type="text/javascript">
									d2 = new dTree('d2');
							        <%
							        	List treeList = (List)request.getAttribute("nodeResTree");
							        	List list = MakeTree.getAllResourceList(treeList);
							        	if(list != null && list.size() > 0){
								       		Resource resource = new Resource();
								       		for( int j = 0 ; j < list.size() ; j++ ){
							        			resource = (Resource) list.get(j);
							        			if(resource.getRsaddress() == null || "".equals(resource.getRsaddress())){
						        	%>
						        					d2.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','');
						        	<%
						        				}else{
						        	%>
						        					d2.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','<%=path%><%=resource.getRsaddress()%>','','I2');
						        	<%			}
						        			}
							        	}
							        %>
							       document.write(d2);
								</script>
							</div>
							<br />
						</td>
						<td bgcolor="#EBECEB" colspan="3" align="center" valign="top" class="color_10" >
							<div align="left"  style="">
							</div> 
							<iframe name="I2" height="100%" width="100%" border="0"
								frameborder="0" src="javascript:parent.showTipMsg('
																			i18n_addsysinfo.message.showTipMsg2_n81i
																');" scrolling="no" >
								i18n_addsysinfo.message.brower_n81i
							</iframe>
						</td>
					</tr>
				</table>
			</form>
	</body>
</html>
