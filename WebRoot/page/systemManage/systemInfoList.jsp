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
		<title>i18n_sysinfolist.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
 		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
	<script language="javascript" type="text/javascript">	
	var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_sysinfolist.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_sysinfolist.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addSystem(){		 	
		document.form3.action ="<%=path%>/sysManage/systemManage!executeAction.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updateSystem(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_sysinfolist.message.selectOne_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/sysManage/systemManage!executeAction.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //停用
	 function stopSystem(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_sysinfolist.message.selectOne_n81i");
	 	}else{//0 启用状态，1 停用状态
	 		if(isOperation("ids", 1)){//当前状态是1，不能停用操作
				alert('i18n_sysinfolist.message.includeStop_n81i');
			}else{
				document.form3.action ="<%=path%>/sysManage/systemManage!executeAction.do?action=stop";
				document.form3.submit();
			}
		}
	 }
	 //启用
	 function startSystem(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_sysinfolist.message.selectOne_n81i");
	 	}else{//0 启用状态，1 停用状态
	 		if(isOperation("ids", 0)){//当前状态是0，不能启用操作
				alert('i18n_sysinfolist.message.includeStart_n81i');
			}else{
				document.form3.action ="<%=path%>/sysManage/systemManage!executeAction.do?action=start";
				document.form3.submit();
			}
		}
	 }
	 //查询记录
	function qry(){
		document.form3.action = "<%=path%>/sysManage/systemManage.do?action=query";
		document.form3.submit();	
	}
	 //查看详情
	 function showRecord(sysid){
		document.form3.action = "<%=path%>/sysManage/systemManage!executeAction.do?action=detail&systemId="+sysid+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
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
			if(!containSpecial(ajaxValue1)){
				ajaxValue = ajaxValue1;
			}else{
				clearTimeout(set_Id);
				alert('i18n_sysinfolist.message.inputInfo_n81i');
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
		 					packNum:1,
		 					packName:'ywxt'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_sysinfolist.message.warning_n81i", "i18n_sysinfolist.message.hint_n81i", submit,{icon: false});
		}
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
				action="<c:url value='/sysManage/systemManage.do?action=query'/>" method="post">
				<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
				<input type="hidden" name="fromWhere" value="${fromWhere }"/>
	
				<div id="divTop">
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_sysinfolist.text.systemName_n81i</font>
						<input  type="text" id="systemName"
							onkeyup="lianxiangkeyup('systemName','SystemTable','String','systemName','suggest1',this.value);"
							name="sysName" title="i18n_sysinfolist.message.systemName_n81i" value="${sysName}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_sysinfolist.text.systemDesc_n81i</font>
						<input  type="text" id="systemDesc"
							onkeyup="lianxiangkeyup('systemDesc','SystemTable','String','systemDesc','suggest2',this.value);"
							name="sysDesc" title="i18n_sysinfolist.message.systemDesc_n81i" value="${sysDesc}" size="20" />
						<div id='suggest2' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>
					<div class="box_2">
						<jsp:include page="/include/include.jsp" />
					</div>
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
						<tr>
							<td class="color_top" width="4%">
								<input type="checkbox" name="checkbox62" value="checkbox"
									onClick="checkAll(this)" />
								i18n_sysinfolist.text.index_n81i
							</td>
							<td class="color_top" width="10%">
								i18n_sysinfolist.text.systemName_n81i
							</td>
							<td class="color_top" width="10%">
								i18n_sysinfolist.text.systemDesc_n81i
							</td>
							<!-- 
							<td class="color_top" width="10%">
								注册IP
							</td>
							<td class="color_top" width="10%">
								注册端口
							</td>
							 -->
							<td class="color_top" width="10%">
								i18n_sysinfolist.text.isMaster_n81i
							</td>
							<td class="color_top" width="10%">
								i18n_sysinfolist.text.createTime_n81i
							</td>
							<td class="color_8" width="6%">
								i18n_sysinfolist.text.isOnline_n81i
							</td>
						</tr>
						<c:set var="index" value="${1}" />
						<c:choose>
							<c:when test="${fn:length(systemList) > 0}">
								<c:forEach items="${systemList}" var="sys" varStatus="vs">
									<input type="hidden" id="yxbz${sys.systemId }"
										name="yxbz${sys.systemId }" value="${sys.systemState}" />
									<c:set var="color" value="color_1"/>
									<c:set var="color_end" value="color_7"/>
									<c:if test="${vs.count%2!=0 }">
										<c:set var="color" value="color_3"/>
										<c:set var="color_end" value="color_6"/>
									</c:if>
									<tr>
										<td class="${color }">
											<input type="checkbox" name="ids" id="ids"
												value="${sys.systemId}" />
											${index+(pageNo-1)*pageSize}
										</td>
										<td class="${color }">
											<a href="javascript:showRecord('${sys.systemId }')">${sys.systemName}</a>
										</td>
										<td class="${color }">
											${sys.systemDesc}
										</td>
										<!-- 
										<td class="${color }">
											${sys.systemIp}
										</td>
										<td class="${color }">
											${sys.systemPort}
										</td>
										 -->
										<td class="${color }">
											<c:if test="${sys.isMaster=='2' }">i18n_sysinfolist.text.slave_n81i</c:if>
											<c:if test="${sys.isMaster=='1' }">i18n_sysinfolist.text.master_n81i</c:if>
										</td>
										<td class="${color }" >
											<fmt:formatDate value="${sys.systemCreatetime}"
												pattern="yyyy-MM-dd HH:mm:ss" />
										</td>
										<td class="${color_end }">
										<!-- 
											<c:if test="${sys.systemState=='0' }">启用</c:if>
											<c:if test="${sys.systemState=='1' }"><font color="red">停用</font></c:if>
										-->
											<c:if test="${sys.systemState=='0' }">i18n_sysinfolist.message.Y_n81i</c:if>
											<c:if test="${sys.systemState=='1' }"><font color="red">i18n_sysinfolist.message.N_n81i</font></c:if>
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" height="35" class="color_6" align="center">
										i18n_sysinfolist.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty systemList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
