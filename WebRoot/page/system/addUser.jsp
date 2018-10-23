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
		<title>i18n_au.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>			
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>	
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>	
			<link href="<c:url value='/js/flag/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css"></link>
			<link href="<c:url value='/js/flag/css/flags.css'/>" rel="stylesheet" type="text/css"></link>
			<script src="<c:url value='/js/flag/js/jquery-1.11.0.min.js'/>"></script>
			<script src="<c:url value='/js/flag/js/bootstrap.min.js'/>"></script>
			<script src="<c:url value='/js/flag/js/jquery.flagstrap.js'/>"></script>  
		<script type="text/javascript">
		function checkusername(){
			var yhbhValue = $("#yhbh").val();
			var result = false;
			if(yhbhValue != ""){
				$.ajax({
					url:"<%=path%>/sysManage/sysPopedomManage.do?action=checkUserName",
					type : "POST",
					async:false,
					dataType : "text",
					data:{'yhbhValue':yhbhValue},
					success : function(data) {
						if(data == "1"){
							alert("i18n_au.message.yhbh1_n81i");
							document.getElementById("yhbh").focus();
							$("input[name=user.yhbh]").next().html("*i18n_au.message.yhbh1_n81i");	
						}else{
							result = true;
						}
					}
				});
				return result;
			}else{
				return result;
			}  
		}
		    var isCommited = false;
			function add(){
			    if(isCommited==false) {
			    	isComited = true;
			    }else {
			    	return;
			    }
				$("#js").html('*');
				$("#yhz").html('*');
				$("#bm").html('*');
			 		if(!$id("yhbh","","i18n_au.text.yhbh_n81i")){
						return false;		 		
			 		}
			 		if(containSpecial($("#yhbh").val())){
			 			$("#yhbh").next().html('i18n_au.message.hasSpecialChar_n81i');
			 			return false;
			 		}
			 		if(!checkZW($("#yhbh").val())){
			 			$("#yhbh").next().html('i18n_au.message.hasZH_n81i');
			 			return false;
			 		}
			 		if(checkNum($("#yhbh").val())){
			 			$("#yhbh").next().html('i18n_au.message.onlyNumber_n81i');
			 			return false;
			 		}
			 		if(!checkusername()){
			 			return false;
			 		}
			 		if(!$id("yhmc","","i18n_au.text.yhmc_n81i")){
			 			return false;
			 		}
			 		
			 		/*2018-08-30是否启用邮件功能*/
			 		var emailFlag=${session.emailFlag==0}
			 		
			 		if(emailFlag&&!$id("email","","E-mail")){
			 			return false;
			 		}
			 		if(emailFlag&&yhForm.email.value!=""){
						if(!checkEmail(yhForm.email.value.toLowerCase())){
							$("#email").next().html('i18n_au.message.email_n81i');
							yhForm.email.focus();
							return false;
						}
					}
			 		if(!isRigthCheck("urole", "remove")){
						$("#js").html("<br>i18n_au.message.js_n81i");
						return false;
					}else{
						if(!isRigthCheck("group", "remove")){
							$("#yhz").html("<br>i18n_au.message.yhz_n81i");
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
					    //获取选择的部门信息
					    if(deptFlag==0){
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
							$("#bm").html("<br>i18n_au.message.bm_n81i");
							return false;
						}else{
								document.yhForm.action="<%=path%>/sysManage/sysPopedomManage.do?action=doaddUserInfo";
								document.yhForm.submit();						
						}
					}
			 	}		
			 function goBack(){
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage.do?action=queryUserInfo";
				document.yhForm.submit();	
			}
			//验证非中文
			function checkZW(s)       
			{       
		   		var cs = /^\w+$/;  
		   		resu = cs.test(s);     
		   		return (cs.test(s));       
			} 
			//验证纯数字
			function checkNum(s)       
			{       
		   		var cs = /^\d+$/;  
		   		resu = cs.test(s);     
		   		return (cs.test(s));       
			} 
			$(document).ready(function() {//选择国家插件初始化函数
			    $('#flagstrap').flagStrap({
			    	placeholder: {
			            value: "",
			            text: "--i18n_adepti.message.selectDefault_n81i--"
			        },
			       
			    	 countries: {//添加国家   ps:左边的值与flags.css中的国家值不对应，需到css中修改  如  zh_CN 默认为CN  css文件中为cn  需改为zh_cn
			    			 "": "",//不要删除，插件bug：第一个选项value为空
			    		 	"en_US": "United States",
			    	        "zh_CN": "Chinese",
			    	  },
			    	 buttonSize: "btn-sm",
			    	 buttonType: "btn-info",
			    	 
			    	 labelMargin: "10px",
			    	 scrollable: true,
			    	 scrollableHeight: "350px",
			    });
			   
			}); 
			
			$(function(){
				var nationRole=${session.nationRole};//配置文件中获取
				var preView=${preViewIds};
				if(nationRole==null||nationRole=="-1"){
					$("input[type='button']").attr("disabled","disabled");
					alert("please add or modify 'myconfig.properties' ,there need a parameter 'nation.role.jsbh'");
					return ;
				}
					
				var urole=document.getElementsByName("urole");
				var group=document.getElementsByName("group");
				for(var i=0 ;i <urole.length;i++){
					if(urole[i].value != nationRole){
						$(urole[i]).prop("checked","checked");
						$(group).click(function(){
							if(this.checked||this.checked=="checked"){
								$(group).removeProp("checked");
								$(this).prop("checked","checked");
							}
						});
					}
				}
				preViewCheck(preView);
				
				$(urole).click(function(){
					var uroleVal=this.value;
					$(group).unbind("click");
					if(uroleVal!=null&&uroleVal!=""&&uroleVal==nationRole){//角色选择为 nation role ，选择所有用户组，不允许修改
						$(group).prop("checked","checked");
						$(group).prop("disabled","disabled");
					}else{
						$(group).removeProp("disabled");
						$(group).removeProp("checked");
						preViewCheck(preView);
						$(group).click(function(){
							if(this.checked||this.checked=="checked"){
								$(group).removeProp("checked");
								$(this).prop("checked","checked");
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
					onmouseup="this.className='btn3_mouseup'" 
					onclick="goBack()" value="i18n_au.button.back_n81i"/>
			 </div>
			<form action="" name="yhForm" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="jsbh" id="jsbh" />
				<input type="hidden" name="yhzbh" id="yhzbh" />
				<input type="hidden" name="deptid" id="deptid" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="3" class="color_8">i18n_au.text.title_n81i</td>
					</tr>
					<tr>
						<td class="color_1" width="25%">i18n_au.text.yhjbxx_n81i</td>
						<td colspan="2">
							<table border="0" cellpadding="0" cellspacing="0" class="table1" width="100%">
								<tr>
									<td class="color_3" width="15%" align="right">
										i18n_au.text.yhbh_n81i：
									</td>
									<td class="color_6" width="50%" align="left">
										<input type="text" name="user.yhbh" id="yhbh"/>
										<font color="red">*i18n_au.message.cannotHasZH_n81i</font>
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										i18n_au.text.yhmc_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="text" name="user.yhmc" id="yhmc"/>
										<font color="red">*</font>
									</td>
								</tr>
								<!-- 
								<tr>
									<td class="color_3" align="right">
										用户密码：
									</td>
									<td class="color_6" align="left">
										<input type="password" name="user.yhmm" id="yhmm" />
										<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="color_3" align="right">
										确认密码：
									</td>
									<td class="color_6" align="left">
										<input type="password" name="confirm" id="confirm" />
										<font color="red">*</font>
									</td>
								</tr>
								 -->
								<c:if test="${session.emailFlag==0 }">
									<tr>
										<td class="color_3" align="right">
											E-mail：
										</td>
										<td class="color_6" align="left">
											<input type="text" name="email" id="email" />
											<font color="red">*</font>
										</td>
									</tr>
								</c:if>
								<tr>
									<td class="color_3" align="right">
										i18n_au.text.state_n81i：
									</td>
									<td class="color_6" align="left">
										i18n_au.text.using_n81i
									</td>
								</tr>
								<c:if test="${session.emailFlag==0 }">
									<tr>
										<td class="color_3" align="right">
											i18n_au.text.reciveEmail_n81i：
										</td>
										<td class="color_6" align="left">
											<input type="radio" name="user.isReceiveEmail" value="0" checked="checked"/>
											i18n_au.message.Y_n81i
											<input type="radio" name="user.isReceiveEmail" value="1"/>
											i18n_au.message.N_n81i
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
											<option value="en_US">ENGLISH</option>
											<option value="zh_CN">简体中文</option>
											<option value="ru_RU">русский язык</option>
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
										i18n_au.text.xzjs_n81i<font color="red" id="js">*</font>
									</td>
									<td class="color_6" valign="top">
										<table >
											<tr>
												<td class="color_1" width="6%">
													<strong>i18n_au.text.select_n81i</strong>
												</td>
												<td class="color_1" width="10%">
												<strong>i18n_au.text.selectUser_n81i</strong>
												</td>
											</tr>
												<c:forEach var="lji" items="${allJsInfo}">
													<%-- <tr>
														<td class="color_3">
															<input type="checkbox" name="urole" value="${lji.jsbh }" />
														</td>
														<td class="color_3">
															${lji.jsmc }
														</td>
													</tr> --%>
													<tr>
														<td class="color_3">
															<input type="radio" name="urole" value="${lji.jsbh }" />
														</td>
														<td class="color_3" nowrap="nowrap">
															${lji.jsmc }
														</td>
													</tr>
												</c:forEach>
										</table>
									</td>
									<td class="color_1" width="8%">i18n_au.text.selectUserGroup_n81i<font color="red" id="yhz">*</font></td>
									<td class="color_6" valign="top">
										<table >
											<tr>
												<td class="color_1" width="6%">
													<strong>i18n_au.text.select_n81i</strong>
												</td>
												<td class="color_1" width="8%">
													<strong>i18n_au.text.userGroup_n81i</strong>
												</td>	
											</tr>
											<c:forEach var="aji" items="${yhzList}">
												<tr>
													<td class="color_3">
														<input type="checkbox" name="group" value="${aji.jsbh }"  />
														<input type="hidden" name="type" value="${aji.type}" />
													</td>
													<td class="color_3" nowrap="nowrap">
														${aji.jsmc }
													</td>
												</tr>
											</c:forEach>
										</table>
									</td>
									<c:if test="${session.deptFlag==0 }">
									<td class="color_1" width="8%">i18n_au.text.selectDept_n81i<font color="red" id="bm">*</font></td>
									<td class="color_6" valign="top" align="left">
									
										<script type="text/javascript">
											d = new dTree('d');
											d.add('1','-1','i18n_au.message.deptMenu_n81i');
											<%
												List list = (List)request.getAttribute("treeList");
												//List treeList = (List)request.getAttribute("treeList");
												//List list = MakeTree.getAllResourceList(treeList);
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
										
									</td>
									</c:if>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="3" class="color_7" align="right">
							&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="add()" value="i18n_au.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['yhForm'].reset()" value="i18n_au.button.reset_n81i"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
