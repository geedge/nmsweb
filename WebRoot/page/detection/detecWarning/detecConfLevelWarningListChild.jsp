<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(detecWarningList) > 0}">
		<c:forEach items="${detecWarningList}" var="detecWarning"
			varStatus="vs">
			<c:set var="color" value="color_1" />
			<c:set var="color_end" value="color_7" />
			<c:if test="${vs.count%2!=0 }">
				<c:set var="color" value="color_3" />
				<c:set var="color_end" value="color_6" />
			</c:if>
			<tr>
				<td class="${color }">
					${index+(pageNo-1)*pageSize}
				</td>
				<td class="${color }">
					<font color="${detecWarning.bgcolor}"> <!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
						<a
						href="javascript:void(0);"
						onclick="remoteConn('${detecWarning.nodeSysType }','${detecWarning.nodeIp}','${detecWarning.nodeType }', this)"
						style="color:${detecWarning.bgcolor};}">
							${detecWarning.nodeIp} </a>
					</font>
				</td>
				<td class="${color }">
					<a href="javascript:showRecord('${detecWarning.id }')" title="i18n_dclwlc.message.showRecord_n81i">${detecWarning.detectionSetInfo.checkTypeInfo.checkTypeName1}</a>&nbsp;&nbsp;
				</td>
				<td class="${color }">
					<a href="javascript:showDetectionInfo('${detecWarning.detectionSetInfo.id }','${detecWarning.seqId}')"
											title="i18n_dclwlc.message.showDetectionInfo_n81i"> ${detecWarning.detectionSetInfo.processIdenName}
												</a>
				</td>
				<td class="${color }">
					<c:if test="${detecWarning.checkWay=='0' }">i18n_dclwlc.message.active_n81i</c:if>
					<c:if test="${detecWarning.checkWay=='1' }">i18n_dclwlc.message.passive_n81i</c:if>
				</td>
				<td class="${color }">
					<fmt:formatDate value="${detecWarning.dataCheckTime}"
						pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td class="${color }">
					${detecWarning.persistTime}
				</td>
				<td class="${color }">
					${detecWarning.currentTimes}
				</td>
				<td class="${color }">
					${detecWarning.policeLevel}
				</td>
				<td class="${color }"  >
					<span class="STYLE1" style="word-break:break-all; color: ${detecWarning.bgcolor}">
					    <c:set value="${fn:replace(fn:replace(detecWarning.performaceData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
						<c:set value="${fn:replace(fn:replace(detecWarning.performaceData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
						<span class="prop" data-temp="${stateInfoParam}"<%-- onmouseover="showTitle('infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}',this,event);" onmouseout="hideTitle('infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}');"  --%>>
							<%-- <c:if test="${fn:length(stateInfo) >= 25}">
								${fn:substring(stateInfo,0,25)}...
							</c:if>
							<c:if test="${fn:length(stateInfo) < 25}">
							    ${stateInfo} 
							</c:if> --%>
							<span class="stateInfoVal">${stateInfoParam}</span>
							<%-- <span id="infoTipSpan_${detecWarning.seqId}_${detecWarning.detectionSetInfo.id}" class="infoTip" style="display:none;">${stateInfoParam}</span> --%>
						</span>
					</span>
				</td>
			</tr>
			<c:set var="index" value="${index + 1}" />
		</c:forEach>
	</c:when>
</c:choose>

<script type="text/javascript" >
/*--------------控制表格输出长度--------------------*/
$(function(){
		$(".prop").each(function(){
				var obj = $(this);
				var tx = document.body.clientWidth; //文档的可见长宽
				var ty = document.body.clientHeight;
				$(obj).on("mouseenter",function(event){
					event = event ? event : window.event;
					$(".popover").remove();
	  	 			var x = event.clientX;//鼠标位置
					var y = event.clientY; 
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
