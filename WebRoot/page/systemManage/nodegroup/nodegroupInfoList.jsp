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
		<title>i18n_ngil.message.title_n81i</title>
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
		alert("i18n_ngil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_ngil.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function addNodeGroup(){		 	
		document.form3.action ="<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=openAdd";
		document.form3.submit();
	 } 
	//修改记录
	 function updateNodeGroup(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ngil.message.updateNodeGroup_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=openUpdate";
			document.form3.submit();
		}
	 }
	 //停用
	 function stopNodeGroup(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ngil.message.SelectOne_n81i");
	 	}else{//0是失效，1是生效
	 		if(isOperation("ids", 0)){//当前状态是0，不能停用操作
				alert('i18n_ngil.message.includeUnusingNode_n81i');
			}else{
			 	document.form3.action ="<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=stop";
				document.form3.submit();
			}
		}
	 }
	 //启用
	 function startNodeGroup(){
		 if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ngil.message.SelectOne_n81i");
	 	}else{//0是失效，1是生效
	 		if(isOperation("ids", 1)){//当前状态是1，不能启用操作
				alert('i18n_ngil.message.startNodeGroup_n81i');
			}else{
			 	document.form3.action ="<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=start";
				document.form3.submit();
			}
		}
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/sysManage/nodeGroupManage.do?action=query";
		document.form3.submit();		
	}
	 //查看详情
	 function showRecord(id){
		document.form3.action = "<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=detail&nodeGroupId="+id;
		document.form3.submit();		
	}
	//管理节点
	 function nodeMgmt(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ngil.message.updateNodeGroup_n81i");
	 	}else{
			document.form3.action = "<%=path%>/sysManage/nodeGroupManage!executeAction.do?action=nodeMgmt";
			document.form3.submit();
		}		
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
						alert('i18n_ngil.message.inputInfo_n81i');
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
			<form name=form3 id="frmArticleType"
				action="<c:url value='/sysManage/nodeGroupManage.do'/>"
				method="post">
				<input type="hidden" name="position" value="${position }" />
				<div class="box_1">
					i18n_ngil.text.groupName_n81i
					<input  type="text" id="nameVo"
						onkeyup="lianxiangkeyup('groupName','NodegroupTable','String','groupName','suggest1',this.value);"
						name="nameVo" title="i18n_ngil.message.groupName_n81i" value="${nameVo}" size="20" />
					<div id='suggest1' class="ac_results"></div>
					
					<div id='suggest2' class="ac_results"></div>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
				</div>

				<div class="box_2">
					<c:if test="${ADMFlag ne true}">
						<jsp:include page="/include/include.jsp" />
					</c:if>
				</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td class="color_top" width="4%">
							<input type="checkbox" name="checkbox62" value="checkbox"
								onClick="checkAll(this)" ${ADMFlag ? "disabled='disabled'":""}/>
							i18n_ngil.text.index_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_ngil.text.nodeGroup_n81i
						</td>
						<td class="color_top" width="10%">
							i18n_ngil.text.nodeGroupType_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_ngil.text.viewLevel_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_ngil.text.createTime_n81i
						</td>
						<td class="color_8" width="6%">
							i18n_ngil.text.state_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(nodeGroupList) > 0}">
							<c:forEach items="${nodeGroupList}" var="group" varStatus="vs">
								<input type="hidden" id="yxbz${group.groupId }"
								name="yxbz${group.groupId }" value="${group.isValid}" />
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										<input type="checkbox" name="ids" id="ids"
											value="${group.groupId}" ${ADMFlag ? "disabled='disabled'":""}/>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										<a href="javascript:showRecord('${group.groupId }')">${group.groupName}</a>
									</td>
									<td class="${color }">
										<c:if test="${group.groupType==0 }">i18n_ngil.message.nodeGroupType0_n81i</c:if>
										<c:if test="${group.groupType==1 }">i18n_ngil.message.nodeGroupType1</c:if>
									</td>
									<td class="${color }">
										<c:if test="${group.viewLevel==1 }">i18n_ngil.message.publisher_n81i</c:if>
										<c:if test="${group.viewLevel==2 }">i18n_ngil.message.publisherGroup_n81i</c:if>
										<c:if test="${group.viewLevel==3 }">i18n_ngil.message.allInSys_n81i</c:if>
									</td>
									<td class="${color }">
										<fmt:formatDate value="${group.groupCreatetime}"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td class="${color_end }">
										<c:if test="${group.isValid==1 }">i18n_ngil.message.isValid0_n81i</c:if>
										<c:if test="${group.isValid==0 }"><font color="red">i18n_ngil.message.isValid1_n81i</font></c:if>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" height="35" class="color_6" align="center">
									i18n_ngil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${!empty nodeGroupList}">
				<jsp:include page="/common/page.jsp" />
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
