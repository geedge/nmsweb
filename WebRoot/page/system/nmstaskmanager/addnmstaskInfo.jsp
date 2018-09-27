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
		<title>i18n_anti.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/fileInput.js"/>"></script>
		<!-- 日期插件 -->
	<script type="text/javascript">
	//查询记录
	function callBack(){
 		document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
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
		$("#missionName").next().html("*");
		$("#jdz").html("*");
		$("#usergroupid").next().html("*");
		$("#commandEName").next().html("*");
		$("#returnPath").next().html("*");
		$("#missionDesc").next().html("");
		var missionval =  jQuery("#missionName").val();
		var nodeListIdShow =  jQuery("#nodeListIdShow").val();
		var nodeGroupsId =  jQuery("#nodeGroupsId").val();
		
		if(missionval==null||$.trim(missionval)==""){
			$("#missionName").next().html("i18n_anti.message.missionName_n81i");
			return  false;
		}
		
		if(nodeListIdShow==null||nodeListIdShow==""||nodeGroupsId==null||nodeGroupsId==""){
			$("#jdz").html("i18n_anti.message.jdz_n81i");
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
				            		alert("i18n_anti.message.nodeIp_n81i");
				            		validIpFlag = false;
				            		return false;
				            	}
							},
							"json");
				if(!validIpFlag) {return false;}
			}
		
		}		
		
		if(jQuery("[name=missionstatetable.systemId]>option:selected").val()=="") {
			alert("i18n_anti.message.systemId_n81i");
			return false;
		}
		
		if(jQuery("input[type='radio'][name='missionstatetable.viewLevel']:checked").val()==2){
			if(jQuery("#usergroupid>option:selected").val()==""){
				$("#usergroupid").next().html("i18n_anti.message.usergroupid_n81i");
				return false;
			}
		}
		
		//文件推送
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==1){
			if(!(checkValEmptyByEach("file","file","Info","i18n_anti.message.pushFile_n81i")
					 && checkValEmptyByEach("text","paramM1[","].destPath","i18n_anti.message.pushDest_n81i"))){
					 	return false;
					 }
		}
		//命令执行
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==4){
		    //最大等待时间：可以为空，不为空时要为数字
		    if(document.getElementById("maxWaitTime")!=null&&document.getElementById("maxWaitTime").value!="") {
			    if(!$id('maxWaitTime','sz',"i18n_anti.message.maxWaitTime_n81i")) {
			    	return false;
			    }
		    }
			if(jQuery("[name=missionparameteriable4.commandType]:checked").val()!=3){
				if(jQuery("[name=missionparameteriable4.commandEName]>option:selected")==null||jQuery("[name=missionparameteriable4.commandEName]  >option:selected").val()==""){
					$("#commandEName").next().html("i18n_anti.message.commandEName_n81i");
					return false;
				}
			}
			if(jQuery("[name=missionstatetable.loopFlag]:checked").val()==1){
				if(!$id('zhouqi','sz',"i18n_anti.text.cycle_n81i")){
					return false;
				}
				if(!$id("missionstatetable.startTime","","i18n_anti.text.startTime_n81i")){
					return false;
				}
				
				if(!$id("missionstatetable.endTime","","i18n_anti.text.endTime_n81i")){
					return false;
				}
				
				var loopStartTime = document.getElementById("missionstatetable.startTime").value;
				var loopEndTime = document.getElementById("missionstatetable.endTime").value;
				if(loopStartTime>loopEndTime) {
					alert("i18n_anti.message.timeInfo1_n81i");
					return false;
				}
				var date = new Date();
				
				var dateTimeArr = loopEndTime.split(" ");//loopEndTime界面插件获取的时间，格式为2013-1-25 12:1:1
				var dateArr = dateTimeArr[0].split("-");
				var timeArr = dateTimeArr[1].split(":");
				var loopEndDate = new Date(dateArr[0],dateArr[1]-1,dateArr[2],timeArr[0],timeArr[1],timeArr[2]);			
				
				if(loopEndDate<date) {
					alert("i18n_anti.message.timeInfo2_n81i");
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
		 				$("#returnPath").next().html("i18n_anti.message.returnPath_n81i");
		 				returnPathFlag = false;
						return  false;
		 			}
		 		}
	 	    });
	 	    if(!returnPathFlag) {return returnPathFlag; }
	 	    
			if(!(checkValEmptyByEach("text","paramM4[","].backup","i18n_anti.text.backup_n81i") && checkValEmptyByEach("text","paramM4[","].backupTo","i18n_anti.text.backupTo_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].pidFile","i18n_anti.text.pidFile_n81i") && checkValEmptyByEach("text","paramM4[","].source","i18n_anti.text.source_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].cover","i18n_anti.text.cover_n81i") && checkValEmptyByEach("text","paramM4[","].execCmd","i18n_anti.text.execCmd_n81i") 
						&& checkValEmptyByEach("text","paramM4[","].execResult","i18n_anti.text.execResult_n81i"))){
							return false;
						}
		}
		//升级部署
		if(jQuery("input[name=missionstatetable.missionType]:checked").val()==6){
		    //等待时间：可以为空，不为空时要为数字
		    if($("#commandEName").val()==""){
		    	$("#mlmc").html("i18n_anti.message.commandEName_n81i");
		    	return false;
		    }else{
		    	$("#mlmc").html("*");
		    }
		    if(document.getElementById("maxWaitTime")!=null&&document.getElementById("maxWaitTime").value!="") {
			    if(!$id('maxWaitTime','sz',"i18n_anti.message.waitTime_n81i")) {
			    	return false;
			    }
		    }
			if(!(checkValEmptyByEach("file","file","Info","i18n_anti.message.pushFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].cover","i18n_anti.text.cover_n81i") 
						 && checkValEmptyByEach("text","paramM6[","].startupFile","i18n_anti.text.startupFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].pidFile","i18n_anti.text.pidFile_n81i")
						 && checkValEmptyByEach("text","paramM6[","].backup","i18n_anti.text.backup_n81i")
						 && checkValEmptyByEach("text","paramM6[","].backupTo","i18n_anti.text.backupTo_n81i"))){
						 	return false;
						 }
		}
		var missionDescVal = $("#missionDesc").val();
		if(missionDescVal.length>100){
			$("#missionDesc").next().html("i18n_anti.message.missionDesc_n81i");
			return false;
		}
		return true;
	}
	function checkValEmptyByEach(type, sname, ename, desc){
		var flag = true;
		jQuery("#file_Td input[type='" + type + "'][name^='" + sname + "'][name$='" + ename + "']").each(function(i,n){
			jQuery(n).next().html("*");
			if($.trim(jQuery(n).val())==""){
				jQuery(n).next().html(desc + "i18n_anti.message.isNotNull_n81i");
				flag = false;
				return  false;
			}
		});
		return flag;
	}

	function checkFileSize(){
		var chkResu = true;
		var isIE = /msie/i.test(navigator.userAgent) && !window.opear;
		var fileSize = 0;
		var sumSize = 0;
		$("#file_Td > div[divType=file_div] > input[type=file]").each(function(i,n){
			if (isIE && !jQuery(n).files) {      
              	jQuery(n).select();
				var path = document.selection.createRange().text;   
              	var fileSystem = new ActiveXObject("Scripting.FileSystemObject");  
                
              	if(!fileSystem.FileExists(path)){  
                 jQuery(n).next().html("i18n_anti.message.fileIsNotExists_n81i");
                 return;  
              	}  
              	var file = fileSystem.GetFile (path);  
              	fileSize = file.Size;     
	        }else{     
	            fileSize = n.files[0].Size;   
	        }    
	        sumSize +=fileSize;
		});
		var size = sumSize / (1024*1024);     
        if(size>100){   
            chkResu = false;
        }
		return chkResu;
	}
	
	//添加操作
	function add(){
		if(checkValue()){
			if(checkFileSize()){//检查file size
				document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=savetask";
				document.yhForm.submit();	
			}else{
				alert("i18n_anti.message.fileIsTooBig_n81i");
				return;
			}
		}
	 }
	//任务类型页面展示 
	 function showInfotag(tasktype){
	 	//重置推送文件操作
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
	 		}
	 		jQuery("td[id=commandexe_type]").show();
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
		//-- 为 任务类型 绑定 选择事件，用于显示表单
		 jQuery("input[type='radio'][id='missionType']").bind({
		 	change : function(){
		 		showInfotag(jQuery("input[type='radio'][id='missionType']:checked").val());
		 		if(jQuery("input[type='radio'][id='missionType']:checked").val()==1){	//推送文件
				 	var model = jQuery("#commandSource>option[type=5]:first").attr('model');
					//jQuery("#commandPara0").val(model);
					//jQuery("#commandParaCheck").val(1);
					//取模板
					$("#file_Td").append($("#"+model).html());
				 }
			}
		 });
	 	jQuery("input[type='radio'][id='missionType']:checked").trigger('change');
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
	 		jQuery("#commandEName").append(jQuery("#commandSource>option[type="+jQuery(this).val()+"]"));
	 		jQuery("#commandEName").val("");
	 		//jQuery("#commandEName").trigger('change');
	 	});
	 	jQuery("input[type='radio'][name=missionparameteriable4.commandType]:checked").trigger('click');
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
				$("#file_Td input[type=radio][name$='[0].returnFlag']").attr("checked", "checked");
				var tasktype = $("input[name=missionstatetable.missionType]:checked").val();
				if(tasktype=='6'){//升级部署，Agent不可添加多组参数
					if(jQuery("#commandEName>option:selected").val()=='upgrade_agent'){
						jQuery("div[id='task1']").hide();
					}else{
						jQuery("div[id='task1']").show();
					}
				}
				$("#mlmc").html("*");
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
	 		}else if(jQuery(this).val() ==4){	//无限制
	 			//隐藏用户组选项
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			resize();
	 		}
	 	});
	 	jQuery("input[type='radio'][name='missionstatetable.viewLevel']:first").click();
	 	
	 	//多文件添加事件
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
	 		var tasktype = $("input[name=missionstatetable.missionType]:checked").val();
	 		var model = jQuery("#commandEName>option:selected").attr('model');
	 		if('1'==tasktype){	//推送文件
				 model = jQuery("#commandSource>option[type=5]:first").attr('model');
			}
			if(model!=null && model!=""){
		 		htmlDiv = $("#"+model).html().replace(new RegExp("\\[0\\]","g"),"["+pLength+"]");
		 		$("#file_Td").append(htmlDiv);
		 		if($("#file_Td > div[divType=file_div]").size()>1){
					$("#file_Td > div[divType=file_div] > span").show();//显示删除按钮
				}
				//特殊处理 给radio选项一些初始值
				$("#file_Td input[type=radio][name$='[" + pLength + "].isAbs']").attr("checked", "checked");
				$("#file_Td input[type=radio][name$='[" + pLength + "].isCreateCover']").attr("checked", "checked");
	 		}else{
	 			$("#mlmc").html("i18n_acnti.message.mlmc_n81i");
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
			$(this).parent().remove();//删除对应的一组参数
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
		// 相似任务Ajax查询功能
		//$("#missionName").bind({
		//	"keyUp":function(){
				//查询
		//		lianxiangkeyup('missionName','MissionstateTable','String','missionName','suggest1',$(this).val());
		//	}
		//});
		// 页面内容自动加载功能
		
		
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
	 	jQuery("input[type=radio][name=detectionSetInfo.viewLevel]:first").trigger('click');
	 	
	 	//-- 为推送附件添加change事件
		$("#infoFile").bind("propertychange",function(){
				$(this).select();
				var path = document.selection.createRange().text;
				//alert("realPath:"+path);
		 		//alert(filepath);
		 		if(jQuery("input[type='radio'][id='missionType']:checked").val()==1){	//推送文件
				 	//var model = jQuery("#commandSource>option[type=5]:first").attr('model');
					//jQuery("#commandPara0").val(model);
					//jQuery("#commandParaCheck").val(1);
					//取模板
					//$("#file_Td").append($("#"+model).html());
				 }
		 });
	 	
	});
	
	/*$(function(){
		$("#infoFile").attr("style","width:15px");
	});*/
	
	
	//选择节点组---begin
	function selectNodeAndNodeGroup() {
		var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		if(nodeLock == 1){
			alert("i18n_anti.message.nodeLock_n81i");
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
	
	
	
	function resize(){
	 	{parent.document.all.I3.height = document.body.scrollHeight;}
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
   	   jQuery("input[type='radio'][name='missionstatetable.viewLevel'][value='1']").trigger('click');
   }
	
   </script>

   	</head>
	<body class="bc">
	<div class="middle_list">
	<div class="box_2">	
		<input type="button" value="i18n_anti.button.back_n81i"
			class=btn3_mouseout onclick="javaScript:callBack();"
			onmouseover="this.className='btn3_mouseover'"
			onmouseout="this.className='btn3_mouseout'"
			onmousedown="this.className='btn3_mousedown'"
			onmouseup="this.className='btn3_mouseup'"/>
	 </div>
	 <div style="height: 25px"></div>
		<form action="" id="yhForm" name="yhForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionName" value="${missionName }" />
		<input type="hidden" name="loopFlag" value="${loopFlag }"  />
		<input type="hidden" name="missionState" value="${missionState }"  />
		<input type="hidden" name="missionType" value="${missionType }" />
		<input type="hidden" name="pageNo" value="${pageNo }" />
		<input type="hidden" name="pageSize" value="${pageSize }" />
		<input type="hidden" name="fromWhere" value="${fromWhere }"/>
		<input type="hidden" id="fw" value="addNewTask"/>
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
				<tr>
				  <td class="color_8" colspan="4">i18n_anti.text.title_n81i</td>
				</tr>
				<tr>
					<td class="td_1" width="100px">i18n_anti.text.missionType_n81i：</td>
					<td class="td_3" width="45%">
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="1" checked="checked" />i18n_anti.message.filePush_n81i&nbsp;
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="4" />i18n_anti.message.commandExcute_n81i&nbsp;
						<input type="radio" name="missionstatetable.missionType" id="missionType" value="6" />i18n_anti.message.upgrade_n81i&nbsp;
					</td>
					<td class="td_1">i18n_anti.text.systemName_n81i：</td>
					<td class="td_2"><strong>${systemTable.systemName}</strong><input name="missionstatetable.systemId" type="hidden"  value="${systemTable.systemId}" />
					</td>
				</tr>
				<tr>
					<td class="td_1">i18n_anti.text.missionName_n81i：</td>
					<td class="td_2" colspan="3">
					<input type="text" name="missionstatetable.missionName" id="missionName" />
					<font color="red">*</font></td>
					
				</tr>
				<tr>
				<td class="td_1">i18n_anti.text.nodeGroup_n81i：</td>
					<td class="td_3">
						<input type="text" name="nodeListIdShow" id="nodeListIdShow" readonly="readonly" value=""/>&nbsp;
						<input type="hidden" name="nodeGroupsId" id="nodeGroupsId" value=""/>&nbsp;
						<input type="button" value="i18n_anti.button.select_n81i" onclick="selectNodeAndNodeGroup()"
						    class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
						/>
						<font color="red" id="jdz">*</font>
					</td>
					<td class="td_1" width="20%" align="right">
						i18n_anti.text.select_n81i
					</td>
					<td class="td_2" width="30%" align="left">
						<input type="text" name="nodeIpShow" id="nodeIpShow" readonly="readonly" value="${detectionSetInfo.nodeIpsName }"/>&nbsp;
						<input type="hidden" name="nodeIpsId" id="nodeIp" value="${detectionSetInfo.nodeIpsId }"/>&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="td_1">i18n_anti.text.viewLevel_n81i：</td>
					<td class="td_3" id="viewLevel0">
						<c:if test="${AdminFlag }">
							<input type="radio" name="missionstatetable.viewLevel" id="" value="4" />i18n_actsi.text.viewPrivilege.unlimited_n81i&nbsp;
						</c:if>
						<c:if test="${!AdminFlag }">
							<input type="radio"	name="missionstatetable.viewLevel" id="" value="1" checked="checked" />i18n_anti.message.publisher_n81i&nbsp;
							<input type="radio"	name="missionstatetable.viewLevel" id="" value="2" />i18n_anti.message.publisherGroup_n81i&nbsp;
							<input type="radio" name="missionstatetable.viewLevel" id="" value="3" />i18n_anti.message.allInSys_n81i&nbsp;
						</c:if>
						
					</td>
					<td class="td_1"  id="usergroup">i18n_anti.text.usergroup_n81i：</td>
					<td class="td_2"  id="usergroup">
						<select name="missionstatetable.groupId" id="usergroupid">
							<option selected="selected" value="">
								i18n_anti.message.userGroupDefault_n81i
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
			<!-- 命令执行 -->
			<tr id="upgrade_date">
				<td class="td_1" id="upgrade_date">i18n_anti.text.upgradeDate_n81i：</td>
				<td class="td_2" id="upgrade_date" colspan="3">
						<input name="missionparametertable6.startTime" id="upgradeTime" type="text"
							onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)"/>
				</td>
			</tr>
			
			<tr id="commandexe0">
				<td class="td_1" id="commandexe_type">i18n_anti.text.commandType_n81i：</td>
				<td class="td_3" id="commandexe_type">
					<input type="radio" name="missionparameteriable4.commandType" value="1" checked="checked" />i18n_anti.message.commandType1_n81i&nbsp;
					<input type="radio" name="missionparameteriable4.commandType" value="2" />i18n_anti.message.commandType2_n81i&nbsp;
					<input type="radio" name="missionparameteriable4.commandType" value="4" style="display: none" />
				</td>
				<td class="td_1">i18n_anti.text.commandexeName_n81i：</td>
				<td class="td_2" id="commandexe_name">
						<select name="commandSource" id="commandSource" style="display: none">
							<c:forEach items="${ordertablelist}" var="ordertable">
								<option value="${ordertable.commandName}" type='${ordertable.commandType }' model='${ordertable["commandModel"]}' desc='${ordertable["commandDesc"]}'>
									${ordertable.commandAlias}
								</option>
							</c:forEach>
						</select>
						<select name="missionparameteriable4.commandEName"	id="commandEName">
							<option selected="selected" value="" model="" desc="">
								i18n_anti.message.commandNameSelect_n81i
							</option>
						</select>
						<font color="red" id="mlmc">*</font>
						<input type="hidden" name="commandParaCheck" id="commandParaCheck" value="0" />
					</td>
				</tr>
				<!-- 推送文件相关内容 -->
				<tr id="tsfile0">
					<td class="td_1">i18n_anti.text.commandDesc_n81i：</td>
					<td class="td_2" colspan="3" id="file_Td">
						<div id="task1"><span class="STYLE1" id="add_file_span"  style="color: #000fff; cursor: hand;">i18n_anti.text.addPushFile_n81i</span>
						<font color="red">i18n_anti.message.addPushFile_n81i</font></div>
						<div id="task4"><span class="STYLE1" id="add_cmd_span"  style="color: #000fff; cursor: hand;">i18n_anti.text.addOperation_n81i</span></div>
					</td>
				</tr>
				<tr id="commandexe_loop">
					<td class="td_1">i18n_anti.text.loopFlag_n81i：</td>
					<td class="td_3" id="commandexe_loop0">
						<input type="radio" name="missionstatetable.loopFlag" id="_type" value="1"	/>i18n_anti.message.timed_n81i&nbsp;
						<input type="radio" name="missionstatetable.loopFlag" id="_type" value="0" checked="checked" />i18n_anti.message.untimed_n81i 
					</td>
					<td class="td_1" id="commandexe_delay">i18n_anti.text.cycle_n81i：</td>
					<td class="td_2" id="commandexe_delay">
						<input type="text" name="missionstatetable.loopDelay" id="zhouqi" value=""/>i18n_anti.text.minute_n81i<font color="red">* </font>
					</td>
				</tr>
				<tr id="commandexe_date">
					<td class="td_1">i18n_anti.text.startTime_n81i：</td>
					<td class="td_3">
							<input name="missionstatetable.startTime" id="missionstatetable.startTime" type="text"
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)"/>
							<font color="red"><span id="commandexe_date">*</span> </font>
					</td>
					<td class="td_1">i18n_anti.text.endTime_n81i：</td>
					<td class="td_2">
						<input name="missionstatetable.endTime" id="missionstatetable.endTime" type="text"
							onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)"/>
						<font color="red"><span id="commandexe_date">*</span> </font>
					</td>
				</tr>
			<!-- 命令执行 -->
				<tr>
					<td class="td_1">i18n_anti.text.missionDesc_n81i：</td>
					<td class="td_2" colspan="3"><textarea name="missionDesc"id="missionDesc" rows="4" style="width: 90%;" ></textarea>
					<font color="red"></font>
					</td>
				</tr>
				<!-- 联系人 -->
				<c:if test="${session.emailFlag==0 }">
					<tr id="userEmail_Line">
						<td class="td_1" align="right">
							i18n_anti.text.user_n81i
						</td>
						<td class="td_2" colspan="3" align="left">
							<input type="checkbox" name="checkAll" value="1"  /> i18n_anti.text.selectAll_n81i&nbsp;
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
						<input type="button" onclick="add()" value="i18n_anti.button.submit_n81i"
							class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"/>
						&nbsp;
						<input type="button" value="i18n_anti.button.reset_n81i"
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
