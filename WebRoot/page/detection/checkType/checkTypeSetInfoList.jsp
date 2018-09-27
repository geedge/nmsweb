<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_ctsil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
			<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
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
	</head>

	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_ctsil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_ctsil.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addCheckTypeSet(){		 	
		document.form3.action ="<%=path%>/detection/checkTypeSet!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updCheckTypeSet(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ctsil.error.itemSelect_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/checkTypeSet!executeAction.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //删除记录
	 function delCheckTypeSet(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ctsil.error.itemSelect_n81i");
	 	}else if(confirm("i18n_ctsil.error.isDelete_n81i")){
		 	document.form3.action ="<%=path%>/detection/checkTypeSet.do?action=del&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/detection/checkTypeSet.do?action=query";
		document.form3.submit();		
	}
	 //配置元数据
	 function showRecord(checktypeid){
	 	document.form3.action = "<%=path%>/detection/metaDataSet!executeAction.do?action=query&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }'+"&typeids="+checktypeid;
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

	// 程辉 2013-5-8 新增 模板下载 
	function downloadExample() {
		document.form3.action = "<c:url value='/'/>/detection/checkTypeSet.do?action=downloadExample";
		document.form3.submit();
		document.form3.action = "<%=path%>/detection/checkTypeSet.do?action=query";
	}

	//程辉 2013-5-8 新增 导入
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_ctsil.error.selectFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_ctsil.error.selectFileType_n81i");
		}else if(confirm('i18n_ctsil.error.isImport_n81i')){
			document.form3.action = "<c:url value='/'/>/detection/checkTypeSet.do?action=importXls";
			document.form3.submit();
			document.form3.action = "<%=path%>/detection/checkTypeSet.do?action=query";
		}
	}
	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<c:url value='/'/>/detection/checkTypeSet.do?action=emportCurrentXls&pageNo="+$("#pageNo").val()+"&pageSize="+'${pageSize }'+"&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/checkTypeSet.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/detection/checkTypeSet.do?action=emportAllXls&ctn="+$("#checkTypeId").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/detection/checkTypeSet.do?action=query";
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
	//	$("#maindiv").attr("style","clear:left");
		$("#info").floatHeaderDiv();
	});
	window.onresize = function(){
		$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
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
		$.get("<c:url value='checkTypeSet.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&ctn="+$("#checkTypeId").val(), function(data){//利用jquery的get方法得到table.html内容
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
		    
			$.get("<c:url value='checkTypeSet.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&ctn="+$("#checkTypeId").val(), function(data){//利用jquery的get方法得到table.html内容
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
			loadButton();
		}
	});	
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
    </script>
	<body>
	<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType" action="<c:url value='/detection/checkTypeSet.do?action=query'/>" method="post" enctype="multipart/form-data">
			<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
			<input type="hidden" id="fw" name="fromWhere" value="${fromWhere }"/>
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			<div id="divTop">
				<div class="box_1">		 
						<label class="divTopText"><font class="selectText">i18n_ctsil.text.detecationTypeName_n81i</font>
						<select  style="width:140px;" name="ctn" id="checkTypeId">
								<option value="">
									--i18n_ctsil.message.selectDetecationTypeDefault_n81i--
								</option>
								<c:if test="${fn:length(allCheckTypeInfo) > 0}">
									<c:set var="isSchedule0" value="0"/>
									<c:forEach items="${allCheckTypeInfo}" var="checkType">
										<c:if test="${checkType.isSchedule != isSchedule0 }">
											<option style="height: 2px;" disabled="disabled">--------------------</option>
											<c:set var="isSchedule0" value="${checkType.isSchedule}"/>
										</c:if>
										<option value="${checkType.id}" 
										<c:if test="${not empty ctn && ctn == checkType.id }">selected="selected"</c:if>>
											${checkType.checkTypeName1}
										</option>
									</c:forEach>
								</c:if>
							</select></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
				<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_ctsil.button.downloadModel_n81i"/>
								&nbsp;		
			<input type="button" value="i18n_ctsil.button.import_n81i Excel" title="i18n_ctsil.button.import_n81i Excel" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_ctsil.button.import_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_ctsil.button.export_n81i"/>
								&nbsp;		
					<jsp:include page="/include/include.jsp" />
				</div>
			</div>
			<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr >
						<td width="6%" class="color_top">
							<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_ctsil.button.index_n81i
						</td>
						<td width="12%" class="color_top">
							i18n_ctsil.text.detecationTypeName_n81i
						</td>
						<td width="12%" class="color_top">
							i18n_ctsil.text.detecationType_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_ctsil.text.tableMap_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_ctsil.text.tableComments_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_ctsil.text.isSchedule_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_ctsil.text.isSnmp_n81i
						</td>
						<td width="12%" class="color_8">
							i18n_ctsil.text.remark_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(checkTypeSetList) > 0}">
							<c:forEach items="${checkTypeSetList}" var="checkTypeSet" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr >
									<td class="${color }">
										<c:if test="${checkTypeSet.isSchedule=='0'}">
											<input type="checkbox" name="ids" id="ids"
													value="${checkTypeSet.id}" disabled="disabled"/>
										</c:if>
										<c:if test="${checkTypeSet.isSchedule=='2'}">
											<input type="checkbox" name="ids" id="ids"
													value="${checkTypeSet.id}" disabled="disabled"/>
										</c:if>
										<c:if test="${checkTypeSet.isSchedule=='1'}">
											<input type="checkbox" name="ids" id="ids" ${(ADMFlag && checkTypeSet.viewLevel ne 4) || (!ADMFlag && checkTypeSet.viewLevel eq 4) ? "disabled='disabled'":""}
													value="${checkTypeSet.id}"/>
										</c:if>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										<a href="javascript:showRecord('${checkTypeSet.id}')">${checkTypeSet.checkTypeName1}</a>
									</td>
									<td class="${color }">
										${checkTypeSet.checkTypeName}
									</td>
									<td class="${color }">
										${checkTypeSet.tableName}
									</td>
									<td class="${color }">
										${checkTypeSet.tableComments}
									</td>
									<td class="${color }">
										<c:if test="${checkTypeSet.isSchedule=='0'}">i18n_ctsil.message.yes_n81i</c:if> 
										<c:if test="${checkTypeSet.isSchedule=='1'}">i18n_ctsil.message.no_n81i</c:if>
										<c:if test="${checkTypeSet.isSchedule=='2'}">i18n_ctsil.message.yes_n81i</c:if>
									</td>
									<td class="${color }">
										<c:if test="${checkTypeSet.isSnmp=='1'||checkTypeSet.isSnmp=='0'}">i18n_ctsil.message.yes_n81i</c:if> 
										<c:if test="${checkTypeSet.isSnmp=='2'||checkTypeSet.isSnmp eq null}">i18n_ctsil.message.no_n81i</c:if>
									</td>
									<td class="${color_end }">
										${checkTypeSet.checkRemark}
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="8" class="color_6" align="center">
									i18n_ctsil.message.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty checkTypeSetList}">
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
									onclick="javascript:emportCurrentXls();" value="i18n_ctsil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_ctsil.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_ctsil.button.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>

