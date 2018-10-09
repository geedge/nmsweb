<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>i18n_st.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet"
			href="<c:url value='/js/jquery-easyui-1.1.2/themes/default/easyui.css'/>"
			type="text/css"></link>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.min.js"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/raphael.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery-easyui-1.1.2/jquery.easyui.min.js' />"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jtopo-0.4.8_01-min.js' />"></script>
			
		<style>		
		body {
			background-image: url("<%=path%>/images/show/bg.jpg");
			background-repeat: no-repeat;
			background-position: center;
			scrollbar-face-color: #EEF0ED; //滚动条凸出部分的颜色
		 	scrollbar-highlight-color: #E7E8EA; //滚动条空白部分的颜色
		 	scrollbar-shadow-color: #EEF0ED; //立体滚动条阴影的颜色
		 	scrollbar-3dlight-color: #EEF0ED; //滚动条亮边的颜色
		 	scrollbar-arrow-color: #E1E3E0; //上下按钮上三角箭头的颜色
		 	scrollbar-track-color: #EEF0ED; //滚动条的背景颜色
		 	scrollbar-darkshadow-color: #CCCCCC; //滚动条强阴影的颜色
		 	scrollbar-base-color: #EEF0ED //滚动条的基本颜色
		}
		</style>	
</head>

<body>
	
	<div>
		<canvas  id="canvas" style="background-color:#FAFAFA; border:1px solid #444;display:block"></canvas>
	</div>
	
	<!-- <div id="nodeList" closed="true">
		1为禁止查询，2为可以联想查询  此开关同main.jsp
		<input type="hidden" id="lianxiangStatus" value="2" />
		<span id="title" class="color_3_tip"
			style="width: 100%;  display: none; text-align: center;"></span>
		<div id="title" class="color_3_tip" style="height: 20px;text-align: center;line-height: 20px">i18n_st.text.policy_n81i</div>
		<iframe id="I2" name="I2" height="30%" width="100%" border="0"
			style="background: #FFFFFF; display: none;" frameborder="0" src=""
			scrolling="no">
			i18n_st.message.frameInfo_n81i
		</iframe>
		<hr id="hr" />
		<iframe id="I3" name="I3" height="100%" width="100%" border="0"
			style="background: #FFFFFF;" frameborder="0" src="" scrolling="no">
			i18n_st.message.frameInfo_n81i
		</iframe>
	</div> -->
	<span id='content' ></span>
</body>
<script>
var imgagePath="${pageContext.request.contextPath}/images/newtopo/";
var canvas = document.getElementById('canvas'); 
var stage = new JTopo.Stage(canvas); // 创建一个舞台对象
var scene = new JTopo.Scene(stage); // 创建一个场景对象
var nodeMap={};
//节点
function newNode(x, y, w, h, text,img){
    var node = new JTopo.Node(text);
    node.setImage(imgagePath+img,false);
    node.setLocation(x, y);
    node.setSize(w, h);
    node.fillColor='255,128,0';
    node.fontColor='0,0,0';
    node.addEventListener("click",function(node){
    	console.log('x  ----- '+node.target.x+'     y ------ '+node.target.y+' ----  '+node.target.text);
    })
    scene.add(node);
    return node;
}

// 简单连线
function newLink(nodeA, nodeZ, text, dashedPattern,arrowsRadius){
    var link = new JTopo.Link(nodeA, nodeZ, text);
    link.lineWidth = 2; // 线宽
    link.dashedPattern = dashedPattern; // 虚线
    link.bundleOffset = 60; // 折线拐角处的长度
    link.bundleGap = 20; // 线条之间的间隔
    link.textOffsetY = 3; // 文本偏移量（向下3个像素）
    link.strokeColor = '0,0,0';
    link.fontColor='0,0,0';
    if(arrowsRadius){
    	link.arrowsRadius = 10;
    }  
    scene.add(link);
    return link;
}
// 折线
function newFoldLink(nodeA, nodeZ, text, direction, dashedPattern){
    var link = new JTopo.FoldLink(nodeA, nodeZ, text);
    link.direction = direction || 'horizontal';
//    link.arrowsRadius = 15; //箭头大小
    link.lineWidth = 2; // 线宽
    link.bundleOffset = 40; // 折线拐角处的长度
    link.bundleGap = 20; // 线条之间的间隔
    link.textOffsetY = 3; // 文本偏移量（向下3个像素）
    link.dashedPattern = dashedPattern; 
    link.strokeColor = '0,0,0';
    link.fontColor='0,0,0';
    scene.add(link);
    return link;
}


