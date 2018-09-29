<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>

<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
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
		<title>i18n_milas.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js' />"></script>
	
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
	<script type="text/javascript" >	
        //页面5分钟刷新一次
        var interval;
		$(function(){
			interval = setInterval('qry()',5*60*1000);
		})
		
		function clear(){
			clearInterval(interval);
		}
	
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/detection/monitorData.do?action=queryAbnormalSet&date="+new Date()+"'/>";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(monid,cid){
	 	clear();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=detail&cId="+cid+"&ids="+monid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
		//绘制折线图
	 function drawPic(ctid,dsiId,id){
	 	clear();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=drawPic&checkTypeId="+ctid+"&dsiId="+dsiId+"&sqId="+id+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
	
	function showDetectionInfo(dsiId,seqId){
		clear();
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=showDetectionInfo&dsiId="+dsiId+"&sqId="+seqId+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
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
				alert('i18n_milas.message.inputInfo_n81i');
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

	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<c:url value='/'/>/detection/monitorData.do?action=emportCurrentXlsAbnormalSet&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/monitorData.do?action=queryAbnormalSet";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/monitorData.do?action=emportAllXlsAbnormalSet&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action ="<%=path%>/detection/monitorData.do?action=queryAbnormalSet";
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
				$("#info").attr("style","width:98.5%;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;");
		}
		$("#maindiv").attr("style","clear:left");
		$("#info").floatHeaderDiv();
	});

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
		
		var childUrlTmp = encodeURI("<c:url value='monitorData.do?action=queryChildForAbnormalSet'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val());
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
		    
		    var urlTmp = encodeURI("<c:url value='monitorData.do?action=queryChildForAbnormalSet'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&cip="+$("#nodeIp").val()+"&ctn="+$("#checkTypeId").val());
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
		}
	});
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
	
	function goBack(){
	    var url = "<%=path%>/detection/switchDetection.do?action=switchDetectInfoGraph";
		document.form3.action =url;
		document.form3.submit();
	}
	
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
	<div class="middle_list"  style="overflow: hidden;">
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/monitorData.do?action=queryAbnormalSet'/>" method="post"  enctype="multipart/form-data">
			<input type="hidden" value="${type}" name="type" />
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			
			<input type="hidden" name="entry" id="entry" value="${entry }"/>
			<input type="hidden" name="detectId" id="detectId" value="${detectId }"/>
			<input type="hidden" name="seqId" id="seqId" value="${seqId }"/>
			<input type="hidden" name="ip" id="ip" value="${ip }"/>
			<input type="hidden" name="pid" id="pid" value="${pid }"/>
			
			<div id="divTop">
				<div class="box_1">					
					<label class="divTopText"><font class="selectText">i18n_milas.text.hostName_n81i</font><input  type="text" id="nodeIp"
								onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
								name="cip" title="i18n_milas.message.hostName_n81i" value="${cip}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
					<label class="divTopText"><font class="selectText">i18n_milas.text.checkType_n81i</font>
						<select  style="width:140px;" name="ctn" id="checkTypeId">
								<option value="">
									--i18n_milas.message.checkTypeDefault_n81i--
								</option>
								<c:if test="${fn:length(allCheckTypeInfo) > 0}">
									<c:set var="isSchedule0" value="0"/>
									<c:forEach items="${allCheckTypeInfo}" var="checkType">
										<c:if test="${checkType.isSchedule != isSchedule0 }">
											<option style="height: 2px;" disabled="disabled">--------------------</option>
											<c:set var="isSchedule0" value="${checkType.isSchedule}"/>
										</c:if>
										<option value="${checkType.id}" 
										<c:if test="${ctn == checkType.id }">selected="selected"</c:if>>
											${checkType.checkTypeName1}
										</option>
									</c:forEach>
								</c:if>
						</select></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
				<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_milas.button.export_n81i"/>
				<c:if test="${entry=='switch'}" >	
					<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_milas.button.back_n81i"/>
				</c:if>
				<jsp:include page="/include/include.jsp" /></div>
			    </div>
			<div id="maindiv">
			<table cellpadding="0" cellspacing="0" class="table" id="info">
				<tr >
					<td width="8%" class="color_top_1" nowrap>
						i18n_milas.text.hostName_n81i
					</td>
					<td width="8%" class="color_top_1" nowrap>
						i18n_milas.text.checkType_n81i
					</td>
					<td width="8%" class="color_top_1" nowrap>
						i18n_milas.text.processIdenName_n81i
					</td>
					<td width="6%" class="color_top_1" nowrap>
						i18n_milas.text.status_n81i
					</td>
					<td width="8%" class="color_top_1">
						i18n_milas.text.dataCheckTime_n81i
					</td>
					<td width="8%" class="color_top_1">
						i18n_milas.text.persistTime_n81i
					</td>
					<td width="5%" class="color_top_1" nowrap>
						i18n_milas.text.tryTimes_n81i
					</td>
					<td width="25%" class="color_8">
						i18n_milas.text.stateInfo_n81i
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
										<c:forEach items="${rowData}" var="cellData" varStatus="ind" begin="2" end="9">										
										<c:set var="dniId" value="${rowData[1] }" />					
										<c:set var="ctiId" value="${rowData[12] }" />
										<c:set var="dsiId" value="${rowData[11] }" />
										<c:set var="nodeIp" value="${rowData[2] }" />
										<c:set var="sqId" value="${rowData[13] }" />
										<c:set var="nodeSysType" value="${rowData[14] }" />	
										<c:set var="charStateNum" value="${rowData[15] }" />
										<c:set var="nodeType" value="${rowData[16] }" />	
										<c:choose>
										<c:when test="${ind.index eq 2}">
										<td class="color_1_1" rowspan="${fn:length(detecInfoList)}" valign="top">
											<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
											<a href="javascript:void(0);"
												onclick="remoteConn('${nodeSysType }','${cellData}','${nodeType }', this)">
												<c:out value="${cellData}" default=""/>
											</a>
										</td>
										</c:when>
										<c:when test="${ind.index eq 3}">
											<td class="color_1_1">
												<a href="javascript:showRecord('${dniId }','${ctiId }')">
													  <c:out value="${cellData}" default=""/>
													 </a>&nbsp;
											</td>
										</c:when>
										<c:when test="${ind.index eq 4}">
											<td class="color_1_1">
												<a href="javascript:showDetectionInfo('${dsiId }','${sqId }')">
															<c:out value="${cellData}" default="" /> </a>&nbsp;													 
													 <c:if test="${charStateNum>0}">
														 <a href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
														     <img src="${pageContext.request.contextPath }/images/action.png"
																	border=0 height="15" width="15" alt="" /> 
														 </a> 
													 </c:if>
											</td>
										</c:when>
										<c:when test="${ind.index eq 5}">
											<td class="color_1_1">
											<c:if test="${fn:trim(cellData)=='1'}"><img src="<c:url value='/images/yes.gif'/>"
													border="0" align="middle" /></c:if>
											<c:if test="${fn:trim(cellData) ne '1'}"><img src="<c:url value='/images/no.gif'/>"
													border="0" align="middle" /></c:if>
											</td>
										</c:when>
										<c:when test="${ind.index eq 6}">
											<td class="color_1_1">
												<c:out value="${cellData}" default=""/>
											</td>
										</c:when>	
										<c:when test="${ind.index eq 9}">
											<c:set value="${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}" var="stateInfo"></c:set>
											<td class="color_7_1" >
												 <c:set value="${fn:replace(fn:replace(cellData,vEnter,'$@$'),'$@$','<br/>')}" var="stateInfoParam"></c:set>
												 <span onmouseover="showTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}',this,event);" onmouseout="hideTitle('infoTipSpan_${sqId}_${ctiId}_${dsiId}');" >	
												       <%--  <c:if test="${fn:length(stateInfo) >= 50}">
															${fn:substring(stateInfo,0,50)}...
														</c:if>
														<c:if test="${fn:length(stateInfo) < 50}">
															${stateInfo}
														</c:if> --%>
														<span class="stateInfoVal">${stateInfo}</span>
														<span id="infoTipSpan_${sqId}_${ctiId}_${dsiId}" class="infoTip" style="display:none;">${stateInfoParam}</span>
												 </span>
											</td>
										
										
										</c:when>										
										<c:otherwise>
											<td class="color_1_1">
												<span class="STYLE1" style="word-break:break-all">
													${fn:replace(fn:replace(cellData,'$@$',''),'<br/>','')}
												</span>
											</td>
										</c:otherwise>
										</c:choose>	
										</c:forEach>	
									</tr>
							</c:if>
							<c:if test="${!flag}">								
								<tr>
								<c:forEach items="${rowData}" var="cellData" varStatus="ind" begin="2" end="9">									
										<c:set var="dniId" value="${rowData[1] }" />					
										<c:set var="ctiId" value="${rowData[12] }" />
										<c:set var="dsiId" value="${rowData[11] }" />
										<c:set var="nodeIp" value="${rowData[2] }" />
										<c:set var="sqId" value="${rowData[13] }" />	
										<c:set var="charStateNum" value="${rowData[15] }" />			
									<c:choose>
									<c:when test="${ind.index eq 2}">
									</c:when>
									<c:when test="${ind.index eq 3}">
										<td class="color_1_1">
											<a href="javascript:showRecord('${dniId }','${ctiId }')">
												  <c:out value="${cellData}" default=""/>
												 </a>&nbsp;
										</td>
									</c:when>
										<c:when test="${ind.index eq 4}">
											<td class="color_1_1">
												<a href="javascript:showDetectionInfo('${dsiId }','${sqId }')">
															<c:out value="${cellData}" default="" /> </a>&nbsp;											 
													 <c:if test="${charStateNum>0}">
														 <a href="javascript:drawPic('${ctiId }','${dsiId }','${sqId }')">
														     <img src="${pageContext.request.contextPath }/images/action.png"
																	border=0 height="15" width="15" alt="" /> 
														 </a> 
													 </c:if>
											</td>
										</c:when>
									<c:when test="${ind.index eq 5}">
										<td class="color_1_1">
											<c:if test="${fn:trim(cellData)=='1'}"><img src="<c:url value='/images/yes.gif'/>"
												border="0" align="middle" /></c:if>
											<c:if test="${fn:trim(cellData) ne '1'}"><img src="<c:url value='/images/no.gif'/>"
													border="0" align="middle" /></c:if>
										</td>
									</c:when>
									<c:when test="${ind.index eq 6}">
										<td class="color_1_1" nowrap="nowrap">
											<c:out value="${cellData}" default=""/>
										</td>
									</c:when>	
									<c:when test="${ind.index eq 9}">
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
								i18n_milas.text.noRecord_n81i
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
		</div>
		<div id="popDiv" class="mydiv" style="display:none;">
		<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width:100px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportCurrentXls();" value="i18n_milas.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_milas.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_milas.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
		<span id="infoTipSpan" class="infoTip" style="display:none;"></span>
	</body>
</html>

