<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
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
		<title>i18n_upr.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
            src="<c:url value='/js/WebCalendar.js' />"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
	function upd(){
	    if($id("policeValue","","i18n_upr.message.policeValue_n81i")
	    	&&$id("policeUnit","","i18n_upr.message.policeUnit_n81i")
	    	&& $id("policeSymbols","xz","i18n_upr.message.policeSymbols_n81i")
	    	&& $id("policeLevel","sz","i18n_upr.message.policeLevel_n81i")){
	    	var poliMsg = $("#policeShowInfo").val();
	    	var pll = $("#policeLevel").val();
	    	
	    	var selEmergVal = jQuery('#policeEmergent').val();
	    	var boo = true;
	    	if(selEmergVal==1) {//非紧急才需要判断级别是否为1-5
		    	if(pll >0 && pll<=5){
		    		boo = true;
		    	}else{
		    		$("#pl").text("i18n_upr.message.policeLevelInfo_n81i");
		    		return;
		    	}
	    	}
	    	
	    	if(boo){
		    	if(poliMsg!=""){
		    		if(poliMsg.length >200){
		    			$("#Msg").text("i18n_upr.message.inputInfo_n81i");
		    			return;
		    		}else{
		    			document.Mkform.action="<%=path%>/detection/policeSet.do?action=doUpdate";
						document.Mkform.submit();	
		    		}
		    	}else{
		    		document.Mkform.action="<%=path%>/detection/policeSet.do?action=doUpdate";
					document.Mkform.submit();	
		    	}
		    }
		}	
	}
	
	function goBack(){
		document.Mkform.action="<%=path%>/detection/policeSet!executeAction.do?action=query";
		document.Mkform.submit();	
	}
	
	jQuery(function(){
	 	var filedType = $("#metadaFType").val();
	 	if(filedType.indexOf("VARCHAR2")>=0){
	 		$("#policeSymbols").find("option[class='notTxt']").remove();
	 	}else{
	 		$("#policeSymbols").find("option[class='isTxt']").remove();
	 	}
	 	
	 	initEmergent();//初始化级别的显示与隐藏
	 	initMarker();//初始化过滤标识及对应字段的显示与隐藏
	})
	
	function initEmergent() {
		var selEmergVal = jQuery('#policeEmergent').val();
		if(selEmergVal=='1') {
			jQuery('#levelTitleTd').show();
			jQuery('#levelValTd').show();
			jQuery('#styleChgTd').attr('colspan','1');
		}else {
			jQuery('#levelTitleTd').hide();
			jQuery('#levelValTd').hide();
			jQuery('#styleChgTd').attr('colspan','3');
			jQuery('#policeLevel').val('0');
		}
	}
	
	function emergentChange() {
		var selEmergVal = jQuery('#policeEmergent').val();
		if(selEmergVal=='1') {
			jQuery('#levelTitleTd').show();
			jQuery('#levelValTd').show();
			jQuery('#styleChgTd').attr('colspan','1');
			jQuery('#policeLevel').val('');
		}else {
			jQuery('#levelTitleTd').hide();
			jQuery('#levelValTd').hide();
			jQuery('#styleChgTd').attr('colspan','3');
			jQuery('#policeLevel').val('0');
		}
	
	}
	
	function initMarker() {
		var selMarkerVal = jQuery('#markerFiledId').val();
		if(selMarkerVal=='') {//未选择字段
			jQuery('#markerTitleTd').hide();
			jQuery('#markerValTd').hide();
			jQuery('#markerStyleChgTd').attr('colspan','3');
		}else {//选择了字段
			jQuery('#markerTitleTd').show();
			jQuery('#markerValTd').show();
			jQuery('#markerStyleChgTd').attr('colspan','1');
		}
	}
	
	function markerFiledChange() {
		var selMarkerVal = jQuery('#markerFiledId').val();
		if(selMarkerVal=='') {//未选择字段
			jQuery('#markerTitleTd').hide();
			jQuery('#markerValTd').hide();
			jQuery('#markerStyleChgTd').attr('colspan','3');
		}else {//选择了字段
			jQuery('#markerTitleTd').show();
			jQuery('#markerValTd').show();
			jQuery('#markerStyleChgTd').attr('colspan','1');
		}
		jQuery('#marker').val('');
	
	}
