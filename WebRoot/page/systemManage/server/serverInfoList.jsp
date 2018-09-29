<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_serverinfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
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
		<script type="text/javascript">
	var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_serverinfo.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_serverinfo.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function openAdd(){		 	
		document.form3.action ="<%=path%>/serverManager/serverManager!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function openUpdate(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_serverinfo.message.selectOne_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/serverManager/serverManager!executeAction.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //停用
	 function stopServer(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_serverinfo.message.selectOne_n81i");
	 	}else{//0 启用状态，1 停用状态
	 		if(isOperation("ids", 1)){//当前状态是1，不能停用操作
				alert('i18n_serverinfo.message.includeStop_n81i');
			}else{
				document.form3.action ="<%=path%>/serverManager/serverManager!executeAction.do?action=stop";
				document.form3.submit();
			}
		}
	 }
	 //启用
	 function startServer(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_serverinfo.message.selectOne_n81i");
	 	}else{//0 启用状态，1 停用状态
	 		if(isOperation("ids", 0)){//当前状态是0，不能启用操作
				alert('i18n_serverinfo.message.includeStart_n81i');
			}else{
				document.form3.action ="<%=path%>/serverManager/serverManager!executeAction.do?action=start";
				document.form3.submit();
			}
		}
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=query";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(sysid){
		document.form3.action = "<%=path%>/serverManager/serverManager!executeAction.do?action=detail&serverId="+sysid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();		
	}
		
	//parent.document.all("listFrame").style.height = document.body.scrollHeight + 16;
	
	
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
				alert('i18n_serverinfo.message.inputInfo_n81i');
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
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
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
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=downloadExample";
		document.form3.submit();
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=query";
	}

	//程辉 2013-5-8 新增 导入
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_serverinfo.message.selectFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_serverinfo.message.selectFileType_n81i");
		}else if(confirm('i18n_serverinfo.message.isImport_n81i')){
			document.form3.action = "<%=path%>/serverManager/serverManager.do?action=importXls";
			document.form3.submit();
			document.form3.action = "<%=path%>/serverManager/serverManager.do?action=query";
		}
	}
	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=emportCurrentXls&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&sn="+$("#serverName").val()+"&si="+$("#serverIp").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=emportAllXls&sn="+$("#serverName").val()+"&si="+$("#serverIp").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=query";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}
	function showDiv1(serverid){
		$("#updateServerID").val(serverid);
		document.getElementById('popDiv1').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv1(){
		document.getElementById('popDiv1').style.display='none';
		document.getElementById('bg').style.display='none';
	}
	// 程辉 2013-5-8 新增 模板下载 update
	function downloadExampleUpdate() {
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=downloadExampleUpdate";
		document.form3.submit();
	}
	// 程辉 2013-5-8 新增导出  update
	function emportXlsUpdate() {
		document.form3.action = "<%=path%>/serverManager/serverManager.do?action=emportXlsUpdate";
		document.form3.submit();
	}
	//程辉 2013-5-8 新增 增量导入 update
	function importXlsAdd() {
		var myfileVal = document.getElementById("myFileUpdate"+$("#updateServerID").val()).value;
		if(myfileVal=="") {
			alert("i18n_serverinfo.message.selectFile1_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_serverinfo.message.selectFileType1_n81i");
		}else if(confirm('i18n_serverinfo.message.isImport1_n81i')){
			document.form3.action = "<%=path%>/serverManager/serverManager.do?action=importXlsUpdate&serverId="+$("#updateServerID").val()+"&operate=add";
			document.form3.submit();
		}
	}
	//程辉 2013-5-8 新增 全量导入 update
	function importXlsAll() {
		var myfileVal = document.getElementById("myFileUpdate"+$("#updateServerID").val()).value;
		if(myfileVal=="") {
			alert("i18n_serverinfo.message.selectFile1_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_serverinfo.message.selectFileType1_n81i");
		}else if(confirm('i18n_serverinfo.message.isImport1_n81i')){
			document.form3.action = "<%=path%>/serverManager/serverManager.do?action=importXlsUpdate&serverId="+$("#updateServerID").val()+"&operate=all";
			document.form3.submit();
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
	//	$("#maindiv").attr("style","clear:left");
		$("#info").floatHeaderDiv();
	});
	
	window.onresize = function(){
		$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
	}
</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<!--中间部分右边开始-->
			<form name=form3 id="frmArticleType"
				action="<c:url value='/serverManager/serverManager.do?action=query'/>" method="post" enctype="multipart/form-data">
				<div id="divTop">
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_serverinfo.text.serverName_n81i</font>
						<input  type="text" id="serverName"
							onkeyup="lianxiangkeyup('serverName','ServerTable','String','serverName','suggest1',this.value);"
							name="sn" title="i18n_serverinfo.message.serverName_n81i" value="${sn}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_serverinfo.text.serverIp_n81i</font>
						<input  type="text" id="serverIp"
							onkeyup="lianxiangkeyup('serverIp','ServerTable','String','serverIp','suggest2',this.value);"
							name="si" title="i18n_serverinfo.message.serverIp_n81i" value="${si}" size="20" />
						<div id='suggest2' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>
					<div class="box_2">
					<!-- 程辉 2013-4-27 新增  begin-->
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_serverinfo.button.downloadExample_n81i"/>
								&nbsp;	
					 
								<input type="button" value="i18n_serverinfo.text.importXls_n81i" title="i18n_serverinfo.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_serverinfo.button.importXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_serverinfo.button.showDiv_n81i"/>
								&nbsp;						
					<!-- 程辉 2013-4-27 新增  end-->
						<jsp:include page="/include/include.jsp" />
					</div>
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
						<tr>
							<td class="color_top" width="4%">
								<input type="checkbox" name="checkbox62" value="checkbox"
									onClick="checkAll(this)" />
								i18n_serverinfo.text.index_n81i
							</td>
							<td class="color_top" width="12%">
								i18n_serverinfo.text.serverName_n81i
							</td>
							<td class="color_top" width="12%">
								i18n_serverinfo.message.serverIp_n81i
							</td>
							<td class="color_top" width="12%">
								i18n_serverinfo.text.createTime_n81i
							</td>
							<td class="color_top" width="4%">
								i18n_serverinfo.text.isOnline_n81i
							</td>
							<td class="color_top" width="18%">								
								i18n_serverinfo.text.configIp_n81i
							</td>
						</tr>
						<c:set var="index" value="${1}" />
						<c:choose>
							<c:when test="${fn:length(stList) > 0}">
								<c:forEach items="${stList}" var="st" varStatus="vs">
									<input type="hidden" id="yxbz${st.id }"
										name="yxbz${st.id }" value="${st.serverState}" />
									<c:set var="color" value="color_1"/>
									<c:set var="color_end" value="color_7"/>
									<c:if test="${vs.count%2!=0 }">
										<c:set var="color" value="color_3"/>
										<c:set var="color_end" value="color_6"/>
									</c:if>
									<tr>
										<td class="${color }">
											<input type="checkbox" name="ids" id="ids"
												value="${st.id}" />
											${index+(pageNo-1)*pageSize}
										</td>
										<td class="${color }">
											<a href="javascript:showRecord('${st.id }')">${st.serverName}</a>
										</td>
										<td class="${color }">
											${st.serverIp}
										</td>
										<td class="${color }">
											<fmt:formatDate value="${st.createTime}" type="both" />
										</td>
										<td class="${color }">
											<c:if test="${st.serverState=='0' }">i18n_serverinfo.message.Y_n81i</c:if>
											<c:if test="${st.serverState=='1' }"><font color="red">i18n_serverinfo.message.N_n81i</font></c:if>
										</td>
										<td class="${color_end }">
											<input type="button" class=btn3_mouseout
												onmouseover="this.className='btn3_mouseover'"
												onmouseout="this.className='btn3_mouseout'"
												onmousedown="this.className='btn3_mousedown'"
												onmouseup="this.className='btn3_mouseup'"
												onclick="javascript:downloadExampleUpdate();" value="i18n_serverinfo.button.downloadExampleUpdate_n81i"/>
											&nbsp;
											<input type="button" value="i18n_entip1.message.selectFile_n81i" title="i18n_entip1.message.selectFile_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
											<input type="file" name="myFileUpdate" id="myFileUpdate${st.id}" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>											
											&nbsp;
											<input type="button" class=btn3_mouseout
												onmouseover="this.className='btn3_mouseover'"
												onmouseout="this.className='btn3_mouseout'"
												onmousedown="this.className='btn3_mousedown'"
												onmouseup="this.className='btn3_mouseup'"
												onclick="javascript:showDiv1(${st.id});" value="i18n_serverinfo.button.showDiv1_n81i"/>
												&nbsp;
											<input type="button" class=btn3_mouseout
												onmouseover="this.className='btn3_mouseover'"
												onmouseout="this.className='btn3_mouseout'"
												onmousedown="this.className='btn3_mousedown'"
												onmouseup="this.className='btn3_mouseup'"
												onclick="javascript:emportXlsUpdate();" value="i18n_serverinfo.button.emportXlsUpdate_n81i"/>
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" height="35" class="color_6" align="center">
										i18n_serverinfo.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					</div>
					<c:if test="${!empty stList}">
						<div id="divBoot">
							<jsp:include page="/common/page.jsp" />
						</div>
					</c:if>
					<!--中间部分右边结束-->
			</form>
		</div>
		<div id="popDiv" class="mydiv" style="display:none;">		
		<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width:100px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportCurrentXls();" value="i18n_serverinfo.button.emportCurrentXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_serverinfo.button.emportAllXls_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_serverinfo.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
		<div id="popDiv1" class="mydiv" style="display:none;">
		<input type="hidden" name="updateServerID" id="updateServerID" value="" />
			<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXlsAdd();" value="i18n_serverinfo.button.importXlsAdd_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXlsAll();" value="i18n_serverinfo.button.importXlsAll_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv1()">i18n_serverinfo.text.closeWindow_n81i</a></div>
	</body>
</html>
