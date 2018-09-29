<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_udti.message.title_n81i</title>
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
        <script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
    $(function(){
    	 
    });
    
    function trim(id) {
    	jQuery("#"+id).val(jQuery.trim(jQuery("#"+id).val()));
    } 
      
	function update(){
		//去空格
		trim("deviceTypeCode");//设备型号
		trim("maxDeviceNum");//最大叠加数
		trim("showIndex");//编号
		trim("nameFormat");//名称格式
		trim("statusValue");//异常比较值
	
	    if($id("deviceRandCode","xz","i18n_udti.text.deviceRandCode_n81i")&& $id("deviceTypeCode","","i18n_udti.text.deviceTypeCode_n81i") && hasDevTypeCode()){
		    
		    //如果最大叠加数非空，则判断是否为数字
	    	var maxDeviceNum=jQuery.trim(document.getElementById('maxDeviceNum').value);
			if(maxDeviceNum!=''&& maxDeviceNum.replace(/[\d+]/ig,"").length>0){
	        	$("#maxDeviceNum").next().html('i18n_udti.message.maxDeviceNum_n81i');
		        return;
	        }else {
	        	$("#maxDeviceNum").next().html('');
	        }
		    
		    var parCode = jQuery("select[id='pid'] option:selected").val();	
			if(isNotBlank(parCode)){
				var name=document.getElementById('showIndex').value;
				if(name=='' ){
				 	$("#showIndex").next().html('i18n_udti.message.showIndex1_n81i');
			        return;
		        }else if(name.replace(/[\d+]/ig,"").length>0){
		        	$("#showIndex").next().html('i18n_udti.message.showIndex2_n81i');
			        return;
		        }else {
		        	$("#showIndex").next().html('*');
		        }
			}
			
		    var myfileVal = document.getElementById("figureFill").value;
			if(myfileVal!="") {//修改图片后，进行替换
				var allowExt = ".png  , .bmp  , .jpg  , .gif";
				var fileExt = myfileVal.substr(myfileVal.lastIndexOf(".")).toLowerCase();
				if(allowExt.indexOf(fileExt)==-1){
					$("#figureFill").next().html('i18n_udti.message.figureFill_n81i：'+allowExt);
					return;
				}else {
					//$("#figureFill").next().html('*');
				}
			}
			document.Brandform.action="<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=updateDevType";
			document.Brandform.submit();
			
			jQuery("#addButton").attr("disabled","true");  
			jQuery("#resetButton").attr("disabled","true");  
			jQuery("#backButton").attr("disabled","true");
        }	
	}
	function hasDevTypeCode(){
		var type;
			$.ajax({
				url:"<%=path%>/sysManage/deviceBrandManage!execute.do?action=hasDevTypeForUpdate",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "error"){
						//alert("记录已存在，请重新输入！");
						$("#deviceTypeCode").next().html("i18n_udti.message.deviceTypeCode_n81i");
						type = false;
					}else if(data == "exception"){
						alert("i18n_udti.message.faild_n81i");
						type = false;
					}else if(data =="success"){
						type = true;
					}
				}
			}); 
		return type;  
	}
	
	function goBack(){
		document.Brandform.action="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo&pageSize="+'${pageSize }'+"&pageNo="+'${pageNo }';
		document.Brandform.submit();	
	}
