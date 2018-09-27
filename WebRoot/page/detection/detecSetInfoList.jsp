<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expries",0);
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dsil.message.title_n81i</title>
 		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
 		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
			
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
	</head>

	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_dsil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_dsil.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addDetecSet(){
		document.form3.action ="<%=path%>/detection/detectionSet!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updDetecSet(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_dsil.message.selectARow_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/detectionSet!executeAction.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //停用
	 function stopDSet(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_dsil.message.selectARow_n81i");
	 	}else{///0 无效，1 有效
	 		if(isOperation("ids", 0)){//当前状态是0，不能停用操作
				alert('i18n_dsil.message.invalidStatus_n81i');
			}else{
				document.form3.action ="<%=path%>/detection/detectionSet!executeAction.do?action=stop";
				document.form3.submit();
			}
		}
	 }
	 //启用
	 function startDSet(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_dsil.message.selectARow_n81i");
	 	}else{//0 无效，1 有效
	 		if(isOperation("ids", 1)){//当前状态是1，不能启用操作
				alert('i18n_dsil.message.validSetting_n81i');
			}else{
				document.form3.action ="<%=path%>/detection/detectionSet!executeAction.do?action=start";
				document.form3.submit();
			}
		}
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/detection/detectionSet.do?action=query";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(setid){
		document.form3.action = "<%=path%>/detection/detectionSet!executeAction.do?action=detail&ids="+setid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
		
	//parent.document.all("listFrame").style.height = document.body.scrollHeight + 16;
	
	//报警设置
	 function addPoliceSet(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_dsil.message.selectARow_n81i");
	 	}else{
	 		var setId = $("input:checked").val();
			window.location="<%=path%>/detection/policeSet!executeAction.do?action=query&pIden="+'${pIden}'+"&ctn="+'${ctn}'+"&ip="+'${ip}'+"&setId="+setId;
		}
	 }
	
	var set_Id;
	var ajaxProperties = "";
	var ajaxTableName = "";
	var ajaxType = "";
	var id = "";
	var returnDiv = "";
	var ajaxValue = "";
	
	function lianxiangkeydown() {
		clearTimeout(set_Id);
	}
	
	function lianxiangkeyup(ajaxProperties1,ajaxTableName1,ajaxType1,id1,returnDiv1,ajaxValue1) {
		if(parent.document.getElementById("lianxiangStatus").value=="2")
		{
			if(jQuery.trim(ajaxValue1)=="") return false;
			
			ajaxProperties = ajaxProperties1;
			ajaxTableName = ajaxTableName1;
			ajaxType = ajaxType1;
			id = id1;
			returnDiv = returnDiv1;
			
			if(!checkStrNoDian(ajaxValue1)){
				ajaxValue = ajaxValue1;
			}else{
				clearTimeout(set_Id);
				alert('i18n_dsil.message.hasSpecialChar_n81i');
				$("#"+id).val('');
				return;
			}
			clearTimeout(set_Id);
			set_Id = setTimeout(ajaxForLianxiang,500);
		}
	}
	
	function ajaxForLianxiang() 
	{
		jQuery.post("<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
		{
			var lianxiangList = data.split(",");
			jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
		});
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


	// 程辉 2013-5-8 新增 模板下载 
	function downloadExample() {
		document.form3.action = "<c:url value='/'/>/detection/detectionSet.do?action=downloadExample";
		document.form3.submit();
		document.form3.action = "<%=path%>/detection/detectionSet.do?action=query";
	}

	//程辉 2013-5-8 新增 导入
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_dsil.message.selectImportFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_dsil.message.selectCorrectImportFile_n81i");
		}else if(confirm('i18n_dsil.message.sureToImport_n81i')){
			document.form3.action = "<c:url value='/'/>/detection/detectionSet.do?action=importXls";
			document.form3.submit();
			document.form3.action = "<%=path%>/detection/detectionSet.do?action=query";
		}
	}
	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<c:url value='/'/>/detection/detectionSet.do?action=emportCurrentXls&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&ip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/detectionSet.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/detectionSet.do?action=emportAllXls&ip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/detectionSet.do?action=query";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}
	
	
	function checkZF(id){
		if(containSpecial($("#"+id).val())){
			alert('i18n_dsil.message.hasSpecialChar_n81i');
			$("#"+id).val('');
			return;
		}
	}
	
	function goGuide(datas) {
		if(datas!=null && datas!=""){
		 	if(datas.resu=='over') {
		 		window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
			}
		 }
	}
	
	$(function(){
		var dh = document.body.clientHeight; 
		var dhh = dh-90+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-90){
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
	//	$("#maindiv").attr("style","clear:left");
		if($("#isComplete").val()=='0'){
			//var content = {
		    //    content: '业务系统操作已完成，是否进行下一步操作?',
		    //    buttons: { '下一步': 1, '返回'：0,'取消': -1 },
		    //    buttonsFocus: 0,
		    //    submit: function (v, h, f) {
		    //        if(v == 1) {//执行下一步--用户组
		    //            window.location ="<%=path%>/sysManage/userGroupPerssion.do?action=query";
		    //        }
		    //       if(v == 0){//返回到设置向导页
		    //            window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
		    //        }
		    //        if(v == -1){//返回到设置向导页
		    //            return;
		    //        }
		    //    }
			//};

			//$.jBox(content);
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:10,
		 					packName:'jcsz'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_dsil.message.detecationWarning_n81i", "i18n_dsil.message.hint_n81i", submit,{icon: false});
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
	var flashFlag = false;
	var memoryData ;
	var intervalID ;
	$(document).ready(function(){//DOM的onload事件
		//$(”#mypage”).load(”table.html”);//table.html的内容被加载到mypage元素
		$("#maindiv").scroll( function() {//定义滚动条位置改变时触发的事件。
		    hght=this.scrollHeight;//得到滚动条总长，赋给hght变量
		    topH=this.scrollTop+this.clientHeight;//得到滚动条当前值，赋给top变量
		});
		
		var childUrlTmp = encodeURI("<c:url value='detectionSet.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&ip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val());
		$.get(childUrlTmp, function(data){//利用jquery的get方法得到table.html内容
		    memoryData = data;
		    flashFlag = true;
		});

		intervalID = setInterval(function(){cando();},1000);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
		function cando(){
			//alert(topH+" " +hght);
			if(topH!=0 && hght!=0 && topH == hght && flashFlag){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
		    	show();//如果是，调用show函数加载内容。
		    }
			//if(topH>parseInt(hght/3)*2){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
		    //	show();//如果是，调用show函数加载内容。
		    //}
		}
		
		function show(){
			flashFlag=false;
		    hght=0;//恢复滚动条总长，因为$(”#mypage”).scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载……
		    topH=0;//原因同上。
		    var flag2 = true;
		    if(memoryData!=null&&memoryData!=""&&memoryData.replace(/(^\s*)|(\s*$)/g,"")!=""){
			    try{
		    	$("#info").append($(memoryData));//用append方法追加内容到mypage元素。
		    	$("#currentPage").html(pagePoint);
		    	$("#pageNo").val(pagePoint);
		    	flag2 = false;
			    }catch(err){
				    
				}
		    }
		    
		    var urlTmp = encodeURI("<c:url value='detectionSet.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&ip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val());
			$.get(urlTmp, function(data){//利用jquery的get方法得到table.html内容
			    if(flag2){
				    try{
			   		$("#info").append($(data));//用append方法追加内容到mypage元素。
				    }catch(err){
					    
					}
			    }else{
			   		flag2 = true;
			   		memoryData = data;
			    }
			    //无数据
			    if(data==null||data==""){
			    	clearInterval(intervalID);
			    }
			    flashFlag = true;
			});
			loadButton();
		}
	});
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
    </script>
	<body>
	<div class="middle_list" style="overflow: hidden;">			
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/detectionSet.do?action=query'/>" method="post" enctype="multipart/form-data">
			<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			<div id="divTop">
				<div class="box_1">		
						<label class="divTopText"><font class="selectText">i18n_dsil.text.nodeIp_n81i</font>
						<input  type="text" id="nodeIp" 
							onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
							name="ip" title="i18n_dsil.message.nodeIp_n81i" value="${ip}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_dsil.text.checkTypeName_n81i</font>
						<select  style="width:140px;" name="ctn" id="checkTypeId">
								<option value="">
									--i18n_dsil.message.selectDefault_n81i--
								</option>
								<c:if test="${fn:length(allCheckTypeInfo) > 0}">
									<c:set var="isSchedule0" value="0"/>
									<c:forEach items="${allCheckTypeInfo}" var="checkType">
										<c:if test="${checkType.isSchedule != isSchedule0 }">
											<option style="height: 2px;" disabled="disabled">--------------------</option>
											<c:set var="isSchedule0" value="${checkType.isSchedule}"/>
										</c:if>
										<option value="${checkType.id}" 
										<c:if test="${not empty ctn && ctn == checkType.id }">selected="selected"</c:if>>
											${checkType.checkTypeName1}
										</option>
									</c:forEach>
								</c:if>
						</select></label>
						<label class="divTopText"><font class="selectText">i18n_dsil.text.processIdenName_n81i
						<input type="text" id="pIden" style="width: 160px" 
								name="pIden"
								title="i18n_dsil.message.processIdenName_n81i" 
								value="${pIden}" size="49" onkeyup="checkZF('pIden');"/></font>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle" onclick="javascript:qry();" />
							&nbsp;
				</div>
				<div class="box_2">
				<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_dsil.button.downloadExample_n81i"/>
								&nbsp;		
			<input type="button" value="i18n_dsil.text.importXls_n81i" title="i18n_dsil.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_dsil.button.importXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_dsil.button.showDiv_n81i"/>
				<br/>
				<div style="float: left">
					<jsp:include page="/include/include.jsp" />	
					</div>				
				</div>	
			</div>
			<div  style="height: 60px"></div>
			<div id="maindiv">
			<table border="0" cellpadding="0" cellspacing="0" class="table" id="info" style="table-layout: fixed;word-wrap:break-word;">
				<tr>
					<td width="6%" class="color_top">
						<!-- 
						<input type="checkbox" ${ADMFlag ? "disabled='disabled'":""}
							name="checkbox62" value="checkbox" onClick="checkAll(this)" />
						 -->
							i18n_dsil.text.index_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.nodeGroup_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.nodeIp_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.checkTypeName_n81i
					</td>
					<!-- 
					<td width="5%" class="color_top" >
						监测方式
					</td>
					 -->
					<td width="4%" class="color_top" >
						i18n_dsil.text.checkGap_n81i
					</td>
					<td width="4%" class="color_top" >
						i18n_dsil.text.checkMaxTimes_n81i
					</td>
					<td width="5%" class="color_top">
						i18n_dsil.text.checkOutTime_n81i
					</td>
					<td width="5%" class="color_top">
						i18n_dsil.text.planCheckTime_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.processIdenName_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.processFile_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.processPath_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_dsil.text.isControlStart_n81i
					</td>
					<td width="6%" class="color_top" >
						i18n_dsil.text.controlStartTime_n81i
					</td>
					<td width="3%" class="color_top" >
						i18n_dsil.text.isSchedule_n81i
					</td>
					<td width="3%" class="color_8" >
						i18n_dsil.text.detectionSetState_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
					<c:when test="${fn:length(detecSetList) > 0}">
						<c:forEach items="${detecSetList}" var="detecSet" varStatus="vs">
							<input type="hidden" id="yxbz${detecSet.id }"
								name="yxbz${detecSet.id }" value="${detecSet.detectionSetState}" />
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
							<tr>
								<td class="${color }">
										<input type="checkbox" name="ids" id="ids" ${(ADMFlag && detecSet.viewLevel ne 4) || (!ADMFlag && detecSet.viewLevel eq 4) ? "disabled='disabled'":""}
											value="${detecSet.id}" />
										${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }" >
									${detecSet.nodeGroupsName}
								</td>
								<td class="${color }">
									${detecSet.nodeIpsName}
								</td>
								<td class="${color }">
									<a href="javascript:showRecord('${detecSet.id }')">${detecSet.checkTypeInfo.checkTypeName1}</a>
								</td>
								<!-- 
								<td class="${color }">
									<c:if test="${detecSet.checkWay=='0' }">主动</c:if>
									<c:if test="${detecSet.checkWay=='1' }">被动</c:if>
								</td>
								 -->
								<td class="${color }">
									${detecSet.checkGap}
								</td>
								<td class="${color }">
									${detecSet.checkMaxTimes}
								</td>
								<td class="${color }">
									${detecSet.checkOutTime}
								</td>
								<td class="${color }">
									<fmt:formatDate value="${detecSet.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td class="${color }">
									${detecSet.processIdenName}
								</td>
								<td class="${color }" style="word-break:break-all">
									${detecSet.processFile}
								</td>
								<td class="${color }" style="word-break:break-all">
									${detecSet.processPath}
								</td>
								<td class="${color }">
									<c:if test="${detecSet.isControlStart=='0' }">i18n_dsil.message.manually_n81i</c:if> 
									<c:if test="${detecSet.isControlStart=='1' }">i18n_dsil.message.NCStart_n81i</c:if>
								</td>
								<td class="${color }">
									<fmt:formatDate value="${detecSet.controlStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td class="${color }">
									<c:if test="${detecSet.checkTypeInfo.isSchedule=='0' }">i18n_dsil.message.yes_n81i</c:if> 
									<c:if test="${detecSet.checkTypeInfo.isSchedule=='1' }">i18n_dsil.message.no_n81i</c:if>
								</td>
								<td class="${color_end }">
									<c:if test="${detecSet.detectionSetState=='0' }"><font color="#FF0000">i18n_dsil.message.invalid_n81i</font></c:if> 
									<c:if test="${detecSet.detectionSetState=='1' }">i18n_dsil.message.valid_n81i</c:if>
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="15" height="20" class="color_6" align="center">
								i18n_dsil.message.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			</div>
			<c:if test="${!empty detecSetList}">
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
									onclick="javascript:emportCurrentXls();" value="i18n_dsil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_dsil.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_dsil.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>

