<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="Shortcut icon" href="images/logo.ico"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>i18n_login.message.title_n81i</title>
<style type="text/css">
* {margin:0px;
   padding:0px;}
	
html, body {;
           background:#EBECEB;;}

.login{font-size:14px;
     margin-left:10px;
	 width:200px;
	 height:155px;}
.loginInput{
	margin-top:5px;
	/* border:1px solid #62c1c6;
	border-radius: 5px 5px 5px 5px; */
	text-align: left;
}
.loginInput img{
	width: 25px;
	height: 20px;
	margin-right:5px;
	float:left;
}	   	 

</style>
</head>
<script type="text/javascript">  
	function sub(){
		var userName=document.getElementById("yhmc").value;
		var password=document.getElementById("yhmm").value;
		if(userName==''){
			//ymPrompt.errorInfo({message:'请输入用户编号或密码！',title:'提示',width:250,height:180});
			alert("i18n_login.message.username_n81i");
			return false;
		}
		if(password==''){
			//ymPrompt.errorInfo({message:'请输入用户编号或密码！',title:'提示',width:250,height:180});
			alert("i18n_login.message.password_n81i");
			return false;
		}
		
		document.form1.submit();
			
	}
	function enterkey(){
	    try{	
	    	var userName=document.getElementById("yhmc").value;
			var password=document.getElementById("yhmm").value;
	        //var el_keydown=window.event.srcElement;
	        var event=arguments.callee.caller.arguments[0]||window.event;
	        var el_keydown=arguments.callee.caller.arguments[0].target||window.event.srcElement;
	         if(event.keyCode==13){
	         	if(el_keydown.id=="yhmc" && el_keydown.value!=''&& password!=''){
	         		 document.form1.submit();
	         	}else if(el_keydown.id=="yhmm" && el_keydown.value!=''&& userName!=''){
	         		 document.form1.submit();
	         	}else{
	         		//ymPrompt.errorInfo({message:'请输入用户编号或密码！',title:'提示',width:250,height:180});
	         		alert("i18n_login.message.username_n81i");
					return false;
	         	}
	         } 
	    }catch(e){
			return ;
	    }
}

</script>
<body>
	<form action="login!login.do" name="form1" method="post">
		<!-- 外部表格开始 -->
		<table width="100%" height="100%" align="center" style="vertical-align:middle">
			<tr>
				<td width="55">&nbsp;</td>
				<td height="750" >
					<div align="center" style="vertical-align:middle">
						<table cellpadding="0" cellspacing="0" border="0"  >
							<tr>
								<td><img src="images/login_web_03.jpg" height="114" /></td>
								<td rowspan="4" style="background:#999999;width:4px;"></td>
							</tr>
							<tr>
								<td><img src="images/login_web_04.jpg"  height="157" /></td>	 
								<td width="43%">
									<div class="login">
										<table width="215"  height="100" cellpadding="0" cellspacing="0" >
											<tr>
												<td style="float:left;" colspan="2"><img src="images/login_07.jpg" width="212"  /></td>
											</tr>
											<tr>
												<td height="25" colspan="2" ><div class="loginInput"><img  src="images/user.png"  /><input type="text" name="logInInfo.yhmc" title="i18n_login.message.yhmc_n81i" id="yhmc" value="" onkeyDown="enterkey();" style="width:150px;" /></div></td>
											</tr>
											<tr>
												<td height="25" colspan="2"><div class="loginInput"><img  src="images/pwd.png"  /><input type="password" name="logInInfo.yhmm" id="yhmm" value="" onkeyDown="enterkey();" style="width:150px;"/></div></td>
											</tr>
											<!-- 
											<tr>
												<td width="163"  height="25">验证码：<input type="text" name="验证码" style="width:95px;" /></td>
												<td width="53" ><img src="images/img.jpg" /></td>
											</tr>
											 -->
											<tr>
												<td>
													<table cellpadding="0" cellspacing="0" style="margin-left:56px;"  height="40" >
														<tr>
															<td width="45"  ><img src="images/button1.png" onclick="sub();"  /></td>
															<td width="5">&nbsp;</td>
															<td width="45"  ><img src="images/button2.png"  onclick="javascript:document.forms['form1'].reset()" /></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td><img src="images/login_web_05.jpg"  height="134" /></td>
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
<script>
document.getElementById("yhmc").focus();
</script>
</html>
