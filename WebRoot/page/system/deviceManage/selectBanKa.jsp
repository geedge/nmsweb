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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<link href="<c:url value='/css/nms.css'/>" type="text/css"
			rel="stylesheet" />
		<style type="text/css">
td {
	height: 35px;
}
</style>
		<script type="text/javascript">
		window.onload=function(){
			window.dialogHeight = (parseInt(window.dialogHeight) + (document.body.scrollHeight - document.body.clientHeight)) + "px";
		};
		$(function(){
			var parentWindow=window.dialogArguments.document;
			var bankaVal = $(parentWindow.getElementById("bankaVal")).val();//获取从父窗口的值
			var arr = bankaVal.split("\,");
			for(var i=0;i<arr.length;i++){
				$("input[type=checkbox]").each(function(index,item){
					if($(item).val()==arr[i]){
						$(item).attr("checked","true");
					}
				});
			}
			$("tr").each(function(index,item){
				if($(item).attr("class")!=""){
					if(($(item).children().length)==1){
						$(item).append("<td></td>");
					}
					if(index%2==0){
						$(item).children().attr("class","color_1");
					}else{
						$(item).children().attr("class","color_3");
					}
				}
			});
		});
		
		function selectBanKa(){
			var checkboxObj = $("input[type=checkbox][name=banka]:checked");
			var arr = new Array();
			checkboxObj.each(function(index,item){
				arr.push($(item).val());
			});
			var resu = $(window.parent.document).find("#I3").contents();
			resu.find("#temp").val(arr);
			layclose();
		}
		
		function selectAll(obj){
			if($(obj).attr("id")=="selectAll"){
				if(obj.checked){
					$("input[type=checkbox][name=banka]").attr("checked","checked");
				}else{
					$("input[type=checkbox][name=banka]").removeAttr("checked");
				}
			}else{
				if(obj.checked){
					if($("input[type=checkbox][name=banka]").not("input:checked").length==0){
						$("#selectAll").attr("checked","checked");
					}
				}else{
					$("#selectAll").removeAttr("checked");
				}
			}
		}
	function layclose() {
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
</script>
	</head>
	<body>
		<table border="0" cellpadding="0" cellspacing="0" class="table">
			<tr>
				<td class="color_8" colspan="2" >
				<div style="margin-left: 100px;float: left"><input type="checkbox" id="selectAll" onclick="selectAll(this)">&nbsp;i18n_sbk.text.selectAll_n81i</div>	<div style="margin-right: 13%">i18n_sbk.text.selectBK_n81i</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 350px" valign="top" bgcolor="#D9D8D8">
					<table border="0" cellpadding="0" cellspacing="0" class="table"
						style="">
						<c:forEach items="${deviceBrandTypeList}" var="device"
							varStatus="status">
							<c:set var="index" value="${status.index+1}" />
							<c:set var="length" value="${fn:length(deviceBrandTypeList)}" />
							<c:if test="${index==1}">
								<tr class="${index}" style="height: 20px">
							</c:if>
							<td style="padding-left: 100px;" align="left">
								<input type="checkbox" name="banka"
									value="${device.subDeviceTypeCode}" onclick="selectAll(this)"/>
								${device.subDeviceTypeCode}
							</td>
							<c:if test="${index%2==0&&index<length}">
								</tr>
								<tr class="${index}" style="height: 20px">
							</c:if>
							<c:if test="${index==length}"></tr></c:if>
						</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" class="td_1">
					<div style="margin-right: 30px">
						<input type="button" class=btn3_mouseout id="sub"
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'" onclick="selectBanKa()"
							value="i18n_sbk.button.submit_n81i" />
						&nbsp;&nbsp;&nbsp;
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'" onclick="layclose();"
							value="i18n_sbk.button.close_n81i" />
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>
