<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>i18n_st.message.title_n81i</title>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.processing.plugin.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ui/jquery-ui.min.js"></script>
	<script src="<%=path %>/js/jquery.topology-2.0.js"></script>
	<script src="<%=path %>/js/jquery.contextmenu.r2.js"></script>
	<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"/>
	<link href="<%=path%>/css/show/topology.css" rel="stylesheet" type="text/css"/>
	
	<style type="text/css">
		#demo-ul * { padding:0; margin:0; list-style:none; font-size: 12px;}
	</style>
	<script type="text/javascript">
		$("#iconBox").hide();
		jQuery(function(){
			$(document).progressDialog.showDialog("i18n_st.message.loading_n81i");
		});
		function qry(para1) 
		{	
			$('.td').find("span").remove();
			$("#iconBox").hide();
			
			jQuery.post("<%=path %>/nodePosition/nodePosition.do?action=getWarNodeFromBox&boxId="+para1+"&ngId="+$('#gid').val(),
				{},function(data)
					{
						if(data.nodeInBoxList.length>0){
							$("#iconBox").show(function(){
								$("#iconBox").css('top','0px');
							});
							var nodes = data.nodeInBoxList;
							$.each(nodes, function(i, node) {
								var node_Id = node.tableName+'_'+node.nodeType+'_'+node.nodeId;
								var $icon = $("<span divType='node' class='icon-span'></span>");
								$icon.attr('id',node_Id).attr('title',node.nodeIp+"_"+node.nodeName+"_"+node.nodeUType+"U");
								if(node.seqId){
									$icon.attr('class','icon-span-red');
								}else{
									$icon.attr('class','icon-span');
								}
								$icon.bind({
									'mouseenter' : function() {//单引
										//$icon.addClass("hover");
										$("#spanIp2").text(node.nodeIp);
										$("#spanName2").text(node.nodeName);
										$("#spanUType2").text(node.nodeUType+"U");
										var iconBoxPosition = {
											top: $("#iconBox").css('top').replace("px","")*1,
											left: $("#iconBox").css('left').replace("px","")*1,
											width: $("#iconBox").css('width').replace("px","")*1,
											height: $("#iconBox").css('height').replace("px","")*1
										}
										
										var cPointY=0;
										var cPointX=0;
										
										var sumWidth = $("#board").css('width').replace("px","")*1;
										var sumheight = $("#board").css('height').replace("px","")*1;
										
										var iconBoxLeft = parseInt(iconBoxPosition.left);
										if(sumWidth-iconBoxLeft < parseInt(iconBoxPosition.width+200)){
											cPointY = parseInt(iconBoxPosition.left - iconBoxPosition.width);
										}else{
											cPointY = parseInt(iconBoxPosition.left + iconBoxPosition.width+10);
										}
										cPointX = parseInt(iconBoxPosition.top + parseInt(node.latticePosition)*11+30);
										if(cPointX+100>sumheight){
											cPointX = sumheight-110;
										}
										
										$("#span_info2")
											.css('top',cPointX+'px')
											.css('left',cPointY+'px')
											.show();
									},
									'mouseleave' : function() {
										$("#span_info2").hide();
										$("#spanIp2").empty();
										$("#spanName2").empty();
										$("#spanUType2").empty();
									}
								});
								//添加到机柜显示
								$("#spanTable").find('#'+node.latticePosition).append($icon);
								//删除占位置的格子
								if(node.nodeUType>1){
									var u = node.nodeUType; //U位
									var position = node.latticePosition; //位置
									var j;
									for(j=1;j<u;j++){
										var thisTd = parseInt(position) + j;
										$("#spanTable").find('#'+thisTd).parent().hide();//删除占位置的tr
									}
								}
						    });
						}else{
							alert("i18n_st.message.spanTable_n81i");
						}
						
			});
			
		}
	</script>
  </head>
  
  <body oncontextmenu="event.returnValue=false">
    	<div id="border_Div">
			<div id="board" class="board" > 
				<!--告警view-->
				<div id="warningInfo" class="warningBgc">
					<div id="iconBoxHeader" class="window-headerForShow">
						<table border="0" width="100%" align="center">
							<tr>
								<td align="left" width="100%">
									<span id="Title" style="cursor: hand;font-size:10px;color:#FFFFFF;"></span>
								</td>
								<!-- 
								<td align="right" width="10%">
									<img src="<c:url value='/images/logo_2.png'/>" onclick="clo();" style="cursor: hand; background-color:#FFFFFF;">
								</td>
								 -->
							</tr>
						</table>
					</div>
					<div id="warningContent" class="iconBoxContent" style="width: 200px;height: 80px" align="left">
						<ul id="demo-ul">
							<li id="nodeSumNum"></li>
							<li id="trueNum"></li>
							<li id="falseNum" style="color:#FF0000"></li>
						</ul>
						<!-- 
						<span id="nodeSumNum"></span>
						<span id="trueNum"></span>
						<span id="falseNum" style="color:#FF0000"></span>
						 -->
					</div>
				</div>
				<!--打开后node列表-->
				<div id="iconBox" class="iconBoxBgc">
					<div id="iconBoxHeader" class="window-header">
						<table border="0" width="100%" align="center">
							<tr>
								<td align="left" width="90%">
									<span id="boxTitle" style="cursor: hand;font-size:10px;color:#000000;"></span>
								</td>
								<td align="right" width="10%">
									<img src="<c:url value='/images/logo_2.png'/>" onclick="$('#iconBox').hide();$('.td').find('span').remove();" style="cursor: hand; background-color:#FFFFFF;">
								</td>
							</tr>
						</table>
						<!-- <span type='close' class='ui-icon ui-icon-close' style="cursor: hand;background-color:#FFFFFF;" onclick="$('#iconBox').hide();$('.td').find('span').remove();"></span>-->
					</div>
					<div id="iconNodeContent" class="iconBoxContent">
						<table id="spanTable1" class = "tableBox1" border="0" cellpadding="0" cellspacing="0" height="500">
							<tr height="8">
								<td
									style="height: 8px; background-image:url(<%=path%>/images/show/top_1.jpg)">
								</td>
								<td
									style="height: 8px; background-image:url(<%=path%>/images/show/top_2.jpg)">
								</td>
								<td
									style="height: 8px; background-image:url(<%=path%>/images/show/top_3.jpg)">
								</td>
							</tr>
							<tr class="tr">
								<td style=" background-image:url(<%=path%>/images/show/left.jpg)">
									&nbsp;
								</td>
								<td id="1"  width="200">
									<table id="spanTable"  class="tableBox">
										<tr><td id="1" class="td">1</td></tr>
										<tr><td id="2" class="td">2</td></tr>
										<tr><td id="3" class="td">3</td></tr>
										<tr><td id="4" class="td">4</td></tr>
										<tr><td id="5" class="td">5</td></tr>
										<tr><td id="6" class="td">6</td></tr>
										<tr><td id="7" class="td">7</td></tr>
										<tr><td id="8" class="td">8</td></tr>
										<tr><td id="9" class="td">9</td></tr>
										<tr><td id="10" class="td">10</td></tr>
										<tr><td id="11" class="td">11</td></tr>
										<tr><td id="12" class="td">12</td></tr>
										<tr><td id="13" class="td">13</td></tr>
										<tr><td id="14" class="td">14</td></tr>
										<tr><td id="15" class="td">15</td></tr>
										<tr><td id="16" class="td">16</td></tr>
										<tr><td id="17" class="td">17</td></tr>
										<tr><td id="18" class="td">18</td></tr>
										<tr><td id="19" class="td">19</td></tr>
										<tr><td id="20" class="td">20</td></tr>
										<tr><td id="21" class="td">21</td></tr>
										<tr><td id="22" class="td">22</td></tr>
										<tr><td id="23" class="td">23</td></tr>
										<tr><td id="24" class="td">24</td></tr>
										<tr><td id="25" class="td">25</td></tr>
										<tr><td id="26" class="td">26</td></tr>
										<tr><td id="27" class="td">27</td></tr>
										<tr><td id="28" class="td">28</td></tr>
										<tr><td id="29" class="td">29</td></tr>
										<tr><td id="30" class="td">30</td></tr>
										<tr><td id="31" class="td">31</td></tr>
										<tr><td id="32" class="td">32</td></tr>
										<tr><td id="33" class="td">33</td></tr>
										<tr><td id="34" class="td">34</td></tr>
										<tr><td id="35" class="td">35</td></tr>
										<tr><td id="36" class="td">36</td></tr>
										<tr><td id="37" class="td">37</td></tr>
										<tr><td id="38" class="td">38</td></tr>
										<tr><td id="39" class="td">39</td></tr>
										<tr><td id="40" class="td">40</td></tr>
										<tr><td id="41" class="td">41</td></tr>
										<tr><td id="42" class="td">42</td></tr>
									</table>		
								</td>
								<td style=" background-image:url(<%=path%>/images/show/right.jpg)">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td style=" background-image:url(<%=path%>/images/show/foot_1.jpg)">
									&nbsp;
								</td>
								<td style=" background-image:url(<%=path%>/images/show/foot_2.jpg)">
									&nbsp;
								</td>
								<td style=" background-image:url(<%=path%>/images/show/foot_3.jpg)">
									&nbsp;
								</td>
							</tr>
						</table> 
					</div>
				</div>
				<!--右侧机柜列表
				<div style="position: absolute; height: 100%; right: 0;">
					<div id="rightMenuFlag"
						style="float: left;width: 20px;text-align: center;">					
						<img src="<%=path%>/images/show/anniu_3.png" border="0" />
					</div>
					<ul id="rightBoxContent" 
						style="width: 150px; height: 50%;list-style-type: none;margin:0px;display: none;"
						class="menucenter">
					</ul>				
				</div>
				 -->
				<div id="span_info2" class="spanInfo">
					<table id="span_info" >
						<tr><td>IP：</td><td id="spanIp2"></td></tr>
						<tr><td>i18n_st.text.spanName2_n81i：</td><td id="spanName2"></td></tr>
						<tr><td>i18n_st.text.spanUType2_n81i：</td><td id="spanUType2"></td></tr>
					</table>
				</div>
				</div>
				<input type="hidden" id="gid" value=""/>
			</div>
		<script >
			jQuery(function(){
				$("#warningInfo").hide();
				$("#iconBox").hide();
				$("#span_info2").hide();
			//节点UI的拖动
				$("#warningInfo").draggable( {
					cursorAt : {cursor :"move"},
					revert:false,
					handle:'#iconBoxHeader',
					containment:$("#board")
				});
				
				$("#iconBox").draggable( {
					cursorAt : {cursor :"move"},
					revert:false,
					handle:'#iconBoxHeader',
					containment:$("#board")
				});
				
				//发送请求，载入节点及关联关系
				$('#board').showTopology("<%=path %>/nodePosition/nodePosition.do?action=getIconModules");
				//绑定右键菜单，将点击右键时的event srcElement事件放入data缓存
				$('#board').bind('contextmenu', function(e) {
					var $a_obj = $(event.srcElement);
					if($a_obj[0].tagName != 'A'){
						$a_obj = $a_obj.parent();
					}
					$('#board').data('active_obj',$a_obj);
				});
				
				//右边菜单 UL
				var $content=$("#rightBoxContent");
				var initWidth=$content.width();
				//菜单触发事件（隐藏、显示右边菜单）
				$("#rightMenuFlag").click(function(){
					$content.stop(true,true);
					if(!$content.is(":hidden")){
						$content.children().hide();
						$content.animate({width:0},function(){$(this).hide()});
					}else{
						$content.show().animate({width:initWidth},function(){
							$(this).children().fadeIn(300);
						})
					}
				});
				
				
				//新右键菜单
				$(document.body).contextMenu('menu1',{
					onShowMenu: function(e,menu){
						
						//获取触发点的图标对象
						var $a_obj = $(e.srcElement).closest('A');
						if($a_obj.size()>0){	//存在保存
							$('#board').data('active_obj',$a_obj);
						}
						//事件对象判断
						var $Obj = $(e.srcElement);
						if($a_obj.size()>0 ){//当前对象是图标
							var data = $a_obj.data('data');
							$("li[ltype='node'][lvalue='1']",menu).hide();
							$("li[id='getChildNg'][ltype='nodeGroup']",menu).hide();
							if(data.viewType == '1'){//节点组
								if(data.childNum >0){
									$("li[id='getChildNg'][ltype='nodeGroup']",menu).show();
								}else{
									$("li[ltype='node'][lvalue='1']",menu).show();
								}
							}else{
								$("ul[id=list1]",menu).hide();
							}
						}else if($Obj[0].tagName == 'DIV' && $Obj.attr('divType') == 'line'){//线
							$("ul[id=list1]",menu).hide();
						}else{//桌面
							$("ul[id=list1]",menu).hide();
						}
						
						return menu;
					},
					bindings : {
						getBox : function(){  //查看机柜
							$("#rightBoxContent").empty();
							var icon = $('#board').data('active_obj');
							var data=icon.data("data");
							$("#gid").val(data.nodeId);
							//var url = "<%=path %>/nodePosition/nodePosition.do?action=getBoxByGroup&npGId="+data.id+"&groupId="+data.nodeId;
							//getBoxByGroup(data,url);
							//$("#rightMenuFlag").trigger('click');
							var url = "<%=path %>/nodePosition/nodePosition.do?action=editMap&from=show&gid="+data.nodeId+"&npGroupId="+data.id;
							url = encodeURI(url);
							window.location.href=url;
						},
						getChildNg : function(){
							var icon = $('#board').data('active_obj');
							var data=icon.data("data");
							//alert(data.nodeId);
							//$("#gid").value=data.nodeId;
							var url = "<%=path %>/nodePosition/nodePosition.do?action=getChildNg&gid="+data.nodeId+"&npGroupId="+data.id+"&from=show";
							url = encodeURI(url);
							
							window.location.href=url;
						}
					}
				});
			})
		</script>
		<div id='menu1'style="display: none;">
			<ul id="list1">
				<!--<li id='save' ltype='normal'>保存</li>-->
				<!--<li id='reset' ltype='normal'>重置</li>-->
				<li id='getBox' ltype='node' lvalue='1'>i18n_st.text.getBox_n81i</li>
				<li id='getChildNg' ltype='nodeGroup'>i18n_st.text.getChildNg_n81i</li>
				<!-- <li id='openTopology' ltype='node' lvalue='1'>查看告警数据</li> -->
			</ul>
		</div>
  </body>
</html>