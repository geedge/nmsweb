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
		<title>i18n_nil.message.title_n81i</title>
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
		<script type="text/javascript">
	var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_nil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_nil.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addRecord(){		 	
		document.form3.action ="<%=path%>/sysManage/nodeManage!executeAction.do?action=openAdd";
		document.form3.submit();
	 } 
	//修改记录
	 function updateRecord(id){
	 	document.form3.action ="<%=path%>/sysManage/nodeManage!executeAction.do?action=openUpdate&nodeId="+id;
		document.form3.submit();
	 }
	 //停用
	 function stopRecord(id){
	 	document.form3.action ="<%=path%>/sysManage/nodeManage!executeAction.do?action=stop&nodeId="+id;
		document.form3.submit();
	 }
	 //启用
	 function startRecord(id){
	 	document.form3.action ="<%=path%>/sysManage/nodeManage!executeAction.do?action=start&nodeId="+id;
		document.form3.submit();
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/sysManage/nodeManage!executeAction.do?action=query";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(id){
		document.form3.action = "<%=path%>/sysManage/nodeManage!executeAction.do?action=detail&nodeId="+id;
		document.form3.submit();		
	}
	//导入节点
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal.value=="") {
			alert("i18n_nil.message.importFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_nil.message.importCorrectFile_n81i");
		}else if(confirm('i18n_nil.message.sureToImport_n81i')){	
			document.form3.action = "<%=path%>/sysManage/nodeManage!executeAction.do?action=importXls";
			document.form3.submit();
		}						
	}
	function downloadExample() {
			document.form3.action = "<%=path%>/sysManage/nodeManage!executeAction.do?action=downloadExample";
			document.form3.submit();
	}
	
	//返回
	 function goBack(){
		//window.parent.goBack();
		document.location.href = "<%=path%>/sysManage/nodeGroupManage.do?action=query";
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
			
			if(!containSpecial(ajaxValue1)){
						ajaxValue = ajaxValue1;
					}else{
						alert('i18n_nil.message.inputInfo_n81i');
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
	
	function downloadfile(fileName){
			document.form3.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.form3.submit();				
	}
	
</script>
	</head>
	<body id="nodeBody">
		<div class="middle_list" id="box">
			<!--中间部分右边开始-->
			
			<form name="form3" id="form3"
				action="<c:url value='/sysManage/nodeManage!queryNodeInfo.do'/>"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="position" value="${position }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_nil.text.nodeName_n81i</font>
					<input  type="text" id="nodeNameVo"
						onkeyup="lianxiangkeyup('nodeName','NodeTable','String','nodeName','suggest1',this.value);"
						name="nodeNameVo" title="i18n_nil.message.nodeName_n81i" value="${nodeNameVo}" size="20" />
					<div id='suggest1' class="ac_results"></div></label>
					<label class="divTopText"><font class="selectText">i18n_nil.text.nodeDesc_n81i</font>
					<input  type="text" id="nodeDescVo"
						onkeyup="lianxiangkeyup('nodeDesc','NodeTable','String','nodeDesc','suggest2',this.value);"
						name="nodeDescVo" title="i18n_nil.message.nodeDesc_n81i" value="${nodeDescVo}" size="20" />
					<div id='suggest2' class="ac_results"></div></label>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
				   
				   <input type="button" value="i18n_nil.text.importXls_n81i" title="i18n_nil.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
					<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
					&nbsp;
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:importXls();" value="i18n_nil.button.importXls_n81i"/>
					&nbsp;
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:addRecord();" value="i18n_nil.button.add_n81i"/>
					&nbsp;
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:downloadExample();" value="i18n_nil.button.downloadExample_n81i"/>
					&nbsp;
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:goBack();" value="i18n_nil.button.back_n81i"/>
					&nbsp;
				</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td class="color_top" width="4%">
							i18n_nil.text.index_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_nil.text.option_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nil.text.nodeIp_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nil.text.nodeName_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nil.text.systemId_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nil.text.nodeGroup_n81i
						</td>
						<td class="color_8" width="8%">
							i18n_nil.text.createDate_n81i
						</td>
					</tr>
					<!-- 1、远程连接引入页面 -->
					<jsp:include page="/common/remoteConn.jsp" />
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(nodeList) > 0}">
							<c:forEach items="${nodeList}" var="node" varStatus="vs">
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
									    <img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<a href="javascript:updateRecord('${node.nodeId}')">i18n_nil.text.update_n81i</a>
										
										<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<c:if test="${node.nodeState=='0' }">
											<a href="javascript:stopRecord('${node.nodeId}')"><font color="red">i18n_nil.text.stop_n81i</font></a>
										</c:if>
										<c:if test="${node.nodeState=='1' }">
											<a href="javascript:startRecord('${node.nodeId}')">i18n_nil.text.start_n81i</a>
										</c:if>
									</td>
									<td class="${color }">
										<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
										<a href="javascript:void(0);"
										   onclick="remoteConn('${node.nodeSystemType }','${node.nodeIp}', null, this)">
										   ${node.nodeIp}
										</a>
									</td>
									<td class="${color }">
										${node.nodeName}
									</td>
									<td class="${color }">
										${node.systemIdName}
									</td>
									<td class="${color }">
										${node.groupIdName}
									</td>
									<td class="${color_end }">
										<fmt:formatDate value="${node.nodeCreatetime}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" height="35" class="color_6" align="center">
									i18n_nil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${!empty nodeList}">
					<jsp:include page="/common/page.jsp" />
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
