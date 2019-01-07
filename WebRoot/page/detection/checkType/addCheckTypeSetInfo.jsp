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
		<title>i18n_actsi.message.title_n81i</title>
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
   
	function add(){
		$('#tnts').text("");
		$('#cnts').text("");
		$('#cnl').text("");
		$('#cnll').text("");
		$('#tnl').text("");
		$("#oidFont").attr('color','red');
	    if($id("checkTypeName1","","i18n_actsi.text.checkTypeName1_n81i") && $id("checkTypeName","","i18n_actsi.text.checkTypeName_n81i")&& $id("tableName","","i18n_actsi.text.tableName_n81i")){
	    	if(containSpecial($("#checkTypeName1").val())){
	    		$("#checkTypeName1").next().html("i18n_actsi.text.checkTypeName1.hasSpecialChar_n81i");
	    		return;
	    	}
	    	if(containSpecial1($("#checkTypeName").val())){//判断是否包含特殊字符和中文
	    		if($("#checkTypeName").val().length<64 && $("#tableName").val().length<=20){
		    		if($("#tableName").val()=='DI_'){
		    			$("#tableName").next().html("i18n_actsi.text.tableName.enterDBName_n81i");
		    			return;
		    		}
		    		if(containSpecial($("#tableName").val())){
			    		$("#tableName").next().html("i18n_actsi.text.tableName.tabSpecialChar_n81i");
			    		$("#tableName").val('DI_');
			    		return;
			    	}
			    	if(!containSpecial1($("#tableName").val())){
			    		$("#tableName").next().html("i18n_actsi.text.tableName.tabHasZh_n81i");
			    		$("#tableName").val('DI_');
			    		return;
			    	}
		    		if(jQuery("#viewLevel2").attr('checked')==true){
		    			if($id("usergroupid","xz","i18n_actsi.text.usergroup_n81i")){
		    				if(jQuery("#isSnmp0").attr('checked')==true){
		    					if($id("snmpOID","","OID") && checkOID($("#snmpOID").val())){
		    							document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doAdd";
										document.Mkform.submit();
		    					}else{
		    						$("#oidFont").text("i18n_actsi.text.oidFont_n81i");
		    						$("#snmpOID").val("");
		    						$("#snmpOID").focus();
		    						return;
		    					}
		    				}else{
		    					document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doAdd";
								document.Mkform.submit();
		    				}
		    			}
		    		}else{
		    			if(jQuery("#isSnmp0").attr('checked')==true){
		    					if($id("snmpOID","","OID") && checkOID($("#snmpOID").val())){
		    						document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doAdd";
									document.Mkform.submit();
		    					}else{
		    						$("#oidFont").text("i18n_actsi.text.oidFont_n81i");
		    						$("#snmpOID").val("");
		    						$("#snmpOID").focus();
		    						return;
		    					}
		    			}else{
		    				document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=doAdd";
							document.Mkform.submit();
		    			}
		    		}
		    	}else{
		    		if($("#checkTypeName").val().length>63){
		    			$("#ctypeName").html("i18n_actsi.text.ctypeName.exception1_n81i");
		    		}
		    		if($("#tableName").val().length>20){
		    			$("#tableNameFont").html("i18n_actsi.text.tableNameFont.exception_n81i");
		    		}
		    	}
	    	}else{
	    		$("#ctypeName").html("i18n_actsi.text.ctypeName.exception2_n81i");
	    	}
		}	
	}
	
	function goBack(){
		document.Mkform.action="<%=path%>/detection/checkTypeSet.do?action=query";
		document.Mkform.submit();	
	}
	//验证非中文和特殊字符
	function containSpecial1(s)       
	{       
   		var cs = /^\w+$/;  
   		resu = cs.test(s);     
   		return (cs.test(s));       
	} 
	//验证oid
	function checkOID(oid){
		var cs = /^([1-9]|\.)([\d\.]+\d)?$/;
		var resu = cs.test(oid);
		return resu;
	}
	jQuery(function(){
		jQuery("td[id=usergroup]").hide();
		jQuery("td[id=viewLevel0]").attr('colspan','3').addClass('td_3').removeClass('td_2');
		if($("#isSnmp0").attr('checked')==true ||$("#isSnmp1").attr('checked')==true){	//oid显示且必选
	 		jQuery("td[id=oid]").show();
	 		jQuery("td[id=snmp]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 	}else{
			jQuery("td[id=oid]").hide();
			jQuery("td[id=snmp]").attr('colspan',3).addClass('td_2').removeClass('td_3');
		}
		//-- 查看权限事件绑定
	 	jQuery("input[type=radio][name=checkTypeInfo.viewLevel]").click(function(){
	 		if(jQuery(this).val() == 2){	//用户组显示且必选
	 			jQuery("td[id=usergroup]").show();
	 			jQuery("td[id=viewLevel0]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 		}else{	//用户组隐藏
	 			jQuery("td[id=usergroup]").hide();
	 			jQuery("#usergroupid").val("");
	 			jQuery("td[id=viewLevel0]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		}
	 	});
	 	//-- 是否为snmp监控事件绑定
	 	jQuery("input[type=radio][name=checkTypeInfo.isSnmp]").click(function(){
	 		if(jQuery(this).val() == 0 || jQuery(this).val() == 1){	//oid显示且必选
	 			jQuery("td[id=oid]").show();
	 			jQuery("td[id=snmp]").attr('colspan',1).addClass('td_3').removeClass('td_2');
	 		}else{	//用户组隐藏
	 			jQuery("td[id=oid]").hide();
	 			jQuery("#snmpOID").val("");
	 			jQuery("td[id=snmp]").attr('colspan',3).addClass('td_2').removeClass('td_3');
	 		}
	 	});
	 	//--验证OID失去焦点事件
	 	$("#snmpOID").focusout(function() {
		  if($("#snmpOID").val()!="" && checkOID($("#snmpOID").val())){
		  	$("#oidFont").attr('color','#009900').text("OIDi18n_actsi.text.lawful_n81i");
		  }
		});
	 	
	})
</script>
	<body>
		<div class="middle_list" >
		<div class="box_2">	
			<input type="button" class="btn3_mouseout"
				onmouseover="this.className='btn3_mouseover'"
				onmouseout="this.className='btn3_mouseout'"
				onmousedown="this.className='btn3_mousedown'"
				onmouseup="this.className='btn3_mouseup'"
				onclick="goBack()" value="i18n_actsi.button.back_n81i"/>
		 </div>
			<form action="" name="Mkform" method="post">
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_actsi.text.addCheckType_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="15%" align="right" nowrap="nowrap">
						i18n_actsi.text.checkTypeName1_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="checkTypeInfo.checkTypeName1" id="checkTypeName1"/>
						<font color="red">*</font>
								
					</td>
					<td class="color_1" width="10%" align="right" nowrap="nowrap">
						i18n_actsi.text.checkTypeName_n81i
					</td>
					<td class="color_3" width="35%" align="left">
						<input type="text" name="checkTypeInfo.checkTypeName" id="checkTypeName" value="${checkTypeIden }"/>
						<font id="ctypeName" color="red">*</font>
								
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right" nowrap="nowrap">
						i18n_actsi.text.tableName_n81i
					</td>
					<td class="color_3" width="30%" align="left">
						<input type="text" name="checkTypeInfo.tableName"
										id="tableName" value="DI_"/>
						<font id="tableNameFont" color="red">*</font>	
					</td>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_actsi.text.tableDesc_n81i
					</td>
					<td class="color_3"  align="left">
						<input type="text" name="checkTypeInfo.tableComments"
										id="tableName" />
							
					</td>
				</tr>
				<tr>
					<td class="td_1" nowrap="nowrap">i18n_actsi.text.viewPrivilege_n81i</td>
					<td class="td_3" id="viewLevel0">
					<c:if test="${!ADMFlag }">
						<input type="radio"	name="checkTypeInfo.viewLevel" id="" value="1" checked="checked" />i18n_actsi.text.viewPrivilege.publisher_n81i&nbsp;
						<input type="radio"	name="checkTypeInfo.viewLevel" id="viewLevel2" value="2" />i18n_actsi.text.viewPrivilege.publisherGroup_n81i&nbsp;
						<input type="radio" name="checkTypeInfo.viewLevel" id="" value="3" />i18n_actsi.text.viewPrivilege.allInSys_n81i&nbsp;
					</c:if>
					<c:if test="${ADMFlag }">
						<input type="radio" name="checkTypeInfo.viewLevel" id="" value="4" checked="checked"/>i18n_actsi.text.viewPrivilege.unlimited_n81i&nbsp;
					</c:if>
					</td>
					<td class="td_1"  id="usergroup">i18n_actsi.text.usergroup1_n81i</td>
					<td class="td_2"  id="usergroup">
						<select name="checkTypeInfo.groupId" id="usergroupid">
							<option selected="selected" value="">
								i18n_actsi.text.selectUserGroup_n81i
							</option>
							<c:forEach items="${setxtjs}"  var="stjs">
									<option   value="${stjs.jsbh}">
											${stjs.jsmc}
									</option>
							</c:forEach>
						</select>
						<font color="red" id="group_red">* </font>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_actsi.text.snmp_n81i
					</td>
					<td class="color_3"  align="left" id="snmp">
						<input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp1" value="1"  />SNMP4J
						<!-- <input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp0" value="0"  />ObjectSNMP -->
						<!-- 
						 -->
						<input type="radio" name="checkTypeInfo.isSnmp" id="isSnmp2" value="2" checked="checked"/>i18n_actsi.text.NO_n81i
					</td>
					<td id="oid" class="color_1"  align="right" valign="top" nowrap="nowrap">
						OID
					</td>
					<td id="oid" class="color_3"  align="left">
						<input type="text" name="checkTypeInfo.snmpOID" id="snmpOID" size="30"/>
						<font id="oidFont" color="red">*</font>	
					</td>
					<!-- 
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						存在是否替换
					</td>
					<td class="color_3"  align="left">
						<input type="radio" name="replace" id="yes" value="1"  checked="checked"/>是
						<input type="radio" name="replace" id="no" value="2" />否
					</td>
					 -->
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_actsi.text.isSchedule_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<input type="radio" name="isSchedule" value="1" disabled="disabled" checked="checked"/>i18n_actsi.text.NO_n81i
						<input type="hidden" name="checkTypeInfo.isSchedule" value="1"/>
					</td>
				</tr>
				<tr>
					<td class="color_1"  align="right" valign="top" nowrap="nowrap">
						i18n_actsi.text.remark_n81i
					</td>
					<td class="color_3"  align="left" colspan="3">
						<textarea rows="3" cols="50" name="checkTypeInfo.checkRemark" id="checkRemark"></textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_actsi.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()"
								value="i18n_actsi.button.reset_n81i"/>
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
