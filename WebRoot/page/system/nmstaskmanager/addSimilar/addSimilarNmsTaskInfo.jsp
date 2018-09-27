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
		<title>i18n_asnti.message.title_n81i</title>
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
	    //document.getElementById("missionType").value = "0";//清空任务类型
	    //document.getElementById("commandexe_loop0").innerHTML = "";//清空任务类型
	
 		document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
		document.yhForm.submit();
	}
	
	//暂时此方法没有用到
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
	
	//新增时，对于非空字段的检查
	function checkValue(){
		$("#missionName").next().html("*");
		$("#jdz").html("*");
		$("#usergroupid").next().html("*");
		$("#commandEName").next().html("*");
		$("#returnPath").next().html("*");
		$("#missionDesc").next().html("");
		var missionval =  jQuery("#missionName").val();
		var nodeListIdShow =  jQuery("#nodeListIdShow").val();
		var nodeGroupsId =  jQuery("#nodeGroupsId").val();
		if(missionval==null||missionval==""){
			$("#missionName").next().html("i18n_asnti.message.missionName_n81i");
			return  false;
		}
		if(jQuery("[name=missionstatetable.systemId]>option:selected").val()=="") {
			alert("i18n_asnti.message.systemType_n81i");
			return false;
		}
		if(nodeListIdShow==null||nodeListIdShow==""||nodeGroupsId==null||nodeGroupsId==""){
			$("#jdz").html("i18n_asnti.message.jdz_n81i");
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
				            		alert("i18n_asnti.message.noUsedNode_n81i");
				            		validIpFlag = false;
				            		return false;
				            	}
							},
							"json");
				if(!validIpFlag) {return false;}
			}
		
		}
		
		if(jQuery("input[type='radio'][name='missionstatetable.viewLevel']:checked").val()==2){
			if(jQuery("#usergroupid>option:selected").val()==""){
				$("#usergroupid").next().html("i18n_asnti.message.usergroupid_n81i");
				return false;
			}
		}
		
		//文件推送
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==1){
			if(!(checkValEmptyByEach("file","file","Info","i18n_asnti.message.pushFile_n81i")
					 && checkValEmptyByEach("text","paramM1[","].destPath","i18n_asnti.message.pushTarget_n81i"))){
					 	return false;
					 }
		}
		//命令执行
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==4){
		    //最大等待时间：可以为空，不为空时要为数字
		    if(document.getElementById("maxWaitTime")!=null&&document.getElementById("maxWaitTime").value!="") {
			    if(!$id('maxWaitTime','sz',"i18n_asnti.text.maxWaitTime_n81i")) {
			    	return false;
			    }
		    }
			if(jQuery("[name=missionparameteriable4.commandType]:checked").val()!=3){
				if(jQuery("[name=missionparameteriable4.commandEName]>option:selected")==null||jQuery("[name=missionparameteriable4.commandEName]  >option:selected").val()==""){
					$("#commandEName").next().html("i18n_asnti.text.commandEName_n81i");
					return false;
				}
			}
			if(jQuery("[name=missionstatetable.loopFlag]:checked").val()==1){
				if(!$id('zhouqi','sz',"i18n_asnti.text.cycle_n81i")){
					return false;
				}
				if(!$id("missionstatetable.startTime","","i18n_asnti.text.startTime_n81i")){
					return false;
				}
				if(!$id("missionstatetable.endTime","","i18n_asnti.text.endTime_n81i")){
					return false;
				}
				var loopStartTime = document.getElementById("missionstatetable.startTime").value;
				var loopEndTime = document.getElementById("missionstatetable.endTime").value;
				if(loopStartTime>loopEndTime) {
					alert("i18n_asnti.message.TimeInfo1_n81i");
					return;
				}
				var date = new Date();
				
				var dateTimeArr = loopEndTime.split(" ");//loopEndTime界面插件获取的时间，格式为2013-1-25 12:1:1
				var dateArr = dateTimeArr[0].split("-");
				var timeArr = dateTimeArr[1].split(":");
				var loopEndDate = new Date(dateArr[0],dateArr[1]-1,dateArr[2],timeArr[0],timeArr[1],timeArr[2]);			
				
				if(loopEndDate<date) {
					alert("i18n_asnti.message.TimeInfo2_n81i");
					return;
				}
			}
			
			//当'回传标识'选择是时，'回传文件'为必填
			var returnPathFlag = true;
			jQuery("input[type='radio'][name^='paramM4['][name$='].returnFlag']:checked").each(function(i,n){
		 		var index = jQuery(this).attr("name").substr(8,1);//指定位置开始指定长度的串
		 		if(jQuery(this).val() == 'Y'){
		 			//验证回传文件
		 			var returnPathStr = jQuery.trim(jQuery("#file_Td input[type='text'][name='paramM4[" + index + "].returnPath']").val());
		 			if(returnPathStr=="") {
		 				$("#returnPath").next().html("i18n_asnti.message.returnPath_n81i");
		 				returnPathFlag = false;
						return  false;
		 			}
		 		}
	 	    });
	 	    if(!returnPathFlag) {return returnPathFlag; }
			
			if(!(checkValEmptyByEach("text","paramM4[","].backup","i18n_asnti.text.backupFile_n81i") && checkValEmptyByEach("text","paramM4[","].backupTo","i18n_asnti.text.backupTo_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].pidFile","i18n_asnti.text.pidFile_n81i") && checkValEmptyByEach("text","paramM4[","].source","i18n_asnti.text.source_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].cover","i18n_asnti.text.coverFile_n81i") && checkValEmptyByEach("text","paramM4[","].execCmd","i18n_asnti.text.execCmd_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].execResult","i18n_asnti.text.execResult_n81i"))){
							return false;
						}
		}
		
		//升级部署
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==6){
			if($("#commandEName").val()==""){
		    	$("#mlmc").html("i18n_asnti.text.mlmc_n81i");
		    	return false;
		    }
		    //等待时间：可以为空，不为空时要为数字
		    if(document.getElementById("maxWaitTime")!=null&&document.getElementById("maxWaitTime").value!="") {
			    if(!$id('maxWaitTime','sz',"i18n_asnti.text.maxWaitTime1_n81i")) {
			    	return false;
			    }
		    }
			if (!(checkValEmptyByEach("file","file","Info","i18n_asnti.message.pushFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].cover","i18n_asnti.text.coverPath_n81i") 
						 && checkValEmptyByEach("text","paramM6[","].startupFile","i18n_asnti.text.startupFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].pidFile","i18n_asnti.text.pidFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].backup","i18n_asnti.text.backupFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].backupTo","i18n_asnti.text.backupTo_n81i"))){
				return false;			 
			}
		}
		var missionDescVal = $("#missionDesc").val();
		if(missionDescVal.length>100){
			$("#missionDesc").next().html("i18n_asnti.text.charsTooLong_n81i");
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
				jQuery(n).next().html(desc + "i18n_asnti.text.isNotNull_n81i");
				flag = false;
				return  false;
			}
		});
		return flag;
	}
	
	//添加操作
	function add(){
		if(checkValue()){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=savetask";
			document.yhForm.submit();		
		}
	}
	 
	//新增相似任务时初始化内容-----------------开始
	//任务类型页面展示：初始化页面显示及隐藏的内容
	function initShowInfotag(tasktype){
	 	if('1'==tasktype){
	 		jQuery("div[id='task1']").show();
	 		jQuery("div[id='task4']").hide();
	 		//jQuery("tr[id^='tsfile']").show();
	 		jQuery("tr[id^='commandexe']").hide();
	 		jQuery("tr[id='upgrade_date']").hide();
	 		//jQuery("#commandParaCheck").val(1);
	 	}	
	 	if('4'==tasktype){
	 		jQuery("div[id='task1']").hide();
	 		jQuery("div[id='task4']").show();
	 		//jQuery("tr[id^='tsfile']").hide();
	 		jQuery("tr[id^='commandexe']").show();
	 		jQuery("tr[id='upgrade_date']").hide();
	 		var isCycle = jQuery("input[id='_type']:checked").val();
	 		if(isCycle==1) {//是周期任务：周期结束时间和起始时间应该显示
	 			jQuery("tr[id='commandexe_date']").show();
	 		} else {//不是周期任务：周期结束时间和起始时间应该隐藏
	 			jQuery("tr[id='commandexe_date']").hide();
	 		}
	 		jQuery("td[id=commandexe_type]").show();
	 		
	 		jQuery("#commandSource").append(jQuery("#commandEName>option[type]"));
	 		var commandType = "${missionparameteriable4.commandType}";
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type="+commandType+"]"));//按照所选命令类型，决定显示可选的命令名称
	 		
	 		jQuery("td[id=commandexe_name]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 	}
	 	if('6'==tasktype){
	 		//-- 页面表单处理
	 		jQuery("div[id='task1']").show();
	 		jQuery("div[id='task4']").hide();
	 		//jQuery("tr[id^='tsfile']").show();
	 		jQuery("tr[id^='commandexe']").show();
	 		jQuery("tr[id='commandexe_loop']").hide();
	 		jQuery("tr[id='commandexe_date']").hide();
	 		jQuery("tr[id=upgrade_date]").show();
	 		
	 		//jQuery("input[name=missionparameteriable4.commandType]:last").trigger('click');//???
	 		jQuery("#commandSource").append(jQuery("#commandEName>option[type]"));
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type=4]"));//按照所选命令类型，决定显示可选的命令名称
	 		//jQuery("#commandEName").val("");//使命令名称默认为请选择命令名称
	 		
	 		jQuery("td[id=commandexe_type]").hide();
	 		jQuery("td[id=commandexe_name]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		
	 		//-- 命令名称下拉菜单处理
	 		jQuery("#commandSource").append(jQuery("#commandEName>option[type]"));
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type=4]"));
	 		//jQuery("#commandEName").val("");
	 		//jQuery("#commandPara0").val("");
	 		
	 		//升级部署，Agent不可添加多组参数
	 		if(jQuery("#commandEName>option:selected").val()=='upgrade_agent'){
				jQuery("div[id='task1']").hide();
			}else{
				jQuery("div[id='task1']").show();
			}
	 	}
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
	 			//jQuery("#usergroupid").val("");//让用户组为空值，即显示“请选择用户组”？？？
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 			//显示联系人 清空联系人选项
	 			$("#userEmail_Line").show();
	 			//$("#userEmail").text("");//新增相似时不能清空默认的联系人信息
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
		 		//$("#userEmail").text("");//新增相似时不能清空默认的联系人信息
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
	
	 //任务类型页面展示
	 function showInfotag(tasktype){
	 	//重置推送文件操作：改变任务类型前，要先删除之前任务的参数（通过触发删除事件实现）
	 	while(jQuery("#file_Td > div[divType=file_div]").size()>0){
	 		jQuery("#file_Td > div[divType=file_div] > span[id='del_file_span']:first").trigger('click');
	 	}
	 	
	 	if('1'==tasktype){
	 		jQuery("div[id='task1']").show();
	 		jQuery("div[id='task4']").hide();
	 		//jQuery("tr[id^='tsfile']").show();
	 		jQuery("tr[id^='commandexe']").hide();
	 		jQuery("tr[id='upgrade_date']").hide();
	 		//jQuery("#commandParaCheck").val(1);
	 	}	
	 	if('4'==tasktype){
	 		jQuery("div[id='task1']").hide();
	 		jQuery("div[id='task4']").show();
	 		//jQuery("tr[id^='tsfile']").hide();
	 		jQuery("tr[id^='commandexe']").show();
	 		jQuery("tr[id='upgrade_date']").hide();
			var isCycle = jQuery("input[id='_type']:checked").val();
	 		if(isCycle==1) {//是周期任务：周期结束时间和起始时间应该显示
	 			jQuery("tr[id='commandexe_date']").show();
	 		} else {//不是周期任务：周期结束时间和起始时间应该隐藏
	 			jQuery("tr[id='commandexe_date']").hide();
	 		}	 		jQuery("td[id=commandexe_type]").show();
	 		jQuery("input[name=missionparameteriable4.commandType]:first").trigger('click');
	 		jQuery("td[id=commandexe_name]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 	}
	 	if('6'==tasktype){
	 		//-- 页面表单处理
	 		jQuery("div[id='task1']").show();
	 		jQuery("div[id='task4']").hide();
	 		//jQuery("tr[id^='tsfile']").show();
	 		jQuery("tr[id^='commandexe']").show();
	 		jQuery("tr[id='commandexe_loop']").hide();
	 		jQuery("tr[id='commandexe_date']").hide();
	 		jQuery("tr[id=upgrade_date]").show();
	 		jQuery("input[name=missionparameteriable4.commandType]:last").trigger('click');
	 		jQuery("td[id=commandexe_type]").hide();
	 		jQuery("td[id=commandexe_name]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		//-- 命令名称下拉菜单处理
	 		jQuery("#commandSource").append(jQuery("#commandEName>option[type]"));
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type=4]"));
	 		jQuery("#commandEName").val("");
	 		//jQuery("#commandPara0").val("");
	 	}
	 }
	
	//-- onLoad
	jQuery(function(){
	    //新增相似任务时初始化
	    initShowInfotag(jQuery("input[type='radio'][id='missionType']:checked").val());//初始化时根据任务类型初始化页面的显示及隐藏
	 	initDeleteSpan();//命令参数的删除标签+升级部署的备份参数的删除标签是否显示
	 	initContactor();//新增相似时初始化联系人
	 	
		//-- 为 任务类型 绑定 选择事件，用于显示表单
		jQuery("input[type='radio'][id='missionType']").bind({
		 	change : function(){
		 	    //重置推送文件操作
			 	showInfotag(jQuery("input[type='radio'][id='missionType']:checked").val());//控制标签的显示和隐藏
		 		if(jQuery("input[type='radio'][id='missionType']:checked").val()==1){	//如果是推送文件的话，默认显示一组命令参数
				 	var model = jQuery("#commandSource>option[type=5]:first").attr('model');//type=5：文件推送
					//jQuery("#commandPara0").val(model);
					//jQuery("#commandParaCheck").val(1);
					//取模板
					$("#file_Td").append($("#"+model).html());//为推送文件添加第一组命令参数
				}
			}
		});
	 	
	 	//-- 周期任务事件绑定
	 	jQuery("input[type=radio][name=missionstatetable.loopFlag]").click(function(){
	 		if(jQuery(this).val() == 1){	//是周期
	 			jQuery("td[id=commandexe_delay]").show();
	 			jQuery("span[id=commandexe_date]").show();
	 			jQuery("tr[id='commandexe_date']").show();
	 			jQuery("td[id=commandexe_loop0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 		}else{	//非周期
	 			jQuery("td[id=commandexe_delay]").hide();
	 			//jQuery("span[id=commandexe_date]").hide();
	 			jQuery("span[id=commandexe_date]").show();
	 			jQuery("tr[id='commandexe_date']").hide();
	 			jQuery("td[id=commandexe_loop0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		}
	 	});
	 	jQuery("input[type='radio'][name=missionstatetable.loopFlag]:checked").trigger('click');
	 	//-- 命令类型 事件绑定
	 	jQuery("input[type=radio][name=missionparameteriable4.commandType]").click(function(){
	 		jQuery("#commandSource").append(jQuery("#commandEName>option[type]"));
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type="+jQuery(this).val()+"]"));//按照所选命令类型，决定显示可选的命令名称
	 		jQuery("#commandEName").val("");//使命令名称默认为请选择命令名称
	 		//jQuery("#commandEName").trigger('change');
	 		//命令类型改变的时候清空命令参数-hyx-新增没有添加，因为添加之后程序没反应，提示要停止脚本
	 		while(jQuery("#file_Td > div[divType=file_div]").size()>0){
	 		    jQuery("#file_Td > div[divType=file_div] > span[id='del_file_span']:first").trigger('click');
	 	    }
	 	});
	 	
	 	//-- 对页面表单控件加入 统一CSS样式
	 	jQuery("input[type='text']").css("width","200px");
	 	jQuery("input[type='file']").css("width","275px");
	 	jQuery("select").css("width","204px");
	 	//-- 命令名称 事件绑定
	 	jQuery("#commandEName").change(function(){
	 		var model = jQuery("#commandEName>option:selected").attr('model');
	 		//2012-3-8 界面调整后修改
	 		//-- 重置推送文件操作
	 		while(jQuery("#file_Td > div[divType=file_div]").size()>0){
	 			jQuery("#file_Td > div[divType=file_div] > span[id='del_file_span']:first").trigger('click');
	 		}
	 		if(model!=null && model!=""){
	 			$("#file_Td").append($("#"+model).html());
	 			//特殊处理 给radio选项一些初始值
				$("#file_Td input[type=radio][name$='[0].isAbs']").attr("checked", "checked");
				$("#file_Td input[type=radio][name$='[0].isCreateCover']").attr("checked", "checked");
				var tasktype = $("input[name=missionstatetable.missionType]:checked").val();
				if(tasktype=='6'){//升级部署，Agent不可添加多组参数
					if(model=="AgentUpgradeTemplate"){
						jQuery("div[id='task1']").hide();
					}else{
						jQuery("div[id='task1']").show();
					}
				}
	 		}
	 		/*var desc = jQuery("#commandEName>option:selected").attr('desc');
	 		//jQuery("#commandPara0").val(model);
	 		jQuery("#commandSesc").empty();
	 		jQuery("#commandSesc").append(jQuery(desc));
	 		if(model==""){
		 		var pArray = desc.split("：");
		 		var params = "";
		 		if(pArray.length>1){
		 			params = desc.substring(pArray[0].length+1,desc.length);
		 		}
		 		jQuery("#commandPara0").val(params);
		 		jQuery("#commandParaCheck").val(0);
	 		}else{
	 			jQuery("#commandParaCheck").val(1);
	 		}*/
	 	});
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
	 		}else if(jQuery(this).val() ==4){	//系统
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			resize();
	 		}
	 	});
	 	
	 	//多文件添加事件:
	 	//添加推送文件：文件推送+升级部署
	 	//添加操作：命令执行
	 	$("#add_file_span,#add_cmd_span").click(function(){
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
	 		var tasktype = $("input[name=missionstatetable.missionType]:checked").val();//获取任务类型的值：1,4,6
	 		var model = jQuery("#commandEName>option:selected").attr('model');//只对命令执行中的命令和升级部署有用
	 		if('1'==tasktype){	//推送文件
				 model = jQuery("#commandSource>option[type=5]:first").attr('model');//取文件推送的model（模板id）
			}
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
	 			$("#mlmc").html("i18n_asnti.message.selectCommandNameDefault_n81i");
	 			return;
	 		}
			/*var params = $.trim($("#commandPara0").val());
			if(params.length>0){
				var paraArrays = params.split("};");
				if(((params.charAt(params.length-2)+""+params.charAt(params.length-1)))=="};"){
					$("#commandPara0").val(params+""+paraArrays[0]+"};");
				}else{
					$("#commandPara0").val(params+"};"+paraArrays[0]+"};");
				}
			}*/
			resize();
		});
		//文件删除事件
		$("#del_file_span").live("click",function(){
			/*var params = $.trim($("#commandPara0").val());
			var paraArrays = params.split("};");
			var point = $(this).closest("div[divType=file_div]").prevAll("div[divType=file_div]").size();
			var pLength = $("#file_Td > div[divType=file_div]").size();
			var i = 0;
			params = "";
			for(;i<pLength;i++){
				if(i!=point){
					params += paraArrays[i]+"};";
				}
			}*/
			$(this).parent().remove();
			//$("#file_Td > div[divType=file_div]:last").remove();
			if($("#file_Td > div[divType=file_div]").size()==1){
				$("#file_Td > div[divType=file_div]:first > span").hide();
			}
			//$("#commandPara0").val(params);
		});
		
		//多备份添加事件
	 	$("#add_backup_span").live("click",function(){
	 		//var pLength = $("#file_Td > div[divType=file_div]").size();
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
	 		
	 		var htmlDiv = "";
	 		var tasktype = $("input[name=missionstatetable.missionType]:checked").val();
	 		if('6'==tasktype){
	 			htmlDiv = $("#upgradeBackupTemplate").html().replace(new RegExp("paramM6\\[0\\]","g"),"paramM6["+pLength+"]");
	 			htmlDiv = htmlDiv.replace(new RegExp("backups\\[0\\]","g"),"backups["+backupLength+"]");
	 			//升级部署，Agent升级只能有一组备份参数
	 			if(jQuery("#commandEName>option:selected").val()=='upgrade_agent'){
	 				$(this).hide();
	 			}
	 			//htmlDiv = htmlDiv.replace(new RegExp("del_file_span","g"), "del_backup_span");
	 		}
			$(this).parent().append(htmlDiv);
			$("#file_Td td[id='" + backupTd + "'] > div[divType=file_div] > span").show();
			resize();
		});
		//备份删除事件
		$("#del_backup_span").live("click",function(){
			$(this).parent().remove();
			//Agent升级只能有一组备份参数，删除后将显示添加备份按钮
			if(jQuery("#commandEName>option:selected").val()=='upgrade_agent'){
	 			$("#file_Td span[id=add_backup_span]").show();
	 		}
			//var backupTd = $(this).parent().parent().attr("id");
			//$("#file_Td td[id='" + backupTd + "'] > div[divType=file_div]:last").remove();
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
	 	//jQuery("input[type=radio][name=detectionSetInfo.viewLevel]:first").trigger('click');//暂时没用？
	});
	
	function resize(){
	 	{parent.document.all.I3.height = document.body.scrollHeight;}
	}
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		if(nodeLock == 1){
			alert("i18n_asnti.message.nodeLock_n81i");
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
		
		//改为window.open-20180831-chenjs---
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
	function selectNodeGroup() {
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
	
   //新增：重置（重置为文件推送）
   function resetInfo(){
   	   jQuery('#yhForm')[0].reset();
   	   jQuery("input[type='radio'][id='missionType']:checked").trigger('change');
   }
	
   </script>
   	</head>
	<body class="bc">
	<div class="box_2">
		<input type="button" value="i18n_asnti.button.back_n81i"
			class=btn3_mouseout onclick="javaScript:callBack();"
			onmouseover="this.className='btn3_mouseover'"
			onmouseout="this.className='btn3_mouseout'"
			onmousedown="this.className='btn3_mousedown'"
			onmouseup="this.className='btn3_mouseup'"/>
	 </div>
	<div class="middle_list">
		<form action="" id="yhForm" name="yhForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionName" value="${missionName }" />
		<input type="hidden" name="loopFlag" value="${loopFlag }"  />
		<input type="hidden" name="missionState" value="${missionState }" />
		<input type="hidden" name="missionType" value="${missionType }" />
		<input type="hidden" name="pageNo" value="${pageNo }" />
		<input type="hidden" name="pageSize" value="${pageSize }" />
		<input type="hidden" id="fw" value="addSimilarNmstask"/>
		<c:if test="${missionstatetable.missionType=='1'}">
			<c:set var="missionParamterTable" value="${missionparametertable1}"></c:set>
		</c:if>
		<c:if test="${missionstatetable.missionType=='4'}">
			<c:set var="missionParamterTable" value="${missionparameteriable4}"></c:set>
		</c:if>
		<c:if test="${missionstatetable.missionType=='6'}">
			<c:set var="missionParamterTable" value="${missionparametertable6}"></c:set>
		</c:if>
		<div class="box_2"></div>
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
				  <td class="color_8" colspan="4">i18n_asnti.text.title_n81i</td>
				</tr>
				<tr>
					<td class="td_1" width="100px">i18n_asnti.text.missionType_n81i：</td>
					<td class="td_3" width="45%">
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="1" 
						         <c:if test="${missionstatetable.missionType=='1'}">checked</c:if>     />i18n_asnti.message.missionType1_n81i&nbsp;
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="4" 
						         <c:if test="${missionstatetable.missionType=='4'}">checked</c:if>     />i18n_asnti.message.missionType4_n81i&nbsp;
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="6" 
						         <c:if test="${missionstatetable.missionType=='6'}">checked</c:if>     />i18n_asnti.message.missionType6_n81i&nbsp;
					</td>
					<td class="td_1">i18n_asnti.text.systemIdName_n81i：</td>
					<td class="td_2"><strong>${missionstatetable.systemIdName}</strong><input name="missionstatetable.systemId" type="hidden"  value="${missionstatetable.systemId}" />
					</td>
				</tr>
				<tr>
					<td class="td_1">i18n_asnti.text.missionName_n81i：</td>
					<td class="td_2" colspan="3">
						<input type="text" name="missionstatetable.missionName" id="missionName" value="${missionstatetable.missionName}"/>
						<font color="red">*</font>
						<div id='suggest1' class="ac_results"></div>
					</td>
				</tr>
				<tr>
				<td class="td_1">i18n_asnti.text.nodeGroup_n81i：</td>
					<td class="td_3">
						<input type="text" name="nodeListIdShow" id="nodeListIdShow" readonly="readonly" value="${missionParamterTable.nodeListName }"/>&nbsp;
						<input type="hidden" name="nodeGroupsId" id="nodeGroupsId" value="${missionParamterTable.nodeGroupsId }"/>&nbsp;
						<input type="button" value="i18n_asnti.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
						/>
						<font color="red" id="jdz">*${nodeCheckInfo }</font>
						
					</td>
					<td class="td_1" width="20%" align="right">
						i18n_asnti.text.nodeIp_n81i
					</td>
					<td class="td_2" width="30%" align="left">
						<input type="text" name="nodeIpShow" id="nodeIpShow" readonly="readonly" value="${missionParamterTable.nodeListName2 }"/>&nbsp;
						<input type="hidden" name="nodeIpsId" id="nodeIp" value="${missionParamterTable.nodeIpsId }"/>&nbsp;
					</td>	
				</tr>	
								
				<tr>
					<td class="td_1">i18n_asnti.text.viewLevel_n81i：</td>
					<td class="td_3" id="viewLevel0">
						<input type="radio"	name="missionstatetable.viewLevel" id="" value="1" 
						        <c:if test="${missionstatetable.viewLevel=='1'}"> checked</c:if>    />i18n_asnti.message.publisher_n81i&nbsp;
						<input type="radio"	name="missionstatetable.viewLevel" id="" value="2" 
						        <c:if test="${missionstatetable.viewLevel=='2'}"> checked</c:if>    />i18n_asnti.message.publisherGroup_n81i&nbsp;
						<input type="radio" name="missionstatetable.viewLevel" id="" value="3" 
						        <c:if test="${missionstatetable.viewLevel=='3'}"> checked</c:if>    />i18n_asnti.message.allInSys_n81i&nbsp;
					</td>
					<td class="td_1"  id="usergroup">i18n_asnti.text.usergroup_n81i：</td>
					<td class="td_2"  id="usergroup">
						<select name="missionstatetable.groupId" id="usergroupid">
							<option  value="">
								i18n_asnti.message.usergroupDefault_n81i
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
				<td class="td_1" id="upgrade_date">i18n_asnti.text.upgradeDate_n81i：</td>
				<td class="td_2" id="upgrade_date" colspan="3">
						<input name="missionparametertable6.startTime" id="upgradeTime" type="text"
							onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)" value="${fn:substring(missionparametertable6.startTime,0,19)}"/>
				</td>
					<!-- 
				<td class="td_1">版&nbsp;&nbsp;本&nbsp;&nbsp;号：</td>
				<td class="td_2" id="upgrade_date">
					<input name="version" value="${version }" id="version" type="text" readonly="readonly"/>
					<font color="red">*请填入数字类型 </font>
				</td>
					 -->
			</tr>
			
			<tr id="commandexe0">
				<td class="td_1" id="commandexe_type">i18n_asnti.text.commandType_n81i：</td>
				<td class="td_3" id="commandexe_type">
					<input type="radio" name="missionparameteriable4.commandType" value="1" 
					          <c:if test="${missionparameteriable4.commandType=='1'}"> checked</c:if>   />i18n_asnti.message.commandType1_n81i&nbsp;
					<input type="radio" name="missionparameteriable4.commandType" value="2" 
					          <c:if test="${missionparameteriable4.commandType=='2'}"> checked</c:if>   />i18n_asnti.message.commandType2_n81i&nbsp;
					<input type="radio" name="missionparameteriable4.commandType" value="4" style="display: none" 
					          <c:if test="${missionparametertable6.commandType=='4'}"> checked</c:if>    />
				</td>
				<td class="td_1">i18n_asnti.text.missionName_n81i：</td>
				<td class="td_2" id="commandexe_name">
						<select name="commandSource" id="commandSource" style="display:none">
							  <c:if test="${missionstatetable.missionType=='4'||missionstatetable.missionType=='6'}">
									<c:forEach items="${ordertablelist}" var="ordertable">
										<option value="${ordertable.commandName}" type='${ordertable.commandType }' model='${ordertable["commandModel"]}' desc='${ordertable["commandDesc"]}'
										        <c:if test="${ordertable.commandName eq missionParamterTable.commandEName}"> selected</c:if>    >
											${ordertable.commandAlias}
										</option>
									</c:forEach>
							  </c:if>
							  <c:if test="${missionstatetable.missionType=='1'}">
									<c:forEach items="${ordertablelist}" var="ordertable">
										<option value="${ordertable.commandName}" type='${ordertable.commandType }' model='${ordertable["commandModel"]}' desc='${ordertable["commandDesc"]}'
										       >
											${ordertable.commandAlias}
										</option>
									</c:forEach>
							  </c:if>
						</select>
						<select name="missionparameteriable4.commandEName"	id="commandEName">
						        <option  value="" model="" desc="">
									i18n_asnti.text.mlmc_n81i
								</option>
						</select>
						<font color="red" id="mlmc">*</font>
						<input type="hidden" name="commandParaCheck" id="commandParaCheck" value="0" />
					</td>
				</tr>
				<!-- 推送文件相关内容 -->
				<tr id="tsfile0">
					<td class="td_1">i18n_asnti.text.commandDesc_n81i：</td>
					<td class="td_2" colspan="3" id="file_Td">
						<div id="task1"><span class="STYLE1" id="add_file_span"  style="color: #000fff; cursor: hand;">i18n_asnti.text.addPushFile_n81i</span>
						<font color="red">i18n_asnti.message.addPushFile_n81i</font></div>
						<div id="task4"><span class="STYLE1" id="add_cmd_span"  style="color: #000fff; cursor: hand;">i18n_asnti.text.addOperation_n81i</span></div>
						<c:if test="${missionstatetable.missionType=='1'}">
							<jsp:include page="/page/system/nmstaskmanager/addSimilar/missionCmdPara1ForNewSimilar.jsp" /><!-- 文件推送 -->
						</c:if>
						<c:if test="${missionstatetable.missionType=='4'}">
							<jsp:include page="/page/system/nmstaskmanager/addSimilar/missionCmdPara4ForNewSimilar.jsp" /><!-- 命令执行 -->
						</c:if>
						<c:if test="${missionstatetable.missionType=='6'}">
							<jsp:include page="/page/system/nmstaskmanager/addSimilar/missionCmdPara6ForNewSimilar.jsp" /><!-- 升级部署 -->
						</c:if>
					</td>
				</tr>
				<!-- 推送文件结束 -->
				<!-- 
				<tr>
					<td class="td_1">命令内容&nbsp;&nbsp;&nbsp;&nbsp;<br/>或&nbsp;&nbsp;参&nbsp;&nbsp;数：</td>
					<td class="td_2" colspan="3">
						<textarea name="commandPara" id="commandPara0" rows="17" style="width: 85%;" ></textarea><font color="red">*</font>
					</td>
				</tr>
				<tr>
				<td class="td_1">&nbsp;</td>
					<td class="td_2" colspan="3">
						<img onclick="SelectDate(jQuery('#paramdate0')[0],'yyyy-MM-dd hh:mm:ss',jQuery('#paramdate0').position().left,jQuery('#paramdate0').position().top)" id="wclander" src="<c:url value='/images/date2.jpg'/>" width="20" height="20" alt="添加时间" />
						<input type="hidden" id="paramdate0" onchange="resetDate(this)" />
						<font color="red">*多参数请以单竖线‘|’分开，添加时间请点击图片 </font>
					 <font color="red">
					 ＾多块内容或多个参数间，请用“;”分隔，且内容块间的“;”必须放在“}”后面，即“};”格式。存在重复或包含路径会重复执行。 <span id="commandSesc" style="width: 300px;"></span>
					 </font>
					</td>
				</tr> -->
				<tr id="commandexe_loop">
					<td class="td_1">i18n_asnti.text.loopFlag_n81i：</td>
					<td class="td_3" id="commandexe_loop0">
						<input type="radio" name="missionstatetable.loopFlag" id="_type" value="1"	
						          <c:if test="${missionstatetable.loopFlag == 1}">checked="checked" </c:if> />i18n_asnti.message.timed_n81i&nbsp;
						<input type="radio" name="missionstatetable.loopFlag" id="_type" value="0" 
						          <c:if test="${missionstatetable.loopFlag == 0}">checked="checked" </c:if>  />i18n_asnti.message.untimed_n81i 
					</td>
					<td class="td_1" id="commandexe_delay">i18n_asnti.text.cycle_n81i：</td>
					<td class="td_2" id="commandexe_delay">
						<input type="text" name="missionstatetable.loopDelay" id="zhouqi" value="${missionstatetable.loopDelay}"/>分钟<font color="red">* </font>
					</td>
				</tr>
				<tr id="commandexe_date">
					<td class="td_1">i18n_asnti.text.startTime_n81i：</td>
					<td class="td_3">
							<input name="missionstatetable.startTime" id="missionstatetable.startTime" type="text"
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)" value="${fn:substring(missionstatetable.startTime,0,19)}"/>
							<font color="red"><span id="commandexe_date">*</span> </font>
					</td>
					<td class="td_1">i18n_asnti.text.endTime_n81i：</td>
					<td class="td_2">
						<input name="missionstatetable.endTime" id="missionstatetable.endTime" type="text"
							onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)" value="${fn:substring(missionstatetable.endTime,0,19)}" />
						<font color="red"><span id="commandexe_date">*</span> </font>
					</td>
				</tr>
			<!-- 命令执行 -->
				<tr>
					<td class="td_1">i18n_asnti.text.missionDesc_n81i：</td>
					<td class="td_2" colspan="3"><textarea name="missionDesc"id="missionDesc" rows="4" style="width: 90%;" >${missionParamterTable.missionDesc}</textarea>
						<font color="red"></font>
					</td>
				</tr>
				<!-- 联系人 -->
				<c:if test="${session.emailFlag==0 }">
					<tr id="userEmail_Line">
						<td class="td_1" align="right">
							i18n_asnti.text.users_n81i：
						</td>
						<td class="td_2" colspan="3" align="left">
							<input type="checkbox" name="checkAll" value="1"  /> i18n_asnti.text.selectAll_n81i&nbsp;
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
						<input type="button" onclick="add()" value="i18n_asnti.button.submit_n81i"
							class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_asnti.button.reset_n81i"
							class=btn3_mouseout onclick="javascript:resetInfo();"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
					</td>
				</tr>
			</table>
		</form>
		</div>

		<jsp:include page="/page/system/nmstaskmanager/taskTemplate.jsp" />
	</body>
</html>