//二次折线
function newFlexionalLink(nodeA, nodeZ, text, dashedPattern,direction){
    var link = new JTopo.FlexionalLink(nodeA, nodeZ, text);
//    link.arrowsRadius = 10;
    link.lineWidth = 2; // 线宽
    link.bundleGap = 15; // 线条之间的间隔
    link.textOffsetY = 10; // 文本偏移量（向下15个像素）
    link.dashedPattern = dashedPattern; 
    link.direction=direction||'vertical';
    link.strokeColor = '0,0,0';
    link.fontColor='0,0,0';
    scene.add(link);
    return link;
}

	$(function (){
		$("#canvas").attr("width",$(window).get(0).innerWidth);
		$("#canvas").attr("height",$(window).get(0).innerHeight);

		scene.mousemove(function(event){
			var node=event.target;
			if(node&&node.elementType=='node'){
				var width=20;
				$('#content').html(node.text);
				$('#content').css({
					position:'absolute',
					top:event.pageY,
					left:event.pageX+20
				}).show();
			}else{
				$('#content').hide();
			}
		});
		
	    
	    //遍历创建节点对象
	    <c:forEach items="${requestScope.topoNodeInfos}" var="item">
	    /* 	var node${item.id} = newNode(${item.x},${item.y},${item.width},${item.height},'${item.text}${item.id}','${item.topoImg.name}'); */
			var node${item.id} = newNode(${item.x},${item.y},${item.width},${item.height},'${item.text}','${item.topoImg.name}');
			node${item.id}.status=${item.status};
			node${item.id}.serializedProperties.push('status');
			
			<c:if test="${item.status==1}">
				node${item.id}.nodeInterval=setInterval(function(){
						if(node${item.id}.alarm!=null&&node${item.id}.alarm!=''){
							node${item.id}.alarm=null;
						}else{
							node${item.id}.alarm='${item.alarm}';
							node${item.id}.alarmColor='171,30,50';
							node${item.id}.alarmAlpha=0.8;
						}
					},600)
				
				node${item.id}.serializedProperties.push('nodeInterval');
			</c:if>
			
			<c:choose>
				<c:when test="${item.type==4}">
					node${item.id}.addEventListener("click",function(){
						window.location.href="${pageContext.request.contextPath}/nodePosition/newTopoShow.do?action=showTopo&topoInfoId="+${item.typeId};
					});
				</c:when>
				<c:when test="${item.type==1||item.type==2}">
					node${item.id}.addEventListener("click",function(node){
						/* parent.getDetectInfo(${item.typeId},${item.type},${item.status}); */
						getDetectInfo(${item.typeId},${item.type},${item.status});
					});
				</c:when>
			</c:choose>
			
			//设置自己特定的class样式
			<c:if test="${not empty item.topoNodeInfoClass}">
				var classJson=${item.topoNodeInfoClass};
				for(var i=0;i<classJson.length;i++){
					for(var key in classJson[i]){
						if(key=='textPosition'){
							node${item.id}.textPosition=classJson[i][key];
						}
					}
				}
			</c:if>
		
			//将节点对象放入map中   key为node+id  值为节点对象
			nodeMap['node${item.id}']=node${item.id};
		</c:forEach>
	    	     
		//遍历创建连线 连接节点
		<c:forEach items="${requestScope.topoLineInfos}" var="item">
			<c:choose>
				<c:when test="${not empty item.topoLineInfoClass}">
					var link${item.id};
					var classJson=${item.topoLineInfoClass};
					for(var i=0;i<classJson.length;i++){
						for(var key in classJson[i]){
							if(key=='newLineMethod'){
								if(classJson[i][key]=='FoldLink'){
									link${item.id}=newFoldLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}');
								}else if(classJson[i][key]=='FlexionalLink'){
									link${item.id}=newFlexionalLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}');
								}
							}else if(key=='offsetGap'){
								link${item.id}.offsetGap=classJson[i][key];
							}else if(key=='direction'){
								link${item.id}.direction=classJson[i][key];
							}else if(key=='nodeIndex'){
								link${item.id}.nodeIndex=classJson[i][key];
							}
						}
					}
				</c:when>
				<c:otherwise>
					var link${item.id} = newLink(node${item.topoNodeInfo1.id},node${item.topoNodeInfo2.id},'${item.text}');
				</c:otherwise>
			</c:choose>
		</c:forEach>

		//缩放并居中显示
		stage.centerAndZoom();
		//设置鼠标可以进行滚轮放大缩小
		stage.wheelZoom=0.85;

	})
	
	$(function(){
		//5分钟刷新一次
		interview = setInterval('refresh()',5*60*10000);
		var height =  document.body.clientHeight;
		var width =  document.body.clientWidth;
	})
	
	function refresh(){
		var varNames={};
		$.ajax({
			type:"post",
			dataType:'json',
			url:"<c:url value='/nodePosition/newTopoShow.do?action=showTopo'/>",
			data:"&requestType=ajax",
			async:true,
			success:function (data,textStatus){
				if(textStatus=='success'&&data!=''&&data!=null){
					var topoNodeInfos;
					var topoLineInfos;
					$(data).each(function(i,item){
						topoNodeInfos = item.topoNodeInfoList;
						topoLineInfos = item.topoLineInfoList;
				 	})
				 	
					$(topoNodeInfos).each(function(i,item){
						//修改节点的警告状态
						if(nodeMap['node'+item.id].status==item.status){
							return;
						}else if(item.status==1){
							console.log('进入重设alarm')
							nodeMap['node'+item.id].nodeInterval=setInterval(function(){
								if(nodeMap['node'+item.id].alarm!=null&&nodeMap['node'+item.id].alarm!=''){
									nodeMap['node'+item.id].alarm=null;
								}else{
									nodeMap['node'+item.id].alarm=item.alarm;
									nodeMap['node'+item.id].alarmColor='171,30,50';
									nodeMap['node'+item.id].alarmAlpha=0.8;
								}
							},600);
							nodeMap['node'+item.id].serializedProperties.push('nodeInterval');
							nodeMap['node'+item.id].status=1;
						}else{
							console.log('删除alarm');
							nodeMap['node'+item.id].alarm=null;
							nodeMap['node'+item.id].status=0;
							window.clearInterval(nodeMap['node'+item.id].nodeInterval);
						}
				 	})
				}
			}		
		}) 
	}
	 
	
	//以下代码解决了easy-ui报错 can't read property msie of undefined
	jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
	
	$(function(){
		 //告警节点列表初始化
		/* $("#nodeList").dialog({
			title:"i18n_st.nodeList.title_n81i",
			resizable:true,
			width:1024,
			height:600
		});	
		 console.log("123213213213") */
	})

	
