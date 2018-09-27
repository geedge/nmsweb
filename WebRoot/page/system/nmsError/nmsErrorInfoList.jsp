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
		<title>i18n_neil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/lockTableHeader.js'/>"></script>
		<script type="text/javascript">
			
			function qry(){
		        document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=query";
			    document.form1.submit();
			}
			
			function checkStateOK(){
				if(countChecked("ids")==0 && countChecked("curid_ids")==0 ){
					alert("i18n_neil.message.checkState0_n81i");
					return null;
				}
				if(isOperation('ids',0)){
					alert('i18n_neil.message.checkState1_n81i');
					return;
				}
		        document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=checkState&state=0";
			    document.form1.submit();
			}
			function checkStateFail(){
				if(countChecked("ids")==0 && countChecked("curid_ids")==0 ){
					alert("i18n_neil.message.checkState0_n81i");
					return null;
				}
				if(isOperation('ids',1)){
					alert('i18n_neil.message.checkState2_n81i');
					return;
				}
		        document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=checkState&state=1";
			    document.form1.submit();
			}
			/*
		    function addRecord(){
		        document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=openAdd";
			    document.form1.submit();
			}
			function updateRecord(id){
				document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=openUpdate&ddid="+id;
				document.form1.submit();
		    }
			*/
			
		    //配置元数据
			function showRecord(ddid){
				document.form1.action = "<%=path%>/nmsError/nmsErrorInfo.do?action=detail&eiId="+ddid;
				document.form1.submit();
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
					
					if(!checkStrNoDian(ajaxValue1)){
						ajaxValue = ajaxValue1;
					}else{
						alert('i18n_neil.message.inputInfo_n81i');
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
				tableHeaderNavigator('I3','info');
			});
			
		</script>
	</head>
	<body>
		<div class="middle_list">
			<form name=form1 id="form1" action="<c:url value='/nmsError/nmsErrorInfo.do?action=query'/>" method="post" >
				<!--中间部分右边开始-->
				<div id="divTop">
					<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_neil.text.errorName_n81i</font>
						<input  type="text" id="errorCodeStr"
							onkeyup="lianxiangkeyup('errorName','NmsErrorCode','String','errorName','suggest1',this.value);"
							name="errorCodeStr" title="i18n_neil.message.errorName_n81i" value="${errorCodeStr}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_neil.text.errorIp_n81i</font>
						<input  type="text" id="errorIp"
							onkeyup="lianxiangkeyup('errortIp','NmsErrorInfo','String','errortIp','suggest2',this.value);"
							name="errorIp" title="i18n_neil.message.errorIp_n81i" value="${errorIp}" size="20" />
						<div id='suggest2' class="ac_results"></div></label>
						<label class="divTopText"><font class="selectText">i18n_neil.text.eiState_n81i</font>
						<select name ="eiState">
							<option value="" selected="selected"  >i18n_neil.message.all_n81i</option>
							<option value="0" ${eiState eq 0 ? "selected" : "" }  >i18n_neil.message.resolved_n81i</option>
							<option value="1" ${eiState eq 1 ? "selected" : "" }  >i18n_neil.message.unresolved_n81i</option>
						</select></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle" onclick="javascript:qry();" />
					</div>
					<div class="box_2">
						<jsp:include page="/include/include.jsp" />
						<input class=btn3_mouseout type="button" 
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:checkStateOK();" value="i18n_neil.button.checkStateOK_n81i"/>
						<!-- 
						<input class=btn3_mouseout type="button" 
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="javascript:checkStateFail();" value="未解决"/>
						 -->
					</div>
				</div>
				<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td class="color_top" width="4%">
							<input type="checkbox" onclick="javascript:checkAll(this);"/>
							i18n_neil.text.index_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.errorName_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_neil.text.eventDesc_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.happendTime_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.errorIp_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.state_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.uploadIp_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_neil.text.newTime_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_neil.text.handleName_n81i
						</td>
						<td class="color_8" width="12%">
							i18n_neil.text.operation_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(objsList) > 0}">
							<c:forEach items="${objsList}" var="objs" varStatus="vs">
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }"  >
										<input type="hidden" name="yxbz${objs[0]}" id="yxbz${objs[0]}" value="${objs[5]}" />
										<input type="checkbox" name="ids" id="pid" value="${objs[0]}" />${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }" >
										${objs[2]}
									</td>
									<td class="${color }" >
										${objs[3]}
									</td>
									<td class="${color }" >
										${objs[4]}
									</td>
									<td class="${color }" >
										${objs[5]}
									</td>
									<td class="${color }">
										<font color="${objs[6]==1 ? "red" : "green"}">
										${objs[6]==0 ? "i18n_neil.message.resolved_n81i" : objs[6]==2?"i18n_neil.message.recovered_n81i":"i18n_neil.message.unresolved_n81i"}
										</font>
									</td>
									<td class="${color }">
										${objs[7]}
									</td>
									<td class="${color }">
										${objs[10]}
									</td>
									<td class="${color }">
										${objs[9]}
									</td>
									<td class="${color_end }">
										<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<a href="javascript:showRecord('${objs[0]}')">i18n_neil.text.showRecord_n81i</a>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" height="35" class="color_6" align="center">
									i18n_neil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				</div>
				<c:if test="${!empty objsList}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
