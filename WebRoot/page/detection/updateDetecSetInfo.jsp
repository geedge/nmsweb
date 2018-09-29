<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
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
		<title>i18n_udsi.message.title_n81i</title>
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
		<script type="text/javascript"
            src="<c:url value='/js/WebCalendar.js' />"></script>
        <script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
	</head>
	<script language="javascript" type="text/javascript">
	function updateCheck(){
		var type;
			$.ajax({
				url:"<%=path%>/detection/detectionSet.do?action=updateCheck",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "exception"){
						type = false;
						alert("i18n_udsi.message.faild_n81i");
					}else if(data =="success"){
						type = true;
					}else{
						type = false;
						alert(data);
					}
				}
			}); 
		return type; 
	}
	
	function add(){
		$("#usergroupid").next().html("*");
		if(checkSpecial($("#processIdenName").val())){
			$("#processIdenName").next().html("i18n_udsi.message.processIdenNameInfo_n81i");
			return;
		}
		var type = $("#checkTypeId").val();
		var startType = $("input[id='isControlStart']:checked").val();
		var userViewLevel = $("input[type=radio][name=detectionSetInfo.viewLevel]:checked").val();
		var checkedSize = $("#userEmail input[name=userEmailIds]:checked").size();
		//alert($("#usergroupid").val());
		//alert("权限："+userViewLevel);
		//alert("选中个数"+checkedSize);
		
		//节点组可以为空，为空表示选择所有的节点组,但是如果选择了节点组，而节点组内无有效的节点，需要提示
		var nodeGroupsId = jQuery("#groupId").val();//选中节点组
		if(nodeGroupsId!="") {
			//当ip为空时，验证所选节点组内是否包含有效节点
			var nodeIds = jQuery("#nodeIp").val();//节点ids:nodeIds为选中的节点的id（用逗号连接的）
			if(nodeIds=="") {
				var validIpFlag = true;
				jQuery.ajaxSetup({async:false});
				jQuery.post("<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=getNodesByNodeGroupId",{"groupId":nodeGroupsId},
				            function(datas){
				            	if(datas.length==0){//所选节点组内无有效的节点
				            		$("#jdz").html("i18n_udsi.message.jdz_n81i");
				            		validIpFlag = false;
				            		return false;
				            	}
							},
							"json");
				if(!validIpFlag) {return false;}
			}
		
		}
		
		if(userViewLevel==2){//组查看
			if($("#usergroupid").val()==""){
				$("#usergroupid").next().html("i18n_udsi.message.userGroup_n81i");
				return;
			}
		}
		
		if(false == (
				$id("processIdenName","","i18n_udsi.message.processIdenName_n81i") && $id("processIden","","i18n_udsi.message.processIden_n81i") 
				&& $id("checkGap","sz","i18n_udsi.message.checkGap_n81i")  
				&& $id("checkOutTime","sz","i18n_udsi.message.checkOutTime_n81i") && $id("checkMaxTimes","sz","i18n_udsi.message.checkMaxTimes_n81i")
    		)) {
			return;
		}
		if(Number(type) ==8){
			if(Number(type) > 7 && startType == 0){ // 手动启动
				if(false ==(
						$id("processFile","","i18n_udsi.message.processFile_n81i")
						&& $id("processSearchCode","","i18n_udsi.text.processSearchCode_n81i")
					)){
					return;
				}
			}
			if(Number(type) > 7 && startType == 1){ // 单次启动
				if(false ==(
						$id("processFile","","i18n_udsi.message.processFile_n81i")
						&& $id("processSearchCode","","i18n_udsi.text.processSearchCode_n81i")
						&& $id("processPath","","i18n_udsi.message.processPath_n81i")
					)){
					return;
				}
			}
			if(Number(type) > 7 && startType == 2){ // 周期启动
				if(!$("#scriptFile").html()) { // 未上传脚本
					if(false ==(
						$id("myFile","","i18n_udsi.message.myFile_n81i")
					)){
						return;
					}
				}
			}
		}
		
		
   		if($("#checkGap").val() >=5){
    		if(userViewLevel!=4 && userViewLevel!=1){//不是自己和无限制
    			if(checkedSize>0&&updateCheck()){//有选中
	    			document.Mkform.action="<%=path%>/detection/detectionSet.do?action=doUpdate";
					document.Mkform.submit();		
    			}else{//无选中
    				$("#lxr").html("i18n_udsi.message.lxr_n81i<br>");
    				return;
    			}
    		}else{
    			if(updateCheck()){
					document.Mkform.action="<%=path%>/detection/detectionSet.do?action=doUpdate";
					document.Mkform.submit();		    			
    			}
    		}
   		}else{
   			$("#checkGap").next().html("i18n_udsi.message.checkGapInfo_n81i");
   			return;
   		}
	}
	
	function goBack(){
		window.location="<%=path%>/detection/detectionSet.do?action=query&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }'+"&ip="+'${ip}'+"&ctn="+'${ctn}'+"&pIden="+'${pIden}';
	}

	function sreachNode(ngId){
		$("#updNip").empty();
		$("#updNip").append("<option value=''>i18n_udsi.message.selectDefault_n81i</option>");
		if(ngId!=null && ngId!=""){
			jQuery.post("<%=path%>/detection/detectionSet.do?action=getAllNode",
			{"gid":ngId},function(datas){
				
				$.each(datas, function(k, da) {			
					$("#updNip").append("<option value="+da+">"+da+"</option>");
				});	       
			},"json");
		}
		
	}
	
	function onLoad(){   
		var jclb = document.Mkform.checkTypeId.value;
		var $selectedvalue = $("input[id='isControlStart']:checked").val();
		
		//alert(jclb);
		if(jclb <= 7){ 
			$("#isSnmpType").val("n");
			$(".controlstarts").css('display','none');			
			$(".asd").css('display','none');			
			$(".bsd").css('display','none');
			$(".csd").css('display','none');
			$(".dsd").css('display','none');
			$(".esd").css('display','none');
		
		}else if(jclb == 8){//进程监测
			$("#isSnmpType").val("n");

			$(".controlstarts").removeAttr("style");
			$(".controlstart3").css('display','none');
			$(".asd").removeAttr("style");
			$(".csd").removeAttr("style");				
			$(".esd").css('display','none');
			if($selectedvalue==1){					
				$(".bsd").removeAttr("style");
				$(".dsd").removeAttr("style");
			} else if($selectedvalue==0){						
				$(".bsd").css('display','none');
				$(".dsd").css('display','none');
			}
		
		}else{
			if($("#sp").val() < 2){//snmp  不是进程的情况下再判断是否为snmp监测
				$(".controlstarts").css('display','none');			
				$(".asd").css('display','none');			
				$(".bsd").css('display','none');
				$(".dsd").css('display','none');
				$(".csd").css('display','none');			
				$(".esd").css('display','none');
				$("#isSnmpType").val("y");

			} else { // 不是SNMP
				$("#isSnmpType").val("n");
				
				$(".controlstarts").removeAttr("style");
				$(".controlstart3").removeAttr("style");
				if($selectedvalue==0) {
					$(".asd").removeAttr("style");
					$(".csd").removeAttr("style");
					$(".bsd").css('display','none');
					$(".dsd").css('display','none');
					$(".esd").css('display','none');
				} else if($selectedvalue==1) {
					$(".asd").removeAttr("style");
					$(".bsd").removeAttr("style");
					$(".dsd").removeAttr("style");
					$(".csd").removeAttr("style");
					$(".esd").css('display','none');
				} else if($selectedvalue==2) {
					$(".asd").css('display','none');
					$(".bsd").removeAttr("style");
					$(".esd").removeAttr("style");
					$(".csd").css('display','none');
					$(".dsd").css('display','none');
				}
			}	
		}
	}
	
	$(function(){
		//-- 查看权限事件绑定
	 	jQuery("input[type=radio][name=detectionSetInfo.viewLevel]").click(function(){
	 		if(jQuery(this).val() == 1){	//个人
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//隐藏联系人选项 但进行默认选择
	 			$("#userEmail_Line").hide();
	 			$.post("<%=path%>/detection/detectionSet.do?action=queryUserInfo",{viewType:$(this).val()},function(datas){viewUserEmail(datas);},"json");
	 		}else if(jQuery(this).val() == 2){	//用户组显示且必选
	 			//显示 用户组选项
	 			//jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 			//显示联系人 清空联系人选项
	 			$("#userEmail_Line").show();
	 			$("#userEmail").text("");
	 			jQuery("#usergroupid").trigger('change');
	 		}else if(jQuery(this).val() ==3){	//系统
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//显示联系人 清空联系人选项
		 		$("#userEmail_Line").show();
		 		$("#userEmail").text("");
	 			//请求获取用户Email信息 默认全选
	 			$.post("<%=path%>/detection/detectionSet.do?action=queryUserInfo",{viewType:$(this).val()},function(datas){viewUserEmail(datas);},"json");
	 		}else if(jQuery(this).val() ==4){
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//隐藏联系人选项 并清空内容
	 			$("#userEmail_Line").hide();
	 			$("#userEmail").text("");
	 		}
	 	});
	 	$("#usergroupid").bind({change:function(){
	 		if($("#usergroupid").val() != ""){
		 		$.post("<%=path%>/detection/detectionSet.do?action=queryUserInfo",{viewType:$("input[type=radio][name=detectionSetInfo.viewLevel]:checked").val(),userGroupId:$("#usergroupid").val()},function(datas){viewUserEmail(datas);},"json");
	 		}else{
	 			$("#userEmail").text("");
	 		}
	 	}})
	 	var loadFlag = true;
	 	var checkedBox = "${detectionSetInfo.contactUserIds }";
	 	function viewUserEmail(datas){
	 		$("#userEmail").text("");
	 		if(datas!=null){
			 	for(var i = 0;i<datas.length;i++){
			 		$("#userEmail").append("<span title='"+datas[i].email+"' ><input type='checkbox' name='userEmailIds' value='"+datas[i].yhid+"'  /> "+datas[i].yhmc+"</span>");
			 		if(i!=0&&i%10==0){$("#userEmail").append("<br />")}
			 	}
			 	$("#userEmail span").attr("width",'100px');
	 		}
	 		if(loadFlag && checkedBox!=null && checkedBox.length>0){
	 			loadFlag = false;
	 			var boxArray = checkedBox.split(',');
	 			for(var i = 0 ; i < boxArray.length ; i++){
		 			//alert( $("#userEmail input[name='userEmailIds'][value='"+boxArray[i]+"']").size());
	 				$("#userEmail input[name='userEmailIds'][value='"+boxArray[i]+"']").trigger('click');
	 			}
	 		}else{
		 		$("input[type='checkbox'][name='checkAll']").attr('checked',true);
		 		$("#userEmail input[type='checkbox']").attr('checked',true);
	 		}
	 		
	 	}
	 	//指定联系人 绑定click事件
	 	$("input[type='checkbox'][ name='checkAll']").bind({
	 		click:function(){
	 			//if($(this).val()==1){//全选
	 				//$(this).next().attr('checked',false);
	 			//	alert($(this).attr('checked'));
	 				$("#userEmail input[type='checkbox']").attr('checked',$(this).attr('checked'));
	 			//}else{//反选
	 			//	$("#userEmail input[type='checkbox']").attr('checked',$(this).attr('checked'));
	 			//}
	 		}
	 	});
	 	$("#userEmail span input[type='checkbox']").live(
	 	'click',function(){
	 		if($("#userEmail input[type='checkbox']").size()==$("#userEmail input[type='checkbox']:checked").size()){	//达成全选
	 			$("input[type='checkbox'][ name='checkAll']").attr('checked',true);
	 		}else{	//未达成全选
	 			$("input[type='checkbox'][ name='checkAll']").attr('checked',false);
	 		}
	 	});
	 	jQuery("input[type=radio][name=detectionSetInfo.viewLevel]:checked").trigger('click');
	})
	$(document).ready(function(){
		$(".controlstart").change(function(){
			onLoad();
		})
	})
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		var groupId = jQuery("#groupId").val();//选中节点组
		var nodeId = jQuery("#nodeIp").val();//选中ip	
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&groupId="+groupId+"&nodeId="+nodeId; //转向网页的地址;
		var name; //网页名称，可为空;
		//var iWidth = 800; //弹出窗口的宽度;
		//var iHeight = 560; //弹出窗口的高度;
		//var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
		//var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
		//window.open(url, "selectNodeAndNodeGroup", "height=" + iHeight + ",,innerHeight=" + iHeight + ",width=" + iWidth + ",innerWidth=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no,menubar=yes,location=no,status=yes,resizable=yes");
		
		//改为layer-20180902-chenjs---
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
			document.getElementById("groupIdShow").value = nodeGroupNames;//节点组名称s
			document.getElementById("groupId").value = nodeGroupIds;//节点组ids
			document.getElementById("nodeIpShow").value = nodeIps;//节点ips
			document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
	}	
	//选择节点组---end
	
	$(function(){
		//下载附件
		$(".downloadA").click(function(){
			window.location="<%=path%>/detection/detectionSet.do?action=downloadScript&myFileFileName=${myFileFileName}";
		});
	});
