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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_emvl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<!-- 日期插件 -->
	<script type="text/javascript">
	//查询记录
	function callBack(){
 		document.yhForm.action ="<c:url value='${prevPageUrl}' />";
	 	//document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
		document.yhForm.submit();
	}
	
	function checkValue(){
		var missionval =  jQuery("#missionName").val();
		var nodeListIdShow =  jQuery("#nodeListIdShow").val();
		var nodeGroupsId =  jQuery("#nodeGroupsId").val();
		var userViewLevel = $("input[type=radio][name=missionstatetable.viewLevel]:checked").val();
		//var obtargetPath =  jQuery("#missionstatetable.missionName").val();
		if(missionval==null||missionval==""){
			alert("i18n_emvl.message.missionName1_n81i");
			return  false;
		}
		
		if(containSpecial(missionval)){
	    	alert("i18n_emvl.message.missionName2_n81i");
	    	$("#missionName").val('');
	    	return false;
	    }
	    
		if(userViewLevel==2){//组查看
			if($("#usergroupid").val()==""){
				alert("i18n_emvl.message.usergroupid_n81i");
				return false;
			}
		}
		
		return true;
	}
	
	
	//添加操作
	function add(){
		if(checkValue()){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=updateViewLevel";
			document.yhForm.submit();		
		}
	 }
	
	
   //新增：重置（重置为文件推送）
   function resetInfo(){
   	   jQuery('#yhForm')[0].reset();
   	   jQuery("input[type='radio'][id='missionType']:checked").trigger('change');
   }
	jQuery(function(){
		if(jQuery("input[type=radio][name=missionstatetable.viewLevel][value='2']").attr('checked')==true){
			jQuery("tr[id=Usergroup]").show();
		}else{
			jQuery("tr[id=Usergroup]").hide();
		}
		
	//-- 查看权限事件绑定
	 	jQuery("input[type=radio][name=missionstatetable.viewLevel]").click(function(){
	 		if(jQuery(this).val() == 2){	//用户组显示且必选
	 			jQuery("tr[id=Usergroup]").show();
	 	
	 		}else{	//用户组隐藏
	 			jQuery("tr[id=Usergroup]").hide();
	 			jQuery("#usergroupid").val("");
	 			
	 		}
	 	});
	})
   </script>
   	</head>
	<body class="bc">
	<div class="middle_list">
	<div class="box_1">
<!-- <img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />&nbsp;你现在所在的位置是：任务添加 -->		</div>
		<form action="" id="yhForm" name="yhForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionstatetable.missionId" value="${missionstatetable.missionId }" />
		<input type="hidden" name="pageNo" value="${pageNo }" />
		<input type="hidden" name="pageSize" value="${pageSize }" />
		<div class="box_2"></div>
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
				  <td class="color_8" colspan="4">i18n_emvl.text.title_n81i</td>
				</tr>
				<tr>
					<td class="td_1">i18n_emvl.text.missionName_n81i：</td>
					<td class="td_2" colspan="3">
					<input type="text" name="missionstatetable.missionName" id="missionName" value="${missionstatetable.missionName }" />
					<font color="red">*</font></td>
				</tr>
				
				<tr>
					<td class="td_1">i18n_emvl.text.viewLevel_n81i：</td>
					<td class="td_2" colspan="3">
						<c:if test="${missionstatetable.systemId == -1}">
							<input type="radio" name="missionstatetable.viewLevel" id="" value="4" ${missionstatetable.viewLevel eq 4 ? "checked=\"checked\"" : "" } />i18n_emvl.message.unlimited_n81i&nbsp;
						</c:if>
						<c:if test="${missionstatetable.systemId != -1}">
							<input type="radio"	name="missionstatetable.viewLevel" id="" value="1" ${missionstatetable.viewLevel eq 1 ? "checked=\"checked\"" : "" } />i18n_emvl.message.publisher_n81i&nbsp;
							<input type="radio"	name="missionstatetable.viewLevel" id="" value="2" ${missionstatetable.viewLevel eq 2 ? "checked=\"checked\"" : "" } />i18n_emvl.message.publisherGroup_n81i&nbsp;
							<input type="radio" name="missionstatetable.viewLevel" id="" value="3" ${missionstatetable.viewLevel eq 3 ? "checked=\"checked\"" : "" } />i18n_emvl.message.allInSys_n81i&nbsp;
						</c:if>
					</td>
				</tr>
				<tr id="Usergroup">
					<td class="td_1"  id="usergroup">i18n_emvl.text.usergroup_n81i：</td>
					<td class="td_2"  id="usergroup" colspan="3">
						<select name="missionstatetable.groupId" id="usergroupid">
								<option selected="selected" value="">
									i18n_emvl.text.usergroupDefault_n81i
								</option>
								<c:forEach items="${setxtjs}"  var="stjs">
										<option value="${stjs.jsbh}" <c:if test="${stjs.jsbh == missionstatetable.groupId }">selected="selected"</c:if>>
												${stjs.jsmc}
										</option>
								</c:forEach>
							</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<tr>
					<td class="color_1" style="text-align: right;" colspan="4">
						<input type="button" onclick="add()" value="i18n_emvl.button.submit_n81i"
							class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_emvl.button.reset_n81i"
							class=btn3_mouseout onclick="javascript:resetInfo();"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_emvl.button.back_n81i"
							class=btn3_mouseout onclick="javaScript:callBack();"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
					</td>
				</tr>
			</table>
		</form>
		</div>
		
		<jsp:include page="/page/system/nmstaskmanager/taskTemplate.jsp" />
	</body>
</html>
