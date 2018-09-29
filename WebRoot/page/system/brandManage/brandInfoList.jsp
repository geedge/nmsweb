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
		<title>i18n_bril.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>

	</head>

	<script language="javascript" type="text/javascript">	
      var msg = '${MSG}';
      if(msg=='1'){
		alert("i18n_bril.message.success_n81i");
	    }else if(msg=='2'){
		alert("i18n_bril.message.faild_n81i");
	  }	 
	  
	  //新增品牌信息
	  function toAddBrand() {
	  	document.form3.action = "<%=path%>/sysManage/brandManage!executeAction.do?action=toAddBrand";
	  	document.form3.submit();
	  }; 
	  //修改品牌信息
	  function toUpdateBrand() {
	  	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_bril.message.selectOne_n81i");
	 	}else{
	 	    //获取选择的品牌信息
		 	document.form3.action = "<%=path%>/sysManage/brandManage!executeAction.do?action=toUpdateBrand";
	  		document.form3.submit();
		}
	  }; 
	  
	  //查询记录
	  function qry(){
		document.form3.action = "<%=path%>/sysManage/brandManage.do?action=queryBrandInfo";
		document.form3.submit();		
	  }
	  
	  //品牌详细信息
	  function detail(brandId) {
	  	document.form3.action = "<%=path%>/sysManage/brandManage.do?action=detailBrand&brandId="+brandId;
		document.form3.submit();		
	  }
	  
	   //删除品牌信息
	  function deleteBrand() {
	    if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_bril.message.selectOne_n81i");
	 	}else if(confirm("i18n_bril.message.delete_n81i")){
		    document.form3.action = "<%=path%>/sysManage/brandManage.do?action=deleteBrand";
	     	document.form3.submit();
		}
	  }; 
	
    </script>


	<body>
	<div class="middle_list">
		<form name="form3" id="frmArticleType"
			action="<c:url value='/sysManage/brandManage.do?action=queryBrandInfo'/>" method="post">
			<div class="box_1">		 
					<label class="divTopText"><font class="selectText">i18n_bril.text.brandName_n81i</font>
					<input  style="width:140px;" name="brandNameForSearch" id="brandNameForSearch" value="${brandNameForSearch}"></label>
					<img src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle" onclick="javascript:qry();" />
			</div>
			<div class="box_2"><jsp:include page="/include/include.jsp" /></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td width="6%" class="color_top">
						<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />i18n_bril.text.index_n81i
					</td>
					<td width="12%" class="color_top">
						i18n_bril.text.brandName_n81i
					</td>
					<td width="10%" class="color_top">
						i18n_bril.text.brandDesc_n81i
					</td>
					<td width="10%" class="color_8">
						i18n_bril.text.brandOid_n81i
					</td>
				</tr>
				<c:set var="index" value="${1}" />
				<c:choose>
				 
					<c:when test="${fn:length(brandListInfo) > 0}">
						<c:forEach items="${brandListInfo}" var="brand" varStatus="vs">
							<c:set var="color" value="color_1"/>
							<c:set var="color_end" value="color_7"/>
							<c:if test="${vs.count%2!=0 }">
								<c:set var="color" value="color_3"/>
								<c:set var="color_end" value="color_6"/>
							</c:if>
							<tr >
								<td class="${color }">
									<input type="checkbox" name="ids" id="ids" value="${brand.id}" />${index+(pageNo-1)*pageSize}
								</td>
								<td class="${color }">
									<a href="javascript:detail('${brand.id}');">${brand.brandName}</a>
								</td>
								<td class="${color }">
									${brand.brandDesc}
								</td>
								<td class="${color_end }">
									${brand.brandOid}
								</td>
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6" align="center" class="color_6">
								i18n_bril.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<c:if test="${!empty brandListInfo}">
				<jsp:include page="/common/page.jsp" />
			</c:if>
		</form>
		</div>
	</body>
</html>

