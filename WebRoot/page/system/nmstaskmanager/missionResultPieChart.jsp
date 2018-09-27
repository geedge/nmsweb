<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>i18n_mrpc.message.title_n81i</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/highcharts.js'/>"></script>
<style type="text/css">
#leftarea {
	height: 100%; width: 615px; float: left; margin-top: 5px;
}
#rightarea {
	height: 100%; float: left; width: calc(100% - 615px);
}
#container {
	height:365px; width: 605px; margin-left: 10px;
}
#legend {
	margin: 15px 0px 0px 10px;
	text-align:center; height: 200px;
	border: 1px; border-style:solid; border-radius: 5px; border-color: #C8C8C8;
}
#legend div {
	display: inline-block; vertical-align: top; margin-top: 15px; 
}
#legend ul {
	margin: 0px 20px; display: block; cursor:pointer; clear: both;
}
#legend ul li{ 
	float: right; display: block;
}
#legend ul li[id^="button"] {
	width: 12px; height: 12px; padding: 0px; margin-left: 8px;
}
#legend ul[id^="legend"] li font {
	font-size: 12px; vertical-align: top;
}
#table1 {
	height: 570px; margin: 5px 15px 5px 10px; padding: 5px;
	border: 1px; border-style: solid; border-radius: 5px; border-color: #C8C8C8;
}
#table1 ul {
	clear: both; list-style: none;
	margin: 0px; padding: 0px;
}
#table1 ul li {
	height: 30px; margin:2px; width: 50px;
	display: inline-block; cursor: pointer;
	<%-- js重计算width --%>
}
#table2 {
	width: auto;
	position: absolute; display: none; background: #EBECEB;
	border: 1px; border-style: solid; border-radius: 5px; border-color: #9A9A9A;
}
#table2 ul {
	margin: 0px; padding: 1px 3px 1px 8px;
	border-bottom-width: 1px; border-bottom-color: #9A9A9A; border-bottom-style: solid;
}
#table2 ul:last-of-type {
	border-bottom-width: 0px;
}
#table2 li {
	cursor:pointer; font-size: 14px; padding: 5px; border-radius: 5px;
}
.clear {
	clear:both; height: 1px; width: 100%; margin-top: -1px; overflow: hidden;
}
table{
	width: 90%;
	margin: 0 auto;
	text-align: right;
}
</style>
<script type="text/javascript">
	<%-- 
	 * 柱形图数据类型	columnData: [[ 任务状态, 节点数量, 节点百分比 ], ...]
	 *				pieData:	[[ 任务状态, 节点数量, 节点百分比 ], ...]
	 * 节点列表表格数据	tableData:	[[ IP地址, 任务状态, 位置信息], ...]
	 --%>

	 var missionid = ${missionstatetable.missionId}; <%-- 任务ID --%>
	 var currMissionid = new Array();	currMissionid.push(${currMissionId}); <%-- 周期任务最近ID --%>
	
	<%-- 非周期任务执行结果比例/周期任务最近周期执行结果比例 --%>
	var column = ${columnData};
	<%-- 周期任务总体执行结果比例 --%>
	var pie = new Array();	pie.push(${totalData});
	<%-- 任务执行所有节点信息 --%>
	var table = ${tableData};
	
	<%-- 属性配置 --%>
	var confFoldUnit = ${foldUnit}; <%-- 节点叠加单位，默认为5，或通过myconfig.properties文件nmstaskmanager.resultchart.foldunit属性自行配置 --%>

	<%-- 任务结果状态信息 --%>
	var states = {"0": ["i18n_mrlchild.message.success_n81i", "#62C462"], "1": ["i18n_mrlchild.message.failed_n81i", "#EE5F5B"], "3": ["i18n_mrlchild.message.underDelivery_n81i", "#F8B551"],
		"5": ["i18n_mrlchild.message.withDraw_n81i", "#7ECEF4"], "6": ["i18n_mrlchild.message.undo_n81i", "#844284"], "7": ["i18n_mrlchild.message.undoComplete_n81i", "#AEAE5F"], 
		"40": ["i18n_mrlchild.message.deliveredSuccess_n81i", "#3399CC"], "50": ["i18n_mrlchild.message.processStop_n81i", "#13B5B1"], "60": ["i18n_mrlchild.message.fileBackup_n81i", "#E5B2FF"], 
		"70": ["i18n_mrlchild.message.fileUpdate_n81i", "#FF9966"], "80": ["i18n_mrlchild.message.commandSuccess_n81i", "#CCCC33"], "81": ["i18n_mrlchild.message.commandFailed_n81i", "#FF9999"],
		"-1": ["i18n_mrlchild.message.resultState01_n81i", "#FFFFFF"]
	};

	<%-- 属性设置 --%>
	var confPerRowMaxNum = 15;	<%-- 单行最大节点数 15, 单页最大节点数 210 --%>
	var confPerPageMaxNum = 210; <%-- 涉及单元格布局, 自动 --%>
	
	$(function() {
		contentcssStyle();	<%-- 页面样式布局 --%>
		dataprocess();		<%-- 数据处理 --%>
		createColunmChat(); <%-- 柱形图绘制 --%>
		legendEvent(); 		<%-- 绑定表格控制按钮 --%>
		createTable();		<%-- 生成节点显示表格 --%>
	});
	
	Array.prototype.indexof = function(e) {
		for (i = 0; i < this.length; i++) if (this[i] == e) return i; return -1;
	};
	Array.prototype.contains = function(e) {
		return (this.indexof(e) != -1);
	};
	<%-- 柱形图series数据类型 --%>
	function ColDataNode(y, color) {
		this.y = y; this.color = color;
	}
	<%-- 饼图series数据类型 --%>
	function PieDataNode(index, y, color) {
		this.name = index; this.y = y; this.color = color;
	}

	var nodeWidth = 50;	<%-- 储存重新计算后表格单元格宽度 --%>
	var nodeHeight = 30; <%-- 储存重新计算后表格单元格高度 --%>
	
	function contentcssStyle() {
		<%-- IFRAME高度增加  --%>
		var thisHeight = parent.document.body.scrollHeight-100;
		var pw = window.parent;
		if(pw){
			var $thisIframe = $("iframe[name='"+window.frameElement.name+"']:last",pw.document);
			if($thisIframe.parent().css('height')!=(thisHeight+'px')){
				$thisIframe.parent().css('height',thisHeight+'px');
			}
			if($thisIframe.css('height')!=(thisHeight+'px')){
				$thisIframe.css('height',thisHeight+"px");
			}
			pw.document.body.scroll = 'auto';
		}
		<%-- 页面宽度控制，未出现滚动条，与预期不符  --%>
		<%-- 单元格宽度自动计算 --%>
		nodeWidth = ($("#table1").width() - 3 * confPerRowMaxNum - 16) / confPerRowMaxNum + "px";
		<%-- 单元格高度自动计算 --%>
		if(thisHeight < 500){ <%-- 1366 * 768 --%>
			$("#table1 ul li").css("height", "10px");
			nodeHeight = 21;
			$("#container").css("height", "235px");
			$("#table1").css("height", "350px");
		}
		
		<%-- 控制按钮颜色设置  --%>
		$("#legend li[id^='button']").each(function(inx) {
			var result = this.id.substr(6);
			var color = states[result][1];
			if(result != -1){
				$(this).css("background", color);
			} else {
				var currLI = $(this);
				$.each(states, function(key, value){
					var currCOL = $("<span></span>").css({"display":"inline-block"});
					currCOL.css({"height":"100%", "width":"1px", "background": value[1]});
					currLI.append(currCOL);
				});
			}
		});
		<%-- 控制按钮提示信息  --%>
		$("#legend ul").each(function(inx) {
			var result = this.id.substr(6);
			var tipInfo = "i18n_mrlchild.message.rightTree_n81i" + states[result][0] + "i18n_mrlchild.message.rightTree.node_n81i";
			$(this).attr("title", tipInfo);
		});
		<%-- 控制按钮初始选中状态  --%>
		$("#legend ul font").css({"color":"#363636", "font-weight":"100"});
		$("#legend-1 font").css({"color":"#000000", "font-weight":"bold"});
	}
	
	var isCycleFlag = false; <%-- 是否周期任务 --%>
	var isFoldFlag = false;	 <%-- 是否叠加节点 --%>

	var seriesColData = new Array(); <%-- 柱形图Series数据 --%>
	var seriesPieData = new Array(); <%-- 饼图Series数据  --%>
	var selectedTable = new Array(); <%-- 筛选展示节点 --%>
	var stateCountArr = new Array(); <%-- 节点状态统计 --%>

	function dataprocess() {
		<%--  计算获取柱形图Series数据 --%>
		for(var inx=0; inx<column.length; inx++) {
			var y = column[inx][1];
			var color = states[column[inx][0]][1];
			seriesColData.push(new ColDataNode(y, color));
		}
		<%-- 计算获取柱形图Series数据, 限周期任务 --%>
		isCycleFlag = pie.length != 0;
		if(isCycleFlag) {
			pie = pie[0]; <%-- 有效数据提取 --%>
			for(var inx=0; inx < pie.length; inx++) {
				var index = "pie" + inx;
				var y = pie[inx][1];
				var color = states[pie[inx][0]][1];
				seriesPieData.push(new PieDataNode(index, y, color));
			}
		}
		<%-- 节点状态辅助列表 --%>
		var temp = new Array();
		for(var inx = 0; inx < column.length; inx++) {
			temp[inx] = column[inx][0];
		}
		for(proName in states){
			var val = temp.contains(proName) ? proName : -1;
			stateCountArr.push(val);
		}
		<%-- 初始表格显示所有状态 --%>
		selectedTable = table;
	}
	
	function createColunmChat() {
		if(isCycleFlag == false) { <%-- 非周期任务 --%>
			<%-- xAxis.min, xAxis.max, plotOptions.column.pointWidth --%>
			var xAxisData = [[-2.5, 2.5, 33], [-2.5, 3.5, 33], [-2.5, 4.5, 33], [-2.5, 5.5, 32], [-2.5, 6.5, 31],[-2.5, 7.5, 30],
				[-2.5, 8.5, 29], [-2, 9, 28], [-1.5, 9.5, 28], [-1, 10, 28], [-1, 11, 28], [-1, 12, 28]];
			var chart = new Highcharts.Chart({
				chart: {
					renderTo: 'container',
					backgroundColor:'#EBECEB',
					borderWidth: 1, borderColor: "#C8C8C8", borderRadius: 5,
					margin: [30, 20, 3, 20]
				},
				title: {
					text: 'i18n_mrlchild.text.resultChart_n81i',y:15,
					style: {"color":"#000000", "font-family":"'微软雅黑', Arial, '宋体'"}
				},
				xAxis : { 
					labels: { enabled: false}, gridLineColor:'#EBECEB', lineColor:'#EBECEB',
					min: xAxisData[column.length - 1][0], 
					max: xAxisData[column.length - 1][1]
				},
				yAxis : {
					labels:{ enabled: false},title:{ text: null}, gridLineWidth: 0},
				credits:{ enabled: false},
				legend: { enabled: false},
				series: [{
					type:'column',
					data: seriesColData
				}],
				tooltip : { formatter : function() {
					var index = this.x;
					var result = column[index][0];
					return states[result][0] + ": " + this.y + ", " + column[index][2]+"%";
				}},
				plotOptions: { column: {
					allowPointSelect: true, shadow: false, cursor: 'pointer',
					pointWidth: xAxisData[column.length - 1][2],
					point:{ events:{ click: function(){
						var index = this.x;
						var result = column[index][0];
						var actionUrl = "<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
						actionUrl += "&missionId=" + missionid + "&result="+result+"&tabs=1";
						window.parent.document.forms[0].action= actionUrl;
						window.parent.document.forms[0].submit();
					}}}
				}}
			});
		}
		else { <%-- 周期任务 --%>
			<%-- xAxis.min, xAxis.max, plotOptions.column.pointWidth --%>
			var xAxisData = [[-3.8, 2.5, 33], [-3.5, 3.2, 33], [-3.5, 4, 33], [-3, 4.5, 32], [-3, 5.3, 31],[-3, 6, 30],
				[-3, 7, 29], [-3.2, 8, 28], [-3.3, 8.7, 27], [-3.8, 10, 26], [-5, 11, 25], [-5, 12, 25]];
			var chart = new Highcharts.Chart({
				chart: {
					renderTo: 'container',
					backgroundColor:"#EBECEB",
					borderWidth: 1, borderColor: "#C8C8C8", borderRadius: 5,
					margin: [30, 10, 3, 10]
				},
				title: {
					text: 'i18n_mrlchild.text.cycleChart_n81i', x: 60, y:15,
					style: {"color":"#000000", "font-family":"'微软雅黑', Arial, '宋体'"}
				},
				xAxis: {
					labels: { enabled: false}, gridLineColor:'#EBECEB',lineColor:'#EBECEB',
					min: xAxisData[column.length - 1][0], 
					max: xAxisData[column.length - 1][1]
				},
				yAxis: { labels:{ enabled: false}, title:{ text: null}, gridLineWidth: 0},
				credits:{ enabled: false},
				legend: { enabled: false},
				labels: { items: [{ 
					html: 'i18n_mrlchild.text.totalChart_n81i', 
					style: { left: '48px', top: '20px', "color":"#000000", "font-family":"'微软雅黑'", "font-size":"14px"}
				}]},
				series: [
					{
						type:'column', data: seriesColData
					},{
						type: 'pie',
						center: [70, 130], size: 120,
						dataLabels: { enabled : false},
						data: seriesPieData
					}
				],
				tooltip : { formatter : function() {
					if (this.point.name){	<%-- 饼图  --%>
						var index = this.point.name.substr(3); <%-- pie index --%>
						var result = pie[index][0];
						return states[result][0] + ": " + pie[index][1] + ", " + pie[index][2]+"%";
					}else {		<%-- 柱图 --%>
						var index = this.x;
						var result = column[index][0];
						return states[result][0] + ": " + this.y + ", " + column[index][2]+"%";
					}
				}},
				plotOptions: {
					column: {
						allowPointSelect: true, shadow: false, cursor: 'pointer',
						pointWidth: xAxisData[column.length - 1][2],
						point:{ events:{ click: function(){
							var result = column[this.x][0];
							var actionUrl = "<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
							actionUrl += "&missionId=" + missionid + "&curMissionId=" + currMissionid[0] + "&result="+result+"&tabs=1";
							window.parent.document.forms[0].action= actionUrl;
							window.parent.document.forms[0].submit();
						}}}
					},
					pie : {
						allowPointSelect: true, shadow: false, cursor: 'pointer',
						point:{ events:{ click: function(){
							var index = this.name.substr(3); <%-- pie index --%>
							var result = pie[index][0];
							var actionUrl = "<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
							actionUrl += "&missionId=" + missionid + "&result="+result+"&tabs=1";
							window.parent.document.forms[0].action= actionUrl;
							window.parent.document.forms[0].submit();
						}}}
					}
				}
			});
		}
	}

	function legendEvent() {
		$("#legend ul").bind("click", function(event){
			$("#legend ul font").css({"color":"#363636", "font-weight":"100"});
			$("#" + event.currentTarget.id + " font").css({"color":"#000000", "font-weight":"bold"});
			selectedTable = new Array();	<%-- 清空 selectedTable 且不影响table --%>
			var stateId = event.currentTarget.id.substr(6);
			if(stateCountArr.contains(stateId)) {
				if(stateId == -1) {
					selectedTable = table;
				} else {
					for(var inx = 0; inx < table.length; inx++) {
						if(table[inx][1] == stateId) {
							selectedTable.push(table[inx]);
						}
					}
				}
			}
			$("#table1 ul").remove();
			if(selectedTable.length == 0) {
				<%-- alert("无当前任务状态节点信息"); --%>
			} else {
				createTable();
			}
		});
		$("#legend ul").hover(
			function(event){
				$("#" + event.currentTarget.id + " font").css("opacity", "0.8");
			},
			function(event){
			 	$("#" + event.currentTarget.id + " font").css("opacity", "1.0");
			}
		);
	}

	var perNodes = 0;	<%-- 当节点叠加时,储存叠加的节点数目 --%>
	
	function createTable() {
		var totalNum = selectedTable.length;
		isFold = (totalNum <= confPerPageMaxNum) ? false : true;
		<%-- 节点不叠加--%>
		if(isFold == false) {
			for(var rowStInx = 0; rowStInx < totalNum; rowStInx += confPerRowMaxNum) { <%-- 行--%>
				var currUL = $("<ul></ul>").appendTo("#table1");
				var rowEndInx = Math.min(rowStInx + confPerRowMaxNum, totalNum); <%-- 修改--%>
				for(var inx = rowStInx; inx < rowEndInx; inx++) { <%-- 列--%>
					var result = selectedTable[inx][1];
					var addr = selectedTable[inx][2];
					var color = states[result][1];
					var ip = selectedTable[inx][0];
					var info = states[result][0];
					var tipstr = info + ": " + ip + ", " + addr;
					var currLI = $("<li></li>").attr({"id":inx, "title": tipstr}).css({"background":color});
					currLI.css("cursor", "pointer");
					currLI.css("width", nodeWidth).css("height", nodeHeight);
					currUL.append(currLI);
				}
			}
		}
		else{	<%-- 节点叠加--%>
			perNodes = Math.ceil(totalNum / confPerPageMaxNum); <%-- 最少叠加数--%>
			perNodes = Math.ceil(perNodes / confFoldUnit) * confFoldUnit; <%-- 实际叠加数--%>
			var perRowMaxNum = confPerRowMaxNum * perNodes;
			for(var rowStInx = 0; rowStInx < totalNum; rowStInx += perRowMaxNum) {
				var currUL = $("<ul></ul>").appendTo("#table1");
				var rowEndInx = Math.min(rowStInx + perRowMaxNum, totalNum);
				for(var inx = rowStInx; inx < rowEndInx; inx += perNodes) {
					var result = selectedTable[inx][1];
					for(var i = inx + 1; i < Math.min(inx + perNodes, totalNum); i++) {
						if(selectedTable[i][1] != result) {
							result = -1;	break;
						}
					}
					var color = states[result][1];
					var currLI = $("<li></li>").attr({"id":inx});
					if(result == -1){  <%-- 多状态叠加节点，重置背景色 --%>
						multiStateColor(currLI, inx, Math.min(perNodes, rowEndInx - inx));
					}else{
						currLI.css({"background":color});
					}
					currLI.css("width", nodeWidth).css("cursor","default");
					currUL.append(currLI);
				}
			}
		}
		table1Event();	<%-- 表格创建后绑定当前表格响应事件--%>
	}

	<%--// 多状态叠加节点，重置背景色 --%>
	function multiStateColor(currLI, inx, perNodes){
		var multiStates = new Array(); <%--// 结果状态 --%>
		var multiStaNum = new Array(); <%--// 数量，两数组一一对应 --%>
		for(var i = inx; i < inx + perNodes ; i++) {
			var result = selectedTable[i][1];
			var arrInx = multiStates.indexof(result);
			if((arrInx == -1)) {
				multiStates.push(result);
				multiStaNum.push(1);
			} else {
				multiStaNum[arrInx]++;
			}
		}
		var totalWidth = parseFloat(nodeWidth.replace('px', ''));
		totalWidth =(totalWidth - multiStates.length); <%--// 减小1px宽度，避免因浮点数舍入导致内部色块宽度超出节点范围 --%>
		for(var i = 0; i < multiStates.length; i++){
			var color = states[multiStates[i]][1];
			var percent = multiStaNum[i] / perNodes;
			var perwidth = (percent * totalWidth) + "px";
			var span = $("<span></span>").css({"float": "left", "height": "100%", "width":perwidth, "background": color});
			currLI.append(span);
			if(i < multiStates.length - 1) { <%--// 两色块间添加1像素渐变 --%>
				var color2 = states[multiStates[i+1]][1];
				var interval = $("<span></span>").css({"float": "left", "height": "100%", "width":"1px"});
				interval.css("background","-moz-linear-gradient(right," + color + "," + color2 + ")");
				currLI.append(interval);
			}
		}
	}

	var hovertimer = 0;	<%-- 计时器,用于二级表格的隐藏和显示 --%>

	function table1Event() {
		<%-- 鼠标悬停: 节点叠加时显示节点表列--%>
		$("#table1 li").bind("mouseover", function(event) {
			event.stopPropagation();
			$(event.currentTarget).css("opacity", "0.8");
			if (isFold == true) {
				currEvent = event;
				hovertimer = window.setTimeout("showTable2();", 1000); 
			}
		});
		
		$("#table1 li").bind("mouseout", function(event) {
			<%-- 透明度控制 --%>
			$(event.currentTarget).css("opacity", "1.0");
			<%-- 隐藏叠加节点信息 --%>
			if(isFold == true) {
				event.stopPropagation();
				window.clearTimeout(hovertimer);
				$("#table2").css({'display':'none'});
			}
		});
		<%-- 点击：未叠加时进行访问请求,叠加时事件无效--%>
		$("#table1 li").bind("click", function(event){
			if(isFold == false) {
				var inx = event.currentTarget.id;
				var ip = selectedTable[inx][0];
				var result = selectedTable[inx][1];
				var actionUrl = "<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
				if(currMissionid.length == 0){ <%-- 非周期 --%>
					actionUrl += "&missionId=" + missionid + "&ip="+ ip + "&result="+result+"&tabs=1";
				} else {	<%-- 周期 --%>
					actionUrl += "&missionId=" + missionid + "&curMissionId=" + currMissionid[0] + "&ip="+ ip + "&result="+result+"&tabs=1";
				}
				window.parent.document.forms[0].action=actionUrl;
				window.parent.document.forms[0].submit();
			}
		});
	}

	var currEvent = null; <%-- showTable2方法传入参数--%>
	function showTable2(start) {
		if(isFold == true) {  <%-- 节点叠加--%>
			$("#table2").remove(); <%-- 表格重新绘制前清除原有数据--%>
			$("#rightarea").append("<div id='table2'></div>");
			var totalNum = selectedTable.length;
			var start = parseInt(currEvent.currentTarget.id);
			for(var inx = start; inx < Math.min(start + perNodes, totalNum); inx++) {
				var ip = selectedTable[inx][0];
				var result = selectedTable[inx][1];
				var addr = selectedTable[inx][2];
				var color = states[result][1];
				var info = states[result][0];
				var htmlStr = ip + ", " + addr + "";			
				var currLI1 = $("<li></li>").html(htmlStr).css("display", "inline-block").css("font-size", "12px");
				var currLI2 = $("<li></li>").css("display", "inline-block").css({"background":color});
				var currUL = $("<ul></ul>").attr({"id":inx}).append(currLI2).append(currLI1);
				$('#table2').append(currUL);
			}
			<%-- 弹窗定位 --%>
			var x = currEvent.pageX;
			var y = currEvent.pageY;
			var table2Width = $("#table2").width();
			var table2Height = $("#table2").height();
			var table1Height = $("#table1").height() - 10;
			if(table1Height < table2Height){	<%-- 添加竖向滚动条 --%>
				$("#table2").css("overflow-y","auto");
				$("#table2").css("max-height", table1Height + 'px');
				$("#table2").css("width", (table2Width + 20) + 'px');
				table2Height = table1Height;
			}
			var screenWidth = $("body").width();
			var screenHeight = $("body").height();
			if(x + table2Width >= screenWidth){
				x = x - table2Width; <%-- 屏幕右侧弹窗位置调整 --%>
			}
			if(y + table2Height > screenHeight){
				y = screenHeight - table2Height;  <%-- 屏幕底部弹窗位置调整 --%>
			}
			$('#table2').css({'display':'block','left':x,'top':y});
			$("#table2").scrollTop(0);
			table2Event();	<%-- 表格创建后绑定该表格响应事件--%>
		}
	}

	function table2Event() {
		<%-- 点击：进行访问请求--%>
		$("#table2 ul").bind("click", function(event){
			var inx = event.currentTarget.id;
			var ip = selectedTable[inx][0];
			var result = selectedTable[inx][1];
			var actionUrl = "<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults";
			if(currMissionid.length == 0){ <%-- 非周期任务 --%>
				actionUrl += "&missionId=" + missionid + "&ip="+ ip + "&result="+result+"&tabs=1";
			} else {	<%-- 周期 任务 --%>
				actionUrl += "&missionId=" + missionid + "&curMissionId=" + currMissionid[0] + "&ip="+ ip + "&result="+result+"&tabs=1";
			}
			window.parent.document.forms[0].action=actionUrl;
			window.parent.document.forms[0].submit();
		});
		<%-- 鼠标移动至弹出层时保持弹出层显示 --%>
		$("#table2").bind("mouseover", function(event){
			$("#table2").css({'display':'block'});
		});
		$("#table2").bind("mouseout", function(event){
			$("#table2").css({'display':'none'});
		});
		<%-- 透明度控制 --%>
		$("#table2 ul").bind("mouseover", function(event) {
			$(event.currentTarget).css("opacity", "0.8");
		});
		$("#table2 ul").bind("mouseout", function(event) {
			$(event.currentTarget).css("opacity", "1.0");
		});
	}
