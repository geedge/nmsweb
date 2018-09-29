<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
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
		<title>i18n_udept.message.title_n81i</title>
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
	<script type="text/javascript" src="<%=path%>/templates/js/object.js"></script>
    <script language="javascript" type="text/javascript">
	//new alignWindowObject(window.opener.winObj.width,window.opener.winObj.height).alignCenter();
	function $(name){
		return document.getElementById(name);
	}
	
	function doUpdate(deptid){
		if($id("deptname","","i18n_udept.text.deptname_n81i")){
			for(var i = 0 ;i<document.all.deptlayer.length;i++){
				if(document.all.deptlayer[i].checked){
					if((document.all.deptlayer[i].value==1 || document.all.deptlayer[i].value==2) && document.getElementById("upperlayer").value==-1){
						alert('i18n_udept.message.deptname_n81i');
						return false;
					}else{
					    //修改的时候，如果名称没有变化，则不做重复判断，直接提交表单
					    if("${deptList[0].deptname}"==jQuery("#deptname").val()) {
					    	document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateDeptInfo&deptid=${deptList[0].deptid }";
							document.yhForm.submit();	
					    } else {
							//判断此部门名称是否已经存在，不允许同一个上级的部门重名
						    var deptName = document.getElementById("deptname").value;
						    var upper = jQuery("#upperlayer >option:selected").val();
						    jQuery.post("<c:url value='/'/>sysManage/sysPopedomManage!checkDeptIsExisted.do",{deptName:deptName,upper:upper},function(datas){checkDeptIsExisted(datas);},"json");
					    }
					}
					break;
				}
			}	 		
		}
	}
	
	 //判断角色名是否已存在，不存在再提交
	function checkDeptIsExisted(datas) {
	    if(datas!=null) {
		    if(datas.hasExisted=="false") {
				document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=doUpdateDeptInfo&deptid=${deptList[0].deptid }";
				document.yhForm.submit();	
		    } else {
		        alert("i18n_udept.message.deptnameExists_n81i");
		        jQuery("#deptname").focus();
		        return;
		    }
	    }
	}
	
	 function goBack(){		
		document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=queryDeptInfo";
		document.yhForm.submit();	
	}
	
</script>

   
	<body>
	<div class="middle_list" >
		<form action="" name="yhForm" method="post">
			<input type="hidden" name="position" value="${position }">
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td class="color_8" colspan="2">
						<strong>i18n_udept.text.title_n81i</strong>				
					</td>
				</tr>
				<tr>
					<td class="color_1" width="25%" align="right">
						i18n_udept.text.deptname_n81i
					</td>
					<td class="color_3" width="25%" align="left">
						<input type="text" name="dept.deptname" id="deptname" value="${deptList[0].deptname }" />
										
					</td>
				</tr>
				<tr>
					<td class="color_1" width="25%" align="right">
						i18n_udept.text.deptlayer_n81i
					</td>
					<td class="color_3" width="25%" align="left">
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="0"  <c:if test="${deptList[0].deptlayer==0 }">checked="checked" </c:if> />总队
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="1"  <c:if test="${deptList[0].deptlayer==1 }">checked="checked" </c:if> />支队
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="2"  <c:if test="${deptList[0].deptlayer==2 }">checked="checked" </c:if> />队	
					</td>
				</tr>
				<tr>
					<td class="color_1" width="25%" align="right">
						i18n_udept.text.upperlayer_n81i
					</td>
					<td class="color_3" width="25%" align="left">
						<select name="dept.upperlayer" id="upperlayer" >
							<option value="-1">
								i18n_udept.message.selectDefault_n81i
							</option>
							<c:forEach items="${listDeptInfo}" var="deptInfo">
								<option value="${deptInfo.deptid}" <c:if test="${deptList[0].upperlayer==deptInfo.deptid }">selected="selected"</c:if>>
									${deptInfo.deptname}
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="doUpdate('${deptList[0].deptid }')"
								value="i18n_udept.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['yhForm'].reset()"
								value="i18n_udept.button.reset_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_udept.button.back_n81i"/>
						&nbsp;
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
<script>
function selectUpper(opt){
	if(opt==0){
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].value="-1";
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].text="i18n_udept.message.selectDefault_n81i";
		document.getElementById("upperlayer").disabled=true;
		//alert(document.getElementById("upperlayer").value);
	}else{
		document.getElementById("upperlayer").disabled=false;
	}
}
</script>
</html>
