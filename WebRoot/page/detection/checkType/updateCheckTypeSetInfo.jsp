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
		<title>i18n_uctsi.message.title_n81i</title>
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
   
	function goBack(){
		document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=query";
		document.Mkform.submit();	
	}
	//验证oid
	function checkOID(oid){
		var cs = /^[1-9]([\d\.]+\d)?$/;
		var resu = cs.test(oid);
		return resu;
	}
	//验证非中文和特殊字符
	function containSpecial1(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	} 
	
	function updateCheck(){
		var type;
		var isSnmp = $("input[type=radio][name=checkTypeInfo.isSnmp]:checked").val();
		$.ajax({
			url:"<%=path%>/detection/checkTypeSet.do?action=updateCheck&checkTypeInfo.isSnmp="+isSnmp,
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "exception"){
					type = false;
					alert("i18n_uctsi.message.faild_n81i");
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
	
	function add(){
		if($id("checkTypeName1","","i18n_uctsi.message.checkTypeName1_n81i") && $id("tableName","","i18n_uctsi.message.tableName_n81i")){
			if(containSpecial($("#checkTypeName1").val())){
	    		$("#checkTypeName1").next().html("i18n_uctsi.error.hasSpecialChar_n81i");
	    		$("#checkTypeName1").val($("#ctname1").val());
	    		return;
	    	}
	    	if($("#tableName").val()=='DI_'){
		    	$("#tableName").next().html("i18n_uctsi.error.inputTableName_n81i");
		    	return;
		    }
		    if($("#tableName").val().length>20){
		    	$("#tableNameFont").html("i18n_uctsi.error.tooLong_n81i");
		    	return;
		    }
		    if(containSpecial($("#tableName").val())){
			    $("#tableName").next().html("i18n_uctsi.error.tabHasSpecialChar_n81i");
			    $("#tableName").val($("#tnBk").val());
			    return;
			}
			if(!containSpecial1($("#tableName").val())){
			    $("#tableName").next().html("i18n_uctsi.error.tabHasZh_n81i");
			    $("#tableName").val($("#tnBk").val());
			    return;
			}
	    	
			if(jQuery("#viewLevel2").attr('checked')==true){
		    	if($id("usergroupid","xz","i18n_uctsi.message.usergroup_n81i")){
		    		if(jQuery("#isSnmp0").attr('checked')==true){
	    				if($id("snmpOID","","OID") && checkOID($("#snmpOID").val()) && updateCheck()){
	    					jQuery("input[type='radio'][name='checkTypeInfo.isSnmp']").removeAttr('disabled');
	    					document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doUpdate";
							document.Mkform.submit();
	    				}else{
	    					$("#OIDFont").text("i18n_uctsi.error.OIDFont_n81i");
	    					$("#snmpOID").val("");
	    					$("#snmpOID").focus();
	    					return;
	    				}
	    			}else{
		    			if(updateCheck()){
		    				jQuery("input[type='radio'][name='checkTypeInfo.isSnmp']").removeAttr('disabled');
		    				document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doUpdate";
							document.Mkform.submit();
		    			}
	    			}
		    	}
		    }else{
		    	if(jQuery("#isSnmp0").attr('checked')==true){
	    			if($id("snmpOID","","OID") && checkOID($("#snmpOID").val()) && updateCheck()){
	    				jQuery("input[type='radio'][name='checkTypeInfo.isSnmp']").removeAttr('disabled');
	    				document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doUpdate";
						document.Mkform.submit();	
	    			}else{
	    				$("#OIDFont").text("i18n_uctsi.error.OIDFont_n81i");
	    				$("#snmpOID").val("");
	    				$("#snmpOID").focus();
	    				return;
	    			}
	    		}else{
		    		if(updateCheck()){
		    			jQuery("input[type='radio'][name='checkTypeInfo.isSnmp']").removeAttr('disabled');
		    			document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doUpdate";
						document.Mkform.submit();
		    		}
	    		}
		    }
		}
	}
	jQuery(function(){
		if(jQuery("#viewLevel2").attr('checked')==true){
			jQuery("td[id=usergroup]").show();
		}else{
			jQuery("td[id=usergroup]").hide();
			jQuery("td[id=viewLevel0]").attr('colspan','3').addClass('td_3').removeClass('td_2');
		}
		
		//-- 查看权限事件绑定
	 	jQuery("input[type='radio'][name='checkTypeInfo.viewLevel']").click(function(){
	 		if(jQuery(this).val() == 2){	//用户组显示且必选
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 		}else{	//用户组隐藏
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		}
	 	});
	 	
	 	if(jQuery("#isSnmp0").attr('checked')==true || jQuery("#isSnmp1").attr('checked')==true){
			jQuery("td[id=oid]").show();
	 		jQuery("td[id=snmp]").attr('colspan',1).addClass('td_3').removeClass('td_2');
		}else{
			jQuery("td[id=oid]").hide();
			jQuery("td[id=snmp]").attr('colspan',3).addClass('td_2').removeClass('td_3');
		}
	 	
	 	//-- 是否snmp监控事件绑定
	 	jQuery("input[type='radio'][name='checkTypeInfo.isSnmp']").click(function(){
	 		if(jQuery(this).val() == 0 || jQuery(this).val() == 1){	//oid显示且必选
	 			jQuery("td[id=oid]").show();
	 			jQuery("td[id=snmp]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 		}else{	//用户组隐藏
	 			jQuery("td[id=oid]").hide();
				jQuery("td[id=snmp]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 			//jQuery("#snmpOID").val("");
	 		}
	 	});
	 	//--验证OID失去焦点事件
	 	$("#snmpOID").focusout(function() {
		  if($("#snmpOID").val()!="" && checkOID($("#snmpOID").val())){
		  	$("#OIDFont").attr('color','#009900').text("OID合法");
		  }
		});
		

	})
</script>

	<body>
		<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_uctsi.button.back_n81i"/>
			 </div>
			<input type="hidden" id="ctname1" value="${checkTypeInfo.checkTypeName1 }"/>
			<form action="" name="Mkform" method="post" id="Mkform">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="checkTypeInfo.id" value="${checkTypeInfo.id }" />
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" id="tnBk" value="${checkTypeInfo.tableName }"  />
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
					<tr>
						<td colspan="4" class="color_8">
							<strong>i18n_uctsi.text.updateDetecationType_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" width="15%" align="right">
							i18n_uctsi.message.checkTypeName1_n81i
						</td>
						<td class="color_3" width="30%" align="left">
							<input type="text" name="checkTypeInfo.checkTypeName1" id="checkTypeName1" value="${checkTypeInfo.checkTypeName1 }"/>
							<font color="red">*</font>	
						</td>
						<td class="color_1" width="15%"  align="right">
							i18n_uctsi.text.checkTypeName_n81i
						</td>
						<td class="color_3" width="30%"  align="left">
							<input type="text" name="checkTypeNameShow" value="${checkTypeInfo.checkTypeName }" disabled/>
							<input type="hidden" name="checkTypeInfo.checkTypeName" id="checkTypeName" value="${checkTypeInfo.checkTypeName }"/>
							<font color="red">*</font>	
						</td>
						
					</tr>
					<tr>
						<td class="color_1" width="12%" align="right">
								i18n_uctsi.message.tableName_n81i
						</td>
						<!--<c:if test="${isHaveTable=='1' }">readonly</c:if>-->
						<td class="color_3" width="38%" align="left">
							<c:if test="${isHaveTable=='1' }" var="ihtFlag">
								<input type="text" name="tableNameShow" value="${checkTypeInfo.tableName }"  disabled/>
								<input type="hidden" name="checkTypeInfo.tableName" id="tableName" value="${checkTypeInfo.tableName }"  />
							</c:if>
							<c:if test="${!ihtFlag}">
								<input type="text" name="checkTypeInfo.tableName" id="tableName" value="${checkTypeInfo.tableName }"  />
							</c:if>
							<font id="tableNameFont" color="red">*</font>
								
						</td>
						<td class="color_1"  align="right" valign="top">
							i18n_uctsi.text.tableComments_n81i
						</td>
						<td class="color_3"  align="left" valign="top">
							<input type="text" name="checkTypeInfo.tableComments"
									id="tableComments" value="${checkTypeInfo.tableComments }"/>
								
						</td>
				   </tr>
					<tr>
						<td class="td_1">i18n_uctsi.text.viewPrivilige_n81i：</td>
						<td class="td_3" id="viewLevel0">
							<c:if test="${!ADMFlag }">
								<input type="radio"	name="checkTypeInfo.viewLevel" 
								id="" value="1" <c:if test="${checkTypeInfo.viewLevel == '1' }">checked="checked"</c:if>/>i18n_uctsi.text.publisher_n81i&nbsp;
							<input type="radio"	name="checkTypeInfo.viewLevel" 
								id="viewLevel2" value="2" <c:if test="${checkTypeInfo.viewLevel == '2' }">checked="checked"</c:if>/>i18n_uctsi.text.publisherGroup_n81i&nbsp;
							<input type="radio" name="checkTypeInfo.viewLevel" 
								id="" value="3" <c:if test="${checkTypeInfo.viewLevel == '3' }">checked="checked"</c:if>/>i18n_uctsi.text.allInSys_n81i&nbsp;
							</c:if>
							<c:if test="${ADMFlag }">
								<input type="radio" name="checkTypeInfo.viewLevel" 
								id="" value="4" <c:if test="${checkTypeInfo.viewLevel == '4' }">checked="checked"</c:if>/>i18n_uctsi.text.unlimited_n81i&nbsp;
							</c:if>
						</td>
						<td class="td_1"  id="usergroup">i18n_uctsi.text.usergroup_n81i：</td>
						<td class="td_2"  id="usergroup">
							<select name="checkTypeInfo.groupId" id="usergroupid">
								<option selected="selected" value="">
									i18n_uctsi.message.selectUserGroup_n81i
								</option>
								<c:forEach items="${setxtjs}"  var="stjs">
										<option value="${stjs.jsbh}" <c:if test="${stjs.jsbh == checkTypeInfo.groupId }">selected="selected"</c:if>>
												${stjs.jsmc}
										</option>
								</c:forEach>
							</select>
							<font color="red" id="group_red">* </font>
						</td>
					</tr>
				   <tr>
				  		<td class="color_1"  align="right" valign="top" nowrap="nowrap">
							i18n_uctsi.message.isSnmp_n81i
						</td>
						<td class="color_3"  align="left" id="snmp">
							<input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp0" value="0" 
							       <c:if test="${checkTypeInfo.isSnmp == 0}">checked="checked"</c:if>
							       <c:if test="${isHaveTable=='1' }">disabled="disabled"</c:if>/>ObjectSNMP
							<input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp1" value="1"  
							       <c:if test="${checkTypeInfo.isSnmp == 1}">checked="checked"</c:if>  
							       <c:if test="${isHaveTable=='1' }">disabled="disabled"</c:if>/>SNMP4J
							<input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp2" value="2" 
							       <c:if test="${checkTypeInfo.isSnmp == 2||checkTypeInfo.isSnmp eq null}">checked="checked"</c:if>
							       <c:if test="${isHaveTable=='1' }">disabled="disabled"</c:if>/>i18n_uctsi.message.no_n81i
						</td>
						<td id="oid" class="color_1"  align="right" valign="top" nowrap="nowrap">
							OID
						</td>
						<td id="oid" class="color_3"  align="left">
							<input type="text" name="checkTypeInfo.snmpOID" id="snmpOID" size="50" value="${checkTypeInfo.snmpOID}"/>
							<font id="OIDFont" color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1"  align="right" valign="top" nowrap="nowrap">
							i18n_uctsi.text.isSchedule_n81i
						</td>
						<td class="color_3"  align="left" colspan="3">
							<input type="radio" name="isSchedule" value="1" disabled="disabled" checked="checked"/>i18n_uctsi.message.no_n81i
							<input type="hidden" name="checkTypeInfo.isSchedule" value="${checkTypeInfo.isSchedule}"/>
						</td>
					</tr>
				   <tr>
						<td class="color_1"  align="right" valign="top">
								i18n_uctsi.text.remark_n81i
						</td>
						<td class="color_3"  align="left" colspan="3">
							<textarea rows="3" cols="50" id="checkRemark" name="checkTypeInfo.checkRemark">${checkTypeInfo.checkRemark }</textarea>
						</td>
					</tr>
					<tr>
						<td class="color_7" colspan="4" align="right">
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'" 
									onclick="add()" value="i18n_uctsi.button.submit_n81i"/>
							&nbsp;
							<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:document.forms['Mkform'].reset()"
									value="i18n_uctsi.button.reset_n81i"/>
						</td>
					</tr>	
				</table>
			</form>
		</div>
	</body>
</html>
