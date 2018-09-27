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
		<title>i18n_jsil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script type="text/javascript">
			var msg = '${MSG}';
		    if(msg=='1'){
				alert("i18n_jsil.message.seccess_n81i");
			}else if(msg=='2'){
				alert("i18n_jsil.message.faild_n81i");
			}	
		    //添加记录
			 function addRecord(){
			  document.form2.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=openAddJsPage&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			  document.form2.submit();
			 }
			 
			 //修改记录
			 function openUpdateRecord(jsbh){
			     document.form2.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=openUpdateJsPage&jsbh="+jsbh+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			     document.form2.submit();
			 	}
			 //配置权限
			 function configJsMkGnRecord(jsbh){
			 	var url = "<%=path%>/sysManage/sSysPopedomManage!execute.do?action=openConfigJsPage&jsbh="+jsbh;
				//窗体名称\路径、宽度、高度、是否全屏0；1
				winObj.init("",url,800,590,0);
				winObj.show();
			  	//window.open("<%=path%>/SysPopedomManage!execute.do?action=openConfigJsPage&jsbh="+jsbh,"","fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,width=800,height=600,left=300,top=200");
			 }
			 function qry(){
					document.form2.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryJsInfo";
					document.form2.submit();		
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
						alert('i18n_jsil.message.inputInfo_n81i');
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
			});
		</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<!--中间部分右边开始-->
			<form name=form2 id="frmArticleType"
				action="<c:url value='sysPopedomManage!queryJsInfo.do'/>"
				method="post">
				<div id="divTop">
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_jsil.text.jsmc_n81i</font>
						<input  id="jsmc"
							onkeyup="lianxiangkeyup('jsmc','XtJsJbxx','String','jsmc','suggest1',this.value);"
							name="jsmc" title="i18n_jsil.message.jsmc_n81i" value="${jsmc}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
					</div>
					<div class="box_2">
					&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:addRecord();" value="i18n_jsil.button.add_n81i"/>
					</div>
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
						<tr>
							<td class="color_top" width="4%">
								i18n_jsil.text.index_n81i
							</td>
							<td class="color_top" width="10%">
								i18n_jsil.text.jsmc_n81i
							</td>
							<td class="color_top" width="15%">
								i18n_jsil.text.jsms_n81i
							</td>
							<td class="color_top" width="10%">
								i18n_jsil.text.state_n81i
							</td>
							<td class="color_8" width="6%">
								i18n_jsil.text.option_n81i
							</td>
						</tr>
						<c:set var="index" value="${1}" />
						<c:choose>
							<c:when test="${fn:length(allJsInfo) > 0}">
							<c:forEach items="${allJsInfo}" var="aji" varStatus="vs">
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
											${aji.jsmc}
										</td>
										<td class="${color }">
											${aji.jsms}
										</td>
										<td class="${color }">
											<c:if test="${aji.zxbz==0}">
								                   i18n_jsil.message.state0_n81i
								            </c:if>
											<c:if test="${aji.zxbz==1}">
												<font color="red">i18n_jsil.message.state1_n81i</font>
											</c:if>
										</td>
										<td class="${color_end }">
											<img src="<c:url value='/images/logo_1.png'/>"
												class="img_middle" />
											&nbsp;
											<a href="javascript:openUpdateRecord('${aji.jsbh}')">i18n_jsil.text.updateInfo_n81i</a>
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" height="35" class="color_6" align="center">
										i18n_jsil.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty allJsInfo}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
