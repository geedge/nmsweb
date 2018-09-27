<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
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
		<title>i18n_ubi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/j.suggest.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
	$(document).keydown(function (e) {//绑定键盘按下事件    防止退格键返回
        var doPrevent;
        // for IE && Firefox
        var varkey = (e.keyCode) || (e.which) || (e.charCode);
        if (varkey == 8) {
            var d = e.srcElement || e.target;
            if (d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA') {
                doPrevent = d.readOnly || d.disabled;
                if (d.type.toUpperCase() == 'SUBMIT'
                    || d.type.toUpperCase() == 'RADIO'
                    || d.type.toUpperCase() == 'CHECKBOX'
                    || d.type.toUpperCase() == 'BUTTON') {
                    doPrevent = true;
                }
            }
            else {
                doPrevent = true;
            }
        }
        else {
            doPrevent = false;
        }
    if (doPrevent)
        e.preventDefault();
    });
		$(function(){
			$("#boxUType").change(function(){
				if(!$id("boxUType","sz","i18n_ubi.text.boxUType_n81i")){
					$("#boxUType").val("");
				}
			})
		})
		
		function updateCheck(){
			var type;
			$.ajax({
				url:"<%=path%>/nodePosition/boxSet.do?action=updateCheck",
				type : "POST",
				async:false,
				data:$('#Mkform').serialize(),
				success : function(data) {
					if(data == "exception"){
						type = false;
						alert("i18n_ubi.message.faild_n81i");
					}else if(data =="success"){
						type = true;
					}else{
						type = false;
						alert(data);
					}
				}
			}); 
			return type;  
		}
		
		function add(){
			if($id("ispn","","i18n_ubi.text.ispn_n81i") && $id("descinfo","","i18n_ubi.text.descinfo_n81i") && $id("boxUType","sz","i18n_ubi.text.boxUType_n81i")
			 && $id("roomIspn","","i18n_ubi.text.roomIspn_n81i") && $id("roomRowPosition","xz","i18n_ubi.text.roomRowPosition_n81i") 
			 && $id("roomColPosition","xz","i18n_ubi.text.roomColPosition_n81i")){
				 if(!containSpecial(lrtrim($("#ispn").val()))){
				 	document.Mkform.action="<%=path%>/nodePosition/boxSet.do?action=doUpdate";
					document.Mkform.submit();
				 }else{
				 	$("#ispn").next().html("i18n_ubi.message.inputInfo_n81i");
				 	return;
				 }
			}	 
		}
		
		//去除左右两端空格
		function lrtrim(s){
			s = s.replace(/(^\s*)|(\s*$)/g,"");
			return s;
		}
		
		function goBack(){
			document.Mkform.action="<%=path%>/nodePosition/boxSet.do?action=query";
			document.Mkform.submit();	
		}
		
		function resetInit(){
			$("#roomIspn").val("${nodeBox.roomIspn }");
	 		var roomIspn = "${nodeBox.roomIspn }";
	 		if(roomIspn!=""){
		 		$.post("<c:url value='/nodePosition/boxSet!getRoomFreeRows.do'/>",
		 			{"roomIspn":roomIspn,"boxId":${nodeBox.nodeBoxId}},
		 			function(data){
		 				// 追加option元素
		 				if(data!=null && data!=""){
			 				$.each(data, function(i,val){
			 					$("#roomRowPosition").append("<option value='"+val+"'>" + val + "</option>");
			 				});
		 				}
		 				//选中行
		 				$("#roomRowPosition option[value=${nodeBox.roomRowPosition}]").attr("selected","selected");
		 			}, "json");
		 	}
		 			
	 		var roomRowPosition = "${nodeBox.roomRowPosition}";
	 		if(roomRowPosition!=""){
		 		$.post("<c:url value='/nodePosition/boxSet!getRoomFreeCols.do'/>",
		 			{"roomIspn":roomIspn,"rowNum":roomRowPosition,"boxId":${nodeBox.nodeBoxId}},
		 			function(data){
		 				// 追加option元素
		 				if(data!=null && data!=""){
			 				$.each(data, function(i,val){
			 					$("#roomColPosition").append("<option value='"+val+"'>" + val + "</option>");
			 				});
		 				}
		 				//选中列
		 				$("#roomColPosition option[value=${nodeBox.roomColPosition}]").attr("selected","selected");
		 			}, "json");
		 	}
		}
			
	// -----机房及位置相关处理
			$(function(){
				var first = 1;
				var vstart;
				//-- 机房 事件绑定 获取可选行号
	 				$("#roomRowPosition").empty();
	 				$("#roomRowPosition").append("<option value=''>i18n_ubi.message.selectDefault_n81i</option>");
	 				$("#roomColPosition").empty();
	 				$("#roomColPosition").append("<option value=''>i18n_ubi.message.selectDefault_n81i</option>");
	 				
	 				var curVal = $("#roomIspn").val();
	 				if(curVal!=""){
		 				$.post("<c:url value='/nodePosition/boxSet!getRoomFreeRows.do'/>",
		 					{"roomIspn":curVal,"boxId":${nodeBox.nodeBoxId}},
		 					function(data){
		 						// 追加option元素
		 						if(data!=null && data!=""){
			 						$.each(data, function(i,val){
			 							$("#roomRowPosition").append("<option value='"+val+"'>" + val + "</option>");
			 						});
		 						}
		 						if(first==1){//第一次加载,选中行
		 							$("#roomRowPosition option[value=${nodeBox.roomRowPosition}]").attr("selected","selected");
		 							$("#roomRowPosition").trigger("blur");//获取列
		 						}
		 					}, "json");
		 			}
	 			//-- 机房行号 事件绑定 由行号决定可选列号
	 			$("#roomRowPosition").blur(function(){
	 				$("#roomColPosition").empty();
	 				$("#roomColPosition").append("<option value=''>i18n_ubi.message.selectDefault_n81i</option>");
	 				
	 				var roomIspn = $("#roomIspn").val();
	 				var curVal = $(this).val();
	 				if(curVal!=""){
		 				$.post("<c:url value='/nodePosition/boxSet!getRoomFreeCols.do'/>",
		 					{"roomIspn":roomIspn,"rowNum":curVal,"boxId":${nodeBox.nodeBoxId}},
		 					function(data){
		 						// 追加option元素
		 						if(data!=null && data!=""){
			 						$.each(data, function(i,val){
			 							$("#roomColPosition").append("<option value='"+val+"'>" + val + "</option>");
			 						});
		 						}
		 						if(first==1){//第一次加载，选中列
		 							$("#roomColPosition option[value=${nodeBox.roomColPosition}]").attr("selected","selected");
		 							first = 0;
		 						}
		 					}, "json");
		 			}
	 			});
			});
			
	</script>
	<body >
		<div class="middle_list" >
			<div class="box_2">		
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_ubi.button.back_n81i"/>
			 </div>
			<form action="" name="Mkform" method="post" id="Mkform">
				<input type="hidden" name="nodeBox.nodeBoxId" value="${nodeBox.nodeBoxId}" />
				<input type="hidden" name="ispnNum" value="${ispnNum }">
				<input type="hidden" name="pageNo" value="${pageNo }" />
				<input type="hidden" name="pageSize" value="${pageSize }" />
				<input type="hidden" name="roomid" value="${roomid }"/>
				<input type="hidden" name="roomIspn" value="${roomIspn }"/>
				<jsp:include page="/common/transferHiddenParameter.jsp" />
				
				<div style="clear: both"></div>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_ubi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_ubi.text.index_n81i：
					</td>
					<td class="color_3"  align="left">
							<input type="text" name="nodeBox.ispn" id="ispn" value="${nodeBox.ispn}"/>
							<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_ubi.text.U_n81i：
					</td>
					<td class="color_3" align="left">
							<input type="text" name="nodeBox.boxUType" id="boxUType" value="${nodeBox.boxUType}"/>
							<font color="red">*</font>
					</td>
				</tr>
				<tr>
						<td class="color_1" align="right">
							i18n_ubi.text.roomIspn_n81i：
						</td>
						<td class="color_3" align="left">
							<input value="${nodeBox.roomIspn }" disabled="disabled"/>
							<input name="nodeBox.roomIspn" id="roomIspn" type="hidden" value="${nodeBox.roomIspn }" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ubi.text.roomRowPosition_n81i：
						</td>
						<td class="color_3" align="left">
							<select name="nodeBox.roomRowPosition" id="roomRowPosition"
								style="width: 151px;">
								<option value="">
									i18n_ubi.message.selectDefault_n81i
								</option>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_ubi.text.roomColPosition_n81i：
						</td>
						<td class="color_3" align="left">
							<select name="nodeBox.roomColPosition" id="roomColPosition"
								style="width: 151px;">
								<option value="">
									i18n_ubi.message.selectDefault_n81i
								</option>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
				<tr>
					<td class="color_1"  align="right">
						i18n_ubi.text.desc_n81i：
					</td>
					<td class="color_3"  align="left">
						<textarea rows="5" cols="60" id="descinfo"
									name="nodeBox.descinfo" >${nodeBox.descinfo}</textarea>
									<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_ubi.button.submit_n81i"/>
						&nbsp;
						<input  type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset();resetInit();" value="i18n_ubi.button.reset_n81i"/>
					</td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>
