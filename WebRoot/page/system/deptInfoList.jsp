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
		<title>i18n_deptil.message.title_n81i</title>
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
				alert("i18n_deptil.message.success_n81i");
			}else if(msg=='2'){
				alert("i18n_deptil.message.faild_n81i");
			}	
		      function addRecord(){
		        document.form1.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=openAddDeptInfo";
				document.form1.submit();
			}
			function updateRecord(deptid){
				document.form1.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=openUpdateDeptPage&deptid="+deptid;
				document.form1.submit();
		    }
		
			 function qry(){
				document.form1.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryDeptInfo";
				document.form1.submit();		
			}
			
			
			jQuery(function(){
				
				var ajaxProperties = "deptname";
				var ajaxTableName =  "TableDepartment";
				var ajaxType =  "String";
				
				jQuery.post("<%=path%>/sysManage/sysPopedomManage!queryInfoForAjax.do",
				{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType},function(data){
					var lianxiangList = new Array(jQuery(data).find("deptname").size());
					var i = 0;
					
					jQuery(data).find("filed").each(function(){
						if(jQuery(this).find("deptname").is("deptname")){
							var lianxiang = jQuery(this).find("deptname").text();
							lianxiangList[i]=new Array('',lianxiang,getPY_str(lianxiang),'');
							i++;
						}
						
					});
					
					jQuery("#deptname").suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#suggest"});
				});
				
				
			});
			
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
						alert('i18n_deptil.message.inputInfo_n81i');
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
		</script>
	</head>
	<body>
		<div class="middle_list">
			<!--中间部分右边开始-->
			<form name=form1 id="frmArticleType"
				action="<c:url value='sysPopedomManage!queryDeptInfo.do'/>"
				method="post">
				<input type="hidden" name="position" value="${position }" />
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_deptil.text.deptname_n81i</font>
					<input  id="deptname"
						onkeyup="lianxiangkeyup('deptname','TableDepartment','String','deptname','suggest1',this.value);"
						name="deptname" title="i18n_deptil.message.deptname_n81i" value="${deptname}"/>
					<div id='suggest1' class="ac_results"></div></label>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
					<button class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:addRecord();">
						i18n_deptil.button.add_n81i
					</button>
				</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td class="color_top" width="4%">
							i18n_deptil.text.index_n81i
						</td>
						<td class="color_top" width="15%">
							i18n_deptil.text.deptname_n81i
						</td>
						<td class="color_top" width="15%">
							i18n_deptil.text.deptLevel_n81i
						</td>
						<td class="color_8" width="6%">
							i18n_deptil.text.option_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(listDeptInfo) > 0}">
							<c:forEach items="${listDeptInfo}" var="aui" varStatus="vs">
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
										${aui.deptname}
									</td>
									<td class="${color }">
										<c:if test="${aui.deptlayer==0}">i18n_deptil.message.deptlayer0_n81i </c:if>
										<c:if test="${aui.deptlayer==1}">i18n_deptil.message.deptlayer1_n81i </c:if>
										<c:if test="${aui.deptlayer==2}">i18n_deptil.message.deptlayer2_n81i </c:if>
									</td>
									<td class="${color_end }">
										<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<a href="javascript:updateRecord('${aui.deptid}')">i18n_deptil.text.update_n81i</a>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" height="35" class="color_6" align="center">
									i18n_deptil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${!empty listDeptInfo}">
					<jsp:include page="/common/page.jsp" />
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
