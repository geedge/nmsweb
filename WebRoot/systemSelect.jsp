<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><link rel="Shortcut icon" href="images/logo.ico"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>i18n_systemSelect.message.title_n81i</title>
<script type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />	
<script src="<c:url value='js/jquery-1.4.2.min.js'/>" type="text/javascript"></script>
<style type="text/css">
* {margin:0px;
   padding:0px;}
	
html, body {;
           background:#EBECEB;;}

.login{font-size:14px;
     margin-left:10px;
	 width:200px;
	 height:155px;}
	 

</style>
</head>
<script type="text/javascript">  
	function sub(){	
		document.form1.submit();
	}
	function exitSystem(){
		document.form1.action = "<%=path%>/login!logout.do";
		document.form1.submit();
	}
	function enterkey(){
	   if(event.keyCode==13){
			document.form1.submit();
		}
	}
$(function(){
	var wHight = $(window).height();//alert('wHight '+wHight);
	var dHight = $(document).height();//alert('dHight '+dHight);
	if(dHight > wHight){//滚动条滚动
		$(document).scrollTop((dHight-wHight)/2);
	}
	$("#system").trigger('focus');
});
$(function(){
	if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
		$(document).keypress(function(e) {  
		       if(e.which == 13) { 
		       		sub(); 
		       }  
		}); 
	 } 
});
</script>
<body>
	<form action="<c:url value='/login!systemSelect.do'/>" name="form1" method="post"  onkeydown="enterkey();">
		<!-- 外部表格开始 -->
		<table width="100%" height="100%" align="center" style="vertical-align:middle">
			<tr>
				<td width="55">&nbsp;</td>
				<td height="750" >
					<div align="center" style="vertical-align:middle" id="test">
						<table cellpadding="0" cellspacing="0" border="0"  >
							<tr>
								<td><img src="<c:url value='/images/login_web_03.jpg'/>" height="114" /></td>
								<td rowspan="4" style="background:#999999;width:4px;"></td>
							</tr>
							<tr>
								<td><img src="<c:url value='/images/login_web_04.jpg'/>"  height="157" /></td>	 
								<td width="%">
									<div class="login" id="login">
										<table width="215"  height="100" cellpadding="0" cellspacing="0" >
											<tr>
												<td style="float:left;" colspan="2"><img src="<c:url value='/images/login_08.jpg'/>" width="212"  /></td>
											</tr>
											<tr>
												<td height="25" colspan="2" style="font-family: '微软雅黑';font-size: 15px;" align="middle">i18n_systemSelect.message.loginSuccess_n81i！</td>
											</tr>
											<tr>
												<td height="25" colspan="2" style="font-family: '微软雅黑';font-size: 15px" nowrap="nowrap">
												i18n_systemSelect.message.system_n81i：<select id='system' name='systemId'  >
																						<c:forEach items="${stList}" var="st" >
																						<option value="${st[0] }">${st[1] }</option>
																						</c:forEach>
																					</select>
																					<input type="hidden" value=""/>
																					<!-- 
																					<input type="text" />
																					 -->
												</td>
											</tr>
											<tr>
												<td>
													<table cellpadding="0" cellspacing="0" style="margin-left:56px;"  height="40" >
														<tr>
															<td width="45">
																	<img src="<c:url value='/images/button1.png'/>" onclick="sub();" />
															</td>
															<td width="5">
																	&nbsp;
															</td>
															<td width="45">
																	<img src="<c:url value='/images/tuichu.png'/>" onclick="exitSystem();"/>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td><img src="<c:url value='/images/login_web_05.jpg'/>"  height="134" /></td>
							</tr> 
						</table>
					</div>
				</td>
				<td width="55">&nbsp;</td>
			</tr>
		</table>
<!-- 外部表格结束 -->
	</form>
</body>
</html>
