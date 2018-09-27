<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_adepti.message.title_n81i</title>
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
        <script type="text/javascript">
			function $(name){
				return document.getElementById(name);
			}
			function add(){
			 	if($id("deptname","","i18n_adepti.text.deptname_n81i")){
			 		for(var i = 0 ;i<document.all.deptlayer.length;i++){
						if(document.all.deptlayer[i].checked){
							if((document.all.deptlayer[i].value==1 || document.all.deptlayer[i].value==2 ) && document.getElementById("upperlayer").value==-1){
								alert('i18n_adepti.message.deptname_n81i');
								return false;
							}else{
							    //判断此部门名称是否已经存在，不允许同一个上级的部门重名
							    var deptName = document.getElementById("deptname").value;
							    var upper = jQuery("#upperlayer >option:selected").val();
							    jQuery.post("<c:url value='/'/>sysManage/sysPopedomManage!checkDeptIsExisted.do",{deptName:deptName,upper:upper},function(datas){checkDeptIsExisted(datas);},"json");
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
						document.yhForm.action="<%=path%>/sysManage/sysPopedomManage!execute.do?action=addDeptInfo";
						document.yhForm.submit();			
				    } else {
				        alert("i18n_adepti.message.deptnameExists_n81i");
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
	</head>
	<body>
	<div class="middle_list" >
		<form action="" name="yhForm" method="post">
		<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="4" class="color_8">
						<strong>i18n_adepti.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="25%" align="right">
						i18n_adepti.text.deptname_n81i
					</td>
					<td class="color_3" width="25%" align="left">
						<input type="text" name="dept.deptname" id="deptname"/>
					</td>
					<td class="color_1" width="25%" align="right">
						i18n_adepti.text.upperlayer_n81i
					</td>
					<td class="color_3"  align="left" width="25%">
						<select name="dept.upperlayer" id="upperlayer">
							<option value="0" selected>
								i18n_adepti.message.selectDefault_n81i
							</option>
							<c:forEach items="${listDeptInfo}" var="deptInfo">
								<option value="${deptInfo.deptid}">
									${deptInfo.deptname}
								</option>
								</c:forEach>
						</select>
					</td>
					
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_adepti.text.deptlayer_n81i
					</td>
					<td class="color_3" width="25%" align="left" colspan="3">
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="0" checked="checked" />i18n_adepti.message.deptlayer0_n81i
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="1" />i18n_adepti.message.deptlayer1_n81i
						<input type="radio" name="dept.deptlayer" id="deptlayer" value="2" />i18n_adepti.message.deptlayer2
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="4" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()"
								value="i18n_adepti.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['yhForm'].reset()"
								value="i18n_adepti.button.reset_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="goBack()" value="i18n_adepti.button.back_n81i"/>
						&nbsp;
					</td>
				</tr>	
			</table>
		</form>
		</div>
	</body>
</html>
<script>
function selectUpper(opt){
	if(opt==0){
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].value="-1";
		document.getElementById("upperlayer").options[document.getElementById("upperlayer").selectedIndex].text="i18n_adepti.message.selectDefault_n81i";
		document.getElementById("upperlayer").disabled=true;
		//alert(document.getElementById("upperlayer").value);
	}else{
		document.getElementById("upperlayer").disabled=false;
	}
}
</script>