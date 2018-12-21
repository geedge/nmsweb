<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="nis.nms.bean.SwitchPortInfo"%>
<%@page import="nis.nms.util.MyNumberFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="nis.nms.bean.DiSystem"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Pragma","No-Cache");	
	response.setHeader("Cache-Control","No-Cache");	
	response.setDateHeader("Expires", 0);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="prama" content="no-cache" />
		<meta http-equiv="cache-content" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<title>i18n_sdigp.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"></link>
		<link href="<%=path%>/css/themes/base/jquery.ui.css" rel="stylesheet" type="text/css"></link>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script type="text/javascript" 
			src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/Highcharts-2.2.1/highcharts.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/WebCalendar.js' />"></script>
	</head>
	<script language="javascript" type="text/javascript">
		document.onmousemove = function (a) {//鼠标移动
    	 	if (!a) a = window.event; //移动时创建一个事件
              jQuery("#indexStr2").val(a.clientX+","+a.clientY);
        }
	
	
		
		//每次打开的时候，判断picId是否为空，非空则执行点击事件
		$(function() {		
		
			/*
			   1.第一次进入：只显示系统基础信息
			   2.自动刷新进入时（之前可能点击了系统或者端口）：之前的系统基础信息和端口信息的伸缩状态要保持不变
			   queryParConditionDisplay和queryChildConditionDisplay元素的值变化的时间：点击图片时
			    以下方法不会改变以上两个元素的值
			    
			    如果原来是收缩状态，点击端口和系统时，仍然收缩：这样不对，应该伸开
			*/
			if('${pid}'=='0') {//顶级设备：点击了系统（此时可能有端口信息，可能处于伸开或者收缩状态）--此时端口信息不会有，所以不用管queryChildConditionDisplay的状态
				if('${queryParConditionDisplay}'=='') {//伸开，第一次进入走这
					toClose('queryChildCondition','openAndCloseChildImgSrc');
					//toOpen('queryParCondition','openAndCloseParImgSrc');
					
					document.getElementById("queryChildConditionDisplay").value="none";
					
				}else if('${queryParConditionDisplay}'=='none') {//收缩
					//toClose('queryParCondition','openAndCloseParImgSrc');
					//toOpen('queryChildCondition','openAndCloseChildImgSrc');
					
					//jQuery("#queryChildConditionDisplay").attr('display','');
				}
				
			}else if('${isLeaf}'=='1') {//叶子设备：点击了端口--此时系统信息一定有（伸开或者收缩着）
				if('${queryChildConditionDisplay}'=='') {//点击端口时，如果之前系统信息是打开的，则要关闭系统信息
					toClose('queryParCondition','openAndCloseParImgSrc');
					//toOpen('queryChildCondition','openAndCloseChildImgSrc');
					
					document.getElementById("queryParConditionDisplay").value="none";
				}else if('${queryChildConditionDisplay}'=='none') {
					//toClose('queryChildCondition','openAndCloseChildImgSrc');
					
					if('${queryParConditionDisplay}'=='') {
						//toOpen('queryParCondition','openAndCloseParImgSrc');
					}else if('${queryParConditionDisplay}'=='none') {//收缩
						//toClose('queryParCondition','openAndCloseParImgSrc');
					}
				}
			}
			
			if('${picId}'!='') {//点击端口的折线图后，定时刷新
				jQuery("#${picId}").trigger('click');//
		    }
			
			//刷新时，滚动条的位置不变
			if(${bodyScrollTop!='0'}) {
				document.body.scrollTop = ${bodyScrollTop};
			}
			
			$('<embed src="<%=basePath %>/page/detection"	quality="high" name="powerMap"	pluginspage="http://www.adobe.com/svg/viewer/install"	type="image/svg+xml" width="520" height="100%" wmode="transparent"	style="overflow-y:scroll; "></embed>').appendTo('#player');
			$('#player').html('');
			$('<embed src="<%=basePath %>/page/detection/switchInfo/${svgName}"	quality="high" name="powerMap"	pluginspage="http://www.adobe.com/svg/viewer/install"	type="image/svg+xml" width="520" height="100%" wmode="transparent"	style="overflow-y:scroll; "></embed>').appendTo('#player');
		});	
		
		window.onscroll=function() {
			if(${devScrollHeight=='0'}) {//devScrollHeight可能为98%
				return false;
			}else if(document.body.scrollTop>=${devScrollHeight}){
				return false;
			}
			
			document.getElementById("bodyScrollTop").value = document.body.scrollTop;
			var oip = document.getElementById("oip");
			oip.style.top = document.body.scrollTop +50;
			
			var backBut = document.getElementById("backBut");
			backBut.style.top = document.body.scrollTop +2;
		}
		
		function goBack(){
			//document.location = "<%=path%>/detection/switchDetection.do?action=query";
			document.form3.action ="<%=path%>/detection/switchDetection.do?action=query";
			document.form3.submit();
		}
		
		function detailPortInfo(nameFlag,pid,isLeaf,id) {
		    //只有isLeaf=1的节点才会有连接，有链接的才会执行此方法，所以下面的pid==0 || isLeaf==1条件可以没有，但是为了防止将来的变化，此条件先保留
		    if(pid==0 || isLeaf==1) {//顶级设备+叶子设备
		    	//获取单击端口的坐标
		    	
		    	document.getElementById("picId").value = "";
				document.getElementById("nameFlag").value = nameFlag;
				document.getElementById("pid").value = pid;
				document.getElementById("isLeaf").value = isLeaf;
				//以下两个句的作用？？:点击端口的时候，要打开端口页面，系统信息页面伸缩状态不变（原则是只能打开一个列表，此操作由页面加载的时候完成）
				document.getElementById("queryChildConditionDisplay").value="";
				//document.getElementById("queryParConditionDisplay").value="";
				var url = "<%=path%>/detection/switchDetection.do?action=detailPortInfo&clickPortId="+id;
				document.portForm.action=url;
				document.portForm.submit();
		    }
		}
		
		function autoSubmit() {
			var url="<%=path%>/detection/switchDetection.do?action=switchDetectInfoGraph";
			document.portForm.action=url;
			document.portForm.submit();
		}
		
		setTimeout('autoSubmit();',300000);//300000:5分钟自动提交一次
		
		function hasElem(id) {
			var obj = document.getElementById(id); 	
			if(obj!='undefined' && obj!=null) {
				return true;
			}else {
				return false;
			}
		}
		
		
		function toOpen(conditionId,imgSrcId) {
			var queryCondition = document.getElementById(conditionId); 	
			var openAndCloseImg = document.getElementById(imgSrcId); 	
			if(hasElem(conditionId) && hasElem(imgSrcId)) {
				open(queryCondition,openAndCloseImg); 
			}
		}
		
		function open(queryCondition, img) {
			queryCondition.style.display = "";
			img.src = "<%=basePath %>images/open.gif";			
			return;
		}
		
		function toClose(conditionId,imgSrcId) {
			var queryCondition = document.getElementById(conditionId); 	
			var openAndCloseImg = document.getElementById(imgSrcId); 	
			if(hasElem(conditionId) && hasElem(imgSrcId)) {
				close(queryCondition,openAndCloseImg); 
			}
		}
		
		function close(queryCondition, img) {
			queryCondition.style.display = "none";
			img.src = "<%=basePath %>images/close.gif";
			return;
		}
		
		/*
		    点击图片时的操作：
		    对conditionId进行伸缩，替换imgSrcId图片:
				如果进行的是伸开，则将conditionOtherId收缩，替换imgSrcOtherId图片，
				如果进行的是收缩，则无操作
				
			flagId:本身的伸缩标志，用于定时刷新时，伸缩状态不发生改变
			otherFlagId：另一个的伸缩标志，如果flagId是伸开，则otherFlagId要收缩
		*/
		function toOpenAndFlex(conditionId,imgSrcId,conditionOtherId,imgSrcOtherId,flagId,otherFlagId){
			var queryCondition = document.getElementById(conditionId); 	
			var openAndCloseImg = document.getElementById(imgSrcId); 	
			if(hasElem(conditionId) && hasElem(imgSrcId)) {
				openAndFlex(queryCondition,openAndCloseImg,conditionOtherId,imgSrcOtherId,flagId,otherFlagId); 
			}
		}		
		toOpenAndFlex('queryParCondition','openAndCloseParImgSrc','queryChildCondition','openAndCloseChildImgSrc','queryParConditionDisplay','queryChildConditionDisplay')
		toOpenAndFlex('queryChildCondition','openAndCloseChildImgSrc','queryParCondition','openAndCloseParImgSrc','queryChildConditionDisplay','queryParConditionDisplay')
		/*
		    对queryCondition进行伸缩，替换img图片:
				如果进行的是伸开，则将otherContionId收缩，替换otherImgId图片，
				如果进行的是收缩，则无操作
		*/
		function openAndFlex(queryCondition, img, otherContionId, otherImgId,flagId,otherFlagId) {
			
			//open
			if (queryCondition.style.display == "none") {
				//close other
				var otherContion = document.getElementById(otherContionId); 	
				var otherImg = document.getElementById(otherImgId); 	
				if(hasElem(otherContionId) && hasElem(otherImgId)) {
					document.getElementById(otherFlagId).value="none";
					toClose(otherContionId,otherImgId);
				}
				//折线图宽度问题：占不了100%：点击端口折线图后，查看告警异常信息列表后返回，点击端口信息时
				if('${picId}'!='') {//点击顶级设备时，清空picId，点击叶子设备时清空picId
					jQuery("#tabs-1").html('');//清空加载页面时产生的折线图，因为此折线图显示的样式不对（宽度不为100%），所以此处再次点击，显示的折线图正常
					jQuery("#${picId}").trigger('click');//??
				}
				
				//obj.innerText = "\u6536\u7f29";
				document.getElementById(flagId).value="";
				img.src = "<%=basePath %>images/open.gif";				
				queryCondition.style.display = "";
				
				return;
			}
			//close
			if (queryCondition.style.display == "") {
				//obj.innerText = "打开？";//\u5c55\u5f00
				queryCondition.style.display = "none";
				document.getElementById(flagId).value="none";
				img.src = "<%=basePath %>images/close.gif";
				return;
			}
		}
		
		//查询告警列表
		function toWarningList() {
			var url = "<%=path%>/detection/monitorData.do?action=queryAbnormalSet&entry=switch&cip=${ip}";
			document.portForm.action=url;
			document.portForm.submit();
		}
		
		var chartObj;
		var seriesOptions = [];
		var policeValue;
		var xtilte="";
		var ytitle="";
		
		function qryPic() {
			var queryCondition = document.getElementById("queryChildCondition"); 	
	        if(queryCondition.style.display == ""){
	        var picId = document.getElementById("picIdFlag").value;
	        }
			document.getElementById("picIdFlag").value = picId;
			if(picId!='') {//点击顶级设备时，清空picId，点击叶子设备时清空picId
				jQuery("#"+picId).trigger('click');
			}
		}	
		
	    function qryPicXt() {
	        var queryCondition1 = document.getElementById("queryParCondition"); 	
	        if(queryCondition1.style.display == ""){
	        var picId = document.getElementById("picIdXtFlag").value;
	        }
			document.getElementById("picIdXtFlag").value = picId;
			if(picId!='') {//点击顶级设备时，清空picId，点击叶子设备时清空picId
				jQuery("#"+picId).trigger('click');
			}
		}	
	
	    function getPicScorce(dataType,drwTo,dataDesc,unit,numberFormat,id){
	    	if(unit!='' && unit!=null && unit!=undefined) {
					unit = "("+unit+")";
			}
	    	document.getElementById("picId").value = id;
	    	document.getElementById("picIdFlag").value = id;
	    	var urlTmp = "<%=path%>/detection/switchDetection!getSource.do?dataType="+dataType+"&dataDesc="+dataDesc+"&unit="+unit+"&seqId=${seqId}&detectId=${detectId}&nameFlag=${nameFlag}&ip=${ip}&startTime="+$("#startTime").val();//+"&endTime="+$("#endTime").val();
	    	var urlTmp = encodeURI(urlTmp);
			$.ajax( {
				url : urlTmp,
				type : "POST",
				dataType : "json",
				success : function(datas) {
					if(datas!=null && datas.length>0){
					    document.getElementById("startTime").value = datas[0].startTime;
					}
					if(datas!=null && datas.length>1){
					    //document.getElementById("endTime").value = datas[0].endTime;
					    xtitle = datas[1].xtitle;//折线图标题
						ytitle = datas[1].ytitle;
						policeValue = datas[1].policeVal;
						var lines = datas[1].lines;
						seriesOptions = [];
						if(lines[0].data==null || lines[0].data.length==0){// 针对丢包数，仅显示一条折线
							seriesOptions[0] = {
								name: lines[2].name,
								data: lines[2].data,
								type: 'line'
							};
						} else {// 针对bps\pps，显示一条step线和点
							seriesOptions[0] = {
								name: lines[0].name,
								data: lines[0].data,
								type: 'line',
								step: true,
								color: '#0CF223'
							};
							seriesOptions[1] = {
								name: lines[1].name,
								data: lines[1].data,
								type: 'scatter',
								color : '#0896E9'
							};
						}
						var tab="tabs-1";
						createChart(policeValue,drwTo,numberFormat,unit,tab);
						
					}else{
					$("#tabs-1").empty();
					$("#tabs-1").append('i18n_sdigp.message.noData_n81i');
					}
				}
			})
			 jQuery("#portInfoPic").show();
		}
	  
	    function getPicSystemScorce(dataType,drwTo,dataDesc,unit,numberFormat,id){
	    	if(unit!='' && unit!=null && unit!=undefined) {
					unit = "("+unit+")";
			}
	    	document.getElementById("picId").value = id;
	    	document.getElementById("picIdXtFlag").value = id;
	    	var  urlTmp = "<%=path%>/detection/switchDetection!getSystemSource.do?dataType="+dataType+"&dataDesc="+dataDesc+"&unit="+unit+"&seqId=${seqId}&detectId=${detectId}&nameFlag=${nameFlag}&ip=${ip}&startTimeXt="+$("#startTimeXt").val();//+"&endTime="+$("#endTime").val();
	    	var urlTmp = encodeURI(urlTmp);
			$.ajax( {
				url : urlTmp,
				type : "POST",
				dataType : "json",
				success : function(datas) {
					if(datas!=null && datas.length>0){
					    document.getElementById("startTimeXt").value = datas[0].startTimeXt;
					}
					if(datas!=null && datas.length>1){
					    //document.getElementById("endTime").value = datas[0].endTime;
					    xtitle = datas[1].xtitle;//折线图标题
						ytitle = datas[1].ytitle;
						policeValue = datas[1].policeVal;
						var lines = datas[1].lines;
						seriesOptions = [];
						if(lines[0].data==null || lines[0].data.length==0){// 针对丢包数，仅显示一条折线
							seriesOptions[0] = {
								name: lines[2].name,
								data: lines[2].data,
								type: 'line'
							};
						} else {// 针对bps\pps，显示一条step线和点
							seriesOptions[0] = {
								name: lines[0].name,
								data: lines[0].data,
								type: 'line',
								step: true,
								color: '#0CF223'
							};
							seriesOptions[1] = {
								name: lines[1].name,
								data: lines[1].data,
								type: 'scatter',
								color : '#0896E9'
							};
						}
						var tab="tabs-2";
						createChart(policeValue,drwTo,numberFormat,unit,tab);
					}else{
					$("#tabs-2").empty();
					$("#tabs-2").append('i18n_sdigp.message.noData_n81i');
					}
				}
			})
			 jQuery("#portInfoPicXt").show();
		}
	  
	    Highcharts.setOptions( {
			global : {
				useUTC : false
			}
		});
		function createChart(policeNum,dto,numberFormat,unit,tab) {
		            if(numberFormat==undefined||numberFormat==null) {
		            	numberFormat=0;//数字保留几位小数
		            }
					chartObj = new Highcharts.Chart(//Highcharts.Chart只显示一个图，Highcharts.StockChart显示2个图（一个总图，一个部分图）
					{
						chart : {
							renderTo : tab,//显示折线图的div的id
							zoomType : 'x',//图像可以x轴方向缩放
							resetZoomButton: {
								position: {//resetRoomButton的位置
									align: 'right',
									x: -10,
									//verticalAlign: 'top',
									y: -30
								}
							// relativeTo: 'plot'
						    },
							showAxes : true,
							spacingRight : 20,
							defaultSeriesType : 'line',//显示折线图的样式：area区域显示，line显示线
							borderWidth: 1//整个图的边宽
						},
						navigator: {
							height: 50,
							margin: 50,
			            	outlineColor: '#E0E0E0',
		           			outlineWidth: 2,
		           			xAxis: {
		           				type : 'datetime',
								labels: {
									align: 'left',
									x: 3,
									y: -4
								},
								dateTimeLabelFormats: {
					                second: '%Y-%m-%d %H:%M:%S',
					                minute: '%Y-%m-%d %H:%M',
					                hour: '%Y-%m-%d %H:%M',
					                day: '%Y-%m-%d',
					                week: '%Y-%m-%d',
					                month: '%Y-%m',
					                year: '%Y'
					            }
							}
			            },
			            
						/*rangeSelector: {//右上方选择显示日期范围内的数据
							buttons: [],
							inputEnabled:true,
							inputDateFormat:'%Y-%m-%d'
						},*/
						
						title : {
							text : xtitle//折线图标题
						},
						subtitle : {
							text : ''//这是副标题内容
						},
						xAxis : {
							type : 'datetime',
							//maxZoom : 1000 * 60 * 60 * 24 *14,
							//startOfWeek: 50,
							labels : {
								rotation : 20,
								y : 20,
								x : 20
							},
							dateTimeLabelFormats: {
				                second: '%Y-%m-%d %H:%M:%S',
				                minute: '%Y-%m-%d %H:%M',
				                hour: '%Y-%m-%d %H:%M',
				                day: '%Y-%m-%d',
				                week: '%Y-%m-%d',
				                month: '%Y-%m',
				                year: '%Y'
				            }
						},
						yAxis : {
							title : {
								text : ytitle//左侧标题
							},
							min:0,//设置y轴的最小值
							minorTickInterval: 'auto'/*,
							plotLines: [{
				                value: policeValue,
				                width: 2,
				                color: '#F24C52',
				                dashStyle: 'dash',
				                label: {
				                    text: '警戒线:('+policeNum+')',
				                    align: 'right',
				                    y: 8,
				                    x: 0
				                }
		            		}],
		            		plotBands: [{
				                from: 80,
				                to: 100,
				                color: '#F24C52'
				            }]*/
		            		
						},
						tooltip : {
							borderColor : "#374E94",
							backgroundColor : {
								linearGradient : [ 0, 0, 0, 60 ],
								stops : [ [ 0, '#FFFFFF' ], [ 1, '#E0E0E0' ] ]
							},
							borderWidth : 1,
							shared : true,
							crosshairs : {
								width : 1,
								color : 'red'
							},
							formatter : function() {
								var s = Highcharts.dateFormat("%Y-%m-%d %H:%M",
										this.x) + ' [';
								$.each(this.points, function(i, point) {
				                    s += '<span style="color:#374E94">'
											+ point.series.name
											+ ':</span><span style="font-weight: bold;color:#F24C52">'
											+ Highcharts.numberFormat(point.y,numberFormat) + unit +'</span>     ';//当鼠标放到一个点上时，显示的y值
				                });
								s = $.trim(s) + "]";								
								return s;
							}
						},
						plotOptions:{
							line:{
								lineWidth : 1,
								marker: {
									radius: 1,//????????
									states: {
										hover: {
											radius: 3
										}
									}
								},
								dashStyle: 'solid'
							},
							area : { 
								fillColor : {
									//linearGradient : [ 0, 0, 0, 200 ],
									//stops : [ [ 0, "#F24C52" ], [ 1, 'rgba(255,0,0,0)' ] ]
									linearGradient : [ 0, 0, 30, 250 ],
									stops : [ [ 0, "#0896E9" ], [ 1, 'rgba(0,157,145,0)' ] ]
								},
								fillOpacity: 0.08,
								lineWidth : 1,
								shadow : true,
								marker: {
									radius: 3,
									states: {
										hover: {
											radius: 5
										}
									}
								}			
							},
							column: {
								grouping: false,
								shadow: false,
								pointPlacement: 'between',
								groupPadding: 0,
								pointPadding: 0,
								borderWidth: 0,
								color: '#0CF223'
							},
							scatter:{
								marker: {
									radius: 2,
									states: {
										hover: {
											radius: 3
										}
									},
									symbol: 'circle'
								}	
							}
						},
						exporting : {
							buttons : {
								exportButton : {
									enabled : false
								}
							}
						},
						legend: {
							enabled: false//不显示折线下发的图标（多条线时，点击可隐藏或者显示折线）
						},
						series : seriesOptions,//显示的数据
					    credits: {
							enabled: false,
							text: 'i18n_sdigp.message.updateTheMarker_n81i'
						}
					});
					
		}
		
		function doSvgFun(){
		//给生成的svg划线
			var clickPortId = "${clickPortId}";//获取单击的端口id
			var emSvg = document.getElementById('emSvg');
			  svgDoc = emSvg.getSVGDocument();  
			  if(svgDoc == null) return ;  
			  svgWnd = svgDoc.svgWnd ; //这个window对象是在svg的初始化里面添加进去的  
			  svgWnd.showSelect(clickPortId) ; //调用svg里的js函数
		}
		
	</script>
	<body style="overflow-y: scroll;"  onload="doSvgFun()">
			<form name=form3 id="frmArticleType"
				action="<c:url value='/detection/switchDetection.do?action=query'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="typeids" value="${typeids[0]}"/>
				<input type="hidden" name="ctn" id="ctn" value="${ctn }" />
				<input type="hidden" name="networElementType" id="networElementType" value="${networElementType }" />
				<!-- 来源于拓扑图 begin -->
				<input type="hidden" name="requestType" value="${requestType }" />
				<input type="hidden" name="nodeGroupId" value="${nodeGroupId }" />
				<input type="hidden" name="nodeIp" value="${nodeIp }" />
				<!-- 来源于拓扑图 end -->	
				<div id="divTop" >
					<div id="backBut" class="box_2" style="position: absolute; top: body.scrollTop+2; left: 95%;">
						<input type="button" class=btn3_mouseout
							onmouseover="this.className='btn3_mouseover'"
							onmouseout="this.className='btn3_mouseout'"
							onmousedown="this.className='btn3_mousedown'"
							onmouseup="this.className='btn3_mouseup'"
							onclick="goBack()" value="i18n_sdigp.button.back_n81i"/>
							&nbsp;
							<input id="indexStr2" type="hidden" />
					</div>
				</div>
			</form>
			<div style="margin:10px;width: 98%;height: ${devHeightSum};min-width:1000px;"  >
				<div style="width:500px;float:left;">
					<embed src="<c:url value='/page/detection/switchInfo/${svgName}'  />"
						quality="high" name="powerMap"
						pluginspage="http://www.adobe.com/svg/viewer/install"
						type="image/svg+xml" width="520" height="100%" wmode="transparent"
						style="overflow-y:scroll; " id="emSvg">
					</embed>
				</div>
				<div style="width:45%;margin-left:550px;margin-top:50px;">
					<form action="<%=path%>/detection/switchDetection.do?action=switchDetectInfoGraph" name="portForm" method="post">
						<input type="hidden" name="deviceTypeCode" value="${deviceTypeCode }" />
						<input type="hidden" name="svgName" value="${svgName }" />
						<input type="hidden" name="dataCheckTime" value="${dataCheckTime }" />
						<input type="hidden" name="seqId" value="${seqId }" />
						<input type="hidden" name="detectId" value="${detectId }" />
						<input type="hidden" name="ip" value="${ip }" />
						<input type="hidden" name="nameFlag" id="nameFlag" value="${nameFlag }" />
						<input type="hidden" name="pid" id="pid" value="${pid }" />
						<input type="hidden" name="isLeaf" id="isLeaf" value="${isLeaf }" />
						<input type="hidden" name="picId" id="picId" value="${picId }" />
						<input type="hidden" name="picIdFlag" id="picIdFlag" value="${picIdFlag }" />
						<input type="hidden" name="picIdXtFlag" id="picIdXtFlag" value="${picIdXtFlag }" />
						<input type="hidden" name="bodyScrollTop" id="bodyScrollTop" value="${bodyScrollTop}" />
	
						<input type="hidden" name="queryParConditionDisplay" id="queryParConditionDisplay" value="${queryParConditionDisplay }" />
						<input type="hidden" name="queryChildConditionDisplay" id="queryChildConditionDisplay" value="${queryChildConditionDisplay }" />
						<div style="width: 100%;height:auto;font-size:14px;padding-top:7px;" align="center">
					    	i18n_sdigp.text.ip_n81i:${ip}
					    	&nbsp;&nbsp;&nbsp;&nbsp;i18n_sdigp.text.deviceTypeCode_n81i:${deviceTypeCode}
					    	&nbsp;&nbsp;&nbsp;&nbsp;i18n_sdigp.text.dataCheckTime_n81i:${dataCheckTime}
					    </div>
							<table border="0" cellpadding="0" cellspacing="0" class="table" >
								<tr style="display: inline;">
									<td class="color_8"   width="100%" >
											 <strong>i18n_sdigp.text.title_n81i</strong>
									</td>
									<td class="color_8"  style="cursor: hand;">
										     <img  id="openAndCloseParImgSrc"  onclick="javascript:toOpenAndFlex('queryParCondition','openAndCloseParImgSrc','queryChildCondition','openAndCloseChildImgSrc','queryParConditionDisplay','queryChildConditionDisplay');" align="right" style="padding-right: 20px;"
												<c:if test="${queryParConditionDisplay eq 'none'}">src="<%=basePath %>images/close.gif"</c:if>
												<c:if test="${queryParConditionDisplay== '' || queryParConditionDisplay eq null}">src="<%=basePath %>images/open.gif"</c:if> />
									</td>
								</tr>
								<tr id="queryParCondition"  style="display:${queryParConditionDisplay}" >
									<td colspan="2">
										<table border="0" cellpadding="0" cellspacing="0" class="table" style="border-spacing:0px;border:0px;">
											<tr >
												<td class="color_1" align="right" width="20%">
													i18n_sdigp.text.sysName_n81i：
												</td>
												<td class="color_3" align="left" width="80%" colspan="3">
													${diSystem.sysName}	
												</td>
											</tr>
											<tr>
												<td class="color_1" align="right" width="20%">
													i18n_sdigp.text.sysUpTime_n81i：
												</td>
												<td class="color_3" align="left"  width="20%">
												    ${diSystem.sysUpTime}
													
												</td>
												<td class="color_1" align="right"  width="20%">
													i18n_sdigp.text.sysLocation_n81i：
												</td>
												<td class="color_3" align="left" >
												 ${diSystem.sysLocation}
												</td>
											</tr>
											<tr>
												<td class="color_1" align="right">
													i18n_sdigp.text.outoctetsspeed_n81i：
												</td>
												<td class="color_3" align="left">
												<a href="#tab2-outoctetsspeedXt" onclick="javascript:getPicSystemScorce('outoctetsspeed',1,'i18n_sdigp.text.outoctetsspeed_n81i','bps',0,'outoctetsspeedXt');" id="outoctetsspeedXt">
													<% DiSystem diSystem = (DiSystem) request.getAttribute("diSystem");  %>
													<%=MyNumberFormat.formatStr1(diSystem==null?null:(diSystem.getSysOutSpeedSum()==null?null:new BigDecimal(diSystem.getSysOutSpeedSum())),0,1024) %>
												</a>
												</td>
												<td class="color_1" align="right" width="20%">
													i18n_sdigp.text.inoctetsspeed_n81i：
												</td>
												<td class="color_3" align="left" width="20%">
												<a href="#tab2-inoctetsspeedXt" onclick="javascript:getPicSystemScorce('inoctetsspeed',1,'i18n_sdigp.text.inoctetsspeed_n81i','bps',0,'inoctetsspeedXt');" id="inoctetsspeedXt">
													<%=MyNumberFormat.formatStr1(diSystem==null?null:(diSystem.getSysInSpeedSum()==null?null:new BigDecimal(diSystem.getSysInSpeedSum())),0,1024) %>
												</a>
												</td>
												
											</tr>							
											<tr>
												<td class="color_1" align="right">
													i18n_sdigp.text.outpktsspeed_n81i：
												</td>
												<td class="color_3" align="left" >
												<a href="#tab2-outpktsspeedXt" onclick="javascript:getPicSystemScorce('outpktsspeed',1,'i18n_sdigp.text.outpktsspeed_n81i','pps',0,'outpktsspeedXt');" id="outpktsspeedXt">
												    <c:if test="${diSystem.sysOutPktsSpeedSum ne null }"> ${diSystem.sysOutPktsSpeedSum}pps </c:if>
												 </a>
												</td>
												<td class="color_1" align="right">
													i18n_sdigp.text.inpktsspeed_n81i：
												</td>
												<td class="color_3" align="left">
												<a href="#tab2-inpktsspeedXt" onclick="javascript:getPicSystemScorce('inpktsspeed',1,'i18n_sdigp.text.inpktsspeed_n81i','pps',0,'inpktsspeedXt');" id="inpktsspeedXt">
												    <c:if test="${diSystem.sysInPktsSpeedSum ne null }"> ${diSystem.sysInPktsSpeedSum}pps </c:if>
												</a>
												</td>
											</tr>
											<tr>
												
												<td class="color_1" align="right">
													i18n_sdigp.text.sysStatus_n81i：
												</td>
												<td class="color_3" align="left" colspan="3">
													${diSystem.sysStatus}	
												</td>
										    </tr>
											<tr>
												<td class="color_1" align="right">
													i18n_sdigp.text.sysDesc_n81i：
												</td>
												<td class="color_3" align="left" colspan="3">
													${diSystem.sysDescr}	
												</td>
											</tr>
										</table>
										<table id="portInfoPicXt" border="0" cellpadding="0" cellspacing="0" class="table" style="width:100%;display:none;border-spacing:0px;border:0px;table-layout: fixed;">
												<tr >
													<td align="center" >
														<div  style='padding-top: 6px;margin-bottom:3px :height: 30px;vertical-align: middle;' >
															i18n_sdigp.text.from_n81i:&nbsp;<input  type="text" id="startTimeXt" name="startTimeXt" value="${startTimeXt}" readonly onclick="SelectDate(this,'yyyy-MM-dd hh:mm',${session.i18n_lang == 'zh_CN'?0:1})" size="15" style="height:20px;vertical-align: middle;" onkeydown="if(event.keyCode==8){event.returnValue=false;}"/> 
														<!-- &nbsp;至: &nbsp;<input  type="text" id="endTime" name="endTime" value="${endTime}" readonly onclick="SelectDate(this,'yyyy-MM-dd hh:mm')" size="15"  style="height:20px;vertical-align: middle;"  onkeydown="if(event.keyCode==8){event.returnValue=false;}" />   -->	 
														<font size="2px">[i18n_sdigp.text.selectOneDay_n81i]</font>	<img src="<c:url value='/images/button_chaxun.png'/>"  onclick="javascript:qryPicXt();"  style="vertical-align: middle;cursor: pointer;"/>
														</div>
														<div id="tabs-2" style='padding: 0;margin: 0;width:auto; height: 215px;'>
														</div>
													</td>
												</tr>
											</table>	
									</td>							
								</tr>
							</table>	
							
							<c:if test="${pid ne 0 && isLeaf eq 1}">
								<table border="0" cellpadding="0" cellspacing="0" class="table" style="table-layout: fixed;">
									<tr>
										<td class="color_8" width="95%">											<strong>i18n_sdigp.text.port_n81i${nameFlag}i18n_sdigp.text.portInfo_n81i</strong>
										</td>
										<td class="color_8" style="cursor: hand;" >
											 <img  id="openAndCloseChildImgSrc" onclick="javascript:toOpenAndFlex('queryChildCondition','openAndCloseChildImgSrc','queryParCondition','openAndCloseParImgSrc','queryChildConditionDisplay','queryParConditionDisplay');" align="right" style="padding-right: 20px;"
													<c:if test="${queryChildConditionDisplay eq 'none'}">src="<%=basePath %>images/close.gif"</c:if>
												<c:if test="${queryChildConditionDisplay eq '' || queryChildConditionDisplay eq null}">src="<%=basePath %>images/open.gif"</c:if> />
										</td>
									</tr>
									<tr id="queryChildCondition" style="display:${queryChildConditionDisplay}">
										<td colspan="2">
											<table border="0" cellpadding="0" cellspacing="0" class="table" style="border-spacing:0px;border:0px;">
												<tr >
										
													<td class="color_1" align="right" width="20%">
														i18n_sdigp.text.ifDescr_n81i：
													</td>
													<td class="color_3" align="left" width="20%">
														${switchPortInfo.ifDescr}	
													</td>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifType_n81i：
													</td>
													<td class="color_3" align="left">
														${switchPortInfo.ifTypeStr}	
													</td>
												</tr>
												<tr>
													<td class="color_1" align="right" >
														i18n_sdigp.text.ifAdminStatus_n81i：
													</td>
													<td class="color_3" align="left" >
															 <c:if test="${switchPortInfo.ifAdminStatus==1 }"> up </c:if>
															 <c:if test="${switchPortInfo.ifAdminStatus==2 }"> down </c:if>
															 <c:if test="${switchPortInfo.ifAdminStatus==3 }"> testing </c:if>
														
													</td>
													<td class="color_1" align="right" >
														i18n_sdigp.text.ifOperStatus_n81i：
													</td>
													<td class="color_3" align="left" >
														 <c:if test="${switchPortInfo.ifOperStatus==1 }"> up </c:if>
														 <c:if test="${switchPortInfo.ifOperStatus==2 }"> down </c:if>
														 <c:if test="${switchPortInfo.ifOperStatus==3 }"> testing </c:if>
													</td>
												</tr>
												<tr>
													<td class="color_1" align="right">
														i18n_sdigp.text.outoctetsspeed_n81i：
													</td>
													<td class="color_3" align="left">
													    <a href="#tab-outoctetsspeed" onclick="javascript:getPicScorce('outoctetsspeed',1,'i18n_sdigp.text.outoctetsspeed_n81i','bps',0,'outoctetsspeed');" id="outoctetsspeed">
													       <% SwitchPortInfo switchPortInfo = (SwitchPortInfo) request.getAttribute("switchPortInfo");  %>${outoctetsspeed}
													       <%=MyNumberFormat.formatStr1(switchPortInfo==null?null:(switchPortInfo.getIfOutOctetsSpeed()==null?null:new BigDecimal(switchPortInfo.getIfOutOctetsSpeed())),0,1024) %>
														</a>
													</td>
													<td class="color_1" align="right" width="20%">
														i18n_sdigp.text.inoctetsspeed_n81i：
													</td>
													<td class="color_3" align="left" width="20%">
													    <a href="#tab-inoctetsspeed" onclick="javascript:getPicScorce('inoctetsspeed',1,'i18n_sdigp.text.inoctetsspeed_n81i','bps',0,'inoctetsspeed');" id="inoctetsspeed">
															<%=MyNumberFormat.formatStr1(switchPortInfo==null?null:(switchPortInfo.getIfInOctetsSpeed()==null?null:new BigDecimal(switchPortInfo.getIfInOctetsSpeed())),0,1024) %>
														</a>
													</td>
													
												</tr>
												<tr>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifouterrors_vary_n81i：
													</td>
													<td class="color_3" align="left" >
													   <a href="#tab-ifouterrors_vary" onclick="javascript:getPicScorce('ifouterrors_vary',1,'i18n_sdigp.text.ifouterrors_vary_n81i','',0,'ifouterrors_vary');" id="ifouterrors_vary">
															${switchPortInfo.ifouterrorsVary}
													   </a>
													</td>
													<td class="color_1" align="right" >
														i18n_sdigp.text.ifinerrors_vary_n81i：
													</td>
													<td class="color_3" align="left" >
														<a href="#tab-inerrorsscale" onclick="javascript:getPicScorce('ifinerrors_vary',1,'i18n_sdigp.text.ifinerrors_vary_n81i','',0,'ifinerrors_vary');" id="ifinerrors_vary">
													    	${switchPortInfo.ifinerrorsVary}
													    </a>
													</td>
													
												</tr>
												<tr>
													<td class="color_1" align="right">
														i18n_sdigp.text.outpktsspeed_n81i：
													</td>
													<td class="color_3" align="left" >
														<a href="#tab-outpktsspeed" onclick="javascript:getPicScorce('outpktsspeed',1,'i18n_sdigp.text.outpktsspeed_n81i','pps',0,'outpktsspeed');" id="outpktsspeed">
															<c:if test="${switchPortInfo.outpktsspeed ne null && switchPortInfo.outpktsspeed!=''}"> <%=new BigDecimal(switchPortInfo.getOutpktsspeed())%>pps </c:if>
															<c:if test="${switchPortInfo.outpktsspeed eq null || switchPortInfo.outpktsspeed==''}"> 0 pps </c:if>
														</a>
													</td>
													<td class="color_1" align="right">
														i18n_sdigp.text.inpktsspeed_n81i：
													</td>
													<td class="color_3" align="left">
														<a href="#tab-inpktsspeed" onclick="javascript:getPicScorce('inpktsspeed',1,'i18n_sdigp.text.inpktsspeed_n81i','pps',0,'inpktsspeed');" id="inpktsspeed">
													    	<c:if test="${switchPortInfo.inpktsspeed ne null && switchPortInfo.inpktsspeed!=''}"> <%=new BigDecimal(switchPortInfo.getInpktsspeed()) %>pps </c:if>
													    	<c:if test="${switchPortInfo.inpktsspeed eq null || switchPortInfo.inpktsspeed==''}"> 0 pps </c:if>
													    </a>
													</td>
												</tr>
												<tr>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifoutdiscards_vary_n81i：
													</td>
													<td class="color_3" align="left">
														<a href="#tab-ifoutdiscardsperc" onclick="javascript:getPicScorce('ifoutdiscards_vary',1,'i18n_sdigp.text.ifoutdiscards_vary_n81i','',0,'ifoutdiscards_vary');" id="ifoutdiscards_vary">
															${switchPortInfo.ifoutdiscardsVary}
														</a>
													</td>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifindiscards_vary_n81i：
													</td>
													<td class="color_3" align="left">
														<a href="#tab-ifindiscardsperc" onclick="javascript:getPicScorce('ifindiscards_vary',1,'i18n_sdigp.text.ifindiscards_vary_n81i','',0,'ifindiscards_vary');" id="ifindiscards_vary">
													   		${switchPortInfo.ifindiscardsVary}
													    </a>
													</td>
												</tr>
												
												<tr>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifHighSpeed_n81i：
													</td>
													<td class="color_3" align="left">
													 	<%=(switchPortInfo==null?"":(switchPortInfo.getIfHighSpeed() ==null?MyNumberFormat.formatStr1(new BigDecimal(switchPortInfo.getIfSpeed()),0,1000):switchPortInfo.getIfHighSpeed()+"Mbps")) %>
													</td>
													<td class="color_1" align="right">
														i18n_sdigp.text.ifPhysAddress_n81i：
													</td>
													<td class="color_3" align="left" >
														${switchPortInfo.ifPhysAddress}	
													</td>
													
												</tr>
												<tr>
													<td class="color_1" align="right" >
														i18n_sdigp.text.ifLastChangeStr_n81i：
													</td>
													
													<td class="color_3" align="left" colspan="3">
														${switchPortInfo.ifLastChangeStr}	
													</td>
													
												</tr>
											</table>	
											<table id="portInfoPic" border="0" cellpadding="0" cellspacing="0" class="table" style="width:100%;display:none;border-spacing:0px;border:0px;table-layout: fixed;">
												<tr >
													<td align="center" >
														<div  style='padding-top: 6px;margin-bottom:3px :height: 30px;vertical-align: middle;' >
															i18n_sdigp.text.from_n81i: &nbsp;<input  type="text" id="startTime" name="startTime" value="${startTime}" readonly onclick="SelectDate(this,'yyyy-MM-dd hh:mm',${session.i18n_lang == 'zh_CN'?0:1})" size="15" style="height:20px;vertical-align: middle;" onkeydown="if(event.keyCode==8){event.returnValue=false;}"/> 
														<!-- &nbsp;至: &nbsp;<input  type="text" id="endTime" name="endTime" value="${endTime}" readonly onclick="SelectDate(this,'yyyy-MM-dd hh:mm')" size="15"  style="height:20px;vertical-align: middle;"  onkeydown="if(event.keyCode==8){event.returnValue=false;}" />   -->	 
														<font size="2px">[i18n_sdigp.text.selectOneDay_n81i]</font>	<img src="<c:url value='/images/button_chaxun.png'/>"  onclick="javascript:qryPic();"  style="vertical-align: middle;cursor: pointer;"/>
														</div>
														<div id="tabs-1" style='padding: 0;margin: 0;width:auto; height: 215px;'>
														</div>
													</td>
												</tr>
											</table>	
									     </td>
								    </tr>
								</table>	
							</c:if>
					</form>
				</div>
			</div>						
	</body>

</html>
