<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.hibernate.lob.SerializableClob"%>
<%@include file="/common/taglib.jsp"%>
<% pageContext.setAttribute("vEvent","\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_mspm1.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
	<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.core.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.widget.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.tabs.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/WebCalendar.js"charset="utf-8'/>"></script>
	<style type="text/css">
		.ui-widget-content {
			border: 0px;
			margin: 0px;
			padding: 0px
		}
		.ui-widget-header {
			border: 1px solid #EBECEB;
			filter: glow(color = EBECEB, strength = 10);
			background: #D9D8D8 url(images/ui-bg_highlight-soft_33_3a8104_1x100.png) 50% 50% repeat-x;
			color: #ffffff;
			font-weight: bold;
		}
	</style>
	<script type="text/javascript">
		$(function() {
			$( "#tabs" ).tabs({
			});
		});
	
		function  uploadfile(fileName){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=misssionInfoDownLoad&missionId="+'${missionstatetable.missionId }'+"&loadfileName="+fileName;
			document.yhForm.submit();				
		}
		function resultChart(id){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=resultChart&missionId="+id;
			document.yhForm.submit();
		}
		function exportXLS(id,result){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=exprotXls&missionId="+id+"&result="+result;
			document.yhForm.submit();
		}
		 //查询记录
		 function callBack(){
	 		document.yhForm.action ="<c:url value='${prevPageUrl}' />";
	 		//document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
			document.yhForm.submit();
		}
		
	function showNodeTitle(showContentSpanId,obj,event) {
		//当前鼠标的坐标          
   	 	var scrollLeft = document.documentElement.scrollLeft;
   	 	var scrollTop = document.documentElement.scrollTop;
   	 	var event = event ? event : window.event;
   	 	var startX = Number(event.clientX)+Number(scrollLeft);
		//span的坐标及宽度
		var instanceDiv = document.getElementById(showContentSpanId);
        var spanX = startX;//span的x坐标
        var spanY = 130;//span的y坐标
       	instanceDiv.style.left=spanX-30+"px";
       	instanceDiv.style.top=spanY-2+"px";
       	instanceDiv.style.zIndex = 1000;
 		var spanHeight = $("#infoTipSpan_missionNode").height();
	    if(spanHeight > 350){
	  	  $("#infoTipSpan_missionNode").height(350)
	    }
		$("#"+showContentSpanId).show();
	}
	
	function hideNodeTitle(showContentSpanId) {
		$("#"+showContentSpanId).hide();
	}
	
	function showTitle(obj,event){
		$(obj).show();
	}
	
	function hideTitle(obj){
		$(obj).hide();
	}
   </script>
	</head>
	<body style="overflow-x: hidden">
	<!--中间部分右边开始-->
	<div class="middle_list">
	<div class="box_1">
		</div>
	<div class="box_2">
		<input type="button" class=btn3_mouseout value="i18n_mspm1.button.back_n81i"
			onmouseover="this.className='btn3_mouseover'"
			onmouseout="this.className='btn3_mouseout'"
			onmousedown="this.className='btn3_mousedown'"
			onmouseup="this.className='btn3_mouseup'"
			onclick="javascript:callBack();"/>&nbsp;&nbsp;
	</div>
	<form action="" name="yhForm" method="post" style="margin-top: 24px">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionName" value="${missionName }" id="missionName"/>
		<input type="hidden" name="loopFlag" value="${loopFlag }" id="loopFlag" />
		<input type="hidden" name="missionState" value="${missionState }" id="missionState" />
		<input type="hidden" name="missionType" value="${missionType }" id="missionType" />
		<jsp:include page="/common/transferHiddenParameter.jsp" />
		
		<table  border="0" cellpadding="0" cellspacing="0" class="table" >
		<tr>
			<td class="color_8" colspan="4"><strong>i18n_mspm1.text.title_n81i</strong></td>
		</tr>
		<tr>
			<td class="td_1" width="10%" nowrap="nowrap">i18n_mspm1.text.missionName_n81i：</td>
			<td class="td_3" width="40%">${missionstatetable.missionName}
			</td>
			<td class="td_1" width="10%" nowrap="nowrap">i18n_mspm1.text.missionType_n81i：</td>
			<td class="td_2" width="40%">
				<c:if test="${missionstatetable.missionType eq 1}">i18n_mspm1.message.missionType1_n81i</c:if> 
				<c:if test="${missionstatetable.missionType eq 2}">i18n_mspm1.message.missionType2_n81i</c:if>
			</td>
		</tr>
		<tr>
			<td class="td_1" nowrap="nowrap">i18n_mspm1.text.systemIdName_n81i：</td>
			<td class="td_3">${missionstatetable.systemIdName}</td>
			<td class="td_1" nowrap="nowrap">i18n_mspm1.text.nodeListName_n81i：	</td>
			<td class="td_2">
				${missionparametertable1.nodeListName}
			</td>
		</tr>
		<tr>
			<td class="td_1" nowrap="nowrap">i18n_mspm1.text.excNode_n81i：</td>
			<td class="td_3" id="tipTd">
						<span id="showSpan" onmouseover="showNodeTitle('infoTipSpan_missionNode',this,event);" onmouseout="hideNodeTitle('infoTipSpan_missionNode');" >
							<script>
							$(function(){
								if('${missionparametertable1.nodeListName2}'!=""){
									var strArr = '${missionparametertable1.nodeListName2}'.split(",");
									if(strArr.length>5){
										var arr = new Array();
										var newStr = "";
										for(var i =0;i<strArr.length;i++){
											newStr = newStr+","+strArr[i];
											if((i+1)%5==0){
												arr.push(newStr);
												newStr="";
											}
											if((i+1)==strArr.length){
												arr.push(newStr);
											}
										}
										//构建table
										var strTable = "<table id='tipTable' style='width:100%'>";
										var strTip="";
										for(var i =0;i<arr.length ;i++){
											strTable += "<tr>";
												var arr2 = arr[i].split(",");
												for(var j=0;j<arr2.length;j++){
													if(arr2[j]!=""){
														strTable +="<td>"+arr2[j]+"</td>";
													}
													if(i==0){
														strTip += ","+arr2[j];
													}
												}
											strTable += "</tr>";
										}
										strTable +="</table>";
										$("#infoTipSpan_missionNode").append(strTable);
										$("#tipTable tr").css({align:"left"});
										$("#showSpan").append(strTip.substring(2)+"...");
									}else{
										$("#tipTd").append('${missionparametertable1.nodeListName2}');
									}
								}
								});
							</script>
							</span>
								<span id="infoTipSpan_missionNode" onmouseover="showTitle(this,event);" onmouseout="hideTitle(this);" class="infoTip" style="display:none;overflow: auto;width: 480px"></span>
						</td>
			<td class="td_1" nowrap="nowrap">i18n_mspm1.text.fileName_n81i：</td>
			<td class="td_2" >
				<c:forEach items="${filesList }" var="file">
				<a href="javascript:uploadfile('${file.fileName}');">${file.fileName}</a><br/>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="td_1" nowrap="nowrap">i18n_mspm1.text.viewLevel_n81i：</td>
			<td class="td_3">
				<c:if test="${missionstatetable.viewLevel eq 1}">i18n_mspm1.message.publisher_n81i</c:if>
				<c:if test="${missionstatetable.viewLevel eq 2}">i18n_mspm1.message.publisherGroup_n81i</c:if>
				<c:if test="${missionstatetable.viewLevel eq 3}">i18n_mspm1.message.allInSys_n81i</c:if>
				<c:if test="${missionstatetable.viewLevel eq 4}">i18n_emvl.message.unlimited_n81i</c:if>
			</td>
			<c:if test="${missionstatetable.viewLevel eq 2}">
				<td class="td_1" nowrap="nowrap">
					i18n_mspm1.text.groupIdName_n81i：
				</td>
				<td class="td_2">
					${missionstatetable.groupIdName }
					
				</td>
			</c:if>
			<c:if test="${missionstatetable.viewLevel ne 2}">
				<td class="td_1" nowrap="nowrap"> i18n_mspm1.text.addUser_n81i： </td>
				<td class="td_2" > 
					${missionstatetable.userIdName}
				</td>
			</c:if>
		</tr>
		<tr>
			<td class="td_1"  width="8%">i18n_mspm1.text.contentParam_n81i：</td>
			<td class="td_3" colspan="3" valign="top" width="42%">
				<div><jsp:include page="/page/system/nmstaskmanager/detail/missionCmdPara1.jsp" /></div>
			</td>
		</tr>
		<tr>
			<td class="td_1"width="8%" nowrap="nowrap">i18n_mspm1.text.missionDesc_n81i：</td>
			<td class="td_2" colspan="3"width="42%">
			${fn:replace(missionparametertable1.missionDesc,vEvent,'<br />') }
			</td>
		</tr>
		<c:if test="${missionstatetable.autoDesc ne null}">
			<tr>
				<td class="td_1" nowrap="nowrap">
					i18n_mspm1.text.runningDesc_n81i：
				</td>
				<td class="td_2" colspan="3" >
				${fn:replace(missionstatetable.autoDesc,vEvent,'<br />') }
				</td>
			</tr>
		</c:if>
			<tr>
				<td colspan="4" class="color_1" style="text-align: right;">
				</td>
			</tr>
			</table>
		</form>
		</div>
	</body>
</html>