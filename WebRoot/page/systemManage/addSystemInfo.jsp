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
		<title>i18n_addsysinfo.message.title_n81i</title>
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
		
		
		function ajaxCheck(){
			var type;
			$.ajax({
				url:"<%=path%>/sysManage/systemManage.do?action=AjaxCheck",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "error"){
						alert("i18n_addsysinfo.message.sysExists_n81i");
						type = false;
					}else if(data == "exception"){
						alert("i18n_addsysinfo.message.faild_n81i");
						type = false;
					}else if(data =="success"){
						type = true;
					}
				}
			}); 
			return type;  
		}
		
			function add(){
				//去空格
				$("#systemName").val($.trim($("#systemName").val()));
				//验证不能空与长度限制
			    if($id("systemName","","i18n_addsysinfo.text.systemName_n81i") && $("#systemName").checkByteLength(64,"i18n_addsysinfo.text.systemName_n81i")
			    	 && $("#systemDesc").checkByteLength(256,"i18n_addsysinfo.text.systemDesc_n81i")
			    	 && $id("systemIp","ip","i18n_addsysinfo.text.systemIp_n81i")
			    	 && $id("systemPort","port","i18n_addsysinfo.text.systemPort_n81i")){			    	 
			    	 if(checkSpecial($.trim($("#systemName").val()))){
			    	 	$("#systemName").next().html("i18n_addsysinfo.message.systemName_n81i");
			    	 	return;
			    	 }
			    	if(ajaxCheck()){
						document.Mkform.action="<%=path%>/sysManage/systemManage.do?action=doAdd";
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
					onclick="goBack()" value="i18n_addsysinfo.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="fromWhere" value="${fromWhere }"/>
				<!-- 
				<div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 业务系统管理 -> 添加业务系统
				</div> -->
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_addsysinfo.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="30%" align="right">
							i18n_addsysinfo.text.systemName_n81i：
						</td>
						<td class="color_6" width="70%" align="left">
							<input type="text" name="system.systemName" id="systemName" style="width: 155px;"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_addsysinfo.text.systemDesc_n81i：
						</td>
						<td class="color_6" align="left" valign="top">
							<textarea rows="4" cols="40" name="system.systemDesc"
								id="systemDesc" style="width: 155px; height: 50px;"
								></textarea>
						</td>
					</tr>
					<c:if test="${systemNum==0}">
						<tr>
							<td class="color_1" align="right">
								i18n_addsysinfo.text.systemIp_n81i：
							</td>
							<td class="color_3" align="left">
								<input type="text" name="system.systemIp"
									value="" id="systemIp"
									style="width: 155px;"  />
									<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="color_1" align="right">
								i18n_addsysinfo.text.systemPort_n81i：
							</td>
							<td class="color_3" align="left">
								<input type="text" name="system.systemPort"
									value="" id="systemPort"
									style="width: 155px;"  />
									<font color="red">*</font>
							</td>
						</tr>
					</c:if>
					<c:if test="${systemNum==0}">
						<tr>
							<td class="color_1" align="right">
								i18n_addsysinfo.text.isMaster_n81i：
							</td>
							<td class="color_3" align="left">
								i18n_addsysinfo.text.master_n81i
								<input type="hidden" name="system.isMaster" value="1" /><!-- 主控系统 -->
							</td>
						</tr>
					</c:if>
					<c:if test="${systemNum!=0}">
						<tr>
							<td class="color_1" align="right">
								i18n_addsysinfo.text.isMaster_n81i：
							</td>
							<td class="color_3" align="left">
								i18n_addsysinfo.text.slave_n81i
								<input type="hidden" name="system.isMaster" value="2" /><!-- 子系统 -->
							</td>
						</tr>
					</c:if>
					<tr>
						<td class="color_1" align="right">
							i18n_addsysinfo.text.isOnline_n81i：
						</td>
						<td class="color_3" align="left">
							i18n_addsysinfo.message.Y_n81i
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_addsysinfo.text.selectUserGroup_n81i：
						</td>
						<td class="color_6" colspan="3" align="left">
						<div id="tree" name="tree"
									style="OVERFLOW-Y: auto; width: 100%;">
										<script type="text/javascript">
											d = new dTree('d');
											d.add('0','-1','i18n_addsysinfo.text.userGroupList_n81i');
									        <%
									        	List treeList = (List)request.getAttribute("userGroupTree");
									        	List list = MakeTree.getAllResourceList(treeList);
									        	if(list != null && list.size() > 0){
									       		Resource resource = new Resource();
									        		for( int i = 0 ; i < list.size() ; i++ ){
									        			resource = (Resource) list.get(i);        				
									        			%>
									        					d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','');
									        			<%
									        		}
									        	}
									        %>
											document.write(d);
									</script>
							</div>
						</td>
					</tr>

					<tr>
						<td class="color_7" colspan="2" align="right">
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_addsysinfo.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Mkform'].reset()" value="i18n_addsysinfo.text.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
