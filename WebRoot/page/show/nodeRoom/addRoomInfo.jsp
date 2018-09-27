<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
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
		<title>i18n_ari.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
	</head>
	<script language="javascript" type="text/javascript">	
   
   var maxRows ='${maxRoomRows}';
   var maxCols = '${maxRoomCols}';
	function add(){
		if($id("roomIspn","","i18n_ari.text.roomIspn_n81i") && $id("roomRows","sz","i18n_ari.text.roomRows_n81i") && $id("roomCols","sz","i18n_ari.text.roomCols_n81i")){
			if(!containSpecial($("#roomIspn").val())){
				$("#roomIspn").next().html("*");
				$("#roomRows").next().html("*");
				$("#roomCols").next().html("*");
				if(Number($("#roomRows").val())>Number(maxRows)){
					$("#roomRows").next().html("i18n_ari.message.roomRows_n81i"+maxRows);
					return;
				}else if(Number($("#roomCols").val())>Number(maxCols)){
					$("#roomCols").next().html("i18n_ari.message.roomRows_n81i"+maxCols);
					return;
				}else{
					if(ajaxCheck()){
						document.Mkform.action="<%=path%>/nodePosition/roomManage.do?action=doAdd";
						document.Mkform.submit();				
					}
				}
			}else{
				$("#roomIspn").next().html("i18n_ari.message.roomIspn_n81i");
				return;
			}
		}	 
	}
	
	function ajaxCheck(){
		var type;
		$.ajax({
			url:"<%=path%>/nodePosition/roomManage.do?action=AjaxCheck",
			type : "POST",
			async:false,
			data:$('#Mkform').serialize(),
			success : function(data) {
				if(data == "error"){
					alert("i18n_ari.message.MkformError_n81i");
					type = false;
				}else if(data == "exception"){
					alert("i18n_ari.message.MkformException_n81i");
					type = false;
				}else if(data =="success"){
					type = true;
				}
			}
		}); 
		return type;  
	}
	
	function goBack(){
		document.Mkform.action="<%=path%>/nodePosition/roomManage.do?action=query";
		document.Mkform.submit();	
	}
	
	$(function(){
		$("#roomRows").change(function(){
			if(!$id("roomRows","sz","i18n_ari.text.roomRows_n81i")){
				$("#roomRows").val("");
			}
		})
		
		$("#roomCols").change(function(){
			if(!$id("roomCols","sz","i18n_ari.text.roomCols_n81i")){
				$("#roomCols").val("");
			}
		})
	})

	</script>
	<body>
		<div class="middle_list" >
			<div class="box_2">	
				<input type="button" class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="goBack()" value="i18n_ari.button.back_n81i"/>
			 </div>
 
			<form action="" name="Mkform" id="Mkform" method="post" id="Mkform">
			<input type="hidden" name="pageNo" value="${pageNo }" />
			<input type="hidden" name="pageSize" value="${pageSize }" />
			<input type="hidden" name="fromWhere" value="${fromWhere }"/>
			<div style="clear: both"></div>
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td colspan="2" class="color_8">
						<strong>i18n_ari.text.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_ari.text.index_n81i
					</td>
					<td class="color_3" align="left">
							<input type="text" name="nodeRoom.roomIspn" id="roomIspn" />
							<span style="color: red" id="info">*</span>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_ari.text.rows_n81i
					</td>
					<td class="color_3" align="left">
							<input type="text" name="nodeRoom.roomRows" id="roomRows" value=""/>
							<span style="color: red" id="row">*</span>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="30%" align="right">
						i18n_ari.text.cols_n81i
					</td>
					<td class="color_3" align="left">
							<input type="text" name="nodeRoom.roomCols" id="roomCols" value=""/>
							<span style="color: red" id="col">*</span>
					</td>
				</tr>
				<tr>
					<td class="color_1" width="20%" align="right">
						i18n_ari.text.roomDesc_n81i
					</td>
					<td class="color_3"  align="left">
						<textarea rows="5" cols="60" id="roomDesc"
									name="nodeRoom.roomDesc" ></textarea>
					</td>
				</tr>
				<tr>
					<td class="color_7" colspan="2" align="right">
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" onclick="add()" value="i18n_ari.button.submit_n81i"/>
						&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'"
								onclick="javascript:document.forms['Mkform'].reset()" value="i18n_ari.button.reset_n81i"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
