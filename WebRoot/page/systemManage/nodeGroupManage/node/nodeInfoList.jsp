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
		<title>${nodegroupTable.groupName }&nbsp;i18n_nodeInfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
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
		<script type="text/javascript">
		
	var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_nodeInfo.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_nodeInfo.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addRecord(){			
		document.form3.action ="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updateRecord(id){
	 	document.form3.action ="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=openUpdate&nodeId="+id+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 }
	 //停用
	 function stopRecord(id){
	 	document.form3.action ="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=stop&nodeId="+id;
		document.form3.submit();
	 }
	 //启用
	 function startRecord(id){
	 	document.form3.action ="<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=start&nodeId="+id;
		document.form3.submit();
	 }
	 
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
		document.form3.submit();		
	}
	
	 //查看详情
	function showRecord(nid){
		if(nid!=null && nid!="" ){
			document.form3.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=detail&nodeId="+nid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();		
		}
	}
	
	//导入节点
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_nodeInfo.message.selectFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_nodeInfo.message.selectFileType_n81i");
		}else if(confirm('i18n_nodeInfo.message.isImport_n81i')){	
			document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=importXls";
			document.form33.submit();
			document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
		}
	}
	function downloadExample() {
			document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=downloadExample";
			document.form33.submit();
			document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
	}

	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form33.action = "<c:url value='/'/>/nodeGroupManage/nodeManage!executeAction.do?action=emportCurrentXls&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&nodeIpVo="+$("#nodeIpVo").val()+"&nodeNameVo="+$("#nodeNameVo").val();
		document.form33.submit();
		closeDiv();
		document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form33.action = "<c:url value='/'/>/nodeGroupManage/nodeManage!executeAction.do?action=emportAllXls&nodeIpVo="+$("#nodeIpVo").val()+"&nodeNameVo="+$("#nodeNameVo").val();
		document.form33.submit();
		closeDiv();
		document.form33.action = "<%=path%>/nodeGroupManage/nodeManage!executeAction.do?action=query";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}
	//返回
	 function goBack(){
		//window.parent.goBack();
		document.location.href = "<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo&showStopNGroup=${showStopNGroup}";
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
				alert('i18n_nodeInfo.message.inputInfo_n81i');
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
	
	$(function() {
		var isValid = '${isValid}';
		if('0'==isValid) {//无效
			jQuery("#validButton").hide();
			jQuery("#validDo a").attr('href','');
		}
	});
	function ieBrowser(){
		if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		}
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
			//var content = {
		    //    content: '业务系统操作已完成，是否进行下一步操作?',
		    //    buttons: { '下一步': 1, '返回'：0,'取消': -1 },
		    //    buttonsFocus: 0,
		    //    submit: function (v, h, f) {
		    //        if(v == 1) {//执行下一步--用户组
		    //            window.location ="<%=path%>/sysManage/userGroupPerssion.do?action=query";
		    //        }
		    //       if(v == 0){//返回到设置向导页
		    //            window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
		    //        }
		    //        if(v == -1){//返回到设置向导页
		    //            return;
		    //        }
		    //    }
			//};

			//$.jBox(content);
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:6,
		 					packName:'jd'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_nodeInfo.message.warning_n81i", "i18n_nodeInfo.message.hint_n81i", submit,{icon: false});
		}
		$("#info").floatHeaderDiv();
	});
	
	function downloadfile(fileName){
			document.form33.action="<c:url value='/'/>/download/downLoadFile!download.do?file="+fileName;
			document.form33.submit();				
	}
