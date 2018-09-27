<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
			
	request.setAttribute("vEnter","\n");
%>
<c:set var="index" value="${1}" />
<c:choose>
	<c:when test="${fn:length(nodeIpGroupListNew) > 0}">
		<c:forEach items="${nodeIpGroupListNew}" var="detecInfoList">
			<c:forEach items="${detecInfoList}" var="rowData" varStatus="vs">
			<c:set var="type" value="${rowData[2]}" />
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
										<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
										<a href="javascript:void(0);" name="${cellData}"
										   onclick="remoteConn('${nodeSysType }','${cellData}','${nodeType }', this)">
										   <c:out value="${cellData}" default="" />
										</a>
									</td>
								</c:when>
								<c:when test="${ind.index eq 2}">
									<td class="color_1_1">
										<c:if test="${cellData == 'i18n_smilc.message.handshake_n81i'}">
											<c:set var="handshake" value="true" />
										</c:if>
										<a href="javascript:showRecord('${dniId }','${ctiId }')"
											title="i18n_smilc.message.showRecord_n81i"> <c:out value="${cellData}" default="" /> </a>&nbsp;
									</td>
								</c:when>
								<c:when test="${ind.index eq 3}">
									<td class="color_1_1">
										<a href="javascript:showDetectionInfo('${dsiId }','${sqId }')"
											title="i18n_smilc.message.showDetectionInfo_n81i"> <c:out value="${cellData}" default="" /> </a>&nbsp;
										<c:if test="${charStateNum>0}">
											<a
												href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
												<img
													src="${pageContext.request.contextPath }/images/action.png"
													border=0 height="15" width="15" alt="" title="i18n_smilc.message.drawPic_n81i" /> </a>
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
											test="${(fn:trim(cellData) == '0' ||fn:trim(cellData) == '-1')&&type=='i18n_smilc.message.handshake_n81i' }"
											var="handshakeEr">
											<img src="<c:url value='/images/no.gif'/>" border="0"
												align="middle" />
										</c:if>
										<c:if
											test="${(fn:trim(cellData) == '0' ||fn:trim(cellData) == '-1')&&type!='i18n_smilc.message.handshake_n81i' }">
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
											<span class="stateInfoVal">${stateInfoParam}</span>
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
											title="i18n_smilc.message.showRecord_n81i"> <c:out value="${cellData}" default="" /> </a>&nbsp;
									</td>
								</c:when>
								<c:when test="${ind.index eq 3}">
									<td class="color_1_1">
										<a href="javascript:showDetectionInfo('${dsiId }','${sqId }')"
											title="i18n_smilc.message.showDetectionInfo_n81i"> <c:out value="${cellData}" default="" /> </a>&nbsp;
										<c:if test="${charStateNum>0}">
											<a
												href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
												<img
													src="${pageContext.request.contextPath }/images/action.png"
													border=0 height="15" width="15" alt="" title="i18n_smilc.message.drawPic_n81i" /> </a>
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
											<span class="prop" data-temp="${stateInfoParam}" <%-- onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this,event);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" --%> >
											<%-- <c:if test="${fn:length(stateInfo) >= 50}">
												${fn:substring(stateInfo,0,50)}...
											</c:if>
											<c:if test="${fn:length(stateInfo) < 50}">
												${stateInfo} 
											</c:if>		 --%>
											<span class="stateInfoVal">${stateInfoParam}</span>	
											<%-- <span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span> --%>
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
		var stateInfos=$(".stateInfoVal");
		for(var i=0;i<stateInfos.length;i++){
			var infoVal=$(stateInfos[i]).text().replace("<br>","").replace("<br/>","").trim();
			if(infoVal.length>50){
				$(stateInfos[i]).html(infoVal.substring(0,50)).append("...");
			}else{
				$(stateInfos[i]).html(infoVal);
			}
		}
	});
</script>
