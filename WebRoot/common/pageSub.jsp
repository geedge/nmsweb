<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
		<script language="javascript" type="text/javascript">
			function pageUrl(formaction){
				pageList(${pageNoSub},formaction);
			}
			function pageList(pageNoSub,formaction){
			        //var pageSize = $("#pageSize").val();//总是提示缺少对象
			        //var pageSize = document.getElementById("pageSize").value;
					var url = '';
					if(formaction != null && formaction != ''){
						url = formaction;
					}else{
						url = document.forms[0].action;
					}
					var frm = document.forms[0];
					if(url.split("?").length>1){
						document.forms[0].action = url +'&pageNoSub='+pageNoSub;
					}else{
						document.forms[0].action = url +'?pageNoSub='+pageNoSub;
					}
					//遮盖层
					//coverDiv();
					document.forms[0].submit();
			}
			function go(){
				var pageNoSub = document.getElementById("pageNoSub").value;
				var pageSizeSub = document.getElementById("pageSizeSub").value;
			//	alert(pageNo);
			//	alert(pageSize);
				if(pageNoSub.replace(/[\d+]/ig,"").length>0){
					alert('i18n_pageSub.text.inputNum_n81i');
					return ;
				}
				if(pageNoSub<=0){
					alert("i18n_pageSub.text.tooSmall_n81i");
					return ;
				}
				//if(pageNo>${page.totalPage}){
					//alert("输入的页码太大，请重新输入的页数");
					//return ;
				//}
				var frm = document.forms[0];
				document.forms[0].action = document.forms[0].action+'?pageNoSub='+pageNoSub+'&pageSizeSub='+pageSizeSub;
				//遮盖层
				coverDiv();
				document.forms[0].submit();
			}
			function limitNum(obj) {
			    if(obj.value.replace(/[\d+]/ig,"").length>0) {
			        alert('i18n_pageSub.text.inputNum_n81i')
			        obj.value="";
			        return false;
			    }
			}
			function boo(tanleName,countHql){
				CountAction.getLogCount(tanleName,countHql,${pageNoSub},{callback:function(data){
						document.getElementById("log").innerHTML=data;
					}}
					);
			}
</script>
</head>
<body>
<div class="box_3"><c:if test="${pageSub.totalCount != 0}">i18n_page.text.total_n81i<span class="page_style2">${pageSub.totalCount}</span> i18n_page.text.record_n81i，</c:if>
					<c:if test="${pageSub.totalCount == 0}">i18n_page.text.total_n81i<span class="page_style2">0</span> i18n_page.text.record_n81i，</c:if>
						i18n_page.text.current_n81i
						<span class="page_style2">
						<c:if test="${pageSub.totalCount != 0}"><span id="currentPage"> ${pageNoSub} </span>/${pageSub.totalPage} </c:if>
						<c:if test="${pageSub.totalCount == 0}"><span id="currentPage"> 0 </span>/0 </c:if> </span>页</div>
<div class="box_2">i18n_page.text.change_n81i
	<select class="option2" onchange="javascript:pageList($(this).val())" id="pageNoSub" name="pageNoSub">
		<c:forEach var="page0" begin="1" end="${pageSub.totalPage }" step="1">
		      <option value="${page0 }" ${pageNoSub==page0?"selected":""} >${page0 }</option>
		</c:forEach>
    </select>i18n_page.text.page_n81i
   i18n_page.text.pageSize_n81i
	<select name="pageSizeSub" onchange="javascript:pageList(1)" id="pageSizeSub" class="option2" style="width: 50px;">
		<option value="10" ${pageSizeSub=="10"?"selected":""}>
			10
		</option>
		<option value="20" ${pageSizeSub=="20"?"selected":""}>
			20
		</option>
		<option value="30" ${pageSizeSub=="30"?"selected":""}>
			30
		</option>
		<option value="50" ${pageSizeSub=="50"?"selected":""}>
			50
		</option>
		<option value="100" ${pageSizeSub=="100"?"selected":""}>
			100
		</option>
		<option value="200" ${pageSizeSub=="200"?"selected":""}>
			200
		</option>
	</select>
  <c:if test="${pageNoSub > 1}">
   	<img src="<c:url value="/images/button_up.png" />" class="img_middle" onclick="pageList(${pageNoSub-1})"/>
  </c:if>
  &nbsp;
   <c:if test="${pageNoSub < pageSub.totalPage}">
   	<img src="<c:url value="/images/button_down.png" />" class="img_middle" onclick="pageList(${pageNoSub+1})"/>
  </c:if>
</div>
</body>