</script>
</head>
<body>
<div id="nowrapdiv">
	<div id="leftarea"><!-- 左侧区域 -->
		<div id="container"><%-- HighCharts柱形图区域 --%></div>
		<div id="legend"><%-- Legend div Start --%>
			<table>
				<tr>
					<td>
					<div style="">
				<ul id="legend5">
					<li id="button5" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.withDraw_n81i</font></li>
				</ul>
				<ul id="legend6">
					<li id="button6" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.undo_n81i</font></li>
				</ul>
				
				<ul id="legend7">
					<li id="button7" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.undoComplete_n81i</font></li>
				</ul>
			</div>
					</td>
					<td>
						<div style="">
				<ul id="legend60">
					<li id="button60" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.fileBackup_n81i</font></li>
				</ul>
				<ul id="legend70">
					<li id="button70" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.fileUpdate_n81i</font></li>
				</ul>
				<ul id="legend80">
					<li id="button80" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.commandSuccess_n81i</font></li>
				</ul>
				<ul id="legend81">
					<li id="button81" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.commandFailed_n81i</font></li>
				</ul>
			</div>
					</td>
				</tr>
				
				<tr>
					<td>
						<div style="">
				<ul id="legend3">
					<li id="button3" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.underDelivery_n81i</font></li>
				</ul>
				<ul id="legend40">
					<li id="button40" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.deliveredSuccess_n81i</font></li>
				</ul>
				<ul id="legend50">
					<li id="button50" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.processStop_n81i</font></li>
				</ul>
			</div>
					</td>
					<td>
						<div style="">
				<ul id="legend-1">
					<li id="button-1" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.resultState01_n81i</font></li>
				</ul>
				<ul id="legend0">
					<li id="button0" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.success_n81i</font></li>
				</ul>
				<ul id="legend1">
					<li id="button1" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"></li>
					<li><font>i18n_mrlchild.message.failed_n81i</font></li>
				</ul>
			</div>
					</td>
				</tr>
			</table>
			
			
			
			
			<div class="clear"></div>
		<%-- Legend div End --%></div>
	</div>
	<div id="rightarea"><!-- 右侧区域 -->
		<div id="table1"><!-- 动态节点信息表 --></div>
		<div id="table2"><!-- 显示隐藏叠加节点信息 --></div>
	</div>
	<div class="clear"></div>
</div>
</body>
</html>