<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.util.Page"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String message = request.getParameter("pageMessage");
	
	Page page2=(Page)request.getAttribute("page");
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<style type="text/css">

</style>
		<script>
		function loadButton(){
			//获取上一页的按钮
			var prev = $("#prev").html();
			var currenttotalPage = $("#currenttotalPage").html();
			var currentPage = $("#currentPage").html();
			if(!prev){//没有上一页按钮  
				if(currentPage!="1"){ //如果只有1页的时候滚动不会加载出上一页
					$("#prev").html("<img src=\"<c:url value="/images/button_up.png" />\" class=\"img_middle\" onclick=\"pageList(\'prev\')\"/>");
				}        
			}
			//删除下一页的按钮
			var next = $("#next").html();
			if((Number(currentPage) == Number(currenttotalPage))&&(next!=null&&next!="")){
				$("#next").html("");
			}
			$("select[name=textfield]").val(currentPage);	//滚动时修改 当前页数的select
		}
function pageUrl(formaction){
	pageList(${pageNo},formaction);
}

function pageList(pageNo,formaction){
if(pageNo == 'prev'){
	pageNo = Number($("#currentPage").html()) -1;
	if(pageNo < 0){
		pageNo = pageNo + 1;
	}
}
if(pageNo == 'next'){
var currenttotalPage = $("#currenttotalPage").html();
	pageNo = Number($("#currentPage").html()) +1;
	if(pageNo > currenttotalPage){
		pageNo = pageNo -1;
	}
}
var newPageSize = document.getElementById("newPageSize").value;
//alert(newPageSize);
		var url = '';
		if(formaction != null && formaction != ''){
		url = formaction;
		}else{
		url = document.forms[0].action;
		}
		var frm = document.forms[0];
	//	alert(url);
		if(url.indexOf("?")!=-1)
			document.forms[0].action = url +'&pageNo='+pageNo+'&pageSize='+newPageSize;
		else 
			document.forms[0].action = url +'?pageNo='+pageNo+'&pageSize='+newPageSize;
	//	alert(document.forms[0].action);
		//遮盖层
		//coverDiv();
		document.forms[0].submit();
}
function go(){
	var pageNo = document.getElementById("pagesize").value;
	var newPageSize = document.getElementById("newPageSize").value;
	//if(pageNo.replace(/[\d+]/ig,"").length>0){
	//	alert('请输入数字');
	//	return ;
	//}
	//if(pageNo<=0){
	//	alert("输入的页码太小，请重新输入的页数");
	//	return ;
	//}
	//if(pageNo>${page.totalPage}){
	//	alert("输入的页码太大，请重新输入的页数");
	//	return ;
	//}
	var frm = document.forms[0];
	var url = document.forms[0].action;
	
	if(url.indexOf("?")!=-1)
			document.forms[0].action = url +'&pageNo='+pageNo+'&pageSize='+newPageSize;
	else 
		document.forms[0].action = url +'?pageNo='+pageNo+'&pageSize='+newPageSize;
	//document.forms[0].action = document.forms[0].action+'&pageNo='+pagesize+'&pageSize='+newPageSize;
	//遮盖层
	//coverDiv();
	document.forms[0].submit();
}
function limitNum(obj) {
    if(obj.value.replace(/[\d+]/ig,"").length>0) {
        alert('i18n_page.message.inputNum_n81i')
        obj.value="";
        return false;
    }
}
//function boo(tanleName,countHql){
//		CountAction.getLogCount(tanleName,countHql,${pageNo},{callback:function(data){
//				document.getElementById("log").innerHTML=data;
//			}}
//			);
//	}
</script>
	</head>

	<body>
	<div class="box_3">
		<c:if test="${page.totalCount != 0}">i18n_page.text.total_n81i<span class="">${page.totalCount}</span> i18n_page.text.record_n81i，</c:if>
						i18n_page.text.current_n81i
						<span class=""><span id="currentPage">${pageNo}</span><c:if
								test="${page.totalCount != 0}">/<span id="currenttotalPage">${page.totalPage}</span></c:if></span>i18n_page.text.page_n81i
	</div>
	<div class="box_2">
		i18n_page.text.change_n81i <select class="option2" onchange="go();" id="pagesize"
													name="textfield" >
							<%
							
							for(int n=1;n<=page2.getTotalPage();n++)
							{
							%>						
           <option value="<%=n %>" ><%=n %></option>
	       <%} %>
	       
         </select>
         <script >
	         var sel=document.getElementById("pagesize");
	         var op=sel.options;
	         for(var i=0;i<op.length;i++)
	         {
		         if(op[i].value==${pageNo})
		         {
		         	op.selectedIndex=i;
		         }
	         }
         </script>
         	i18n_page.text.page_n81i  i18n_page.text.pageSize_n81i <select name="pageSize"
						onchange="javascript:pageList(1)" id="newPageSize" class="option2_1">
						<option value="10" ${pageSize=="10"?"selected":""}>
							10
						</option>
						<option value="20" ${pageSize=="20"?"selected":""}>
							20
						</option>
						<option value="30" ${pageSize=="30"?"selected":""}>
							30
						</option>
						<option value="50" ${pageSize=="50"?"selected":""}>
							50
						</option>
						<option value="100" ${pageSize=="100"?"selected":""}>
							100
						</option>
						<option value="200" ${pageSize=="200"?"selected":""}>
							200
						</option>
					</select> 
    <span id="prev"><c:if test="${pageNo > 1}"><img src="<c:url value="/images/button_up.png" />" class="img_middle" onclick="pageList('prev')"/></c:if></span>
		  &nbsp;
	<span id="next"><c:if test="${pageNo+1 <= page.totalPage}"><img src="<c:url value="/images/button_down.png" />" class="img_middle" onclick="pageList('next')"/></c:if></span>
	</div>
	</body>
</html>
