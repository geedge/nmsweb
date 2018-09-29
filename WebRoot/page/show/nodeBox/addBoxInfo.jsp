<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
	request.setAttribute("vEnter","\n");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_abi.message.title_n81i</title>
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
				if(!$id("boxUType","sz","i18n_abi.text.boxUType_n81i")){
					$("#boxUType").val("");
				}
			})
		})
   
   
	function checkIspn(){
 		var type;
		$.ajax({
			url:"<%=path%>/nodePosition/boxSet.do?action=addCheck",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "exist"){
					$("#ispn").next().html("i18n_abi.message.ispn_n81i");
					type = false;
				}else if(data == "exception"){
					alert("i18n_abi.message.faild_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		}); 
		return type;  
   }
   
	function add(){
		var roomIspn ;
		if($id("ispn","","i18n_abi.text.roomIspn_n81i") && $id("boxUType","sz","i18n_abi.text.boxUType_n81i")){
			if($("select[name=nodeBox.roomIspn]").val()==undefined){
				roomIspn = $id("roomIspn","","i18n_abi.text.roomIspn_n81i") ;
			}else{
				roomIspn = $id("roomIspn","xz","i18n_abi.text.roomIspn_n81i") ;
			}
			if(roomIspn && $id("roomRowPosition","xz","i18n_abi.text.roomRowPosition_n81i") 
				 && $id("roomColPosition","xz","i18n_abi.text.roomColPosition_n81i") && $id("descinfo","","i18n_abi.text.descinfo_n81i")){
				if(!containSpecial(lrtrim($("#ispn").val()))){
					if(checkIspn($("#ispn").val())){
						document.Mkform.action="<%=path%>/nodePosition/boxSet.do?action=doAdd";
						document.Mkform.submit();					
					}
				 }else{
				 	$("#ispn").next().html("i18n_abi.message.ispn1_n81i");
				 	return;
				 }
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
	// -----机房及位置相关处理
			$(function(){
				//-- 机房 事件绑定 获取可选行号
		 		roomIspnChange();
	 			//-- i18n_abi.text.roomRowPosition_n81i 事件绑定 由行号决定可选列号
	 			$("#roomRowPosition").blur(function(){
	 				$("#roomColPosition").empty();
	 				$("#roomColPosition").append("<option value=''>i18n_abi.message.selectDefault_n81i</option>");
	 				
	 				var roomIspnVal = $("#roomIspn").val();
	 				if(roomIspnVal==null||roomIspnVal==""||roomIspnVal==undefined){
						roomIspnVal = $("select[name=nodeBox.roomIspn]").val()
					}
	 				var curVal = $(this).val();
	 				if(curVal!=""){
		 				$.post("<c:url value='/nodePosition/boxSet!getRoomFreeCols.do'/>",
		 					{"roomIspn":roomIspnVal,"rowNum":curVal},
		 					function(data){
		 						// 追加option元素
		 						if(data!=null && data!=""){
			 						$.each(data, function(i,val){
			 							$("#roomColPosition").append("<option value='"+val+"'>" + val + "</option>");
			 						});
		 						}
		 				}, "json");
		 			}
	 			});
			}); 
			
			
		function roomIspnChange(){
			var roomIspnVal;
			roomIspnVal = $("#roomIspn").val();
			if(roomIspnVal==null||roomIspnVal==""||roomIspnVal==undefined){
				roomIspnVal = $("select[name=nodeBox.roomIspn]").val()
			}
			$("#roomRowPosition").empty();
			$("#roomRowPosition").append("<option value=''>i18n_abi.message.selectDefault_n81i</option>");
			$("#roomColPosition").empty();
			$("#roomColPosition").append("<option value=''>i18n_abi.message.selectDefault_n81i</option>");
			$.post("<c:url value='/nodePosition/boxSet!getRoomFreeRows.do'/>",
		 					{"roomIspn":roomIspnVal},
		 					function(data){
		 						// 追加option元素
		 						if(data!=null && data!=""){
			 						$.each(data, function(i,val){
			 							$("#roomRowPosition").append("<option value='"+val+"'>" + val + "</option>");
			 						});
		 						}
		 					}, "json");
		}
	</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_abi.button.back_n81i"/>
			</div>

			<form action="" name="Mkform" id="Mkform" method="post">
			<input type="hidden" name="ispnNum" value="${ispnNum }">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
				<input type="hidden" name="roomid" value="${roomid }"/>
				<input type="hidden" name="roomIspn" value="${roomIspn }" >
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_abi.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_abi.text.ispn_n81i：
					</td>
					<td class="color_3" align="left">
							<input type="text" name="nodeBox.ispn" id="ispn" />
							<font color="red">*</font>
					</td>
				</tr>
					<tr>
						<td class="color_1" width="30%" align="right">
							i18n_abi.text.U_n81i：
						</td>
						<td class="color_3" align="left">
							<input type="text" name="nodeBox.boxUType" id="boxUType"
								value="42" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_abi.text.roomIspn_n81i：
						</td>
						<td class="color_3" align="left">
						
						<c:choose>
							<c:when test="${roomIspn==null||roomIspn==''}">
								<select name="nodeBox.roomIspn" onchange="roomIspnChange()" id="roomIspn">
									<option value="">i18n_abi.message.selectDefault_n81i</option>
									<c:forEach items="${nodeRoomList}" var="item">
										<option value="${item.roomIspn}">${item.roomIspn}</option>
									</c:forEach>
								</select>
							</c:when>
							<c:otherwise>
								<input  disabled="disabled" value="${roomIspn }"/>
								<input name="nodeBox.roomIspn" id="roomIspn" type="hidden"  value="${roomIspn }"/>
							</c:otherwise>
						</c:choose>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_abi.text.roomRowPosition_n81i：
						</td>
						<td class="color_3" align="left">
							<select name="nodeBox.roomRowPosition" id="roomRowPosition"
								style="width: 151px;">
								<option value="">
									i18n_abi.message.selectDefault_n81i
								</option>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="color_1" align="right">
							i18n_abi.text.roomColPosition_n81i：
						</td>
						<td class="color_3" align="left">
							<select name="nodeBox.roomColPosition" id="roomColPosition"
								style="width: 151px;">
								<option value="">
									i18n_abi.message.selectDefault_n81i
								</option>
							</select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
					<td class="color_1" width="20%" align="right">
						i18n_abi.text.des_n81i：
					</td>
					<td class="color_3"  align="left">
						<textarea rows="5" cols="60" id="descinfo"
									name="nodeBox.descinfo" ></textarea>
									<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_abi.text.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()" value="i18n_abi.text.reset_n81i"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
