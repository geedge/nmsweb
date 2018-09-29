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
		<title>i18n_snr.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/layer.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/raphael.js'/>"></script>
		<link rel="stylesheet"
			href="<c:url value='/js/jquery-easyui-1.1.2/themes/default/easyui.css'/>"
			type="text/css"></link>
		<script type="text/javascript"
			src="<c:url value='/js/jquery-easyui-1.1.2/jquery.easyui.min.js' />"></script>
		<style>
body {
	background-image: url("${pageContext.request.contextPath}/images/show/bg.jpg");
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

		<script type="text/javascript">
		var raphael;
		var nodes = new Array();
		var roomStartX =100;
		var roomStartY = 30;
		var roomTitleHeight = 30;
		var roomTitleGap = 15;
		var allY = 0;
		var gap = 10;//同一机房的X,Y间距
		var roomGap = 50;//机房Y轴的间距
		var roomWidth=100;
		var roomHeight=200;
		
		var minboxLeft = 50;
		var minboxWidth=140;
		var minboxHeight=200;
		
		var boxWidth=206;
		var boxHeight=540;
		
		var titleImg = "${pageContext.request.contextPath}/images/topo3d/grayline.jpg";
		var boxTopImg = "${pageContext.request.contextPath}/images/topo3d/box_top.png";
		var boxFootImg = "${pageContext.request.contextPath}/images/topo3d/box_foot.png";
		var boxLeftImg = "${pageContext.request.contextPath}/images/topo3d/box_left.png";
		var boxRightImg = "${pageContext.request.contextPath}/images/topo3d/box_right.png";
		
		var boxImg="${pageContext.request.contextPath}/images/topo3d/box.png";
		var boxErrorImg="${pageContext.request.contextPath}/images/topo3d/boxError.png";
		var rapheals = new Array();
		var raphealsInd = 0;
		var nodeIndexs = new Array();
		
		var idnum =1;
		
		$(function(){
			var height = document.body.clientHeight;
			var width = document.body.clientWidth-100;
			//计算画布高度
			var raphaelHeight = roomGap;
			var raphaelWidth = roomGap;
			var maxRoomClos = 0;
			<c:forEach items="${nodeRoomList}" var="nodeRoom" varStatus="index">
				var ind = ${index.index};
				var roomRows = ${nodeRoom.roomRows};
				var roomBJHeight = (ind+1)*roomTitleHeight+roomTitleGap*2+roomRows*roomHeight+(roomRows-1)*gap;
				raphaelHeight+=roomBJHeight+roomGap;
				
				var roomCols = ${nodeRoom.roomCols};
				maxRoomClos = maxRoomClos >=roomCols?maxRoomClos:roomCols;
			</c:forEach>
			raphaelWidth= 2*roomStartX+maxRoomClos*(roomWidth+gap);
			
			if(height > raphaelHeight){
				raphaelHeight=height;
			}
			if(width > raphaelWidth){
				raphaelWidth=width;
			}
			raphael =  Raphael("canvas",raphaelWidth,raphaelHeight);
			//raphael.rect(0,0,width-100,height).attr({'stroke-width':1,stroke: "#FFFFFF", fill: "#FBFBEA"});
			
			//机柜展示
			$("#nodeBox").dialog({
				title:"i18n_snr.text.nodeBox_n81i",
				resizable:true,
				width:220,
				height:578
			});	
			
			//告警信息列表
			$("#alarmInfo").dialog({
				title:"i18n_snr.text.alarmInfo_n81i",
				resizable:true,
				width:width-120,
				height:height-20
			});
			
			$("#alarmInfo").dialog({
				onClose:function(){
					$("#I3").html("");
					$("#I3").removeAttr("src");
				}
			});
			<c:forEach items="${nodeRoomList}" var="nodeRoom" varStatus="index">
				
				var ind = ${index.index};
				//画机房
		 		var roomRows = ${nodeRoom.roomRows};
		 		var roomCols = ${nodeRoom.roomCols};
		 		
		 		//var roomStartX = (width-(roomRows*roomWidth))/2;
		 		//画整个机房的背景
		 		var roomBJWidth  = roomCols*roomWidth+(roomCols-1)*gap+2*roomTitleGap;
		 		var roomBJHeight = roomTitleHeight+roomTitleGap*2+roomRows*roomHeight+(roomRows-1)*gap;
		 		var roomBJY = allY + roomGap;
		 		allY += roomBJHeight + roomGap;
		 		raphael.rect(roomStartX-roomTitleGap,roomBJY,roomBJWidth,roomBJHeight).attr({stroke: "#000000",'stroke-width':1,title:'${nodeGroup.groupName}', fill: "#FFFFFF"});
		 		
		 		//画title图片
		 		var titleTtext = "i18n_snr.text.titleTtext.nodeGroup_n81i：${nodegroupTable.groupName}  i18n_snr.text.titleTtext.roomId_n81i：${nodeRoom.roomIspn}"
		 		raphael.rect(roomStartX-roomTitleGap,roomBJY,roomBJWidth,roomTitleHeight).attr({stroke: "#CBD1D9",'stroke-width':1,title:titleTtext, fill: "url("+titleImg+")"});
		 		<c:choose>
		 			<c:when test="${session.i18n_lang == 'ru_RU'}">
		 				raphael.text(roomStartX+220,roomBJY+roomTitleGap,titleTtext).attr({'font-size':12,fill:"#000000"});
		 			</c:when>
		 			<c:when test="${session.i18n_lang == 'zh_CN'}">
	 					raphael.text(roomStartX+120,roomBJY+roomTitleGap,titleTtext).attr({'font-size':12,fill:"#000000"});
	 				</c:when>
		 			<c:when test="${session.i18n_lang == 'en_US'}">
	 					raphael.text(roomStartX+150,roomBJY+roomTitleGap,titleTtext).attr({'font-size':12,fill:"#000000"});
	 				</c:when>
		 		</c:choose>
		 		//raphael.text(roomStartX+120,roomBJY+roomTitleGap,titleTtext).attr({'font-size':12,fill:"#000000"});
		 		//该机房的所有机柜信息
		 		var nodeBoxs=$.parseJSON('${nodeRoom.nodeBoxInfo}');
		 		for(var row = 1;row <=roomRows; row++){
		 			for(var col = 1;col <=roomCols; col++){
		 				//机房的位置上是否存在机柜
		 				var position = row+""+col;
		 				var roomColor = "#CCCCCC";
		 				var boxBgImg = boxImg;//机柜背景图片
		 				var boxTitle = "i18n_snr.message.boxTitle1 _n81i";
		 				if(nodeBoxs[position]!=undefined){
		 					roomColor = "#A3C09F";//机柜正常常绿色
		 					if(nodeBoxs[position].alarm){
		 						roomColor = "#E64F42";//机柜异常红色
		 						boxBgImg = boxErrorImg;//机柜背景图片异常
		 						
		 					}
		 					if(nodeBoxs[position].hasNode){
		 						roomColor = "#5589D7";//机柜有该节点组下节点
		 						boxTitle = "i18n_snr.message.boxTitle2_n81i";
		 						if(nodeBoxs[position].alarm){
		 							boxTitle = "i18n_snr.message.boxTitle3_n81i";
		 						}
		 					}
		 					
		 				}
		 				var title=row+"i18n_snr.message.title.row_n81i"+col+"i18n_snr.message.title.column_n81i";
		 				var roomX = roomStartX+(col-1)*(roomWidth+gap);
		 				//画图的Y开始点+每个机房的TitleY+每行的高
		 				var roomY = roomBJY+(roomTitleHeight+roomTitleGap)+(row-1)*(roomHeight+gap);
		 				raphael.rect(roomX,roomY,roomWidth,roomHeight).attr({stroke: "#000000",'stroke-width':1,title:title, fill: roomColor}); 
		 				if(nodeBoxs[position]!=undefined){
		 					//raphael.text(roomX+40,roomY+40,nodeBoxs[position].descinfo).attr({'font-size':12,fill:"#000000"});
		 					var param = "&groupId="+'${nodegroupTable.groupId}'+"&nodeBoxId="+nodeBoxs[position].nodeBoxId+",i18n_snr.message.room_n81i:"+'${nodeRoom.roomIspn}'+" "+title+" i18n_snr.text.nodeBox_n81i:"+nodeBoxs[position].ispn;
		 					var node = raphael.image(boxBgImg,roomX-20,roomY,minboxWidth,minboxHeight).attr({title:boxTitle,text:param});
		 					node.id = idnum;
		 					$("body").append("<input type='hidden' id="+idnum+" value=''>");
   							$("input[id="+idnum+"]").val(param);
   							idnum++;
		 					node.click(function(){
		 					//	var param = this.attr("text");
			 					var nodeid = this.id;
			 					var selector = "#"+nodeid;
								var param = $(selector).val();		 						
		 						getNodeBox(param);
		 					});
		 				}
		 				//设置行列信息
		 				raphael.text(roomX+50,roomY+50,title).attr({'font-size':12,fill:"#000000"});
		 			}
		 		}
			</c:forEach>
			
			if('${groupId}' != "" &&'${nodeBoxId}'!= "" &&'${nodeBoxIspn}' != ""){
				var param =  "&groupId="+'${groupId}'+"&nodeBoxId="+'${nodeBoxId}'+","+'${nodeBoxIspn}';
				getNodeBox(param);
			}
		})
		
		function getNodeBox(param){
			var params=param.split(",");
			$.ajax({
					type:"post",
					dataType:'json',
					url:"<c:url value='/nodePosition/topoShow.do?action=getNodeBox'/>",
					data:params[0],
					async:true,
					 success:function (data,textStatus){
						 if(textStatus == "success" && (data!= null && data!= "" )){
						 	$("#nodeBoxs").html("");
							 var t =$("#nodeBox").dialog("options").title;
						 	$("#nodeBox").dialog("setTitle", params[1]);
						 	$("#nodeBox").dialog("open"); 
						 	
						 	var length = $(data).length;
						 	var raphaelBox = Raphael("nodeBoxs",boxWidth,boxHeight);
						 	//raphaelBox.rect(0,0,boxWidth,boxHeight).attr({'stroke-width':1,stroke: "#FFFFFF", fill: "#FBFBEA"});
						 	//边框设置
						 	var subBoxStartX=20;
						 	var subBoxStartY=10;
						 	var footHeight = 30;
						 	var subBoxGap = 3;
						 	raphaelBox.image(boxTopImg,0,0,204,subBoxStartY);
						 	raphaelBox.image(boxLeftImg,0,subBoxStartY,subBoxStartX,boxHeight);
						 	raphaelBox.image(boxRightImg,boxWidth-20,subBoxStartY,subBoxStartX,boxHeight);
						 	raphaelBox.image(boxFootImg,0,boxHeight-footHeight,204,footHeight);
						 	//每个子U为的大小设置
						 	var subHeight = (boxHeight-subBoxStartY-footHeight)/length-subBoxGap;
						 	var subWidth = boxWidth - 2*subBoxStartX;
						 	var index=-1;//控制占多个U位的处理；
						 	var nodeIndex=0;//在机柜展示中显示节点机所在的序号
						 	$(data).each(function(i,item){
						 		if(index >= i){
						 			return true;
						 		}
						 		//item.nodeposition
						 		var subBoxY = subBoxStartY+i*(subHeight+subBoxGap);
						 		var newHeight = subHeight;
						 		if(item.nodeSeqId != "0" && item.nodeTable != null){
						 			
						 			var title="";//设置节点的提升信息
						 			var param="";//设置单击事件的传参
						 			if(item.nodeTable != null){
						 				title = "i18n_snr.message.nodeTableTitle.nodeIp_n81i："+item.nodeTable.nodeIp+"\ni18n_snr.message.nodeTableTitle.nodeName_n81i："+item.nodeTable.nodeName
						 						+"\ni18n_snr.message.nodeTableTitle.nodeU_n81i："+item.nodeTable.nodeUType+"\ni18n_snr.message.nodeTableTitle.startU_n81i："+item.nodeTable.nodeBeginUType;
						 				param = "&seqList="+item.nodeTable.seqId;
						 				
						 				//占多个U位的处理
						 				var UNum = Number(item.nodeTable.nodeUType);
						 				if( UNum>1){
						 					newHeight = UNum*subHeight+(UNum-1)*subBoxGap;
						 					index = i+UNum-1;
						 				}
						 			}
						 			//alert(item.nodeTable.nodeName+"------"+item.groupNode+"---"+item.nodeTable.alarm);
						 			var subColor="#80B167";//绿色
						 			//是本节点组的显示（红色or绿色） 非本节点组显示灰色
						 			if(item.groupNode){
						 				if(item.nodeTable.alarm){//节点如果异常则显示红色
						 					subColor="#FF0000";
						 				}
						 			}else{
						 				subColor="#939393";//灰色
						 			}
						 			
						 			//只有告警节点才可以单击显示告警信息
						 			if(item.groupNode &&item.nodeTable.alarm){
						 			//节点如果异常则显示红色
						 				var node = raphaelBox.rect(subBoxStartX,subBoxY,subWidth,newHeight).attr({stroke: "#CEDBEF",'stroke-width':0.1,title:title,text:param, fill: subColor});
						 				node.id = "u"+i;
						 				$("#nodeBoxs").append("<input type='hidden' id="+node.id+" value=''>");
						 				$("input[id="+node.id+"]").val(param);
								 			node.click(function(){
							   				//	var param = this.attr("text");
							   					var selector= "#"+this.id;
							   					var param = $(selector).val();
							   					var nodeip = item.nodeTable.nodeIp;
							   					var nodeType = item.nodeTable.nodeType;
							   					getAlarmInfo(param,nodeip,nodeType);
											}).mouseover(function(){
												this.animate({"stroke-width":2},100);
											}).mouseout(function(){
												this.animate({"stroke-width":0.1},100);
											});
						 			}else{
						 				raphaelBox.rect(subBoxStartX,subBoxY,subWidth,newHeight).attr({stroke: "#CEDBEF",'stroke-width':0.1,title:title,text:param, fill: subColor})
								 			.mouseover(function(){
												this.animate({"stroke-width":2},100);
											}).mouseout(function(){
												this.animate({"stroke-width":0.1},100);
											});
						 			}
						 			
						 			//写节点机在机柜中的序号,放入数组中
						 			if(item.groupNode){
						 				nodeIndex++;
						 				nodeIndexs[nodeIndex]={"x":subBoxStartX-5,"y":subBoxY+5};
						 			}
						 			console.log("rephaelBox:"+raphaelBox);
						 		}else{
						 			var title="i18n_snr.message.UBit_n81i"+item.nodeposition;
						 			raphaelBox.rect(subBoxStartX,subBoxY,subWidth,newHeight).attr({stroke: "#CEDBEF",'stroke-width':0.1,title:title, fill: "#ffffff"})
						 			.mouseover(function(){
										this.animate({"stroke-width":2},100);
									}).mouseout(function(){
										this.animate({"stroke-width":0.1},100);
									});
						 		}
						 	});
						 	
						 	//写节点机在机柜中的序号
						 	var nodeShowInd = 0;
						 	for(var i = 1;i<=nodeIndex;i++){
						 		if(nodeIndexs[i] != null &&nodeIndexs[i] != ""){
						 			nodeShowInd++;
						 			raphaelBox.text(nodeIndexs[i].x,nodeIndexs[i].y,nodeShowInd).attr({'font-size':12,fill:"#000000"});
						 		}
						 	}
						 }
					}
				})
		}
		
		
		function getAlarmInfo(param,nodeip,nodeType){
			if(nodeType== 0){
				var url ="<c:url value='/detection/detectionWarning.do?action=query&ip="+nodeip+"&levelAlarm=1"+param+"+&type=3Droom'/>";
			}else if(nodeType == 1){
				var url ="<c:url value='/detection/detectionWarning.do?action=queryNE&ip="+nodeip+"&levelAlarm=1"+param+"+&type=3Droom'/>";
			}
			$("#I3").html("");
			$("#I3").attr("src",url);
			$("#alarmInfo").dialog("open");
		}
		</script>

	</head>

	<body>
		<div
			style="width: 100%; height: 100%; overflow-x: auto; overflow-y: auto;"
			id="canvas"></div>
		<div id="nodeBox" closed="true">
			<div id="nodeBoxs"></div>
		</div>
		<div id="alarmInfo" closed="true">
			<iframe id="I3" name="I3" height="100%" width="100%" border="0"
				style="background: #FFFFFF;" frameborder="0" src="" scrolling="auto">
				i18n_snr.message.frame_n81i
			</iframe>
		</div>
	</body>
</html>
