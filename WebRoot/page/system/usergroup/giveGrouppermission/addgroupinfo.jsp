<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ page import="nis.nms.core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_agi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<!-- <link rel="StyleSheet" href="<c:url value='/dtree/css/dtree.css" type="text/css'/>" /> -->
		<link href="<c:url value='/js//dtree/css/dtree.css'/>" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<c:url value='/dtree/js/dtree_checkbox.js'/>"></script>	
		<script type="text/javascript">
			
			
		function ajaxCheck(){
		   var type;
				$.ajax({
					url:"<c:url value='/'/>sysManage/userGroupPerssion.do?action=AjaxCheck",
					type : "POST",
					async:false,
					data:$('#jsForm').serialize(),
					success : function(data) {
						if(data == "error"){
							alert("i18n_agi.message.jsFormError_n81i");
							type = false;
						}else if(data == "exception"){
							alert("i18n_agi.message.jsFormException_n81i");
							type = false;
						}else if(data =="success"){
							type = true;
						}
					}
				}); 
				return type;  
		   }
			
			 function add(){
			 	if($id("jsmc","","i18n_agi.text.jsmc_n81i")){
			 		if(checkSpecial($.trim($("#jsmc").val()))){
			    	 	$("#jsmc").next().html("i18n_agi.message.jsmc_n81i");
			    	 	return;
			    	}
			 		var values=document.getElementsByName("mkid");
					var checkedValues='';
					for(i = 0; i < values.length; i++ ){
						if (values[i].checked==true ){
							checkedValues +=values[i].value+",";
						}
					}
					if(checkedValues==''){
						$("#sys").html('i18n_agi.message.sys_n81i');
						return ;
					}	
					if(ajaxCheck()){
						document.jsForm.action="<c:url value='/'/>sysManage/userGroupPerssion.do?action=addgroupInfo";
						document.jsForm.submit();					
					}				  
			 	}		
			}
			function goBack(){
				document.jsForm.action="<c:url value='/'/>sysManage/userGroupPerssion.do?action=query";
				document.jsForm.submit();	
			}
			
	    </script>
	</head>
	<body>
	<div class="middle_list">
		<div class="box_2">	
			<input type="button" value="i18n_agi.button.back_n81i"
				class=btn3_mouseout onclick="javaScript:goBack();"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"/>
		 </div>
		 <div style="height: 25px"></div>
		<form action="" name="jsForm" id="jsForm" method="post">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<table border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
					<td class="color_top" colspan="2">
						<strong>i18n_agi.text.title_n81i</strong>	
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">i18n_agi.text.jsmc_n81i：</td>
					<td class="color_3" align="left">
						<input type="text" name="role.jsmc" id="jsmc"/>
						<font color="red">*</font>
					</td>
				</tr>												
				<tr>
					<td class="color_1" align="right">i18n_agi.text.jsms_n81i：</td>
					<td class="color_3" align="left">
						<textarea name="role.jsms" id="jsms" rows="4" cols="40" ></textarea>
					</td>
				</tr>
				<tr>
						<td class="color_1" align="right">
							i18n_agi.text.state_n81i：
						</td>
						<td class="color_3" align="left">
							i18n_agi.text.using_n81i
						</td>
					</tr>				 
					<tr>
						<td class="color_1" align="right">
							i18n_agi.text.selectSys_n81i<font color="red">*</font>
						</td>
						<td class="color_3" colspan="3" align="left">
						<font color="red" id="sys"></font>
						<div id="tree" name="tree"
									style="OVERFLOW-Y: auto; width: 100%;">
										<script type="text/javascript">
											d = new dTree('d');
											d.add('0','-1','i18n_agi.text.systemList_n81i');
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
					<td colspan="2" align="right" class="color_1">
						<input type="button" onclick="add()" value="i18n_agi.button.submit_n81i"
								class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"/>
							&nbsp;
							<input type="button" value="i18n_agi.button.reset_n81i"
								class=btn3_mouseout onclick="javascript:jQuery('#jsForm')[0].reset();"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"/>
					</td>
				</tr>
			</table>
		</form>	
	</div>
	</body>
</html>