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
		<title>i18n_ungi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript">
			function add(){
			    //去空格
			    $("#groupName").val($.trim($("#groupName").val()));
			    //验证不能空与长度限制
			    //验证不能空与长度限制
			    if($id("groupName","","i18n_ungi.text.groupName_n81i") && $("#groupName").checkByteLength(64,"i18n_ungi.text.groupName_n81i") && $id("mkid","","i18n_ungi.text.systemId_n81i")){
			    	if(jQuery("#viewLevel2").attr('checked')==true){
	    				if($("#usergroupId option").length<=1){
			    			alert('i18n_ungi.message.noGroupBelong_n81i');
			    			return;
			    		}else if($("#usergroupId").val()==''){
			    			alert('i18n_ungi.message.selectGroup_n81i');
			    			return;
			    		}
	    			}
					document.Ngform.action="<%=path%>/sysManage/nodeGroupManage.do?action=doUpdate";
					document.Ngform.submit();	
				}	
			}
			
			function goBack(){
				document.Ngform.action="<%=path%>/sysManage/nodeGroupManage.do?action=query";
				document.Ngform.submit();	
			}
			
			
			jQuery(function(){
				if(jQuery("#viewLevel2").attr('checked')==true){
					jQuery("td[id=usergroup]").show();
				}else{
					jQuery("td[id=usergroup]").hide();
					jQuery("td[id=viewLevel]").attr('colspan',3).addClass('color_6').removeClass('color_3');
				}
				
				//-- 查看权限事件绑定
			 	jQuery("input[type=radio][name=nodeGroup.viewLevel]").click(function(){
			 		if(jQuery(this).val() == 2){	//用户组显示且必选
			 			jQuery("td[id=usergroup]").show();
			 			jQuery("td[id=viewLevel]").attr('colspan',1).addClass('color_3').removeClass('td_6');
			 		}else{	//用户组隐藏
			 			jQuery("td[id=usergroup]").hide();
			 			jQuery("#usergroupId").val("");
			 			jQuery("td[id=viewLevel]").attr('colspan',3).addClass('color_6').removeClass('color_3');
			 		}
			 	});
			})
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form action="" name="Ngform" method="post">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="nodeGroup.groupId"
					value="${nodeGroup.groupId }" />
				<input type="hidden" name="nameVo" id="nameVo" value="${nameVo }" />
				<input type="hidden" name="descVo" id="descVo" value="${descVo }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<!-- <div class="box_1">
					<img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />
					&nbsp;你现在所在的位置是: 业务系统管理 -> 修改节点组
				</div> -->
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_ungi.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_ungi.text.groupName_n81i：
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text"  name="nodeGroup.groupName" value="${nodeGroup.groupName }" id="groupName"  />
							<font color="red">* </font>
						</td>
						<td class="color_1" width="20%" align="right">
							i18n_ungi.text.groupType_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="nodeGroup.groupType" id="groupType"
								value="0"  <c:if test="${nodeGroup.groupType==0 }">checked</c:if> />i18n_ungi.message.groupType0_n81i
							<input type="radio" name="nodeGroup.groupType" id="groupType"
								value="1"  <c:if test="${nodeGroup.groupType==1 }">checked</c:if>/>i18n_ungi.message.groupType1_n81i
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ungi.text.systemId_n81i：
						</td>
						<td class="color_3" align="left">
							<c:if test="${ADMFlag eq true}" var="flag">
								<select name="mkid" id="mkid" >
									<option selected="selected" value="">
										i18n_ungi.message.systemId_n81i
									</option>
									<c:if test="${fn:length(systemList)>0 }">
										<c:forEach items="${systemList }" var="system">
											<option value="${system.systemId }" <c:if test="${system.systemId==nodeGroup.systemId }">selected</c:if>>
												${system.systemName }
											</option>
										</c:forEach>
									</c:if>
								</select>
							</c:if>
							<c:if test="${!flag}">
								<input type="hidden" name="mkid" id="mkid"
									value="${system.systemId }" />
								<input type="text" name="mkName" id="mkName"
									value="${system.systemName }" readonly
									 />
							</c:if>
							<font color="red">* </font>
						</td>
						<td class="color_1" align="right">
							i18n_ungi.text.isValid_n81i：
						</td>
						<td class="color_6" align="left">
							<input type="radio" name="nodeGroup.isValid" id="isValid"
								value="1" <c:if test="${nodeGroup.isValid==1 }">checked</c:if> />
							i18n_ungi.message.valid_n81i
							<input type="radio" name="nodeGroup.isValid" id="isValid"
								value="0" <c:if test="${nodeGroup.isValid==0 }">checked</c:if>/>
							<font color="red">i18n_ungi.message.invalid_n81i</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ungi.text.viewLevel_n81i：
						</td>
						<td class="color_3" align="left" id="viewLevel">
							<input type="radio" name="nodeGroup.viewLevel" id="viewLevel1"
								value="1" <c:if test="${nodeGroup.viewLevel==1 }">checked</c:if> />
							i18n_ungi.message.publisher_n81i&nbsp;
							<input type="radio" name="nodeGroup.viewLevel" id="viewLevel2"
								value="2" <c:if test="${nodeGroup.viewLevel==2 }">checked</c:if> />
							i18n_ungi.message.publisherGroup_n81i&nbsp;
							<input type="radio" name="nodeGroup.viewLevel" id="viewLevel3"
								value="3" <c:if test="${nodeGroup.viewLevel==3 }">checked</c:if> />
							i18n_ungi.message.allInSys_n81i&nbsp;
						</td>
						<td class="color_1" align="right" id="usergroup">
							i18n_ungi.text.usergroup_n81i：
						</td>
						<td class="color_6" align="left" id="usergroup">
							<select name="nodeGroup.createUsergroupId" id="usergroupId" >
								<option value="">
									i18n_ungi.message.usergroup_n81i
								</option>
								<c:if test="${fn:length(allUserGroup)>0 }">
									<c:forEach items="${allUserGroup }" var="userG">
										<option value="${userG.jsbh }"
											<c:if test="${userG.jsbh==nodeGroup.createUsergroupId }">selected</c:if>>
											${userG.jsmc }
										</option>
									</c:forEach>
								</c:if>
							</select>
							<font color="red">* </font>
						</td>
					</tr>
					<tr>
						<td class="color_1"  align="right">
							i18n_ungi.text.groupDesc_n81i：
						</td>
						<td class="color_6" colspan="3" align="left">
							<textarea rows="4" cols="80" name="nodeGroup.groupDesc"
								id="groupDesc" style="width: 360px" >${nodeGroup.groupDesc }</textarea>
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
											onclick="add()" value="i18n_ungi.button.submit_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="javascript:document.forms['Ngform'].reset()"
											value="i18n_ungi.button.reset_n81i"/>
										&nbsp;
										<input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="goBack()" value="i18n_ungi.button.back_n81i"/>
										&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
