<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Pragma","No-Cache");	
	response.setHeader("Cache-Control","No-Cache");	
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
        <!-- 弹出对话框 -->
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />

	</head>

	<script language="javascript" type="text/javascript">	

		$(function() {			
			$( "#downloadDialog" ).dialog({
				autoOpen: true,
				minWidth: 240,
				modal: true,
				//隐藏右上角的关闭按钮：以下2行
				closeOnEscape:false,
				open:function(event,ui){$(".ui-dialog-titlebar-close").hide();},
				resizable:false//大小固定
			});
		});
		function toConfigDevice(){
			var seqId = jQuery("select[id=seqId] option:selected").val();
			var deviceBrandCode = jQuery("select[id=deviceBrandCode] option:selected").val();
			var deviceBrandTypeCode = jQuery("select[id=deviceBrandTypeCode] option:selected").val();
			var maxDevNum = jQuery("select[id=maxDevNum] option:selected").val();//最大叠加数
			if(isBlank(maxDevNum)) {
				maxDevNum = 1;
			}
			if(isNotBlankAndTip(seqId,"i18n_snadt.message.seqId_n81i","seqId")&&isNotBlankAndTip(deviceBrandCode,"i18n_snadt.message.deviceBrandCode_n81i","deviceBrandCode")&&isNotBlankAndTip(deviceBrandTypeCode,"i18n_snadt.message.deviceBrandTypeCode_n81i","deviceBrandTypeCode")) {
				document.toConfigDevForm.action="<%=path%>/detection/switchDetection.do?action=configSpecialDevice&seqId="+seqId+"&deviceBrandCode="+deviceBrandCode+"&deviceBrandTypeCode="+deviceBrandTypeCode+"&maxDevNum="+maxDevNum;
		     	document.toConfigDevForm.submit();
			}
		}
		
		function isNotBlankAndTip(obj,tip,id) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		jQuery("#"+id).next().html('*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	     		return true;
	     	}else {
	     		jQuery("#"+id).next().html(tip);
	     		return false;
	     	}
        }
        
		function isNotBlank(obj) {
	     	if(obj!="" && obj!=null && obj!='undefined') {
	     		return true;
	     	}else {
	     		return false;
	     	}
        }
        
		function isBlank(obj) {
	     	if(obj=="" || obj==null || obj=='undefined') {
	     		return true;
	     	}else {
	     		return false;
	     	}
        }
        
        
        //选择品牌时，型号为当前品牌下的型号        
		function changeDevBrand() {
			jQuery("select[id='deviceBrandTypeCode']").empty();
	 		var selecVal = jQuery("select[id='deviceBrandCode'] option:selected").val();	 
	 		if(isNotBlank(selecVal)) {
			 	jQuery("select[id='deviceBrandTypeCode']").append('<option  value="" >i18n_snadt.message.selectDefault_n81i</option>');
				<c:forEach items="${deviceBrandTypeList}" var="brandType" >
					if('${brandType.deviceRandCode}'==selecVal) {
						var htmlStr = '<option  value="${brandType.deviceTypeCode}" >${brandType.deviceTypeCode}</option>';
			 			jQuery("select[id='deviceBrandTypeCode']").append(htmlStr);
					}
				</c:forEach>
		 		jQuery("#devBradnType").show();
	 		}else {
		 		jQuery("#devBradnType").hide();
	 		}
	 		jQuery("#maxDevNumDiv").hide();
		}
		
       
        //选择设备型号时，如果最大叠加数大于1，则显示选择叠加数，否则不显示     
		function changeMaxDevNum() { 
			jQuery("select[id='maxDevNum']").empty();//清空叠加数
	 		var selecVal = jQuery("select[id='deviceBrandTypeCode'] option:selected").val();//选中的型号	 
	 		if(isNotBlank(selecVal)) {
	 			var seleTypeMaxDevNum = 1;
				<c:forEach items="${deviceBrandTypeList}" var="brandType" >
					if('${brandType.deviceTypeCode}'==selecVal) {
						seleTypeMaxDevNum = '${brandType.maxDeviceNum}';
					}
				</c:forEach>
	 		
			 	jQuery("select[id='maxDevNum']").append('<option  value="" >i18n_snadt.message.selectDefault_n81i</option>');
			    if(seleTypeMaxDevNum>1) {
				    for(var i=1;i<=seleTypeMaxDevNum;i++) {
						var htmlStr = '<option  value="'+i+'" >'+i+'</option>';
			 			jQuery("select[id='maxDevNum']").append(htmlStr);
				    }
			 		jQuery("#maxDevNumDiv").show();
			    }else {
			    	jQuery("#maxDevNumDiv").hide();
			    }
			 	
	 		}else {
		 		jQuery("#maxDevNumDiv").hide();
	 		}
		}
		
       
    </script>
	<body>	
	<form id="toConfigDevForm"  action="<%=path%>/detection/switchDetection.do?action=toConfigSpecialDevice" name="toConfigDevForm" method="post">		
			<div id="downloadDialog" style="display: none;font-size:14px;margin-top:10px;" title="i18n_snadt.message.selectDefault_n81i" align="center">
					<div style="font-size: 12px;">
						 i18n_snadt.text.seqId_n81i：<select id="seqId" name="" style="width: 100px;">
						  <option  value="" >i18n_snadt.message.selectDefault_n81i</option>
						  <c:forEach items="${switcheNodeList}" var="switchNode" >
						  	  <option  value="${switchNode[1]}" >${switchNode[0]}</option>
						  </c:forEach>
						  </select><font color="red">*</font>
						  <br/><br/>
						  i18n_snadt.text.deviceBrandCode_n81i：<select id="deviceBrandCode" name="" style="width: 100px;" onchange="changeDevBrand();">
						  	   <option  value="" >i18n_snadt.message.selectDefault_n81i</option>
							   <c:forEach items="${deviceBrandList}" var="brand" >
							  	    <option  value="${brand[0]}" >${brand[1]}</option>
							   </c:forEach>
						  </select><font color="red">*</font>
						  <br/><br/>
						  <div id="devBradnType" style="display: none;">
							 i18n_snadt.text.deviceBrandTypeCode_n81i：<select id="deviceBrandTypeCode" name="" style="width: 100px;" onchange="changeMaxDevNum();">
							  	  <option  value="" >i18n_snadt.message.selectDefault_n81i</option>
							  </select><font color="red">*</font>
						  	  <div id="maxDevNumDiv" style="display: none;">
								  <br/>
								  i18n_snadt.text.maxDevNum_n81i：<select id="maxDevNum" name="" style="width: 100px;">
								  	  <option  value="" >i18n_snadt.message.selectDefault_n81i</option>
								  </select><font color="red"></font>
							  </div>
						  </div>
					</div>  
					<div style="font-size: 12px;margin-top: 10px;" align="center">
						 <input type="button" class=btn3_mouseout
														onmouseover="this.className='btn3_mouseover'"
														onmouseout="this.className='btn3_mouseout'"
														onmousedown="this.className='btn3_mousedown'"
														onmouseup="this.className='btn3_mouseup'"
														onclick="toConfigDevice()" value="i18n_snadt.button.ok_n81i"/>
				    </div>
			</div>
	</form>
	</body>
</html>