</script>
	</head>
	<body id="nodeBody">
		<div class="middle_list" id="box" style="overflow: hidden;">
			<!--中间部分右边开始-->
			<form name=form33 id="form33" action="<c:url value='nodeManage!queryNodeInfo.do'/>" method="post" style="margin: 0; padding: 0" enctype="multipart/form-data">
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
				<input type="hidden" name="fromWhere" value="${fromWhere }"/>
				<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
				<input type="hidden" name="isValid" value="${isValid }" />
				<div id="divTop">
					<div class="box_2" >
						<div id="validButton" style="display:inline;">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:downloadExample();" value="i18n_nodeInfo.button.downloadExample_n81i"/>
							&nbsp;
						   
						   <input type="button" value="i18n_nodeInfo.text.importXls_n81i" title="i18n_nodeInfo.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
							<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:importXls();" value="i18n_nodeInfo.button.importXls_n81i"/>
							&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_nodeInfo.button.showDiv_n81i"/>
								&nbsp;		
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:addRecord();" value="i18n_nodeInfo.button.add_n81i"/>
							&nbsp;
						</div>	
						<c:if test="${type != 'config'}">				
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:goBack();" value="i18n_nodeInfo.button.back_n81i"/>
						</c:if>
						&nbsp;
					</div>
				</div>
				</form>
				<form name=form3 id="form3" action="<c:url value='nodeManage!queryNodeInfo.do'/>" method="post">
					<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
					<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
					<input type="hidden" name="fromWhere" value="${fromWhere }"/>
					<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
					<input type="hidden" name="isValid" value="${isValid }" />
				<input type="hidden" name="type" value="${type }"/>
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_nodeInfo.text.nodeIp_n81i</font>
						<input  type="text" id="nodeIpVo"
							onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIpVo','suggest3',this.value);"
							name="nodeIpVo" title="i18n_nodeInfo.message.nodeIp_n81i" value="${nodeIpVo}" size="20" />
						<div id='suggest3' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_nodeInfo.text.nodeName_n81i</font>
						<input  type="text" id="nodeNameVo"
							onkeyup="lianxiangkeyup('nodeName','NodeTable','String','nodeNameVo','suggest1',this.value);"
							name="nodeNameVo" title="i18n_nodeInfo.message.nodeName_n81i" value="${nodeNameVo}" size="20" />
						<div id='suggest1' class="ac_results"></div></label><%--
						节点描述
						<input  type="text" id="nodeDescVo"
							onkeyup="lianxiangkeyup('nodeDesc','NodeTable','String','nodeDescVo','suggest2',this.value);"
							name="nodeDescVo" title="请输入节点描述" value="${nodeDescVo}" size="20" />
						<div id='suggest2' class="ac_results"></div>
						--%><img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle" onclick="javascript:qry();" />
					</div>
				<div id="maindiv" style="clear:both;">
				<table border="0" cellpadding="0" cellspacing="0" class="table" align="center" id="info">
					<tr>
						<td class="color_top" width="4%">
							i18n_nodeInfo.text.index_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nodeInfo.text.nodeIp_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nodeInfo.text.nodeName_n81i
						</td>
						<td class="color_top" width="6%">
							i18n_nodeInfo.text.nodeType_n81i
						</td>
						<td class="color_top" width="6%">
							i18n_nodeInfo.text.nodeHight_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nodeInfo.text.systemId_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nodeInfo.text.nodeGroup_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_nodeInfo.text.createTime_n81i
						</td>
						<td class="color_8" width="10%">
							i18n_nodeInfo.text.operation_n81i
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
										<!-- 2、 调用JS，此处远程连接调用JS在/common/remoteConn.jsp中 -->
										<a href="javascript:void(0);"
										   onclick="remoteConn('${node.nodeSystemType }','${node.nodeIp}','${node.nodeType }', this)">
										   ${node.nodeIp}
										</a>
										
									</td>
									<td class="${color }">
										${node.nodeName}
									</td>
									<td class="${color }">
										<c:if test="${node.nodeType==1}">
											<c:if test="${node.networElementType==1}">
												i18n_nodeInfo.message.specialDevice_n81i
											</c:if>
											<c:if test="${node.networElementType==2}">
												i18n_nodeInfo.message.diskArray_n81i
											</c:if>
											<c:if test="${node.networElementType==3}">
												i18n_nodeInfo.message.blockRouter_n81i
											</c:if>
											<c:if test="${node.networElementType==4}">
												i18n_nodeInfo.message.netElements_n81i
											</c:if>
										</c:if>
										<c:choose>
											<c:when test="${node.nodeType==0&&node.specialServerType!=null}">
											i18n_nodeInfo.text.specialServer_n81i
											</c:when>
											<c:when test="${node.nodeType==0}">
											i18n_nodeInfo.text.server_n81i
											</c:when>
										</c:choose>
									</td>
									<td class="${color }">
										${node.nodeUType}U
									</td>
									<td class="${color }">
										${node.systemIdName}
									</td>
									<td class="${color }">
										${node.groupIdName}
									</td>
									<td class="${color }">
										<fmt:formatDate value="${node.nodeCreatetime}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<c:if test="${isValid==0}"><!-- isValid=0 表示无效 -->
										<td class="${color_end }" >
										    <img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<a><font color="gray">i18n_nodeInfo.text.updateInfo_n81i</font></a>
											
											<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<c:if test="${node.nodeState=='0' }"><!-- nodeState=0表示正常 nodeState=1表示有故障 -->
												<a ><font color="gray">i18n_nodeInfo.message.downline_n81i</font></a>
											</c:if>
											<c:if test="${node.nodeState=='1' }">
												<a ><font color="gray">i18n_nodeInfo.message.online_n81i</font></a>
											</c:if>
											<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<a ><font color="gray">i18n_nodeInfo.text.systemInfo_n81i</font></a>
										</td>
									</c:if>
									<c:if test="${isValid!=0}">
										<td class="${color_end }" >
										    <img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<a href="javascript:updateRecord('${node.nodeId}')">i18n_nodeInfo.text.updateInfo_n81i</a>
											
											<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<c:if test="${node.nodeState=='0' }">
												<a href="javascript:stopRecord('${node.nodeId}')"><font color="red">i18n_nodeInfo.message.downline_n81i</font></a>
											</c:if>
											<c:if test="${node.nodeState=='1' }">
												<a href="javascript:startRecord('${node.nodeId}')">i18n_nodeInfo.message.online_n81i</a>
											</c:if>
											<c:if test="${node.nodeType=='0' }">
												<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
												<a href="javascript:showRecord('${node.nodeId}')">i18n_nodeInfo.text.systemInfo_n81i</a>
											</c:if>
										</td>
									</c:if>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" height="35" class="color_6" align="center">
									i18n_nodeInfo.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				</div>
				<c:if test="${!empty nodeList}">
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
									onclick="javascript:emportCurrentXls();" value="i18n_nodeInfo.button.emportCurrentXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_nodeInfo.button.emportAllXls_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_nodeInfo.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>
