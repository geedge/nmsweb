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
		<title>i18n_abdti.message.title_n81i</title>
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
    
	function add(){
					
		//去空格
		trim("deviceTypeCode");//设备型号
		trim("showIndexStart");//编号开始值
		trim("showIndexEnd");//编号结束值
		trim("nameFormat");//名称格式
		trim("statusValue");//异常比较值
		
	    if($id("deviceRandCode","xz","i18n_abdti.text.deviceRandCode_n81i") && $id("pid","","i18n_abdti.text.pid_n81i")){//&& !hasDevTypeCode():不进行判断了,$id("deviceTypeCode","","设备型号") 也不用判断了，默认赋值
	    	
		        
		    //var parCode = jQuery("select[id='pid'] option:selected").val();	
			//if(isNotBlank(parCode)){
				var showIndexStart=document.getElementById("showIndexStart").value;
				var showIndexEnd=document.getElementById("showIndexEnd").value;
				if(showIndexStart=='' ){
				 	$("#showIndexEnd").next().html('i18n_abdti.message.showIndexEnd1_n81i');
			        return;
			    }else if(showIndexStart.replace(/[\d+]/ig,"").length>0){
		        	$("#showIndexEnd").next().html('i18n_abdti.message.showIndexEnd2_n81i');
			        return;
			    }else if(showIndexEnd=='') {
				 	$("#showIndexEnd").next().html('i18n_abdti.message.showIndexEnd3_n81i');
				 	return;
		        }else if(showIndexEnd.replace(/[\d+]/ig,"").length>0) {
		        	$("#showIndexEnd").next().html('i18n_abdti.message.showIndexEnd4_n81i');
		        	return;
		        }else if(showIndexStart>showIndexEnd){
		        	//$("#showIndexEnd").next().html('编号开始值:'+showIndexStart+'应小于编号结束值:'+showIndexEnd);
		        	//return;//????????????
		        }else {
		        	$("#showIndexEnd").next().html('*');
		        }
			//}
			
		    var myfileVal = document.getElementById("figureFill").value;
			if(myfileVal=="") {
				//$("#figureFill").next().html('请选择设备图片');
				//return;
			}else {
				var allowExt = ".png  , .bmp  , .jpg  , .gif";
				var fileExt = myfileVal.substr(myfileVal.lastIndexOf(".")).toLowerCase();
				if(allowExt.indexOf(fileExt)==-1){
					$("#figureFill").next().html('i18n_abdti.message.figureFill_n81i：'+allowExt);
					return;
				}else {
					//$("#figureFill").next().html('*');
				}
			}

			
			document.Brandform.action="<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=addBatchDevType";
			document.Brandform.submit();
			jQuery("#addButton").attr("disabled","true");
			jQuery("#resetButton").attr("disabled","true");
			jQuery("#backButton").attr("disabled","true");
        }	
	}
	
	//判断设备型号是否重复
	function hasDevTypeCode(){
		var hasDevCode = false;
	    $.ajaxSettings.async = false;//设置同步
		//先判断任务编号是否存在，不存在不查询
		var deviceTypeCode = jQuery.trim(jQuery("#deviceTypeCode").val());
		var deviceRandCode = jQuery.trim(jQuery("select[id='deviceRandCode'] option:selected").val());
		if(deviceTypeCode!='') {
			$.getJSON("<%=path%>/sysManage/deviceBrandManage!execute.do?action=hasDevType&devTypeCodeForSearch="+deviceTypeCode+"&devRandCodeForSearch="+deviceRandCode,
	             {}, function(data){
					 if(data!=null&&data!=""&&data.result=='success') {//设备型号已存在
					 	var tip = data.tip;
					 	$("#deviceTypeCode").next().html(tip);
					 	hasDevCode = true;
					 	return true;
					 }else {
					 	$("#deviceTypeCode").next().html(tip);
					 	hasDevCode = false;
					 	return false;
					 }
			});  	
		}
		return hasDevCode;
	}
	
	function goBack(){
		document.Brandform.action="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo";
		document.Brandform.submit();	
	}
