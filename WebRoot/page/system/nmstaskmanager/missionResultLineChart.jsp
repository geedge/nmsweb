<%@ page language="java" import="java.util.*,java.math.BigInteger,java.text.NumberFormat" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_mrlc.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
		<script type="text/javascript"src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script type="text/javascript" 
			src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/highcharts.js"></script>
		<style>
		.leftArrow {
			border-right: 10px solid #c2c2c2;
			border-top: 10px solid transparent; 
			border-bottom:10px solid transparent;
			width:0;
			height:0;
			z-index:-1;
		}
		.leftArrow:hover {
			border-right: 10px solid red;
			border-top: 10px solid transparent; 
			border-bottom:10px solid transparent;
			width:0;
			height:0;
			cursor: pointer;
		}
		.rightArrow {
			border-left: 10px solid #c2c2c2;
			border-top: 10px solid transparent; 
			border-bottom:10px solid transparent;
			width:0;
			height:0;
		}
		.rightArrow:hover {
			border-left: 10px solid red;
			border-top: 10px solid transparent; 
			border-bottom:10px solid transparent;
			width:0;
			height:0;
			cursor: pointer;
		}
		</style>
		<script type="text/javascript">
			
			var chart;
			var roundArray = null;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						plotBackgroundColor: '#EBECEB',
						borderColor:null,
						margin:[0,0,65,0],
						borderWidth:0,
						borderRadius:0,			//顶角曲度
						defaultSeriesType: 'line'
						
					},
					title: {
						useHTML:true,
						y : 20,
						text: null
						//<div style="background-image:url(/nmsweb/images/button_chaxun.png)" onclick="javascript:msg(1);"> 《</div>
						//text: '<a href="javascript:msg(1);" ><img src="/images/button_chaxun.png" />《</a> ${missionstatetable.missionName }定时任务执行结果趋势图   '
					},
					legend: {
						align: 'center',
						verticalAlign: 'bottom',
						x: 0,
						y: 15,
						floating: true,
						shadow: false
					},
					tooltip: {
						shared: true,
						crosshairs: true,
						borderColor: '#808080',
						formatter: function() {
							var s = '';
							$.each(this.points, function(i, point) {
				                s += '<span style="color:'+point.series.color+'">'+ point.series.name +'</span>: <b>'+ this.y + '</b><br/>';
				             });
							s = $.trim(s) ;
							return s;
						}
					},
					xAxis: {
						title: {
							text: 'i18n_mrlc.text.xAxis_n81i',
							align: 'high',
							style: {
								color: '#808080',
								backgroundColor:'#EBECEB'
							},
							margin:-10
						},
						categories: [<%=request.getAttribute("xValue") %>],
						labels: {
							align:'left',
							x:3,
							y:-3,
							step: 1
						},
						min: 0
					},
					yAxis: {
						allowDecimals : false,
						title: {
							text: null
						},
						plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}],
						labels: {
							align:'left',
							x:3,
							y:-3,
							formatter : function(){
								return Highcharts.numberFormat(this.value,0);
							}
						},
						min: 0,
						showFirstLabel : false
					},
					
					plotOptions: {
						line: {
							allowPointSelect: true,
							cursor: 'pointer',
							lineWidth: 2,
							states: {
								hover: {
									lineWidth: 3
								}
							},
							marker: {
								states: {
									hover: {
										enabled: true,
										symbol: 'circle',
										radius: 5,
										lineWidth: 1
									}
								}	
							},
							point:{
								events:{
									click: function(){
										var roundId = 0;//周期任务id，用于点击折线上的点，进入具体的结果列表
										for(var i  = 0; i<roundArray.length;i++){
											//alert(roundArray[i]);
											if(roundArray[i].length>this.x){
												if(roundArray[i][this.x]!= null){
													roundId = roundArray[i][this.x][1];
													break;
												}
											}
										}
										if(roundId == null){
											return;
										}
										window.parent.document.forms[0].action="<c:url value='/'/>/nmstaskManager/nmsTaskManager!executeAction.do?action=searchResults&missionId=${missionId}&curMissionId="+roundId+"&tabs=2&dataStart="+$("#dataStart").val()+"&dataEnd="+$("#dataEnd").val()+"&dataRange=0";
										window.parent.document.forms[0].submit();
									}
								}
							}
						}
					},
				    series: [
				    	<%
				    		List<Object[]> resultObjects = (List<Object[]>)request.getAttribute("resultObjects"); 
				    		String[][] lines = new String[][]{
					    		{"0","i18n_mrlc.message.success_n81i","#62C462"},
					    		{"1","i18n_mrlc.message.failed_n81i","#EE5F5B"},
					    		{"3","i18n_mrlc.message.underDelivery_n81i","#F8B551"},
					    		{"40","i18n_mrlc.message.deliveredSuccess_n81i","#3399CC"},
					    		{"50","i18n_mrlc.message.processStop_n81i","#13b5b1"},
					    		{"60","i18n_mrlc.message.fileBackup_n81i","#E5B2FF"},
					    		{"70","i18n_mrlc.message.fileUpdate_n81i","#FF9966"},
					    		{"80","i18n_mrlc.message.commandSuccess_n81i","#CCCC33"},
					    		{"81","i18n_mrlc.message.commandFailed_n81i","#FF9999"},
					    		{"5","i18n_mrlc.message.withDraw_n81i","#7ecef4"},
					    		{"6","i18n_mrlc.message.undo_n81i","#844284"},
					    		{"7","i18n_mrlc.message.undoComplete_n81i","#AEAE5F"}
				    		};
				    		StringBuffer roundStrAll = new StringBuffer();
				    		if(resultObjects!=null){
				    			boolean dFlag = false;
				    			for(String[] line: lines){
				    				boolean viewFlag = false;
				    				StringBuffer datas = new StringBuffer();
						    		StringBuffer roundStr = new StringBuffer();
				    				for(Object[] objs:resultObjects){
				    					if(line[0].equals(objs[2].toString())){
				    						viewFlag = true;
				    						datas.append(","+objs[3].toString());
				    						roundStr.append(",["+objs[4].toString()+","+objs[0].toString()+"]");
				    					}else{
				    						//break;
				    					}
				    				}
				    				if(datas.length()>0){
				    					datas.deleteCharAt(0);
				    				}
				    				
				    				if(roundStr.length()>0){
				    					roundStr.deleteCharAt(0);
				    					roundStrAll.append(",["+roundStr+"]");
				    				}
				    				if(viewFlag){
				    					%>
				    					<%=dFlag?",":"" %>
				    					{
				    					name: '<%=line[1] %>',
										color: '<%=line[2] %>',
										data: [<%=datas.toString() %>],
										marker:{
											symbol: 'circle'
										}}
				    					<%
				    					dFlag = true;				    					
				    				}
				    			}
				    		}
				    		if(roundStrAll.length()>0){
				    			roundStrAll.deleteCharAt(0);
				    		}
				    		//System.out.println(roundStrAll);
				    	%>
				
					],
					credits:{
						enabled: false
					}
				});
				roundArray = new Array(<%=roundStrAll %>);//轮次和任务id的对应关系，用于点击折线图进入对应周期的结果列表
				if(${dataStart==1} && ${dataEnd==sumRound}) {//只有一页
					$("#firstTd").hide();
					$("#lastTd").hide();
				}else if(${dataStart==1}&& ${dataEnd!=sumRound} ) {//多页，第一页
					$("#firstTd").hide();
					$("#lastTd").show();
				}else if(${dataEnd==sumRound} && ${dataStart!=1}) {//多页，最后一页
					$("#firstTd").show();
					$("#lastTd").hide();
				}else {
					$("#firstTd").show();
					$("#lastTd").show();
				}
				
			});
			
		  //更新图表数据dataRange:-1代表向前查询周期轮次；1代表向后查询周期轮次
		  function getData(dataRange) {	
			   var categories = [];
			   var dataStartTmp=$("#dataStart").val();
			   var dataEndTmp=$("#dataEnd").val();
			   var dataArr=[];
			   $.ajax({
			   	  url:"<%=path%>/nmstaskManager/nmsTaskManager!getLineByAjax.do?missionId=${missionstatetable.missionId}&dataStart="+dataStartTmp+"&dataEnd="+dataEndTmp+"&dataRange="+dataRange,
				  type : "POST", 
				  dataType : "json",
			      success : function(datas){
						      if(datas!=null){
						      		var dsTmp = datas[0].dataStart;
						      		var deTmp = datas[0].dataEnd;
							      	$("#dataStart").val(dsTmp);
							      	$("#dataEnd").val(deTmp);
							      	var sumRoundTmp = datas[4].sumRound;
							      	if(dsTmp==1 && deTmp==sumRoundTmp) {//只有一页
										$("#firstTd").hide();
										$("#lastTd").hide();
									}else if(dsTmp==1&& deTmp!=sumRoundTmp ) {//多页，第一页
										$("#firstTd").hide();
										$("#lastTd").show();
									}else if(deTmp==sumRoundTmp && dsTmp!=1) {//多页，最后一页
										$("#firstTd").show();
										$("#lastTd").hide();
									}else {
										$("#firstTd").show();
										$("#lastTd").show();
									}
							      	
							      	var xValueTmp = datas[1].xValue;	
							      	if(xValueTmp!=null && xValueTmp!=undefined){
							      		$(xValueTmp).each(function(n,item){
								        	categories.push(item);				
						      			})
						      			chart.xAxis[0].setCategories(categories);//xValue为x轴的周期轮次
							      	}		  
							      	
							      	var linesTmp = datas[2].lines;  
							      	if(linesTmp!=null && linesTmp!=undefined){
								      	for(var i = 0; i<12;i++){
								      		chart.series[0].remove(false);
							      		}
							      	
							      		for(var i = 0; i<linesTmp.length;i++){
							      			var seriesTmp = {
							      				data:[],
							      				marker:{//设置折线图的点都为圆形，如果不设置，则一会圆形，一会三角形，会变化
							      					symbol: 'circle'
							      				}
							      			};
											//alert(i+"=="+linesTmp[i].dataTmp);	
											$(linesTmp[i].dataTmp).each(function(n,item){
									        	//alert(item);	
									        	//dataArr.push(item);	
									        	seriesTmp.data.push(Number(item));//此处不用Number(item),直接用item也可以
									        	//chart.series.data.push(dataArr);		
							      			})							      			
							      			seriesTmp.name = linesTmp[i].nameTmp;							      			
							      			seriesTmp.color = linesTmp[i].colorTmp;								      			
								      	    chart.addSeries(seriesTmp);								      	   
										}
										chart.redraw();//所有操作结束后，再一起重画图
							      	}	  
							      	var roundStrAllTmp = datas[3].roundStrAll;	
							      	roundArray = new Array();	
							      	for(var i = 0; i<roundStrAllTmp.length;i++){
							      		var arr1=[];					      	
								      	$(roundStrAllTmp[i]).each(function(n,item){
								      		arr1.push(item);
								      	})	
								      	roundArray.push(arr1);
							      	}
						      }			      		
			      }
			    });
		  }	
		</script>
	</head>
	<body>
	<form action="" name="form1" method="post" id="form1">
		<input type="hidden" id="dataStart" name="dataStart" value="${dataStart}"/>
		<input type="hidden" id="dataEnd" name="dataEnd" value="${dataEnd}"/>
		<table align="center">
			<tr>
				<td id="firstTd" title="i18n_mrlc.text.firstTd_n81i" style="vi">
				<div class="leftArrow" onclick="javascript:getData(-1);" ></div> 
				</td>
				<td>
				 <font style="color: #000000;font-size: 16px;fill: #3E576F; font-family: '微软雅黑';"> &nbsp;&nbsp; &nbsp;${missionstatetable.missionName }i18n_mrbc.text.resultChart_n81i&nbsp;&nbsp;&nbsp;  </font>
				</td>
				<td id="lastTd" title="i18n_mrlc.text.lastTd_n81i">
				<div class="rightArrow" onclick="javascript:getData(1);"></div> 
				</td>
			</tr>
		</table>
		
		<div id="container" style="width: 100%; height:354px;padding: 0px 0px;background-color: #EBECEB;" >	</div>		
	</form>
	</body>
</html>
