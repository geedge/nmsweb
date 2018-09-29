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
		<title>i18n_ct.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet"
			href="<c:url value='/js/jquery-easyui-1.1.2/themes/default/easyui.css'/>"
			type="text/css"></link>
		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.min.js"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/raphael.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery-easyui-1.1.2/jquery.easyui.min.js' />"></script>
		<style>
body {
	background-image: url("<%=path %>/images/show/bg.jpg");
	background-repeat: no-repeat;
	background-position: center;
}
</style>
		<script type="text/javascript">
	var raphael;
	var raphaelNet;
	var index=0;
	var imgagePath="<%=path %>/images/toposvg/";
	var server = "<%=path %>/images/toposvg/server.png";
	var switchImg = "<%=path %>/images/toposvg/switch.png";
	var coreswitch = "<%=path %>/images/toposvg/core_switch.png";
	var device = "<%=path %>/images/toposvg/device.png";
	var router = "<%=path %>/images/toposvg/router.png";
	var images = new Array();
	var lines = new Array();
	var nodegroupArrowPositions = new Array();//连线位置信息
	var nodegroupBgImgPositions = new Array();//背景图片位置信息
	$(function(){
		var height='${backgroudImg.figureHeight }';
		var width=document.body.clientWidth; //'${backgroudImg.figureWidth }' ;
		raphael =  Raphael("mainDiv", width,height);
		//画底图
		raphael.rect('${backgroudImg.figureX}','${backgroudImg.figureY}','${backgroudImg.figureWidth}','${backgroudImg.figureHeight}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${backgroudImg.figureFill}'+")"});
		
		//-----------------------修改功能 初始化显示所有之前的配置 begin--------------------
		//画节点组背景图
		<c:forEach items="${nodegroupBgimgPositionList}" var="position">
			var  img = raphael.rect('${position.figureX}','${position.figureY}','${position.figureWidth}','${position.figureHeight}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position.figureFill}'+")"});
			var imageName = '${position.figureFill}'.split(".")[0];
			//默认id为数字类型，为Id赋值，如果已赋值则无需再赋值
			if(!isNaN(Number(this.id))){
				img.id=imageName+index;
				index++;
			}
			images[img.id] = {"src":imageName,"x":img.attr("x"),"y":img.attr("y"),"width":img.attr("width"),"height":img.attr("height")};
			nodegroupBgImgPositions['${position.groupId}'] = images[img.id];
		</c:forEach>
		//画灯泡
		//t.id,t.group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill,t.show_status
		//alert(${fn:length(nodeGroupPositionList)});
		<c:forEach items="${nodeGroupPositionList}" var="position">
			var  bulbImg = raphael.rect('${position[2]}','${position[3]}','${position[4]}','${position[5]}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position[6]}'+")"});
		</c:forEach>
		
		//画线
		//t.id,t.src_group_id,t.desc_group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill
		<c:forEach items="${nodegroupArrowPositionList}" var="position">
			var  arrowImg = raphael.rect('${position[3]}','${position[4]}','${position[5]}','${position[6]}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position[7]}'+")"});
			var lineItem = new Array();
			if(nodegroupArrowPositions['${position[1]},${position[2]}'] == null){
				lineItem.push(arrowImg);
				nodegroupArrowPositions['${position[1]},${position[2]}'] = lineItem;
			}else{
				lineItem = nodegroupArrowPositions['${position[1]},${position[2]}'];
				lineItem.push(arrowImg);
				nodegroupArrowPositions['${position[1]},${position[2]}'] = lineItem;
			}
		</c:forEach>
		
		//-----------------------修改功能 初始化显示所有之前的配置 end--------------------
		
		
		raphael.image(server,width-100,10,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1}).mouseover(function(){
			var cloneEle = raphael.image(this.attr("src"),this.attr("x"),this.attr("y"),this.attr("width"),this.attr("height")).attr({stroke: "#FFFFFF",'stroke-width':0.1})
			cloneEle.drag(move,start,end);
			cloneEle.dblclick(function(){
			//双击删除
			/*this.remove();
			images[this.id] = null;*/
			/*for(key in images){
				alert("after:"+key+"--"+images[key]);
			}*/
			//双击连线
			lines[this.id] = {"src":this.attr("src"),"x":this.attr("x"),"y":this.attr("y"),"width":this.attr("width"),"height":this.attr("height")};
			var length=0;
			for(key in lines){
				if(key != null && (key.indexOf("server") !=-1 ||key.indexOf("switch") !=-1 ||key.indexOf("device") !=-1||key.indexOf("router") !=-1)){
					length++;
				}
			}
			//alert("dblclick:"+length);
			if(length ==2){
				configNodegroup();
				//createLine();
			}
			
		})
		});
		
		raphael.image(coreswitch,width-100,82,70,68).attr({stroke: "#FFFFFF",'stroke-width':0.1}).mouseover(function(){
			var cloneEle = raphael.image(this.attr("src"),this.attr("x"),this.attr("y"),this.attr("width"),this.attr("height")).attr({stroke: "#FFFFFF",'stroke-width':0.1})
			cloneEle.drag(move,start,end);
		});
		
		raphael.image(switchImg,width-100,160,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1}).mouseover(function(){
			var cloneEle = raphael.image(this.attr("src"),this.attr("x"),this.attr("y"),this.attr("width"),this.attr("height")).attr({stroke: "#FFFFFF",'stroke-width':0.1})
			cloneEle.drag(move,start,end);
		});
		
		raphael.image(device,width-100,218,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1}).mouseover(function(){
			var cloneEle = raphael.image(this.attr("src"),this.attr("x"),this.attr("y"),this.attr("width"),this.attr("height")).attr({stroke: "#FFFFFF",'stroke-width':0.1})
			cloneEle.drag(move,start,end);
		});
		
		raphael.image(router,width-100,255,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1}).mouseover(function(){
			var cloneEle = raphael.image(this.attr("src"),this.attr("x"),this.attr("y"),this.attr("width"),this.attr("height")).attr({stroke: "#FFFFFF",'stroke-width':0.1})
			cloneEle.drag(move,start,end);
		});
		
		raphael.rect(width-100,300,48,20).attr({stroke: "#000000",'stroke-width':0.5,fill:"#990000"}).click(function(){
			saveTopoConfig();
		});
		
		raphael.text(width-75,310,"i18n_ct.text.save_n81i").attr({'font-size':12,fill:"#ffffff"});
		
		//节点组配置及线配置
		$("#doConfig").dialog({
			title:"i18n_ct.text.sets_n81i",
			resizable:true,
			width:380,
			height:250
		});		
	})
	
	function start(){
		this.xx = this.attr("x");
		this.yy = this.attr("y");
		this.animate({"opacity":.2},500);
	}
	function move(dx,dy){
		this.attr({x:this.xx+dx,y:this.yy+dy});
	}
	
	function end(){
		this.animate({"opacity":1},500);
		var src = this.attr("src");
		var imageName = src.split("/")[2].split(".")[0];
		//默认id为数字类型，为Id赋值，如果已赋值则无需再赋值
		if(!isNaN(Number(this.id))){
			this.id=imageName+index;
			index++;
		}
		images[this.id] = {"src":imageName,"x":this.attr("x"),"y":this.attr("y"),"width":this.attr("width"),"height":this.attr("height")};
		//alert(this.id+"---"+images[this.id].src+"----"+images[this.id].x);
	}
	//配置2节点的节点组信息及，连线信息。
	function configNodegroup(){
		$("#doConfig").dialog("open");
	}
	
	$(function(){
		$("#confirm").click(function(){
			//srcNodeGroup  descNodeGroup  lineDirection  lineNumber  srcLinePostion  descLinePostion
			if($("#srcNodeGroup").val() ==""){
				alert("i18n_ct.message.srcNodeGroup_n81i");
				return;
			}
			
			if($("#descNodeGroup").val() ==""){
				alert("i18n_ct.message.descNodeGroup_n81i");
				return;
			}
			
			if($("#lineOffset").val()!=""){
				if(!Number($("#lineOffset").val())){
					alert("i18n_ct.message.lineOffset_n81i");
					return;
				}
			}
			
			if($("#lineDirection").val() ==""){
				alert("i18n_ct.message.lineDirection_n81i");
				return;
			}
			
			if($("#lineNumber").val() == 3){
				if($("#srcLinePostion").val() ==""){
					alert("i18n_ct.message.srcLinePostion_n81i");
					return;
				}
				
				if($("#descLinePostion").val() ==""){
					alert("i18n_ct.message.descLinePostion_n81i");
					return;
				}
			}
			createLine();
			$("#doConfig").dialog("close");
			//clearConfig();
			
		})
	})
	
	function createLine(){
		var len=0;
		var fromId;
		var toId;
		for(key in lines){
			if(key != null && (key.indexOf("server") !=-1 ||key.indexOf("switch") !=-1 ||key.indexOf("device") !=-1)){
				if(len == 0){
					fromId = key;
				}
				if(len == 1){
					toId =key;
				}
				len++;
				//alert(key+"  createLine:"+len+"    fromId:"+fromId+"    toId:"+toId);
			}
		}
		if(fromId !="" && toId!=""){
			var	fromX = lines[fromId].x;
			var fromY = lines[fromId].y;
			var fromWidth = lines[fromId].width;
			var fromHeight = lines[fromId].height;
			
			var	toX = lines[toId].x;
			var toY = lines[toId].y;
			var toWidth = lines[toId].width;
			var toHeight = lines[toId].height;
			//alert(fromX+"--"+fromY+"--"+fromWidth+"--"+fromHeight+"-2222-"+toX+"--"+toY+"--"+toWidth+"--"+toHeight);
			
			var lineDirection = $("#lineDirection").val();
			var srcNodeGroupId = $("#srcNodeGroupId").val();
			var descNodeGroupId = $("#descNodeGroupId").val(); 
			var lineOffset = $("#lineOffset").val() == ""?0:Number($("#lineOffset").val()); 
			var lineDirection = $("#lineDirection").val(); 
			var lineNumber = $("#lineNumber").val(); 
			var srcLinePostion = $("#srcLinePostion").val(); 
			var descLinePostion = $("#descLinePostion").val();
			//alert(lineDirection+"---"+(lineDirection==1?"":"_xh"));
			var lineItem = new Array();
			if(lineNumber == 3){//需要三条线的画线逻辑
			
			}else{//自动算取线条
				if(fromX > toX){
					//alert((fromY - toY)+"---"+toHeight/2+"----"+(fromX - toX)+"---"+toWidth/2);
					if((((fromY - toY)>0?(fromY - toY):-(fromY - toY)) >toHeight/2)){
						if(((fromX - toX)>0?(fromX - toX):-(fromX - toX)) > toWidth/2){
							if(fromY > toY){//第二象限
								var arrowLine1 = raphael.rect((fromX+fromWidth/2)+lineOffset,(toY+toHeight/2),4,(fromY-toY-toHeight/2)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								var arrowLine2 = raphael.rect((toX+toWidth),(toY+toHeight/2),(fromX-toX-toWidth+fromWidth/2)+lineOffset,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								lineItem.push(arrowLine1);
								lineItem.push(arrowLine2);
							}else if(fromY < toY){//第三象限
								var arrowLine1 = raphael.rect(fromX+fromWidth/2+lineOffset,fromY+fromHeight,4,(toY-fromY-fromHeight+toHeight/2)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+".gif)"});
								var arrowLine2 =raphael.rect(toX+toWidth,toY+toHeight/2,(fromX-toX-toWidth+fromWidth/2+4)+lineOffset,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								lineItem.push(arrowLine1);
								lineItem.push(arrowLine2);
							}else{
								var arrowLine = raphael.rect((toX+toWidth),(toY+toHeight/2),(fromX-toX-toWidth),4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								lineItem.push(arrowLine);
							}
						}else{
							var arrowLine = raphael.rect(fromY>toY?(toX+(toWidth-(fromX - toX))/2):(fromX+(fromWidth-(fromX - toX))/2),fromY>toY?toY+toHeight:fromY+fromHeight,4,(fromY>toY?fromY-toY-toHeight:toY-fromY-fromHeight)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: fromY>toY?"url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+"_f.gif)":"url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+".gif)"});
							lineItem.push(arrowLine);
						}
					}else{
						var arrowLine = raphael.rect((toX+toWidth),(toY+(toHeight-(toY-fromY))/2),(fromX-toX-toWidth),4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+"_f.gif)"});
						lineItem.push(arrowLine);
					}
				}else{
				  //alert((fromY - toY)+"---"+toHeight/2+"----"+(fromX - toX)+"---"+toWidth/2);
					if((((fromY - toY)>0?(fromY - toY):-(fromY - toY)) >toHeight/2)){
						if(((fromX - toX)>0?(fromX - toX):-(fromX - toX)) > toWidth/2){
							if(fromY > toY){//第一象限
								var arrowLine1 = raphael.rect((fromX+fromWidth/2)+lineOffset,(toY+toHeight/2),4,(fromY-toY-toHeight/2)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								var arrowLine2 = raphael.rect((fromX+fromWidth/2)+lineOffset,(toY+toHeight/2),(toX-fromX-fromWidth/2)-lineOffset,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+".gif)"});
								lineItem.push(arrowLine1);
								lineItem.push(arrowLine2);
							}else if(fromY < toY){//第四象限
								var arrowLine1 = raphael.rect((fromX+toWidth/2)+lineOffset,(fromY+fromHeight),4,(toY-fromY-fromHeight+toHeight/2)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+".gif)"});
								var arrowLine2 = raphael.rect((fromX+toWidth/2)+lineOffset,(toY+toHeight/2),(toX-fromX-fromWidth/2)-lineOffset,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+".gif)"});
								lineItem.push(arrowLine1);
								lineItem.push(arrowLine2);
							}else{
								var arrowLine = raphael.rect((fromX+fromWidth),(fromY+fromHeight/2),(toX-fromX-fromWidth),4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+"_f.gif)"});
								lineItem.push(arrowLine);
							}
						}else{
							var arrowLine = raphael.rect(fromY>toY?(toX+(toWidth-(toX-fromX))/2):(fromX+(fromWidth-(toX - fromX ))/2),(fromY>toY?toY+toHeight:fromY+fromHeight),4,(fromY>toY?fromY-toY-toHeight:toY-fromY-fromHeight)).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: fromY>toY?"url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+"_f.gif)":"url(images/toposvg/arrow-green_v"+(lineDirection==1?"":"_xh")+".gif)"});
							lineItem.push(arrowLine);
						}
					}else{
						var arrowLine = raphael.rect((fromX+fromWidth),(fromY+(fromHeight-(fromY-toY))/2),(toX-fromX-fromWidth),4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h"+(lineDirection==1?"":"_xh")+".gif)"});
						lineItem.push(arrowLine);
					}
				}
				
				nodegroupArrowPositions[srcNodeGroupId+","+descNodeGroupId] = lineItem;
			}
			//设置背景图片位置信息，每次连线涉及到2个背景图片及源节点组与目的节点组
			nodegroupBgImgPositions[srcNodeGroupId] = images[fromId];
			nodegroupBgImgPositions[descNodeGroupId] = images[toId];
			//设置灯泡位置信息，每个背景图片对应一个灯泡,后台自动算取位置信息
			lines = new Array();
		}
		
	}
	
	function saveTopoConfig(){
		var bgImgInfos="";
		for(key in nodegroupBgImgPositions){
			if(typeof(nodegroupBgImgPositions[key]) == "object"){
				//alert(key+"--"+nodegroupBgImgPositions[key].src+"   "+nodegroupBgImgPositions[key].x+"   "+nodegroupBgImgPositions[key].y+"   "+nodegroupBgImgPositions[key].width+"   "+nodegroupBgImgPositions[key].height);
				bgImgInfos+=":"+key+","+nodegroupBgImgPositions[key].src+","+nodegroupBgImgPositions[key].x+","+nodegroupBgImgPositions[key].y+","+nodegroupBgImgPositions[key].width+","+nodegroupBgImgPositions[key].height;
			}
		}
		if(bgImgInfos!=""){
			bgImgInfos = bgImgInfos.substring(1);
		}
		//alert("--bgImgInfos--"+bgImgInfos);
		var arrowInfos = "";
		for(key in nodegroupArrowPositions){
			if(typeof(nodegroupArrowPositions[key]) == "object"){
				//alert(key+"--"+nodegroupBgImgPositions[key].src+"   "+nodegroupBgImgPositions[key].x+"   "+nodegroupBgImgPositions[key].y+"   "+nodegroupBgImgPositions[key].width+"   "+nodegroupBgImgPositions[key].height);
				var lineInfos = "";
				for(key1 in nodegroupArrowPositions[key]){
					if(typeof(nodegroupArrowPositions[key][key1]) == "object"){
						lineInfos+=";"+key+","+Math.floor(nodegroupArrowPositions[key][key1].attr("x"))+","+Math.floor(nodegroupArrowPositions[key][key1].attr("y"))+","+Math.floor(nodegroupArrowPositions[key][key1].attr("width"))+","+Math.floor(nodegroupArrowPositions[key][key1].attr("height"))+","+nodegroupArrowPositions[key][key1].attr("fill");
					}
				}
				if(lineInfos !=""){
					arrowInfos+=":"+lineInfos.substring(1);
				}
			}
		}
		
		if(arrowInfos!=""){
			arrowInfos = arrowInfos.substring(1);
		}
		//alert("--arrowInfos--"+arrowInfos);
		window.location="<c:url value='/nodePosition/nodeGroupPosition.do?action=saveConfigTopo&nodegroupBgImgPositions="+bgImgInfos+"&nodegroupArrowPositions="+arrowInfos+"'/>";
	}
	
	
	function clearConfig(){
		$("#srcNodeGroup").val("");
		$("#srcNodeGroupId").val("");
		$("#descNodeGroup").val("");
		$("#descNodeGroupId").val(""); 
		$("#lineOffset").val(""); 
		$("#lineDirection").val(""); 
		$("#lineNumber").val(""); 
		$("#srcLinePostion").val(""); 
		$("#descLinePostion").val("");
		$("#srcTR").hide();
		$("#descTR").hide();
	}
	
	
	//选择源节点组
	function selectNodeAndNodeGroup() {
		var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		if(nodeLock == 1){
			alert("i18n_ct.message.nodeLock_n81i");
			return ;
		}
		//var groupId = $("#nodeGroupId").val();//选中节点组
		//var nodeId = $("#nodeId").val();;//选中ip	
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup"; //转向网页的地址;
		var name; //网页名称，可为空;
		//改为window.open-20180831-chenjs---
		parent.layer.open({
			type: 2,
			title: "i18n_tsnang.text.selectNodeGroup_n81i",
			area:['850px', '610px'],
			shade: 0.6,
			closeBtn: 1,
			maxmin:true,
			content: url
		});
		
		top.$("#ly").css("display", "block");
		top.$("#ly").width(parent.document.body.clientWidth);
		top.$("#ly").height(parent.document.body.clientHeight);
	}
	
	function reciveNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps){
		//alert(nodeGroupIds+" " +nodeGroupNames+" "+nodeIds+" "+nodeIps);
		document.getElementById("srcNodeGroup").value = nodeGroupNames;//节点组名称
		document.getElementById("srcNodeGroupId").value = nodeGroupIds;//节点组id
		document.getElementById("nodeIpShow").value = nodeIps;//节点ip
		document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
			
	}
	
	//选择目标节点组
	function selectNodeAndNodeGroup1() {
		var nodeLock = '${nodeLock eq null ? -1 : nodeLock }';
		if(nodeLock == 1){
			alert("i18n_ct.message.nodeLock_n81i");
			return ;
		}
		//var groupId = $("#nodeGroupId").val();//选中节点组
		//var nodeId = $("#nodeId").val();;//选中ip	
		//var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&groupId="+groupId+"&nodeId="+nodeId+"&type=descgroup"; //type=1代表查询目标节点组
		var url = "<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=toSelectNodeAndNodeGroup&type=descgroup";
		var name; //网页名称，可为空;
		//改为window.open-20180831-chenjs---
		parent.layer.open({
			type: 2,
			title: "i18n_tsnang.text.selectNodeGroup_n81i",
			area:['850px', '610px'],
			shade: 0.6,
			closeBtn: 1,
			maxmin:true,
			content: url
		});
	}
	
	function reciveNodeAndNodeGroup1(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps){
		//alert(nodeGroupIds+" " +nodeGroupNames+" "+nodeIds+" "+nodeIps);
		document.getElementById("descNodeGroup").value = nodeGroupNames;//节点组名称
		document.getElementById("descNodeGroupId").value = nodeGroupIds;//节点组id
		document.getElementById("nodeIpShow").value = nodeIps;//节点ip
		document.getElementById("nodeIp").value = nodeIds;//节点ids:nodeIds为选中的节点的id（用逗号连接的）
			
	}
	
	function showLinePosition(){
		var lineNum = $("#lineNumber").val();
		if(lineNum == 3){
			$("#srcTR").show();
			$("#descTR").show();
		}else{
			$("#srcTR").hide();
			$("#descTR").hide();
		}
	}
