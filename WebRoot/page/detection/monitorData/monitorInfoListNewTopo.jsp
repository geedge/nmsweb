<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
	request.setAttribute("vEnter","\n");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_miln.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/scrollBar/perfect-scrollbar.css'/>" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery1.11.3.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-migrate-1.4.1.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js' />"></script>
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
	background-color: #fff;
	border: 1px solid #000;
	text-align: center;
	line-height: 40px;
	font-size: 12px;
	font-weight: bold;
	z-index: 99;
	width: 220px;
	height: 80px;
	left: 50%; /*FF IE7*/
	top: 50%; /*FF IE7*/
	margin-left: -150px !important; /*FF IE7 该值为本身宽的一半 */
	margin-top: -60px !important; /*FF IE7 该值为本身高的一半*/
	margin-top: 0px;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document .               compatMode &&        
				                    document .               compatMode ==
		          
		   'CSS1Compat') ?    
		   
				                    documentElement .               scrollTop +  
		              (   
		     
		     document .       
		       documentElement .               clientHeight-this .            
		  offsetHeight )/ 2 :        
		      /*IE6*/        
				                    document .               body .             
		 scrollTop +   
		             (    
		    
		     document .        
		      body .       
		       clientHeight -                 this .              
		clientHeight )/ 2 );
	/*IE5 IE5.5*/
}

