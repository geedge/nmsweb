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
		<title>i18n_upsysinfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
		
		function updateCheck(){
			var type;
			$.ajax({
				url:"<%=path%>/sysManage/systemManage.do?action=updateCheck",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "error"){
						alert("i18n_upsysinfo.message.repeat_n81i");
						type = false;
					}else if(data == "exception"){
						alert("i18n_upsysinfo.message.faild_n81i");
						type = false;
					}else if(data =="success"){
						type = true;
					}
				}
			}); 
			return type;  
		}
		
			function add(){
				//验证不能空与长度限制
			    if($id("systemName","","i18n_upsysinfo.text.systemName_n81i") && $("#systemName").checkByteLength(64,"i18n_upsysinfo.text.systemName_n81i")
			    	 && $("#systemDesc").checkByteLength(256,"i18n_upsysinfo.text.systemDesc_n81i")){
			    	if(checkSpecial($.trim($("#systemName").val()))){
			    	 	$("#systemName").next().html("i18n_upsysinfo.message.systemName_n81i");
			    	 	$("#systemName").val($("#oldsysName").val());
			    	 	return;
			    	 }
			    	 if(updateCheck()){
						document.Mkform.action="<%=path%>/sysManage/systemManage.do?action=doUpdate";
						document.Mkform.submit();			    	 
			    	 }	    	
				}	
			}
			
			function goBack(){
				window.location="<%=path%>/sysManage/systemManage.do?action=query&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';	
			}
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
					onclick="goBack()" value="i18n_upsysinfo.button.back_n81i"/>
			 </div>
			<input type="hidden" id="oldsysName" value="${system.systemName }" />
			<form action="" name="Mkform" method="post" id="Mkform">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="system.systemId" value="${system.systemId }" />
				<input type="hidden" name="sysName" id="sysName" value="${sysName }" />
				<input type="hidden" name="sysDesc" id="sysDesc" value="${sysDesc }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				
				<input type="hidden" name="system.systemIp"	value="${system.systemIp }" id="systemIp" />
				<input type="hidden" name="system.systemPort"	value="${system.systemPort }" id="systemPort" />
				<input type="hidden" name="system.isMaster"	value="${system.isMaster }" id="isMaster" />
				
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_upsysinfo.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_upsysinfo.text.systemName_n81i：
						</td>
						<td class="color_6" width="50%" align="left">
							<input type="text" name="system.systemName"
								value="${system.systemName }" id="systemName"
								style="width: 155px;"  />
								<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_upsysinfo.text.systemDesc_n81i：
						</td>
						<td class="color_3" align="left">
							<textarea rows="4" cols="40" name="system.systemDesc"
								id="systemDesc" style="width: 155px; height: 50px;"
								>${system.systemDesc }</textarea>
						</td>
					</tr>
					<!-- 
					<tr>
						<td class="color_1" align="right">
							注册IP：
						</td>
						<td class="color_3" align="left">
							${system.systemIp }
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							注册端口：
						</td>
						<td class="color_3" align="left">
							${system.systemPort }
						</td>
					</tr>
					 -->
					<tr>
						<td class="color_1" align="right">
							i18n_upsysinfo.text.isMaster_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${system.isMaster == 2}">i18n_upsysinfo.text.slave_n81i</c:if>
							<c:if test="${system.isMaster == 1}">i18n_upsysinfo.text.master_n81i</c:if>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_upsysinfo.text.isOnline_n81i：
						</td>
						<td class="color_3" align="left">
							<input type="radio" name="system.systemState" id="ss0" value="0" 
							       <c:if test="${system.systemState == '0'}">checked="checked"</c:if>
							      />i18n_upsysinfo.message.Y_n81i
							<input type="radio" name="system.systemState" id="ss1" value="1" 
							       <c:if test="${system.systemState == '1'}">checked="checked"</c:if>
							      />i18n_upsysinfo.message.N_n81i
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_upsysinfo.text.selectUser_n81i：
						</td>
						<td class="color_6" align="left">
							<div id="tree" name="tree"
									style="OVERFLOW-Y: auto; width: 100%;">
										<script type="text/javascript">
											d = new dTree('d');
											d.add('0','-1','i18n_upsysinfo.message.selectUser_n81i');
									        <%
									        	List treeList = (List)request.getAttribute("userGroupTree");
									        	List list = MakeTree.getAllResourceList(treeList);
									        	if(list != null && list.size() > 0){
									       		Resource resource = new Resource();
									        		for( int i = 0 ; i < list.size() ; i++ ){
									        			resource = (Resource) list.get(i);        				
									        			if(resource.getChecked()!=null && !"".equals(resource.getChecked())){
									               		%>
									        	        		d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','checked');
									           	        <%          			
									        			}else{
									        		    %>
									    	        		d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','');
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
						<td class="color_7" colspan="4" align="right">
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_upsysinfo.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Mkform'].reset()" value="i18n_upsysinfo.button.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
