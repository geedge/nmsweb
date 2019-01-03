<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
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
		<title>i18n_adsi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery1.11.3.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
            src="<c:url value='/js/WebCalendar.js' />"></script>
        <script type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js' />"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
	
	function add(){
		if(checkSpecial($("#processIdenName").val())){
			$("#processIdenName").next().html("i18n_adsi.message.inputInfo_n81i");
			return;
		}
		
	    var type = $("#checkTypeId").find("option:selected").val();
		var startType = $("input[id='isControlStart']:checked").val();
		var userViewLevel = $("input[type=radio][name='detectionSetInfo.viewLevel']:checked").val();
		var emailFlag=${session.emailFlag==0 };
		var checkedSize = $("#userEmail input[name=userEmailIds]:checked").size();
		
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
				            		$("#jdz").html("i18n_adsi.message.noValidNodes_n81i");
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
				$("#usergroupid").next().html("i18n_adsi.message.usergroupid_n81i");
				return;
			}
		}
		
		//去空格
		$("#processIden").val($.trim($("#processIden").val()));
		
		if(false == (
				$id("processIdenName","","i18n_adsi.message.processIdenName_n81i") && $id("checkTypeId","xz","i18n_adsi.message.checkTypeId_n81i")
				&& $id("processIden","","i18n_adsi.message.processIden_n81i") && containSpecial1("processIden", "i18n_adsi.message.processIden_n81i") 
				&& $id("checkGap","sz","i18n_adsi.message.checkGapTitle_n81i")  
	    		&& $id("checkOutTime","sz","i18n_adsi.message.checkOutTime_n81i") && $id("checkMaxTimes","sz","i18n_adsi.message.checkMaxTimes_n81i")
    		)) {
			return;
		}
		if(Number(type)==8){
			if(Number(type) > 7 && startType == 0){ // 手动启动
				if(false ==(
						$id("processFile","","i18n_adsi.message.processFile_n81i")
						|| $id("processSearchCode","","i18n_adsi.message.processSearchCodeTitle_n81i")
					)){
					alert("i18n_pidFile.keyword.allblank_n81i");
					return;
				}
			}
			if(Number(type) > 7 && startType == 1){ // 单次启动
				if(false ==(
						$id("processFile","","i18n_adsi.message.processFile_n81i")
						|| $id("processSearchCode","","i18n_adsi.message.processSearchCodeTitle_n81i")
					)){
					alert("i18n_pidFile.keyword.allblank_n81i");
					return;
				}else{
					if(! $id("processPath","","i18n_adsi.message.processPathTitle_n81i")){
						return;
					}
				}
			}
			if(Number(type) > 7 && startType == 2){ // 周期启动
				if($("#myFile").val()==''){
					$("#myFile").next().html("i18n_adsi.message.myFile_n81i");
					return;
				}
			}
		}
		
		
		/* TODO */
   		if($("#checkGap").val() >=5){
   			if(userViewLevel!=4 && userViewLevel!=1 && emailFlag){//不是自己和无限制
    			if(checkedSize>0){//有选中
	    			document.Mkform.action="<%=path%>/detection/detectionSet.do?action=doAdd";
					document.Mkform.submit();		
    			}else{//无选中
    				$("#lxr").html("i18n_adsi.message.leastOneUser_n81i<br>");
    				return;
    			}
    		}else{
    			document.Mkform.action="<%=path%>/detection/detectionSet.do?action=doAdd";
				document.Mkform.submit();	
    		}
   		}else{
   			$("#checkGap").next().html("i18n_adsi.message.checkGapInfo_n81i");
   			return;
   		}   
	}
	
	//验证非中文和特殊字符
	function containSpecial1(id,info)       
	{       
   		var s = document.getElementById(id).value;
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		if((cs.test(s))){
   			return true;
   		}else{
   			$("#pIdenFont").html("<div style='display:inline'><font color='red'>i18n_adsi.message.pIdenFont_n81i</font></div>");
   			return false;
   		}
	} 
	
	function goBack(){
		window.location="<%=path%>/detection/detectionSet.do?action=query";	
	}

	function sreachNode(ngId){
		$("#addNip").empty();
		$("#addNip").append("<option value=''>i18n_adsi.message.selectDefault_n81i</option>");
		if(ngId!=null && ngId!=""){
			jQuery.post("<%=path%>/detection/detectionSet.do?action=getAllNode",
			{"gid":ngId},function(datas){
				
				$.each(datas, function(k, da) {	
					$("#addNip").append("<option value="+da+">"+da+"</option>");
				});	       
			},"json");
		}
	}
	
	function onLoad(){   
		var checkType = document.Mkform.checkTypeId.value;
		var startType = $("input[id='isControlStart']:checked").val();
		var is = $('#checkTypeId').find("option:selected").attr('issn');
		
		//alert(checkType + "," + startType + "," + is);
		
		if(checkType <= 7){
			$(".controlstarts").css('display','none');			
			$(".asd").css('display','none');			
			$(".bsd").css('display','none');
			$(".dsd").css('display','none');
			$(".csd").css('display','none');			
			$(".esd").css('display','none');			
		}else if(checkType == 8){
			$(".controlstarts").removeAttr("style");
			$(".controlstart3").css('display','none');
			$(".asd").removeAttr("style");
			$(".csd").removeAttr("style");				
			$(".esd").css('display','none');
			if(startType==1){					
				$(".bsd").removeAttr("style");
				$(".dsd").removeAttr("style");
			} else if(startType==0){						
				$(".bsd").css('display','none');
				$(".dsd").css('display','none');
			}
		}else{ //大于8 不是默认的
			if(!is || is=="2"){//不是SNMP
				$(".controlstarts").removeAttr("style");
				$(".controlstart3").removeAttr("style");
				if(startType==0) {
					$(".asd").removeAttr("style");
					$(".csd").removeAttr("style");
					$(".bsd").css('display','none');
					$(".dsd").css('display','none');
					$(".esd").css('display','none');
				} else if(startType==1) {
					$(".asd").removeAttr("style");
					$(".bsd").removeAttr("style");
					$(".dsd").removeAttr("style");
					$(".csd").removeAttr("style");
					$(".esd").css('display','none');
				} else if(startType==2) {
					$(".bsd").removeAttr("style");
					$(".esd").removeAttr("style");
					$(".asd").css('display','none');
					$(".csd").css('display','none');
					$(".dsd").css('display','none');
				}
			} else { // SNMP
				$(".controlstarts").css('display','none');			
				$(".asd").css('display','none');			
				$(".bsd").css('display','none');
				$(".dsd").css('display','none');
				$(".csd").css('display','none');			
				$(".esd").css('display','none');
			}
		}
	}
	
	$(function(){
		$("#checkTypeId").change(function(){
			$("#jj").text("*");
			var startType = $("input[id='isControlStart']:checked").val();	
			var selId=$(this).val();
			var is = $(this).find("option:selected").attr('issn');
			$("#cpId").val(selId);
			
			if(selId <= 7){							
				$("input[id='isControlStart'][value=1]").attr('checked','checked');
				$("#isSnmpType").val("n");
			
			} else if(selId == 8){//默认的进程
				$("input[id='isControlStart'][value=0]").attr('checked','checked');
				$("#isSnmpType").val("n");

			} else{//大于8 不是默认的，判断是否为SNMP监控
				
				if(!is || is=="2"){//不是SNMP
					$("input[id='isControlStart'][value=2]").attr('checked','checked');
					$("#isSnmpType").val("n");
				
 				}else{ // SNMP
					$("input[id='isControlStart'][value=0]").attr('checked','checked');
					$("#isSnmpType").val("y");
				}
			}
			
			onLoad();
		})
		
		//jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
		//-- 查看权限事件绑定
	 	jQuery("input[type=radio][name='detectionSetInfo.viewLevel']").click(function(){
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
	 			jQuery("#usergroupid").val("");
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
		 		$.post("<%=path%>/detection/detectionSet.do?action=queryUserInfo",{viewType:$("input[type=radio][name='detectionSetInfo.viewLevel']:checked").val(),userGroupId:$("#usergroupid").val()},function(datas){viewUserEmail(datas);},"json");
	 		}else{
	 			$("#userEmail").text("");
	 		}
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
	 			//if($(this).val()==1){//全选
	 				//$(this).next().attr('checked',false);
	 				$("#userEmail input[type='checkbox']").attr('checked',$(this).attr('checked'));
	 			//}else{//反选
	 			//}
	 		}
	 	});
	 	$("#userEmail span input[type='checkbox']").on(
	 	'click',function(){
	 		if($("#userEmail input[type='checkbox']").size()==$("#userEmail input[type='checkbox']:checked").size()){	//达成全选
	 			$("input[type='checkbox'][ name='checkAll']:first").attr('checked',true);
	 		}else{	//未达成全选
	 			$("input[type='checkbox'][ name='checkAll']:first").attr('checked',false);
	 		}
	 	});
	 	jQuery("input[type=radio][name='detectionSetInfo.viewLevel']:first").trigger('click');
	})
	$(document).ready(function(){
		$(".controlstart").change(function(){
			onLoad();
		})
	})
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		var type = $("#checkTypeId").find("option:selected").val();//所选监测类别
		if(type == null || type ==""){
			$("#jj").text("i18n_adsi.message.monitorCategory_n81i");
			return;
		}
		var groupId = jQuery("#groupId").val();//选中节点组
		var nodeId = jQuery("#nodeIp").val();//选中ip	
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&groupId="+groupId+"&nodeId="+nodeId; //转向网页的地址;
		var name; 
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
		
		
		/* if(window.hasOpenWindow){
			window.newWindow.focus();
		}
		var openOption = 'width=850px,height=560px,left='+(window.screen.width-850)/2+',top='+(window.screen.height-30-650)/2;
		window.hasOpenWindow = true;
		window.newWindow = window.open(url,name,openOption);
		var loop = setInterval(function(){
			if(newWindow.closed) {
				clearInterval(loop);
				top.$("#ly").css("display", "none");
			}
		}, 500);
		
		top.$("#ly").css("display", "block");
		top.$("#ly").width(parent.document.body.clientWidth);
		top.$("#ly").height(parent.document.body.clientHeight); */
		
		/* document.all.ly.style.display="block";
		document.all.ly.style.width=document.body.clientWidth;
		document.all.ly.style.height=document.body.clientHeight; */
	}
	
	function reciveNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps){
			document.getElementById("groupIdShow").value = nodeGroupNames;//节点组名称s
			document.getElementById("groupId").value = nodeGroupIds;//节点组ids
			document.getElementById("nodeIpShow").value = nodeIps;//节点ips
			document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
	}	
	//选择节点组---end
	
