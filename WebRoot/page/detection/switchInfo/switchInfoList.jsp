<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="nis.nms.util.MyNumberFormat"%>
<%@page import="nis.nms.bean.SwitchPortInfo"%>
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
		<title>i18n_sil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script src="<c:url value='/js/lockTableHeader.js'/>" type="text/javascript"></script>	
	
	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_sil.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_sil.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function add(id){
		document.form3.action = "<%=path%>/detection/metaDataSet!executeAction.do?action=oppAdd&typeids="+id;
		document.form3.submit();
	 }
	 //批量修改记录:
	 function upd(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_sil.message.selectInfo1_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=oppUpdList";
			document.form3.submit();
		}
	 }
	 //修改记录,暂时不用
	 function updOld(){
	 	//alert(1);
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_sil.message.selectInfo2_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=oppUpd";
			document.form3.submit();
		}
	 }
	 
	 //生成数据表
	 function createTable(){
	 	if(confirm("i18n_sil.message.sureToCreate_n81i")){
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=createTab";
			document.form3.submit();
		}
	 }
	 //向数据表添加字段
	 function addFiled(){
	 	if(confirm("i18n_sil.message.sureToAdd_n81i")){
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=addFiled";
			document.form3.submit();
		}
	 }
	 
	 //停用:将METADATA表中的STATE字段置为1
	 function startUpOrStop(type) {
	    if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_sil.message.selectInfo1_n81i");
	 	}else {
	 		var num = jQuery("input[name='ids']:checked").size();
	 		var mids = new Array(num);
		 	jQuery("input[name='ids']:checked").each(function(i){
			   mids[i]=$(this).val();
			});
			
	 		jQuery.post("<c:url value='/'/>detection/metaDataSet!getState.do",{ids:mids.toString()},function(datas){checkIsState(datas,type);},"json");
	 		
		}
	 }
	 
	 function checkIsState(datas,type) {
	 	if(datas!=null && datas.length>0) {
	 		if(type=='1'){//停用
	 			document.form3.action="<%=path%>/detection/metaDataSet.do?action=stop";
				document.form3.submit();
	 		}else{//启用
	 			document.form3.action="<%=path%>/detection/metaDataSet.do?action=start";
			    document.form3.submit();
	 		}
		}
	 }
	 
	 function goBack(){
		document.form3.action ="<%=path%>/detection/switchDetection.do?action=query";
		document.form3.submit();
	 }
	 
	 function ieBrowser(){
		if($.browser.msie){
			if($.browser.version.split('.')[0]<=7){
				return false;
			}else{
				return true;//ie8+
			}
		}
	}

	//程辉 2013-5-8 新增 导出
	function emportXls() {
		document.form3.action = "<c:url value='/'/>/detection/switchDetection.do?action=emportXls&detectId="+'${detectId}'+"&seqId="+'${seqId}'+"&checkDate="+'${checkDate}';
		document.form3.submit();
	}
	
	$(function(){
		var dh = document.body.clientHeight; 
		var dhh = dh-60+"px;";
		var tableHeight = $("#info").height();
		if(tableHeight > dh-60){
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
			if(ieBrowser()){
				$("#info").attr("style","width:100%;");
			}else{
				$("#info").attr("style","width:98.5%;");
			}
		}else{
			$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
			$("#info").attr("style","width:100%;");
		}		
		$("#info").floatHeaderDiv();
		//tableHeaderNavigator('I3','info');
	});
	

    </script>

	</head>
	<body>
	<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/switchDetection.do?action=singleSwitchInfo'/>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="typeids" value="${typeids[0]}"/>
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<input type="hidden" name="networElementType" id="networElementType" value="${networElementType }" />
			<!-- 来源于拓扑图 begin -->
			<input type="hidden" name="requestType" value="${requestType }" />
			<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
			<input type="hidden" name="nodeIp" value="${nodeIp }" />
			<!-- 来源于拓扑图 end -->	
			<div id="divTop">
				<div class="box_2">
				<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="emportXls()" value="i18n_sil.button.export_n81i"/>
					<c:if test="${isSch=='0'&& isHaveTable=='no'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="add(${typeids[0]})" value="i18n_sil.button.add_n81i" disabled="disabled"/>	<!-- 预置表的新增 -->
					</c:if>
					<c:if test="${isSch=='1'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="add(${typeids[0]})" value="i18n_sil.button.add_n81i"
										${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}/>
					</c:if>
					<c:if test="${isSch=='0' && isHaveTable=='no'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="upd()" value="i18n_sil.button.update_n81i" disabled="disabled"/>
					</c:if>
					<c:if test="${isSch=='1'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="upd()" value="i18n_sil.button.update_n81i"
										${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}/>	
					</c:if>
					<c:if test="${isHaveTable=='no'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="createTable()" value="i18n_sil.button.createTable_n81i"
								${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}
									/>
					</c:if>
					<c:if test="${isSch=='1'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="startUpOrStop(1)" value="i18n_sil.button.stop_n81i"/> <!-- 非预置的表才有停用 -->
					</c:if>
					<c:if test="${isSch=='1'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="startUpOrStop(0);" value="i18n_sil.button.start_n81i"/> <!-- 非预置的表才有启用 -->
					</c:if>
					<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_sil.button.back_n81i"/>
				</div>
			</div>
			<div id="maindiv">
			<c:if test="${si ne null}">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="switchInfo">
					<tr >
						<td colspan="4" class="color_8">
							<strong>i18n_sil.text.switchIp_n81i:${switchIp } i18n_sil.text.title_n81i</strong>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_sil.text.sysDescr_n81i：
						</td>
						<td class="color_3" align="left" >
							${si.sysDescr}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" width="20%">
							i18n_sil.text.sysObjectID_n81i：
						</td>
						<td class="color_3" align="left" >
							${si.sysObjectID}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right" >
							i18n_sil.text.upTimeStr_n81i：
						</td>
						<td class="color_3" align="left" >
							${si.upTimeStr}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_sil.text.sysContact_n81i：
						</td>
						<td class="color_3" align="left">
							${si.sysContact}	
						</td>
						
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_sil.text.sysName_n81i：
						</td>
						<td class="color_3" align="left">
							${si.sysName}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_sil.text.sysLocation_n81i：
						</td>
						<td class="color_3" align="left">
							${si.sysLocation}	
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_sil.text.sysServices_n81i：
						</td>
						<td class="color_3"align="left">
						${si.sysServices}	
							<fmt:formatDate value="${detectionInfoNew.detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_sil.text.checkedTimeStr_n81i：
						</td>
						<td class="color_3" align="left">
						${si.checkedTimeStr}	
							<fmt:formatDate value="${detectionInfoNew.detectionSetInfo.planCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</table>
			</c:if>
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td width="3%" class="color_top">
							i18n_sil.text.index_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_sil.text.ifDescr_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.ifHighSpeed_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_sil.text.ifOperStatus_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.ifInOctetsSpeed_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.inpktsspeed_n81i
						</td>
						<!-- 
						<td width="7%" class="color_top">
							输入丢包率(%)
						</td>
						<td width="7%" class="color_top">
							输入差错率(pps)
						</td>
						 -->
						<td width="7%" class="color_top">
							i18n_sil.text.ifindiscardsVary_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.ifinerrorsVary_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.ifOutOctetsSpeed_n81i
						</td>
						<td width="8%" class="color_top">
							i18n_sil.text.outpktsspeed_n81i
						</td>
						<!-- 
						<td width="7%" class="color_top">
							输出丢包率(%)
						</td>
						<td width="7%" class="color_top">
							输出差错率(pps)
						</td>
						 -->
						 <td width="7%" class="color_top">
							i18n_sil.text.ifoutdiscardsVary_n81i
						</td>
						<td width="7%" class="color_top">
							i18n_sil.text.ifouterrorsVary_n81i
						</td>
						<td width="13%" class="color_top">
							i18n_sil.text.lastStringTime_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<%
						List<SwitchPortInfo> siList = (List<SwitchPortInfo>) request.getAttribute("totalSiList");
						if(siList!=null && siList.size()>0){
							int vs = -1;
							for(SwitchPortInfo si : siList){
								vs++;
								pageContext.setAttribute("vs",vs);
								pageContext.setAttribute("si",si);
							 %>
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								
								<tr>
									<td class="${color }">
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										${si.ifDescr}
									</td>
									<td class="${color }">
										 <%=(si.getIfHighSpeed() ==null?MyNumberFormat.formatStr1(new BigDecimal(si.getIfSpeed()),0,1000):si.getIfHighSpeed()+"Mbps") %>
									</td>
									<td class="${color }">
										${si.ifOperStatus}
									</td>
									<td class="${color }">
										<%=MyNumberFormat.formatStr1(si.getIfInOctetsSpeed()==null?null:(new BigDecimal(si.getIfInOctetsSpeed()).multiply(new BigDecimal(8))),0,1024) %>
									</td>
									<td class="${color }">
										<c:if test="${si.inpktsspeed ne null }"> 
											<%=new BigDecimal(si.getInpktsspeed()).setScale(0,BigDecimal.ROUND_UP) %>pps
										</c:if>
									</td>
									<td class="${color }">
										${si.ifindiscardsVary}
									</td>
									<td class="${color }">
										${si.ifinerrorsVary}
									</td>
									<!-- 
									<td class="${color }">
										${si.ifInErrorsScale}
									</td>
									<td class="${color }">
										${si.ifInErrorsScale}
									</td>
									 -->
									<td class="${color }">
										<%=MyNumberFormat.formatStr1(si.getIfOutOctetsSpeed()==null?null:(new BigDecimal(si.getIfOutOctetsSpeed()).multiply(new BigDecimal(8))),0,1024) %>
									</td>
									<td class="${color }">
										<c:if test="${si.outpktsspeed ne null }">
											<%=new BigDecimal(si.getOutpktsspeed()).setScale(0,BigDecimal.ROUND_UP) %>pps
										</c:if>
									</td>
									<td class="${color }">
										${si.ifoutdiscardsVary}
									</td>
									<td class="${color }">
										${si.ifouterrorsVary}
									</td>
									<td class="${color }">
										${si.lastStringTime}
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							 <%
							}
						}else{
						  %>
							<tr>
								<td  colspan="13" class="color_6" align="center">
									i18n_sil.text.noRecord_n81i
								</td>
							</tr>
						  <%
						}
					   %>
				</table>
			</div>
			<!-- <div id="divBoot">
			
				<---jsp:include page="/common/page.jsp" />
			
			</div> -->
		</form>
		</div>
	</body>
</html>

