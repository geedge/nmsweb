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
		<title>i18n_mrbc.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/desktop/css/index${userBgColor }.css'/>"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/highcharts.js"></script>
		<script type="text/javascript">
		
			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						plotBackgroundColor: '#EBECEB',
						borderColor:null,
						margin:[0,0,30,0],
						borderWidth:0,
						borderRadius:0,			//顶角曲度
						defaultSeriesType: 'line'
					},
					title: {
						y : 20,
						text: '${missionstatetable.missionName }i18n_mrbc.text.resultChart_n81i'
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
					plotOptions: {
						column: {
							//pointPadding: 0.2,
							pointWidth: 25,
							borderWidth: 0
						}
					},
				    series: [
						<%
				    		List<Object[]> resultObjects = (List<Object[]>)request.getAttribute("resultObjects"); 
				    		String[][] lines = new String[][]{
					    		{"0","i18n_mrbc.message.success_n81i","#62C462"},
					    		{"1","i18n_mrbc.message.failed_n81i","#EE5F5B"},
					    		{"3","i18n_mrbc.message.underDelivery_n81i","#F8B551"},
					    		{"40","i18n_mrbc.message.deliveredSuccess_n81i","#3399CC"},
					    		{"50","i18n_mrbc.message.processStop_n81i","#13b5b1"},
					    		{"60","i18n_mrbc.message.fileBackup_n81i","#E5B2FF"},
					    		{"70","i18n_mrbc.message.fileUpdate_n81i","#FF9966"},
					    		{"80","i18n_mrbc.message.commandSuccess_n81i","#CCCC33"},
					    		{"81","i18n_mrbc.message.commandFailed_n81i","#FF9999"},
					    		{"5","i18n_mrbc.message.withDraw_n81i","#7ecef4"},
					    		{"6","i18n_mrbc.message.undo_n81i","#844284"},
					    		{"7","i18n_mrbc.message.undoComplete_n81i","#AEAE5F"}
				    		};
				    		
				    		if(resultObjects!=null){
				    				boolean dFlag = false;
				    			for(String[] line: lines){
				    				boolean viewFlag = false;
				    				StringBuffer datas = new StringBuffer();
				    				for(Object[] objs:resultObjects){
				    				System.out.println(line[0]+" "+objs[1].toString());
				    					if(line[0].endsWith(objs[1].toString())){
				    						viewFlag = true;
				    						datas.append(","+objs[2].toString());
				    					}
				    				
				    				}
				    				if(datas.length()>0){
				    					datas.deleteCharAt(0);
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
				    	%>
					],
					credits:{
						enabled: false
					}
				});
			});
				
		</script>
	</head>
	<body>
		<div id="container" style="width: 800px; height: 380px; margin: 0 auto"></div>
	</body>
</html>
