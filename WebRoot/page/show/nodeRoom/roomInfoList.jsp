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
		<title>i18n_ril.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
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
	_top: expression(eval(document.compatMode &&  
				              document.compatMode ==   'CSS1Compat') ?  
				              documentElement.scrollTop +     ( 
		 document.documentElement.clientHeight-this.offsetHeight )/ 2 :  
		/*IE6*/ 
		
				              document.body.scrollTop +     ( 
		 document.body.clientHeight -     this.clientHeight )/ 2 );
	/*IE5 IE5.5*/
}

.bg {
	background-color: #ccc;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0; /*FF IE7*/
	filter: alpha(opacity =   50); /*IE*/
	opacity: 0.5; /*FF*/
	z-index: 1;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document.compatMode &&  
				              document.compatMode ==   'CSS1Compat') ?  
				              documentElement.scrollTop +     ( 
		 document.documentElement.clientHeight-this.offsetHeight )/ 2 :  
		/*IE6*/ 
		
				              document.body.scrollTop +     ( 
		 document.body.clientHeight -     this.clientHeight )/ 2 );
	/*IE5 IE5.5*/
}
/*The END*/
</style>
		<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_ril.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_ril.message.faild_n81i");
	  }	  

      function boxmanager(){

  	  if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ril.message.selectOne_n81i");
	 	}else{
	 		var checks = document.getElementsByName("ids");
	 		var roomid ="";
	 		var roomIspn;
	 		for(i = 0 ; i <= checks.length ; i++ ){
	 			if(checks[i]){
					if(checks[i].checked)
					{
						roomid=checks[i].value;
						roomIspn=$.trim($(checks[i]).parent().next().html());
					}
	 			}
	 		}
		 	document.form3.action ="<%=path%>/nodePosition/boxSet.do?action=query&roomid="+roomid+"&roomIspn="+roomIspn;
			document.form3.submit();
		}
  	  }
	  
	//添加记录
	 function addRecord(){		 	
		document.form3.action ="<%=path%>/nodePosition/roomManage!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updRecord(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ril.message.selectOne_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/nodePosition/roomManage!executeAction.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 
 	//删除记录
	 function delRecord(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ril.message.selectOne_n81i");
	 	}else if(confirm("i18n_ril.message.delete_n81i")){
		 	document.form3.action ="<%=path%>/nodePosition/roomManage!executeAction.do?action=del&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/nodePosition/roomManage.do?action=query";
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
			if(!containSpecial(ajaxValue1)){
				ajaxValue = ajaxValue1;
			}else{
				clearTimeout(set_Id);
				alert('i18n_ril.message.inputInfo_n81i');
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

	// 程辉 2013-5-8 新增 模板下载 
	function downloadExample() {
		document.form3.action = "<c:url value='/'/>/nodePosition/roomManage.do?action=downloadExample";
		document.form3.submit();
		document.form3.action = "<%=path%>/nodePosition/roomManage.do?action=query";
	}

	//程辉 2013-5-8 新增 导入
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_ril.message.selectImportFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_ril.message.selectCorrectFile_n81i");
		}else if(confirm('i18n_ril.message.sureToImport_n81i')){
			document.form3.action = "<c:url value='/'/>/nodePosition/roomManage.do?action=importXls";
			document.form3.submit();
			document.form3.action = "<%=path%>/nodePosition/roomManage.do?action=query";
		}
	}
	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<c:url value='/'/>/nodePosition/roomManage.do?action=emportCurrentXls&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&rIspn="+$("#rIspn").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/nodePosition/roomManage.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/nodePosition/roomManage.do?action=emportAllXls&rIspn="+$("#rIspn").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/nodePosition/roomManage.do?action=query";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}

	function goGuide(datas) {
		if(datas!=null && datas!=""){
		 	if(datas.resu=='over') {
		 		window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
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
		$("#maindiv").attr("style","clear:left");
		if($("#isComplete").val()=='0'){
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:3,
		 					packName:'jf'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_ril.message.warning_n81i", "i18n_ril.message.hint_n81i", submit,{icon: false});
		}
		
	});
    </script>

	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<form name=form3 id="frmArticleType"
				action="<c:url value='/nodePosition/roomManage.do?action=query'/>" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="isComplete" id="isComplete"
					value="${isComplete}" />
				<input type="hidden" name="fromWhere" value="${fromWhere }" />
				<div id="divTop">
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_ril.text.rIspn_n81i</font>
						<input type="text" id="rIspn"
							onkeyup="lianxiangkeyup('roomIspn','NodeRoomTable','String','rIspn','suggest1',this.value);"
							name="rIspn" title="i18n_ril.message.rIspn_n81i" value="${rIspn}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>

					<div class="box_2">

						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:downloadExample();" value="i18n_ril.button.downloadExample_n81i" />
						&nbsp; 
						<input type="button" value="i18n_ril.text.importXls_n81i" title="i18n_ril.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
						<input type="file" name="myFile" id="myFile" value="" onchange="javascript:setValue(this.value)"
							class="filebtn" />
						&nbsp;
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:importXls();" value="i18n_ril.button.import_n81i" />
						&nbsp;
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:showDiv();" value="i18n_ril.button.export_n81i" />
						&nbsp;
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:boxmanager();" value="i18n_ril.button.boxmanager_n81i" />
						&nbsp;
						<jsp:include page="/include/include.jsp" /></div>
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table"
						id="info">
						<tr>
							<td width="8%" class="color_top" nowrap>
								<input type="checkbox" name="checkbox62" value="checkbox"
									onClick="checkAll(this)" />
								i18n_ril.text.index_n81i
							</td>
							<td width="20%" class="color_top" nowrap>
								i18n_ril.text.rIspn_n81i
							</td>
							<td width="10%" class="color_top" nowrap>
								i18n_ril.text.roomRows_n81i
							</td>
							<td width="10%" class="color_top" nowrap>
								i18n_ril.text.roomCols_n81i
							</td>
							<td width="40%" class="color_top" nowrap>
								i18n_ril.text.roomDesc_n81i
							</td>
						</tr>
						<c:set var="index" value="${1}" />
						<c:choose>
							<c:when test="${fn:length(nodeRoomList) > 0}">
								<c:forEach items="${nodeRoomList}" var="nodeRoom" varStatus="vs">
									<c:set var="color" value="color_1" />
									<c:set var="color_end" value="color_7" />
									<c:if test="${vs.count%2!=0 }">
										<c:set var="color" value="color_3" />
										<c:set var="color_end" value="color_6" />
									</c:if>
									<tr>
										<td class="${color }">
											<input type="checkbox" name="ids" id="ids"
												value="${nodeRoom.roomId}" />
											${index+(pageNo-1)*pageSize}
										</td>
										<td class="${color }">
											${nodeRoom.roomIspn}
										</td>
										<td class="${color }">
											${nodeRoom.roomRows}
										</td>
										<td class="${color }">
											${nodeRoom.roomCols}
										</td>
										<td class="${color }">
											${nodeRoom.roomDesc}
										</td>

									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>

							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" height="20" class="color_6" align="center">
										i18n_ril.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty nodeRoomList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
			</form>
		</div>
		<br />
		<div id="popDiv" class="mydiv" style="display: none;">
			<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width: 100px;"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportCurrentXls();" value="i18n_ril.button.exportCurrentXls_n81i" />
			&nbsp;
			<input type="button" class=btn3_mouseout style="width: 80px"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="javascript:emportAllXls();" value="i18n_ril.button.exportAllXls_n81i" />
			&nbsp;
			<br />
			<a href="javascript:closeDiv()">i18n_ril.text.closeWindow_n81i</a>
		</div>

		<div id="bg" class="bg" style="display: none;"></div>
	</body>
</html>

