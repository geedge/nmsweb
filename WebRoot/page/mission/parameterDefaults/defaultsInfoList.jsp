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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dil.message.infoManage_n81i</title>
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>" rel="stylesheet"
			type="text/css" />
		<script src="<c:url value='/js/onmouse${userBgColor }.js'/>" type="text/javascript"></script>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
			
		<script language="javascript" type="text/javascript"src="<c:url value='/js/datepicker/WdatePicker.js'/>"></script>
		<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>
		<script type="text/javascript" src="<%=path%>/templates/js/common.js"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.js' />"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js' />"></script>
		<script type="text/javascript" src="<c:url value='/js/unicodes.js' />"></script>

	</head>
	
    <script language="javascript" type="text/javascript">
    var msg = '${MSG}';
    if(msg=='1'){
		alert("i18n_dil.message.success_n81i");
	}else if(msg=='2'){
		alert("i18n_dil.message.faild_n81i");
	}
      function addRecord(){
        document.form1.action = "<%=path%>/mission/missionParameterDefaults.do?action=add";
		document.form1.submit();
	}
	function viewRecord(id){ 
		document.getElementById("pdid").value = id;
        document.form1.action = "<%=path%>/mission/missionParameterDefaults.do?action=view";
		document.form1.submit();
	}

	 function qry(){
		document.form1.action = "<%=path%>/mission/missionParameterDefaults.do?action=select";
		document.form1.submit();		
	}
	
	
	jQuery(function(){
		$("#systemId").data("nodes",$("#nodeId").clone());
		$("#systemId").bind("change",function(){
			$("#nodeId option[systems]").remove();
			if($(this).val()=="0"){
				$("#systemId").data("nodes").find("option[systems]").clone().appendTo("#nodeId");
				$("#nodeId").val(0);
			}else{
				$("#systemId").data("nodes").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#nodeId");
				$("#nodeId").val(0);
			}
		});
		if($("#systemId").val()!=0){
			$("#nodeId option[systems]").remove();
			$("#systemId").data("nodes").find("option[systems='"+$("#systemId").val()+"']").clone().appendTo("#nodeId");
		}
	});
    </script>
     
	
	<body>
		<form name=form1 id="missionForm" action="<c:url value='/mission/missionParameterDefaults.do?action=select'/>" method="post">
			<input type="hidden" name="missionState.missionType" value="${missionState.missionType }" />
			<input type="hidden" id="pdid" name="parameterDefaults.id" value="${parameterDefaults.id }" />
			
			<table width="99%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="ta_color" >
				<div
					style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;">
					</div>
					<td colspan="8">
					 
						  <table width="100%" border="0" cellspacing="1" cellpadding="0" class="ta_color">
                             <tr>
								<td colspan="15" height="25px" class="td_color" nowrap class="STYLE1" align="right">							
									<img src="<c:url value='/desktop/images/anniu/a_03${userBgColor }.gif'/>" align="center" onclick="javascript:addRecord();"  border="0" />&nbsp;
								</td>
							</tr>
                             <tr align="left">  
                                
								    
								     <td height="20" class="td_color" nowrap >
									   <div align="center">
										<span class="STYLE1">&nbsp;&nbsp;i18n_dil.text.missionName_n81i :  </span>
									   </div>
								     </td>	
								     
								     <td height="20" bgcolor="#FFFFFF" nowrap>
										<div align="left">
											<span class="STYLE1">
												<input type="text" id="missionName" 
