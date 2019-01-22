<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_sitl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
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
	_top: expression(eval(document .                                        
		    compatMode &&      
		
		   
		           
				                                   document .     
		                            
		          compatMode ==            
		  
		          
		                  'CSS1Compat') ?                   
		   
				                                   documentElement .       
		                        
		            scrollTop +              
		  
		                             (                  
		     
		                    document .                      
		                      documentElement . 
		                                
		          clientHeight-this .           
		  
		            
		                 offsetHeight )/ 2 :                       
		                     /*IE6*/                       
				                                   document .      
		                             
		        body .          
		  
		              
		                scrollTop +                  
		                            (                   
		    
		                    document .                       
		                     body .                      
		                      clientHeight -   
		                                     
		     this .       
		   
		                 
		               clientHeight )/ 2 );
	/*IE5 IE5.5*/
}

.bg {
	background-color: #ccc;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0; /*FF IE7*/
	filter: alpha(opacity =                                             50);
	/*IE*/
	opacity: 0.5; /*FF*/
	z-index: 1;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document .                                        
		    compatMode &&      
		
		   
		           
				                                   document .     
		                            
		          compatMode ==            
		  
		          
		                  'CSS1Compat') ?                   
		   
				                                   documentElement .       
		                        
		            scrollTop +              
		  
		                             (                  
		     
		                    document .                      
		                      documentElement . 
		                                
		          clientHeight-this .           
		  
		            
		                 offsetHeight )/ 2 :                       
		                     /*IE6*/                       
				                                   document .      
		                             
		        body .          
		  
		              
		                scrollTop +                  
		                            (                   
		    
		                    document .                       
		                     body .                      
		                      clientHeight -   
		                                     
		     this .       
		   
		                 
		               clientHeight )/ 2 );
	/*IE5 IE5.5*/
}
/*The END*/
</style>
	</head>

	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_sitl.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_sitl.message.faild_n81i");
	  }	  
	 
	 function goBack(){
		document.form3.action ="<%=path%>/detection/checkTypeSet.do?action=query";
		document.form3.submit();
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
		document.form3.action = "<c:url value='/'/>/detection/switchDetection.do?action=emportCurrentXls&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }';
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/switchDetection.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/switchDetection.do?action=emportAllXls";
		document.form3.submit();
		closeDiv();
		document.form3.action ="<%=path%>/detection/switchDetection.do?action=query";
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
		
		$("#info").floatHeaderDiv();
	});
	
	function showGrap(detectId,seqId,ip) {
		//检查是否支持SVG图形
		if(!isSVG()) {
			svgDownloadConn();	
		}else {
			var url = "<%=path%>/detection/switchDetection.do?action=switchDetectInfoGraph&pid=0&detectId="+detectId+"&seqId="+seqId+"&ip="+ip;
			document.form3.action=url;
			document.form3.submit();
		}
	}
	
	function showList(detectId,seqId,checkDate,networElementType){
		var url ="<c:url value='/detection/switchDetection.do?action=singleSwitchInfo&detectId= "+detectId+"&seqId="+seqId+"&checkDate="+checkDate+"&networElementType="+networElementType+"' />";
		
		if(networElementType == ''){
			var url ="<c:url value='/detection/switchDetection.do?action=singleSwitchInfo&detectId= "+detectId+"&seqId="+seqId+"&checkDate="+checkDate+"' />";
		}
		document.form3.action=url;
		document.form3.submit();
	}
	
	//检查是否支持SVG图形
	function isSVG() {
		if(window.ActiveXObject && navigator.userAgent.indexOf("MSIE 9.0")<=0) {//说明是IE浏览器,navigator.userAgent:ie8设置兼容模式时，navigator.userAgent的值为MSIE 7.0
			try {
			    var sctXObj = new ActiveXObject("ADOBE.SVGCtl");//new ActiveXObject("ADOBE.SVGCtl")会产生异常，需要捕捉
				return true;
			}catch(e) {
				return false;
			}
		}else {//非IE浏览器（火狐等，直接支持svg，无需安装插件）
			return true;
		}
	}

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
		
		$.get("<c:url value='switchDetection.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint), function(data){//利用jquery的get方法得到table.html内容
		    memoryData = data;
		    flashFlag = true;
		});

		intervalID = setInterval(function(){cando();},1000);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
		function cando(){
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
		    	//$("#info").append($(memoryData));//用append方法追加内容到mypage元素。
		    	$("#currentPage").html(pagePoint);
		    	$("#pageNo").val(pagePoint);
		    	flag2 = false;
			    }catch(err){
				    
				}
		    }
		    
			$.get("<c:url value='switchDetection.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint), function(data){//利用jquery的get方法得到table.html内容
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
	
	
	 //查询记录
	 function qry(){
		document.form3.action = "<c:url value='/detection/switchDetection.do?action=query'/>";
		document.form3.submit();		
	}
	
	//---------------主机名联想查询 begin-------------
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
				clearTimeout(set_Id);
				alert('i18n_sitl.message.inputInfo_n81i');
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
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue,"nodeType":1},function(data)
		{
			var lianxiangList = data.split(",");
			jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv,showType:"scroll"});
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
		});
	}
	//---------------主机名联想查询 end-------------
    </script>

	<body>
		<div class="middle_list" style="overflow: hidden;">
			<form name=form3 id="frmArticleType"
				action="<c:url value='/detection/switchDetection.do?action=query'/>"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="typeids" value="${typeids[0]}" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
				<!-- 来源于拓扑图 begin -->
				<input type="hidden" name="requestType" value="${requestType }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<!-- 来源于拓扑图 end -->			
				<div id="divTop">
					<div class="box_1">	
						<label class="divTopText"><font class="selectText">i18n_sitl.text.nodeIp_n81i</font> <input  type="text" id="nodeIp"
								onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
								name="nodeIp" title="i18n_sitl.message.nodeIp_n81i" value="${nodeIp}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<%-- <label class="divTopText"><font class="selectText">i18n_sitl.text.networElementType_n81i</font>
						<select name="networElementType"  id="networElementType" style="width:140px;" >
							<option value="">i18n_sitl.message.selectDefault_n81i</option>
							<c:forEach items="${optionList}"  var="optionTable" >
								<option value="${optionTable.typeCode}" <c:if test="${optionTable.typeCode == networElementType}">selected="selected"</c:if>>
									${optionTable.typeValue}
								</option>
							</c:forEach>
						</select>	</label>	 --%>		
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>
					<div class="box_2">
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:showDiv();" value="i18n_sitl.button.export_n81i" />
					</div>
					<br />
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table"
						id="info">
						<tr>
							<td width="6%" class="color_top">
								i18n_sitl.text.netType_n81i
							</td>
							<td width="10%" class="color_top">
								i18n_sitl.text.nodeIp_n81i 
							</td>
							<td width="12%" class="color_top">
								i18n_sitl.text.checkType_n81i
							</td>
							<td width="12%" class="color_top">
								i18n_sitl.text.processIdenName_n81i
							</td>
							<td width="10%" class="color_top">
								i18n_sitl.text.portNum_n81i
							</td>
							<td width="10%" class="color_top">
								i18n_sitl.text.text.dataCheckTime_n81i
							</td>
							<td width="10%" class="color_top">
								i18n_sitl.text.showRecord_n81i
							</td>
						</tr>
						<jsp:include page="/common/svgDownloadConn.jsp" />
						<c:choose>
							<c:when test="${fn:length(datasList) > 0}">
								<c:forEach items="${datasList}" var="typeData">
									<c:forEach items="${typeData}" var="rowData" varStatus="vs">
										<c:if test="${vs.index==0}" var="flag">
											<tr>
												<c:forEach items="${rowData}" var="cellData" varStatus="ind"
													begin="3" end="8">
													<c:set var="dsiId" value="${rowData[1] }" />
													<c:set var="seqId" value="${rowData[2] }" />
													<c:set var="nodeIp" value="${rowData[4] }" />
													<c:set var="checkDate" value="${rowData[9] }" />
													<c:choose>
														<c:when test="${ind.index eq 3}">
															<td class="color_1_1" rowspan="${fn:length(typeData)}"
																valign="top">
																<c:out value="${cellData}" default="" />
															</td>
														</c:when>


														<c:otherwise>
															<td class="color_1_1">
																<span class="STYLE1" style="word-break: break-all">
																	<c:out value="${cellData}" default="" /> </span>
															</td>
														</c:otherwise>
													</c:choose>

												</c:forEach>
												<td class="color_1_1">
													<a href='#showGrap'
														onclick="javascript:showGrap('${dsiId}','${seqId}','${nodeIp}');">
														i18n_sitl.text.showGrap_n81i </a>
													<a onclick="javascript:showList('${dsiId}','${seqId}','${checkDate}','${networElementType }');"
														href='#'>
														i18n_sitl.text.showList_n81i</a>
												</td>
											</tr>
										</c:if>
										<c:if test="${!flag}">
											<tr>
												<c:forEach items="${rowData}" var="cellData" varStatus="ind"
													begin="3" end="8">
													<c:set var="dsiId" value="${rowData[1] }" />
													<c:set var="seqId" value="${rowData[2] }" />
													<c:set var="nodeIp" value="${rowData[4] }" />
													<c:set var="checkDate" value="${rowData[9] }" />
													<c:choose>
														<c:when test="${ind.index eq 3}">
														</c:when>
														<c:otherwise>
															<td class="color_1_1">
																<span class="STYLE1" style="word-break: break-all">
																	<c:out value="${cellData}" default="" /> </span>
															</td>
														</c:otherwise>
													</c:choose>

												</c:forEach>
												<td class="color_1_1">
													<a href='##showGrap'
														onclick="javascript:showGrap('${dsiId}','${seqId}','${nodeIp}');">
														i18n_sitl.text.showGrap_n81i </a>
													<a onclick="javascript:showList('${dsiId}','${seqId}','${checkDate}','');"
														href='#'>
														i18n_sitl.text.showList_n81i </a>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="color_6" align="center" colspan="7">
										i18n_sitl.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty datasList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
			</form>
		</div>
		<div id="popDiv" class="mydiv" style="display: none;">
			<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width: 100px;"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportCurrentXls();" value="i18n_sitl.button.exportCurrentPage_n81i" />
			&nbsp;
			<input type="button" class=btn3_mouseout style="width: 80px"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportAllXls();" value="i18n_sitl.button.exportAllData_n81i" />
			&nbsp;
			<br />
			<a href="javascript:closeDiv()">i18n_sitl.text.closeWindow_n81i</a>
		</div>

		<div id="bg" class="bg" style="display: none;"></div>
	</body>
</html>

