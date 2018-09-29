<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_mrsl.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
	<script language="javascript" type="text/javascript">	
		$(document).ready(function(){
		//	setTimeout(function(){
				var thisHeight = parent.document.body.scrollHeight-100;
				var pw = window.parent;
				if(pw){
					var $thisIframe = $("iframe[name='"+window.frameElement.name+"']:last",pw.document);
					if($thisIframe.parent().css('height')!=(thisHeight+'px')){
						$thisIframe.parent().css('height',thisHeight+'px');
					}
					if($thisIframe.css('height')!=(thisHeight+'px')){
						$thisIframe.css('height',thisHeight+"px");
					}
					pw.document.body.scroll = 'auto';
				}
		//	},1000);
			$("#info").floatHeaderDiv();
		});
	//查询记录
	function qry(){
 		//document.form3.action ="<c:url value='/nmstaskManager/nmsTaskManager.do?action=query' />";
		document.form3.submit();
	}
	//查询记录
	 function searchResults(missionId,roundId){
		window.parent.document.forms[0].action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults&missionId="+missionId+"&curMissionId="+roundId+"&tabs=3";
		window.parent.document.forms[0].submit();
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
		var dhh = dh-40+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-60){
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
			if(ieBrowser()){
				$("#info").attr("style","width:100%;");
			}else{
				$("#info").attr("style","width:98.5%;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
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
		    var rowN = Number($("input[type=checkbox]:last").next().val())+1;
		    var url2="<c:url value='nmsTaskManager.do?action=statisticListChild'/>&pageNo="+(++pagePoint)+"&pageSize="+'${pageSize }';
		    var urlTmp = encodeURI(url2);
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
				data:$("#frmArticleType").serialize(),
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
	 
	 
    </script>
</head>
	<body class="bc">
<!--中间部分右边开始-->
<div class="middle_list">
<div class="box_2">
</div>
<form name=form3 id="frmArticleType" action="<c:url value='nmsTaskManager.do?action=statisticList'/>" method="post">
	<input type="hidden" name="position" value="${position }" />
<div class="box_1"> 
<label class="divTopText"><font class="selectText">i18n_mrsl.text.loopInterval_n81i</font>: 
<input type="hidden" name="missionId" value="${missionstatetable.missionId}"/>
<input name="startTimeStr" id="startTimeStr" type="text" value="<fmt:formatDate type="both" value="${startTimeStr }" />"
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)"/></label><label class="divTopText"><font class="selectText"> i18n_mrsl.text.to_n81i</font> 
<input name="endTimeStr" id="endTimeStr" type="text" value="<fmt:formatDate type="both" value="${endTimeStr }" />"
								onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss',${session.i18n_lang == 'zh_CN'?0:1},0,0)"/></label>
<img src="<c:url value='/images/button_chaxun.png'/>" class="img_middle" onclick="javascript:qry();"  />
</div>
<div id="maindiv" style="clear: both">
<table border="0" cellpadding="0" cellspacing="0" class="table" width="100%" id="info">
	<tr>
		<td class="color_top_1">i18n_mrsl.text.cycle_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.loopInterval_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.successNum_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.filedNum_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.downNum_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.upNum_n81i</td>
		<td class="color_top_1">i18n_mrsl.text.totalNum_n81i</td>
	</tr>
	<c:set var="index" value="${page.totalCount - (pageNo-1)*page.pageSize}" />
	<c:choose>
	<c:when test="${fn:length(loopInfolist)>0}">
		<c:forEach items="${loopInfolist }" var="objs" >
			<c:if test="${index%2 eq 1}">
				<c:set var="tdClass" value="color_1" />
				<c:set var="tdClassR" value="color_7" />
			</c:if>
			<c:if test="${index%2 eq 0}">
				<c:set var="tdClass" value="color_3" />
				<c:set var="tdClassR" value="color_6" />
			</c:if>
			<tr>
				<td class="${tdClass }"><a href="javaScript:searchResults(${objs[0] },${objs[1] })">i18n_mrsl.text.searchResults_n81i${index }i18n_mrsl.text.searchResults.cycle_n81i</a></td>
				<td class="${tdClass }"><a href="javaScript:searchResults(${objs[0] },${objs[1] })">${objs[2] }&nbsp;-&nbsp;${objs[3] }</a>
				</td>
				<td class="${tdClass }">${objs[6] }</td>
				<td class="${tdClass }">${objs[7] }</td>
				<td class="${tdClass }">${objs[8] }</td>
				<td class="${tdClass }">${objs[9] }</td>
				<td class="${tdClassR }">${objs[10] }</td>
			</tr>
			<c:set var="index" value="${index-1}" />
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td class="td_2" colspan="7" style="text-align: center">i18n_mrsl.text.noResult_n81i</td>
		</tr>
	</c:otherwise>
	</c:choose>
</table>
</div>
<c:if test="${!empty loopInfolist}">
	<jsp:include page="/common/page.jsp" />
</c:if>
<!--中间部分右边结束-->	
</form>
</div>
<br />
</body>
</html>