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
		<title>i18n_afnti.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<!-- 日期插件 -->
	<script type="text/javascript">
	
	//查询记录
	function callBack(){
 		document.yhForm.action ="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults&missionId=${missionId}&result="+'${result}'+"&ip="+'${ip}'+"&tabs="+'${tabs}'+"&curMissionId="+'${curMissionId}';
		document.yhForm.submit();
	}
	
	function resetDate(obj){
		var split = "|";
		var params = jQuery("#commandPara0").val();
		//alert(params);
		if(params.length==0){
			jQuery("#commandPara0").val(obj.value);
		}else{
			var param = params.split(split);
			if(param[param.length-1].length==0){
				jQuery("#commandPara0").val(params+obj.value);
			}else{
				jQuery("#commandPara0").val(params.substring(0,params.length-param[param.length-1].length)+obj.value);
			}
		}
	}
	
	function checkValue(){
		var missionval =  jQuery("#missionName").val();
		var nodeListIdShow =  jQuery("#nodeListIdShow").val();
		var nodeGroupsId =  jQuery("#nodeGroupsId").val();
		//var obtargetPath =  jQuery("#missionstatetable.missionName").val();
		if(missionval==null||missionval==""){
			alert("i18n_afnti.message.missionName1_n81i");
			return  false;
		}
		
		if(containSpecial(missionval)){
	    	alert("i18n_afnti.message.missionName2_n81i");
	    	$("#missionName").val('');
	    	return false;
	    }
		
		if(nodeListIdShow==null||nodeListIdShow==""||nodeGroupsId==null||nodeGroupsId==""){
			alert("i18n_afnti.message.nodeList_n81i");
			return  false;
		}
		if(jQuery("[name=missionstatetable.systemId]>option:selected").val()=="") {
			alert("i18n_afnti.message.operationType_n81i");
			return false;
		}
		//if(jQuery("#nodeListId >option:selected").val()==""){
				//alert("请选择节点组");
				//return false;
		//}
		
		if(jQuery("input[type='radio'][name='missionstatetable.viewLevel']:checked").val()==2){
			if(jQuery("#usergroupid>option:selected").val()==""){
				alert("i18n_afnti.message.userGroup_n81i");
				return false;
			}
		}
		return true;
	}
	
	function checkValEmptyByEach(type, sname, ename, desc){
		var flag = true;
		jQuery("#file_Td input[type='" + type + "'][name^='" + sname + "'][name$='" + ename + "']").each(function(i,n){
			if(jQuery(n).val()==""){
				alert(desc + "i18n_afnti.message.isNotNull_n81i");
				flag = false;
				return  false;
			}
		});
		return flag;
	}
	
	//添加操作
	function add(){
		if(checkValue()){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=saveFailedNodesTask";
			document.yhForm.submit();		
		}
	 }
	 
	//跳转到相似任务
	function jumpToSimilarTaskInfo(){
		document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=upgradeFailedNodesAsSimilarTask";
		document.yhForm.submit();
	 }
	//-- onLoad
	jQuery(function(){
	 	//-- 查看权限 事件绑定
	 	jQuery("input[type='radio'][name='missionstatetable.viewLevel']").click(function(){
	 	
	 		if(jQuery(this).val() == 1){	//个人
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//隐藏联系人选项 但进行默认选择
	 			$("#userEmail_Line").hide();
	 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:$(this).val()},function(datas){viewUserEmail(datas);},"json");
	 		}else if(jQuery(this).val() == 2){	//用户组显示且必选
	 			//显示 用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 			//显示联系人 清空联系人选项
	 			$("#userEmail_Line").show();
	 			$("#userEmail").text("");
	 			jQuery("#usergroupid").trigger('change');
	 			resize();
	 		}else if(jQuery(this).val() ==3){	//系统
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//显示联系人 清空联系人选项
		 		$("#userEmail_Line").show();
		 		$("#userEmail").text("");
	 			//请求获取用户Email信息 默认全选
	 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:$(this).val()},function(datas){viewUserEmail(datas);},"json");
	 			resize();
	 		}
	 	});
	 	
		//-----------------------
	 	$("#usergroupid").bind({change:function(){
	 		if($("#usergroupid").val() != ""){
	 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:$("input[type=radio][name=missionstatetable.viewLevel]:checked").val(),userGroupId:$("#usergroupid").val()},function(datas){viewUserEmail(datas);},"json");
	 		}else{
	 			$("#userEmail").text("");
	 		}
	 		resize();
	 	}})
	 	function viewUserEmail(datas){
	 		$("#userEmail").text("");
	 		if(datas!=null){
			 	for(var i = 0;i<datas.length;i++){
			 		$("#userEmail").append("<span title='"+datas[i].email+"' ><input type='checkbox' name='userEmailIds' value='"+datas[i].yhid+"'  /> "+datas[i].yhmc+"</span>");
			 		if(i!=0&&i%10==0){$("#userEmail").append("<br />")}
			 	}
			 	$("#userEmail span").attr("width",'100px');
	 		}
	 		$("input[type='checkbox'][name='checkAll']").attr('checked',true);
	 		$("#userEmail input[type='checkbox']").attr('checked',true);
	 	}
	 	//指定联系人 绑定click事件
	 	$("input[type='checkbox'][ name='checkAll']").bind({
	 		click:function(){
	 			if($(this).val()==1){//全选
	 				//$(this).next().attr('checked',false);
	 				$("#userEmail input[type='checkbox']").attr('checked',$(this).attr('checked'));
	 			}else{//反选
	 			}
	 		}
	 	});
	 	$("#userEmail span input[type='checkbox']").live(
	 	'click',function(){
	 		if($("#userEmail input[type='checkbox']").size()==$("#userEmail input[type='checkbox']:checked").size()){	//达成全选
	 			$("input[type='checkbox'][ name='checkAll']:first").attr('checked',true);
	 		}else{	//未达成全选
	 			$("input[type='checkbox'][ name='checkAll']:first").attr('checked',false);
	 		}
	 	});

	 	jQuery("input[type='radio'][name='missionstatetable.viewLevel']:checked").click();
	});
	
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		//var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		//if(nodeLock == 1){
		//	alert("失败节点继续升级 节点组及节点不可修改");
		//	return ;
		//}
		var groupId = jQuery("#nodeGroupsId").val();//选中节点组
		var nodeId = jQuery("#nodeIp").val();//选中ip
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&groupId="+groupId+"&nodeId="+nodeId; //转向网页的地址;
		var name; //网页名称，可为空;
		//var iWidth = 800; //弹出窗口的宽度;
		//var iHeight = 560; //弹出窗口的高度;
		//var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
		//var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
		//window.open(url, "selectNodeAndNodeGroup", "height=" + iHeight + ",,innerHeight=" + iHeight + ",width=" + iWidth + ",innerWidth=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no,menubar=yes,location=no,status=yes,resizable=yes");
		
		//改为layer-20180831-chenjs---
		parent.layer.open({
			type: 2,
			title: "i18n_tsnang.text.selectNodeGroup_n81i",
			area:['850px', '610px'],
			shade: 0.6,
			closeBtn: 1,
			maxmin:true,
			content: url
		});
	}
	
	function reciveNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps){
			document.getElementById("nodeListIdShow").value = nodeGroupNames;//节点组名称s
			document.getElementById("nodeGroupsId").value = nodeGroupIds;//节点组ids
			document.getElementById("nodeIpShow").value = nodeIps;//节点ips
			document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
	}
	
	function resize(){
	 	{parent.document.all.I3.height = document.body.scrollHeight;}
	}
	
   </script>
   	</head>
	<body class="bc">
	<div class="middle_list">
	<div class="box_1">
