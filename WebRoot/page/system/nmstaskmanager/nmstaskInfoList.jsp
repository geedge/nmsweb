<%@ page language="java" pageEncoding="utf-8"%>
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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_ntil.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
	<style type="text/css">				
				.mydiv {
				background-color:#fff;
				border: 1px solid #000;
				text-align: center;
				line-height: 40px;
				font-size: 12px;
				font-weight: bold;
				z-index:99;
				width: 220px;
				height: 80px;
				left:50%;/*FF IE7*/
				top: 50%;/*FF IE7*/
				
				margin-left:-150px!important;/*FF IE7 该值为本身宽的一半 */
				margin-top:-60px!important;/*FF IE7 该值为本身高的一半*/
				
				margin-top:0px;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				
				
				.bg {
				background-color: #ccc;
				width: 100%;
				height: 100%;
				left:0;
				top:0;/*FF IE7*/
				filter:alpha(opacity=50);/*IE*/
				opacity:0.5;/*FF*/
				z-index:1;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				/*The END*/
				
			</style>
	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_ntil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_ntil.message.faild_n81i");
	  }	  
	  
	  //复选框实现单选效果
	  function radioButton(obj){
		var checks = document.getElementsByTagName("input");
		var selectedCount = countChecked("pid");	
		if(selectedCount > 1){
			for(i = 0 ; i <= checks.length ; i++ ){
				if(checks[i]){
					if(checks[i].name == 'pid'){
						if(checks[i].checked)
						{
							if(checks[i]!=obj){
								checks[i].checked=false;
							}
						}
					}
									
				}
			}
		}
	}  
		
	//添加记录
	
	 function add(){		 	
		document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=toaddtaskPage' />&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	 
	 //添加相似任务	
	 function addSimilar(){	
	    if(!isRigthCheck("pid", "edit")){//检查是否只选择了一条记录
	 		alert("i18n_ntil.message.selectOne_n81i");
	 	}else{
	 		document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=toAddSimilarTaskPage' />&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		    document.form3.submit();
		}
		
	 } 
	 //添加逆向任务：只选择一条+升级部署+任务完成+有备份	
	 function addConverse(){
	    if(!isRigthCheck("pid", "edit")){//检查是否只选择了一条记录
	 		alert("i18n_ntil.message.selectOne_n81i");
	 		return;
	 	}
	 	var missId = getOnlyValue("pid");//获得选中任务的任务Id
	 	$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryMissInfoForConverse",{missId:missId},function(datas){checkCoverseMiss(datas);},"json");//根据任务Id从后台获得任务的相关信息，判断是否符合逆向任务的条件
	 } 
	 
	 //检查选中的任务是否符合逆向任务的条件：是否升级部署+非逆向任务+是否任务完成+是否有备份（从大到小判断，先任务类型，再完成，再备份）	
	 function checkCoverseMiss(datas) {
	    if(datas!=null){
	    	if(datas.canConverse=="false") {//任务不可逆向
		    	if(datas.isUpdate=="false") {
	                alert("i18n_ntil.message.isUpdate_n81i");
	                return;
	 	        }
		    	if(datas.isConverse=="true") {
	                alert("i18n_ntil.message.isConverse_n81i");
	                return;
	 	        }
		        if(datas.finished=="false") {
		        	alert("i18n_ntil.message.finished_n81i");
		        	return;
		        }
		        if(datas.haveBackUp=="false") {
		        	alert("i18n_ntil.message.haveBackUp_n81i");
		        	return;
		        }
		    } else {
		        document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=toAddConverseTaskPage' />&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		    	document.form3.submit();
		    }
	    }
	 }
	 
	 //查询记录
	 function qry(){
 		document.form3.action ="<c:url value='${thisPageUrl }' />";
		document.form3.submit();
	}
		
	//查看任务信息
	function viewMissionInfo(missionId){
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=viewMission' />&missionId="+missionId+"&pageNo="+mypageNo+"&pageSize="+mypageSize;
		document.form3.submit();
	}
	//查看结果信息
	function viewResultsStatistics(missionId){
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=statistic' />&missionId="+missionId+"&mypageNo="+mypageNo+"&mypageSize="+mypageSize;
		document.form3.submit();
	}
	
	//修改
	function editMissionViewLevel(missionId){
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action ="<c:url value='/' />nmstaskManager/nmsTaskManager.do?action=editViewLevel&missionId="+missionId+"&pageNo="+mypageNo+"&pageSize="+mypageSize;
		document.form3.submit();
	}
	//修改
	function editedate(type,missionId){
		document.form3.action ="<c:url value='/' />nmstaskManager/nmsTaskManager.do?action=toeditedate&type="+type+"&missionId="+missionId+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	}
	//删除
	function deletedate(type,missionId){
		document.form3.action ="<c:url value='/' />nmstaskManager/nmsTaskManager.do?action=toeditedate&type="+type+"&missionId="+missionId+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	}
	//添加记录
	 function updateAgent(){		 	
		document.form3.action ="<c:url value='/' />nmstaskManager/nmsTaskManager.do?action=toUpdateAgent&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//快速启用
	function startDn(){
		if($("input[type=checkbox]:checked").length==0){
			alert("i18n_ntil.message.selectOne_n81i");
			return false;
		}
 		if(isLoopFlag("pid", 0)){//是否定時任务：1是；0不是
 			alert('i18n_ntil.message.isLoopFlag_n81i');
 		}else{
	 		if(isOperation("pid", 3)||isOperation("pid", 4)){
	 			alert('i18n_ntil.message.taskComplete_n81i');
	 			return ;
	 		}
	 		if(isOperation("pid", 1)||isOperation("pid", 2)){	//启用状态的任务无法再次启用
				alert('i18n_ntil.message.taskInEffect_n81i');
			}else{	//停用状态的任务可以重新启用
				if(!isOperation("pid", 7)){	//未撤销完成任务无法启用
					alert('i18n_ntil.message.taskNotCancelled_n81i');
					return ;
				}
				document.form3.action ="<c:url value='/' />/nmstaskManager/nmsTaskManager.do?action=toUpdateState&curstate=1&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
				document.form3.submit();
			}
 		}
	}
	//快速停用
	function shutDn(){
		if($("input[type=checkbox]:checked").length==0){
			alert("i18n_ntil.message.toSelect_n81i");
			return false;
		}
 		if(isLoopFlag("pid", 0)){//是否定時任务：1是；0不是
 			alert('i18n_ntil.message.isLoopFlag_n81i');
 		}else{
 			if(isOperation("pid", 3)||isOperation("pid", 4)){
	 			alert('i18n_ntil.message.taskComplete_n81i');
	 			return ;
	 		}
	 		if(isOperation("pid", 5)||isOperation("pid", 6)||isOperation("pid", 7)){//停用状态的任务无法再次停用
				alert('i18n_ntil.message.disabledTask_n81i');
			}else{	//启用状态的任务可以重新停用
				if(confirm('i18n_ntil.message.operateCautiously_n81i')){	//未撤销完成任务无法启用
					document.form3.action ="<c:url value='/' />/nmstaskManager/nmsTaskManager.do?action=toUpdateState&curstate=5&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
					document.form3.submit();
				}
			}
		}	 		
	}	
	function isLoopFlag(checkName,flagValue){
		var loopFlagValue ;
		var loopFlag;
		var flag = false;
		var checks = document.getElementsByTagName("input");	
		for(i = 0 ; i <= checks.length ; i++ ){
			if(checks[i]){
				if(checks[i].name == checkName){
					if(checks[i].checked)
					{
						loopFlag='loopFlag'+checks[i].value;
						loopFlagValue = document.getElementById(loopFlag).value;
						if(loopFlagValue==flagValue){
							flag=true;
						}
					}
				}
			}
		}
		return flag;
	}
	
	function checkZF(id){
		if(containSpecial($("#"+id).val())){
			alert('i18n_ntil.message.inputInfo_n81i');
			$("#"+id).val('');
			return;
		}
	}
	
	function ieBrowser(){
		if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		}
	}

	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		var flag; 
		var url = window.location.href; 
		if(url.indexOf("nmsTaskManager.do?action=query")!=-1){//任务配置
			flag = "taskConfigration";
		}else if(url.indexOf("nmsTaskManager!execute.do?action=query")!=-1){//任务查看
			flag = "taskView";
		}
		document.form3.action = "<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=emportCurrentXls&flag="+flag+"&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&missionName="+$("#mName").val()+"&loopFlag="+$("#checkTypeId").val()+"&missionState="+$("#checkTypeId1").val()+"&missionType="+$("#checkTypeId2").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>${thisPageUrl }";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		var flag; 
		var url = window.location.href; 
		if(url.indexOf("nmsTaskManager.do?action=query")!=-1){//任务配置
			flag = "taskConfigration";
		}else if(url.indexOf("nmsTaskManager!execute.do?action=query")!=-1){//任务查看
			flag = "taskView";
		}
		document.form3.action = "<c:url value='/'/>/nmstaskManager/nmsTaskManager.do?action=emportAllXls&flag="+flag+"&missionName="+$("#mName").val()+"&loopFlag="+$("#checkTypeId").val()+"&missionState="+$("#checkTypeId1").val()+"&missionType="+$("#checkTypeId2").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>${thisPageUrl }";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}
	
	function goGuide(datas) {
		if(datas!=null && datas!=""){
		 	if(datas.resu=='over') {
		 		window.location ="<c:url value='/' />/sysManage/guideManage!execute.do?action=index";
			}
		}
	}
	
	$(function(){
		var dh = document.body.clientHeight; 
		var dhh = dh-60+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-60){
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
			if(ieBrowser()){
				$("#info").attr("style","width:100%;");
			}else{
				$("#info").attr("style","width:98.5%;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;");
		}
	//	$("#maindiv").attr("style","clear:both");
		
		if($("#isComplete").val()=='0'){
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:7,
		 					packName:'rw'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_ntil.message.warning_n81i", "i18n_ntil.message.hint_n81i", submit,{icon: false});
		}
		
		$("#info").floatHeaderDiv();
	});

	window.onresize = function(){
		$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
	}

	/*------ 滚动条滚动 延迟加载页面操作--------------*/
	var hght=0;//初始化滚动条总长
	var topH=0;//初始化滚动条的当前位置
	var pagePoint = ${pageNo};
	var memoryData ;
	var intervalID ;
	var currentPage = 0; //当前页数
	var currenttotalPage = 0; //总页数
	$(function(){//DOM的onload事件
		$("#maindiv").scroll( function() {//定义滚动条位置改变时触发的事件。
		    hght=this.scrollHeight;//得到滚动条总长，赋给hght变量
		    topH=this.scrollTop+this.clientHeight;//得到滚动条当前值，赋给top变量
		});
		intervalID = setInterval(function(){cando();},1000);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
		function cando(){
			currentPage = $("#currentPage").html(); 
		    currenttotalPage = $("#currenttotalPage").html();
		    if(Number(currentPage) < Number(currenttotalPage)){
				if(topH!=0 && hght!=0 && topH == hght ){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
			    	show();//如果是，调用show函数加载内容。
			    }
			}else if(Number(currentPage) == Number(currenttotalPage)){
				clearInterval(intervalID);
			}
		}
		function show(){
		    hght=0;//恢复滚动条总长，因为$(”#mypage”).scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载……
		    topH=0;//原因同上。
		    var urlTmp = encodeURI("<c:url value='nmsTaskManager.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&missionName="+$("#mName").val()+"&loopFlag="+$("#checkTypeId").val()+"&missionState="+$("#checkTypeId1").val()+"&missionType="+$("#checkTypeId2").val());
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
				success : function(data) {
					$("#info").append($(data));//用append方法追加内容到mypage元素。
				   	$("#currentPage").html(pagePoint);//修改页码
			    	$("#pageNo").val(pagePoint);
				}
			});
			loadButton();
		}
	});
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
    </script>