</script>
	<body >
		<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_udsi.button.back_n81i"/>
			 </div>
			<input type="hidden" id="szName" value="${detectionSetInfo.processIdenName}" />
			<form action="" name="Mkform" method="post" id="Mkform" style="margin-top: 23px" enctype="multipart/form-data">
				<input type="hidden" name="detectionSetInfo.id" value="${detectionSetInfo.id }" />
				<input type="hidden" name="ip" id="ip" value="${ip }" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" id="fw" value="detecSetUpp"/>
				<input type="hidden" id="isSnmpType" value=""/>
				<input type="hidden" name="pIden" id="pIden" value="${pIden }" />
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_udsi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_udsi.text.processIdenName_n81i
					</td>
					<td class="color_3" width="20%" align="left">
							<input type="text" name="detectionSetInfo.processIdenName" 
								id="processIdenName" value="${detectionSetInfo.processIdenName}"/>
							<font color="red">*</font>
					</td>
					<td class="color_1" align="right">
						i18n_udsi.text.processIden_n81i
					</td>
					<td class="color_6" align="left">
							<input type="text" name="processIdenShow" 
								id="processIdenShow" value="${detectionSetInfo.processIden}" disabled/>
							<input type="hidden" name="detectionSetInfo.processIden" 
								id="processIden" value="${detectionSetInfo.processIden}"/>
							<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_udsi.text.checkType_n81i
					</td>
					<td class="color_6" align="left" colspan="3">
						<c:if test="${fn:length(allCheckTypeInfo) > 0}">
							<c:forEach items="${allCheckTypeInfo}" var="checkType">
								<c:if test="${checkType.id == detectionSetInfo.checkTypeInfo.id }">
									<input type="text" name="checkTypeName1" value="${checkType.checkTypeName1}" disabled/>
									<input type="hidden" name="sp" id="sp" value="${checkType.isSnmp }" />
								</c:if> 
							</c:forEach>
						</c:if>								
						<input type="hidden"  name="detectionSetInfo.checkTypeInfo.id" id="checkTypeId" value="${detectionSetInfo.checkTypeInfo.id }" />
						<input type="hidden"  name="detectionSetInfo.checkWay" id="checkWay" value="${detectionSetInfo.checkWay }" />
						<font color="red">*</font>
					</td>
					
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_udsi.text.nodeGroup_n81i
					</td>
					<td class="color_6" width="30%" align="left">
						<!-- <select name="detectionSetInfo.nodegroup.groupId" id="groupId" onchange="sreachNode(this.value)">
							<option value="">
								请选择
							</option>
							<c:if test="${fn:length(nodeGroupList) > 0}">
								<c:forEach items="${nodeGroupList}" var="nodeGroup">
									<option value="${nodeGroup.groupId}" 
										<c:if test="${nodeGroup.groupId == detectionSetInfo.nodegroup.groupId }">selected="selected"</c:if>>
										${nodeGroup.groupName}
									</option>
									</c:forEach>
								</c:if>
						</select>   -->
						
						<input type="text" name="groupIdShow" id="groupIdShow" readonly="readonly" value="${detectionSetInfo.nodeGroupsName }"/>&nbsp;
						<input type="hidden" name="detectionSetInfo.nodeGroupsId" id="groupId" value="${detectionSetInfo.nodeGroupsId }"/>&nbsp;
						<input type="button" value="i18n_udsi.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						<font color="red" id="jdz"></font>
					</td>
					<td class="color_1" width="20%" align="right">
						i18n_udsi.text.nodeIp_n81i
					</td>
					<td class="color_6" width="30%" align="left">
						<input type="text" name="detectionSetInfo.nodeIpsName" id="nodeIpShow" readonly="readonly" value="${detectionSetInfo.nodeIpsName }"/>&nbsp;
						<input type="hidden" name="detectionSetInfo.nodeIpsId" id="nodeIp" value="${detectionSetInfo.nodeIpsId }"/>&nbsp;
					</td>	
					
					
				</tr>
				<tr>
				<td class="td_1">i18n_udsi.text.viewLevel_n81i</td>
					<td class="td_3" id="viewLevel0">
						<c:if test="${!ADMFlag }">
							<input type="radio"	name="detectionSetInfo.viewLevel" id="" value="1" ${detectionSetInfo.viewLevel eq "1"?"checked":""} />i18n_udsi.message.publisher_n81i&nbsp;
							<input type="radio"	name="detectionSetInfo.viewLevel" id="" value="2" ${detectionSetInfo.viewLevel eq "2"?"checked":""}  />i18n_udsi.message.publisherGroup_n81i&nbsp;
							<input type="radio" name="detectionSetInfo.viewLevel" id="" value="3"  ${detectionSetInfo.viewLevel eq "3"?"checked":""} />i18n_udsi.message.allInSys_n81i&nbsp;
						</c:if>
						<c:if test="${ADMFlag }">
							<input type="radio" name="detectionSetInfo.viewLevel" id="" value="4"  ${detectionSetInfo.viewLevel eq "4"?"checked":""} />i18n_udsi.message.unlimited_n81i&nbsp;
						</c:if>
						<br />
					</td>
					<td class="td_1"  id="usergroup">i18n_udsi.text.userGroup_n81i</td>
					<td class="td_2"  id="usergroup">
						<select name="detectionSetInfo.createUserGroupId" id="usergroupid">
							<option selected="selected" value="">
								i18n_udsi.text.selectUserGroup_n81i
							</option>
							<c:forEach items="${setxtjs}"  var="stjs">
									<option   value="${stjs.jsbh}" ${detectionSetInfo.createUserGroupId == stjs.jsbh?"selected":""}>
											${stjs.jsmc}
									</option>
							</c:forEach>
						</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_udsi.text.planCheckTime_n81i
					</td>
					<td class="color_3" align="left">
						<input name="detectionSetInfo.planCheckTime"
								id="planCheckTime" type="text" value="<fmt:formatDate value="${detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1})"/>
					</td>
					<td class="color_1" align="right">
						i18n_udsi.text.checkGap_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.checkGap"
								id="checkGap" value="${detectionSetInfo.checkGap }"/>
						<font color="red">*i18n_udsi.message.checkGapInfo1_n81i</font>
					</td>
				</tr>
				<tr>
					<!-- 
					<td class="color_1" align="right">
						上传监测数据时间间隔(分钟)
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.uploadGap"
								id="uploadGap" value="${detectionSetInfo.uploadGap }"/>
						<font color="red">*</font>
					</td>
					 -->
					<td class="color_1" align="right">
						i18n_udsi.text.checkOutTime_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.checkOutTime" id="checkOutTime" 
								value="${detectionSetInfo.checkOutTime }"/>
						<font color="red">*</font>
					</td>
					<td class="color_1" align="right">
						i18n_udsi.text.checkMaxTimes_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.checkMaxTimes" id="checkMaxTimes" 
								value="${detectionSetInfo.checkMaxTimes }"/>
						<font color="red">*</font>		
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap"  class="color_1" align="right">
						i18n_udsi.text.detectionSetState_n81i
					</td>
					<td nowrap="nowrap"  colspan="3" class="color_6" align="left">
						<input type="radio" name="detectionSetInfo.detectionSetState" id="detectionSetState" value="1" 
							<c:if test="${detectionSetInfo.detectionSetState == '1' }">checked="checked"</c:if> />i18n_udsi.message.valid_n81i
						<input type="radio" name="detectionSetInfo.detectionSetState" id="detectionSetState" value="0"
							<c:if test="${detectionSetInfo.detectionSetState == '0' }">checked="checked"</c:if> />i18n_udsi.message.invalid_n81i						
					</td>
				</tr>
				<tr class="controlstarts">
					<td class="color_1" align="right">
						i18n_udsi.text.isControlStart_n81i
					</td>
					<td class="color_6" colspan="3" align="left">
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="0" <c:if test="${detectionSetInfo.isControlStart == '0' }">checked="checked"</c:if> class="controlstart" />i18n_udsi.message.manually_n81i
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="1" <c:if test="${detectionSetInfo.isControlStart == '1' }">checked="checked"</c:if> class="controlstart"/>i18n_udsi.message.singleStart_n81i
						<span class="controlstart3">
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="2" <c:if test="${detectionSetInfo.isControlStart == '2' }">checked="checked"</c:if> class="controlstart"/>i18n_udsi.message.cycleStart_n81i
						</span>
					</td>
				</tr>
				<tr class="bsd">
					<td class="color_1" align="right">
						i18n_udsi.text.controlStartTime_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input name="detectionSetInfo.controlStartTime"
								id="controlStartTime" type="text" value="<fmt:formatDate value="${detectionSetInfo.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1})"/>
					</td>
				</tr>
				<tr class="asd">
					<td class="color_1" align="right">
						i18n_udsi.text.processFile_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processFile" id="processFile" value="${detectionSetInfo.processFile}"/>			
						<font color="red">*</font>
					</td>
				</tr>
				<tr class="csd">
					<td class="color_1" align="right">
						i18n_udsi.text.processSearchCode_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processSearchCode" id="processSearchCode" value="${detectionSetInfo.processSearchCode}"/>
						<font color="red">*i18n_udsi.message.processSearchCode_n81i</font>
					</td>
				</tr>
				<tr class="dsd">
					<td class="color_1" align="right">
						i18n_udsi.text.processPath_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processPath" id="processPath" value="${detectionSetInfo.processPath}"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr class="esd">
					<td class="color_1" align="right">
						i18n_udsi.text.scriptFile_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<c:if test="${not empty myFileFileName}">
							<a title="i18n_udsi.text.download_n81i" href="#" class="downloadA" id="scriptFile">${myFileFileName}</a>&nbsp;&nbsp;
						</c:if>
						<input type="button" value="i18n_udsi.text.scriptFile_n81i" title="i18n_udsi.text.scriptFile_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
						<input type="file" name="myFile" id="myFile" value="" onchange="javascript:setValue(this.value)"/>
						<c:if test="${not empty myFileFileName}">
							<font color="red">i18n_udsi.message.scriptFile_n81i</font>
						</c:if>
						<c:if test="${empty myFileFileName}">
							<font color="red">*</font>
						</c:if>
					</td>
				</tr>
				<c:if test="${session.emailFlag==0 }">			
					<tr id="userEmail_Line">
						<td class="color_1" align="right">
							i18n_udsi.text.user_n81i
						</td>
						<td class="color_3" colspan="3" align="left">
							<font color="red" id ="lxr"></font>
							<input type="checkbox" name="checkAll" value="1"  /> i18n_udsi.text.selectAll_n81i&nbsp;
							<!-- 
							<input type="button" name="checkOther" value="反选" /> 
							 -->
							<div id="userEmail" style="width: 100%;height: 50px; overflow-y: scroll; word-wrap: break-word;word-break:normal; ">
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_udsi.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()" value="i18n_udsi.button.reset_n81i"/>
					</td>
				</tr>
			</table>
		<script type="text/javascript">onLoad();</script>
		</form>
		</div>
	</body>
</html>
