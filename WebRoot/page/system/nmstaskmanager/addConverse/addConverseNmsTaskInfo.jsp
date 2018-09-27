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
		<title>i18n_acnti.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<!-- 日期插件 -->
	<script type="text/javascript">
	
	//返回：查询记录
	function callBack(){
	    //由于返回后进行的操作是重新查询一边列表，且新增时的一些字段名和查询时的字段名相同，后台查询时会按填写的一些信息去查询，所以要清空查询的字段
	    //document.getElementById("missionName").value = "";//清空任务名称
	    var url = window.location.href;
	    if(url.indexOf("toAddConverseTaskPage")!=-1){
	    	document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
	    }else{
	 		document.yhForm.action ="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults&missionId=${missionId}&result="+'${result}'+"&ip="+'${ip}'+"&tabs="+'${tabs}';
	    }
		document.yhForm.submit();
	}
	
	//新增逆向（升级部署）时，对于非空字段的检查
	function checkValue(){
		$("#missionName").next().html("*");
		$("#jdz").html("*");
		$("#usergroupid").next().html("*");
		$("#commandEName").next().html("*");
		$("#returnPath").next().html("*");
		$("#missionDesc").next().html("");
	    //任务名称非空
		var missionval =  jQuery("#missionName").val();
		var nodeListIdShow =  jQuery("#nodeListIdShow").val();
		var nodeGroupsId =  jQuery("#nodeGroupsId").val();
		if(missionval==null||missionval==""){
			$("#missionName").next().html("i18n_acnti.message.missionName_n81i");
			return  false;
		}
		//节点组非空
		if(nodeListIdShow==null||nodeListIdShow==""||nodeGroupsId==null||nodeGroupsId==""){
			$("#jdz").html("i18n_acnti.message.jdz_n81i");
			return  false;
		}else {
			//当ip为空时，验证所选节点组内是否包含有效节点
			var nodeIds = jQuery("#nodeIp").val();//节点ids:nodeIds为选中的节点的id（用逗号连接的）
			if(nodeIds=="") {
				var validIpFlag = true;
				jQuery.ajaxSetup({async:false});
				jQuery.post("<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=getNodesByNodeGroupId",{"groupId":nodeGroupsId},
				            function(datas){
				            	if(datas.length==0){//所选节点组内无有效的节点
				            		alert("i18n_acnti.message.nodeIp_n81i");
				            		validIpFlag = false;
				            		return false;
				            	}
							},
							"json");
				if(!validIpFlag) {return false;}
			}
		}
		
		
		//若查看权限为用户组，则用户组非空
		if(jQuery("input[type='radio'][name='missionstatetable.viewLevel']:checked").val()==2){
			if(jQuery("#usergroupid>option:selected").val()==""){
				$("#usergroupid").next().html("i18n_acnti.message.usergroupid_n81i");
				return false;
			}
		}
		
	    //等待时间：可以为空，不为空时要为数字
	    if(document.getElementById("maxWaitTime")!=null&&document.getElementById("maxWaitTime").value!="") {
		    if(!$id('maxWaitTime','sz',"i18n_acnti.message.maxWaitTime_n81i")) {
		    	return false;
		    }
	    }
		if (!(checkValEmptyByEach("text","paramM6[","].cover","i18n_acnti.text.cover_n81i") 
					 && checkValEmptyByEach("text","paramM6[","].source","i18n_acnti.text.source_n81i") 
					 && checkValEmptyByEach("text","paramM6[","].startupFile","i18n_acnti.text.startupFile_n81i")
					 && checkValEmptyByEach("text","paramM6[","].pidFile","i18n_acnti.text.pidFile_n81i")
					 && checkValEmptyByEach("text","paramM6[","].backup","i18n_acnti.text.backup_n81i")
					 && checkValEmptyByEach("text","paramM6[","].backupTo","i18n_acnti.text.backupTo_n81i"))){
			return false;
		}
		var missionDescVal = $("#missionDesc").val();
		if(missionDescVal.length>100){
			$("#missionDesc").next().html("i18n_acnti.message.missionDesc_n81i");
			return false;
		}
		return true;
	}
	
	//非空字段检查时调用的公用方法
	function checkValEmptyByEach(type, sname, ename, desc){
		var flag = true;
		jQuery("#file_Td input[type='" + type + "'][name^='" + sname + "'][name$='" + ename + "']").each(function(i,n){
			jQuery(n).next().html("*");
			if(jQuery(n).val()==""){
				jQuery(n).next().html(desc + "i18n_acnti.message.notNull_n81i");
				flag = false;
				return  false;
			}
		});
		return flag;
	}
	
	//添加操作
	function add(){
		if(checkValue()){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=saveConverseTask";
			document.yhForm.submit();		
		}
	}
	 
	//新增相似任务时初始化内容-----------------开始
	//逆向任务页面展示：升级部署
	function initShowInfotag(){
	 		//-- 页面表单处理
	 		jQuery("tr[id^='commandexe']").show();
	}
	 
	//命令参数的删除标签+升级部署的备份参数的删除标签是否显示
	function initDeleteSpan() {
	    var missionType = ${missionstatetable.missionType};
	    //如果命令个数大于1，则显示删除
        if($("#file_Td > div[divType=file_div]").size()>1) {
			 $("#file_Td > div[divType=file_div] > span").show();
		}
		//如果是升级部署，则显示所有备份参数的删除
		if(missionType==6) {
		     $("#file_Td td > div[divType=file_div] > span[id='del_backup_span']").show();//显示备份参数的删除??
		}
	}
	
	//新增相似任务时初始化联系人
	function initContactor(){	 
	 		if(${missionstatetable.viewLevel=='1'}){	//个人
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');//控制查看权限行的样式
	 			//隐藏联系人选项 但进行默认选择
	 			$("#userEmail_Line").hide();
	 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:"1"},function(datas){initUserEmail(datas);},"json");
	 		}else if(${missionstatetable.viewLevel=='2'}){	//用户组显示且必选
	 			//显示 用户组选项
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 			//显示联系人 清空联系人选项
	 			$("#userEmail_Line").show();
	 			if($("#usergroupid").val() != ""){
		 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:$("input[type=radio][name=missionstatetable.viewLevel]:checked").val(),userGroupId:$("#usergroupid").val()},function(datas){initUserEmail(datas);},"json");
		 		}else{
		 			$("#userEmail").text("");
		 		}
		 		resize();
	 		}else if(${missionstatetable.viewLevel=='3'}){	//系统
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");//让用户组为空值，即显示“请选择用户组”？？？
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//显示联系人 清空联系人选项
		 		$("#userEmail_Line").show();
	 			//请求获取用户Email信息 默认全选
	 			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryUserInfo",{viewType:"3"},function(datas){initUserEmail(datas);},"json");
	 			resize();
	 		}
	 }
	 
	 //初始化联系人时调用的回调方法
	 function initUserEmail(datas){
	 		$("#userEmail").text("");//清空联系人内容
	 		var checked = "";
	 		var contactorIds = ","+"${missionstatetable.contactUserIds}"+",";
	 		//alert(contactorIds+"="+datas.length);
	 		if(datas!=null){
	 		    var subStr = "";
			 	for(var i = 0;i<datas.length;i++){
			 	    subStr = ","+datas[i].yhid+",";
			 	    //alert(subStr);
			 	    if(contactorIds.indexOf(subStr)>=0) {
			 	        checked = "checked";//如果用户id在missionstatetable.contactUserIds里，则默认选中，否则不选中
			 	    }
			 		$("#userEmail").append("<span title='"+datas[i].email+"' ><input type='checkbox' name='userEmailIds' value='"+datas[i].yhid+"' " + checked+ " /> "+datas[i].yhmc+"</span>");
			 		if(i!=0&&i%10==0){$("#userEmail").append("<br />")}//联系人显示的时候10个换行
			 		checked = "";
			 	}
			 	$("#userEmail span").attr("width",'100px');
	 		}
	 }
	 //新增相似任务时初始化内容-----------------结束
	
	
	//-- onLoad
	jQuery(function(){
	    //新增相似任务时初始化
	    initShowInfotag();//初始化时根据任务类型初始化页面的显示及隐藏
	 	initDeleteSpan();//命令参数的删除标签+升级部署的备份参数的删除标签是否显示
	 	initContactor();//新增相似时初始化联系人
	 	
	 	
	 	
	 	//-- 对页面表单控件加入 统一CSS样式
	 	jQuery("input[type='text']").css("width","200px");
	 	jQuery("input[type='file']").css("width","275px");
	 	jQuery("select").css("width","204px");
	 	
	 	//-- 查看权限 事件绑定
	 	jQuery("input[type='radio'][name='missionstatetable.viewLevel']").click(function(){
	 	
	 		if(jQuery(this).val() == 1){	//个人
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');//控制查看权限行的样式
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
	 	
	 	//多文件添加事件:
	 	//添加推送文件：文件推送+升级部署
	 	//添加操作：命令执行
	 	$("#add_file_span").click(function(){
	 		//var pLength = $("#file_Td > div[divType=file_div]").size();
	 		var pLength = $("#file_Td input[id=index]:last").attr('name');//因为有删除的情况，所以取最后一个，如有0,1,2,3,4，删除0和3和4，那最大的就是2，那新加的就是3
	 		if(pLength==undefined) {//如果一个也没有，则默认为0
	 			pLength = 0;
	 		} else {
	 		    var start = pLength.indexOf('[')+1;
	 		    var end = pLength.indexOf(']');
	 		    pLength = Number(pLength.substring(start,end)) + 1;
	 		}
	 		var htmlDiv = "";
	 		//var model = jQuery("#commandId>option:selected").attr('model');//只对命令执行中的命令和升级部署有用
	 		model = "OtherUpgradeTemplate";
			if(model!=null && model!=""){
		 		htmlDiv = $("#"+model).html().replace(new RegExp("\\[0\\]","g"),"["+pLength+"]");//模板生成新的内容时需要改变下标：0,1,2,3...
		 		$("#file_Td").append(htmlDiv);//添加一组命令参数
		 		if($("#file_Td > div[divType=file_div]").size()>1){//如果命令个数大于1，则显示删除
					$("#file_Td > div[divType=file_div] > span").show();
				}
				//特殊处理 给radio选项一些初始值
				$("#file_Td input[type=radio][name$='[" + pLength + "].isAbs']").attr("checked", "checked");//相对、绝对路径的初始值
				$("#file_Td input[type=radio][name$='[" + pLength + "].isCreateCover']").attr("checked", "checked");//创建、不创建的初始值
	 		}else{
	 			$("#mlmc").html("i18n_acnti.message.mlmc_n81i");
	 			return;
	 		}
			resize();
		});
		//文件删除事件
		$("#del_file_span").live("click",function(){
			$(this).parent().remove();//删除对应的一组参数
			//$("#file_Td > div[divType=file_div]:last").remove();
			if($("#file_Td > div[divType=file_div]").size()==1){
				$("#file_Td > div[divType=file_div]:first > span").hide();
			}
		});
		
		//多备份添加事件
	 	$("#add_backup_span").live("click",function(){
	 		var backupTd = $(this).parent().attr("id");
	 		var startPLength = backupTd.indexOf('[')+1;
	 		var endPLength = backupTd.indexOf(']');
	 		var pLength = Number(backupTd.substring(startPLength,endPLength));//backup_Td[0],备份父标签编号
	 		
	 		var backupLength = $("#file_Td td[id='" + backupTd + "'] input[id=backUpIndex]:last").attr('name');//因为有删除的情况，所以取最后一个，如有0,1,2,3,4，删除0和3和4，那最大的就是2，那新加的就是3
	 		if(backupLength==undefined) {//如果一个也没有，则默认为0
	 			backupLength = 0;
	 		} else {
	 		    var start = backupLength.indexOf('[')+1;
	 		    var end = backupLength.indexOf(']');
	 		    backupLength = Number(backupLength.substring(start,end)) + 1;
	 		}
	 		//alert(backupLength);
	 		var htmlDiv = "";
	 			 	   
 			htmlDiv = $("#upgradeBackupTemplate").html().replace(new RegExp("paramM6\\[0\\]","g"),"paramM6["+(pLength)+"]");
 			htmlDiv = htmlDiv.replace(new RegExp("backups\\[0\\]","g"),"backups["+backupLength+"]");
 			//alert(htmlDiv);
			$(this).parent().append(htmlDiv);
			$("#file_Td td[id='" + backupTd + "'] > div[divType=file_div] > span").show();
			
			//升级部署，Agent升级只能有一组备份参数
	 		if($("#commandEName").val()=='upgrade_agent'){
	 			$(this).hide();
	 		}
	 		
			resize();
		});
		
		//多恢复添加事件
	 	$("#add_recovery_span").live("click",function(){
	 		var recoveryTd = $(this).parent().attr("id");
	 		//alert(recoveryTd);
	 		var startPLength = recoveryTd.indexOf('[')+1;
	 		var endPLength = recoveryTd.indexOf(']');
	 		var pLength = Number(recoveryTd.substring(startPLength,endPLength));//backup_Td[0],备份父标签编号
	 		
	 		var recoveryLength = $("#file_Td td[id='" + recoveryTd + "'] input[id=recoveryIndex]:last").attr('name');//因为有删除的情况，所以取最后一个，如有0,1,2,3,4，删除0和3和4，那最大的就是2，那新加的就是3
	 		if(recoveryLength==undefined) {//如果一个也没有，则默认为0
	 			recoveryLength = 0;
	 		} else {
	 		    var start = recoveryLength.indexOf('[')+1;
	 		    var end = recoveryLength.indexOf(']');
	 		    recoveryLength = Number(recoveryLength.substring(start,end)) + 1;
	 		}
	 		//alert(recoveryLength);
	 		var htmlDiv = "";
	 			 	   
 			htmlDiv = $("#upgradeRecoveryTemplate").html().replace(new RegExp("paramM6\\[0\\]","g"),"paramM6["+(pLength)+"]");
 			htmlDiv = htmlDiv.replace(new RegExp("recoverys\\[0\\]","g"),"recoverys["+recoveryLength+"]");
 			//alert(htmlDiv);
			$(this).parent().append(htmlDiv);
			$("#file_Td td[id='" + recoveryTd + "'] > div[divType=file_div] > span").show();
			
			//升级部署，Agent升级只能有一组恢复参数
	 		if($("#commandEName").val()=='upgrade_agent'){
	 			$(this).hide();
	 		}
			resize();
		});
		
		//备份删除事件
		$("#del_backup_span").live("click",function(){
			$(this).parent().remove();
			//Agent升级只能有一组备份参数，删除后将显示添加备份按钮
			if($("#commandEName").val()=='upgrade_agent'){
	 			$("#file_Td span[id=add_backup_span]").show();
	 		}
		});
		
		//恢复删除事件
		$("#del_recovery_span").live("click",function(){
		    $(this).parent().remove();
		    //Agent升级只能有一组恢复参数，删除后将显示添加备份按钮
			if($("#commandEName").val()=='upgrade_agent'){
	 			$("#file_Td span[id=add_recovery_span]").show();
	 		}
		});
		//-- 任务类型：命令执行，命令类型：原生命令 启动 回传文件事件绑定
	 	jQuery("input[type='radio'][name^='paramM4['][name$='].returnFlag']").live("click", function(){
	 		var index = jQuery(this).attr("name").substr(8,1);//指定位置开始指定长度的串
	 		if(jQuery(this).val() == 'Y'){
	 			//显示回传文件
	 			jQuery("#file_Td td[id='returnfile[" + index + "]']").show();
	 			jQuery("#file_Td td[id='maxWaitTime[" + index + "]']").attr('colspan',1);
	 		}else{//隐藏回传文件
	 			jQuery("#file_Td input[type='text'][name='paramM4[" + index + "].returnPath']").val("");
	 			jQuery("#file_Td td[id='returnfile[" + index + "]']").hide();
	 			jQuery("#file_Td td[id=maxWaitTime[" + index + "]']").attr('colspan',3);
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
	 		$("#userEmail").text("");//清空联系人内容
	 		if(datas!=null){
			 	for(var i = 0;i<datas.length;i++){
			 		$("#userEmail").append("<span title='"+datas[i].email+"' ><input type='checkbox' name='userEmailIds' value='"+datas[i].yhid+"'  /> "+datas[i].yhmc+"</span>");
			 		if(i!=0&&i%10==0){$("#userEmail").append("<br />")}//联系人显示的时候10个换行
			 	}
			 	$("#userEmail span").attr("width",'100px');
	 		}
	 		$("input[type='checkbox'][name='checkAll']").attr('checked',true);//勾上全选
	 		$("#userEmail input[type='checkbox']").attr('checked',true);//默认所有联系人都是选中的
	 	}
	 	
	 	//指定联系人 绑定click事件
	 	$("input[type='checkbox'][ name='checkAll']").bind({
	 		click:function(){
	 			if($(this).val()==1){//全选
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
	});
	
	function resize(){
	 	{parent.document.all.I3.height = document.body.scrollHeight;}
	}
	
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		if(nodeLock == 1){
			alert("i18n_acnti.message.nodeLock_n81i");
			return ;
		}
		var groupId = jQuery("#nodeGroupsId").val();//选中节点组
		var nodeId = jQuery("#nodeIp").val();//选中ip	
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&groupId="+groupId+"&nodeId="+nodeId; //转向网页的地址;
		var name; //网页名称，可为空;
		//var iWidth = 800; //弹出窗口的宽度;
		//var iHeight = 560; //弹出窗口的高度;
		//var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
		//var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
		//window.open(url, "selectNodeAndNodeGroup", "height=" + iHeight + ",,innerHeight=" + iHeight + ",width=" + iWidth + ",innerWidth=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no,menubar=yes,location=no,status=yes,resizable=yes");
		
		//改为模式窗口-201301024-hyx---
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
		//alert(nodeGroupIds+" " +nodeGroupNames+" "+nodeIds+" "+nodeIps);
			document.getElementById("nodeListIdShow").value = nodeGroupNames;//节点组名称s
			document.getElementById("nodeGroupsId").value = nodeGroupIds;//节点组ids
			document.getElementById("nodeIpShow").value = nodeIps;//节点ips
			document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
			
	}
	
	
	
	//选择节点组---begin
	function selectNodeGroup2() {
		var nodeGroupIds = jQuery("#nodeGroupsId").val();
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeGroup&nodeGroupIds="+nodeGroupIds; //转向网页的地址;
		var name; //网页名称，可为空;
		var iWidth = 360; //弹出窗口的宽度;
		var iHeight = 560; //弹出窗口的高度;
		var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
		var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
		window.open(url, "selectNodeGroup", "height=" + iHeight + ",,innerHeight=" + iHeight + ",width=" + iWidth + ",innerWidth=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no,menubar=no,location=no,status=yes,resizable=yes");
	}
	
	function reciveNodeGroup(ids,names){
		if(ids!=""&&name!="") {
			document.getElementById("nodeListIdShow").value = names;
			document.getElementById("nodeGroupsId").value = ids;
		}		
	}	
	//选择节点组---end
	
   </script>
   	</head>
	<body class="bc">
	<div class="box_2">
			<input type="button" value="i18n_acnti.button.back_n81i"
				class=btn3_mouseout onclick="javaScript:callBack();"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"/>
		 </div>
	<div class="middle_list">
		<form action="" id="yhForm" name="yhForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionparametertable6.commandType" value="4" />
		<input type="hidden" name="missionName" value="${missionName }" />
		<input type="hidden" name="loopFlag" value="${loopFlag }"  />
		<input type="hidden" name="missionState" value="${missionState }"  />
		<input type="hidden" name="missionType" value="${missionType }"  />
		<input type="hidden" name="pageNo" value="${pageNo }" />
		<input type="hidden" name="pageSize" value="${pageSize }" />
		<input type="hidden" id="fw" value="addConverTask"/>
		<div class="box_2"></div>
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
				  <td class="color_8" colspan="4">i18n_acnti.text.title_n81i</td>
				</tr>
				<tr>
					<td class="td_1" width="100px">i18n_acnti.text.missionType_n81i：</td>
					<td class="td_3" width="45%">
						<input type="hidden" name="missionstatetable.missionType" id="missionType" value="6" />
						i18n_acnti.text.upgrade_n81i&nbsp;
					</td>
					<td class="td_1">i18n_msil.text.systemName_n81i：</td>
					<td class="td_2"><strong>${missionstatetable.systemIdName}</strong><input name="missionstatetable.systemId" type="hidden"  value="${missionstatetable.systemId}" />
					</td>
				</tr>
				<tr>
					<td class="td_1">i18n_acnti.text.missionName_n81i：</td>
					<td class="td_2" colspan="3">
					<input type="text" name="missionstatetable.missionName" id="missionName" value="${missionstatetable.missionName}"/>
					<div id='suggest1' class="ac_results"></div>
					<font color="red">*</font></td></tr>
				<tr>
				<td class="td_1">i18n_acnti.text.nodeGroup_n81i：</td>
					<td class="td_3">
						<input type="text" name="nodeListIdShow" id="nodeListIdShow" readonly="readonly" value="${missionparametertable6.nodeListName }"/>&nbsp;
						<input type="hidden" name="nodeGroupsId" id="nodeGroupsId" value="${missionparametertable6.nodeGroupsId }"/>&nbsp;
						<input type="button" value="i18n_acnti.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
						/>
						<font color="red" id="jdz">*${nodeCheckInfo }</font>
					</td>
					<td class="td_1" width="20%" align="right">
						i18n_acnti.text.nodeIp_n81i
					</td>
					<td class="td_2" width="30%" align="left">
						<input type="text" name="nodeIpShow" id="nodeIpShow" readonly="readonly" value="${missionparametertable6.nodeListName2 }"/>&nbsp;
						<input type="hidden" name="nodeIpsId" id="nodeIp" value="${missionparametertable6.nodeIpsId }"/>&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="td_1">i18n_acnti.text.viewLevel_n81i：</td>
					<td class="td_3" id="viewLevel0">
						<input type="radio"	name="missionstatetable.viewLevel" id="" value="1" 
						        <c:if test="${missionstatetable.viewLevel=='1'}"> checked</c:if>    />i18n_acnti.message.publisher_n81i&nbsp;
						<input type="radio"	name="missionstatetable.viewLevel" id="" value="2" 
						        <c:if test="${missionstatetable.viewLevel=='2'}"> checked</c:if>    />i18n_acnti.message.publisherGroup_n81i&nbsp;
						<input type="radio" name="missionstatetable.viewLevel" id="" value="3" 
						        <c:if test="${missionstatetable.viewLevel=='3'}"> checked</c:if>    />i18n_acnti.message.allInSys_n81i&nbsp;
					</td>
					<td class="td_1"  id="usergroup">i18n_acnti.text.usergroup_n81i：</td>
					<td class="td_2"  id="usergroup">
						<select name="missionstatetable.groupId" id="usergroupid">
							<option  value="">
								i18n_acnti.message.selectUsergroupDefault_n81i
							</option>
							<c:forEach items="${setxtjs}"  var="stjs">
									<option   value="${stjs.jsbh}" 
									      <c:if test="${stjs.jsbh eq missionstatetable.groupId}"> selected</c:if>  >
											${stjs.jsmc}
									</option>
							</c:forEach>
						</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<!-- 命令执行 -->
				<tr id="upgrade_date">
					<td class="td_1" id="upgrade_date">i18n_acnti.text.upgradeTime_n81i：</td>
					<td class="td_2" id="upgrade_date" >
							<input name="missionparametertable6.startTime" id="upgradeTime" type="text"
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)" value="${fn:substring(missionparametertable6.startTime,0,19)}"/>
					</td>
					<td class="td_1" >
						i18n_acnti.text.parentMissionId_n81i：
					</td>
					<td class="td_2">
						<input type="hidden" name="missionparametertable6.version" id="pidFile" value="${missionparametertable6.missionId}" />
						${missionparametertable6.missionId}&nbsp;
					</td>
				</tr>
			
				<tr id="commandexe0">
					<td class="td_1">i18n_acnti.text.commandName_n81i：</td>
					<td class="td_2" colspan="3" id="commandexe_name">
					        <input type="hidden" name="missionparametertable6.commandEName" value="${missionparametertable6.commandEName}" id="commandEName"/>
					        ${missionparametertable6.commandName}
					        <font color="red" id="mlmc"></font>
					        <!-- 模板校验标识参数 0不校验  1校验 -->
							<input type="hidden" name="commandParaCheck" id="commandParaCheck" value="0" />
					</td>
				</tr>
				<!-- 推送文件相关内容 -->
				<tr id="tsfile0">
					<td class="td_1">i18n_acnti.text.commandDesc_n81i</td>
					<td class="td_2" colspan="3" id="file_Td">
						<div id="task1">
							<c:if test="${missionparametertable6.commandEName!='upgrade_agent'}"><!-- Agent不显示，Server和第三方升级部署显示 -->
								<span class="STYLE1" id="add_file_span"  style="color: #000fff; cursor: hand;">i18n_acnti.text.addOperation_n81i</span>
							</c:if>
						</div>
						<jsp:include page="/page/system/nmstaskmanager/addConverse/missionCmdPara6ForNewConverse.jsp" /><!-- 升级部署 -->
					</td>
				</tr>
				<tr>
					<td class="td_1">i18n_acnti.text.missionDesc_n81i：</td>
					<td class="td_2" colspan="3"><textarea name="missionDesc"id="missionDesc" rows="4" style="width: 90%;" >${missionparametertable6.missionDesc}</textarea>
						<font color="red"></font>
					</td>
				</tr>
				<!-- 联系人 -->
				<c:if test="${session.emailFlag==0 }">
					<tr id="userEmail_Line">
						<td class="td_1" align="right">
							i18n_acnti.text.users_n81i：
						</td>
						<td class="td_2" colspan="3" align="left">
							<input type="checkbox" name="checkAll" value="1"  /> i18n_acnti.message.selectAll_n81i&nbsp;
							<div id="userEmail" style="width: 100%;height: 50px; overflow-y: scroll; word-wrap: break-word;word-break:normal; ">
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="color_1" style="text-align: right;" colspan="4">
						<input type="button" onclick="add()" value="i18n_acnti.button.submit_n81i"
							class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_acnti.button.reset_n81i"
							class=btn3_mouseout onclick="javascript:jQuery('#yhForm')[0].reset();"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
					</td>
				</tr>
			</table>
		</form>
		</div>

		<jsp:include page="/page/system/nmstaskmanager/addConverse/converseTaskTemplate.jsp" />
	</body>
</html>
