<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
$(function(){
/* 	$.ajax({
		url:'http://127.0.0.1:8080/nmsweb/authentication/identificat.do?action=identification&token='+getUrlParam('token'),
		type:"get",
		async:false,
		dataType:"jsonp",
		jsonp:"jsonCallback",
		success:function(data){
			alert(data.user+"=="+data.pwd);
		},
		error:function(data){
			alert("没有相应的token:"+data);
		}
		
	}); */
	$.ajax({ 
		url:'http://127.0.0.1:8080/nmsweb/authentication/identificat.do?action=identification&token='+getUrlParam('token'),
        type: "get", 
        async: false, 
        dataType: "jsonp", 
        jsonp: "callback", //服务端用于接收callback调用的function名的参数(请使用callback或jsonp)
        jsonpCallback: "fun_jsonpCallback", //callback的function名称
        success: function(json) { 
            alert(json.user); 
        },
        error: function(){
            alert('Request Error');
        } 
    }); 
});
//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
</script>
</head>

<body>
	username:<input type="text" id="username"/><br/>
	password:<input type="password" id="password"/>
</body>
</html>