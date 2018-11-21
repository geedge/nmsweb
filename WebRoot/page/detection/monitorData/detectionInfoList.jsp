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
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter", "\n");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dil.message.title_n81i</title>
		<style>
			/* 自定义滚动条 */
			.pop-content {
				position:relative;
				max-height:300px;
			}
			/* .pop-content::-webkit-scrollbar {
				width:3px;
				height:1px;
			}
			.pop-content::-webkit-scrollbar-thumb {
				border-radius:5px;
				-webkit-box-shadow:inset 0 0 2px #CCCCCC;
				background:#CCCCCC;
			}
			.pop-content::-webkit-scrollbar-track {
				-webkit-box-shadow:inset 0 0 2px #EDEDED;
				background:white;
				border-radius:5px;
			} */
		</style>
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
			src="<c:url value='/js/WebCalendar.js' />"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/scrollBar/perfect-scrollbar.js"/>"></script>
		<script type="text/javascript">	
	
	 //查询记录
	 function qry(){
		document.form3.action = "<c:url value='monitorData.do?action=showDetectionInfo&date="+new Date()+"'/>";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(monid,cid){
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=detailWarning&cId="+cid+"&ids="+monid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
		//绘制折线图
	function drawPic(ctid,dsiId,id){
		document.form3.action = "<%=path%>/detection/monitorData!executeAction.do?action=drawPic&checkTypeId="+ctid+"&dsiId="+dsiId+"&sqId="+id+"&nodeType="+$("#nodeType").val()+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
	
	function goBack(){
		var action ="<c:url value='/detection/monitorData.do?action=query'/>";
		if($("#type").val()== "1"){
			action ="<c:url value='/detection/monitorData.do?action=queryNE'/>";
		}else if($("#type").val()== "2"){
			action ="<c:url value='/detection/monitorData.do?action=queryAbnormalSet'/>";
		}else if($("#flag").val()== "warning"&&$("#nodeType").val()== "0"){
			action ="<c:url value='/detection/detectionWarning.do?action=query'/>";
		}else if($("#flag").val()== "warning"&&$("#nodeType").val()== "1"){
			action ="<c:url value='/detection/detectionWarning.do?action=queryNE'/>";
		}else if($("#flag").val()== "warning"&&$("#nodeType").val()== ""){//左下角动画报警
			action ="<c:url value='/detection/detectionWarning.do?action=queryAll&warnType=leftWarn&police_emergent=0'/>";
		}else if($("#flag").val()== "queryAllConfigLevel"){
			action ="<c:url value='/detection/detectionWarning.do?action=queryAllConfigLevel'/>";
		} else if($("#flag").val()== "queryEmergent"){
			action ="<c:url value='/detection/monitorData.do?action=queryEmergent'/>";
		} else if($("#flag").val()== "queryEmergentDetail"){
			action ="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&nodeType=${nodeType}&requestType=topo&nodeGroupId=${nodeGroupId}&nodeId=${nodeId}'/>";
		}
		if($("#requestType").val()== "newTopo"){
			console.log("ccccmmmmmmmmmmmmmmmm")
			action ="<c:url value='/detection/monitorData.do?action=query&nodeId=${nodeId}'/>";
		}
		document.form3.action = action;
		document.form3.submit();
	}
	
	function checkDate(){
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		if(startTime != "" && endTime!=""){
			if(startTime > endTime){
				alert("i18n_dil.message.checkDate_n81i");
				$("#endTime").val("");
				$("#endTime").focus();
			}
		}
	}
	
	
	$(function(){
		$('.pop-content').each(function(){
			var ps = new PerfectScrollbar(this);
		})
		var dh = document.body.clientHeight; 
		var dhh = dh-60+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-60){
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
			if(ieBrowser()){
				$("#info").attr("style","width:100%;clear:both;");
			}else{
				$("#info").attr("style","width:98.5%;clear:both;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;clear:both;");
		}
		$("#info").floatHeaderDiv();
	//	$("#info").attr("style","clear:left");
	
	});

	function ieBrowser(){
		if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		}
	}
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
	var dsiId="${dsiId }";
	var seqId="${sqId }";
	$(document).ready(function(){//DOM的onload事件
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
		    var urlTmp = encodeURI("<c:url value='monitorData!executeAction.do?action=showDetectionInfoChild'/>&dsiId="+dsiId+ "&sqId="+seqId+"&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&sTime="+$("#startTime").val()+"&eTime="+$("#endTime").val()+"&status="+$("#status").val()+"&date=<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(
							new Date()).toString()%>");
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
				success : function(data) {
					$("#info").append($(data));//用append方法追加内容到mypage元素。
				   	$("#currentPage").html(pagePoint);//修改页码
			    	$("#pageNo").val(pagePoint);
			    	$('.pop-content').each(function(){
						var ps = new PerfectScrollbar(this);
					})
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
	
	function changeEmergent() {
		var selEmergVal = jQuery('#police_emergent').val();
		if(selEmergVal=='1') {
			jQuery('#levelSpan').show();
		}else {
			jQuery('#levelSpan').hide();
		}
	}
    </script>
	</head>
	<body>
		<form name=form3 id="frmArticleType"
			action="<c:url value='monitorData.do?action=showDetectionInfo'/>&date=<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(
							new Date()).toString()%>"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="pageNoforexp" id="pageNo"
				value="${pageNo }" />
			<!-- 查看检测设置历史记录 begin -->
			<input type="hidden" name="dsiId" value="${dsiId }" />
			<input type="hidden" name="sqId" value="${sqId }" />
			<input type="hidden" name="flag" id="flag" value="${flag }" />
			<input type="hidden" name="showHistory" value="${showHistory }" />
			<input type="hidden" name="entry" value="${entry }" />
			<input type="hidden" name="cip" value="${cip }" />
			<!-- nodeType=1：异常网元  nodeType=0:异常服务器 -->
			<input type="hidden" value="${nodeType }" name="nodeType"
				id="nodeType" />
			<!-- 查看检测设置历史记录 end -->
			<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
			<input type="hidden" value="${type }" name="type" id="type" />
			<!-- 来源于拓扑图 begin -->
			<input type="hidden" name="requestType" value="${requestType }" id="requestType" />
			<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
			<!-- 来源于拓扑图 end -->
			<input type="hidden" name="detectId" id="detectId"
				value="${detectId }" />
			<input type="hidden" name="ip" id="ip" value="${ip }" />
			<input type="hidden" name="pid" id="pid" value="${pid }" />
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<input type="hidden" name="stateInfo" id="stateInfo" value="${stateInfo }" />
			<input type="hidden" name="pIden" id="pIden" value="${pIden }" />
			<input type="hidden" name="dct" id="dct" value="${dct }" />
			<input type="hidden" name="police_emergent" id="police_emergent"
				value="${police_emergent }" />
			<input type="hidden" name="nodeIpRange" value="${nodeIpRange}"
				id="nodeIpRange" />
			<input type="hidden" name="nodeGroupStr" id="nodeGroupStr"
				value="${nodeGroupStr }" />
			<input type="hidden" name="police_level" id="police_level"
				value="${police_level }" />
			<input type="hidden" name="mypageNo" value="${mypageNo }" />
			<input type="hidden" name="mypageSize" value="${mypageSize }" />
			<div id="divTop">
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_dil.text.startTime_n81i</font>:
					<input type="text" id="startTime" name="sTime"
						onclick="SelectDate(this,'yyyy-MM-dd',${session.i18n_lang == 'zh_CN'?0:1})" value="${sTime}"
						onchange="checkDate();" />
					--
					<input type="text" id="endTime" name="eTime"
						onclick="SelectDate(this,'yyyy-MM-dd',${session.i18n_lang == 'zh_CN'?0:1})" value="${eTime}"
						onchange="checkDate();" /></label>
					&nbsp;&nbsp;&nbsp; <label class="divTopText"><font class="selectText">i18n_dil.text.status_n81i</font>:
					<select id="status" name="status" style="width: 80px;">
						<option value="">
							i18n_dil.message.statusDefault_n81i
						</option>
						<option value="1"
							<c:if test="${status =='1'}">selected="selected"</c:if>>
							i18n_dil.message.normal_n81i
						</option>
						<option value="-1,0"
							<c:if test="${status == '-1,0'}">selected="selected"</c:if>>
							i18n_dil.message.abnormal_n81i
						</option>

					</select></label>
					&nbsp;&nbsp;&nbsp;
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
					<jsp:include page="/include/include.jsp" />
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'" onclick="goBack()"
						value="i18n_dil.button.back_n81i" />
				</div>
			</div>
			<div id="maindiv">
				<table cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td width="8%" class="color_top_1" nowrap>
							i18n_dil.text.nodeIp_n81i 
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_dil.text.checkType_n81i
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_dil.text.checkTypeName_n81i
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_dil.text.state_n81i
						</td>
						<td width="8%" class="color_top_1">
							i18n_dil.text.dataCheckTime_n81i
						</td>
						<td width="8%" class="color_top_1" nowrap>
							i18n_dil.text.tryTimes_n81i
						</td>
						<td width="32%" class="color_8">
						<c:choose>
							<c:when test="${flag=='queryAllConfigLevel'||flag=='warning'}">i18n_dil.text.performaceData_n81i</c:when>
							<c:otherwise>i18n_dil.text.stateInfo_n81i</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<c:choose>
						<c:when test="${fn:length(detectionInfoWarningList) > 0}">
							<c:forEach items="${detectionInfoWarningList}"
								var="detectionInfo" varStatus="index">
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										<c:out value="${detectionInfo[0]}" />
									</td>
									<td class="${color }">

										<!--  <a
										href="javascript:showRecord('${detectionInfo[7] }','${detectionInfo[10] }')"
										title="查看详情"> -->
										<c:out value="${detectionInfo[1]}" />
										<!-- </a>  -->
									</td>
									<td class="${color }">
										<c:out value="${detectionInfo[2]}" />
									</td>
									<td class="${color }">
										<c:if test="${fn:trim(detectionInfo[3])=='1'}">
											<img src="<c:url value='/images/yes.gif'/>" border="0"
												align="middle" />
										</c:if>
										<c:if
											test="${fn:trim(detectionInfo[3]) == '0' ||fn:trim(detectionInfo[3]) == '-1'}"
											var="handshakeEr">
											<img src="<c:url value='/images/no.gif'/>" border="0"
												align="middle" />
										</c:if>
									</td>
									<td class="${color }">
										<c:out value="${detectionInfo[4]}" />
									</td>
									<td class="${color }">
										<c:out value="${detectionInfo[5]}" />
									</td>
									<td class="${color_end }">
										<div class="pop-content">
											${fn:replace(fn:replace(detectionInfo[6],vEnter,'$@$'),'$@$','<br/>')}
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="color_6" align="center">
									i18n_dil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty detectionInfoWarningList}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>
	</body>
</html>

