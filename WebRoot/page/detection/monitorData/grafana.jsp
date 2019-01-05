<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("vEnter","\n");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>National Proxy</title>
	<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery1.11.3.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/js/echarts.min.js'/>"></script>
</head>
<style>
	.section{
		margin: 30px 10px 30px 10px;
		float: left;
		width:100%;
	}
	.part{
		height: 400px;
		width: 50%;
		float: left;
		min-width: 600px; 
	}
	.part{
		margin-top: 60px;
	}
	#template{
		display: none;
	}
	.addr{
		text-align: center;
		font-size: 24px;
		font-weight:bold;
		padding: 5px;
		height: 50px;
		line-height: 50px;
	}
	.pic{
		float: left;
	}
</style>
<script language="javascript" type="text/javascript">	
	var systemId = "${systemLogin}";//从session 中取出 systemId
	var refreshInterval = 30000;//定时数据间隔，单位：ms
	//数据源
	var influxdbSource = {
			"100000":{
				addr:"Astana",
				url:'http://10.0.5.19:8086/query'
			},
			/* "100001":{
				addr:"Almaty",
				url:'http://10.0.5.19:8086/query'
			} */
	};
	//配置查询相关信息
	var queryInfo = {
			traffic : {
				title:'traffic',
				yAxisName:'packet/s',
				data: {
					legend:['Raw Input'],
					db:'proxy_stat',
					q:'SELECT sum("value_sum") / 30 FROM "[KNI]rx_pkts" WHERE time >= now() - 6h GROUP BY time(30s) fill(0)'
				}
			},
			connections :{
				title:'connections',
				yAxisName:'conn/s',
				data:{
					legend:['Pending','Unknown','Asymmetric','Intercept','Whitelist','Not HIT'],
					db:'proxy_stat',
					q:'SELECT sum("value_sum") / 30 FROM "[KNI]link_pending" WHERE time >= now() - 6h GROUP BY time(30s) fill(0);SELECT sum("value_sum") / 30 FROM "[KNI]link_unknown" WHERE time >= now() - 6h GROUP BY time(30s) fill(0);SELECT sum("value_sum") / 30 FROM "[KNI]link_asym" WHERE time >= now() - 6h GROUP BY time(30s) fill(0);SELECT sum("value_sum") / 30 FROM "[KNI]link_intercept" WHERE time >= now() - 6h GROUP BY time(30s) fill(0);SELECT sum("value_sum") / 30 FROM "[KNI]link_whitelist" WHERE time >= now() - 6h GROUP BY time(30s) fill(0);SELECT sum("value_sum") / 30 FROM "[KNI]link_not_hit" WHERE time >= now() - 6h GROUP BY time(30s) fill(0)'
				}
			},
			connect_client_latency : {
				title:'connect client latency',
				data:{
					legend:['50%','60%','90%','mean','upper'],
					db:'proxy_stat',
					q:'SELECT mean("50_percentile_sum") FROM "[FP]ssl_down(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(linear);SELECT mean("60_percentile_sum") FROM "[FP]ssl_down(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(linear);SELECT mean("90_percentile_sum") FROM "[FP]ssl_down(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(linear);SELECT mean("mean_sum") FROM "[FP]ssl_down(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(linear);SELECT mean("upper_sum") FROM "[FP]ssl_down(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(linear)'
				}
			},
			connect_server_latency :{
				title:'connect server latency',
				data:{
					legend:['50%','60%','90%','99%','mean','upper'],
					db:'proxy_stat',
					q:'SELECT mean("50_percentile_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none);SELECT mean("60_percentile_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none);SELECT mean("90_percentile_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none);SELECT mean("99_percentile_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none);SELECT mean("mean_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none);SELECT mean("upper_sum") FROM "[FP]ssl_up(ms)" WHERE time >= now() - 6h GROUP BY time(20s) fill(none)'
				}
			},
	};
	
	function renderChart(systemId){
		var influxdb = influxdbSource[systemId];
		var addr = influxdb.addr;
		var $templateClone = $("#template").clone();
		$templateClone.attr("id",systemId);
		$templateClone.find(".addr").html(addr);
		$("#container").append($templateClone);
		$.each(queryInfo,function(key,info){
			var $part = $templateClone.find("."+key);
			var title = info.title;
			var data = info.data;
			var yAxisName = info.yAxisName;
			var legengData = data.legend;
			var series = [];
			$.each(legengData,function(i,n){
				series.push({
					name: n,
					symbol:"none",
		            type: 'line',
		            data: []
				});
			});
			var Chart=echarts.init($part[0]);//初始化
			Chart.showLoading({text : "loading..."}); 
			var option = {
					title: { 
						text: title ,left:"49%"
					},
					tooltip: { 
						trigger: 'axis',
						formatter: function(params){
							var dateTime ;
							var result = "";
							$.each(params,function(i,n){
								console.log(n);
								if(!dateTime){
									dateTime = (new Date(n.value[0])).Format("yyyy-MM-dd hh:mm:ss");//n.value[0];
								}
								result += "<br/>" +n.marker + n.seriesName +": " + (n.value[1]?n.value[1].toFixed(0):"");
							});
					        return dateTime  + result;
					    }
					},
					legend: { 
						data:legengData,
						left:20,
						bottom:5
					},
					xAxis: { 
						type: 'time', 
						timeFormat: 'hh:mm',
						splitNumber:6
					},
					yAxis: { 
						type: 'value',
						name:yAxisName,
						nameLocation:"middle",
						nameTextStyle:{
						    padding:30
						}
					},
					series: series
			};
			Chart.setOption(option);
		});
	}

	
	//刷新数据
	function refreshData(){
		$("#container > .section").each(function(i,n){
			var $section = $(this);
			var systemId = $section.attr("id");
			var influxdb = influxdbSource[systemId];
			$.each(queryInfo,function(key,info){
				var $part = $section.find("."+key);
				var title = info.title;
				var data = info.data;
				var legengData = data.legend;
				$.ajax({//ajax请求获取数据
					type : "POST",
					url : influxdb.url,
					crossDomain:true,//请求偏向外域
					data:{ 
						db:data.db,//查询的数据库名
						q:data.q //查询语句
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						var results = data.results;//返回的result为json格式的数据
						var series = [];
						$.each(results, function(index, result) {
							var s = result["series"];
							var values = s ? s[0].values : [];
							console.log(values);
							series.push({
								name: legengData[index],
					            type: 'line',
					            data: values
							});
						});
						var Chart=echarts.getInstanceByDom($part[0]);//获取echarts实例
						Chart.showLoading({text : "loading..."}); 
						var option = { series: series };
						console.log(option);
						Chart.setOption(option);
						Chart.hideLoading();
					}
				});
			});
		});
	}

	$(function(){
		if(systemId == '-1'){//显示所有地区的图表
			$.each(influxdbSource,function(key,value){
				renderChart(key);
			});
		}else{//只显示当前登录的图表
			renderChart(systemId);
		}
		//首次加载数据
		refreshData();
		//定时刷新功能
		setInterval(function(){
			refreshData();
		}, refreshInterval);
	});
	
	// 对Date的扩展，将 Date 转化为指定格式的String   
	// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
	// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
	// 例子：   
	// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
	// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
	Date.prototype.Format = function(fmt) { //author: meizz   
	  var o = {   
	    "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
	  };   
	  if(/(y+)/.test(fmt))   
	    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	    if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	}
</script>
<body>
	<div id="container" class="container"></div>
	<div id="template" class="section" >
		<div class="addr"></div>
		<div class="pic">
			<div class="part traffic"></div>
			<div class="part connections"></div>
			<div class="part connect_client_latency"></div>
			<div class="part connect_server_latency"></div>
		</div>
	</div>	
</body>
</html>
