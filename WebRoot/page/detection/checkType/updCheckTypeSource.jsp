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
		<title>i18n_ucts.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/dtree/js/dtree_checkbox.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
            src="<c:url value='/js/WebCalendar.js' />"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   	var flag = false;
	function add(){
		if(document.getElementById('lengthFt').style.display=='block'){
			var legthValue = document.getElementById('filedTypeLength');
			if(legthValue.value==""){
				alert("i18n_ucts.message.inputFiledTypeLength_n81i");
				legthValue.focus();
				return;
			}
		}
		if($id("filedName","","i18n_ucts.message.filedName_n81i") && $id("filedType","","i18n_ucts.message.filedType_n81i") && $id("filedComments","","i18n_ucts.message.filedComments_n81i"))
	    {
	    	var oid = document.getElementById("oid");
	    	if(oid!=undefined && oid!=null) {//snmp监控，进行oid非空检查
	    	 	if(!$id("oid","","OID")) {
	    	 		return;
	    	 	}
	    	}
	    	if(document.getElementById('filedType').value=='VARCHAR2'){
	    	 	if($id("filedTypeLength","","i18n_ucts.message.filedTypeLength_n81i") && $id("filedTypeLength","sz","i18n_ucts.message.filedTypeLength_n81i")){
		    	 	document.form1.action="<%=path%>/detection/metaDataSet.do?action=doUpd";
					document.form1.submit();	
	    	 	}
	    	}else{
	    	 	document.form1.action="<%=path%>/detection/metaDataSet.do?action=doUpd";
				document.form1.submit();
	    	 }
				
		} 
	}
	
	function goBack(tid){
		window.location="<%=path%>/detection/metaDataSet.do?action=query&typeids="+tid;
	}
	
	function rclick(obj){
		if(obj.id=='state1'){//停用
			document.getElementById('chartState1').checked="checked";
		}else{
			if($("#filedType").val() == "VARCHAR2"){
				$("#chartState1").attr("checked","checked");//1停用
			}
		}
	}
	
	jQuery(function(){
		if(jQuery("#filedType").val() == "VARCHAR2"){
			jQuery("td[id=lengthFt]").show();
			jQuery("td[id=viewLevel0]").attr('colspan',1);
			$("#chartState1").attr("checked","checked");//1停用
		}else{
			jQuery("td[id=lengthFt]").hide();
			jQuery("td[id=viewLevel0]").attr('colspan',3);
		}
		//-- 字段类型选择事件绑定
	 	jQuery("#filedType").change(function(){
	 		if(jQuery(this).val() == "VARCHAR2"){
	 			jQuery("td[id=lengthFt]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1);
	 			flag = true;
	 			$("#chartState1").attr("checked","checked");//1停用
	 		}else{	//字段长度隐藏--数字 时间
	 			jQuery("td[id=lengthFt]").hide();
	 			jQuery("#filedTypeLength").val("");
	 			jQuery("td[id=viewLevel0]").attr('colspan',3);
	 			flag = false;
	 			
	 			//判断是启用还是停用
	 			if($("#state1").attr("checked")==true){//停用
	 				
	 				$("#chartState1").attr("checked","checked");//1停用
	 			}
	 		}
	 	});
	})
	</script>
	
	<body>
	<div class="middle_list" >
		<form action="" name="form1" method="post">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" value="${metadata.checkTypeInfo.id }" name="typeids"/>
			<input type="hidden" value="${metadata.id }" name="metadata.id">
			<input type="hidden" value="${mState }" name="mState">
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_ucts.text.updateMetaData_n81i</strong>
						</td>
					</tr>
						<tr>
							<td class="color_1" width="15%" align="right">
								i18n_ucts.text.checkType_n81i
							</td>
							<td class="color_3" width="35%" align="left">
								<input type="hidden" name="checkTypeInfo.id"
										id="checkTypeId" value="${metadata.checkTypeInfo.id }"/>
								<input type="text" name="checkTypeInfo.checkTypeName"
										id="checkTypeName" value="${metadata.checkTypeInfo.checkTypeName }" readonly />
								<font color="red">*</font>
							</td>
							<td class="color_1" width="15%" align="right">
								i18n_ucts.text.tableName_n81i
							</td>
							<td class="color_3" width="35%" align="left">
								<input type="text" name="metadata.tableName"
										id="tableName" value="${metadata.tableName }" readonly/>
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="color_1" align="right">
								i18n_ucts.message.filedName_n81i
							</td>
							<td class="color_3" align="left">
								<input type="text" name="metadata.filedName"
										id="filedName" value="${metadata.filedName }"/>
								<font color="red">*</font>
							</td>
							<td class="color_1" align="right">
								i18n_ucts.message.filedComments_n81i
							</td>
							<td class="color_3" align="left">
								<input type="text" name="metadata.filedComments"
										id="filedComments" value="${metadata.filedComments }" />
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="color_1" align="right">
								i18n_ucts.message.filedType_n81i
							</td>
							<td class="color_6" align="left" id="viewLevel0">
								<select name="filedType" id="filedType">
										<option value="">
											i18n_ucts.message.filedTypeDefault_n81i
										</option>
										<option value="Number" <c:if test="${metadata.filedType == 'Number'}">selected="selected"</c:if>>
											i18n_ucts.message.filedTypeNumber_n81i
										</option>
										<option value="DATE" <c:if test="${metadata.filedType == 'DATE'}">selected="selected"</c:if>>
											i18n_ucts.message.filedTypeDATE_n81i
										</option>
										<option value="VARCHAR2" <c:if test="${filedType == 'VARCHAR2'}">selected="selected"</c:if>>
											i18n_ucts.message.filedTypeVARCHAR2_n81i
										</option>
									</select>
								<font color="red">*</font>
							</td>
							<td class="color_1" align="right" id="lengthFt">
								i18n_ucts.message.filedTypeLength_n81i
							</td>
							<td class="color_3" align="left" id="lengthFt">
								<input type="text" name="filedTypeLength" value="${filedTypeLength}"
										id="filedTypeLength" />
										<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="color_1" align="right">
								i18n_ucts.text.isState_n81i
							</td>
							<td nowrap="nowrap"  class="color_6" align="left">
								<input type="radio" name="metadata.state"
										id="state" onclick="rclick(this)" value="0" <c:if test="${metadata.state == '0' }">checked="checked"</c:if>/>启用 
								<input type="radio" name="metadata.state"
										id="state1" onclick="rclick(this)" value="1" <c:if test="${metadata.state == '1' }">checked="checked"</c:if>/>停用 
							</td>
							<td class="color_1" align="right">
								i18n_ucts.text.isChartState_n81i
							</td>
							<td nowrap="nowrap"  class="color_6" align="left">
								<input type="radio" name="metadata.chartState"
										id="chartState0" value="0" <c:if test="${metadata.chartState == '0' }">checked="checked"</c:if>/>是
								<input type="radio" name="metadata.chartState"
										id="chartState1" value="1" <c:if test="${metadata.chartState == '1' }">checked="checked"</c:if>/>否
							</td>
						</tr>
						<tr>
							<td class="color_1" align="right">
								i18n_ucts.text.showNum_n81i
							</td>
							<td class="color_3" align="left" 
							      <c:if test="${metadata.checkTypeInfo.isSnmp == 2||metadata.checkTypeInfo.isSnmp eq null}">colspan="3"</c:if>  >
								<input type="text" name="metadata.showNum"
										id="showNum" value="${metadata.showNum }" />
							</td>
							<c:if test="${metadata.checkTypeInfo.isSnmp == 1}"><!-- 是SNMP监控 -->
								<td class="color_1" align="right">
									OID
								</td>
								<td class="color_3" align="left" >
									<input type="text" name="metadata.oid"
											id="oid" value="${metadata.oid}"/>
									<font color="red">*</font>
						   </c:if>
						</tr>
						<tr>
							<td class="color_7" colspan="4" align="right">
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'" 
										onclick="add()" value="i18n_ucts.button.submit_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="javascript:document.forms['form1'].reset()"
										value="i18n_ucts.button.reset_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="goBack(${metadata.checkTypeInfo.id })"
										value="i18n_ucts.button.back_n81i"/>
								&nbsp;
							</td>
						</tr>
					</table>
		</form>
		</div>
	</body>
</html>
