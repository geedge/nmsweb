<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="refresh" content="300;<%=path%>/detection/detectionWarning.do?action=query" />		
		<title>i18n_dclwl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"	type="text/css" />
 		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/scrollBar/perfect-scrollbar.css'/>" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery1.11.3.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js' />"></script>
		<script type="text/javascript" src="<c:url value='/js/WebCalendar.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap.min.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap-tooltip.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap-popover.js' />"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/scrollBar/perfect-scrollbar.js"/>"></script>
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
/* 自定义滚动条 */
.pop-content {
	position:relative;
	max-height:300px;
	padding-left:5px;
}
.ps__rail-x {
	display:none !important;
}
.ps__rail-y {
	display:"" !important;
}
.popover.top {
	margin-top: -3px !important;
}
.popover.bottom {
	margin-top: 3px !important;
}
.fade.in {
  opacity: 1;
}
.popover {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 1010;
  display: none;
  width: 300px;
  padding: 1px;
  text-align: left;
  white-space: normal;
  background-color: #ffffff;
  border: 1px solid #ccc;
  border: 1px solid rgba(0, 0, 0, 0.2);
  -webkit-border-radius: 6px;
     -moz-border-radius: 6px;
          border-radius: 6px;
  -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
     -moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
          box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  -webkit-background-clip: padding-box;
     -moz-background-clip: padding;
          background-clip: padding-box;
}
.fade {
  opacity: 0;
  -webkit-transition: opacity 0.15s linear;
     -moz-transition: opacity 0.15s linear;
       -o-transition: opacity 0.15s linear;
          transition: opacity 0.15s linear;
}				
			</style>	
	</head>
	<script language="javascript" type="text/javascript">	
     
       //页面5分钟刷新一次
		var interval;
		$(function(){
			interval = setInterval('qry()',5*60*1000);
			$(".prop").each(function(){
				var obj = $(this);
				var tx = document.body.clientWidth; //文档的可见长宽
				var ty = document.body.clientHeight;
				$(obj).on("mouseenter",function(event){
					event = event ? event : window.event;
					$(".popover").remove();
	  	 			var x = event.clientX;//鼠标位置
					var y = event.clientY; 
					//alert(tx + "," + ty + "," + x + "," + y);
					if (y < ty/2) {
						var placement = "bottom";
					} else {						
						var placement = "top";
					}
					$(obj).popover({
						html:true,
						content:"<div class='pop-content'><div style='margin-right:15px'>" + $(this).attr("data-temp") + "</div></div>",
						placement:placement
					});
					$(obj).popover("show");
					const ps = new PerfectScrollbar('.pop-content');
					
					//修复因浏览器兼容性导致的弹出框位置不对的问题
					var pop = document.getElementsByClassName("popover")[0]; //弹出层的信息
					var popx1 = pop.offsetLeft;
					var popy1 = pop.offsetTop;
					var popx2 = pop.offsetLeft + pop.offsetWidth;
					var popy2 = pop.offsetTop + pop.offsetHeight;
					
					var propy1 = $(obj).offset().top;
					var propy2 = $(obj).offset().top + $(obj).height();
					if (placement == "top") {
						if (propy1 < popy2) {
							$(pop).css("top", propy1 - 3);
						}
					} else if (placement == "bottom") {
						if (propy2 > popy1) {
							$(pop).css("top", propy2 + 3);
						}
					}
					
				}).on("mouseleave",function(event){
					event = event ? event : window.event;
					var pop = document.getElementsByClassName("popover")[0]; //弹出层的信息
					var popx1 = pop.offsetLeft;
					var popy1 = pop.offsetTop;
					var popx2 = pop.offsetLeft + pop.offsetWidth;
					var popy2 = pop.offsetTop + pop.offsetHeight;
					
					//var popChild = $(obj).find(".stateInfoVal")[0]; //td中的span
					//var popChildyHeight = popChild.offsetHeight;
					
					var x = event.clientX; //鼠标位置
					var y = event.clientY;
					if (y < ty/2) {
						var extraTop = 3;
						var extraBottom = 0;
					} else {						
						var extraTop = 0;
						var extraBottom = 3;
					}
					
					if (x < popx1 || x > popx2 || y < (popy1 - extraTop) || y > (popy2 + extraBottom)) {
						$(obj).popover("hide");
					} else {
						$(pop).on("mouseleave",function(event){
							$(obj).popover("hide");
						});
					}
				});
			});
		})
		
		function clear(){
			clearInterval(interval);
		}
	 //查询记录
	function qry(){
		document.form3.action = "<%=path%>/detection/detectionWarning.do?action=queryAllConfigLevel";		
		document.form3.submit();		
	}

	 //查看详情
	 function showRecord(warnid){
	 	clear();
	 	var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action = "<%=path%>/detection/detectionWarning.do?action=detail&ids="+warnid+"&pageNo="+mypageNo +"&pageSize="+mypageSize;;
		document.form3.submit();		
	}
	
	function showDetectionInfo(dsiId,seqId){
		clear();
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		$("#newPageSize").attr("disabled","true");
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=showDetectionInfo&dsiId="+dsiId+"&sqId="+seqId+"&flag=queryAllConfigLevel"+"&mypageNo="+mypageNo +"&mypageSize="+mypageSize;
		document.form3.submit();
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
				alert('i18n_dclwl.message.hasSpecialChar_n81i');
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
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue,"nodeType":'${nodeType}'},function(data)
		{
			var lianxiangList = data.split(",");
			if('${nodeType}' == '1'){
				jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv,showType:"scroll"});
			}else{
				jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			}
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
		});
	}
	
	function lianxiangStateInfokeyup() {
		var stateInfo = $('#stateInfo').val();
		setTimeout(function(){
			jQuery.post(
				"<%=request.getContextPath()%>/sysManage/dataDictionary!querySouceForAjax.do",
				{'ddid': 'monitorStatusInfo', 'nameLike': stateInfo },
				function(data) {
					var lianxiangList = data.split(",");
					$('#stateInfo').suggest(lianxiangList,{hot_list:lianxiangList,attachObject:'#suggest2'});
					$('#stateInfo').css("color","#000000"); <%-- 修正查询条件文本内容自动变灰 --%>
				}
			);
		},500);
	}
	
	function isShuzi(){
		//if($id("police_level","sz","预警级别")){
		if(document.getElementById("police_level").value.replace(/[\d+]/ig,"").length>0){
		 	alert('i18n_dclwl.message.inputNum_n81i');
		 	document.getElementById("police_level").value = "";
	        return false;
        }else{
			if(document.getElementById("police_level").value!="" && ($("#police_level").val() <=0 || $("#police_level").val()>99)){
				alert("i18n_dclwl.message.policeLevelVal_n81i");				
		 		document.getElementById("police_level").value = "";
				return;
			}
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
		document.form3.action = "<c:url value='/'/>/detection/detectionWarning.do?action=emportCurrentXls&pageType=queryAllConfigLevel&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&police_level="+$("#police_level").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val()+"&dct="+$("#dataCheckTime").val()+"&ip="+$("#nodeIp").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/detectionWarning.do?action=queryAllConfigLevel";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/detectionWarning.do?action=emportAllXls&pageType=queryAllConfigLevel&police_level="+$("#police_level").val()+"&ctn="+$("#checkTypeId").val()+"&pIden="+$("#pIden").val()+"&dct="+$("#dataCheckTime").val()+"&ip="+$("#nodeIp").val();
		document.form3.submit();
		closeDiv();
		document.form3.action ="<%=path%>/detection/detectionWarning.do?action=queryAllConfigLevel";
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
			alert('i18n_dclwl.message.hasSpecialChar_n81i');
			$("#"+id).val('');
			return;
		}
	}
	window.onresize = function(){
		$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
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
		$("#info").floatHeaderDiv();
	});
	
	
	function goBackSwitch() {
		document.form3.action="<%=path%>/detection/switchDetection.do?action=switchDetectInfoGraph";
		document.form3.submit();	
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
		    var url2 = encodeURI("<c:url value='detectionWarning.do?action=queryConfLevelChild'/>&levelAlarm=${levelAlarm}&nodeType="+'${nodeType}'+"&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&police_level="+$("#police_level").val()+"&police_emergent="+$("#police_emergent").val()+"&ctn="+$("#checkTypeId").val()+"&stateInfo="+$("#stateInfo").val()+"&pIden="+$("#pIden").val()+"&dct="+$("#dataCheckTime").val()+"&ip="+$("#nodeIp").val()+"&nodeIpRange="+$("#nodeIpRange").val()) + "&timeoutDetecFilter=${timeoutDetecFilter}";
			$.ajax({
				url:url2,
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
		//初始化级别的显示和隐藏
		var emergentVal = jQuery('#police_emergent').val();
	    if(emergentVal!=undefined && emergentVal!=null) {//需要选择紧急 or 非紧急,就需要初始化级别的显示隐藏
	    	changeEmergent();
	    }
	});
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
	
	function downloadfile(fileName){
			document.form3.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.form3.submit();				
	}
	
	function changeEmergent() {
		var selEmergVal = jQuery('#police_emergent').val();
		if(selEmergVal=='1') {
			jQuery('#levelSpan').show();
		}else {
			jQuery('#levelSpan').hide();
		}
	
	}
	
	/*--------------控制表格输出长度--------------------*/
	$(function(){
		var stateInfos=$(".stateInfoVal");
		for(var i=0;i<stateInfos.length;i++){
			var infoVal=$(stateInfos[i]).text().trim();
			if(infoVal.length>25){
				$(stateInfos[i]).text(infoVal.substring(0,25)).append("...");
			}else{
				$(stateInfos[i]).text(infoVal);
			}
		}
	});
    </script>
	<body>
	<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/detectionWarning.do'/>?action=queryAllConfigLevel" method="post" enctype="multipart/form-data">
			<input type="hidden" name="levelAlarm" value="${1}"/>
			<input type="hidden" name="seqIdList" value="${seqIdList}"/>
			<!-- 从网元监测信息进入时带过来的参数：9个 -->
			<input type="hidden" name="entry" value="${entry}"/>
			<input type="hidden" name="detectId" value="${detectId}"/>
			<input type="hidden" name="seqId" value="${seqId}"/><!-- 因为有seqId，用户在告警界面查询别的节点的信息，返回网元监测信息时，也不会改变之前的节点，ip只是供显示用的 -->
			
			<input type="hidden" name="nodeType" value="${nodeType}"/>
			
	    	<input type="hidden" name="nameFlag" value="${nameFlag}"/>
			<input type="hidden" name="pid" value="${pid}"/>
			<input type="hidden" name="isLeaf" value="${isLeaf}"/>
			<input type="hidden" name="picId" value="${picId}"/>
			<input type="hidden" name="queryParConditionDisplay" value="${queryParConditionDisplay}"/>
			<input type="hidden" name="queryChildConditionDisplay" value="${queryChildConditionDisplay}"/>  	
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			<input type="hidden" name="warnType" id="warnType" value="${warnType }"/>

			<div id="divTop">
				<div class="box_1">		
				<!--  -->
					<c:choose>
					    <c:when test="${emergentSetStr eq null || emergentSetStr=='' || (fn:contains(emergentSetStr,',1,') && fn:contains(emergentSetStr,',0,'))}">
					   	    <label class="divTopText"><font class="selectText">i18n_dclwl.text.police_emergent_n81i</font><select name="police_emergent" id="police_emergent" onchange="changeEmergent();">
					   	    			<option value="">i18n_dclwl.text.changeEmergentDefault_n81i</option>
					   	    			<option value="0" 
					   	    			    <c:if test="${police_emergent=='0'}">  selected="selected" </c:if> >i18n_dclwl.text.emergency_n81i</option>
					   	    			<option value="1"
					   	    			    <c:if test="${police_emergent=='1'}">  selected="selected" </c:if> >i18n_dclwl.text.nonEmergency_n81i</option>
					   	    	  </select></label>
					    </c:when>
					    <c:otherwise>
					    	  <input type="hidden" id="police_emergent" name="police_emergent" value="${police_emergent}"/>
					    </c:otherwise>
					</c:choose>
				    <c:choose>
				    	<c:when test="${emergentSetStr ne null && emergentSetStr!='' && emergentSetStr==',0,'}">
				    	    <!-- 只紧急：无级别条件 -->
				    		<input type="hidden" id="police_level" name="police_level" value="${police_level}"/>
				    		
				    	</c:when>  
				    	<c:otherwise>
				    		 <!-- 空、紧急+非紧急：都不显示；非紧急：显示 [police_emergent!=1 可以避免条件显示跳动：针对不选，或者选紧急+非紧急时，查询条件没选非紧急的情况] -->
						     <span id="levelSpan" <c:if test="${police_emergent!=1 && (emergentSetStr eq null || emergentSetStr=='' ||  (fn:contains(emergentSetStr,',1,') && fn:contains(emergentSetStr,',0,')))}">style="display: none;"</c:if>  >
						    	<label class="divTopText"><font class="selectText">i18n_dclwl.text.police_level_n81i</font>
										<select name="police_level" id="police_level" >
							   	    			<option value="">i18n_dclwl.text.changeEmergentDefault_n81i</option>
							   	    			<c:forEach items="${levelSetList}" var="level" >
								   	    			<option value="${level}"  
								   	    			    <c:if test="${police_level==level}">  selected="selected" </c:if> >${level}i18n_dclwl.text.police_levelSelect_n81i</option>
							   	    			</c:forEach>
							   	    	</select></label>
						     </span>
				    	</c:otherwise>
				    </c:choose>
					<label class="divTopText"><font class="selectText">i18n_dclwl.text.nodeIp_n81i</font> <input  type="text" id="nodeIp"
								onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
								name="ip" title="i18n_dclwl.message.nodeIp_n81i" value="${ip}" size="20" style="width: 100px;"/>
						<div id='suggest1' class="ac_results"></div></label>
					<label class="divTopText"><font class="selectText">i18n_dclwl.text.checkType_n81i</font>
						<select name="checkType">
							<option value="-1" <c:if test="${empty checkType or checkType eq -1}">selected ="selected"</c:if>>i18n_dwl.text.changeEmergentDefault_n81i</option>
							<c:forEach items="${allCheckTypeInfo }" var="checkTypeInfo">
								<option value="${checkTypeInfo.id }" <c:if test="${checkTypeInfo.id eq checkType}">selected ="selected"</c:if>>${checkTypeInfo.checkTypeName1 }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="ctn" title="i18n_dclwl.message.checkType_n81i"  value="${ctn}" id="checkTypeId"  style="width: 100px;"
						onkeyup="lianxiangkeyup('checkTypeName1','CheckTypeInfo','String','checkTypeId','suggest1',this.value);" /> 
					</label>
					<label class="divTopText"><font class="selectText">i18n_dclwl.text.pIden_n81i</font>
						<input   type="text" id="pIden" style="width: 100px" 
								name="pIden"
								title="i18n_dclwl.message.pIden_n81i" 
								value="${pIden}" size="49" onkeyup="checkZF('pIden');"/></label>
					<label class="divTopText"><font class="selectText">i18n_dclwl.text.dataCheckTime_n81i</font>
						<input  type="text" id="dataCheckTime" 
								name="dct" value="${dct}" readonly
								onclick="SelectDate(this,'yyyy-MM-dd',${session.i18n_lang == 'zh_CN'?0:1})" style="width: 90px;"/></label>
					<%-- <label class="divTopText"><font class="selectText">i18n_dclwl.text.stateInfo_n81i</font>--%>
						<input type="hidden" name="stateInfo" title="i18n_dclwl.message.stateInfo_n81i" value="${stateInfo}" id="stateInfo"
								onkeyup="lianxiangStateInfokeyup();" style="width: 100px"/>
						<%-- <div id='suggest2' class="ac_results" style="min-width: 200px; width: auto;"></div></label> --%>
					<label class="divTopText"><font class="selectText">i18n_dclwl.text.timeoutDetecFilter_n81i</font>
						<select name="timeoutDetecFilter">
							<option value="true" <c:if test="${timeoutDetecFilter ne 'false'}"> selected ="selected"</c:if> >i18n_dclwl.message.yes_n81i</option>
							<option value="false" <c:if test="${timeoutDetecFilter eq 'false'}"> selected ="selected"</c:if> >i18n_dclwl.message.no_n81i</option>
						</select></label>
					
					<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
				<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_dclwl.message.export_n81i"/>
					<jsp:include page="/include/include.jsp" />
					&nbsp;
					<c:if  test="${entry=='switch'}">
						<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="goBackSwitch()" value="i18n_dclwl.button.back_n81i"/>
					</c:if>
				</div>
			</div>
			<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr >
						<td width="4%" class="color_top" nowrap>
							i18n_dclwl.text.index_n81i
						</td>
						<td width="6%" class="color_top" nowrap>
							i18n_dclwl.text.nodeIp_n81i
						</td>
						<td width="8%" class="color_top" nowrap>
							i18n_dclwl.text.checkType_n81i
						</td>
						<td width="8%" class="color_top" nowrap>
							i18n_dclwl.text.pIden_n81i
						</td>
						<td width="5%" class="color_top" nowrap>
							i18n_dclwl.text.checkWay_n81i
						</td>
						<td width="10%" class="color_top" nowrap>
							i18n_dclwl.text.dataCheckTime_n81i
						</td>
						<td width="8%" class="color_top" nowrap>
							i18n_dclwl.text.persistTime_n81i
						</td>
						<td width="5%" class="color_top" nowrap>
							i18n_dclwl.text.tryTimes_n81i
						</td>
						<td width="6%" class="color_top" nowrap>
							i18n_dclwl.text.police_level_n81i
						</td>
						<td width="18%" class="color_top" nowrap>
							i18n_dclwl.text.stateInfo_n81i
						</td>
						<!-- 
						<td width="18%" class="color_8" nowrap>
							警告信息
						</td>
						 -->
					</tr>
					<!-- 1、远程连接引入页面 -->
					<jsp:include page="/common/remoteConn.jsp" />
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(detecWarningList) > 0}">
							<c:forEach items="${detecWarningList}" var="detecWarning" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr >	
									<td class="${color }">
										${index+(pageNo-1)*pageSize}
									</td>						
									<td class="${color }">
										<font color="${detecWarning.bgcolor}">
											<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
											<a href="javascript:void(0);"
												onclick="remoteConn('${detecWarning.nodeSysType }','${detecWarning.nodeIp}','${detecWarning.nodeType }', this)"
												style="color:${detecWarning.bgcolor};}">${detecWarning.nodeIp}
											</a>
										</font>
									</td>
									<td class="${color }">
										<a href="javascript:showRecord('${detecWarning.id }')" title="i18n_dclwl.message.showRecord_n81i">${detecWarning.detectionSetInfo.checkTypeInfo.checkTypeName1}</a>&nbsp;&nbsp;
									</td>
									<td class="${color }">
									<a href="javascript:showDetectionInfo('${detecWarning.detectionSetInfo.id }','${detecWarning.seqId}')"
											title="i18n_dclwl.message.showDetectionInfo_n81i"> ${detecWarning.detectionSetInfo.processIdenName}
												</a>
									</td>
									<td class="${color }">
										<c:if test="${detecWarning.checkWay=='0' }">i18n_dclwl.message.active_n81i</c:if>
										<c:if test="${detecWarning.checkWay=='1' }">i18n_dclwl.message.passive_n81i</c:if>
									</td>
									<td class="${color }">
										<fmt:formatDate value="${detecWarning.dataCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td class="${color }">
										${detecWarning.persistTime}
									</td>
									<td class="${color }">
										${detecWarning.currentTimes}
									</td>
									<td class="${color }" >
										${detecWarning.policeLevel}
									</td>									
									<td class="${color }"  >
										<span class="STYLE1" style="word-break:break-all; color: ${detecWarning.bgcolor}">
										    <c:set value="${fn:replace(fn:replace(detecWarning.performaceData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
											<c:set value="${fn:replace(fn:replace(detecWarning.performaceData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
											<span class="prop" data-temp="${stateInfoParam}" <%-- onmouseover="showTitle('infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}',this,event);" onmouseout="hideTitle('infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}');" --%> >
												<%-- <c:if test="${fn:length(stateInfo) >= 25}">
													${fn:substring(stateInfo,0,25)}...
												</c:if>
												<c:if test="${fn:length(stateInfo) < 25}">
												    ${stateInfo} 
												</c:if> --%>
												<span class="stateInfoVal">${stateInfo}</span>
												<%-- <span id="infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}" class="infoTip" style="display:none;">${stateInfoParam}</span> --%>
											</span>
										</span>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="10" class="color_6" align="center">
									i18n_dclwl.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty detecWarningList}">
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
									onclick="javascript:emportCurrentXls();" value="i18n_dclwl.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_dclwl.button.exprotAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_dclwl.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
		
		<span id="infoTipSpan" class="infoTip" style="display:none;"></span>
	</body>
</html>

