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
		<title>i18n_acts.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
	function addCheck(){
		var type;
		$.ajax({
			url:"<%=path%>/detection/metaDataSet.do?action=addCheck",
			type : "POST",
			async:false,
			data:$('#form1').serialize(),
			success : function(data) {
				if(data == "exception"){
					type = false;
					alert("i18n_acts.error.abnormalOperation_n81i");
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
   	var flag = false;
	function add(){
		$("#filedNameFont").html("*");
		$("#zfcd").html("*");
		if(flag==true){
			var legthValue = document.getElementById('filedTypeLength');
			if(legthValue.value==""){
				$("#zfcd").html("i18n_acts.error.charLen_n81i");
				legthValue.focus();
				return;
			}
		}
		if($id("filedName","","i18n_acts.text.filedName_n81i")&& $id("filedComments","","i18n_acts.text.filedComments_n81i")
	    	 && $id("filedType","xz","i18n_acts.text.filedType_n81i") && $id("showNum","","i18n_acts.text.showNum_n81i")
	    	 && $id("showNum","sz","i18n_acts.text.showNum_n81i")){
	    	 var oid = document.getElementById("oid");
			 if(oid!=undefined && oid!=null) {//snmp监控，进行oid非空检查
	    	 	if(!$id("oid","","OID")) {
	    	 		return;
	    	 	}
	    	 }
	    	 if($("#filedName").val().length<15){
	    	 	if(!containSpecial($("#filedName").val())){
	    	 		if(!containSpecial1($("#filedName").val())){
			    		$("#filedName").next().html("i18n_acts.error.filedName_n81i");
			    		return;
			    	}
	    	 		if(!checkNum($("#filedName").val())){
	    	 			if(document.getElementById('filedType').value=='VARCHAR2'){
		    	 			if($id("filedTypeLength","","i18n_acts.text.filedTypeLength_n81i") && $id("filedTypeLength","sz","i18n_acts.text.filedTypeLength_n81i") && addCheck()){
		    	 				document.form1.action="<%=path%>/detection/metaDataSet.do?action=doAdd";
								document.form1.submit();	
		    	 			}
		    	 		}else{
			    	 		if(addCheck()){
								document.form1.action="<%=path%>/detection/metaDataSet.do?action=doAdd";
								document.form1.submit();
			    	 		}
		    	 		}
	    	 		}else{
	    	 			$("#filedNameFont").html("i18n_acts.error.cannotNum_n81i");
	    	 		}
	    	 	}else{
	    			$("#filedNameFont").html("i18n_acts.error.hasSpecialChar_n81i");
				}	
	    	}else{
	    		$("#filedNameFont").html("i18n_acts.error.lenTooLess_n81i");
	    	}	
		} 
	}
	
	//检查是否以数字开头
	function checkNum(s)       
	{       
   		var cs = /^[0-9]*$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));    
	} 
	
	//验证非中文和特殊字符
	function containSpecial1(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	} 
	
	function goBack(tid){
		var fw = $("#fw").val();
		var ic = $("#ic").val();
		if(fw!=null && fw !=""){//从向导过来
			if(ic!=null && ic =='0'){//添加提交过  ----监测类别源数据 操作完成
				window.location="<%=path%>/detection/metaDataSet.do?action=query&typeids="+tid+"&fromWhere="+fw+"&isComplete="+ic;
			}else{//监测类别完成
				window.location="<%=path%>/detection/metaDataSet.do?action=query&typeids="+tid+"&fromWhere="+fw+"&isJclbComplete=0";
			}
		}else{
			window.location="<%=path%>/detection/metaDataSet.do?action=query&typeids="+tid;
		}
		
	}
	
	function rclick(obj){
		if(obj.id=='State1'){//停用
			document.getElementById('chartState1').checked="checked";
		}else{//启用
			if($("#filedType").val() == "VARCHAR2"){
				document.getElementById('chartState1').checked="checked";
			}
		}
	}

	jQuery(function(){
		jQuery("td[id=lengthFt]").hide();
		jQuery("td[id=viewLevel0]").attr('colspan',3);
		//-- 字段类型选择事件绑定
	 	jQuery("#filedType").change(function(){
	 		if(jQuery(this).val() == "VARCHAR2"){
	 			jQuery("td[id=lengthFt]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1);
	 			flag = true;
	 			//$("#chartState0").attr("disabled","disabled");
	 			$("#chartState1").attr("checked","checked");
	 		}else{	//字段长度隐藏
	 			jQuery("td[id=lengthFt]").hide();
	 			jQuery("#filedTypeLength").val("");
	 			jQuery("td[id=viewLevel0]").attr('colspan',3);
	 			flag = false;
	 			
	 			if($("#State1").attr("checked")==true){//停用
	 				//$("#chartState0").attr("disabled","disabled");
	 				$("#chartState1").attr("checked","checked");
	 			}
	 		}
	 	});
	})
	
	</script>
	
	<body>
		<div class="middle_list" >
			<form action="" name="form1" method="post" id="form1">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" value="${typeids[0] }" name="typeids"/>
				<input type="hidden" id="fw" name="fromWhere" value="${fromWhere }"/>
				<input type="hidden" id="ic" name = "isComplete" id="isComplete" value="${isComplete}"/>
				<input type="hidden" id="ijc" name = "isJclbComplete" id="isJclbComplete" value="${isJclbComplete}"/>
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_acts.text.addDetecationMetaDate_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="15%" align="right">
							i18n_acts.text.detecationType_n81i
						</td>
						<td class="color_3" width="35%" align="left">
							<input type="hidden" name="checkTypeInfo.id"
									id="checkTypeId" value="${checkTypeInfo.id }"/>
							<input type="text" name="checkTypeInfo.checkTypeName"
									id="checkTypeName" value="${checkTypeInfo.checkTypeName }" readonly="readonly"/>
							<font color="red">*</font>			
						</td>
						<td class="color_1" width="15%" align="right">
							i18n_acts.text.tableName_n81i
						</td>
						<td class="color_3" width="35%" align="left">
							<input type="text" name="metadata.tableName"
									id="tableName" value="${checkTypeInfo.tableName }" readonly="readonly"/>
							<font color="red">*</font>		
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_acts.text.filedName_n81i
						</td>
						<td class="color_3" align="left">
							<input type="text" name="metadata.filedName"
									id="filedName" value=""/>
							<font id="filedNameFont" color="red">*</font>
						</td>
						<td class="color_1" align="right">
							i18n_acts.text.filedComments_n81i
						</td>
						<td class="color_3" align="left" >
							<input type="text" name="metadata.filedComments"
									id="filedComments" value=""/>
							<font color="red">*i18n_acts.error.filedComments_n81i</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_acts.text.filedType_n81i
						</td>
						<td class="color_6" align="left" id="viewLevel0">
							<select name="filedType" id="filedType">
									<option value="">
											i18n_acts.message.filedType.selectDefault_n81i
									</option>
									<option value="Number">
											i18n_acts.message.filedType.selectNumber_n81i
									</option>
									<option value="DATE">
											i18n_acts.message.filedType.selectDATE_n81i
									</option>
									<option value="VARCHAR2">
											i18n_acts.message.filedType.selectVARCHAR2_n81i
									</option>
							</select>
							<font color="red">*</font>
						</td>
						<td class="color_1" align="right" id="lengthFt">
							i18n_acts.text.filedTypeLength_n81i
						</td>
						<td class="color_3" align="left" id="lengthFt">
							<input type="text" name="filedTypeLength"
									id="filedTypeLength" />
									<font color="red" id="zfcd">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_acts.text.metaDateState_n81i
						</td>
						<td nowrap="nowrap"  class="color_6" align="left">
							<input type="radio" name="metadata.state"
									id="State0" value="0" onclick="rclick(this)" checked="checked" />i18n_acts.message.metaDateState0_n81i 
							<input type="radio" name="metadata.state"
									id="State1" value="1" onclick="rclick(this)"/>i18n_acts.message.metaDateState1_n81i
						</td>
						<td class="color_1" align="right">
							i18n_acts.text.ChartState_n81i
						</td>
						<td nowrap="nowrap"  class="color_6" align="left">
							<input type="radio" name="metadata.chartState"
									id="chartState0" value="0" />i18n_acts.message.yes_n81i 
							<input type="radio" name="metadata.chartState"
									id="chartState1" value="1" checked="checked" />i18n_acts.message.no_n81i
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_acts.text.serialNumber_n81i
						</td>
						<td class="color_3" align="left" 
						       <c:if test="${checkTypeInfo.isSnmp != 1&&checkTypeInfo.isSnmp !=0}">colspan="3"</c:if> >
							<input type="text" name="metadata.showNum" id="showNum" value="${maxNum+1 }"/>
							<font color="red">*</font>
						</td>
						<c:if test="${checkTypeInfo.isSnmp == 1||checkTypeInfo.isSnmp == 0}"><!-- 是SNMP监控 -->
								<td class="color_1" align="right">
									OID
								</td>
								<td class="color_3" align="left" >
									<input type="text" name="metadata.oid"
											id="oid" value=""/>
									<font color="red">*</font>
								</td>
						</c:if>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_acts.button.submit_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="javascript:document.forms['form1'].reset()" value="i18n_acts.button.reset_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										onclick="goBack(${checkTypeInfo.id })"
										value="i18n_acts.button.back_n81i"/>
								&nbsp;
						</td>
					</tr>
				</table>
				</form>
			</div>
		</body>
</html>