.bg {
	background-color: #ccc;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0; /*FF IE7*/
	filter: alpha(opacity =               50); /*IE*/
	opacity: 0.5; /*FF*/
	z-index: 1;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document .               compatMode &&        
				                    document .               compatMode ==
		          
		   'CSS1Compat') ?    
		   
				                    documentElement .               scrollTop +  
		              (   
		     
		     document .       
		       documentElement .               clientHeight-this .            
		  offsetHeight )/ 2 :        
		      /*IE6*/        
				                    document .               body .             
		 scrollTop +   
		             (    
		    
		     document .        
		      body .       
		       clientHeight -                 this .              
		clientHeight )/ 2 );
	/*IE5 IE5.5*/
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
		<script type="text/javascript">	
     //页面5分钟刷新一次
		var interval;
		$(function(){
			/* interval = setInterval('qry()',5*60*1000); */
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
		document.form3.action = "<c:url value='monitorData.do?action=query&nodeType=${nodeType}&requestType=newTopo&date="+new Date()+"'/>";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(monid,cid){
	 	clear();
	 	var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=detail&cId="+cid+"&ids="+monid+"&pageNo="+mypageNo+"&pageSize="+mypageSize+"&flag="+'newTopo'+"&nodeType="+'${nodeType}'+"&nodeId="+'${nodeId}'+"&nodeGroupId="+'${nodeGroupId}';
		document.form3.submit();		
	}
		//绘制折线图
	 function drawPic(ctid,dsiId,id){
	 	clear();
	 	var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=drawPic&checkTypeId="+ctid+"&dsiId="+dsiId+"&sqId="+id+"&pageNo="+mypageNo+"&pageSize="+mypageSize+"&nodeType="+'${nodeType}'+"&nodeId="+'${nodeId}'+"&nodeGroupId="+'${nodeGroupId}';
		document.form3.submit();		
	}

	function showDetectionInfo(dsiId,seqId){
		clear();
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		$("#newPageSize").attr("disabled","true");
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=showDetectionInfo&dsiId="+dsiId+"&sqId="+seqId+"&mypageNo="+mypageNo+"&mypageSize="+mypageSize+"&nodeType="+'${nodeType}'+"&nodeId="+'${nodeId}'+"&nodeGroupId="+'${nodeGroupId}';
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
				alert('i18n_miln.message.inputInfo_n81i');
				$("#"+id).val('');
				return;
			}
			clearTimeout(set_Id);
			set_Id = setTimeout(ajaxForLianxiang,500);
		}
	}
	function ajaxForLianxiang() 
	{
		if('${requestType}'=="topo"){//拓扑图过来的不做nodeType区分
			jQuery.post("<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
			{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
			{
				var lianxiangList = data.split(",");
				jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			});
		}else{
			jQuery.post("<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
			{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue,"nodeType":0},function(data)
			{
				var lianxiangList = data.split(",");
				jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			});
		}
		
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
		document.form3.action = "<c:url value='/'/>/detection/monitorData.do?action=emportCurrentXlsForTopo&nodeType=0&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<c:url value='monitorData.do?action=query'/>";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/monitorData.do?action=emportAllXlsForTopo&nodeType=0&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action ="<c:url value='monitorData.do?action=query'/>";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
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
				$("#info").attr("style","width:98%;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;");
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
		     var urlTmp = encodeURI("<c:url value='monitorData.do?action=queryChild'/>&nodeType=${nodeType}&requestType=${requestType}&nodeGroupId=${nodeGroupId}&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val()+"&stateInfo="+$("#stateInfo").val());
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
	function downloadfile(fileName){
			document.form3.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.form3.submit();				
	}
	/*--------------控制表格输出长度--------------------*/
	$(function(){
		var stateInfos=$(".stateInfoVal");
		for(var i=0;i<stateInfos.length;i++){
			var infoVal=$(stateInfos[i]).text().trim();
			if(infoVal.length>50){
				$(stateInfos[i]).text(infoVal.substring(0,50)).append("...");
			}else{
				$(stateInfos[i]).text(infoVal);
			}
		}
	});
    </script>
	</head>
	<body>
		<form name=form3 id="frmArticleType"
			action="<c:url value='monitorData.do?action=query&nodeType=${nodeType}&requestType=newTopo&nodeId=${nodeId}&nodeGroupId=${nodeGroupId}'/>&date=<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()).toString()%>"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="pageNoforexp" id="pageNo"
				value="${pageNo }" />
			<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
			<input type="hidden" value="${type }" name="type" id="type" />
			<!-- 来源于拓扑图 begin -->
			<input type="hidden" name="requestType" value="${requestType }" />
			<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
			<input type="hidden" name="nodeId" value="${nodeId }" />
			<!-- 来源于拓扑图 end -->

			<div id="divTop">
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_miln.text.nodeIp_n81i </font>
					<input type="text" id="nodeIp"
						onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
						name="cip" title="i18n_miln.message.nodeIp_n81i " value="${cip}" size="20" />
					<div id='suggest1' class="ac_results"></div></label>
					<label class="divTopText"><font class="selectText">i18n_miln.text.checkType_n81i</font>
						<select name="checkType">
							<option value="-1" <c:if test="${empty checkType or checkType eq -1}">selected ="selected"</c:if>>i18n_dwl.text.changeEmergentDefault_n81i</option>
						    <c:forEach items="${allCheckTypeInfo }" var="checkTypeInfo">
								<option value="${checkTypeInfo.id }" <c:if test="${checkTypeInfo.id eq checkType}">selected ="selected"</c:if>>${checkTypeInfo.checkTypeName1 }</option>
							</c:forEach>
						</select>
					<input type="hidden" name="ctn" title="i18n_miln.message.checkType_n81i"  value="${ctn}" id="checkTypeId" 
					onkeyup="lianxiangkeyup('checkTypeName1','CheckTypeInfo','String','checkTypeId','suggest1',this.value);" /> 
					</label>
					<!-- <label class="divTopText"><font class="selectText">i18n_miln.text.stateInfo_n81i</font> -->
						<input type="hidden" name="stateInfo" title="i18n_miln.message.stateInfo_n81i" value="${stateInfo}" id="stateInfo"
								onkeyup="lianxiangStateInfokeyup();"/>
						<!-- <div id='suggest2' class="ac_results" style="min-width: 200px; width: auto;"></div></label> --> 
					<div style="display:inline; margin-top:10px;">
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle" onclick="javascript:qry();" />
					</div>
				</div>
				<div class="box_2">
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:showDiv();" value="i18n_miln.button.export_n81i" />
					<jsp:include page="/include/include.jsp" /></div>
			</div>
			<div id="maindiv">
				<table cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td width="8%" class="color_top_1" nowrap>
							i18n_miln.text.nodeIp_n81i
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_miln.text.checkType_n81i
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_miln.text.processIdenName_n81i
						</td>
						<td width="6%" class="color_top_1" nowrap>
							i18n_miln.text.state_n81i
						</td>
						<td width="8%" class="color_top_1">
							i18n_miln.text.dataCheckTime_n81i
						</td>
						<td width="8%" class="color_top_1">
							i18n_miln.text.persistTime_n81i
						</td>
						<td width="5%" class="color_top_1" nowrap>
							i18n_miln.text.tryTimes_n81i
						</td>
						<td width="25%" class="color_8">
							i18n_miln.text.stateInfo_n81i
						</td>
					</tr>
					<!-- 1、远程连接引入页面 -->
					<jsp:include page="/common/remoteConn.jsp" />
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(nodeIpGroupListNew) > 0}">
							<c:forEach items="${nodeIpGroupListNew}" var="detecInfoList">
								<c:forEach items="${detecInfoList}" var="rowData" varStatus="vs">
									<c:if test="${vs.index==0}" var="flag">
										<tr>
											<c:forEach items="${rowData}" var="cellData" varStatus="ind"
												begin="1" end="8">
												<c:set var="dniId" value="${rowData[0] }" />
												<c:set var="ctiId" value="${rowData[11] }" />
												<c:set var="dsiId" value="${rowData[10] }" />
												<c:set var="nodeIp" value="${rowData[1] }" />
												<c:set var="sqId" value="${rowData[12] }" />
												<c:set var="nodeSysType" value="${rowData[13] }" />
												<c:set var="charStateNum" value="${rowData[14] }" />
												<c:set var="nodeType" value="${rowData[15] }" />
												<c:set var="status" value="${rowData[4] }" />
												
												<c:if test="${ctiId == 7}">
													<c:set var="isHandShake" value="1"/>
												</c:if>
												<c:if test="${ctiId != 7}">
													<c:set var="isHandShake" value="0"/>
												</c:if>
												
												<!-- 特种设备特殊标记 -->
												<c:set var="specialServer" value="${rowData[18] }" />
												<c:choose>
													<c:when test="${ind.index eq 1}">
														<td class="color_1_1"
															rowspan="${fn:length(detecInfoList)}" valign="top">
															<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
															<a
																href="javascript:void(0);"
																onclick="remoteConn('${nodeSysType }','${cellData}','${nodeType }', this)"><c:out
																	value="${cellData}" default="" /> 
																	<c:if test="${not empty specialServer}"><span style="color:red">*</span></c:if></a>
															
														</td>
													</c:when>
													<c:when test="${ind.index eq 2}">
														<td class="color_1_1">
															<c:if test="${cellData == 'i18n_miln.message.handshake_n81i'}" var="handshake"></c:if>
															<a href="javascript:showRecord('${dniId }','${ctiId }')"
																title="i18n_miln.message.showRecord_n81i"> <c:out value="${cellData}" default="" />
															</a>&nbsp;
														</td>
													</c:when>
													<c:when test="${ind.index eq 3}">
														<td class="color_1_1">
															<a
																href="javascript:showDetectionInfo('${dsiId }','${sqId }')"
																title="i18n_miln.message.showDetectionInfo_n81i"> <c:out value="${cellData}" default="" />
															</a>&nbsp;
															<c:if test="${charStateNum>0}">
																<a
																	href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')"
																	title="i18n_miln.message.drawPic_n81i"> <img
																		src="${pageContext.request.contextPath }/images/action.png"
																		border=0 height="15" width="15" alt="" /> </a>
															</c:if>
														</td>
													</c:when>
													<c:when test="${ind.index eq 4}">
														<td class="color_1_1">
															<c:if test="${fn:trim(cellData)=='1'}">
																<img src="<c:url value='/images/yes.gif'/>" border="0"
																	align="middle" />
															</c:if>
															<c:if
																test="${fn:trim(cellData) == '0' ||fn:trim(cellData) == '-1'}"
																var="handshakeEr">
																<img src="<c:url value='/images/no.gif'/>" border="0"
																	align="middle" />
															</c:if>
														</td>
													</c:when>
													<c:when test="${ind.index eq 5}">
														<td class="color_1_1">
															<c:out value="${cellData}" default="" />
														</td>
													</c:when>
													<c:when test="${ind.index eq 6}">
														<td class="color_1_1" nowrap="nowrap">
															<c:if test="${status !='3'}">
																<c:out value="${cellData}" default="" />
															</c:if>
														</td>
													</c:when>
													<c:when test="${ind.index eq 8}">
													    <c:set value="${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
														<td class="color_7_1" >
															<c:set value="${fn:replace(fn:replace(cellData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
															<span class="prop" data-temp="${stateInfoParam}"<%-- onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this,event);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" --%> >
																<%-- <c:if test="${fn:length(stateInfo) >= 50}">
																	${fn:substring(stateInfo,0,50)}...
																</c:if>
																<c:if test="${fn:length(stateInfo) < 50}">
																	${stateInfo}
																</c:if> --%>
																<span class="stateInfoVal">${stateInfo}</span>
																<%-- <span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span> --%>
															</span>
														</td>
													</c:when>
													<c:otherwise>
														<td class="color_1_1">
															<span class="STYLE1" style="word-break: break-all">
																${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')} </span>
														</td>
													</c:otherwise>			
												</c:choose>
											</c:forEach>
										</tr>
									</c:if>
									<c:if test="${!flag}">
										<tr>
											<c:forEach items="${rowData}" var="cellData" varStatus="ind"
												begin="1" end="8">
												<c:set var="dniId" value="${rowData[0] }" />
												<c:set var="ctiId" value="${rowData[11] }" />
												<c:set var="dsiId" value="${rowData[10] }" />
												<c:set var="nodeIp" value="${rowData[1] }" />
												<c:set var="sqId" value="${rowData[12] }" />
												<c:set var="charStateNum" value="${rowData[14] }" />
												<c:set var="status" value="${rowData[4] }" />
												<c:choose>
													<c:when test="${ind.index eq 1}">
													</c:when>
													<c:when test="${ind.index eq 2}">
														<td class="color_1_1">
															<a href="javascript:showRecord('${dniId }','${ctiId }')"
																title="i18n_miln.message.showRecord_n81i"> <c:out value="${cellData}" default="" />
															</a>&nbsp;
														</td>
													</c:when>
													<c:when test="${ind.index eq 3}">
														<td class="color_1_1">
															<a
																href="javascript:showDetectionInfo('${dsiId }','${sqId }')"
																title="i18n_miln.message.showDetectionInfo_n81i"> <c:out value="${cellData}" default="" />
															</a>&nbsp;
															<c:if test="${charStateNum>0}">
																<a
																	href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
																	<img
																		src="${pageContext.request.contextPath }/images/action.png"
																		border=0 height="15" width="15" alt="" title="i18n_miln.message.drawPic_n81i" />
																</a>
															</c:if>
														</td>
													</c:when>
													<c:when test="${ind.index eq 4}">
														<td class="color_1_1">
															<c:if test="${isHandShake == 0 || !handshakeEr}">
																<c:if test="${fn:trim(cellData)=='1'}">
																	<img src="<c:url value='/images/yes.gif'/>" border="0"
																		align="middle" />
																</c:if>
																<c:if
																	test="${fn:trim(cellData) == '0' || fn:trim(cellData) == '-1'}">
																	<img src="<c:url value='/images/no.gif'/>" border="0"
																		align="middle" />
																</c:if>
															</c:if>
														</td>
													</c:when>
													<c:when test="${ind.index eq 5}">
														<td class="color_1_1" nowrap="nowrap">
															<c:out value="${cellData}" default="" />
														</td>
													</c:when>
													<c:when test="${ind.index eq 6}">
														<td class="color_1_1" nowrap="nowrap">
															<c:if test="${isHandShake == 0 || (!handshakeEr && status !='3')}">
																<c:out value="${cellData}" default="" />
															</c:if>
														</td>
													</c:when>

													<c:when test="${ind.index eq 8}">
													    <c:set value="${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
														<td class="color_7_1" >
															<c:set value="${fn:replace(fn:replace(cellData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
															<span onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this,event);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" >
																<%-- <c:if test="${fn:length(stateInfo) >= 50}">
																	${fn:substring(stateInfo,0,50)}...
																</c:if>
																<c:if test="${fn:length(stateInfo) < 50}">
																	${stateInfo}
																</c:if>		 --%>
																<span class="stateInfoVal">${stateInfo}</span>	
																<span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span>
															</span>		
														</td>
													</c:when>
													<c:otherwise>
														<td class="color_1_1">
															${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}
														</td>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</tr>
									</c:if>
								</c:forEach>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="8" class="color_6" align="center">
									i18n_miln.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty nodeIpGroupListNew}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>

		<div id="popDiv" class="mydiv" style="display: none;">
			<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width: 100px;"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportCurrentXls();" value="i18n_miln.button.exportCurrentPage_n81i" />
			&nbsp;
			<input type="button" class=btn3_mouseout style="width: 80px"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportAllXls();" value="i18n_miln.button.exportAllData_n81i" />
			&nbsp;
			<br />
			<a href="javascript:closeDiv()">i18n_miln.text.closeWindow_n81i</a>
		</div>

		<div id="bg" class="bg" style="display: none;"></div>
		 <span id="infoTipSpan" class="infoTip" style="display:none;"></span>
	</body>
</html>

