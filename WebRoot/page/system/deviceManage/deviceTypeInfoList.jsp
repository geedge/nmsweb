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
		<title>i18n_dtil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js' />"></script>
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
	  function ajaxForPardevice(obj) 
	{
		jQuery.post("<%=path%>/sysManage/deviceBrandManage.do?action=ajaxForParDevCode",
		{"brand":obj},function(data)
		{
			var everyItems=jQuery.trim(data).split(",");
			$("#parDevCode").suggest(everyItems,{hot_list:everyItems,attachObject:"#suggest1"});
			$("#suggest1").css("display","none");
		});
	}
	  //新增设备型号信息
	  function toAddDevType() {
	  		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=toAddDevType&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';
	     	document.form3.submit();
	  };
	  
	  //新增槽位设备信息
	  function toAddPosDevType(pid) {
	  		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=toAddPosDevType&posParDevId="+pid;
	     	document.form3.submit();
	  };
	  //配置设备位置
	  function toConfDevPos(pid) {
	  		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=toConfDevPos&posParDevId="+pid;
	     	document.form3.submit();
	  }; 
	  
	  //批量新增设备型号信息
	  function toAddBatchDevType() {
	  		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=toAddBatchDevType";
	     	document.form3.submit();
	  }; 
	  //修改设备型号信息
	  function toUpdateDevType() {
	  	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_dtil.message.selectOne_n81i");
	 	}else{
	 	    //获取选择的设备型号信息
		 	document.form3.action = "<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=toUpdateDevType&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';
	  		document.form3.submit();
		}
	  }; 
	  
	  //查询记录
	  function qry(){
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
		document.form3.submit();		
	  }
	  
	  function detailDev(id){
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=detailDevType&devId="+id+"&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';
		document.form3.submit();	
	  }
	  
	   //删除设备型号信息
	  function deleteDevType() {
	    if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_dtil.message.selectOne_n81i");
	 	}else if(confirm("i18n_dtil.message.delete_n81i")){
		    document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=deleteDevType";
	     	document.form3.submit();
		}
	  }
	  
	  function isNotBlank(obj) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		return true;
	     	}else {
	     		return false;
	     	}
     }
	
	  //add by wx
	 function emptyCode(){
	 	jQuery("input[id='parDevCode']").val("");
	 }
	 //add by wx 品牌改变时改变suggest提示内容
	 function changeparCode1() {
		jQuery("div[id='suggest1']").empty();//清空父设备型号列表
 		var selecVal = jQuery("select[id='devRandCodeForSearch'] option:selected").val();	//所选品牌
 		
 		if(isNotBlank(selecVal)) {
		 	ajaxForPardevice(selecVal);	
		 	$("#suggest1").hide();		
 		}else {
 			ajaxForPardevice("");
 			$("#suggest1").hide();
 		}
	 }
	// 程辉 2013-5-8 新增 模板下载 
		function downloadExample() {
			document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=downloadExampleType";
			document.form3.submit();
			document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
		}

		//程辉 2013-5-8 新增 导入
		function importXls() {
			var myfileVal = document.getElementById("myFile").value;
			if(myfileVal=="") {
				alert("i18n_dtil.message.selectImportFile_n81i");
			}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
				alert("i18n_dtil.message.selectCorrectFile_n81i");
			}else if(confirm('i18n_dtil.message.sureToImport_n81i')){
				document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=importXlsType";
				document.form3.submit();
				document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
			}
		}
		//程辉 2013-5-8 新增 导出当前页
		function emportCurrentXls() {
			if($("#noresult").html() != ""&&$("#noresult").html() != null){
				alert("i18n_dtil.message.noDataExport_n81i");
				return ;
			}
			var currentPage = $("#currentPage").html(); 
			document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=emportCurrentXlsType&pageNo="+currentPage+"&pageSize="+'${pageSize }'+"&devTypeCodeForSearch="+$("#devTypeCodeForSearch").val()+"&devRandCodeForSearch="+$("#devRandCodeForSearch").val()+"&parDevId="+$("#parDevCode").val();
			document.form3.submit();
			closeDiv();
			document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
		}
		//程辉 2013-5-8 新增 导出全部
		function emportAllXls() {
			if($("#noresult").html() != ""&&$("#noresult").html() != null){
				alert("i18n_dtil.message.noDataExport_n81i");
				return ;
			}
			document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=emportAllXlsType&devTypeCodeForSearch="+$("#devTypeCodeForSearch").val()+"&devRandCodeForSearch="+$("#devRandCodeForSearch").val()+"&parDevId="+$("#parDevCode").val();
			document.form3.submit();
			closeDiv();
			document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
		}
		function showDiv(){
			document.getElementById('popDiv').style.display='block';
			document.getElementById('bg').style.display='block';
		}

		function closeDiv(){
			document.getElementById('popDiv').style.display='none';
			document.getElementById('bg').style.display='none';
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
		window.onresize = function(){
			$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
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
		    var url2="<c:url value='deviceBrandManage.do?action=queryDeviceTypeInfoChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&devTypeCodeForSearch="+$("#devTypeCodeForSearch").val()+"&devRandCodeForSearch="+$("#devRandCodeForSearch").val()+"&parDevCode="+$("#parDevCode").val();
		    var urlTmp = encodeURI(url2);
			$.ajax({
				url:urlTmp,
				type : "get",
				async:false,
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
	var set_Id;
	var parDevCode = "";
	function suggestKeyUp(str){
		parDevCode = str;
		if(!checkStrNoDian(str)){
			clearTimeout(set_Id);
			set_Id = setTimeout(suggestResult,800);
		}else{
			clearTimeout(set_Id);
			alert('i18n_dtil.message.inputInfo_n81i');
			$("#parDevCode").val('');
			return;
		}
	}
	function suggestResult(){
		if(parDevCode==""){
		 	return ; 
		}
		var brand = $("#devRandCodeForSearch").val();
		$.ajax({
			url:"<%=path%>/sysManage/deviceBrandManage.do?action=suggestResult",
			type : "POST",
			data:{"brand":brand,"keyWord":parDevCode},
			success : function(data) {
				var lianxiangList = data.split(",");
				$("#parDevCode").suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#suggest1",showType:"scroll"});
			}
		});
	}
    </script>
	<body>
	<div class="middle_list">
	<form name="form3" id="frmArticleType"
			action="<c:url value='/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo'/>" method="post" enctype="multipart/form-data">
			<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_dtil.text.devTypeCode_n81i</font>
					<input  style="width:80px;" name="devTypeCodeForSearch" id="devTypeCodeForSearch" value="${devTypeCodeForSearch}" /></label>
					<label class="divTopText"><font class="selectText">i18n_dtil.text.devRandCode_n81i</font>
					<select id="devRandCodeForSearch" name="devRandCodeForSearch">
					   	<option  value="" >i18n_dtil.message.selectDefault_n81i</option>
						<c:forEach items="${devBrandListInfo}" var="brand" >
						  	<option  value="${brand.deviceRandCode}"  
						  	   <c:if test="${devRandCodeForSearch==brand.deviceRandCode }">selected="selected"</c:if> >${brand.deviceRandCode}</option>
						</c:forEach>
					</select></label>
					<label class="divTopText"><font class="selectText">i18n_dtil.text.parDev_n81i</font>
					<input type="text" id="parDevCode" name="parDevCode" value="${parDevCode}" onkeyup="suggestKeyUp(this.value)">
					<div id="suggest1" class="ac_results" style="display:none;"></label>
					</div>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
			</div>
			<div class="box_2">
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_dtil.button.export_n81i"/>
				<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="toAddDevType()" value="i18n_dtil.button.add_n81i"/>
 		 		<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="toAddBatchDevType()" value="i18n_dtil.button.toAddBatchDevType_n81i"/>   
				<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="toUpdateDevType()" value="i18n_dtil.button.update_n81i"/>
				<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="deleteDevType()" value="i18n_dtil.button.delete_n81i"/>
			
			
			</div>
			<div id="maindiv">
			<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
				<tr>
					<td width="6%" class="color_top">
						<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_dtil.text.index_n81i
					</td>
					<td width="12%" class="color_top">
						i18n_dtil.text.devTypeCode_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_dtil.text.devRandCode_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_dtil.text.deviceDesc_n81i
					</td>					
					<td width="10%" class="color_top">
						i18n_dtil.text.parDevCode_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_dtil.text.addTime_n81i
					</td>
					<td width="10%" class="color_8">
						i18n_dtil.text.opration_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
				 
					<c:when test="${fn:length(devTypeListInfo) > 0}">
						<c:forEach items="${devTypeListInfo}" var="devType" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
							</c:if>
							<tr >
								<td class="${color }">
									<input type="checkbox" name="ids" id="ids" value="${devType.id}" 
									      <c:if test="${devType.hasInstance==1}">disabled="disabled"</c:if> />${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }">
									${devType.deviceTypeCode}
								</td>
								<td class="${color }">
									${devType.deviceRandCode}
								</td>
								<td class="${color }">
									${devType.deviceDesc}
								</td>
								<td class="${color}">
									${devType.parDevCode}
								</td>
								<td class="${color}">
									<fmt:formatDate value="${devType.addTime}" type="both" />
								</td>
								<td class="${color_end}">
									<a href="javascript:detailDev('${devType.id}');">i18n_dtil.text.detailDev_n81i</a>
									<c:if test="${not empty devType.pid && devType.pid==0 && devType.isPositionDev!=1}">
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:toAddPosDevType('${devType.id}');">i18n_dtil.text.toAddPosDevType_n81i</a>
									</c:if>
									<c:if test="${devType.figureFill !=null && devType.isLeaf==0 && devType.isPositionDev!=1}">
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:toConfDevPos('${devType.id}');">i18n_dtil.text.toConfDevPos_n81i</a>
									</c:if>
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7" align="center" class="color_6">
								<div id="noresult">i18n_dtil.text.noRecord_n81i</div>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			</div>
			<c:if test="${!empty devTypeListInfo}">
				<jsp:include page="/common/page.jsp" />
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
									onclick="javascript:emportCurrentXls();" value="i18n_dtil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_dtil.button.exportAllDate_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_dtil.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>