function getDetectInfo(id,type,showStatus){
	//根据类型的不同 判断节点或节点组的查询条件
	var url ="<c:url value='/detection/monitorData.do?action=query&nodeType=1&requestType=newTopo&nodeGroupId="+id+"'/>";
	var url2="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&nodeType=1&requestType=topo&nodeGroupId="+id+"'/>";
	if(type==2){
		url ="<c:url value='/detection/monitorData.do?action=query&nodeType=2&requestType=newTopo&nodeId="+id+"'/>";
		url2="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&nodeType=2&requestType=topo&nodeId="+id+"'/>";
	}
	//异常情况，显示紧急告警列表，否则不显示
	if(showStatus == 1){
		//$("#title").show();
		top.$("#I4").show();
		top.$("#hr").show();
		top.$("#I4").attr("src",url2);
	}else{
		//$("#title").hide();
		top.$("#I4").hide();
		top.$("#hr").hide();
	}

	top.$("#I5").attr("src",url);//由于所有数据列表不会出现隐藏的情况，所以标题的确定就有I5来负责
	
	var thisheight = $(document).height()*0.9;
	var thiswidth = $(document).width()*0.9;
	parent.layer.open({
		type: 1,
		title: "i18n_st.text.policy_n81i",
		area:[thiswidth + 'px', thisheight + 'px'],
		shade: 0.6,
		closeBtn: 1,
		maxmin:true,
		content: top.$("#nodeList")
	}); 
	
}


 function setDivTitle(groupName) {
	if(groupName!='undefined' && groupName!=null && groupName!="") {
		$("#nodeList").dialog({
			title:groupName+" i18n_st.text.monitorData_n81i"
		});	
	}else {
		$("#nodeList").dialog({
			title:"i18n_st.text.monitorData_n81i"
		});	
	}
	$("#nodeList").dialog("open");
}

</script>	
</html>