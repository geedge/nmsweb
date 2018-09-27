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
		<title>i18n_apdti.message.title_n81i</title>
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
    $(function(){
    	 
    });
    
    function trim(id) {
    	jQuery("#"+id).val(jQuery.trim(jQuery("#"+id).val()));
    }    
    
	function add(){
					
		//去空格
		trim("deviceTypeCode");//设备型号
		//trim("showIndex");//编号
		trim("showIndexStart");//编号开始值
		trim("showIndexEnd");//编号结束值
		
	    //if($id("deviceTypeCode","","设备型号") ){//&& !hasDevTypeCode()
	        
	        var showIndexStart=document.getElementById("showIndexStart").value;
			var showIndexEnd=document.getElementById("showIndexEnd").value;
			if(showIndexStart=='' ){
			 	$("#showIndexEnd").next().html('i18n_apdti.message.showIndexEnd1_n81i');
		        return;
		    }else if(showIndexStart.replace(/[\d+]/ig,"").length>0){
	        	$("#showIndexEnd").next().html('i18n_apdti.message.showIndexEnd2_n81i');
		        return;
		    }else if(showIndexEnd=='') {
			 	$("#showIndexEnd").next().html('i18n_apdti.message.showIndexEnd3_n81i');
			 	return;
	        }else if(showIndexEnd.replace(/[\d+]/ig,"").length>0) {
	        	$("#showIndexEnd").next().html('i18n_apdti.message.showIndexEnd4_n81i');
	        	return;
	        }else if(showIndexStart>showIndexEnd){
	        	//$("#showIndexEnd").next().html('编号开始值:'+showIndexStart+'应小于编号结束值:'+showIndexEnd);
	        	//return;//????????????
	        }else {
	        	$("#showIndexEnd").next().html('*');
	        }
	        //编号不可为空	        
			/*var name=document.getElementById('showIndex').value;
			if(name=='' ){
			 	$("#showIndex").next().html('请输入编号');
		        return;
	        }else if(name.replace(/[\d+]/ig,"").length>0){
	        	$("#showIndex").next().html('请输入数字');
		        return;
	        }else {
	        	$("#showIndex").next().html('*');
	        }*/
		    
			document.Brandform.action="<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=addPosDevType";
			document.Brandform.submit();
			jQuery("#addButton").attr("disabled","true");
			jQuery("#resetButton").attr("disabled","true");  
			jQuery("#backButton").attr("disabled","true");
        //}	
	}
	
	//判断设备型号是否重复
	function hasDevTypeCode(){
		var hasDevCode = false;
	    $.ajaxSettings.async = false;//设置同步
		//先判断任务编号是否存在，不存在不查询
		var deviceTypeCode = jQuery.trim(jQuery("#deviceTypeCode").val());
		var deviceRandCode = '${devType.deviceRandCode}';
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
	
	function isNotBlank(obj) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		return true;
	     	}else {
	     		return false;
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
					onclick="goBack()" value="i18n_apdti.button.back_n81i"/>
			 </div>
 
			<form action="" name="Brandform" method="post" enctype="multipart/form-data">
			<input type="hidden" name="devTypeCodeForSearch" id="devTypeCodeForSearch" value="${devTypeCodeForSearch}" />
			<input type="hidden" name="devRandCodeForSearch" id="devRandCodeForSearch" value="${devRandCodeForSearch}" />
			<input  type="hidden" name="parDevId" id="parDevId" value="${parDevId}" />
			<input type="hidden" name="devType.isPositionDev"  value="1" />
			<input type="hidden" name="devType.deviceRandCode"  value="${devType.deviceRandCode}" />
			<input type="hidden" name="devType.maxDeviceNum"  value="1" />
			<input type="hidden" name="devType.pid"  value="${devType.id}" />
			
			<input type="hidden" name="devType.deviceTypeCode" id="deviceTypeCode" value="${devType.deviceTypeCode}" />
			
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_apdti.text.title_n81i</strong>
					</td>
				</tr>
				<tr id="parDevCode">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_apdti.text.deviceTypeCode_n81i
					</td>
					<td class="color_3" align="left">
					    ${devType.deviceTypeCode}
					</td>
				</tr>	
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_apdti.text.deviceRandCode_n81i
					</td>
					<td class="color_3" align="left">
					    ${devType.deviceRandCode}
					</td>
				</tr>
	<!--    	<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						设备型号
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.deviceTypeCode" id="deviceTypeCode" value="" />
						<font id = "deviceTypeCodeTip" color="red">*</font>自动在设备型号后添加编号（如输入DPX8000-A12,则设备型号为'DPX8000-A12-编号'）
					</td>
				</tr>	 -->		
<!-- 			<tr id="devShowIndex">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						编号
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.showIndex" id="showIndex" value="" />
						<font id = "showIndexTip" color="red">*</font>
					</td>
				</tr>   -->	
				<tr  id="devShowIndex">
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_apdti.text.showIndexStart_n81i
					</td>
					<td class="color_3" width="30%" align="left" >
						<input type="text" name="devType.showIndexStart" id="showIndexStart" value="" size="6" />--<input type="text" name="devType.showIndexEnd" id="showIndexEnd" value="" size="6" />
						<font id = "showIndexTip" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_apdti.text.deviceDesc_n81i
					</td>
					<td class="color_3"  align="left" >
						<textarea type="text" name="devType.deviceDesc" id="deviceDesc" rows="3" cols="50"></textarea>i18n_apdti.text.autoAddDeviceID_n81i
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout id="addButton" 
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_apdti.button.add_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout id="resetButton" 
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Brandform'].reset()"
								value="i18n_apdti.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
