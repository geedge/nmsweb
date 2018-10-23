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
		<title>i18n_uu.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox_multi_choose.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
			function doUpdate(yhid,yhbh){
				$("#js").html('*');
				$("#yhz").html('*');
				$("#bm").html('*');
				var emailFlag=${session.emailFlag==0 };
				if($id("yhmc","","i18n_uu.text.yhmc_n81i") && $id("email","","E-mail")){
					if(containSpecial($("#yhmc").val())){
			    		$("#yhmc").next().html("i18n_uu.message.yhmc_n81i");
			    		$("#yhmc").val($("#cna").val());
			    		return;
			    	}
					if(emailFlag&&!checkEmail(document.getElementById("email").value.toLowerCase())){
						$("#email").next().html('i18n_uu.message.email_n81i');
						document.getElementById("email").focus();
						return false;
					}
					
			 		if(!isRigthCheck("urole", "remove")){
						$("#js").html("<br>i18n_uu.message.js_n81i");
						return;
					}else {
						if(!isRigthCheck("group", "remove")){
							$("#yhz").html("<br>i18n_uu.message.yhz_n81i");
							return;
						}
					    //获取选择的用户组信息
						var values=document.getElementsByName("group");
						var checkedGroupValues='';
						for( var i = 0; i < values.length; i++ ){
							if (values[i].checked==true ){
								checkedGroupValues +=values[i].value+",";
							}
						}
						checkedGroupValues = checkedGroupValues.substr(0,checkedGroupValues.length-1);
					    document.getElementById("yhzbh").value = checkedGroupValues;
						
						//获取选择的角色信息
						var values=document.getElementsByName("urole");
						var checkedRoleValues='';
						for( var i = 0; i < values.length; i++ ){
							if (values[i].checked==true ){
								checkedRoleValues +=values[i].value+",";
							}
						}
					    checkedRoleValues = checkedRoleValues.substr(0,checkedRoleValues.length-1);
						document.getElementById("jsbh").value = checkedRoleValues;
						
						var deptFlag=${session.deptFlag };
						if(deptFlag==0){
							 //获取选择的部门信息
							var values=document.getElementsByName("mkid");
							var checkedDeptValues='';
							for( var i = 0; i < values.length; i++ ){
								if (values[i].checked==true ){
									checkedDeptValues +=values[i].value+",";
								}
							}
							checkedDeptValues = checkedDeptValues.substr(0,checkedDeptValues.length-1);
							document.getElementById("deptid").value = checkedDeptValues;
						}
					   
						
						if(deptFlag==0&&checkedDeptValues==''){
							$("#bm").html("<br>i18n_uu.message.bm_n81i");
							return;
						}else{
							document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateUserInfo&yhid="+yhid+"&yhbh="+encodeURI(yhbh);
							document.yhForm.submit();				
						}
					}
				}
			}
			
			function goBack(){
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryUserInfo";
				document.yhForm.submit();	
			}
			
			$(function(){
				var nationRole=${session.nationRole};//配置文件中获取
				var preView=${preViewIds};
				if(nationRole==null||nationRole=="-1"){
					$("input[type='button']").attr("disabled","disabled");
					alert("please add or modify 'myconfig.properties' ,there need a parameter 'nation.role.jsbh'");
					return ;
				}
				var checkedRole=$("input[name='urole'][checked='checked']");
				var urole=document.getElementsByName("urole");
				var group=document.getElementsByName("group");
				for(var i=0 ;i<checkedRole.length;i++){
					if($(checkedRole[i]).val()==nationRole){
						$(group).attr("disabled","disabled");
					}else{
						$(group).click(function(){
							if(this.checked||this.checked=="checked"){
								$(group).removeAttr("checked");
								$(this).attr("checked","checked");
							}
						});
					}
				}
				preViewCheck(preView);
				$(urole).click(function(){
					var uroleVal=this.value;
					if(uroleVal!=null&&uroleVal!=""&&uroleVal==nationRole){//角色选择为 nation role ，选择所有用户组，不允许修改
						$(group).attr("checked","checked");
						$(group).attr("disabled","disabled");
					}else{
						$(group).removeAttr("disabled");
						$(group).removeAttr("checked");
						preViewCheck(preView);
						$(group).click(function(){
							if(this.checked||this.checked=="checked"){
								$(group).removeAttr("checked");
								$(this).attr("checked","checked");
							}
						});
					}
				});
				
				
			});
			function preViewCheck(preView){
				if(preView!=null&&preView!=""&&preView!=undefined){
					var objGroup=$("input[name='group']");
					var flag=false;
					for(var i=0;i<objGroup.length;i++){
						var value=$(objGroup[i]).val();
						for(var j=0;j<preView.length;j++){
							console.log(preView[j]+"-->"+$(objGroup[i]).val());
							var preValue=preView[j];
							
							if(value==preValue){
								flag=true;
							}
						}
						if(!flag){
							$(objGroup[i]).attr("disabled","disabled");
						}
						flag=false;
					}
				}
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
					onmouseup="this.className='btn3_mouseup'" onclick="goBack()" 
					value="i18n_uu.button.back_n81i"/>
			 </div>
				<input type="hidden" id="cna" value="${userInfo[0].yhmc }" />
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="jsbh" id="jsbh" />
				<input type="hidden" name="yhzbh" id="yhzbh" />
				<input type="hidden" name="deptid" id="deptid" />
				
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="3" class="color_8">
							<strong>i18n_uu.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="15%">
							<strong>i18n_uu.text.baseInfo_n81i</strong>
						</td>
						<td class="color_6">
							<table border="0" cellpadding="0" cellspacing="0" class="table1">
								<tr>
									<td class="color_3" width="15%" align="right">
										i18n_uu.text.yhbh_n81i：
									</td>
									<td class="color_6" width="50%" align="left">
										<input type="text" name="user.yhbh" id="yhbh"
											value="${userInfo[0].yhbh }" disabled="disabled" />
											<input type="hidden" name="user.yhbh" value="${userInfo[0].yhbh }"/>
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_uu.text.yhmc_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="user.yhmc" id="yhmc"
											value="${userInfo[0].yhmc }" />
											<font color="red">*</font>
									</td>
								</tr>
								<c:if test="${session.emailFlag==0 }">
									<tr>
										<td class="color_3" align="right">
											E-mail：
										</td>
										<td class="color_6" align="left">
											<input type="text" name="user.email" id="email" value="${userInfo[0].email }"/>
											<font color="red">*</font>
										</td>
									</tr>
								</c:if>
								<tr>
									<td class="color_3" align="right">
										i18n_uu.text.state_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="radio" name="user.zxbz" value="0"
											${userInfo[0].zxbz==0? "checked='checked' ":"" } />
										i18n_uu.message.state0_n81i
										<input type="radio" name="user.zxbz" value="1"
											${userInfo[0].zxbz==1? "checked='checked' ":"" }/>
										i18n_uu.message.state1_n81i
									</td>
								</tr>
								<c:if test="${session.emailFlag==0 }">
									<tr>
										<td class="color_3" align="right">
											i18n_uu.text.isReceiveEmail_n81i：
										</td>
										<td class="color_6" align="left">
											<input type="radio" name="user.isReceiveEmail" value="0"
											${userInfo[0].isReceiveEmail==0? "checked='checked' ":"" } />
											i18n_uu.message.isReceiveEmail0_n81i
											<input type="radio" name="user.isReceiveEmail" value="1"
											${userInfo[0].isReceiveEmail==1? "checked='checked' ":"" } />
											i18n_uu.message.isReceiveEmail1_n81i
										</td>
									</tr>
								</c:if>
								<tr>
									<td class="color_3" align="right">
										i18n_au.text.language_n81i：
									</td>
									<td class="color_6" align="left">
										 <select name="user.language">
											<option value="">--i18n_adepti.message.selectDefault_n81i--</option>
											<option value="en_US" ${userInfo[0].language=="en_US"? "selected='selected'":"" } >ENGLISH</option>
											<option value="zh_CN" ${userInfo[0].language=="zh_CN"? "selected='selected'":"" } >简体中文</option>
											<option value="ru_RU" ${userInfo[0].language=="ru_RU"? "selected='selected'":"" } >русский язык</option>
										</select> 
										<!-- <div id="flagstrap" data-input-name="user.language" ></div> 带有国旗的下拉选-->
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<table border="0" cellpadding="0" cellspacing="0" class="table1" width="100%">
								<tr>
									<td class="color_1" width="8%">
										i18n_uu.text.role_n81i<font color="red" id="js">*</font>
									</td>
									<td class="color_6" valign="top">
										<table>
											<tr>
												<td class="color_1" width="6%">
													<strong>i18n_uu.message.select_n81i</strong>
												</td>
												<td class="color_1" width="10%">
												<strong>i18n_uu.message.userRole_n81i</strong>
												</td>
											</tr>
												<c:forEach var="lji" items="${listJsInfo}">
											<tr>
												<%-- <td class="color_3">
													<c:if test="${lji.isChecked!=null}">
														<input type="checkbox" name="urole" value="${lji.jsbh }"
															checked="checked" />
													</c:if>
													<c:if test="${lji.isChecked==null}">
														<input type="checkbox" name="urole" value="${lji.jsbh }" />
													</c:if>
												</td>
												<td class="color_3">
													${lji.jsmc }
												</td> --%>
												<td class="color_3">
													<c:if test="${lji.isChecked!=null}">
														<input type="radio" name="urole" value="${lji.jsbh }"
															checked="checked" />
													</c:if>
													<c:if test="${lji.isChecked==null}">
														<input type="radio" name="urole" value="${lji.jsbh }" />
													</c:if>
												</td>
												<td class="color_3" nowrap="nowrap">
													${lji.jsmc }
												</td>
											</tr>
											</c:forEach>
										</table>
									</td>
									<td class="color_1" width="8%">i18n_uu.text.selectUserGroup_n81i<font color="red" id="yhz">*</font></td>
									<td class="color_6" valign="top">
										<table>
											<tr>
												<td class="color_1" width="6%">
													<strong>i18n_uu.message.select_n81i</strong>
												</td>
												<td class="color_1" width="8%">
													<strong>i18n_uu.text.userGroup_n81i</strong>
												</td>	
											</tr>
											<c:forEach var="aji" items="${yhzList}">
												<tr>
													<td class="color_3">
														<c:if test="${aji.isChecked!=null}">
															<input type="checkbox" name="group" value="${aji.jsbh }"
																checked="checked" />
														</c:if>
														<c:if test="${aji.isChecked==null}">
															<input type="checkbox" name="group" value="${aji.jsbh }" />
														</c:if>
													</td>
													<td class="color_3" nowrap="nowrap">
														${aji.jsmc }
													</td>
												</tr>
											</c:forEach>
										</table>
									</td>
									<c:if test="${session.deptFlag==0 }">
									<td class="color_1" width="8%">i18n_uu.text.selectDept_n81i<font color="red" id="bm">*</font></td>
									<td class="color_6" valign="top" align="left">
										<script type="text/javascript">
											d = new dTree('d');
											d.add('1','-1','i18n_uu.text.deptMenu_n81i');
											<%
												List list = (List)request.getAttribute("treeList");
												//List treeList = (List)request.getAttribute("treeList");
												//List list = MakeTree.getAllResourceList(treeList);
												if(list != null && list.size() > 0){
													Resource resource = new Resource();
													for( int i = 0 ; i < list.size() ; i++ ){
										        		resource = (Resource) list.get(i);
										        		if(resource.getChecked()!=null && !"".equals(resource.getChecked())){
										               		%>
										        	        	d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','checked','');
										           	      	<%          			
										        		}else{
										        			%>
										    	        		d.add('<%=resource.getRsCode()%>','<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','','','');
										       	      		<% 
										        		}		
										        	}
												}
											%>
											document.write(d);
										</script>
									</td>
									</c:if>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="doUpdate('${userInfo[0].yhid }','${userInfo[0].yhbh}')" 
											value="i18n_uu.text.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" 
											value="i18n_uu.text.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
