<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

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
		<title>i18n_dept.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/MzTreeView10.js"/>"></script>
		<script type="text/javascript">
		     var tree = new MzTreeView("tree");
		     
			 window.onload=function(){
       			<c:if test="${listDeptInfo ne null}">
				</c:if>
   			 }
   			 function EI(t) {return document.getElementById(t);}
   			 tree.icons["property"] = "property.gif";
	  		 tree.icons["css"] = "collection.gif";
	  		 tree.icons["book"]  = "book.gif";
	  		 tree.setIconPath("<%=basePath%>"+"/images/tree/"); //可用相对路径
	  
   			 var listvalue = new Array();
		 	 <c:if test="${listDeptInfo ne null}">
		 	 	tree.nodes["0_1"]="text:i18n_dept.text.deptMenu_n81i;hint:i18n_dept.text.deptMenu_n81i;icon:css;data:id=1;leaf:true";
			 	listvalue['1']="1;i18n_dept.text.deptMenu_n81i;0;0";	
				<c:forEach var="dept" items="${listDeptInfo}" >
					<c:if test="${dept.deptstate==1}" var="zxFlag">
						tree.nodes["${dept.upperlayer}_${dept.deptid}"]="text:<font color='#999999'>${dept.deptname}</font>;hint:${dept.deptname};icon:css;data:id=${dept.deptid};leaf:true";
					</c:if>
					<c:if test="${!zxFlag}">
						tree.nodes["${dept.upperlayer}_${dept.deptid}"]="text:${dept.deptname};hint:${dept.deptname};icon:css;data:id=${dept.deptid};leaf:true";
					</c:if>
					listvalue['${dept.deptid}']="${dept.deptid};${dept.deptname};${dept.upperlayer};${dept.deptstate}";	
				</c:forEach>
			 </c:if>
			 
		     tree.setTarget("MzMain");//??
		     
		var oldDeptName = "";
		//点击各节点触发的事件
		function myclick(id){
			var node=tree.currentNode;
			var values = listvalue[id].split(";");
			//EI("pid").value=values[0];//由于id是按升序派力的，所以[0]是id最小的元素，点击一个节点，新建子节点的时候，被点击的节点就是父节点
			oldDeptName = values[1];
			torepair(listvalue[id]);
		}
		
		//显示详细信息
		function torepair(txt){
			var arr=txt.split(";");
			$("#deptid").val(arr[0]);//节点id
			$("#deptname").val(arr[1]);//节点名称
			$("#pid").val(arr[2]);//节点父id
			$("#pname").val(arr[1]);
			if(arr[3] == '0' ){
				$('#stateY').attr('checked','checked');
			}else{
				$('#stateN').attr('checked','checked');
			}
			$("#deptname").next().html('*');
		}
		
		//修改
		function commitUpdate(){
			//校验
			if(!$id("deptname","","i18n_dept.text.deptname_n81i")){
				$("#deptname").trigger('focus');
				return false;
			}
		
			if(checkSpecial($("#deptname").val())){
				$("#deptname").next().html("i18n_dept.message.deptname_n81i");
				return false;
			}
			//修改的时候，如果名称没有变化，则不做重复判断，直接提交表单
		    if(oldDeptName==jQuery("#deptname").val()) {
		    	var actionurl = "<%=path%>/deptManage/deptManage!execute.do?action=update";
				document.forms.yhForm.action = actionurl;
				document.forms.yhForm.submit();
				document.forms.yhForm.action="";		
		    } else {
				//判断此部门名称是否已经存在，不允许同一个上级的部门重名
			    var deptName = document.getElementById("deptname").value;
			    //var upper = jQuery("#pid").val();
			    var upper = jQuery("#deptid").val();
			    jQuery.post("<c:url value='/'/>sysManage/sysPopedomManage!checkDeptIsExisted.do",{deptName:deptName,upper:upper},function(datas){checkDeptIsExisted(datas,'update');},"json");
		    }
		}
		
		//新增
		function commitAdd(){
			//校验
			if(!$id("deptname","","i18n_dept.text.deptname_n81i")){
				$("#deptname").trigger('focus');
				return false;
			}
		
			if(checkSpecial($("#deptname").val())){
				$("#deptname").next().html("i18n_dept.message.deptname_n81i");
				return false;
			}
			
			//判断此部门名称是否已经存在，不允许同一个上级的部门重名
		    var deptName = document.getElementById("deptname").value;
		    //var upper = jQuery("#pid").val();
		    var upper = jQuery("#deptid").val();
		    jQuery.post("<c:url value='/'/>sysManage/sysPopedomManage!checkDeptIsExisted.do",{deptName:deptName,upper:upper},function(datas){checkDeptIsExisted(datas,'add');},"json");
		}
		
		 //判断角色名是否已存在，不存在再提交
		function checkDeptIsExisted(datas,action) {
		    if(datas!=null) {
			    if(datas.hasExisted=="false") {
					var actionurl = "<%=path%>/deptManage/deptManage!execute.do?action="+action;
					document.forms.yhForm.action = actionurl;
					document.forms.yhForm.submit();
					document.forms.yhForm.action="";		
			    } else {
			        $("#deptname").next().html("i18n_dept.message.deptname1_n81i");
			        jQuery("#deptname").focus();
			        return;
			    }
		    }
		}
		</script>
	</head>
	<body>
		<div class="middle_list">
			<!--中间部分右边开始：操作按钮-->
			<div class="box_2">
				<jsp:include page="/include/include.jsp" />
			</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table" >
					<tr>
						<td class="color_8">i18n_dept.text.deptMenu_n81i</td>
						<td class="color_8">i18n_dept.text.deptInfo_n81i</td>
					</tr>
					<tr>
						<td class="color_1" align="left">
							<div id="deptTree"
								style="overflow: scroll; height:500px">
								<script language="javascript">
								<%-- 动态定义树的可显示高度 --%>
								document.write(tree.toString());
								
								<%-- 生成功能树 --%>
								</script>
							</div>
						</td>
						<td class="color_3" align="left" valign="top">
						<input type="hidden" id="pname"/>
						<form action="" name="yhForm" id="yhForm" method="post" >
							<input type="hidden" name="dept.deptid" id="deptid" />
							<input type="hidden" name="dept.upperlayer" id="pid" />
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
								<tr type='form'>
									<td class="td_1" width="10%">
										i18n_dept.text.deptname_n81i：
									</td>
									<td  class="td_3" width="35%">
										<input type="text" name="dept.deptname" id="deptname"  value="${dept.deptname}"/>
										<font color="red">*</font>
									</td>
									<td class="td_1" width="10%">i18n_dept.text.state_n81i：</td>
									<td class="td_3" >
										<input type="radio" name="dept.deptstate" id="stateY" value="0" checked="checked"/>i18n_dept.message.valid_n81i
										<input type="radio" name="dept.deptstate" id="stateN" value="1" />i18n_dept.message.invalid_n81i
									</td>
								</tr>
								
								<tr>
									<td colspan="4" align="right" class="td_1" >&nbsp;
										<input type="button" value="i18n_dept.button.add_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitAdd()"/>
										&nbsp;
										<input type="button" value="i18n_dept.button.update_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitUpdate()"/>
										
									</td>
								</tr>
							</table>
						</form>
						</td>
					</tr>
				</table>
				<!--中间部分右边结束-->
		</div>
	</body>
</html>
