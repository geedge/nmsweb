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
		<title>i18n_ctsl.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
	</head>

	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_ctsl.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_ctsl.message.faild_n81i");
	  }	  
	  
	//添加记录
	 function add(id){		 	
		document.form3.action = "<%=path%>/detection/metaDataSet!executeAction.do?action=oppAdd&typeids="+id;
		document.form3.submit();
	 }
	 //批量修改记录:
	 function upd(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ctsl.error.itemSelect_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=oppUpdList";
			document.form3.submit();
		}
	 }
	 //修改记录,暂时不用
	 function updOld(){
	 	//alert(1);
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_ctsl.error.itemSelect1_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=oppUpd";
			document.form3.submit();
		}
	 }
	 
	 //生成数据表
	 function createTable(){
	 	if(confirm("i18n_ctsl.message.isCreateTable_n81i")){
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=createTab";
			document.form3.submit();
		}
	 }
	 //向数据表添加字段
	 function addFiled(){
	 	if(confirm("i18n_ctsl.message.isAddFiled_n81i")){
		 	document.form3.action ="<%=path%>/detection/metaDataSet!executeAction.do?action=addFiled";
			document.form3.submit();
		}
	 }
	 
	 //停用:将METADATA表中的STATE字段置为1
	 function startUpOrStop(type) {
	    if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_ctsl.error.itemSelect_n81i");
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
		document.form3.action ="<%=path%>/detection/checkTypeSet.do?action=query";
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
	
	function goGuide(datas) {
		if(datas!=null && datas!=""){
		 	if(datas.resu=='over') {
		 		window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
			}
		 }
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
		
		if($("#isComplete").val()=='0'){
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:9,
		 					packName:'jclbysj'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_ctsl.message.warningDetecationMetaDate_n81i", "i18n_ctsl.message.hint_n81i", submit,{icon: false});
		}
		
		if($("#isJclbComplete").val()=='0'){
			var submit = function (v, h, f) {
				if (v == 'yes') {
					$("input[type=hidden][name=fromWhere]").val('formGuide');
			        return;
				}
				if (v == 'no') {
					$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
		 				{
		 					packNum:8,
		 					packName:'jclb'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_ctsl.message.warningDetecationType_n81i", "i18n_ctsl.message.hint_n81i", submit,{icon: false});
		}
		
		$("#info").floatHeaderDiv();
	});
	window.onresize = function(){
		$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
	}
    </script>

	<body>
	<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType"
			action="<c:url value='/detection/metaDataSet.do'/>" method="post">
			<input type="hidden" name="typeids" value="${typeids[0]}"/>
			<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
			<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
			<input type="hidden" name = "isJclbComplete" id="isJclbComplete" value="${isJclbComplete}"/>
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<input type="hidden" name="isSnmp" value="${isSnmp }"/>
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<div id="divTop">
				<div class="box_2">
					<c:if test="${isSch=='0'&& isHaveTable=='no'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="add(${typeids[0]})" value="i18n_ctsl.button.add_n81i" disabled="disabled"/>	<!-- 预置表的新增 -->
					</c:if>
					<c:if test="${isSch=='1'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="add(${typeids[0]})" value="i18n_ctsl.button.add_n81i"
										${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}/>
					</c:if>
					&nbsp;
					<c:if test="${isSch=='0' && isHaveTable=='no'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="upd()" value="i18n_ctsl.button.update_n81i" disabled="disabled"/>
					</c:if>
					<c:if test="${isSch=='1'}">
							<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="upd()" value="i18n_ctsl.button.update_n81i"
										${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}/>	
					</c:if>
					&nbsp;
					<c:if test="${isHaveTable=='no'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="createTable()" value="i18n_ctsl.button.createTable_n81i"
								${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}
									/>
					</c:if>
					&nbsp;
					<c:if test="${isSch=='1'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="startUpOrStop(1)" value="i18n_ctsl.button.stop_n81i"/> <!-- 非预置的表才有停用 -->
					</c:if>
					&nbsp;
					<c:if test="${isSch=='1'}">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="startUpOrStop(0);" value="i18n_ctsl.button.start_n81i"/> <!-- 非预置的表才有启用 -->
					</c:if>
					&nbsp;
					<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_ctsl.button.back_n81i" style="margin-right: 20px"/>
				</div>
				
			</div>
			<div style="height: 25px"></div>
			<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td width="6%" class="color_top">
							<input type="checkbox"
									name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_ctsl.text.index_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_ctsl.text.detecationType_n81i
						</td>
						<td width="12%" class="color_top">
							i18n_ctsl.text.tableName_n81i
						</td>
						<td width="12%" class="color_top">
							i18n_ctsl.text.tableComments_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_ctsl.text.filedName_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_ctsl.text.filedDesc_n81i
						</td>
						<td width="8%" class="color_top">
							i18n_ctsl.text.filedType_n81i
						</td>
						<td width="8%" class="color_top">
							i18n_ctsl.text.isMetaDateState_n81i
						</td>
						<td width="8%" class="color_top">
							i18n_ctsl.text.isChartState_n81i
						</td>
						<td width="7%" 
						    <c:if test="${isSnmp != 1 && isSnmp!=0}"> class="color_8"</c:if>
						    <c:if test="${isSnmp == 1||isSnmp==0}"> class="color_top"</c:if>
						>
							i18n_ctsl.text.transIndex_n81i
						</td>
						
						<c:if test="${isSnmp == 1||isSnmp==0}">
							<td width="9%" class="color_8">
								OID
							</td>
						</c:if>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(metadataList) > 0}">
							<c:forEach items="${metadataList}" var="metadata" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr>
									<td class="${color }">
										<c:if test="${isSch=='0'}">
											<input type="checkbox" name="ids" id="ids"
												value="${metadata.id}" disabled="disabled"/>
										</c:if>
											
										<c:if test="${isSch=='1'}">
											<input type="checkbox" name="ids" id="ids" ${(ADMFlag && checkTypeInfo.viewLevel ne 4) || (!ADMFlag && checkTypeInfo.viewLevel eq 4) ? "disabled='disabled'":""}
												value="${metadata.id}" />
										</c:if>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										${metadata.checkTypeInfo.checkTypeName}
									</td>
									<td class="${color }">
										${metadata.checkTypeInfo.tableName}
									</td>
									<td class="${color }">
										${metadata.checkTypeInfo.tableComments}
									</td>
									<td class="${color }">
										${metadata.filedName}
									</td>
									<td class="${color }">
										${metadata.filedComments}
									</td>
									<td class="${color }">
										${metadata.filedType}
									</td>
									<td class="${color }">
										<c:if test="${metadata.state=='0' }">i18n_ctsl.button.start_n81i</c:if>
										<c:if test="${metadata.state=='1' }"><font color="red">i18n_ctsl.button.stop_n81i</font></c:if>
									</td>
									<td class="${color }">
										<c:if test="${metadata.chartState=='0' }">i18n_ctsl.message.yes_n81i</c:if>
										<c:if test="${metadata.chartState=='1' }">i18n_ctsl.message.no_n81i</c:if>
									</td>
									<td 
									     <c:if test="${metadata.checkTypeInfo.isSnmp == 1||metadata.checkTypeInfo.isSnmp==0}">class="${color }"</c:if> 
										  <c:if test="${metadata.checkTypeInfo.isSnmp != 1&&metadata.checkTypeInfo.isSnmp!=0}">class="${color_end }"</c:if> 
									>
										${metadata.showNum}
									</td>
									<c:if test="${metadata.checkTypeInfo.isSnmp == 1||metadata.checkTypeInfo.isSnmp == 0}">
										<td class="${color_end }">
											${metadata.oid}
										</td>
									</c:if>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td 
	                                   <c:if test="${isSnmp != 1 && isSnmp!=0}"> colspan="10" </c:if>
						               <c:if test="${isSnmp == 1||isSnmp ==0}"> colspan="11" </c:if>	
	                                                                                    class="color_6" align="center">
									i18n_ctsl.message.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty metadataList}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>
		</div>
	</body>
</html>

