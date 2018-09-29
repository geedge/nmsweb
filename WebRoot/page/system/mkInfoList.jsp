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
		<title>i18n_mil.message.title_n81i</title>
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
		<script src="<c:url value='/js/jquery.js'/>" type="text/javascript"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js' />"></script>

	</head>
	
    <script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_mil.message.seccess_n81i");
	    }else if(msg=='2'){
		alert("i18n_mil.message.faild_n81i");
	  }	  
	  
	  //复选框实现单选效果
	  function radioButton(obj){
		var checks = document.getElementsByTagName("input");
		var selectedCount = countChecked("pid");	
		if(selectedCount > 1){
			for(i = 0 ; i <= checks.length ; i++ ){
				if(checks[i]){
					if(checks[i].name == 'pid'){
						if(checks[i].checked)
						{
							if(checks[i]!=obj){
								checks[i].checked=false;
							}
						}
					}
									
				}
			}
		}
	}  
		
	//添加记录
	
	 function addRecord(){		 	
	 	/*document.form3.action ="<%=path%>/sysManage/sysPopedomManage!execute.do?action=addMkInfo";*/
	 	if(countChecked("pid")==0){
	 		if(confirm("i18n_mil.message.pid_n81i")){
				document.form3.action ="<%=path%>/sysManage/sysPopedomManage!execute.do?action=openAddMkInfo";
				document.form3.submit();
			}else{
				return;
			}
			
		}else if(countChecked("pid")>1){
			alert('i18n_mil.message.selectOne_n81i');
			return ;
		}else{
			document.form3.action ="<%=path%>/sysManage/sysPopedomManage!execute.do?action=openAddMkInfo";
			document.form3.submit();
		}
	 	
	 } 
	
	 
	//修改记录
	 function updateRecord(mkid){
	 	document.form3.action ="<%=path%>/sysManage/sysPopedomManage!execute.do?action=updateMkInfo&mkid="+mkid;
		document.form3.submit();
	 }
	 //查询记录
	 function qry(){
			document.form3.action = "<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryMkInfo";
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
						alert('i18n_mil.message.inputInfo_n81i');
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
     
	
	<body>
		<form name=form3 id="frmArticleType" action="<c:url value='sysPopedomManage!queryMkInfo.do'/>" method="post">
			<input type="hidden" name="position" value="${position }">
			<table width="99%" align="center" align="center" cellpadding="0" cellspacing="1" class="ta_color">
				<div
					style="height: 3px; width: 100%; margin: 0px auto; padding: 0px;"></div>
				
				</tr>				
				<tr>
					<td colspan="7">
						<table width="100%" border="0" cellpadding="0" cellspacing="1" class="ta_color">
							<tr>
								<td colspan="5" class="td_color" height="25px" nowrap class="STYLE1" align="right">
									<img src="<c:url value='/desktop/images/anniu/a_03${userBgColor }.gif'/>" align="center" onclick="javascript:addRecord();"  border="0" />&nbsp;
								</td>
							</tr>							
							<tr align="left">
								
								<td height="20" class="td_color" nowrap>
									<div align="left">
										<span class="STYLE1">&nbsp;&nbsp;i18n_mil.text.mkmc_n81i : </span>
									</div>
								</td>
								
								<td height="20" bgcolor="#FFFFFF" nowrap>
									<div align="left">
										<span class="STYLE1">
											&nbsp;&nbsp;<input type="text" id="mkmc" onkeyup="lianxiangkeyup('mkmc','XtMkJbxx','String','mkmc','suggest1',this.value);"
												name="mkmc" title="i18n_mil.message.mkmc_n81i" value="${mkmc}" size="20" />
										 </span>
										<div id='suggest1' class="ac_results"></div>
									</div>
								</td>	
								
								<td height="20" class="td_color" nowrap>
									<div align="left">
										<span class="STYLE1">&nbsp;&nbsp;i18n_mil.text.mkms_n81i : </span>
									</div>
								</td>
								
								<td height="20" bgcolor="#FFFFFF" nowrap>
									<div align="left">
										<span class="STYLE1">
											&nbsp;&nbsp;<input type="text" id="mkms" onkeyup="lianxiangkeyup('mkms','XtMkJbxx','String','mkms','suggest2',this.value);"
												name="mkms" title="i18n_mil.message.mkms_n81i" value="${mkms}" size="20" /> </span>
										<div id='suggest2' class="ac_results"></div>
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
				<td width="4%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.index_n81i</span>
						</div>
					</td>
				  <td width="10%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.mkid_n81i</span>
						</div>
					</td>
					<td width="20%" class="td_color" nowrap>
						<div align="center">
							<span class="STYLE1">i18n_mil.text.mkmc_n81i</span>
						</div>
					</td>
					<td width="35%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.mkurl_n81i</span>
						</div>
					</td>
					<td width="25%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.mkms_n81i</span>
						</div>
					</td>
					<td width="5%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.state_n81i</span>
						</div>
					</td>
					<td width="5%" class="td_color">
						<div align="center">
							<span class="STYLE1">i18n_mil.text.option_n81i</span>
						</div>
					</td>					
				</tr>
				 <c:set var="index" value="${1}" /> 
        <c:choose>
					<c:when test="${fn:length(allMkInfo) > 0}">
						<c:forEach items="${allMkInfo}" var="ami">
							
							<tr>
								<td bgcolor="#FFFFFF">
									<div align="center" class="STYLE1">	
									<input type="checkbox" name="pid" id="pid" value="${ami.id}" onclick="radioButton(this);"/>									
										<span class="STYLE1">${index}</span>									
										
									</div>
								</td>	
								<td bgcolor="#FFFFFF">
									<div align="center" class="STYLE1">										
										<span class="STYLE1">${ami.id}</span>									
										
									</div>
								</td>								 
								<td bgcolor="#FFFFFF">
									<div align="center">
										<span class="STYLE1">${ami.mkmc}</span>
									</div>
								</td>																
		                        <td bgcolor="#FFFFFF">
									<div align="center">
										<span class="STYLE1">${ami.mkurl}</span>
									</div>
								</td>
								<td bgcolor="#FFFFFF">
									<div align="center">
										<span class="STYLE1">${ami.mkms}</span>
									</div>
								</td>							
                                <td bgcolor="#FFFFFF" nowrap="nowrap">
									<div align="center">									
										<c:if test="${ami.zxbz==0}">
										   <font size=2>i18n_mil.message.state0_n81i</font>
										</c:if>
						                <c:if test="${ami.zxbz==1}">
							            <font color="red" size=2>i18n_mil.message.state1_n81i</font>
						                </c:if>
									</div>
								</td>																						
							    <td bgcolor="#FFFFFF" nowrap="nowrap" >
							      <div align="center">
							       <font size=2>
							       <a href="javascript:updateRecord('${ami.id}')">i18n_mil.text.update_n81i</a>
							       </font>
							      </div>
					            </td >						            									
							</tr>	
							<c:set var="index" value="${index + 1}" />											
						</c:forEach>
					
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7" height="20" align="center" class="color_6">
								i18n_mil.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<c:if test="${!empty allMkInfo}">
					<tr>
						<td height="20" colspan="7" class="td_color">
							<jsp:include page="/common/page.jsp" />
						</td>
					</tr>		
				</c:if>
			</table>
		</form>
				<br/>	
	</body>
</html>

