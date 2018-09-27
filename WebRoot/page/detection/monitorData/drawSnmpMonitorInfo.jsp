<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_dsmi.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/js/dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"></link>
		<link href="<%=path%>/css/themes/base/jquery.ui.css" rel="stylesheet" type="text/css"></link>
		
		<script type="text/javascript"src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script type="text/javascript" 
			src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/highcharts.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/WebCalendar.js' />"></script>
		<script>
		$(function() {
			$( "#tabs" ).tabs();
			$( "#tabs" ).removeClass("ui-widget");//删除ui样式(此样式会使折线图下方navigator失灵)
			if(document.getElementById("tabs-1")){
				$("a[dtype='cli']:eq(0)").trigger('click');
				$("a[dtype='cli']:eq(0)").trigger('click');//只调用一次时，曲线x轴的时间和实际时间差8个小时，调用2次就没问题了
			}
		
			$("#ok").click(function() {
				var result = "";
				var num = $(".checks:checked").size();
				if(num>5){
						alert("i18n_dsmi.message.selectToDraw1_n81i");
						return;
				}else{
					$(".checks:checked").each(function() {
						var lable = $(this).closest("label");
						result += lable.attr("ids")+',';
					});
					if (result == "") {
						alert("i18n_dsmi.message.selectTodraw2_n81i");
						return;
					} else {
						var metaId= $("#mid").val();
						
						var drwTo= $("#tabIndex").val();
						getPicScorce(metaId,drwTo,result);
						//清空选择
						//$(".checks").removeAttr("checked");
						//resetBg();
					}
				}
			})
			
			$("#clear").click(function() {
				$(".checks").removeAttr("checked");
				resetBg();
			})
		
			$(".checks").click(function() {
				resetBg();
			})
		});
		
		function resetBg() {
			$(".checks").each(function() {
				var label = $(this).closest("label");
				if ($(this).is(":checked")) {
					label.css("background-Color", "#B5C19B");
				} else {
					label.css("background-Color", "");
				}
			})
		}
		
		//type为空是服务器检测菜单
		//type=1:网元监测
		//type=1：异常网元
		//showHistory不为空是查询监测历史记录
		function goBack(){
			var action ="<c:url value='/detection/monitorData.do?action=query'/>";
			if($("#type").val()== "1"){
				action ="<c:url value='/detection/monitorData.do?action=queryNE'/>";
			}else if($("#type").val()== "2"){
				action ="<c:url value='/detection/monitorData.do?action=queryAbnormalSet'/>";
			}
			if($("#showHistory").val()== "history"){
				action ="<c:url value='/detection/monitorData.do?action=showDetectionInfo'/>";
			}
			if($("#flag").val()== "queryEmergent"){
				action ="<c:url value='/detection/monitorData.do?action=queryEmergent'/>";
			}
			if($("#flag").val()== "queryEmergentDetail"){
				action ="<c:url value='/detection/monitorData.do?action=queryEmergentDetail&requestType=topo&nodeGroupId=${nodeGroupId}&nodeId=${nodeId}'/>";
			}
			if($("#requestType").val()== "newTopo"){
				action ="<c:url value='/detection/monitorData.do?action=query&nodeId=${nodeId}'/>";
			}
			document.Mkform.action=action;
			document.Mkform.submit();	
		}

		 //查询记录
		function qry(){
			var startTime = $("#startTime").val();
			if(startTime==""){
				alert("i18n_dsmi.message.startTime_n81i");
				return;
			}
			var endTime = $("#endTime").val();
			if(endTime==""){
				alert("i18n_dsmi.message.endTime_n81i");
				return;
			}
			var start=new Date(startTime.replace(/-/g,"/"));//起始时间操作值
			var start1=new Date(startTime.replace(/-/g,"/"));//起始时间备份
			start.setDate(start.getDate()+7);//起始时间日期加一周 用来与结束时间比较
			var end=new Date(endTime.replace(/-/g,"/"));//结束时间
			if(end<=start1){
				alert("i18n_dsmi.message.startGtEnd_n81i");
				return;
			}
			if(end>start){
				alert("i18n_dsmi.message.intervalErr_n81i");
				return;
			}
			$("#ok").click();
		}
		
		var seriesOptions = [];
		var policeValue;
		var xtilte="";
		var ytitle="";
	
		function getPicScorce(metaid,drwTo,lns){
			$("#tabIndex").val(drwTo);
			$("#mid").val(metaid);
			seriesOptions = [];//清空数据源
			
			$.ajax( {
				url : "<%=path%>/detection/monitorData!getSnmpSource.do?metaId="+metaid+"&dId="+$('#did').val()+"&cId="+$('#ctid').val()+"&seqId="+$('#seqId').val()+"&lns="+lns+"&startTime="+$('#startTime').val()+"&endTime="+$('#endTime').val()+"&type="+$('#type').val()+"&requestType="+$('#requestType').val()+"&nodeGroupId="+$('#nodeGroupId').val(),
				type : "POST",
				dataType : "json",
				success : function(datas) {
					if(datas!=null){
						$('#tabsHidd-'+drwTo).val('1');
						xtitle = datas[0].xtitle;
						ytitle = datas[0].ytitle;
						policeValue = datas[0].policeVal;
						var lines = datas[1].lines;
						if(lines[0].data == null || lines[0].data == ""){
							$("#tabs-"+drwTo).empty();
							$("#tabs-"+drwTo).append('i18n_dsmi.message.noData_n81i');
						}else{
							$.each(lines, function(k, da) {
								seriesOptions[k] = {
									name: da.name,
									data: da.data
								};
								createChart(policeValue,drwTo);
							});
						}
					}else{
						$("#tabs-"+drwTo).empty();
						$("#tabs-"+drwTo).append('i18n_dsmi.message.noData_n81i');
					}
				}
			})
		}
		
		function createChart(policeNum,dto) {
					var chartObj = new Highcharts.Chart(
					{
						chart : {
							renderTo : 'tabs-'+dto,
							zoomType : 'x',
							showAxes : true,
							spacingRight : 20,
							defaultSeriesType : 'line',
							borderWidth: 1
						},
						title : {
							text : xtitle
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
								text : ytitle
							},
							minorTickInterval: 'auto',
							min:0,
							plotLines: [{
				                value: policeValue,
				                width: 2,
				                color: '#F24C52',
				                dashStyle: 'dash',
				                label: {
				                    text: 'i18n_dsmi.message.policyLine_n81i:('+policeNum+')',
				                    align: 'right',
				                    y: 8,
				                    x: 0
				                }
		            		}]/*,
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
											+ point.y + '</span>     ';
				                });
								s = $.trim(s) + "]";
								return s;
							}
						},
						plotOptions:{
							line:{
								lineWidth : 1,
								marker: {
									radius: 2,
									states: {
										hover: {
											radius: 3
										}
									}
								}	
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
							}
						},
						exporting : {
							buttons : {
								exportButton : {
									enabled : false
								}
							}
						},
						series : seriesOptions,
					    credits: {
							enabled: false,
							text: 'i18n_dsmi.message.updateTheMark_n81i'
						}
					});
					Highcharts.setOptions( {
						global : {
							useUTC : false
						}
					});
					
				}
			
		</script>

	</head>
	<body>
		<form action="" name="Mkform" method="post">
			<input type="hidden" name="cip"  value="${cip }" />
			<input type="hidden" name="ctn"  value="${ctn }" />
			<input type="hidden" name="stateInfo" id="stateInfo" value="${stateInfo }" />
			
			<input type="hidden" name="detectionSetInfoId" id="detectionSetInfoId" value="${detectionSetInfoId }">
			
			<input type="hidden" id="seqId" name="seqId"  value="${sqId}"/>
			<input type="hidden" id="nodeGroupStr" name="nodeGroupStr"  value="${nodeGroupStr}"/>
			<input type="hidden" id="nodeIpRange" name="nodeIpRange"  value="${nodeIpRange}"/>
			<input type="hidden" id="did" name ="dsiId" value="${dsiId }"/>
			<input type="hidden" id = "ctid" name="ctid" value = "${ctId}"/>
			<input type="hidden" id = "isClick" name="isClick" value ="0"/>
			<input type="hidden" id = "mid" name="mid" value = "${metaId}"/>
			<input type="hidden" id="tabIndex" value=""/>
			<!-- type为空：服务器检测，type=1：网元检测  type=2:异常网元 -->
			<input type="hidden" value="${type }" name="type" id="type"/>
			<input type="hidden" value="${flag }" name="flag" id="flag"/>
			<input type="hidden" value="${nodeType }" name="nodeType" id="nodeType"/>
			<!-- 来源于拓扑图 begin -->
			<input type="hidden" id="requestType" name="requestType" value="${requestType }" />
			<input type="hidden" id="nodeGroupId" name="nodeGroupId" value="${nodeGroupId }" />
			<!-- 来源于拓扑图 end -->
			
			<!-- 是否为特种设备进入此页面 -->
			<input type="hidden" name="entry" id="entry" value="${entry }"/>
			<input type="hidden" name="detectId" id="detectId" value="${detectId }"/>
			<input type="hidden" name="ip" id="ip" value="${ip }"/>
			<input type="hidden" name="pid" id="pid" value="${pid }"/>
			
			<!-- 查看监测设置历史记录 begin -->
			<input type="hidden" name="sqId" value="${sqId }" />
			<input type="hidden" name="sTime" value="${sTime }" />
			<input type="hidden" name="eTime" value="${eTime }" />
			<input type="hidden" name="status" value="${status }" />
			<input type="hidden" name="showHistory" value="${showHistory }" id="showHistory" />
			<!-- 查看监测设置历史记录 end -->
			
			<jsp:include page="/common/transferHiddenParameter.jsp" />
			
			<table width="80%" align="center" border="0" cellpadding="0"
				cellspacing="1" class="table">
				<tr>
					<td  class="color_8">
						<strong>i18n_dsmi.message.title_n81i</strong>
					</td>
				</tr>
				<tr>
					<td  class="box_1">
					    <div class="box_1">
						<label class="divTopText"><font class="selectText">i18n_dsmi.text.startTime_n81i</font>
						<%--<%
						Date d = new Date();
						d.setDate(d.getDate()-7);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String st = sdf.format(d);
						String et = sdf.format(new Date());
						%>
						--%><input  type="text" id="startTime" 
								name="startTime" value="" readonly
								onclick="SelectDate(this,'yyyy-MM-dd',${session.i18n_lang == 'zh_CN'?0:1})"/></label>
						<label class="divTopText"><font class="selectText">i18n_dsmi.text.endTime_n81i</font>
						<input  type="text" id="endTime" 
								name="endTime" value="" readonly
								onclick="SelectDate(this,'yyyy-MM-dd',${session.i18n_lang == 'zh_CN'?0:1})"/></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="color: red;">i18n_dsmi.message.defaultMsg_n81i</span>
					</td>
					<td  class="box_2">
				        <div class="box_2">
							<input type="button" class=btn3_mouseout 
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="goBack()" value="i18n_dsmi.button.back_n81i"/>
						</div>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
							<div id="tabs">
									<c:set var="index" value="${1}" />
									<c:set var="index1" value="${1}" />
									
									<c:choose>
										<c:when test="${fn:length(metadataList) > 0}">
											<ul>
											<c:forEach items="${metadataList}" var="meta">
												<c:if test="${meta.filedComments==''}">
													<li>
														<a dtype='cli' href="#tabs-${index }" onclick="getPicScorce(${meta.id },'${index }','')">${meta.filedName}</a>
														<input id="tabsHidd-${index }" type="hidden" value="0"/>
													</li>
												</c:if>
												<c:if test="${meta.filedComments!=''}">
													<li>
														<a dtype='cli' href="#tabs-${index }" onclick="getPicScorce(${meta.id },'${index }','')">${meta.filedComments}</a>
														<input id="tabsHidd-${index }" type="hidden" value="0"/>
													</li>
												</c:if>		
												
												<c:set var="index" value="${index + 1}" />
											</c:forEach>
											</ul>
											<!-- 画图用的div -->
											<c:forEach items="${metadataList}" var="meta1">
												<div id="tabs-${index1 }" style='padding: 0;margin: 0;width: 95%; height: 450px;'>
													
												</div>
												<c:set var="index1" value="${index1 + 1}" />
											</c:forEach>
										</c:when>
										
										<c:otherwise>
											<span>i18n_dsmi.text.noRecord_n81i</span>		
										</c:otherwise>
									 </c:choose>
							</div>
							<div id="listDiv"
								style="margin:5px 0px;background-color: #d3eaef; text-align:left;overflow: auto;border:1px solid gray;">
								<c:choose>
								<c:when test="${fn:length(dataList) > 0}">
								    <table width="100%" align="left" border="0" cellpadding="0" cellspacing="0"  style="margin-top: 5px;">
										<c:set var="numPerRow" value="${6}" />
										<c:forEach items="${dataList}" var="item" varStatus="num">
										    <c:if test="${num.count%numPerRow==1}">
											<tr>
										    </c:if>
												<td align="left" width="10%"  style="">
													<label class="item" title="${item}" ids="${item}"style="text-overflow: ellipsis; overflow: hidden;padding-left: 5px;">
														<input class="checks" type="checkbox" value="${item}"/>
														${item}
													</label>
												</td>
										    <c:if test="${num.count%numPerRow==0}">
										    </tr>
										    </c:if>
										</c:forEach>
										<c:if test="${fn:length(dataList)%numPerRow!=0}">
										    </tr>
										</c:if>
									</table>
								</c:when>
								<c:otherwise>
									<span>i18n_dsmi.textnoClassify_n81i</span>		
								</c:otherwise>
								</c:choose>
								<span style=" text-align: left;">
									<br/>
									<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										id="clear" value="i18n_dsmi.button.clearSelected_n81i"/>
									&nbsp;
									<input type="button" class=btn3_mouseout
										onmouseover="this.className='btn3_mouseover'"
										onmouseout="this.className='btn3_mouseout'"
										onmousedown="this.className='btn3_mousedown'"
										onmouseup="this.className='btn3_mouseup'"
										id="ok" value="i18n_dsmi.button.sure_n81i"/>
								</span>
							</div>
					</td>
				</tr>
			</table>
		</form>
		<br />
	</body>
</html>