</script>
	<body>
		<div class="middle_list" >
			<form action="" name="Mkform" method="post">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" value="${policeRelationId}" name="policeRelationId"/>
				<input type="hidden" value="${setId}" name="setId"/>
				<input type="hidden" value="${detectionSetInfoId}" name="detectionSetInfoId"/>
				<input type="hidden" value="${ip}" name="ip"/>
				<input type="hidden" value="${ctn}" name="ctn"/>
				<input type="hidden" value="${pIden}" name="pIden"/>
				<input type="hidden" value="${dataPoliceRelation.id}" name="dataPoliceRelation.id"/>
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_upr.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="20%" align="right">
							i18n_upr.text.metadata_n81i
						</td>
						<td class="color_6" width="30%" align="left" >
							<c:if test="${fn:length(allMetadata) > 0}">
							<c:forEach items="${allMetadata}" var="metadata">
								<c:if test="${metadata.id == dataPoliceRelation.metadata.id }">
									<input type="text" name="filedName" readonly="readonly" value="${metadata.filedComments}"/>
									<input type="hidden" id="metadaFType" value="${metadata.filedType }" />
								</c:if> 
							</c:forEach>
							</c:if>								
							<input type="hidden"  name="dataPoliceRelation.metadata.id" id="metadaId" value="${dataPoliceRelation.metadata.id }" />
							
							<font color="red">*</font>
						 </td>
						 <td class="color_1" width="15%" align="right">
								i18n_upr.text.policeState_n81i
							</td>
							<td class="color_6" width="35%" align="left">
								<input type="radio" name="dataPoliceRelation.policeState"
										id="policeState1" value="0" <c:if test="${dataPoliceRelation.policeState == '0' }">checked="checked"</c:if>/>i18n_upr.message.active_n81i 
								<input type="radio" name="dataPoliceRelation.policeState"
										id="policeState" value="1" <c:if test="${dataPoliceRelation.policeState == '1' }">checked="checked"</c:if>/>i18n_upr.message.invalid_n81i
							</td>
							
						</tr>
						<tr>
						   <td class="color_1" width="20%" align="right">
								i18n_upr.text.markerFiled_n81i
							</td>
							<td class="color_6" width="30%" align="left" colspan="3" id="markerStyleChgTd">
								<select name="dataPoliceRelation.markerFiledId" id="markerFiledId" onchange="markerFiledChange();" style="width: 153px;">
										<option value="" id="qxz">
											i18n_upr.message.markerFiledDefault_n81i
										</option>
										<c:if test="${fn:length(allMetadata) > 0}">
											<c:forEach items="${allMetadata}" var="metadata">
												<option value="${metadata.id}" id="${metadata.filedType}"  
												<c:if test="${dataPoliceRelation.markerFiledId == metadata.id}">selected="selected"</c:if> >
													${metadata.filedComments}
												</option>
											</c:forEach>
										</c:if>
									</select>									
							</td>
							<td class="color_1" width="15%" align="right" style="display: none;" id="markerTitleTd">
								i18n_upr.text.marker_n81i
							</td>
							<td class="color_6" width="35%" align="left" colspan="1" style="display: none;" id="markerValTd">
								<input type="text" name="dataPoliceRelation.marker"
										id="marker" value="${dataPoliceRelation.marker}"/><font color="red" >i18n_upr.message.marker_n81i</font>
							</td>
						</tr>
						<tr>
						    <td class="color_1" align="right">
								i18n_upr.text.policeEmergent_n81i
							</td>
							<td class="color_3" align="left" id="styleChgTd">
								<select name="dataPoliceRelation.policeEmergent"  id="policeEmergent"  onchange="emergentChange();" style="width: 153px;">
								
										<option value="0" <c:if test="${dataPoliceRelation.policeEmergent == 0}">selected="selected"</c:if> >
											i18n_upr.message.emergent_n81i
										</option>
										<option value="1"  <c:if test="${dataPoliceRelation.policeEmergent == 1}">selected="selected"</c:if>>
											i18n_upr.message.nonEmergent_n81i
										</option>
								</select>
								<font color="red">*</font>
							</td>
							<td class="color_1" align="right" id="levelTitleTd" >
								i18n_upr.text.policeLevel_n81i
							</td>
							<td class="color_3" align="left"  id="levelValTd">
								<input type="text" name="dataPoliceRelation.policeLevel"
										id="policeLevel" value="${dataPoliceRelation.policeLevel}"/>
								<font id="pl" color="red">*i18n_upr.message.policeLevelInfo_n81i</font>
							</td>
						</tr>
						<tr id = "pv">
							<td class="color_1" align="right">
								i18n_upr.text.policeValue_n81i
							</td>
							<td class="color_3" align="left">
								<input type="text" name="dataPoliceRelation.policeValue"
										id="policeValue" value="${dataPoliceRelation.policeValue}"/>
								<font color="red">*</font>	
							</td>
							<td class="color_1" align="right">
								i18n_upr.text.policeUnit_n81i
							</td>
							<td class="color_3" align="left">
								<input type="text" name="dataPoliceRelation.policeUnit"
										id="policeUnit" value="${dataPoliceRelation.policeUnit}"/>
										<font color="red">*</font>
							</td>
						</tr>
						
						<tr>
						    <td class="color_1" align="right">
								i18n_upr.message.policeSymbols_n81i
							</td>
							<td class="color_3" align="left">
								<select name="dataPoliceRelation.policeSymbols" id="policeSymbols" style="width: 153px;">
										<option value="">
											i18n_upr.message.markerFiledDefault_n81i
										</option>
										<option value=">" <c:if test="${dataPoliceRelation.policeSymbols == '>' }">selected="selected"</c:if> class="notTxt">
											&gt;
										</option>
										<option value="<" <c:if test="${dataPoliceRelation.policeSymbols == '<' }"> selected="selected" </c:if> class="notTxt">
											&lt;
										</option>
										<option value=">=" <c:if test="${dataPoliceRelation.policeSymbols == '>=' }">selected="selected"</c:if> class="notTxt">
											&gt;=
										</option>
										<option value="<=" <c:if test="${dataPoliceRelation.policeSymbols == '<=' }">selected="selected"</c:if> class="notTxt">
											&lt;=
										</option>
										<option value="=" <c:if test="${dataPoliceRelation.policeSymbols == '=' }">selected="selected"</c:if> class="notTxt">
											=
										</option>
										<option value="equals" <c:if test="${dataPoliceRelation.policeSymbols == 'equals' }">selected="selected"</c:if> class="isTxt">
											equals
										</option>
										<option value="include" <c:if test="${dataPoliceRelation.policeSymbols == 'include' }">selected="selected"</c:if>class="isTxt">
											include
										</option>
										<option value="exclude" <c:if test="${dataPoliceRelation.policeSymbols == 'exclude' }">selected="selected"</c:if>class="isTxt">
											exclude
										</option>
									</select>
									
									<font color="red">*</font>
							</td>
							<td class="color_1"  align="right" valign="top" nowrap="nowrap">
								i18n_upr.text.policeShowInfo_n81i
							</td>
							<td class="color_3"  align="left" valign="top">
								<textarea rows="3" cols="40" name="dataPoliceRelation.policeShowInfo" id="policeShowInfo">${dataPoliceRelation.policeShowInfo}</textarea>
								<div><font color="red" id="Msg">i18n_upr.message.policeShowInfo_n81i</font></div>
							</td>
						</tr>
						<tr>
							<td class="color_7" colspan="4" align="right">
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'" 
										onclick="upd()" value="i18n_upr.button.submit_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="javascript:document.forms['Mkform'].reset()" value="i18n_upr.button.reset_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="goBack()" value="i18n_upr.button.back_n81i"/>
								&nbsp;
							</td>
						</tr>
					</table>
				</form>
			</div>
	</body>
</html>