</script>
	<body onload=onLoad()>
		<div class="middle_list" >
			<div class="box_2" style="height: 22px">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_adsi.button.back_n81i"/>
			 </div>
			<input type="hidden" id="cpId"/>
			<form action="" name="Mkform" id="Mkform" method="post" enctype="multipart/form-data">
			<input type="hidden" name="ip" id="ip" value="${ip }" />
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<input type="hidden" id="fw" value="detecSetAdd"/>
			<input type="hidden" id="isSnmpType" value=""/>
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_adsi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_adsi.message.processIdenName_n81i
					</td>
					<td class="color_3" width="20%" align="left">
						<input type="text" name="detectionSetInfo.processIdenName" id="processIdenName" value="" />
						<font color="red">*</font>
					</td>
					<td class="color_1" align="right">
						i18n_adsi.message.processIden_n81i
					</td>
					<td class="color_6" align="left">
						<input type="text" name="detectionSetInfo.processIden" id="processIden" value="${detectSetIden }"/>
						<font id="pIdenFont" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_adsi.message.checkTypeId_n81i
					</td>
					<td class="color_6" align="left" colspan="3">
						<select name="detectionSetInfo.checkTypeInfo.id" id="checkTypeId">
							<option value="">
								i18n_adsi.message.selectDefault_n81i
							</option>
							<c:if test="${fn:length(allCheckTypeInfo) > 0}">
								<c:set var="isSchedule0" value="0"/>
								<c:forEach items="${allCheckTypeInfo}" var="checkType">
									<c:if test="${checkType.isSchedule != isSchedule0 }">
										<option style="height: 2px;" disabled="disabled">--------------------</option>
										<c:set var="isSchedule0" value="${checkType.isSchedule}"/>
									</c:if>
									<option value="${checkType.id}" issn="${checkType.isSnmp }">
										${checkType.checkTypeName1}
									</option>
								</c:forEach>
							</c:if>
						</select>
						<font id="jj" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_adsi.text.nodeGroup_n81i
					</td>
					<td class="color_6" width="30%" align="left">
						<!-- <select name="detectionSetInfo.nodegroup.groupId" id="groupId" onchange="sreachNode(this.value);">
							<option value="">
								i18n_adsi.message.selectDefault_n81i
							</option>
							<c:if test="${fn:length(nodeGroupList) > 0}">
								<c:forEach items="${nodeGroupList}" var="nodeGroup">
									<option value="${nodeGroup.groupId}">${nodeGroup.groupName}</option>
									</c:forEach>
								</c:if>
						</select>  -->
						<input type="text" name="groupIdShow" id="groupIdShow" readonly="readonly" value=""/>&nbsp;
						<input type="hidden" name="detectionSetInfo.nodeGroupsId" id="groupId" value=""/>&nbsp;
						<input type="button" value="i18n_adsi.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
						/>
						<font color="red" id="jdz"></font>
					</td>
					<td class="color_1" width="20%" align="right">
						i18n_adsi.text.nodeIp_n81i
					</td>
					<td class="color_6" width="30%" align="left">
						<input type="text" name="detectionSetInfo.nodeIpsName" id="nodeIpShow" readonly="readonly" value=""/>&nbsp;
						<input type="hidden" name="detectionSetInfo.nodeIpsId" id="nodeIp" value=""/>&nbsp;
						<!--  <select name="detectionSetInfo.nodeIp" id="addNip">
						</select> -->
					</td>	
					
				</tr>
				<tr>
				<td class="td_1">i18n_adsi.text.viewLevel_n81i</td>
					<td class="td_3" id="viewLevel0">
						<c:if test="${!ADMFlag }">
							<input type="radio"	name="detectionSetInfo.viewLevel" id="" value="1" checked="checked" />i18n_adsi.message.publisher_n81i&nbsp;
							<input type="radio"	name="detectionSetInfo.viewLevel" id="viewLevel2" value="2" />i18n_adsi.message.publisherGroup_n81i&nbsp;
							<input type="radio" name="detectionSetInfo.viewLevel" id="" value="3" />i18n_adsi.message.allInSys_n81i&nbsp;
						</c:if>
						<c:if test="${ADMFlag }">
							<input type="radio" name="detectionSetInfo.viewLevel" id="" value="4" checked="checked"/>i18n_adsi.message.unlimited_n81i&nbsp;
						</c:if>
					</td>
					<td class="td_1"  id="usergroup">i18n_adsi.text.userGroup_n81i</td>
					<td class="td_2"  id="usergroup">
						<select name="detectionSetInfo.createUserGroupId" id="usergroupid">
							<option selected="selected" value="">
								i18n_adsi.message.usergroupid_n81i
							</option>
							<c:forEach items="${setxtjs}"  var="stjs">
									<option   value="${stjs.jsbh}">
											${stjs.jsmc}
									</option>
							</c:forEach>
						</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_adsi.text.planCheckTime_n81i
					</td>
					<td class="color_3" align="left">
						<input name="detectionSetInfo.planCheckTime"
							id="planCheckTime" type="text" readonly
							onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1})"/>
							
					</td>
					<td class="color_1" align="right">
						i18n_adsi.text.checkGap_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.checkGap"
								id="checkGap" value="15"/>
						<font color="red">*i18n_adsi.message.checkGapInfo_n81i</font>
					</td>
				</tr>
				<tr>
					<!-- 
					<td class="color_1" align="right">
						上传监测数据时间间隔(分钟)
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.uploadGap"
								id="uploadGap" value="5"/>
						<font color="red">*间隔必须大于或等于5分钟</font>
					</td>
					 -->
					<td class="color_1" align="right">
						i18n_adsi.text.checkOutTime_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.checkOutTime" id="checkOutTime" value="5"/>
						<font color="red"><span class="STYLE1">*</span> </font>
					</td>
					<td class="color_1" align="right">
						i18n_adsi.text.checkMaxTimes_n81i
					</td>
					<td class="color_3" align="left">
						<input type="text" name="detectionSetInfo.checkMaxTimes" id="checkMaxTimes" value="1"/>
						<font color="red"><span class="STYLE1">*</span> </font>		
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_adsi.text.state_n81i
					</td>
					<td class="color_3" align="left" colspan="3">
						i18n_adsi.text.runAble_n81i
					</td>
				</tr>
				<tr class="controlstarts">
					<td class="color_1" align="right">
						i18n_adsi.text.controlstart_n81i
					</td>
					<%-- TODO --%>
					<td class="color_6" colspan="3" align="left">
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="0" checked="checked" class="controlstart" />i18n_adsi.message.manually_n81i
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="1" class="controlstart" />i18n_adsi.message.singleStart_n81i
						<span class="controlstart3">
						<input type="radio" name="detectionSetInfo.isControlStart"
								id="isControlStart" value="2" class="controlstart" />i18n_adsi.message.cycleStart_n81i</span>
					</td>
				</tr>
				<tr class="bsd">
					<td class="color_1" align="right">
						i18n_adsi.text.controlStartTime_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input name="detectionSetInfo.controlStartTime"
								id="controlStartTime" type="text" readonly
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1})"/>
					</td>
				</tr>
				<tr class="asd">
					<td class="color_1" align="right">
						i18n_adsi.message.processFile_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processFile" id="processFile" value=""/>
						<font color="red">* i18n_pidFile.keyword.allblank_n81i</font>
						<!-- <input type="file" id="processFile" value="" name="deteProcessFile" class="filebtn1"/>						
						<input type="hidden" id="ppPath" name="detectionSetInfo.processFile"/> -->
					</td>
				</tr>
				<tr class="csd">
					<td class="color_1" align="right">
						i18n_adsi.message.processSearchCodeTitle_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processSearchCode" id="processSearchCode" value=""/>
						<font color="red">* i18n_adsi.message.processSearchCode_n81i</font>
					</td>
				</tr>
				<tr class="dsd">
					<td class="color_1" align="right">
						i18n_adsi.message.processPathTitle_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="text" name="detectionSetInfo.processPath" id="processPath" value=""/>
						<font color="red">* i18n_adsi.message.processPath_n81i</font>
					</td>
				</tr>
				<%-- TODO --%>
				<tr class="esd">
					<td class="color_1" align="right">
						i18n_adsi.text.myFile_n81i
					</td>
					<td class="color_3" colspan="3" align="left">
						<input type="button" value="i18n_adsi.text.myFile_n81i" title="i18n_adsi.text.myFile_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
						<input type="file" name="myFile" id="myFile" value="" onchange="javascript:setValue(this.value)"/>
						<font color="red">*</font>
					</td>
				</tr>	
				<c:if test="${session.emailFlag==0 }">		
					<tr id="userEmail_Line">
						<td class="color_1" align="right">
							i18n_adsi.text.user_n81i
						</td>
						<td class="color_3" colspan="3" align="left">
							<font color="red" id ="lxr"></font>
							<input type="checkbox" name="checkAll" value="1"  /> i18n_adsi.message.checkAll_n81i&nbsp;
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
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_adsi.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()" value="i18n_adsi.button.reset_n81i"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