<!-- <img src="<c:url value='/images/sanjiao.png'/>" class="img_middle" />&nbsp;你现在所在的位置是：任务添加 -->		</div>
		<form action="" id="yhForm" name="yhForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="oldMissionId" value="${missionstatetable.missionId }" />
		<input type="hidden" id="fw" value="addNewTask"/>
		<input type="hidden" id="dataStart" name="dataStart" value="${dataStart}"/>
    	<input type="hidden" id="dataEnd" name="dataEnd" value="${dataEnd}"/>
    	<input type="hidden" id="dataRange" name="dataRange" value="${dataRange}"/>
		<div class="box_2"></div>
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
				  <td class="color_8" colspan="4">i18n_afnti.text.title_n81i</td>
				</tr>
				<tr>
					<td class="td_1">i18n_afnti.text.missionName_n81i：</td>
					<td class="td_3" colspan="1">
					<input type="text" name="missionstatetable.missionName" id="missionName" value="${missionstatetable.missionName }" />
					<font color="red">*</font></td>
					<td class="td_2" colspan="2">
						<a href="javaScript:jumpToSimilarTaskInfo()">i18n_afnti.text.editCommandSets_n81i</a>
					</td>
				</tr>
				<tr>
				<td class="td_1">i18n_afnti.text.nodeGroup_n81i：</td>
					<td class="td_3">
						<input type="text" name="nodeListIdShow" id="nodeListIdShow" readonly="readonly" value="${missionParamterTable.nodeListName }"/>&nbsp;
						<input type="hidden" name="nodeGroupsId" id="nodeGroupsId" value="${missionParamterTable.nodeGroupsId }"/>&nbsp;
						<input type="button" value="i18n_afnti.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
						/>
						<font color="red">*${nodeCheckInfo }</font>
					</td>
					<td class="td_1" width="20%" align="right">
						i18n_afnti.text.nodeIp_n81i
					</td>
					<td class="td_2" width="30%" align="left">
						<input type="text" name="nodeIpShow" id="nodeIpShow" readonly="readonly" value="${missionParamterTable.nodeListName2 }"/>&nbsp;
						<input type="hidden" name="nodeIpsId" id="nodeIp" value="${missionParamterTable.nodeIpsId }"/>&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="td_1">i18n_afnti.text.viewLevel_n81i：</td>
					<td class="td_3" id="viewLevel0">
						<input type="radio"	name="missionstatetable.viewLevel" value="1" ${missionstatetable.viewLevel eq 1 ? "checked=\"checked\"":"" } />i18n_afnti.message.publisher_n81i&nbsp;
						<input type="radio"	name="missionstatetable.viewLevel" value="2" ${missionstatetable.viewLevel eq 2 ? "checked=\"checked\"":"" } />i18n_afnti.message.publisherGroup_n81i&nbsp;
						<input type="radio" name="missionstatetable.viewLevel" value="3" ${missionstatetable.viewLevel eq 3 ? "checked=\"checked\"":"" } />i18n_afnti.message.allInSys_n81i&nbsp;
					</td>
					<td class="td_1"  id="usergroup">i18n_afnti.text.usergroup_n81i：</td>
					<td class="td_2"  id="usergroup">
						<select name="missionstatetable.groupId" id="usergroupid">
							<option selected="selected" value="">
								i18n_afnti.message.userGroupDefault_n81i
							</option>
							<c:forEach items="${setxtjs}"  var="stjs">
								<option value="${stjs.jsbh}" ${missionstatetable.groupId eq stjs.jsbh ? "selected=\"selected\"":"" }  >
										${stjs.jsmc}
								</option>
							</c:forEach>
						</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<tr>
					<td class="td_1">i18n_afnti.text.missionDesc_n81i：</td>
					<td class="td_2" colspan="3"><textarea name="missionDesc"id="missionDesc" rows="4" style="width: 90%;" ></textarea></td>
				</tr>
				<!-- 联系人 -->
				<c:if test="${session.emailFlag==0 }">
					<tr id="userEmail_Line">
						<td class="td_1" align="right">
							i18n_afnti.text.users_n81i
						</td>
						<td class="td_2" colspan="3" align="left">
							<input type="checkbox" name="checkAll" value="1"  /> i18n_afnti.message.selectAll_n81i&nbsp;
							<!-- 
							<input type="button" name="checkOther" value="反选" /> 
							 -->
							<div id="userEmail" style="width: 100%;height: 50px; overflow-y: scroll; word-wrap: break-word;word-break:normal; ">
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="color_1" style="text-align: right;" colspan="4">
						<input type="button" onclick="add()" value="i18n_afnti.buttone.add_n81i"
							class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_afnti.buttone.reset_n81i"
							class=btn3_mouseout onclick="javascript:resetInfo();"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_afnti.buttone.back_n81i"
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