</script>

	</head>

	<body>
		<div id="mainDiv"
			style="width: 100%; height: 100%; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
		</div>
		<input type="hidden" name="nodeIpShow" id="nodeIpShow" />
		<input type="hidden" name="nodeIpsId" id="nodeIp" />
		<input type="hidden" id="fw" value="addNewTask"/>
		<div id="doConfig" closed="true">
			<table border="0" cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td class="color_1" align="right" width="30%">
						i18n_ct.text.srcNodeGroup_n81i：
					</td>
					<td class="color_3" align="left" width="70%">
						<input type="text" name="srcNodeGroup" id="srcNodeGroup"
							readonly="readonly" value="" />
						&nbsp;
						<input type="hidden" name="srcNodeGroupId" id="srcNodeGroupId"
							value="" />
						&nbsp;
						<input type="button" value="i18n_ct.button.select_n81i" onclick="selectNodeAndNodeGroup()"
							class=btn3_mouseout onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_ct.text.descNodeGroup_n81i：
					</td>
					<td class="color_3" align="left">
						<input type="text" name="descNodeGroup" id="descNodeGroup"
							readonly="readonly" value="" />
						&nbsp;
						<input type="hidden" name="descNodeGroupId" id="descNodeGroupId"
							value="" />
						&nbsp;
						<input type="button" value="i18n_ct.button.select_n81i" onclick="selectNodeAndNodeGroup1()"
							class=btn3_mouseout onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_ct.text.lineOffset_n81i：
					</td>
					<td class="color_3" align="left">
						<input type="text" name="lineOffset" id="lineOffset"/>
					</td>
				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_ct.text.lineDirection_n81i：
					</td>
					<td class="color_3" align="left">
						<select name="lineDirection" id="lineDirection"
							style="width: 150px;">
							<option value="">
								i18n_ct.message.lineDirectionDefault_n81i
							<option value="1">
								i18n_ct.message.lineDirection1_n81i
							<option value="2">
								i18n_ct.message.lineDirection2_n81i
						</select>
						<font color="red">*</font>
					</td>

				</tr>
				<tr>
					<td class="color_1" align="right">
						i18n_ct.text.lineNumber_n81i：
					</td>
					<td class="color_3" align="left">
						<select name="lineNumber" id="lineNumber" style="width: 150px;" onchange="showLinePosition()">
							<option value="">
								i18n_ct.message.lineNumberDefault_n81i
							<option value="3">
								3
						</select>
					</td>
				</tr>
				<tr id="srcTR" style="display:none;">
					<td class="color_1" align="right">
						i18n_ct.text.srcLinePostion_n81i：
					</td>
					<td class="color_3" align="left">
						<select name="srcLinePostion" id="srcLinePostion"
							style="width: 150px;">
							<option value="">
								i18n_ct.message.srcLinePostionDefault_n81i
							<option value="up">
								i18n_ct.message.srcLinePostionUp_n81i
							<option value="down">
								i18n_ct.message.srcLinePostionDown_n81i
							<option value="left">
								i18n_ct.message.srcLinePostionLeft_n81i
							<option value="right">
								i18n_ct.message.srcLinePostionRight_n81i
						</select>
						<font color="red">*</font>
					</td>

				</tr>
				<tr id="descTR" style="display:none;">
					<td class="color_1" align="right">
						i18n_ct.text.descLinePostion_n81i：
					</td>
					<td class="color_3" align="left">
						<select name="descLinePostion" id="descLinePostion"
							style="width: 150px;">
							<option value="">
								i18n_ct.message.descLinePostionDefault_n81i
							<option value="up">
								i18n_ct.message.descLinePostionUp_n81i
							<option value="down">
								i18n_ct.message.descLinePostionDown_n81i
							<option value="left">
								i18n_ct.message.descLinePostionLeft_n81i
							<option value="right">
								i18n_ct.message.descLinePostionRight_n81i
						</select>
						<font color="red">*</font>
					</td>
				</tr>

				<tr>
					<td align="center" colspan="2">
						<input type="button" value="i18n_ct.button.ok_n81i" id="confirm" />
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
