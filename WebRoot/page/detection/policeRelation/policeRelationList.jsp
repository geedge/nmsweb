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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_prl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
	</head>
		<script language="javascript" type="text/javascript">	
	      var msg = '${MSG}';
	      if(msg=='1'){
			alert("i18n_prl.message.success_n81i");
		    }else if(msg=='2'){
			alert("i18n_prl.message.faild_n81i");
		  }	  

	 	 //查询记录
	 	function qry(){
	 		document.form3.action = "<%=path%>/detection/policeSet.do?action=query";
	 		document.form3.submit();		
	 	}
		  
	  	function checkZF(id){
			if(containSpecial($("#"+id).val())){
				alert('i18n_prl.message.hasSpecialChar_n81i');
				$("#"+id).val('');
				return;
			}
		}
		//添加记录
		 function add(){ 	
			document.form3.action ="<%=path%>/detection/policeSet!executeAction.do?action=openAdd";
			document.form3.submit();
		 } 
		//修改记录
		 function upd(){
		 	if(!isRigthCheck("ids", "edit")){
		 		alert("i18n_prl.message.select_n81i");
		 	}else{
		 		var detectionSetInfoId = $("input:checked").next().val();
		 		var policeRelationId = $("input:checked").val();
				document.form3.action ="<%=path%>/detection/policeSet!executeAction.do?action=openUpdate&detectionSetInfoId="+detectionSetInfoId+"&policeRelationId="+policeRelationId;
				document.form3.submit();
			}
		 }
		 
		function goBack(){
			window.location="<%=path%>/detection/detectionSet.do?action=query&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }'+"&ip="+'${ip}'+"&ctn="+'${ctn}'+"&pIden="+'${pIden}';
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
			if('${setId}'==null||'${setId}'==""){
				$("input[type=hidden][name=pIden]").remove();
				$("input[type=hidden][name=ctn]").remove();
				$("input[type=hidden][name=ip]").remove();
			}
		
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
			
			$("#info").floatHeaderDiv();
		});
		
		
		$(function(){
			var spanObj=$("span[class='STYLE1']");
			for(var i=0;i<spanObj.length;i++){
				var spanVal=$(spanObj[i]).text().trim();;
				console.log(spanVal);
				if(spanVal.length>=25){
					$(spanObj[i]).text(spanVal.substring(0,25)).append("...");
				}else{
					$(spanObj[i]).text(spanVal);
				}
			}
		});
	
	    </script>
	<body>
	<div class="middle_list"  style="overflow: hidden;">
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/policeSet.do?action=query'/>" method="post">
			<input type="hidden" name="setId" value="${setId }"/>
			<input type="hidden" name="pIden" value="${pIden }"/>
			<input type="hidden" name="ctn" value="${ctn }"/>
			<input type="hidden" name="ip" value="${ip }"/>
			<div id="divTop">
			<c:if test="${operator eq 'all'}">
			<div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_prl.text.checkTypeName_n81i</font>
						<select  style="width:140px;" name="ctn" id="checkTypeId">
								<option value="">
									--i18n_prl.message.checkTypeDefault_n81i--
								</option>
								<c:if test="${fn:length(allCheckTypeInfo) > 0}">
									<c:set var="isSchedule0" value="0"/>
									<c:forEach items="${allCheckTypeInfo}" var="checkType">
										<c:if test="${checkType.isSchedule != isSchedule0 }">
											<option style="height: 2px;" disabled="disabled">--------------------</option>
											<c:set var="isSchedule0" value="${checkType.isSchedule}"/>
										</c:if>
										<option value="${checkType.id}" 
										<c:if test="${ctn == checkType.id }">selected="selected"</c:if>>
											${checkType.checkTypeName1}
										</option>
									</c:forEach>
								</c:if>
						</select></label>
						<label class="divTopText"><font class="selectText">i18n_prl.text.processIdenName_n81i </font>
						<input type="text" id="pIden" style="width: 160px" 
								name="pIden"
								title="i18n_prl.message.processIdenName_n81i" 
								value="${pIden}" size="49" onkeyup="checkZF('pIden');"/></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle3" onclick="javascript:qry();" />
							&nbsp;
				</div>
				</c:if>
				<div class="box_2">		
				<c:if test="${operator ne 'all'}">
					<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="add()" value="i18n_prl.button.add_n81i"/>
						&nbsp;
				</c:if>			
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="upd()" value="i18n_prl.button.update_n81i"/>
						&nbsp;
						<c:if test="${operator ne 'all'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_prl.button.back_n81i"/>
				</c:if>		
				</div>
			</div>
			<div id="maindiv">
			<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
				<tr>
					<td width="5%" class="color_top">
						<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_prl.text.index_n81i
					</td>
					<td width="10%" class="color_top" nowrap>
						i18n_prl.text.checkTypeName_n81i
					</td>
					<td width="10%" class="color_top" nowrap>
						i18n_prl.text.processIdenName_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.checkGap_n81i
					</td>
					<td width="12%" class="color_top" nowrap>
						i18n_prl.text.filedName_n81i
					</td>
					<td width="12%" class="color_top" nowrap>
						i18n_prl.text.filedComments_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.policeValue_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.policeUnit_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.policeSymbols_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.policeLevel_n81i
					</td>
					<td width="8%" class="color_top">
						i18n_prl.text.policeEmergent_n81i
					</td>
					<td width="8%" class="color_top" nowrap>
						i18n_prl.text.state_n81i
					</td>
					<td width="20%" class="color_top" nowrap>
						i18n_prl.text.policeShowInfo_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
					<c:when test="${fn:length(dataPoliceRelationList) > 0}">
						<c:forEach items="${dataPoliceRelationList}" var="policeRelation" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
							</c:if>
							<tr>
								<td class="${color }">
									<input type="checkbox" name="ids" id="ids"
											value="${policeRelation.id}" />
											<input type="hidden" value="${policeRelation.detectionSetInfo.id}">
										${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }">
									${policeRelation.detectionSetInfo.checkTypeInfo.checkTypeName1}
								</td>
								<td class="${color }">
									${policeRelation.detectionSetInfo.processIdenName}
								</td>
								<td class="${color }">
									${policeRelation.detectionSetInfo.checkGap}
								</td>	
								<td class="${color }">
									${policeRelation.metadata.filedName}
								</td>
								<td class="${color }">
									${policeRelation.metadata.filedComments}
								</td>
								<td class="${color }">
									${policeRelation.policeValue}
								</td>
								<td class="${color }">
									${policeRelation.policeUnit}
								</td>
								<td class="${color }">
									${policeRelation.policeSymbols}
								</td>
								<td class="${color }">
									${policeRelation.policeLevel}
								</td>
								<td class="${color }">
									<c:if test="${policeRelation.policeEmergent=='0' }">i18n_prl.message.emergent_n81i</c:if>
									<c:if test="${policeRelation.policeEmergent=='1' }">i18n_prl.message.nonEmergent_n81i</c:if>
								</td>
								<td class="${color }">
									<c:if test="${policeRelation.policeState=='0' }">i18n_prl.message.active_n81i</c:if>
									<c:if test="${policeRelation.policeState=='1' }"><font color="red">i18n_prl.message.invalid_n81i</font></c:if>
								</td>
								<td class="${color_end }" title="${policeRelation.policeShowInfo }">
									<span class="STYLE1" style="word-break:break-all; color: ${detecWarning.bgcolor}">
										<%-- <c:if test="${fn:length(policeRelation.policeShowInfo) >= 25}">
											<c:out value="${fn:substring(policeRelation.policeShowInfo,0,25)}..." default=""/>
										</c:if>
										<c:if test="${fn:length(policeRelation.policeShowInfo) < 25}">
											<c:out value="${policeRelation.policeShowInfo}" default=""/>
										</c:if> --%>
										${policeRelation.policeShowInfo}
										
									</span>
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="13" height="20" class="color_6" align="center">
								i18n_prl.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			</div>
			<c:if test="${!empty dataPoliceRelationList}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>
		</div>
	</body>
</html>

