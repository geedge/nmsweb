<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>i18n_sr.message.title_n81i</title>

		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/raphael.js'/>"></script>
		<style>
body {
	background-image: url("<%=path %>/images/show/bg.jpg");
	background-repeat: no-repeat;
	background-position: center;
	scrollbar-face-color: #E6E7E9; //滚动条凸出部分的颜色 
	scrollbar-highlight-color: #E7E8EA; //滚动条空白部分的颜色 
	scrollbar-shadow-color: #E6E7E9; //立体滚动条阴影的颜色 
	scrollbar-3dlight-color: #E6E7E9; //滚动条亮边的颜色 
	scrollbar-arrow-color: #E1E3E0; //上下按钮上三角箭头的颜色 
	scrollbar-track-color: #E6E7E9; //滚动条的背景颜色 
	scrollbar-darkshadow-color: #CCCCCC; //滚动条强阴影的颜色 
	scrollbar-base-color: #E6E7E9// 滚动条的基本颜色
}

#hint {
	border: 1px solid #000000;
	background: #EEF0ED;
	position: absolute;
	z-index: 9;
	padding: 6px;
	line-height: 14px;
	text-align: left;
	top: 1520px;
	font-size: 12px;
}
</style>

		<script type="text/javascript">
		var raphael;
		var raphaelRoom;
		var top1 = 20;
		var left = 5;
		var Xgap = 5;
		var Ygap = 10;
		var nodeWidth = 60;
		var nodeHeight = 60;
		var leafNodeHeight = 33;
		var textOffset = 8;
		var nodes = new Array();
		
		var roomY = 30;
		var roomGap = 5;
		var roomWidth=100;
		var roomHeight=100;
		var minboxWidth=50;
		var minboxHeight=100;
		var boxWidth=250;
		var boxHeight=500;
		var nodegroupsHeight=0;
		
		var nodeGroupUrl="${pageContext.request.contextPath}/images/topo3d/nodeGroup.png";
		var nodeGroupErrorUrl="${pageContext.request.contextPath}/images/topo3d/nodeGroupError.png";
		var leafNodeUrl="${pageContext.request.contextPath}/images/topo3d/leafNode.png";
		var leafNodeErrorUrl="${pageContext.request.contextPath}/images/topo3d/leafNodeError.png";
		
		var boxUrl="${pageContext.request.contextPath}/images/topo3d/box.png";
		var boxErrorUrl="${pageContext.request.contextPath}/images/topo3d/boxError.png";
		
		var lineUrl = "${pageContext.request.contextPath}/images/topo3d/cutLine.png";
		$(function(){
			var height = document.body.clientHeight;
			var width = document.body.clientWidth;
			$("#nodegroups").css("height",height-10);
			
			var length = '${fn:length(nodegroupList) }';
			nodegroupsHeight = top1+ length*(nodeHeight+Ygap)
			raphael =  Raphael("nodegroups",70,nodegroupsHeight);
			
			var leafNums = 0;
			var firstGroupId = '${firstGroupId}';
		
			<c:forEach items="${nodegroupList}" var="nodeGroup" varStatus="index">
				
				var ind = '${index.index}';
				if(ind == 0 && (firstGroupId == ""||firstGroupId == null)){
					firstGroupId = '${nodeGroup.groupId}';
				}
				var nodeX = left;
   				var nodeY = top1 +ind*(nodeHeight+Ygap)-(leafNums*(nodeWidth-leafNodeHeight));
				var fillImg;
				var fillImgHeight;
				//是否为叶子节点组 leafGroup=0叶子节点组
				if('${nodeGroup.leafGroup}' == 0){
					//节点组状态 0正常 1异常
					if('${nodeGroup.status}' == 0){
						fillImg = leafNodeUrl;
					}else{
						fillImg = leafNodeErrorUrl;
					}
					fillImgHeight = leafNodeHeight;
					leafNums++;
				}else{
					//节点组状态 0正常 1异常
					if('${nodeGroup.status}' == 0){
						fillImg = nodeGroupUrl;
					}else{
						fillImg = nodeGroupErrorUrl;
					}
					fillImgHeight = nodeHeight;
				}
   				var node  = raphael.rect(nodeX,nodeY,nodeWidth,fillImgHeight).attr({stroke: "#FFFFFF",'stroke-width':0.1,title:'${nodeGroup.groupName}',text:'${nodeGroup.alramInfo}', fill: "url("+fillImg+")"});
   				node.id = '${nodeGroup.groupId}';
   				nodes['${nodeGroup.groupId}']=node;
   				
   				$("body").append("<input type='hidden' id='${nodeGroup.groupId}' value=''>");
   				$("input[id='${nodeGroup.groupId}']").val('${nodeGroup.alramInfo}');
   				
   				//点击查看节点组下的机房
   				node.click(function(){
   					clearSelectImg();
   					var imgUrl = this.attr("fill");
   					imgUrl = imgUrl.replace(".png","_select.png");
   					this.attr({ fill: imgUrl});
					getNodeRoom('${nodeGroup.groupId}');
					
				}).mousemove(function(event){
					this.animate({"fill-opacity":.8},800);
//					var alramInfo = this.attr("text");
					var nodeid = this.id;
					var selector = "#"+nodeid;
					var alramInfo = $(selector).val();
					showMsg(alramInfo,event);
				}).mouseout(function(){
					this.animate({"fill-opacity":1},800);
					hideMsg();
				})
			</c:forEach>
			
			//初始化机房展示
			$("#I2").attr("src","<c:url value='/nodePosition/topoShow.do?action=getNodeRoom&groupId="+firstGroupId+"&nodeBoxId=${nodeBoxId}&nodeBoxIspn=${nodeBoxIspn}'/>");
			var imgUrl = nodes[firstGroupId].attr("fill");
			imgUrl = imgUrl.replace(".png","_select.png");
			nodes[firstGroupId].attr({ fill: imgUrl});
		})
		
		function getNodeRoom(groupId){
			$("#I2").attr("src","<c:url value='/nodePosition/topoShow.do?action=getNodeRoom&groupId="+groupId+"'/>");
		}
		
		function clearSelectImg(){
			for(key in nodes){
				var node =  raphael.getById(key);
				var fillUrl = node.attr("fill");
				if(fillUrl.indexOf("_select") >0){
					fillUrl = fillUrl.replace("_select","");
					node.attr({fill:fillUrl});
				}
			}
		}
		
		function showMsg(alramInfo,event){  
	     var oSon = window.document.getElementById("hint");  
	     var infos = alramInfo.split("|");
	     var info="";
	     for(key in infos){
	     	if(key == 0){
	     	var inf="";
	     		var a = infos[key];
	     		if(a.length>13){
		     		for(var i = 0 ;i <a.length;i++){
			     		if(i%13==0&&i!=0){
			     			inf = inf + "<br/>";
			     		}
		     			inf = inf + a.charAt(i);
		     		}
	     		}else{
	     			inf =infos[key];
	     		}
	     		info+="<span style='font-weight: bold;'>"+inf+"</span><br/><br/>";
	     	}else{
	     		info+=infos[key]+"<br/>";
	     	}
	     	
	     }
	     with (oSon){
		      innerHTML = info;  
		      style.display = "block";  
			if(navigator.userAgent.indexOf("MSIE")>0) {  
       		  style.pixelLeft = window.event.clientX + window.document.body.scrollLeft-200 ;  
		      style.pixelTop = window.event.clientY + window.document.body.scrollTop-50;  
   			}else if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
   				var e = event ? event : window.event;
		        x = e.clientX;
		        y = e.clientY;
				  style.left = x + window.document.body.scrollLeft-200 ;  
			      style.top =  y + window.document.body.scrollTop-50;  
   			}else if(navigator.userAgent.indexOf("Chrome")>0){
   				var e = event ? event : window.event;
		        x = e.clientX;
		        y = e.clientY;
				  style.left = x + window.document.body.scrollLeft-200 ;  
			      style.top =  y + window.document.body.scrollTop-50;
   			}		      
	     	}  
    	} 
		
		function hideMsg(){
			$("#hint").hide();
		}
		
		$(function(){
			$("#prev").click(function(){
				var ctopVal = Number($("#nodegroups").children().css("top").replace("px",""));
				var pageHeight = Number($("#nodegroups").css("height").replace("px",""));
				pageHeight = ctopVal>=0?pageHeight:0;
				ctopVal = ctopVal>=0?ctopVal:-ctopVal;
				//alert(ctopVal+"--"+pageHeight);
				if(ctopVal<=pageHeight){
					alert("i18n_sr.message.isFirst_n81i");
					return;
				}
				var topVal = Number($("#nodegroups").children().css("top").replace("px",""))+(nodeHeight+Ygap);
				$("#nodegroups").children().animate({top:topVal},{queue:false,duration:500});
			})
			
			$("#next").click(function(){
				var ctopVal = Number($("#nodegroups").children().css("top").replace("px",""));
				var pageHeight = Number($("#nodegroups").css("height").replace("px",""));
				if((-ctopVal+pageHeight) >= nodegroupsHeight){
					alert("i18n_sr.message.isLast_n81i");
					return;
				}
				var topVal = Number($("#nodegroups").children().css("top").replace("px",""))-(nodeHeight+Ygap);
				//alert(ctopVal+"--"+nodegroupsHeight+"--"+topVal+"--"+$("#nodegroups").css("height"));
				$("#nodegroups").children().animate({top:topVal},{queue:false,duration:500});
			})
			
			/*if(navigator.userAgent.indexOf("MSIE")>0) {  
				$("#I2").css("height","100%");
   			}else if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
   				$("#I2").css("height","870px");
   			}*/
   			resizeIframe('I2');
		})
		    function resizeIframe(obj) {
		        var Iframe = document.getElementById(obj);
		            if (Iframe){
		                if (Iframe.contentDocument){//ff
		                    Iframe.style.height = Iframe.contentDocument.body.scrollHeight +80+'px';
		                }
		                else if(Iframe.document && Iframe.document.body.scrollHeight){//ie
		                Iframe.style.height = iframe.document.body.scrollHeight + 40 + 'px';
		            }
		        }
   			}
		</script>
	</head>

	<body style="overflow-y: hidden">
		<div>
			<iframe id="I2" name="I2" height="100%" width="100%" border="0" 
				frameborder="0" src="" scrolling="auto">
				i18n_sr.message.frame_n81i
			</iframe>
		</div>
		<!-- 节点组画布 -->

		<div
			style="position: absolute; top: 22px; right: 20px; z-index: 2; width: 70px; overflow: hidden; border-left: #cccccc 1px solid;"
			id="nodegroups">
		</div>
		<div id="prev"
			style="position: absolute; top: 2px; right: 2px; z-index: 2; width: 70px; height: 22px; background-repeat: no-repeat; background-image: url('../images/prev_v.png');">
		</div>
		<div id="next"
			style="position: absolute; bottom: 2px; right: 2px; z-index: 2; width: 70px; height: 22px; background-repeat: no-repeat; background-image: url('../images/next_v.png');">
		</div>


		<div id="hint" style="display: none;" mousemove="showMsg()"
			onmouseout="hideMsg()"></div>
	</body>
</html>
