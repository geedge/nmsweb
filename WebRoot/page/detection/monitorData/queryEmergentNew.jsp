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
		<title>i18n_qe.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/scrollBar/perfect-scrollbar.css'/>" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery1.11.3.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/WebCalendar.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap.min.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap-tooltip.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/bootstrap-popover.js' />"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/scrollBar/perfect-scrollbar.js"/>"></script>
	</head>
	<style>
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
	//绘制折线图
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
	 function drawPic(ctid,dsiId,id){
	 	clear();
	 	var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=drawPic&checkTypeId="+ctid+"&dsiId="+dsiId+"&flag=queryEmergentDetail"+"&sqId="+id+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&nodeType="+'${nodeType}'+"&nodeId="+'${nodeId}'+"&nodeGroupId="+'${nodeGroupId}';
		document.form3.submit();		
	}

	function showDetectionInfo(dsiId,seqId){
		clear();
		var mypageNo = $("#currentPage").html();
		var mypageSize = $("#newPageSize").val();
		$("#newPageSize").attr("disabled","true");
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=showDetectionInfo&dsiId="+dsiId+"&sqId="+seqId+"&flag=queryEmergentDetail"+"&mypageNo="+mypageNo+"&mypageSize="+mypageSize+"&nodeType="+'${nodeType}'+"&nodeId="+'${nodeId}'+"&nodeGroupId="+'${nodeGroupId}';
		document.form3.submit();
	}
	
	function ieBrowser(){
		/* if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		} */
	}
	$(function(){
		var dh = document.body.clientHeight;
		if(dh==0){
			location.reload();
		}
		var dhh = dh-30+"px;";
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
		intervalID = setInterval(function(){cando();},800);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
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
		    var url2="<c:url value='/detection/monitorData.do?action=queryEmergentChildDetail'/>&pageNo="+(++pagePoint)+"&pageSize="+'${pageSize }'+"$nodeType=${nodeType}$&requestType=topo&requestType=topo&nodeGroupId="+'${nodeGroupId}&nodeId=${nodeId}';
		    var urlTmp = encodeURI(url2);
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
				success : function(data) {
					var resultHtml = $(data);
					var parentLastIpTd = $("td[rowspan]:last");
					var childFirstIpTd = $(resultHtml).find("td[rowspan]:first");
					var pLastIp = $(parentLastIpTd).text().trim();
					var cFirstIp = $(childFirstIpTd).text().trim();
					if (pLastIp == cFirstIp) {
						$(parentLastIpTd).attr("rowspan", $(parentLastIpTd).attr("rowspan")+$(childFirstIpTd).attr("rowspan"));
						$(resultHtml).children("td[rowspan]:first").remove();
					}
					$("#info").append($(resultHtml));//用append方法追加内容到mypage元素。 
					//$("#info").append($(data));//用append方法追加内容到mypage元素。
				   	$("#currentPage").html(pagePoint);//修改页码
			    	$("#pageNo").val(pagePoint);
				}
			});
			loadButton();
		}
	});
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
	
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
	<body>
		<form name=form3 id="frmArticleType"
			action="<c:url value='monitorData.do?action=queryEmergentDetail&nodeType=${nodeType}&requestType=topo&nodeId=${nodeId}&nodeGroupId=${nodeGroupId}'/>&date=<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()).toString()%>"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="pageNoforexp" id="pageNo"
				value="${pageNo }" />
				<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
			<input type="hidden" value="${type }" name="type" id="type" />
			<!-- 来源于拓扑图 begin -->
			<input type="hidden" name="requestType" value="${requestType }" />
			<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
			<!-- 来源于拓扑图 end -->
			<div id="maindiv">
			<table cellpadding="0" cellspacing="0" class="table" id="info">
				<tr>
					<td width="8%" class="color_top_1" nowrap>
						i18n_qe.text.nodeIp_n81i 
					</td>
					<td width="8%" class="color_top_1" nowrap>
						i18n_qe.text.checkType_n81i
					</td>
					<td width="8%" class="color_top_1" nowrap>
						i18n_qe.text.processIdenName_n81i
					</td>
					<td width="6%" class="color_top_1" nowrap>
						i18n_qe.text.state_n81i
					</td>
					<td width="8%" class="color_top_1">
						i18n_qe.text.dataCheckTime_n81i
					</td>
					<td width="8%" class="color_top_1">
						i18n_qe.text.persistTime_n81i
					</td>
					<td width="5%" class="color_top_1" nowrap>
						i18n_qe.text.tryTimes_n81i
					</td>
					<td width="25%" class="color_8">
						i18n_qe.text.stateInfo_n81i
					</td>
				</tr>
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
											<c:choose>
												<c:when test="${ind.index eq 1}">
													<td class="color_1_1" rowspan="${fn:length(detecInfoList)}"
														valign="top">
															<c:out
																value="${cellData}" default="" /> 
													</td>
												</c:when>
												<c:when test="${ind.index eq 2}">
													<td class="color_1_1">
														<c:if test="${cellData == 'i18n_qe.message.handshake_n81i'}" var="handshake"></c:if>
															<c:out value="${cellData}" default="" /> &nbsp;
													</td>
												</c:when>
												<c:when test="${ind.index eq 3}">
													<td class="color_1_1">
													<a
																href="javascript:showDetectionInfo('${dsiId }','${sqId }')"
																title="i18n_qe.button.showDetectionInfo_n81i"> <c:out value="${cellData}" default="" />
															</a>&nbsp;
															<c:if test="${charStateNum>0}">
																<a
																	href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')"
																	title="i18n_qe.button.drawPic_n81i"> <img
																		src="${pageContext.request.contextPath }/images/action.png"
																		border=0 height="15" width="15" alt="" /> </a>
															</c:if>
														<!--<c:out value="${cellData}" default="" />
														<c:if test="${charStateNum>0}">
																<img
																	src="${pageContext.request.contextPath }/images/action.png"
																	height="15" width="15" alt="" /> 
														</c:if>
														-->
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
															<span class="prop" data-temp="${stateInfoParam}" <%-- onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this,event);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" --%> >
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
															<c:out value="${cellData}" default="" />
													</td>
												</c:when>
												<c:when test="${ind.index eq 3}">
													<td class="color_1_1">
														<c:out value="${cellData}" default="" />
														<c:if test="${charStateNum>0}">
																<img border="0"
																	src="${pageContext.request.contextPath }/images/action.png"
																	  height="15" width="15" alt="" /> 
														</c:if>
													</td>
												</c:when>
												<c:when test="${ind.index eq 4}">
													<td class="color_1_1">
														<c:if test="${!handshakeEr}">
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
														<c:if test="${!handshakeEr && status !='3'}">
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
								i18n_qe.text.noRecord_n81i
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
      <span id="infoTipSpan" class="infoTip" style="display:none;"></span>
	</body>
</html>

