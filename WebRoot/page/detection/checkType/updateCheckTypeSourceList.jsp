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
		<title>i18n_uctsl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
	</head>

	<script language="javascript" type="text/javascript">	
	function updateCheck(){
		var type;
		$.ajax({
			url:"<%=path%>/detection/metaDataSet.do?action=updateCheck",
			type : "POST",
			async:false,
			data:$('#frmArticleType').serialize(),
			success : function(data) {
				if(data == "exception"){
					type = false;
					alert("i18n_uctsl.message.faild_n81i");
				}else if(data =="success"){
					type = true;
				}else{
					type = false;
					alert(data);
				}
			}
		}); 
		return type;
	}
	
	function add() {
		if(checkForm()&&updateCheck()) {
			jQuery("select[ltype='haveTable']").removeAttr('disabled');
			jQuery("input[type='text'][ltype='haveTable']").removeAttr('disabled');
			document.form3.action="<%=path%>/detection/metaDataSet.do?action=doUpdList";
			document.form3.submit();
		}
	}
	
	//表单检查：字段名：非空，长度小于30，字段名不可重名
	function checkForm() {
		var flag = true;
		//字段名
		var nameArray = new Array();
		jQuery("[id^='filedName_']").each(function(i) {
			var filedName = this.value;
			if(filedName==""||filedName==undefined||filedName==null) {
				//alert("字段名均不可为空");
				$(this).next().html("i18n_uctsl.message.inputFiledName_n81i");
				$(this).focus();
				flag = false;
				return false;//跳出的是each，而不是checkForm
			}else if(!$(this).checkByteLength(30,"i18n_uctsl.text.filedName_n81i")) {//长度不符合
				$(this).focus();
				flag = false;
				return false;
			}else if(checkNum(filedName)){
				//alert("字段名均不能以数字开头");
				$(this).next().html("i18n_uctsl.message.cannotNum_n81i");
				$(this).focus();
				flag = false;
				return false;		
			}else {//进行字段名是否重复验证,如果重复则返回false
			    nameArray[i] = this.value;
			}
		});
		//符合条件：非空，长度，才有判断元素是否重复的意义
		if(flag==true) {
			var names = ","+nameArray.join(",")+",";
			for(var i=0;i<nameArray.length;i++) {
				if(names.replace(nameArray[i]+",","").indexOf(","+nameArray[i]+",")>-1) {//说明有重复元素
					//alert("字段名重复，请修改！");
					$("[id^='filedName_'][value='"+nameArray[i]+"']").next().html("i18n_uctsl.message.filedNameRepeat_n81i");
					$("[id^='filedName_'][value='"+nameArray[i]+"']").focus();
					flag = false;
					break;
				}
			}
		}
		
		if(flag==true) {
			//字段描述非空
			jQuery("[id^='filedComments_']").each(function(i) {
				var filedName = this.value;
				if(filedName==""||filedName==undefined||filedName==null) {
					alert("i18n_uctsl.message.filedComments_n81i");
					$(this).focus();
					flag = false;
					return false;//跳出的是each，而不是checkForm
				}
			});
		}
		
		if(flag==true) {
			//字段类型非空
			jQuery("[id^='filedType_']").each(function(i) {
				var filedName = this.value;
				if(filedName==""||filedName==undefined||filedName==null) {
					alert("i18n_uctsl.message.filedType1_n81i");
					$(this).focus();
					flag = false;
					return false;//跳出的是each，而不是checkForm
				}else if('VARCHAR2'==this.value) {
					var lengthId = "filedTypeLength_" + jQuery(this).attr('id').substr(10);
					var filedLength = jQuery("input[type='text'][id='"+lengthId+"']").val();
					if(filedLength==""||filedLength==undefined||filedLength==null) {
						alert("i18n_uctsl.message.filedLength1_n81i");
						jQuery("input[type='text'][id='"+lengthId+"']").focus();
						flag = false;
						return false;//跳出的是each，而不是checkForm
					}else if(filedLength.replace(/[\d+]/ig,"").length>0) {//文本类型的长度应为数字
						 	alert('i18n_uctsl.message.filedLength2_n81i')
							jQuery("input[type='text'][id='"+lengthId+"']").focus();
							flag = false;
							return false;//跳出的是each，而不是checkForm					
					}
				}
			});
		}
		
		//判断是否选择了分类标识
		if(flag==true) {
			var issnmp =$("#is").val(); 
			if(issnmp!=null && issnmp !=""){
				if(Number(issnmp) < 2){//snmp监控
					var checkedSize = $("input[type='radio'][id^='sortSign_'][value='0']:checked").size();
					var hasSortSign = $("#hasSortSign").val();
					if(hasSortSign!=null&& hasSortSign !="yes"&&Number(checkedSize) == 0){
						alert("i18n_uctsl.message.hasSortSign_n81i");
						flag = false;
						return false;
					}
				}
			}
			
		}
		return flag;
    }
	
	//检查是否以数字开头
	function checkNum(s)       
	{       
   		var cs = /^[0-9]*$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));    
	} 
	
	//无用？
	function rclick(obj){
		if(obj.id=='state1'){//停用此字段时，字段不可用于统计
			document.getElementById('chartState1').checked="checked";
		}else{
			if($("#filedType").val() == "VARCHAR2"){
				$("#chartState1").attr("checked","checked");//1停用
			}
		}
	}
	
	jQuery(function(){
		//if(jQuery("select[id^='filedType_']").val() == "VARCHAR2"){
		//	$("#chartState1").attr("checked","checked");//1停用,文本字段类型不可用于统计，所以当为文本类型时，用于统计选停用??
		//}
		//-- 字段类型选择事件绑定
		/*jQuery("[id^='filedType_']").change(function(){
	 		var idTemp = jQuery(this).attr('id');
	 		var id = idTemp.substr(idTemp.indexOf("_"));
	 		if(jQuery(this).val() == "VARCHAR2"){
	 			jQuery("[id='lengthFt"+id+"']").css("display","inline");
	 		}else{	//字段长度隐藏--数字 时间
	 			jQuery("[id='lengthFt"+id+"']").css("display","none");
	 			jQuery("[id='lengthFt"+id+"']").val("");//数字和时间类型字段，长度为空
	 		}
	 	}); 
	 	*/
	 	//分类标识选择【是】事件绑定:有一个点击是，除了这个元素以为的其它都点击否
	 	jQuery("input[type='radio'][id^='sortSign_'][value='0']").click(function() {
 			var curId = jQuery(this).attr('id');//当前选择元素的ID
	 		jQuery("input[type='radio'][id^='sortSign_'][id!='"+curId+"'][value='1']").each(function(i){
	 			jQuery(this).trigger('click');
	 		});	 	
	 	});
	 	
	 	//选择统计时 判断字段类型
	 	jQuery("input[type='radio'][id^='chartState_'][value='0']").click(function() {
 			var curId = jQuery(this).attr('id');//当前选择元素的ID
 			var id = curId.substr(curId.indexOf("_"));//metaId
	 		if(jQuery("#filedType"+id).val() == "VARCHAR2"){
	 			alert("i18n_uctsl.message.filedType2_n81i");
	 			jQuery("input[type='radio'][id='"+curId+"'][value='1']").trigger('click');
	 			return;
	 		} 	
	 	});
	 	
	 	//不可把统计改为否
	 	//if(jQuery("input[type='radio'][id^='chartState_'][value='0']").attr('checked') == true){
	 	//	alert("inin");
	 	//	alert(jQuery("input[type='radio'][id^='chartState_'][value='1']"));
 		//	jQuery("input[type='radio'][id^='chartState_'][value='1']").attr('readonly','readonly');
	 	//}
	 	$("#tt").floatHeaderDiv();
	 })
	 
	 function fieldTypeChange(obj){
	 		var idTemp = jQuery(obj).attr('id');
	 		var id = idTemp.substr(idTemp.indexOf("_"));
	 		if(jQuery(obj).val() == "VARCHAR2"){
	 			jQuery("[id='lengthFt"+id+"']").css("display","inline");
	 		}else {	//字段长度隐藏--数字 时间
	 			jQuery("[id='lengthFt"+id+"']").css("display","none");
	 			jQuery("[id='filedTypeLength"+id+"']").val("");//数字和时间类型字段，长度为空
	 		}
	 }
	 
	 function readOnlySelect(obj) {
	 	var index = obj.selectedIndex;
	 	obj.onchange = function() {
	 		obj.selectedIndex = index;
	 	} 
	 }
	
	 function goBack(){
		document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=query";
		document.form3.submit();
	 }
    </script>

	<body>
	<div class="middle_list">
		<form name=form3 id="frmArticleType" action="" method="post">
			<input type="hidden" name="typeids" value="${typeids[0]}"/>
			<input type="hidden" name="pageNo" value="${pageNo}" /><!-- 列表当前页数 -->
			<input type="hidden" name="pageSize" value="${pageSize}" /><!-- 列表当前页数 -->
			<input type="hidden" name="isSnmp" value="${isSnmp}" id="is"/>
			<input type="hidden" name="hasSortSign" value="${hasSortSign}" id="hasSortSign"/>
			<c:forEach items="${ids}" var="ids" varStatus="vs">
				<input type="hidden" name="ids" id="ids" value="${ids}"/>
			</c:forEach>
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<table border="0" cellpadding="0" cellspacing="0" class="table" id="tt">
				<tr>
					<td colspan="8" class="color_7" style="font-size:13px;">
						<strong>i18n_uctsl.text.updateMetaData_n81i</strong>
					</td>
				</tr>
				<tr>
					<td width="2%" class="color_top">
						i18n_uctsl.text.index_n81i
					</td>
					<td width="12%" class="color_top">
						i18n_uctsl.text.filedName_n81i
					</td>
					<td width="16%" class="color_top">
						i18n_uctsl.text.filedComments_n81i
					</td>
					<td width="8%" class="color_top">
						i18n_uctsl.text.filedType_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_uctsl.text.isMetaDateState_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_uctsl.text.isChartState_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_uctsl.text.dict_n81i
					</td>
					<td width="6%" class="color_top">
						i18n_uctsl.text.isClassify_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
					<c:when test="${fn:length(metadataList) > 0}">
						<c:forEach items="${metadataList}" var="metadata" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:set var="color_btton" value="color_3"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
								<c:set var="color_btton" value="color_1"/>
							</c:if>
							<tr>
								<td class="${color }">
									${index+(pageNo-1)*pageSize}
									<input type="hidden" value="${metadata.id }" name="metadataList[${index-1}].id" id="id_${metadata.id}">
									<input type="hidden" value="${metadata.id }" name="metadataIds" id="metadataIds">
								</td>
								<td class="${color }">
									<input type="text" name="metadataList[${index-1}].filedName" id="filedName_${metadata.id}" 
										<c:if test="${fn:trim(metadata.filedName)==''}"> value="${metadata.filedComments}" </c:if>   
										<c:if test="${fn:trim(metadata.filedName)!=''}"> value="${metadata.filedName}" </c:if>   
										<c:if test="${isHaveTable=='yes'}"> readonly="readonly" </c:if>									
									/>
								    <font color="red">*</font>
								</td>
								<td class="${color }">
									<input type="text" name="metadataList[${index-1}].filedComments"
										id="filedComments_${metadata.id}" value="${metadata.filedComments }"  />
									<font color="red">*i18n_uctsl.text.showFiledUtil_n81i</font>
								</td>
								<td class="${color }">
									<c:if test="${isHaveTable=='no'}"> 
											<select name="metadataList[${index-1}].filedTypeOnly" id="filedType_${metadata.id}" onchange="javascript:fieldTypeChange(this);">
												<option value="" >
													i18n_uctsl.message.metaDataDefault_n81i
												</option>
												<option value="NUMBER" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'NUMBER'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataNumber_n81i
												</option>
												<option value="DATE" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'DATE'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataDATE_n81i
												</option>
												<option value="VARCHAR2" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'VARCHAR2'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataVARCHAR2_n81i
												</option>
											</select>
									</c:if>		
									<c:if test="${isHaveTable=='yes'}"> 
											<select disabled="disabled" ltype="haveTable" name="metadataList[${index-1}].filedTypeOnly" id="filedType_${metadata.id}" onfocus="javascript:readOnlySelect(this);">
												<option value="" >
													i18n_uctsl.message.metaDataDefault_n81i
												</option>
												<option value="NUMBER" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'NUMBER'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataNumber_n81i
												</option>
												<option value="DATE" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'DATE'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataDATE_n81i
												</option>
												<option value="VARCHAR2" <c:if test="${fn:toUpperCase(metadata.filedTypeOnly) == 'VARCHAR2'}">selected="selected"</c:if>>
													i18n_uctsl.message.metaDataVARCHAR2_n81i
												</option>
											</select>
									</c:if>		
									<font color="red">*</font>
									
									<div align="left" id="lengthFt_${metadata.id}" 
									              <c:if test="${metadata.filedTypeOnly == 'VARCHAR2'}"> style="display:inline;"  </c:if>
									              <c:if test="${metadata.filedTypeOnly != 'VARCHAR2'}"> style="display:none;"  </c:if> >
										i18n_uctsl.message.metaDataLength_n81i
											<input type="text" name="metadataList[${index-1}].filedTypeLength" value="${metadata.filedTypeLength}"
													id="filedTypeLength_${metadata.id}" maxlength="5" size="2" 
													<c:if test="${isHaveTable=='yes'}"> readonly="readonly" </c:if>
													<c:if test="${isHaveTable=='yes'}">ltype="haveTable" disabled="disabled" </c:if>		
													/>
													<font color="red">*</font>
									</div>
									
								</td>
								<td class="${color }">
									<input type="radio" name="metadataList[${index-1}].state"
										id="state_${metadata.id}" onclick="rclick(this)" value="0" <c:if test="${metadata.state == '0' || fn:trim(metadata.state) ==''}">checked="checked"</c:if>/>i18n_uctsl.message.start_n81i 
									<input type="radio" name="metadataList[${index-1}].state"
										id="state_${metadata.id}" onclick="rclick(this)" value="1" <c:if test="${metadata.state == '1' }">checked="checked"</c:if>/>i18n_uctsl.message.stop_n81i
								</td>
								<td class="${color }">
									<input type="radio" name="metadataList[${index-1}].chartState"
										id="chartState_${metadata.id}" value="0" <c:if test="${metadata.chartState == '0' }">checked="checked"</c:if>/>i18n_uctsl.message.yes_n81i
									<input type="radio" name="metadataList[${index-1}].chartState"
										id="chartState_${metadata.id}" value="1" <c:if test="${metadata.chartState == '1' || fn:trim(metadata.chartState) ==''}">checked="checked"</c:if>
										<c:if test="${metadata.chartState == '0' }"> disabled="disabled" </c:if>/>i18n_uctsl.message.no_n81i
								</td>
								<td class="${color }">
									<select name="metadataList[${index-1}].typeId" id="typeId_${metadata.id}">
										<option value="">
											i18n_uctsl.message.metaDataDefault_n81i
										</option>
										<c:choose>
											<c:when test="${fn:length(typeTableList) > 0}">
												<c:forEach items="${typeTableList}"  var="typeTable" >
													<option value="${typeTable.id}" <c:if test="${typeTable.id == metadata.typeId}">selected="selected"</c:if>>
														${typeTable.typeName}
													</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
								<td class="${color }">
									<input type="radio" name="metadataList[${index-1}].sortSign"
										id="sortSign_${metadata.id}" value="0" <c:if test="${metadata.sortSign == '0' }">checked="checked"</c:if>/>i18n_uctsl.message.yes_n81i
									<input type="radio" name="metadataList[${index-1}].sortSign"
										id="sortSign_${metadata.id}" value="1" <c:if test="${metadata.sortSign == '1' || fn:trim(metadata.sortSign) ==''}">checked="checked"</c:if>/>i18n_uctsl.message.no_n81i
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="8" align="center">
								i18n_uctsl.message.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
						<td class="${color_btton}" colspan="8" align="right">
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'" 
									onclick="add()" value="i18n_uctsl.button.submit_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:document.forms['form3'].reset()"
									value="i18n_uctsl.button.reset_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="goBack(${metadata.checkTypeInfo.id })"
									value="i18n_uctsl.button.back_n81i"/>
							&nbsp;
						</td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>