</head>
	<body>
		<!--中间部分右边开始-->
		<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType" action="<c:url value='${thisPageUrl }'/>" method="post" enctype="multipart/form-data">
			<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<input type="hidden" name="from" value="${from }"/>
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			<div id="divTop">
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_ntil.text.missionName_n81i</font><input type="text" id="mName"  name="missionName" title="i18n_ntil.message.missionName_n81i" value="${missionName}" size="20" onkeyup="checkZF('mName');"/></label>
					<label class="divTopText"><font class="selectText">i18n_ntil.text.loopFlag_n81i</font><select name="loopFlag"  id="checkTypeId">
									<option value="" 
										<c:if test="${loopFlag eq null}">selected="selected"</c:if> >
										--i18n_ntil.text.selectDefault_n81i-- 
									</option>
									<option value="1"
										<c:if test="${loopFlag eq 1}">selected="selected"</c:if>>
										i18n_ntil.message.timed_n81i
									</option>
									<option value="0"
										<c:if test="${loopFlag == '0'}">selected="selected"</c:if>>
										i18n_ntil.message.untimed_n81i
									</option>
								</select></label>
					<label class="divTopText"><font class="selectText">i18n_ntil.text.missionState_n81i</font><select name="missionState"  style="width:120px;" id="checkTypeId1">
								<option value="" >
									--i18n_ntil.text.selectDefault_n81i--
								</option>
								<option value="1"
									<c:if test="${missionState eq 1}">selected="selected"</c:if>>
									i18n_ntil.message.missionCreated_n81i
								</option>
								<option value="2"
									<c:if test="${missionState eq 2}">selected="selected"</c:if>>
									i18n_ntil.message.missionExec_n81i
								</option>
								<!-- 包括4个状态：非周期任务：全部成功、部分成功、全部失败，周期任务已完成 -->
							    <option value="3"  
                                    <c:if test="${missionState eq 3}">selected="selected"</c:if>>
									i18n_ntil.message.missionComplete_n81i
								</option>  
								<option value="4"
									<c:if test="${missionState eq  4}">selected="selected"</c:if>>
									i18n_ntil.message.execFailed_n81i
								</option>
								<option value="5"
									<c:if test="${missionState eq 5}">selected="selected"</c:if>>
									i18n_ntil.message.revocation_n81i
								</option>
								<option value="6"
									<c:if test="${missionState eq 6}">selected="selected"</c:if>>
									i18n_ntil.message.cancellation_n81i
								</option>
								<option value="7"
									<c:if test="${missionState eq 7}">selected="selected"</c:if>>
									i18n_ntil.message.cancelled_n81i
								</option>
							</select></label>
						<label class="divTopText"><font class="selectText">i18n_ntil.text.missionType_n81i</font>
						<select name="missionType" id="checkTypeId2">
							<option value="0"
								<c:if test="${missionType eq 0}">selected="selected"</c:if>>
								--i18n_ntil.text.selectDefault_n81i--
							</option>
							<option value="1"
								<c:if test="${missionType eq 1}">selected="selected"</c:if>>
								i18n_ntil.message.missionType1_n81i
							</option>
							<!-- 
							<option value="2"
								<c:if test="${missionstatetable.missionType eq 2}">selected="selected"</c:if>>
								非流文本数据获取
							</option>
							<option value="3"
								<c:if test="${missionstatetable.missionType eq 3}">selected="selected"</c:if>>
								流文本数据获取
							</option>
							<option value="5"
								<c:if test="${missionstatetable.missionType eq 5}">selected="selected"</c:if>>
								shell注册
							</option>
							 -->
							<option value="4"
								<c:if test="${missionType eq 4}">selected="selected"</c:if>>
								i18n_ntil.message.missionType4_n81i
							</option>
							<option value="6"
								<c:if test="${missionType eq 6}">selected="selected"</c:if>>
								i18n_ntil.message.missionType6_n81i
							</option>
						</select></label>
						<img src="<c:url value='/images/button_chaxun.png'/>" class="img_middle2" onclick="javascript:qry();"  />
				</div>
				<div class="box_2">
					<c:if test="${ADMFlag ne true}">
					<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_ntilp.button.exportXls_n81i"/>
						<jsp:include page="/include/include.jsp"></jsp:include>
					</c:if>
				</div>
			</div>
			<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info" >
					<tr>
						<td class="color_top" width="4%">
							<input type="checkbox" onclick="javascript:checkAll(this);" ${ADMFlag ? "disabled='disabled'":""}/>
						</td>
						<td colspan="1" class="color_top" width="6%">i18n_ntil.text.operation_n81i</td>
						<td class="color_top" width="12%" nowrap="nowrap">i18n_ntil.text.missionName_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.missionType_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.loopFlag_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.missionState_n81i</td>
						<td class="color_top" width="12%" nowrap="nowrap">i18n_ntil.text.missionStateDesc_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.systemId_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.userGroup_n81i</td>
						<td class="color_top" width="12%" nowrap="nowrap">i18n_ntil.text.viewLevel_n81i</td>
						<td class="color_top" width="6%" nowrap="nowrap">i18n_ntil.text.user_n81i</td>
						<td class="color_8" width="12%" nowrap="nowrap">i18n_ntil.text.createTime_n81i</td>
					</tr>
					<c:set var="index" value="${(pageNo-1)*page.pageSize+ 1}" />
					<c:choose>
					<c:when test="${fn:length(missionstateTableList) > 0}">
						<c:forEach items="${missionstateTableList}"	var="missionstatetable">
						<c:if test="${index%2 eq 1}">
							<c:set var="tdClass" value="color_1" />
							<c:set var="tdClassR" value="color_7" />
						</c:if>
						<c:if test="${index%2 eq 0}">
							<c:set var="tdClass" value="color_3" />
							<c:set var="tdClassR" value="color_6" />
						</c:if>
					<c:if test="${missionstatetable.missionState ne -1}">
					<tr>
						<td class="${tdClass }" nowrap="nowrap" >
							<input type="hidden" id="yxbz${missionstatetable.missionId }" name="yxbz${missionstatetable.missionId }"	value="${missionstatetable.missionState}" />
							<input type="hidden" id="loopFlag${missionstatetable.missionId }" name="loopFlag${missionstatetable.missionId }" value="${missionstatetable.loopFlag}" />
							<input type="checkbox" name="pid" id="pid" value="${missionstatetable.missionId}"  ${ADMFlag ? "disabled='disabled'":""} />${index}
						</td>
						<td class="${tdClass }" nowrap="nowrap">
							<a href="javaScript:viewResultsStatistics('${missionstatetable.missionId}');">i18n_ntil.text.resultView_n81i</a>
							<c:if test="${missionstatetable.userId eq loginUserId}">
							<a href="javaScript:editMissionViewLevel('${missionstatetable.missionId}');">i18n_ntil.text.updateInfo_n81i</a>
							</c:if>
						</td>
						<td class="${tdClass }" nowrap="nowrap"><a href="javaScript:viewMissionInfo('${missionstatetable.missionId}');" title="i18n_ntil.button.clickToShowInfo_n81i">${missionstatetable.missionName}</a></td>
						<td class="${tdClass }" nowrap="nowrap">
							<c:if test="${missionstatetable.missionType eq 1}">
								i18n_ntil.message.missionType1_n81i
							</c:if>
							<c:if test="${missionstatetable.missionType eq 2}">
								i18n_ntil.message.missionType2_n81i
							</c:if>
							<c:if test="${missionstatetable.missionType eq 3}">
								i18n_ntil.message.missionType3_n81i
							</c:if>
							<c:if test="${missionstatetable.missionType eq 5}">
								i18n_ntil.message.missionType5_n81i
							</c:if>
							<c:if test="${missionstatetable.missionType eq 4}">
								i18n_ntil.message.missionType4_n81i
							</c:if>
							<c:if test="${missionstatetable.missionType eq 6}">
								i18n_ntil.message.missionType6_n81i
							</c:if>
						</td>
						<td class="${tdClass }"  nowrap="nowrap">
							<c:if test="${missionstatetable.loopFlag eq 1}">i18n_ntil.message.Y_n81i</c:if>
							<c:if test="${missionstatetable.loopFlag eq 0}">i18n_ntil.message.N_n81i</c:if>
						</td>
						<td class="${tdClass }" nowrap="nowrap">
							<c:if test="${missionstatetable.missionState eq 1}">i18n_ntil.message.missionCreated_n81i</c:if>
							<c:if test="${missionstatetable.missionState eq 2}">i18n_ntil.message.missionExec_n81i</c:if>
					        <c:if test="${missionstatetable.missionState eq 3 }"><font color="blue">i18n_ntil.message.missionComplete_n81i</font></c:if>	
                            <c:if test="${missionstatetable.missionState eq 30}"><font color="green">i18n_ntil.message.allSuccess_n81i</font></c:if>
							<c:if test="${missionstatetable.missionState eq 32}"><font color="#e47833">i18n_ntil.message.partiallySuccess_n81i</font></c:if>
							<c:if test="${missionstatetable.missionState eq 31}"><font color="red">i18n_ntil.message.allFailed_n81i</font></c:if>
							<c:if test="${missionstatetable.missionState eq 4}">i18n_ntil.message.execFailed_n81i</c:if>
							<c:if test="${missionstatetable.missionState eq 5}">i18n_ntil.message.revocation_n81i</c:if>
							<c:if test="${missionstatetable.missionState eq 6}">i18n_ntil.message.cancellation_n81i</c:if>
							<c:if test="${missionstatetable.missionState eq 7}">i18n_ntil.message.cancelled_n81i</c:if>
							
						</td>
						<td class="${tdClass }" nowrap="nowrap">
				<!--       <c:if test="${missionstatetable.missionStateDesc eq null || missionstatetable.missionStateDesc eq ''}">
						   <c:if test="${missionstatetable.missionState eq 1}">任务已创建</c:if>
							<c:if test="${missionstatetable.missionState eq 2}">任务已开始执行</c:if>
					        <c:if test="${missionstatetable.missionState eq 3 && missionstatetable.loopFlag eq 1}"><font color="blue">周期任务已完成</font></c:if>	
                            <c:if test="${missionstatetable.missionState eq 30}"><font color="green">全部成功</font></c:if>
							<c:if test="${missionstatetable.missionState eq 32}"><font color="yellow">部分成功</font></c:if>
							<c:if test="${missionstatetable.missionState eq 31}"><font color="red">全部失败</font></c:if>
							<c:if test="${missionstatetable.missionState eq 4}">任务未能执行</c:if>
							<c:if test="${missionstatetable.missionState eq 5}">周期任务准备撤销</c:if>
							<c:if test="${missionstatetable.missionState eq 6}">周期任务执行撤销</c:if>
							<c:if test="${missionstatetable.missionState eq 7}">周期任务完成撤销</c:if>
						</c:if>
						<c:if test="${missionstatetable.missionStateDesc ne null && missionstatetable.missionStateDesc ne ''}">   -->		
						    ${missionstatetable.missionStateDesc}
			<!--    	</c:if>  -->		
						
						</td>
						<td class="${tdClass }" nowrap="nowrap">${missionstatetable.systemIdName}</td>
						<td class="${tdClass }" nowrap="nowrap">${missionstatetable.groupIdName}</td>
						<td class="${tdClass }" nowrap="nowrap">
							<c:if test="${missionstatetable.viewLevel eq 1}">i18n_ntil.message.publisher_n81i</c:if> 
							<c:if test="${missionstatetable.viewLevel eq 2}">i18n_ntil.message.publisherGroup_n81i</c:if> 
							<c:if test="${missionstatetable.viewLevel eq 3}">i18n_ntil.message.allInSys_n81i</c:if>
							<c:if test="${missionstatetable.viewLevel eq 4}">i18n_emvl.message.unlimited_n81i</c:if>
						</td>
						<td class="${tdClass }" nowrap="nowrap">${missionstatetable.userIdName}</td>
						<td class="${tdClassR }" nowrap="nowrap"><fmt:formatDate value="${missionstatetable.createTime}" type="both" /></td>
				        </tr>
				    </c:if>
						<c:set var="index" value="${index + 1}" />
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="12" align="center" class="color_6">
								i18n_ntil.message.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty missionstateTableList}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
			</form>
		</div>
		<br />
		<div id="popDiv" class="mydiv" style="display:none;">
		<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width:100px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportCurrentXls();" value="i18n_ntil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_ntil.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_ntil.button.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>