//检查是否包含特殊字符
	function containSpecial(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	} 
	
	//暂时无用
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
		 	jQuery("select[id='statusFiled']").append('<option  value="" >i18n_abdti.message.selectDefault_n81i</option>');
			<c:forEach items="${fieldList}" var="field" >
				if('${field[0]}'==selecVal) {
					var htmlStr = '<option  value="${field[1]}" >${field[1]}</option>';
		 			jQuery("select[id='statusFiled']").append(htmlStr);
				}
			</c:forEach>
			
			jQuery("select[id='indexFiled']").append('<option  value="" >i18n_abdti.message.selectDefault_n81i</option>');
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
		//$("#devShowIndex").hide();
		
	 	jQuery("select[id='pid']").append('<option  value="" >i18n_abdti.message.selectDefault_n81i</option>');
 		if(isNotBlank(selecVal)) {
			<c:forEach items="${devTypeListInfo}" var="type" >
				if('${type.deviceRandCode}'==selecVal) {
					var htmlStr = '<option  value="${type.id}" >${type.deviceTypeCode}</option>';
		 			jQuery("select[id='pid']").append(htmlStr);
				}
			</c:forEach>
			
	 		//jQuery("#parDevCode").show();
 		}else {
	 		//jQuery("#parDevCode").hide();
 		} 
 		
 		jQuery("#deviceTypeCode").val('');//设置端口名的前缀 	
	}
	
	//选择父设备型号后，改变端口的前缀（端口名=选择的父设备型号+编号）
	function setDevCode() {
 		var selecVal = jQuery("select[id='pid'] option:selected").text();	//所选父设备型号
 		jQuery("#deviceTypeCode").val(selecVal);//设置端口名的前缀 		
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
</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">		
				<input type="button" class=btn3_mouseout id="backButton" 
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_abdti.button.back_n81i"/>
			 </div>
			<form action="" name="Brandform" method="post" enctype="multipart/form-data">
			<input type="hidden" name="devTypeCodeForSearch" id="devTypeCodeForSearch" value="${devTypeCodeForSearch}" />
			<input type="hidden" name="devRandCodeForSearch" id="devRandCodeForSearch" value="${devRandCodeForSearch}" />
			<input  type="hidden" name="parDevId" id="parDevId" value="${parDevId}" />
			<input type="hidden" name="devType.isPositionDev" id="isNotPositionDev" value="0" />
			
			<input type="hidden" name="devType.deviceTypeCode" id="deviceTypeCode" value="" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_abdti.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.deviceRandCode_n81i
					</td>
					<td class="color_3" align="left">
						<select id="deviceRandCode" name="devType.deviceRandCode" style="width: 170px;"  onchange="changeparCode();">
						   	<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
							<c:forEach items="${devBrandListInfo}" var="brand" >
							  	<option  value="${brand.deviceRandCode}"  >${brand.deviceRandCode}</option>
							</c:forEach>
						</select>
						<font id = "deviceRandCodeTip" color="red">*</font>
					</td>
				</tr>
				<tr  id="parDevCode">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.pid_n81i
					</td>
					<td class="color_3" align="left">
						<select id="pid" name="devType.pid"  onchange="setDevCode();">
						   	<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
							
						</select>
						<font id = "pidTip" color="red">*</font>
					</td>
				</tr>
	<!-- 		<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						设备型号
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="hidden" name="devType.deviceTypeCode" id="deviceTypeCode" value="" />
						<font id = "deviceTypeCodeTip" color="red">*</font>自动在设备型号后添加编号（如输入DPX8000-A12,则设备型号为'DPX8000-A12-编号'）
					</td>
				</tr>   -->	
	<!--	<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						最大叠加数
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.maxDeviceNum" id="maxDeviceNum" value="" />
						<font id = "maxDeviceNumTip" color="red"></font>
					</td>
				</tr>    -->		
				<tr  >
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.showIndexRule_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
                        <input type="radio" name="devType.showIndexRule" id="showIndexRule" value="0"  checked="checked"/>i18n_abdti.message.showIndexRule.all_n81i						
						<input type="radio" name="devType.showIndexRule" id="showIndexRule" value="1" />i18n_abdti.message.showIndexRule.odd_n81i
                        <input type="radio" name="devType.showIndexRule" id="showIndexRule" value="2"  />i18n_abdti.message.showIndexRule.even_n81i
					</td>
				</tr>
				<tr  id="devShowIndex">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.showIndexStart_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.showIndexStart" id="showIndexStart" value="" size="6" />--<input type="text" name="devType.showIndexEnd" id="showIndexEnd" value="" size="6" />
						<font id = "showIndexTip" color="red">*</font>
					</td>
				</tr>
	<!--		<tr style="display: inline" id="devShowIndex">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						槽位设备
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="radio" name="devType.isPositionDev" id="isPositionDev" value="0" />是
                        <input type="radio" name="devType.isPositionDev" id="isNotPositionDev" value="1" checked="checked"  />否
					</td>
				</tr>    -->	
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.figureFill_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
					<input type="button" value="i18n_abdti.text.figureFill_n81i" title="i18n_abdti.text.figureFill_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
						<input type="file" name="figureFill" id="figureFill" value="" onchange="javascript:setValue(this.value)"/>
					<!--  <font id = "figureFillTip" color="red">*</font>  -->	
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.nameFormat_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.nameFormat" id="nameFormat" value="" />（i18n_abdti.text.nameFormatInfo_n81i）
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.diTableName_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="diTableName" name="devType.diTableName"  onchange="changeShowHide();">
					   		<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
						   	<c:forEach items="${metadataList}" var="meta" >
						  		<option  value="${meta}" >${meta}</option>
						   	</c:forEach>
					  	</select>
					</td>
				</tr>
				<tr id="tableLinkField" style="display: none;">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.indexFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="indexFiled" name="devType.indexFiled" >
						  	<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
						 </select>
					</td>
				</tr>
				<tr  id="tableStatusField" style="display: none;">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.statusFiled_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="statusFiled" name="devType.statusFiled"  onchange="changeStatus();">
						  	<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
						 </select>
					</td>
				</tr>
				<tr id="tableSymbols" style="display: none;">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.statusSymbols_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<select id="statusSymbols" name="devType.statusSymbols"  >
						   	<option  value="" >i18n_abdti.message.selectDefault_n81i</option>
						   	<option  value="&gt;" >&gt;</option>
						   	<option  value="=" >=</option>
						   	<option  value="&lt;" >&lt;</option>
						</select>
					</td>
				</tr>
				<tr id="tableStatusValue"  style="display: none;">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_abdti.text.statusValue_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.statusValue" id="statusValue" value="" />
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_abdti.text.deviceDesc_n81i
					</td>
					<td class="color_3"  align="left" >
						<textarea type="text" name="devType.deviceDesc" id="deviceDesc" rows="3" cols="50"></textarea>i18n_abdti.text.autoAddDeviceID_n81i
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout id="addButton" 
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_abdti.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout id="resetButton" 
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Brandform'].reset()"
								value="i18n_abdti.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
