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
		<title>i18n_aji.message.title_n81i</title>
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
			function add(){
			 	if($id("jsmc","","i18n_aji.text.jsmc_n81i")){
			 		if(checkSpecial($("#jsmc").val())){
						$("#jsmc").next().html("i18n_aji.message.jsmc_n81i");
						return;
					}
			 		var values=document.getElementsByName("mkid");
					var checkedValues='';
					for( var i = 0; i < values.length; i++ ){
						if (values[i].checked==true ){
							checkedValues +=values[i].value+",";
						}
					}
					if(checkedValues==''){
						$('#mk').html("i18n_aji.message.mk_n81i");
						return ;
					}
					//判断此角色名是否已经存在，不允许角色重名
					$.post("<c:url value='/'/>sysManage/sysPopedomManage!checkRoleIsExisted.do",{roleName:$("#jsmc").val()},function(datas){checkRoleIsExisted(datas);},"json");
			 	}		
			}  
			
			//判断角色名是否已存在，不存在再提交
			function checkRoleIsExisted(datas) {
			    if(datas.hasExisted=="false") {
					document.jsForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=addJsInfo";
					document.jsForm.submit();
			    } else {
			    	$("#jsmc").next().html("i18n_aji.message.jsmcInput_n81i");
			        $("#jsmc").focus();
			        return;
			    }
			}
			function goBack(){		
				document.jsForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryJsInfo";
				document.jsForm.submit();	
			}
		</script>
	</head>
	<body>
	<div class="box_2">		
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'" onclick="goBack()" value="i18n_aji.button.back_n81i"/>
			 </div>
		<div class="middle_list">
			<form action="" name="jsForm" method="post">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<!-- <div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 系统配置 —> 角色管理 —> 新增角色信息
				</div>
				<div style="clear: both"></div> -->
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="2" class="color_8">
							<strong>i18n_aji.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_aji.text.jsmc_n81i：
						</td>
						<td class="color_6" width="50%" align="left">
							<input type="text" name="role.jsmc" id="jsmc"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_aji.text.jsms_n81i：
						</td>
						<td class="color_6" align="left">
							<textarea rows="4" cols="40" name="role.jsms" id="jsms"
								></textarea>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_aji.text.state_n81i：
						</td>
						<td class="color_6" align="left">
							i18n_aji.text.using_n81i
						</td>
					</tr>		
					<tr>
						<td class="color_1" align="right" valign="top">
							i18n_aji.message.selectMk_n81i：
						</td>
						<td class="color_6" align="left">
						<font color="red" id="mk"></font>
						<div id="tree" name="tree"
									style="OVERFLOW-Y: auto; width: 100%;">
										<script type="text/javascript">
											d = new dTree('d');
											d.add('0','-1','i18n_aji.message.mkMenu_n81i<font color="red">*</font>');
									        <%
									        	List treeList = (List)request.getAttribute("treeList");
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
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_aji.button.submit_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['jsForm'].reset()" value="i18n_aji.button.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
