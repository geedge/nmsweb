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
		var imgagePath="${pageContext.request.contextPath}/images/toposvg/";
		var redbulbUrl="${pageContext.request.contextPath}/images/toposvg/alarm.gif";
		var greenbulbUrl="${pageContext.request.contextPath}/images/toposvg/green_bulb.png";
		var lineUrl = "${pageContext.request.contextPath}/images/toposvg/line1.gif";
		var server = "${pageContext.request.contextPath}/images/toposvg/server.png";
		var switchImg = "${pageContext.request.contextPath}/images/toposvg/switch.png";
		var coreswitch = "${pageContext.request.contextPath}/images/toposvg/core_switch.png";
		var device = "${pageContext.request.contextPath}/images/toposvg/device.png";
		var router = "${pageContext.request.contextPath}/images/toposvg/router.png";
		var lightInterview;
		
		var positions = new Array();
		var arrowPosition = new Array();
		var interval;
		
		var boxWidth=206;
		var boxHeight=540;
		
		var titleImg = "${pageContext.request.contextPath}/images/topo3d/grayline.jpg";
		var boxTopImg = "${pageContext.request.contextPath}/images/topo3d/box_top.png";
		var boxFootImg = "${pageContext.request.contextPath}/images/topo3d/box_foot.png";
		var boxLeftImg = "${pageContext.request.contextPath}/images/topo3d/box_left.png";
		var boxRightImg = "${pageContext.request.contextPath}/images/topo3d/box_right.png";
		$(function(){
			var height='${backgroudImg.figureHeight }';
			var width='${backgroudImg.figureWidth }' ;
			raphael =  Raphael("mainDiv", width,height);
			
			//-----------1.画底图
			raphael.rect('${backgroudImg.figureX}','${backgroudImg.figureY}','${backgroudImg.figureWidth}','${backgroudImg.figureHeight}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${backgroudImg.figureFill}'+")"});
			
			//-----------2.画节点组背景图
 		<c:forEach items="${nodegroupBgimgPositionList}" var="position">
				var  img = raphael.rect('${position.figureX}','${position.figureY}','${position.figureWidth}','${position.figureHeight}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position.figureFill}'+")"});
				img.click(function(){
					//跳转到3d机房
					var groupId = '${position.groupId}';
					window.location.href="<c:url value='/nodePosition/topoShow.do?action=show3DRoom&firstGroupId="+groupId+"'/>";
				}).mouseover(function(){
					
					var nodeInfo = "${position.nodeInfo}";
					var clientx =  window.event.clientX;
					var clienty = window.event.clientY;
					//2秒后出发悬浮事件，2面前可以执行单击服务器跳转到3D机房页面
					interval = setInterval(function(){
						showNodeList(nodeInfo,clientx,clienty);
					},2000);
					
				}).mouseout(function(){
					hideMsg();
				});
			</c:forEach>
			//-----------3.画灯泡
			//t.id,t.group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill,t.show_status
			//alert(${fn:length(nodeGroupPositionList)});
			<c:forEach items="${nodeGroupPositionList}" var="position">
				positions['${position[1]}']={"groupId":'${position[1]}'};
				var  bulbImg = raphael.rect('${position[2]}','${position[3]}','${position[4]}','${position[5]}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position[6]}'+")"});
				
				bulbImg.click(function(){
					//获取该节点组的检测信息
					getDetectInfo('${position[1]}','${position[7]}');
				})
				bulbImg.id= "bulb"+'${position[1]}';
			</c:forEach>
			
			//-----------4.画线
			//t.id,t.src_group_id,t.desc_group_id,t.figure_x,t.figure_y,t.figure_width,t.figure_height,t.figure_fill
			<c:forEach items="${nodegroupArrowPositionList}" var="position">
				arrowPosition['${position[0]}']={"id":'${position[0]}'};
				var  arrowImg = raphael.rect('${position[3]}','${position[4]}','${position[5]}','${position[6]}').attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+'${position[7]}'+")"});
				arrowImg.id= "arrow"+'${position[0]}';
			</c:forEach>
			
			//画节点组 测试用
			//drawNodeGroup();
			//画灯 测试用
			//drawBulb();
			//画箭头 测试用
			//drawArrow();
			
			//-----------5.告警节点列表初始化
			$("#nodeList").dialog({
				title:"i18n_st.nodeList.title_n81i",
				resizable:true,
				width:1024,
				height:600
			});	
			
			//-----------6.机柜展示初始化
			$("#nodeBox").dialog({
				title:"i18n_st.nodeBox.title_n81i",
				resizable:true,
				width:220,
				height:578
			});	
		})

		//调整到3D机房的机柜展示页面
		/*function getNodeBox(groupId,nodeBoxId,nodeBoxIspn){
			window.location.href="<c:url value='/nodePosition/topoShow.do?action=show3DRoom&firstGroupId="+groupId+"&nodeBoxId="+nodeBoxId+"&nodeBoxIspn="+nodeBoxIspn+"'/>";
		}
		*/
		
		//悬浮显示机柜,该方法的调用入口在Action拼装nodeInfo中
		function getNodeBox(groupId,nodeBoxId,nodeBoxIspn,nodeIp){
		//alert(groupId+"--"+nodeBoxId+"--"+nodeBoxIspn+"--"+nodeIp);
			$.ajax({
					type:"post",
					dataType:'json',
					url:"<c:url value='/nodePosition/topoShow.do?action=getNodeBox'/>",
					data: "&groupId="+groupId+"&nodeBoxId="+nodeBoxId,
					async:true,
					 success:function (data,textStatus){
						 if(textStatus == "success" && (data!= null && data!= "" )){
						 	$("#nodeBoxs").html("");
							 var t =$("#nodeBox").dialog("options").title;
						 	$("#nodeBox").dialog("setTitle", nodeBoxIspn);
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
						 				title = "i18n_st.text.nodeIp_n81i："+item.nodeTable.nodeIp+"\ni18n_st.text.nodeName_n81i："+item.nodeTable.nodeName
						 						+"\ni18n_st.text.nodeUType_n81i："+item.nodeTable.nodeUType+"\ni18n_st.text.nodeBeginUType_n81i："+item.nodeTable.nodeBeginUType;
						 				param = "&seqList="+item.nodeTable.seqId;
						 				
						 				//占多个U位的处理
						 				var UNum = Number(item.nodeTable.nodeUType);
						 				if( UNum>1){
						 					newHeight = UNum*subHeight+(UNum-1)*subBoxGap;
						 					index = i+UNum-1;
						 				}
						 			}
						 			
						 			var subColor="#80B167";//绿色
						 			//是本节点组且为点击的IP的显示（红色or绿色） 非本节点组显示灰色
						 			//alert(item.nodeTable.nodeIp +"---"+ nodeIp+"==="+(item.nodeTable.nodeIp == nodeIp));
						 			if(item.groupNode && item.nodeTable.nodeIp == nodeIp){
						 				if(item.nodeTable.alarm){//节点如果异常则显示红色
						 					subColor="#FF0000";
						 				}
						 			}else{
						 				subColor="#939393";//灰色
						 			}
						 			//只有告警节点才可以单击显示告警信息
						 			if(item.groupNode &&item.nodeTable.alarm){//节点如果异常则显示红色
						 				raphaelBox.rect(subBoxStartX,subBoxY,subWidth,newHeight).attr({stroke: "#CEDBEF",'stroke-width':0.1,title:title,text:param, fill: subColor})
								 			.click(function(){
							   					var param = this.attr("text");
							   					getAlarmInfo(param);
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
						 			
						 		}else{
						 			var title="i18n_st.text.U_n81i"+item.nodeposition;
						 			raphaelBox.rect(subBoxStartX,subBoxY,subWidth,newHeight).attr({stroke: "#CEDBEF",'stroke-width':0.1,title:title, fill: "#ffffff"})
						 			.mouseover(function(){
										this.animate({"stroke-width":2},100);
									}).mouseout(function(){
										this.animate({"stroke-width":0.1},100);
									});
						 		}
						 	});
						 }
					}
				})
		}
		function getDetectInfo(nodeGroupId,showStatus){
			var url ="<c:url value='/detection/monitorData.do?action=query&requestType=topo&nodeGroupId="+nodeGroupId+"'/>";
			var url2="<c:url value='/detection/monitorData.do?action=queryEmergent&requestType=topo&nodeGroupId="+nodeGroupId+"'/>";
			//异常情况，显示紧急告警列表，否则不显示
			if(showStatus == 1){
				$("#title").show();
				$("#I2").show();
				$("#hr").show();
				$("#I2").attr("src",url2);
			}else{
				$("#title").hide();
				$("#I2").hide();
				$("#hr").hide();
			}
			
			$("#I3").attr("src",url);//由于所有数据列表不会出现隐藏的情况，所以标题的确定就有I3来负责
			//$("#nodeList").dialog("open");//需要关闭，否则会先显示之前打开的节点组，再显示当前节点组
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
		
		
		//画节点组 测试用
		function drawNodeGroup(){
			//服务器 1-8 ,opacity:0.1  server
			raphael.rect(834,30,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(833,148,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(833,284,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(834,400,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(915,476,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(834,522,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(915,596,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(834,648,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			
			//节点 1.1-4
			raphael.rect(578,24,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(580,152,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(580,283,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(580,404,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			
			//节点 2.1-6
			raphael.rect(427,23,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(426,152,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(425,283,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(425,405,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(424,530,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			raphael.rect(425,637,45,62).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+server+")"});
			
			//交换机 1.核心交换机
			raphael.rect(696,282,70,68).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+coreswitch+")"});
			
			//交换机 1.1-5
			raphael.rect(502,34,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(507,161,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(507,293,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(509,415,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(512,643,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			
			//交换机 2.1-3
			raphael.rect(353,35,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(358,225,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			raphael.rect(358,475,50,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+switchImg+")"});
			
			//分流设备 1.1-4
			raphael.rect(293,47,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+device+")"});
			raphael.rect(299,237,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+device+")"});
			raphael.rect(301,487,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+device+")"});
			raphael.rect(296,655,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+device+")"});
			
			//波分路由
			raphael.rect(293,47,29,27).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+device+")"});
			
			
			//波分路由节点组背景图
			raphael.rect(163,85,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+router+")"});
			raphael.rect(163,142,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+router+")"});
			raphael.rect(163,336,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+router+")"});
			raphael.rect(163,390,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+router+")"});
			raphael.rect(163,582,25,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+router+")"});
			
			
		}
		//画箭头 测试用
		function drawArrow(){
		
			//-----------------------------服务器1.1-8------------------
			//后端服务器-核心交换机
			raphael.rect(734,58,105,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			raphael.rect(734,58,4,230).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			
			
			//日志服务器-核心交换机
			raphael.rect(744,178,95,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			raphael.rect(744,178,4,115).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			//日志服务器-光纤交换机
			raphael.rect(878,178,36,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//087交换机-核心交换机
			raphael.rect(754,264,164,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			raphael.rect(754,264,4,34).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			
			
			//邮件服务器-核心交换机
			raphael.rect(758,312,80,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//087系统-核心交换机
			raphael.rect(754,332,4,100).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(754,428,86,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//087系统-光纤交换机1-3
			raphael.rect(877,428,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//界面服务器-核心交换机
			raphael.rect(746,337,4,164).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(746,497,174,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//分中心-核心交换机
			raphael.rect(738,341,4,215).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(738,552,102,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//省平台后端服务器-核心交换机
			raphael.rect(728,344,4,280).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(730,620,194,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			//黑盒服务器-核心交换机
			raphael.rect(718,341,4,337).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(718,674,120,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//黑盒服务器-省平台用户接入交换机
			raphael.rect(876,674,42,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			
			
			
			//-----------------------------交换机1.1-5------------------
			//电信汇接交换机-核心交换机
			raphael.rect(720,95,4,195).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			raphael.rect(536,95,188,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			raphael.rect(536,75,4,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			
			//电信汇接交换机-电信一级节点
			raphael.rect(472,58,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//电信汇接交换机-电信二级节点
			raphael.rect(550,58,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//电信汇接交换机-电信侧封堵路由
			raphael.rect(516,75,4,24).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			raphael.rect(186,95,330,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
			
			
			
			//移动汇接交换机-核心交换机
			raphael.rect(710,230,4,66).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			raphael.rect(530,230,184,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			raphael.rect(530,206,4,28).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			//移动汇接交换机-移动一级节点
			raphael.rect(470,178,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//移动汇接交换机-移动二级节点
			raphael.rect(554,178,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//移动汇接交换机-移动侧封堵路由
			raphael.rect(530,148,4,16).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			raphael.rect(234,148,300,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
			
			//铁通汇接交换机-核心交换机
			raphael.rect(702,264,4,36).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh_f.gif)"});
			raphael.rect(530,264,4,30).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(530,264,176,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			//铁通汇接交换机-铁通一级节点
			raphael.rect(470,308,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//铁通汇接交换机-铁通二级节点
			raphael.rect(554,308,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//铁通汇接交换机-电信侧封堵路由
			raphael.rect(530,338,4,14).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			raphael.rect(190,348,340,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
			
			//联通教育汇接交换机-核心交换机
			raphael.rect(702,334,4,70).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(544,400,4,22).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(544,400,162,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			//联通教育汇接交换机-联通一级节点
			raphael.rect(468,428,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//联通教育汇接交换机-联通教育二级节点
			raphael.rect(556,428,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//联通教育汇接交换机-教育一级节点
			raphael.rect(468,552,56,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			raphael.rect(520,454,4,102).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			//联通教育汇接交换机-联通侧封堵路由
			raphael.rect(520,400,4,22).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			raphael.rect(248,400,276,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			//联通教育汇接交换机-教育侧封堵路由
			raphael.rect(544,454,4,144).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			raphael.rect(190,594,358,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
			
			
			//科技汇接交换机-核心交换机
			raphael.rect(710,338,4,330).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_xh.gif)"});
			raphael.rect(560,668,154,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh_f.gif)"});
			//科技汇接交换机-科技一级节点
			raphael.rect(472,668,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_xh.gif)"});
			//科技汇接交换机-科技侧封堵路由
			raphael.rect(535,688,4,22).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			raphael.rect(190,706,349,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
			
			//-----------------------------交换机2.1-3------------------
			//电信分流交换机-电信一级
			raphael.rect(400,58,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			//电信分流交换机-电信分流D
			raphael.rect(322,58,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			
			//移动铁通分流交换机-移动一级
			raphael.rect(382,178,4,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			raphael.rect(382,178,48,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			
			//移动铁通分流交换机-铁通一级
			raphael.rect(382,308,48,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(382,270,4,42).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			//移动铁通分流交换机-移动铁通分流D
			raphael.rect(328,244,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(328,250,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			
			
			//联通教育分流交换机-联通一级
			raphael.rect(382,428,46,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(382,428,4,48).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			//联通教育分流交换机-教育一级
			raphael.rect(382,552,46,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(382,519,4,38).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			//联通教育分流交换机-联通教育分流D
			raphael.rect(330,494,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(330,500,30,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			
			//科技一级-科技分流D
			raphael.rect(324,668,106,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			//---------------------------分流设备D 1.1-4
			//波分设备（运营商侧）-电信分流D
			raphael.rect(252,58,40,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			//波分设备（运营商侧）-移动铁通分流D
			raphael.rect(242,204,4,40).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			raphael.rect(242,244,58,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			raphael.rect(242,250,58,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(242,250,4,44).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			//波分设备（运营商侧）-联通教育分流D
			raphael.rect(246,494,56,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(246,454,4,40).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v.gif)"});
			
			raphael.rect(246,500,56,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			raphael.rect(246,500,4,40).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_v_f.gif)"});
			//出口-科技分流D
			raphael.rect(114,668,180,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h.gif)"});
			
			//---------------------------波分路由箭头D 1.1-4
			raphael.rect(138,95,25,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			raphael.rect(138,154,25,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			raphael.rect(138,346,25,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			raphael.rect(138,400,25,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			raphael.rect(138,592,25,4).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url(images/toposvg/arrow-green_h_f.gif)"});
			
		}
		
		
		//画灯 测试用	
		function drawBulb(){
			
			//服务器 1-8
			raphael.rect(856,56,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(856,176,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(856,310,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(856,426,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(940,502,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(856,548,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(940,620,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			raphael.rect(856,674,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			
			//节点 1.1-4
			raphael.rect(602,52,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(604,179,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(604,310,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(604,432,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			
			//节点 2.1-6
			raphael.rect(450,50,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(450,179,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(450,310,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(450,432,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(450,558,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(450,664,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			
			//交换机 1.核心交换机
			raphael.rect(728,310,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+redbulbUrl+")"});
			
			//交换机 1.1-5
			raphael.rect(524,48,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(528,176,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(528,308,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(528,430,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(532,660,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			
			//交换机 2.1-3
			
			raphael.rect(374,50,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(376,244,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(378,490,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			
			//分流设备 1.1-4
			raphael.rect(300,45,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(307,235,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(309,485,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(304,653,25,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			
			
			//波分路由灯
			raphael.rect(166,85,29,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(166,142,29,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(166,336,29,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(166,390,29,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
			raphael.rect(166,582,29,25).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+greenbulbUrl+")"});
		}
	
	$(function(){
		//5分钟刷洗一次
		interview = setInterval('refresh()',5*60*1000);
		
		var height =  document.body.clientHeight;
		var width =  document.body.clientWidth;
		//alert(height+"  "+width);
		
	})
	
	function refresh(){
		$.ajax({
			type:"post",
			dataType:'json',
			url:"<c:url value='/nodePosition/nodeGroupPosition.do?action=showTopo'/>",
			data:"&requestType=ajax",
			async:true,
			 success:function (data,textStatus){
				 if(textStatus == "success" && (data!= null && data!= "" )){
				 	var nodeGroupPositionList;
				 	var nodegroupArrowPositionList;
				 	$(data).each(function(i,item){
				 		nodeGroupPositionList = item.nodeGroupPositionList;
				 		nodegroupArrowPositionList = item.nodegroupArrowPositionList;
				 	})
				 	
				 	//更新灯泡
				 	$(nodeGroupPositionList).each(function(i,item){
				 		if(item != null || item != ""){
				 			//如果存在，则替换图片 如果不存在则画图
				 			var bulbId = "bulb"+item[1];
				 			if(positions[item[1]] == null || positions[item[1]] == ""){
				 				//alert("null--->"+i+"   id:"+item[0]);
				 				positions[item[1]]= item[1];
								var  bulbImg = raphael.rect(item[2],item[3],item[4],item[5]).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+item[6]+")"});
								bulbImg.id= bulbId
								
				 			}else{
				 				//alert("exist--->"+i+"  id:"+item[0]);
				 				var bulbImg = raphael.getById(bulbId);
								var fillUrl = imgagePath+item[6];
								bulbImg.attr({fill:"url("+fillUrl+")"});
				 			}
				 		}
				 	})
				 	
				 	//更新箭头
				 	$(nodegroupArrowPositionList).each(function(i,item){
				 		if(item != null || item != ""){
				 			//如果存在，则替换图片 如果不存在则画图
				 			var arrowId = "arrow"+item[0];
				 			if(arrowPosition[item[0]] == null || arrowPosition[item[0]] == ""){
				 				//alert("null--->"+i+"   id:"+item[0]);
				 				positions[item[0]]= item[0];
								var  bulbImg = raphael.rect(item[3],item[4],item[5],item[6]).attr({stroke: "#FFFFFF",'stroke-width':0.1,fill: "url("+imgagePath+item[7]+")"});
								bulbImg.id=arrowId ;
								
				 			}else{
				 				//alert("exist--->"+i+"  id:"+item[0]);
				 				var bulbImg = raphael.getById(arrowId);
								var fillUrl = imgagePath+item[7];
								bulbImg.attr({fill:"url("+fillUrl+")"});
				 			}
				 		}
				 	})
				 	
				 	
				 }
			}
		})
	}
	
	//悬浮显示节点信息
	function showNodeList(nodeInfo,clientx,clienty){  
		if(interval){
			clearInterval(interval);
		}
		var oSon = document.getElementById("hint");  
	 	 with (oSon){  
	      innerHTML = nodeInfo;  
	      style.display = "block";  
		  style.pixelLeft = clientx-5 ;  
	      style.pixelTop = clienty-5;  
     	}  
    } 
		
		function showMsg(){
			 var oSon = document.getElementById("hint");  
			 with (oSon){  
		      style.display = "block";  
	     	}  
		}
		function hideMsg(){
			if(interval){
				clearInterval(interval);
			}
			 var oSon = document.getElementById("hint");  
			 with (oSon){  
		      style.display = "none";  
	     	}  
		}
	</script>
	</head>

	<body>
		<div id="mainDiv"
			style="width: 100%; height: 100%; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
		</div>


		<div id="nodeList" closed="true">
			<!-- 1为禁止查询，2为可以联想查询  此开关同main.jsp-->
			<input type="hidden" id="lianxiangStatus" value="2" />
			<!--<span id="title" class="color_3_tip"
				style="width: 100%;  display: none; text-align: center;"></span>-->
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
		</div>

		<div id="hint" style="display: none;" onmouseout="hideMsg()"
			onmouseover="showMsg()"></div>
		<div id="nodeBox" closed="true">
			<div id="nodeBoxs"></div>
		</div>

	</body>
</html>