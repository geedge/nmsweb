<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<% pageContext.setAttribute("vEvent","\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_mrs.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
	<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.core.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.widget.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/ui/jquery.ui.tabs.js'/>"></script>
	<script type="text/javascript"src="<c:url value='/js/WebCalendar.js"charset="utf-8'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/highcharts.js'/>"></script>
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
		var tabs=${tabs}+"0";  var tabnum;
		$(function() {
			$( "#tabs" ).tabs({
			});
			$( "#tabs" ).find("a").click(function(){
				//alert($(this).attr("href"));
				tabnum = $(this).attr('href');
				var $div = $($(this).attr("href"));
				if($div.find("iframe").size()!=0){
					return ;
				}
				//if($(this).attr("href")=='#tabs-3'){
				//	$div.append("<iframe name='I1' width='100%' height='0px' marginheight='0' marginwidth='0' frameborder='0' scrolling='no'"
				//			+"src='nmsTaskManager!executeAction.do?action="+$(this).attr("pro")+"&type="+$(this).attr("tag")+"&missionId=${missionstatetable.missionId}'"
				//			+">浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe>");
				//}else{
					$div.append("<iframe name='I1' width='100%' height='380px' marginheight='0' marginwidth='0' frameborder='0' scrolling='no'"
							+"src='nmsTaskManager!executeAction.do?action="+$(this).attr("pro")+"&type="+$(this).attr("tag")+"&missionId=${missionstatetable.missionId}&mypageNo=${mypageNo}&mypageSize=${mypageSize}&missionName=${missionName}&loopFlag=${loopFlag}&missionState=${missionState}&missionType=${missionType}&dataStart=${dataStart}&dataEnd=${dataEnd}&dataRange=${dataRange}'"
							+">i18n_mrs.message.brower_n81i</iframe>");
							
				//}
				
			});
			if(tabs>0){
				$( "#tabs" ).find("a:eq("+(tabs/10-1)+")").trigger('click');
			}else{
				$( "#tabs" ).find("a:eq(0)").trigger('click');
			}
			
		});
		
		function exportXLS(id,result){
			tabnum = tabnum.substring(tabnum.length-1, tabnum.length);
			document.yhForm.action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=exprotXls&missionId="+id+"&result="+result + '&tabs=' + tabnum;
			document.yhForm.submit();
		}
		//返回任务列表
		function callBack(){
			document.yhForm.action ="<c:url value='${prevPageUrl}' />";
			//document.yhForm.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
			document.yhForm.submit();
		}
   </script>
	</head>
	<body style="overflow: hidden">
	<!--中间部分右边开始-->
	<div class="middle_list">
	<div class="box_1">
	<!-- 
		<img src="<c:url value='/'/>/images/sanjiao.png" class="img_middle" />&nbsp;你现在所在的位置是：命令执行-任务结果查看
	 -->
		</div>
	<div class="box_2">
		<input type="button" class=btn3_mouseout value="i18n_mrs.button.exportXls_n81i"
			onmouseover="this.className='btn3_mouseover'"
			onmouseout="this.className='btn3_mouseout'"
			onmousedown="this.className='btn3_mousedown'"
			onmouseup="this.className='btn3_mouseup'"
			onclick="exportXLS(${missionstatetable.missionId },1)"/>
			&nbsp;
		<input type="button" class=btn3_mouseout value="i18n_mrs.button.back_n81i"
			onmouseover="this.className='btn3_mouseover'"
			onmouseout="this.className='btn3_mouseout'"
			onmousedown="this.className='btn3_mousedown'"
			onmouseup="this.className='btn3_mouseup'"
			onclick="javascript:callBack();"/>&nbsp;&nbsp;
	 </div>
	<form action="" name="yhForm" method="post" style="margin-top: 26px">
		<input type="hidden" name="position" value="${position }" />
		<input type="hidden" name="missionName" value="${missionName }" id="missionName"/>
		<input type="hidden" name="loopFlag" value="${loopFlag }" id="loopFlag" />
		<input type="hidden" name="missionState" value="${missionState }" id="missionState" />
		<input type="hidden" name="missionType" value="${missionType }" id="missionType" />
		<input type="hidden" name="from" value="${from }" />
		<input type="hidden" name="mypageNo" value="${mypageNo}" /><!-- 列表当前页数 -->
		<input type="hidden" name="mypageSize" value="${mypageSize}" /><!-- 列表当前页数 -->
		<table   cellpadding="0" cellspacing="0" class="table" border="0" align="left">
		<tr>
			<td class="color_8" colspan="5"><strong>
				<c:if test="${missionstatetable.missionType eq 1}">i18n_mrs.message.filePush_n81i</c:if>
				<c:if test="${missionstatetable.missionType eq 2}">i18n_mrs.message.getNonStream_n81i</c:if>
				<c:if test="${missionstatetable.missionType eq 3}">i18n_mrs.message.getStream_n81i</c:if>
				<c:if test="${missionstatetable.missionType eq 4}">i18n_mrs.message.commandExec_n81i</c:if>
				<c:if test="${missionstatetable.missionType eq 5}">i18n_mrs.message.shellRegist_n81i</c:if>
				<c:if test="${missionstatetable.missionType eq 6}">i18n_mrs.message.upgradeDeployment_n81i</c:if>
				-
				<c:if test="${missionstatetable.loopFlag eq 1}">i18n_mrs.text.loopFlag_n81i - </c:if>
				${missionstatetable.missionName}
				-
				i18n_mrs.text.resultView_n81i</strong></td>
		</tr>
		<tr>
			<td class="td_3" width="100%" valign="top">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1" pro="resultChart" tag ='pie' ><strong>i18n_mrs.text.pie_n81i</strong></a></li>
						<c:if test="${missionstatetable.loopFlag==1}">
							<li><a href="#tabs-2" pro="resultChart" tag ='line' ><strong>i18n_mrs.text.line_n81i</strong></a></li>
							<!-- 
							<li><a href="#tabs-3" pro="resultChart" tag ='column' ><strong>i18n_mrs.text.column_n81i</strong></a></li>
							 -->
							<li><a href="#tabs-3" pro="statisticList" tag ='data' ><strong>i18n_mrs.text.data_n81i</strong></a></li>
							<!-- 
							 -->
						</c:if>
					</ul>
					<div id="tabs-1" style="background-color: #EBECEB;padding: 0px 0px;" >
					</div>
					<c:if test="${missionstatetable.loopFlag==1}">
						<div id="tabs-2" align="center" style="background-color: #EBECEB;padding: 0px 0px;">
						</div>
						<!-- 
						<div id="tabs-3" align="center" style="background-color: #EBECEB;padding: 0px 0px;">
						</div>
						 -->
						<div id="tabs-3" align="center" style="background-color: #EBECEB;padding: 0px 0px;">
						</div>
					</c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="color_1" style="text-align: right;">
				<!-- 
				<button
					style="border-style: none; background-color: transparent; background-image: url(< c : url value = '/desktop/images/anniu/button${userBgColor }.png'/ >); vertical-align: middle;"
					onmouseover="this.className='hover';"
					onmouseout="this.className='normal';"
					onclick="javascript:resultChart(${missionstatetable.missionId})">
					结果图
				</button>
				<input type="button" class=btn3_mouseout value="失败结果导出"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="exportXLS(${missionstatetable.missionId },1)"/>
					&nbsp;
				<input type="button" class=btn3_mouseout value="返回"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="javascript:callBack();"/>&nbsp;&nbsp;
				 -->
			</td>
		</tr>
		</table>
	</form>
	</div>
	</body>
</html>