<%@page import="nis.nms.util.Constant"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.hibernate.lob.SerializableClob"%>
<%@include file="/common/taglib.jsp"%>
<% 
pageContext.setAttribute("vEvent","\n");
response.setHeader("Cache-Control","max-age=0");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_mrl.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
	<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.core.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.widget.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.tabs.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/WebCalendar.js"charset="utf-8'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/highcharts.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/lockTableHeader.js'/>"></script>
	<style type="text/css">
		.ui-widget-content {
			border: 0px;
			margin: 0px;
			padding: 0px
		}
		.ui-widget-header {
			border: 1px solid #D9D8D8;
			filter: glow(color = red, strength = 10);
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
		
		/*结果判定失败操作*/
		function judgmentFails(id){
			if(countChecked("ids")==0 && countChecked("curid_ids")==0 ){
				alert("i18n_mrl.message.judgmentFails_n81i");
				return null;
			}
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=judgmentFails&missionId="+id;
			document.yhForm.submit();
		}
		/*失败节点再次升级*/
		function updateFailedNodes(id){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=upgradeFailedNodes&missionId="+id+"&result="+'${result}';
			document.yhForm.submit();
		}
		/*导出操作
			未选中节点导出全部
			存在选中节点导出选中节点
		*/
		function exportXLS(id){
			var curMissionId = $("input[name=curMissionId]").val();
			if(curMissionId!=""){
				document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=exprotXls&missionId="+id+"&curMissionId="+curMissionId;
			}else{
				document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=exprotXls&missionId="+id;
			}
			document.yhForm.submit();
			document.yhForm.action="<c:url value='nmsTaskManager.do?action=searchResults'/>";
		}
		/*下载文件*/
		function uploadfile(fileName){
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=download&loadfileName="+fileName;
			document.yhForm.submit();				
		}
		/*查询操作*/
		function  qry(){
			var result = $("select[name=result]").val();
			$("input[type=hidden][name=result]").val(result);
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
			document.yhForm.submit();				
		}
		/*返回操作*/
		function  callBack(missionId){
			document.location.href ="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=statistic&missionId="+missionId+"&tabs=${tabs}&mypageNo=${mypageNo}&mypageSize=${mypageSize}&missionName=${missionName}&loopFlag=${loopFlag}&missionState=${missionState}&missionType=${missionType}&dataStart=${dataStart}&dataEnd=${dataEnd}&dataRange=${dataRange}";
			//document.yhForm.submit();				
		}
		/*创建逆向任务校验操作*/
		function reverseNodes(id,type){
			$.post("<c:url value='/'/>nmstaskManager/nmsTaskManager.do?action=queryMissInfoForConverse",{missId:id},function(datas){checkCoverseMiss(datas,id,type);},"json");//根据任务Id从后台获得任务的相关信息，判断是否符合逆向任务的条件
			
		}
		
	 /*逆向任务校验回调函数*/
	 //检查选中的任务是否符合逆向任务的条件：是否升级部署+非逆向任务+是否任务完成+是否有备份（从大到小判断，先任务类型，再完成，再备份）	
	 function checkCoverseMiss(datas,id,type) {
	    if(datas!=null){
	    	if(datas.canConverse=="false") {//任务不可逆向
		    	if(datas.isUpdate=="false") {
	                alert("i18n_mrl.message.isUpdate_n81i");
	                return;
	 	        }
		    	if(datas.isConverse=="true") {
	                alert("i18n_mrl.message.isConverse_n81i");
	                return;
	 	        }
		        if(datas.finished=="false") {
		        	alert("i18n_mrl.message.finished_n81i");
		        	return;
		        }
		        if(datas.haveBackUp=="false") {
		        	alert("i18n_mrl.message.haveBackUp_n81i");
		        	return;
		        }
		    } else {
		        document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=reverseNodesAgain&reverseType="+type+"&missionId="+id+"&result="+'${result}';
		    	document.yhForm.submit();
		    }
	    }
	 }
	 
	function lianxiangIpNodekeyup() {
		var ipStr = $('#ipNode').val();
		if(checkStrNoDian(ipStr)) {
			alert('i18n_mrl.message.hasSpecialChar_n81i');
			$('#ipNode').val('');
			return;
		}
		setTimeout(function(){
			jQuery.post(
				"<%=request.getContextPath()%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
				{'ajaxProperties':'nodeIp', 'ajaxTableName': 'NodeTable',
				 'ajaxType':'String', 'nodeType':0, 'ajaxValue': ipStr
				},
				function(data) {
					var lianxiangList = data.split(",");
					$('#ipNode').suggest(lianxiangList,{hot_list:lianxiangList,attachObject:'#suggest1'});
				}
			);
		},500);
	}
	 
	function downloadfile(fileName){
			document.yhForm.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.yhForm.submit();				
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
	$(function(){
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
		    var rowN = Number($("input[type=checkbox]:last").next().val())+1;
		    var url2="<c:url value='nmsTaskManager.do?action=searchResultsChild'/>&pageNo="+(++pagePoint)+"&pageSize="+'${pageSize }'+"&rowN="+rowN;
		    var urlTmp = encodeURI(url2);
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
				data:$("#yhForm").serialize(),
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
	 
   function batchDownLoadFile(missionName){
	    if($("#info input[type=checkbox]:checked").length>0){
	    	var arr = new Array();
	    	$("#info input[type=checkbox]:checked").each(function(index,item){
	    		var fileName = $(item).parent().parent().find("td:last").find("a").html();
	    		if(fileName!=""&&fileName!=undefined){
		    		arr.push(fileName);
	    		}
	    	});
	    	if(arr.length>0){
	    		var fileNames = arr.join(",");
	    		document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=batchDownLoadFile&names="+fileNames+"&missionName="+missionName;
			    document.yhForm.submit();
		        document.yhForm.action="<c:url value='nmsTaskManager.do?action=searchResults'/>";	
	    	}else{
	    		alert("i18n_mrl.message.batchDownLoadFile_n81i");
	    	}
	    }else{
	    	alert("i18n_mrl.message.selectOne_n81i");
	    }
   }
   </script>
	</head>
	<body>
	<!--中间部分右边开始-->
	<div class="middle_list">
	<form action="<c:url value='nmsTaskManager.do?action=searchResults'/>" method="post" name="yhForm" id="yhForm">
	<div class="box_1">
	<input type="hidden" name="missionName" value="${missionName }" />
	<input type="hidden" name="loopFlag" value="${loopFlag }" />
	<input type="hidden" name="missionState" value="${missionState }" />
	<input type="hidden" name="missionType" value="${missionType }" />
	<input type="hidden" name="mypageNo" value="${mypageNo }" />
	<input type="hidden" name="mypageSize" value="${mypageSize }" />
	<input type="hidden" name="position" value="${position }" />
	<input type="hidden" name="tabs" value="${tabs }" />
	<input type="hidden" name="result" value="${result }" />
	<input type="hidden" name="curMissionId" value="${curMissionId }" />
	<input type="hidden" id="dataStart" name="dataStart" value="${dataStart}"/>
    <input type="hidden" id="dataEnd" name="dataEnd" value="${dataEnd}"/>
    <input type="hidden" id="dataRange" name="dataRange" value="${dataRange}"/>
	&nbsp;i18n_mrl.text.missionType_n81i : <B>
					<c:if test="${missionstatetable.missionType eq 1}">i18n_mrl.message.missionType1_n81i</c:if>
					<c:if test="${missionstatetable.missionType eq 4}">i18n_mrl.message.missionType4_n81i</c:if>
					<c:if test="${missionstatetable.missionType eq 6}">i18n_mrl.message.missionType6_n81i</c:if>
				   </B>
	&nbsp;i18n_mrl.text.missionName_n81i: <input type="hidden" name="missionId" value="${missionstatetable.missionId}"/><B>${missionstatetable.missionName}</B>
	<c:if test="${loopmissionStateTable ne null}"> i18n_mrl.text.cycle_n81i：<B>
	<fmt:formatDate value="${loopmissionStateTable.startTime }" type="both"  />
	 - 
	 <fmt:formatDate value="${loopmissionStateTable.endTime }" type="both"  /></B>
	</c:if>
	
	&nbsp;i18n_mrl.text.result_n81i : <select name="result" >
						<option value="" selected="selected">i18n_mrl.message.resultStateDefault_n81i</option>
						<option value="3" ${result eq "3"?"selected":""}>i18n_mrl.message.underDelivery_n81i</option>
						<option value="40" ${result eq "40"?"selected":""}>i18n_mrl.message.deliveredSuccess_n81i</option>
						<option value="50" ${result eq "50"?"selected":""}>i18n_mrl.message.processStop_n81i</option>
						<option value="60" ${result eq "60"?"selected":""}>i18n_mrl.message.fileBackup_n81i</option>
						<option value="70" ${result eq "70"?"selected":""}>i18n_mrl.message.fileUpdate_n81i</option>
						<option value="80" ${result eq "80"?"selected":""}>i18n_mrl.message.commandSuccess_n81i</option>
						<option value="81" ${result eq "81"?"selected":""}>i18n_mrl.message.commandFailed_n81i</option>
						<c:if test="${missionstatetable.loopFlag ne 0}">
						<option value="5" ${result eq "5"?"selected":""}>i18n_mrl.message.withDraw_n81i</option>
						<option value="6" ${result eq "6"?"selected":""}>i18n_mrl.message.undo_n81i</option>
						<option value="7" ${result eq "7"?"selected":""}>i18n_mrl.message.undoComplete_n81i</option>
						</c:if>
						<option value="0" ${result eq "0"?"selected":""}>i18n_mrl.message.success_n81i</option>
						<option value="1" ${result eq "1"?"selected":""}>i18n_mrl.message.failed_n81i</option>
					</select>
		i18n_mrl.text.ipNode_n81i: <input type="text" id="ipNode" name="ip" title="i18n_mrl.message.ipNode_n81i" value="${ip}" size="15" onkeyup="lianxiangIpNodekeyup();"/>
		<div id='suggest1' class="ac_results"></div>
		<img src="<c:url value='/images/button_chaxun.png'/>" class="img_middle" onclick="javascript:qry();"  />
				
	</div>
	<div class="box_2">
				<%-- <input type="button" class=btn3_mouseout value="i18n_mrl.button.judgmentFails_n81i"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="judgmentFails(${missionstatetable.missionId })"/> --%>
					&nbsp;
					
					<input type="button" class=btn3_mouseout value="i18n_mrl.button.updateFailedNodes_n81i"
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="updateFailedNodes(${missionstatetable.missionId })"/>
						&nbsp;
						<!-- 
						 -->
					<c:if test="${missionstatetable.missionType eq 6}">
						<input type="button" class=btn3_mouseout value="i18n_mrl.button.reverseSuccessNodes_n81i"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="reverseNodes(${missionstatetable.missionId },0)"/>
							&nbsp;
						<input type="button" class=btn3_mouseout value="i18n_mrl.button.reverseFaildNodes_n81i"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="reverseNodes(${missionstatetable.missionId },1)"/>
							&nbsp;
						<input type="button" class=btn3_mouseout value="i18n_mrl.button.reverseAllNodes_n81i"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="reverseNodes(${missionstatetable.missionId },-1)"/>
							&nbsp;
					</c:if>
						
					<input type="button" class=btn3_mouseout value="i18n_mrl.button.exportXLS_n81i"
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="exportXLS(${missionstatetable.missionId })"/>
						&nbsp;
					<c:if test="${missionstatetable.missionType eq 4}">
					    <c:if test="${missionparameteriable4.commandEName=='upgrade_start' || missionparameteriable4.commandEName=='upgrade_exec' || missionparameteriable4.commandEName=='single_exec'}">
							<input type="button" class=btn3_mouseout value="i18n_mrl.button.batchDownLoadFile_n81i"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="batchDownLoadFile('${missionstatetable.missionName}')"/>
						&nbsp;
						</c:if>
					</c:if>
					<input type="button" class=btn3_mouseout value="i18n_mrl.button.back_n81i"
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:callBack(${missionstatetable.missionId});"/>&nbsp;&nbsp;
	</div>
		<div id="maindiv">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table" id="info">
			<tr>
				<td width="5%" class="color_top">
				<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />
				</td>
				<td width="10%" class="color_top">i18n_mrl.text.missionName_n81i</td>
				<td width="10%" class="color_top">i18n_mrl.text.nodeIp_n81i</td>
				<td width="10%" class="color_top" nowrap="nowrap">i18n_mrl.text.returnResult_n81i</td>
				<td width="30%" class="color_top">i18n_mrl.text.resultCause_n81i</td>
				<c:if test="${missionstatetable.missionType eq 4}">
				    <c:if test="${missionparameteriable4.commandEName=='upgrade_start' || missionparameteriable4.commandEName=='upgrade_exec' || missionparameteriable4.commandEName=='single_exec'}">
							<td width="10%" class="color_8">i18n_mrl.text.backFile_n81i</td>
					</c:if>
				</c:if>
			</tr>
			<!-- 1、远程连接引入页面 -->
			<jsp:include page="/common/remoteConn.jsp" />
			<c:set var="rowN" value="${(pageNo-1)*page.pageSize+ 1}" />
			<%
				List resultList =(List) request.getAttribute("resultObjects");
				if(resultList!=null){
					//System.out.println(resultList==null?-1:resultList.size());
					Iterator ite = resultList.iterator();
					for(;ite.hasNext();){
						Object[] result =(Object[])ite.next();
						String desc = null;
						if(Constant.IS_MYSQL){
							desc = (String)(result[3]);
						}else{
							SerializableClob clob = (SerializableClob)(result[3]);
							desc = (clob==null || clob.length()==0)?"":clob.getSubString(1,Integer.parseInt(clob.length()+""));
						}
						pageContext.setAttribute("result",result);
						pageContext.setAttribute("desc",desc);
			 %>
				<c:if test="${rowN % 2 eq 1}"><c:set var="color" value="color_1" /></c:if>
				<c:if test="${rowN % 2 eq 0}"><c:set var="color" value="color_3" /></c:if>
			<tr>
			
				<td class="${color }" >
				<!--周期任务-->
				<c:if test="${missionstatetable.loopFlag eq 1}">
					<input type="checkbox" id="ids" name="curid_ids"  value="${result[8]}_${result[6]}" />${rowN }
					<input type="hidden" value="${rowN }">
				</c:if>
				<!--非周期任务-->
				<c:if test="${missionstatetable.loopFlag ne 1}">
					<input type="checkbox" id="ids" name="ids" value="${result[6]}" />${rowN }
					<input type="hidden" value="${rowN }">
				</c:if>
				</td>
				<td class="${color }">${result[0]}</td>
				<td class="${color }">
					<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
					<a href="javascript:void(0);"
					   onclick="remoteConn('${result[4] }','${result[1]}','${result[5] }', this)">
					   ${result[1]}
					</a>
				</td>
				<td class="${color }">
					<c:if test="${result[2] eq 3}">i18n_mrl.message.underDelivery_n81i</c:if>
					<c:if test="${result[2] eq 40}">i18n_mrl.message.deliveredSuccess_n81i</c:if>
					<c:if test="${result[2] eq 50}">i18n_mrl.message.processStop_n81i</c:if>
					<c:if test="${result[2] eq 60}">i18n_mrl.message.fileBackup_n81i</c:if>
					<c:if test="${result[2] eq 70}">i18n_mrl.message.fileUpdate_n81i</c:if>
					<c:if test="${result[2] eq 80}">i18n_mrl.message.commandSuccess_n81i</c:if>
					<c:if test="${result[2] eq 81}">i18n_mrl.message.commandFailed_n81i</c:if>
					<c:if test="${result[2] eq 0}">i18n_mrl.message.success_n81i</c:if>
					<c:if test="${result[2] eq 1}">i18n_mrl.message.failed_n81i</c:if>
					<c:if test="${result[2] eq 5}">i18n_mrl.message.withDraw_n81i</c:if>
					<c:if test="${result[2] eq 6}">i18n_mrl.message.undo_n81i</c:if>
					<c:if test="${result[2] eq 7}">i18n_mrl.message.undoComplete_n81i</c:if>
					<c:if test="${result[2] eq -1}">i18n_mrl.message.decisionFailed_n81i</c:if>
				</td>
				<td class="${color }">
				<textarea cols="50" rows="4" readonly="readonly">${desc }</textarea>
				</td>
				<c:if test="${missionstatetable.missionType eq 4}">
				    <c:if test="${missionparameteriable4.commandEName=='upgrade_start' || missionparameteriable4.commandEName=='upgrade_exec' || missionparameteriable4.commandEName=='single_exec'}">
						<td class="${color }" width="200px">
						<c:forEach items="${fn:split(result[7],'@@@')}" var="result0" >
							<a href="javascript:uploadfile('${result0}')">${result0}</a><br />
						</c:forEach>
						</td>
					</c:if>
				</c:if>
			</tr>
			<c:set var="rowN" value="${rowN+1}" />
		<%}} %>
		</table>
		</div>
</form>
		<jsp:include page="/common/page.jsp" />
		<!--中间部分右边结束-->	
		</div>
		<div id="aa"></div>
	</body>
</html>