//检查是否包含特殊字符
	function containSpecial(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	} 
	
	function chShowIndex() {
		var pid = $("select[id='pid'] option:selected").val();
		$("#showIndex").val('');
		if(pid!='' && pid!=null && pid!='undefined') {
			$("#devShowIndex").show();
		}else {
			$("#devShowIndex").hide();
		}
	}
	
	function isNotBlank(obj) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		return true;
	     	}else {
	     		return false;
	     	}
    }
	
	function changeShowHide() {
		jQuery("select[id='indexFiled']").empty();
		jQuery("select[id='statusFiled']").empty();
		jQuery("#statusValue").val('');
		jQuery("select[id='statusSymbols']").val('');
 		var selecVal = jQuery("select[id='diTableName'] option:selected").val();	
 		if(isNotBlank(selecVal)) {
		 	jQuery("select[id='statusFiled']").append('<option  value="" >i18n_udti.message.selectDefault_n81i</option>');
			<c:forEach items="${fieldList}" var="field" >
				if('${field[0]}'==selecVal) {
					var htmlStr = '<option  value="${field[1]}" >${field[1]}</option>';
		 			jQuery("select[id='statusFiled']").append(htmlStr);
				}
			</c:forEach>
			
			jQuery("select[id='indexFiled']").append('<option  value="" >i18n_udti.message.selectDefault_n81i</option>');
			<c:forEach items="${fieldList}" var="field" >
			    if('${field[0]}'==selecVal) {
			     	var htmlStr = '<option  value="${field[1]}" >${field[1]}</option>';
			      	jQuery("select[id='indexFiled']").append(htmlStr);
			    }
			</c:forEach>
			
	 		//jQuery("#tableStatusValue").show();
	 		//jQuery("#tableSymbols").show();
	 		jQuery("#tableStatusField").show();
	 		jQuery("#tableLinkField").show();
 		}else {
	 		//jQuery("#tableStatusValue").hide();
	 		//jQuery("#tableSymbols").hide();
	 		jQuery("#tableStatusField").hide();
	 		jQuery("#tableLinkField").hide();
 		} 
 		jQuery("#tableStatusValue").hide();
	 	jQuery("#tableSymbols").hide();
 		
	}
	function changeparCode() {
		jQuery("select[id='pid']").empty();//清空父设备型号列表
 		var selecVal = jQuery("select[id='deviceRandCode'] option:selected").val();	//所选品牌
 		//品牌改变时，编号清空，隐藏
		$("#showIndex").val('');
		$("#devShowIndex").hide();
		
 		if(isNotBlank(selecVal)) {
		 	jQuery("select[id='pid']").append('<option  value="" >i18n_udti.message.selectDefault_n81i</option>');
			<c:forEach items="${devTypeListInfo}" var="type" >
				if('${type.deviceRandCode}'==selecVal) {
					var htmlStr = '<option  value="${type.id}" >${type.deviceTypeCode}</option>';
		 			jQuery("select[id='pid']").append(htmlStr);
				}
			</c:forEach>
			
	 		jQuery("#parDevCode").show();
 		}else {
	 		jQuery("#parDevCode").hide();
 		} 
 		
	}
	
	
	function changeStatus() {
		jQuery("#statusValue").val('');
		jQuery("select[id='statusSymbols']").val('');
 		var selecVal = jQuery("select[id='statusFiled'] option:selected").val();	
 		if(isNotBlank(selecVal)) {			
	 		jQuery("#tableStatusValue").show();
	 		jQuery("#tableSymbols").show();
 		}else {
	 		jQuery("#tableStatusValue").hide();
	 		jQuery("#tableSymbols").hide();
 		} 
 		
	}
	
	
	
	function downLoadDevPic(fileName) {
		document.Brandform.action="<%=basePath%>/download/downLoadFile!downloadDevPic.do?file="+fileName+"&backPathStr=<%=basePath%>/sysManage/deviceBrandManage.do?action=toUpdateDevType%26ids=${devType.id}";
		document.Brandform.submit();	
	}
