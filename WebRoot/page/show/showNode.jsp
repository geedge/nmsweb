<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>i18n_sn.message.title_n81i</title>

		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />

		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/raphael.js'/>"></script>

		<script type="text/javascript">
		var raphael;
		var top = 100;
		var left = 200;
		var Xgap = 200;
		var Ygap = 80;
		var nodeWidth = 120;
		var nodeHeight = 80;
		var textOffset = 8;
		var nodes = new Array();
		$(function(){
			var height = document.body.clientHeight;
			var width = document.body.clientWidth-5;
			//alert(height+"   "+width);
			raphael =  Raphael(0,0, width,height);
			//raphael.rect(0,0,width,height).attr({'stroke-width':1,stroke: "#FFFFFF", fill: "#FBFBEA"});
			
			//画节点图间的关系
			draw();
			
			//节点间关系
			drawLine();
		})
		
		//var serverImg  = raphael.rect(serverImgX,y,serverImgWidth,serverImgHeight).attr({stroke: "#FFFFFF", fill: "url("+serverImgUrl+")"});
		function draw(){
		   	for(var i = 0;i < 9; i++){
   				var nodeX = left + i%3*(nodeWidth+Xgap);
   				var nodeY = top + parseInt(i/3)*(nodeHeight+Ygap);
   				var node  = raphael.rect(nodeX,nodeY,nodeWidth,nodeHeight).attr({stroke: "#FFFFFF", fill: "#990000"});
   				node.id = "node"+i;
   				nodes[i] = node;
		   	}
			
		}
		
		function drawLine(){
			for(key in nodes){
				if(key%3 == 1){
					var previousNode = nodes[key-1];
					var previousNodeAttr = raphael.getById("node"+(key-1)).attr();
					var preNodeX = previousNodeAttr["x"]+previousNodeAttr["width"];
					var preNodeY = previousNodeAttr["y"]+previousNodeAttr["height"]/2 ;
					//var preNodeY1 = previousNodeAttr["y"]+previousNodeAttr["height"]*2/3 ;
					
					var currentNode = nodes[key];
					var currentNodeAttr = raphael.getById("node"+key).attr();
					var curNodeX = currentNodeAttr["x"];
					var curNodeY = currentNodeAttr["y"]+currentNodeAttr["height"]/2;
					//var curNodeY1 = currentNodeAttr["y"]+currentNodeAttr["height"]*2/3;
					//画带箭头的线
					var arrorPath = getArr(preNodeX, preNodeY,curNodeX,curNodeY,8);
					//var arrorPath1 = getArr(curNodeX,curNodeY1,preNodeX, preNodeY1,8);
					raphael.path(arrorPath).attr({'stroke-width':1,stroke: "#000000"});
					//raphael.path(arrorPath1).attr({'stroke-width':1,stroke: "#FF0000"});
					//写内容
					var rot = Raphael.angle(curNodeX, curNodeY,preNodeX,preNodeY);
					var contentX = preNodeX+(curNodeX-preNodeX)/2+(((curNodeX-preNodeX)>0) && ((curNodeY-preNodeY)<0)?-textOffset:textOffset);
					var contentY = preNodeY+(curNodeY-preNodeY)/2-textOffset;
					raphael.text(contentX,contentY,"i18n_sn.message.content_n81i"+key).attr({'stroke-width':0.1,stroke: "#333333", fill: "#333333",transform:"r"+rot});
					
				}else if(key%3 == 2){
					var previousNode = nodes[key-1];
					var previousNodeAttr = raphael.getById("node"+(key-1)).attr();
					var preNodeX = previousNodeAttr["x"]+previousNodeAttr["width"];
					var preNodeY = previousNodeAttr["y"]+previousNodeAttr["height"]/3 ;
					var preNodeY1 = previousNodeAttr["y"]+previousNodeAttr["height"]*2/3 ;
					
					var currentNode = nodes[key];
					var currentNodeAttr = raphael.getById("node"+key).attr();
					var curNodeX = currentNodeAttr["x"];
					var curNodeY = currentNodeAttr["y"]+currentNodeAttr["height"]/3;
					var curNodeY1 = currentNodeAttr["y"]+currentNodeAttr["height"]*2/3;
					//画带箭头的线
					var arrorPath = getArr(preNodeX, preNodeY,curNodeX,curNodeY,8);
					var arrorPath1 = getArr(curNodeX,curNodeY1,preNodeX, preNodeY1,8);
					raphael.path(arrorPath).attr({'stroke-width':1.3,stroke: "#000000"});
					raphael.path(arrorPath1).attr({'stroke-width':1.5,stroke: "#000000"});
					//写内容
					var rot = Raphael.angle(curNodeX, curNodeY,preNodeX,preNodeY);
					var contentX = preNodeX+(curNodeX-preNodeX)/2+(((curNodeX-preNodeX)>0) && ((curNodeY-preNodeY)<0)?-textOffset:textOffset);
					var contentY = preNodeY+(curNodeY-preNodeY)/2-textOffset;
					raphael.text(contentX,contentY,"i18n_sn.message.content_n81i"+key+"1").attr({'stroke-width':0.1,stroke: "#333333", fill: "#333333",transform:"r"+rot});
					
					var contentX1 = preNodeX+(curNodeX-preNodeX)/2+(((curNodeX-preNodeX)>0) && ((curNodeY1-preNodeY1)<0)?-textOffset:textOffset);
					var contentY1 = preNodeY1+(curNodeY1-preNodeY1)/2-textOffset;
					raphael.text(contentX1,contentY1,"i18n_sn.message.content_n81i"+key+"2").attr({'stroke-width':0.1,stroke: "#333333", fill: "#333333",transform:"r"+rot});
				}else if(key == 3){
					var currentNode = nodes[key];
					var currentNodeAttr = raphael.getById("node"+key).attr();
					var curNodeX = currentNodeAttr["x"]+previousNodeAttr["width"];
					var curNodeY = currentNodeAttr["y"]+currentNodeAttr["height"]/2;
					
					var nextNodeX = curNodeX+Xgap;
					var nextNodeY = currentNodeAttr["y"] - Ygap - nodeHeight/3;
					
					var nextNodeY1 = currentNodeAttr["y"] + currentNodeAttr["height"] + Ygap + nodeHeight/3; 
					
					var arrorPath = getArr(curNodeX, curNodeY,nextNodeX,nextNodeY,8);
					var arrorPath1 = getArr(curNodeX,curNodeY,nextNodeX, nextNodeY1,8);
					raphael.path(arrorPath).attr({'stroke-width':1.2,stroke: "#000000"});
					raphael.path(arrorPath1).attr({'stroke-width':1.2,stroke: "#000000"});
					
					var rot = Raphael.angle(nextNodeX,nextNodeY,curNodeX, curNodeY);
					var contentX = curNodeX+(nextNodeX-curNodeX)/2+(((nextNodeX-curNodeX)>0) && ((nextNodeY-curNodeY)<0)?-textOffset:textOffset);
					var contentY = curNodeY+(nextNodeY-curNodeY)/2-textOffset;
					raphael.text(contentX,contentY,"i18n_sn.message.content_n81i"+key+"1").attr({'stroke-width':0.1,stroke: "#333333", fill: "#333333",transform:"r"+rot});
					
					var rot1 = Raphael.angle(nextNodeX,nextNodeY1,curNodeX, curNodeY);
					var contentX1 = curNodeX+(nextNodeX-curNodeX)/2+(((nextNodeX-curNodeX)>0) && ((nextNodeY1-curNodeY)<0)?-textOffset:textOffset);
					var contentY1 = curNodeY+(nextNodeY1-curNodeY)/2-textOffset;
					raphael.text(contentX1,contentY1,"i18n_sn.message.content_n81i"+key+"1").attr({'stroke-width':0.1,stroke: "#333333", fill: "#333333",transform:"r"+rot1});
				}
				
			}
		}
		
		//画带箭头的线
			//var arrorPath = getArr(resPos.x, resPos.y,desPos.x,desPos.y,imgStep);
			//raphael.path(arrorPath).attr({'stroke-width':1,stroke: "#FF0000"});
		
		//获取组成箭头的三条线段的路径
     function getArr(x1, y1, x2, y2, size) {
         var angle = Raphael.angle(x1, y1, x2, y2);//得到两点之间的角度
         var a45 = Raphael.rad(angle - 45);//角度转换成弧度
         var a45m = Raphael.rad(angle + 45);
         var x2a = x2 + Math.cos(a45) * size;
         var y2a = y2 + Math.sin(a45) * size;
         var x2b = x2 + Math.cos(a45m) * size;
         var y2b = y2 + Math.sin(a45m) * size;
         var result = ["M", x1, y1, "L", x2, y2, "L", x2a, y2a, "M", x2, y2, "L", x2b, y2b,"Z"];
         return result;
     }
		
		</script>

	</head>

	<body>
	</body>
</html>
