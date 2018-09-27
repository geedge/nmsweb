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
		<title>i18n_dbil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>	
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
			<style type="text/css">			
				.mydiv {
				background-color:#fff;
				border: 1px solid #000;
				text-align: center;
				line-height: 40px;
				font-size: 12px;
				font-weight: bold;
				z-index:99;
				width: 220px;
				height: 80px;
				left:50%;/*FF IE7*/
				top: 50%;/*FF IE7*/
				
				margin-left:-150px!important;/*FF IE7 该值为本身宽的一半 */
				margin-top:-60px!important;/*FF IE7 该值为本身高的一半*/
				
				margin-top:0px;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				
				
				.bg {
				background-color: #ccc;
				width: 100%;
				height: 100%;
				left:0;
				top:0;/*FF IE7*/
				filter:alpha(opacity=50);/*IE*/
				opacity:0.5;/*FF*/
				z-index:1;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				/*The END*/
				
			</style>

	</head>

	<script language="javascript" type="text/javascript">	
	  
	  //新增品牌信息
	  function toAddDevBrand() {
	  	document.form3.action = "<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=toAddDevBrand";
	  	document.form3.submit();
	  }; 
	  //修改品牌信息
	  function toUpdateDevBrand() {
	  	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_dbil.message.selectOne_n81i");
	 	}else{
	 	    //获取选择的品牌信息
		 	document.form3.action = "<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=toUpdateDevBrand";
	  		document.form3.submit();
		}
	  }; 
	  
	  //查询记录
	  function qry(){
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
		document.form3.submit();		
	  }
	  
	  //品牌详细信息
	  /*function detail(brandId) {
	  	document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=detailBrand&brandId="+brandId;
		document.form3.submit();
	  }*/
	  
	   //删除品牌信息
	  function deleteDevBrand() {
	    if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_dbil.message.selectOne_n81i");
	 	}else if(confirm("i18n_dbil.message.delete_n81i")){
		    document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=deleteDevBrand";
	     	document.form3.submit();
		}
	  }

	// 程辉 2013-5-8 新增 模板下载 
	function downloadExample() {
		document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=downloadExample";
		document.form3.submit();
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
	}

	//程辉 2013-5-8 新增 导入
	function importXls() {
		var myfileVal = document.getElementById("myFile").value;
		if(myfileVal=="") {
			alert("i18n_dbil.message.selectImportFile_n81i");
		}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
			alert("i18n_dbil.message.selectCorrectFile_n81i");
		}else if(confirm('i18n_dbil.message.sureToImport_n81i')){
			document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=importXls";
			document.form3.submit();
			document.form3.action ="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
		}
	}
	//程辉 2013-5-8 新增 导出当前页
	function emportCurrentXls() {
		document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=emportCurrentXls&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&brandNameForSearch="+$("#brandNameForSearch").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
	}
	//程辉 2013-5-8 新增 导出全部
	function emportAllXls() {
		document.form3.action = "<c:url value='/'/>/sysManage/deviceBrandManage.do?action=emportAllXls&brandNameForSearch="+$("#brandNameForSearch").val();
		document.form3.submit();
		closeDiv();
		document.form3.action = "<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo";
	}
	function showDiv(){
		document.getElementById('popDiv').style.display='block';
		document.getElementById('bg').style.display='block';
	}

	function closeDiv(){
		document.getElementById('popDiv').style.display='none';
		document.getElementById('bg').style.display='none';
	}
		
	 
    </script>


	<body>
	<div class="middle_list">
		<form name="form3" id="frmArticleType"
			action="<c:url value='/sysManage/deviceBrandManage.do?action=queryDeviceBrandInfo'/>" method="post"  enctype="multipart/form-data">
			<div class="box_1">		 
					<label class="divTopText"><font class="selectText">i18n_dbil.text.brandName_n81i </font>
					<input  style="width:140px;" name="brandNameForSearch" id="brandNameForSearch" value="${brandNameForSearch}"></label>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle2" onclick="javascript:qry();" />
			</div>
			<div class="box_2">
			<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_dbil.button.downloadExample_n81i"/>
								&nbsp;		
			
			<input type="button" value="i18n_dbil.text.importXls_n81i" title="i18n_dbil.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_dbil.buton.importXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_dbil.buton.exportXls_n81i"/>
								&nbsp;		
			<jsp:include page="/include/include.jsp" /></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table" style="clear: left;">
				<tr>
					<td width="6%" class="color_top">
						<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_dbil.text.index_n81i
					</td>
					<td width="12%" class="color_top">
						i18n_dbil.text.deviceRandCode_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_dbil.text.deviceRandName_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_dbil.text.deviceBrandDesc_n81i
					</td>
					<td width="10%" class="color_8">
						i18n_dbil.text.addTime_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
				 
					<c:when test="${fn:length(devBrandListInfo) > 0}">
						<c:forEach items="${devBrandListInfo}" var="devBrand" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
							</c:if>
							<tr >
								<td class="${color }">
									<input type="checkbox" name="ids" id="ids" value="${devBrand.id}" />${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }">
									${devBrand.deviceRandCode}
								</td>
								<td class="${color }">
									${devBrand.deviceRandName}
								</td>
								<td class="${color}">
									${devBrand.deviceBrandDesc}
								</td>
								<td class="${color_end}">
									<fmt:formatDate value="${devBrand.addTime}" type="both" /> 
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5" align="center" class="color_6">
								i18n_dbil.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<c:if test="${!empty devBrandListInfo}">
				<jsp:include page="/common/page.jsp" />
			</c:if>
		</form>
		</div>
		<div id="popDiv" class="mydiv" style="display:none;">
		<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width:100px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportCurrentXls();" value="i18n_dbil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_dbil.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_dbil.text.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>