<%--												onkeyup="lianxiangkeyup('deptname','TableDepartment','String','deptname','suggest1',this.value);"--%>
												name="missionState.missionName" value="${missionState.missionName }" size="20" /> </span>
											<div id='suggest1' class="ac_results"></div>
										</div>
									</td>
									<td height="20" class="td_color" nowrap >
									   <div align="center">
										<span class="STYLE1">&nbsp;&nbsp;i18n_dil.text.missionType_n81i :  </span>
									   </div>
								     </td>	
								     
								     <td height="20" bgcolor="#FFFFFF" nowrap>
										<div align="left">
											<span class="STYLE1">
												<select name="parameterDefaults.missionType">
													<option value="0">i18n_dil.text.selectDefault_n81i..</option>
													<c:forEach items="${mtList }" var="mt">
														<option value="${mt[0] }" <c:if test="${mt[0] eq parameterDefaults.missionType }" > selected="selected" </c:if> >${mt[1] }</option>
													</c:forEach>
												</select>
												
												</span>
											<div id='suggest1' class="ac_results"></div>
										</div>
									</td>	
									<td height="20" class="td_color" nowrap >
									   <div align="center">
										<span class="STYLE1">&nbsp;&nbsp;i18n_dil.text.system_n81i :  </span>
									   </div>
								     </td>	
								     
								     <td height="20" bgcolor="#FFFFFF" nowrap>
										<div align="left">
											<span class="STYLE1">
												<select id="systemId" name="missionState.systemId">${fn:length(sysList)}
												<option value="0">i18n_dil.text.selectDefault_n81i...</option>
												<c:forEach items="${sysList}" var="sys">
													<option value='${sys[0] }' <c:if test="${missionState.systemId eq sys[0] }"> selected ="selected"</c:if> >${sys[1] }</option>
												</c:forEach>
												</select>
												</span>
											<div id='suggest1' class="ac_results"></div>
										</div>
									</td>	
								<td height="20" class="td_color" nowrap >
									   <div align="center">
										<span class="STYLE1">&nbsp;&nbsp;i18n_dil.text.nodeGroup_n81i :  </span>
									   </div>
								     </td>	
								     
								     <td height="20" bgcolor="#FFFFFF" nowrap>
										<div align="left">
											<span class="STYLE1">
												<select id="nodeId" name="nodeId" >
												<option value="0">i18n_dil.text.selectDefault_n81i..</option>
												<c:forEach items="${ngList}" var="ng" varStatus="ins">
													<option value='${ng[0] }' systems="${ng[2] }" <c:if test="${nodeId eq ng[0] }"> selected ="selected"</c:if> >${ng[1] }</option>
												</c:forEach>
												</select>
												</select>
												</span>
											</span>
											<div id='suggest1' class="ac_results"></div>
										</div>
									</td>
									  <td height="20" class="td_color">
									  <div align="center">
									  <img src="<c:url value='/desktop/images/anniu/anniu_3${userBgColor }.png'/>" align="center" onclick="javascript:qry();"  border="0" />
									  </div>
								    </td>
							 </tr>
						</table>
					</td>
				</tr>
		
				<tr>
					<td width="5%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_dil.text.index_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_dil.text.opration_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_dil.text.missionName_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_dil.text.missionType1_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_dil.text.missionType_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_dil.text.nodeGroup_n81i</span>
						</div>
					</td>
				</tr>
				 <c:set var="index" value="${1+(pageNo-1)*page.pageSize}" />
           <c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="pd">
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="center" class="STYLE1">
										<span class="STYLE1">${index}</span>
									</div>
								</td>	
								<td bgcolor="#FFFFFF">
									<div align="center" class="STYLE1">
										 <font size=2>
										<a href="javascript:viewRecord('${pd[0] }')">i18n_dil.text.viewRecord_n81i</a>
										</font>
									</div>
								</td>								
								<td bgcolor="#FFFFFF">
									<div align="center">
										<span class="STYLE1">${pd[1] }
										</span>
									</div>
								</td>       														                             																				
							    <td bgcolor="#FFFFFF"nowrap="nowrap" >
							      <div align="center"class="STYLE1">
							     	<c:forEach items="${mtList}" var="mt" varStatus="ins">
							     	<c:if test="${pd[2] eq mt[0] }">${mt[1] }</c:if>
									</c:forEach>
					            </td >				
					            <td bgcolor="#FFFFFF"nowrap="nowrap" >
							      <div align="center"class="STYLE1">
							       ${pd[4] }
							      </div>
					            </td >	
					             <td bgcolor="#FFFFFF"nowrap="nowrap" >
							      <div align="center"class="STYLE1">
							        ${pd[6] }
							      </div>
					            </td >	
							</tr>		
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
       
						<tr>
							<td colspan="8" height="20" align="center" class="color_6">
								i18n_dil.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				
				
				<tr>
					<td height="20" colspan="8" class="td_color">
						<jsp:include page="/common/page.jsp" /></td>
				</tr>
				
			</table>
		</form>
		<br/><br/>
	</body>
</html>