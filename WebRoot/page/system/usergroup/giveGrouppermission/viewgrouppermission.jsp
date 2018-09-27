<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ page import="nis.nms.core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_vgp.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<link rel="StyleSheet" href="<c:url value='/dtree/css/dtree.css" type="text/css'/>" />
		<script type="text/javascript" src="<c:url value='/js/dtree/js/dtree.js'/>"></script>	
		<script type="text/javascript">
			function goBack(pageNo,pageSize){
				
				document.parentWindow.location="<c:url value='/'/>sysManage/userGroupPerssion.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize;
			}
			
			function SetWinHeight(obj){ 
				var win=obj; 
				win.height =0;
				if (document.getElementById) 
				{
					if (win && !window.opera) 
					{ 
						if(win.Document && win.Document.body.scrollHeight) 
							win.height = win.Document.body.scrollHeight;
						else if (win.contentDocument && win.contentDocument.body.offsetHeight) 
							win.height = win.contentDocument.body.offsetHeight; 
					} 
				} 
			} 	
			
			$(function() {
			    document.jsForm.action="<c:url value='/'/>sysManage/systemManage!getGroupUser.do?userGroupId=${listJsInfo[0].jsbh}";
				document.jsForm.submit();
			});
	    </script>
	</head>
	<body>
	<div class="middle_list">
		<div class="box_2">	
			<input type="button" value="i18n_vgp.button.back_n81i" class=btn3_mouseout
				onclick="javaScript:goBack('${pageNo }','${pageSize }');"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'" />
		 </div>
		<form action="<c:url value='/sysManage/systemManage!getGroupUser.do?userGroupId=${listJsInfo[0].jsbh}'/>" name="jsForm" id="jsForm" method="post" target="I11">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
				<table border="0" cellpadding="0" cellspacing="0" class="table" >
					<tr>
						<td class="color_top" colspan="4">
							<strong>i18n_vgp.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_vgp.text.userGroup_n81i：
						</td>
						<td class="color_3" align="left" width="28%">
							<input name="role.jsbh" value="${listJsInfo[0].jsbh }"
								type="hidden">
							${listJsInfo[0].jsmc }
						</td>
						<td class="color_1" align="right" width="15%">
							i18n_vgp.text.state_n81i：
						</td>
						<td class="color_3" align="left" >
							<input name="role.type" value="1" type="hidden" />
							<c:if test="${listJsInfo[0].zxbz==0}"> <font size=2>i18n_vgp.message.state0_n81i</font>&nbsp; </c:if>
							<c:if test="${listJsInfo[0].zxbz==1}"> <font size=2>i18n_vgp.message.state1_n81i</font>&nbsp; </c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_vgp.text.userGroupDesc_n81i：
						</td>
						<td class="color_3" align="left" >
							<div style="word-break:break-all;word-wrap:break-word;"> ${listJsInfo[0].jsms}</div>
						</td>
						<td class="color_1" align="right">
							i18n_vgp.text.systemId_n81i：
						</td>
						<td class="color_3" valign="top" align="left">
							<div id="tree" name="tree"
								style="OVERFLOW-Y: auto; width: 100%; text-align: left;">
								<script type="text/javascript">
								d = new dTree('d');
								d.add('0','-1','i18n_vgp.message.systemId_n81i');
						        <%
						        	List treeList = (List)request.getAttribute("listresources");
						        	List list = MakeTree.getAllResourceList(treeList);
						        	if(list != null && list.size() > 0){
						       		Resource resource = new Resource();
						       		for( int i = 0 ; i < list.size() ; i++ ){
						        			resource = (Resource) list.get(i);
						        			if(resource.getChecked()!=null && !"".equals(resource.getChecked())){
											%>
						        	        	d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>');
											<% 
						        			}
						        				
						        	}
						        }
						        %>
				       			document.write(d);
							</script>
							</div>
						</td>
					</tr>
					<tr>
						<td class="color_top" colspan="4">
							<strong>i18n_vgp.text.userGroupInfo_n81i</strong>
						</td>
					</tr>
					<tr >
					   <td colspan="4"  >
					       <iframe name="I11" height="0" width="100%" frameborder="0" 
					       			src="" scrolling="no" onload="SetWinHeight(this)">
							i18n_bgp.message.brower_n81i
							</iframe>
						</td>
					</tr>					
				</table>
			</form>	
	</div>
	</body>
</html>