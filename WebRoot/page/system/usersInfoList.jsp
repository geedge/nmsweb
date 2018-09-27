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
		<title>i18n_uil.message.title_n81i</title>
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
				alert("i18n_uil.message.success_n81i");
			}else if(msg=='2'){
				alert("i18n_uil.message.faild_n81i");
			}	
		    function addRecord(){
		        document.form11.action = "<%=path%>/sysManage/sysPopedomManage!executeAction.do?action=openAddUserInfo&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			    document.form11.submit();
			}
			function updateRecord(yhid,yhbh){
				document.form11.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=updateUserInfo&yhid="+yhid+"&yhbhpram="+encodeURI(yhbh)+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
				document.form11.submit();
		    }
		    
		    function updatePassword(yhid,yhbh){
				document.form11.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=updateUserPassword&yhid="+yhid;
				document.form11.submit();
		    }
		
			 function qry(){
				document.form11.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryUserInfo";
				document.form11.submit();		
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
						alert('i18n_uil.message.inputInfo_n81i');
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
			
			//导入节点
			function importXls() {
				var myfileVal = document.getElementById("myFile").value;
				if(myfileVal=="") {
					alert("i18n_uil.message.myFile1_n81i");
				}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
					alert("i18n_uil.message.myFile2_n81i");
				}else if(confirm('i18n_uil.message.myFile3_n81i')){
					document.form1.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=importXls";
					document.form1.submit();
				}
			}
			
			function downloadExample() {
				document.form1.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=downloadExample";
				document.form1.submit();
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
			<form name=form1 id="frmArticleType" 
				action="<c:url value='sysPopedomManage!queryUserInfo.do'/>"
				method="post" enctype="multipart/form-data">
					<div class="box_2">
					<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:downloadExample();" value="i18n_uil.button.downloadExample_n81i"/>
							&nbsp;
						
						<input type="button" value="i18n_uil.text.importUser_n81i" title="i18n_uil.text.importUser_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
							<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:importXls();" value="i18n_uil.button.importXls_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:addRecord('${pageNo }','${pageSize }');" value="i18n_uil.button.add_n81i"/>
							&nbsp;
							
					</div>
			</form>
			<form name=form11 action="<c:url value='sysPopedomManage!queryUserInfo.do'/>" method="post">
				<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_uil.text.yhbh_n81i</font>
						<input type="text"  id="yhbh"
							onkeyup="lianxiangkeyup('yhbh','XtYhJbxx','String','yhbh','suggest1',this.value);"
							name=yhbh title="i18n_uil.message.yhbh_n81i" value="${yhbh}" size="20" />
						<div id='suggest1' class="ac_results"></div></label>					
						<label class="divTopText"><font class="selectText">i18n_uil.text.yhmc_n81i</font>
						<input type="text"  id="yhmc"
							onkeyup="lianxiangkeyup('yhmc','XtYhJbxx','String','yhmc','suggest2',this.value);"
							name="yhmc" title="i18n_uil.message.yhmc_n81i" value="${yhmc}" size="20" />
						<div id='suggest2' class="ac_results"></div></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
				</div>
				<div id="maindiv">
					<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
						<tr>
							<td class="color_top" width="4%">
								i18n_uil.text.index_n81i
							</td>
							<td class="color_top" width="8%">
								i18n_uil.text.yhbh_n81i
							</td>
							<td class="color_top" width="8%">
								i18n_uil.text.yhmc_n81i
							</td>
							<td class="color_top" width="12%">
								i18n_uil.text.role_n81i
							</td>
							<c:if test="${session.deptFlag==0 }">
							<td class="color_top" width="8%">
								i18n_uil.text.dept_n81i
							</td>
							</c:if>
							<td class="color_top" width="8%">
								i18n_uil.text.createDate_n81i
							</td>
							<td class="color_top" width="6%">
								i18n_uil.text.state_n81i
							</td>
							<td class="color_8" width="12%">
								i18n_uil.text.option_n81i
							</td>
						</tr>
						<c:set var="index" value="${1}" />
						<c:choose>
							<c:when test="${fn:length(allUserInfo) > 0}">
								<c:forEach items="${allUserInfo}" var="aui" varStatus="vs">
									<input type="hidden" id="yhbh${aui.yhid }"
										name="yhbh${aui.yhid }" value="${aui.yhid}" />
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
											${aui.yhbh}
										</td>
										<td class="${color }">
											${aui.yhmc}
										</td>
										<td class="${color }">
											${aui.userRole}
										</td>
										<c:if test="${session.deptFlag==0 }">
										<td class="${color }">
											${aui.userDept}
										</td>
										</c:if>
										<td class="${color }">
											<fmt:formatDate
													value="${aui.ctime}" type="both" />
										</td>
										<td class="${color }">
											<c:choose>
												<c:when test="${aui.zxbz==0}">
													i18n_uui.message.state0_n81i
												</c:when>
												<c:otherwise>
													<font color="red">i18n_uui.message.state1_n81i</font>
												</c:otherwise>
											</c:choose>
										</td>
										<td class="${color_end }">
											<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<a href="javascript:updateRecord('${aui.yhid}','${aui.yhbh }','${pageNo }','${pageSize }')">i18n_uil.text.updateRecord_n81i</a>
											<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
											<a href="javascript:updatePassword('${aui.yhid}','${aui.yhbh }','${pageNo }','${pageSize }')">i18n_uil.text.updatePassword_n81i</a>
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8" height="35" class="color_6" align="center">
										i18n_uil.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty allUserInfo}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