</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">		
				<input type="button" class=btn3_mouseout id="backButton"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_udti.button.back_n81i"/>
			 </div>
			<form action="" name="Brandform" method="post" enctype="multipart/form-data" id="Mkform">
			<input type="hidden" name="devTypeCodeForSearch" id="devTypeCodeForSearch" value="${devTypeCodeForSearch}" />
			<input type="hidden" name="devRandCodeForSearch" id="devRandCodeForSearch" value="${devRandCodeForSearch}" />
			<input  type="hidden" name="parDevId" id="parDevId" value="${parDevId}" />
			<input type="hidden" name="devType.id" value="${devType.id}" />
			<input type="hidden" name="devType.figureFill" value="${devType.figureFill}" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_udti.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.deviceRandCode_n81i
					</td>
					<td class="color_3" align="left">
						<select id="deviceRandCode" name="devType.deviceRandCode" style="width: 170px;"  onchange="changeparCode();">
						   	<option  value="" >i18n_udti.message.selectDefault_n81i</option>
							<c:forEach items="${devBrandListInfo}" var="brand" >
							  	<option  value="${brand.deviceRandCode}"  
							  		<c:if test="${brand.deviceRandCode==devType.deviceRandCode}">selected="selected"</c:if> >
							  		${brand.deviceRandCode}
							  	</option>
							</c:forEach>
						</select>
						<font id = "deviceRandCodeTip" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.deviceTypeCode_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.deviceTypeCode" id="deviceTypeCode" value="${devType.deviceTypeCode}" />
						<font id = "deviceTypeCodeTip" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.maxDeviceNum_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.maxDeviceNum" id="maxDeviceNum" value="${devType.maxDeviceNum}" />
						<font id = "maxDeviceNumTip" color="red"></font>
					</td>
				</tr>
				<tr id="parDevCode" <c:if test="${devType.deviceRandCode==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.pid_n81i
					</td>
					<td class="color_3" align="left">
						<select id="pid" name="devType.pid" onchange="javascript:chShowIndex();" >
						   	<option  value="" >i18n_udti.message.selectDefault_n81i</option>
							<c:forEach items="${devTypeListInfo}" var="type" ><!-- 共选择的只有当前品牌的型号 -->
							  	<c:if test="${type.deviceRandCode==devType.deviceRandCode}">
								  	<option  value="${type.id}"  
								  		<c:if test="${type.id==devType.pid}">selected="selected"</c:if> >
								  		${type.deviceTypeCode}
								  	</option>
							  	</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr id="devShowIndex" <c:if test="${devType.pid==0}">style="display: none;"</c:if>>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.showIndex_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.showIndex" id="showIndex" value="${devType.showIndex}" />
						<font id = "showIndexTip" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.figureFill_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="button" value="i18n_udti.text.figureFill_n81i" title="i18n_udti.text.figureFill_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
						<input type="file" name="figureFill" id="figureFill" value="${devType.figureFill}" onchange="javascript:setValue(this.value)"/>
						<a href="javascript:downLoadDevPic('/images/svg/upload/${devType.figureFill}');">${devType.figureFill}</a>
					<!-- 	<font id = "figureFillTip" color="red">*</font>  -->
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.nameFormat_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.nameFormat" id="nameFormat" value="${devType.nameFormat}" />（i18n_udti.text.nameFormatInfo_n81i）
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.diTableName_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="diTableName" name="devType.diTableName"  onchange="changeShowHide();">
					   		<option  value="" >i18n_udti.message.selectDefault_n81i</option>
						   	<c:forEach items="${metadataList}" var="meta" >
						  		<option  value="${meta}" 
						  		   <c:if test="${meta==devType.diTableName}">selected="selected"</c:if>>
						  			${meta}
						  		</option>
						   	</c:forEach>
					  	</select>
					</td>
				</tr>
				<tr id="tableLinkField" <c:if test="${devType.diTableName==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.indexFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="indexFiled" name="devType.indexFiled" >
						  	<option  value="" >i18n_udti.message.selectDefault_n81i</option>
						  	<c:forEach items="${fieldList}" var="field" ><!-- 共选择的只有当前品牌的型号 -->
							  	<c:if test="${field[0]==devType.diTableName}">
								  	<option  value="${field[1]}"  
								  		<c:if test="${field[1]==devType.indexFiled}">selected="selected"</c:if> >
								  		${field[1]}
								  	</option>
							  	</c:if>
							</c:forEach>
						 </select>
					</td>
				</tr>
				<tr  id="tableStatusField" <c:if test="${devType.diTableName==null}">style="display: none;"</c:if>>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.statusFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="statusFiled" name="devType.statusFiled"  onchange="changeStatus();">
						  	<option  value="" >i18n_udti.message.selectDefault_n81i</option>
						  	<c:forEach items="${fieldList}" var="field" ><!-- 共选择的只有当前品牌的型号 -->
							  	<c:if test="${field[0]==devType.diTableName}">
								  	<option  value="${field[1]}"  
								  		<c:if test="${field[1]==devType.statusFiled}">selected="selected"</c:if> >
								  		${field[1]}
								  	</option>
							  	</c:if>
							</c:forEach>
						 </select>
					</td>
				</tr>
				<tr id="tableSymbols" <c:if test="${devType.statusFiled==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.tableStatusValue_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="statusSymbols" name="devType.statusSymbols"  >
						   	<option  value="" >i18n_udti.message.selectDefault_n81i</option>
						   	<option  value="&gt;" <c:if test="${devType.statusSymbols=='>'}">selected="selected"</c:if> >&gt;</option>
						   	<option  value="=" <c:if test="${devType.statusSymbols=='='}">selected="selected"</c:if> >=</option>
						   	<option  value="&lt;" <c:if test="${devType.statusSymbols=='<'}">selected="selected"</c:if> >&lt;</option>
						</select>
					</td>
				</tr>
				<tr id="tableStatusValue"  <c:if test="${devType.statusFiled==null}">style="display: none;"</c:if> >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_udti.text.statusValue_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.statusValue" id="statusValue" value="${devType.statusValue}" />
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_udti.text.deviceDesc_n81i
					</td>
					<td class="color_3"  align="left" >
						<textarea type="text" name="devType.deviceDesc" id="deviceDesc" rows="3" cols="50">${devType.deviceDesc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout id="addButton"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="update()"
								value="i18n_udti.button.update_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout id="resetButton"
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Brandform'].reset()"
								value="i18n_udti.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
