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
    <title>i18n_em.message.title_n81i</title>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ui/jquery-ui.min.js"></script>
	<script src="<%=path %>/js/jquery.topology-2.0.js"></script>
	<script src="<%=path %>/js/jquery.contextmenu.r2.js"></script>
	<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"></link>
	<link href="<%=path%>/css/themes/base/jquery.ui.css" rel="stylesheet" type="text/css"></link>
	<link href="<%=path%>/css/show/topology.css" rel="stylesheet" type="text/css"></link>
	
	<script type="text/javascript">
		function clo(){
			var spanSize=$("div[id='iconBoxContent']").find("span").size();
			if(spanSize!=0){//机柜中有节点
				if(confirm("i18n_em.message.saveSets_n81i")){
					//先保存机柜内容再隐藏
					var icon = $('#board').data('active_obj');
					var boxData=icon.data("data");
					var ndId= $("#gid").val();
					saveBoxLine(ndId,boxData,"<%=path %>/nodePosition/nodePosition.do?action=saveBoxLine");
					$("#iconBox").hide();
					$('.td').find("span").remove();
				}else{
					window.location.reload();
				}	
			}else{//没有节点直接关闭
				$("#iconBox").hide();
				$('.td').find("span").remove();
			}
		}
		
		//拓扑图展示用
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
										$("#spanIp").text(node.nodeIp);
										$("#spanName").text(node.nodeName);
										$("#spanUType").text(node.nodeUType+"U");
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
										
										$("#span_info1")
											.css('top',cPointX+'px')
											.css('left',cPointY+'px')
											.show();
									},
									'mouseleave' : function() {
										$("#span_info1").hide();
										$("#spanIp").empty();
										$("#spanName").empty();
										$("#spanUType").empty();
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
							alert("i18n_em.message.spanTable_n81i");
						}
						
			});
			
		}
	</script>
  </head>
  
  <body oncontextmenu="event.returnValue=false">
    	<div id="border_Div">
			<div id="board"  class="board">
				<input id="from" type="hidden" value="${from}"/>
				<c:if test="${from!='show'}"><!--如果从拓扑展示过来 则不显示下面内容  -->
					<!-- 图片修改窗口 -->
					<div id="imageBox" class="imageBox">
						<div id="imgList">
					
						</div>
						<span style="vertical-align:bottom;float: right;"><input type='button' value='i18n_em.button.ok_n81i' id="apply" /><input type='button' value='i18n_em.button.cancle_n81i' id="cancel" /></span>
					</div>
					<div class="findDiv" >
						i18n_em.text.find_n81i：
						<input type="text" id="ispn" name="descinfo" title="i18n_em.message.find_n81i" size="20" />
						<img id="getBoxBtn" src="<c:url value='/images/show/sosuo.png'/>" align="middle" border="0" />
					</div>
					<div id='suggest1' class="boxIconMenu">
							<ul id="boxList" 
							style="width: 150px; height: 50%; list-style-type: none; margin: 0px;"
							class="menucenter">
							</ul>
						</div>
					<!-- 右侧菜单列表 -->
					<div class="liList" id="rightNodeList">
						<div id="rightMenuFlag"
							style="float: left;width: 20px;text-align: center;">					
							<img src="<%=path%>/images/show/anniu_2.png" border="0" />
						</div>
						<ul id="rightMenuContent" 
							style="width: 150px; height: 50%;list-style-type: none;margin:0px;display: none;"
							class="menucenter">
						</ul>				
					</div>
					<!-- 操作信息窗口 -->
					<div id="action_info" class="actionInfo">
					</div>
				</c:if>
				<!-- 悬浮窗口 -->
				<div id="iconBox" class="iconBoxBgc">
					<div id="iconBoxHeader" class="window-header">
						<table border="0" width="100%" align="center">
							<tr>
								<td align="left" width="90%"><span id="boxTitle" style="font-size:10px;color:#000000;"></span></td>
								<td align="right" width="10%">
									<c:if test="${from=='show'}"><!--如果从拓扑展示过来 则不显示下面内容  -->
									 	<img src="<c:url value='/images/logo_2.png'/>" onclick="$('#iconBox').hide();$('.td').find('span').remove();" style="cursor: hand; background-color:#FFFFFF;">
									</c:if>
									<c:if test="${from!='show'}"><!--如果从拓扑展示过来 则不显示下面内容  -->
									 	<img src="<c:url value='/images/logo_2.png'/>" onclick="$('#iconBox').hide();" style="cursor: hand; background-color:#FFFFFF;">
									</c:if>
								</td>
							</tr>
						</table>
						<!-- <span type='close' class='ui-icon ui-icon-close' style="cursor: hand; background-color:#FFFFFF;" onclick="clo();"></span> -->
					</div>
					 <div id="iconBoxContent"  class="iconBoxContent">
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
								<td width="200">
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
				<!-- 节点详细信息 -->
				<div id="span_info1" class="spanInfo">
					<table id="span_info">
						<tr><td>IP：</td><td id="spanIp"></td></tr>
						<tr><td>i18n_em.text.spanName_n81i：</td><td id="spanName"></td></tr>
						<tr><td>i18n_em.text.spanUType_n81i：</td><td id="spanUType"></td></tr>
					</table>
				</div>
				
				<input id= "gid" type="hidden" value="${groupId }"/>
				<input id= "groupNpId" type="hidden" value="${groupNpId }"/>
				<input id= "boxNodeId" type="hidden" value=""/>
			</div>
    </div>
		<script >
			jQuery(function(){
				$('#iconBox').hide();
				$("#suggest1").hide();
				$("#span_info1").hide();
				
				//加载"修改图片" 用图片url
				jQuery.post("<%=path %>/nodePosition/nodePosition.do?action=loadImg",
				{},function(data){
					 	if(data.length>0){
							$.each(data, function(i, imgUrl) {
								var thisSrc =  "<%=path%>"+imgUrl;
								var $icon = $("<img border='0' width = '24' height = '24' onclick='javaScript:mouseclickF()' checkVal='0' onmouseout='javaScript:mouseoutF(this)' onmouseover='javaScript:mouseoverF(this)'/>");
								$icon.attr('src',thisSrc).attr('style','margin: 1px');
								$("#imgList").append($icon);
						    });
						}
						
				});
				
				//节点UI的拖动
				$("#iconBox").draggable( {
					cursorAt : {cursor :"move"},
					revert:false,
					handle:'#iconBoxHeader',
					containment:$("#board")
				});
				$('#getBoxBtn').bind('click',function(){
					$("#boxList").empty();
					var url = "<%=path %>/nodePosition/nodePosition.do?action=getBox&boxIspn="+$('#ispn').val()+"&gid="+$('#groupNpId').val();
					url = encodeURI(url)
					getbox(url);
					
				});
				//发送请求，载入节点及关联关系
				$('#board').editTopology("<%=path %>/nodePosition/nodePosition.do?action=getNodeModules&gid="+$('#gid').val()+"&npGroupId="+$('#groupNpId').val(),1);
				
				//新右键菜单
				$('#board').contextMenu('menu1',{
					onShowMenu: function(e,menu){
						var f = $("#from").val();
						//获取触发点的图标对象
						var $a_obj = $(e.srcElement).closest('A');
						if($a_obj.size()>0){	//存在保存
							$('#board').data('active_obj',$a_obj);
						}
					
						//事件对象判断
						var $Obj = $(e.srcElement);
						if($a_obj.size()>0 ){//当前对象是图标
						
							$("li[ltype!='node']",menu).hide();
							$("li[id='openTopology']",menu).hide();
							var data = $a_obj.data('data');
							var node_id = $a_obj.data('node_id');
							
							if(data.viewType == '1'){//节点组
								if(f=="show"){
									$("ul[id='menuList']",menu).hide();
								}else{
									$("li[lvalue]",menu).hide();
									$("li[id='unLink']",menu).hide();
									if(data.childNum >0){
										$("li[id='openTopology'][lvalue='1']",menu).show();
									}
								}
								
							}else if(data.viewType == '2'){//机柜
								if(f=="show"){
									$("ul li[id!='openBox']",menu).hide();
								}else{
									$("li[id='unLink']",menu).hide();
									$("li[ltype='node'][lvalue='3']",menu).show();
								}
							}
						}else if($Obj[0].tagName == 'DIV' && $Obj.attr('divType') == 'line'){//线
							//$("ul li[ltype!='line']",menu).hide();
							$("ul[id='menuList']",menu).hide();
						}else{//桌面
							if(f=="show"){
								$("ul[id='menuList']",menu).hide();
							}else{
								$("ul li[ltype!='normal']",menu).hide();
							}
						}
						return menu;
					},
					bindings : {
						save : function(){//保存操作
								if($("#iconBox").is(":visible")==true){
									var ndId= $("#gid").val();
									var boxNodeId= $("#boxNodeId").val();
									var resu = saveBoxLine(ndId,boxNodeId,"<%=path %>/nodePosition/nodePosition.do?action=saveBoxLine");
									//$("#iconBox").hide();
									//$('.td').find("span").remove();	
									if(resu==true){
										saveNode("<%=path %>/nodePosition/nodePosition.do?action=updateNodes",1);
									}
								}else{
									saveNode("<%=path %>/nodePosition/nodePosition.do?action=updateNodes",1);
								}
							
						},
						reset : function(){//页面重置
							document.location.reload();
						},
						link : function(){//开始创建关联关系
							$('#board').data('action_flag',true);//事件标志对象——开始
							var $fromNode = $('#board').data('active_obj');
							var nl1 = $fromNode.data('data');
							
							if(!nl1){alert("i18n_em.message.board_n81i");return;}
							
							if(nl1.nodeType=="nodeBox"){
								$("#action_info").html("<input type='button' value='i18n_em.button.cancle_n81i' id='exitLink'><br/>i18n_em.message.nodeBox_n81i：<br/>"+ nl1.ispn).show();
							}else{
								$("#action_info").html("<input type='button' value='i18n_em.button.cancle_n81i' id='exitLink'><br/>i18n_em.message.nodeBox_n81i：<br/>"+ nl1.nodeName).show();
							}
							
							$("#board A[divType='node']").bind('click',function(){
								if($('#board').data('action_flag')){
									addLinkInPage();
								}else{
									return;
								} 
							});
							
							$("#exitLink").live('click',function(){
								$('#board').data('action_flag',false);//事件标志对象——结束
								$("#action_info").hide();
							});
						},
						//cancel : function(){//取消关联
						//	$('#board').data('action_flag',false);//事件标志对象——结束
						//	$("#action_info").hide();
						//},
						unLink : function(){//删除关联关系或节点
							//var nodesSize = $("a[divType='node'][active='1']").size();
							//var lineSize = $("div[divType='line'][active='1'][id*='_x_']").size();
							deleteNodesInPage(0);
							//deleteLinesInPage(0);
						},
						changeImg : function(){//修改图标、图片
							$("#imageBox").show(function(){
								var $icon = $('#board').data('active_obj');
								var nl = $icon.data('data');
								var nodePosition ={top: nl.positionY+70,left: nl.positionX+70};
								$(this).css('top',nodePosition.top+'px').css('left',nodePosition.left+'px');
							}).find("#apply").click(function(){
								var $icon = $('#board').data('active_obj');
								var nsrc = $("#imageBox img[checkVal='1']").attr('src');
								$icon.find('img').attr("src",nsrc);
								var nl = $icon.data('data');
								nl.imageUrl = nsrc;
								$icon.data('data',nl);
								$("#imageBox").hide();
						 	});
						 	$("#imageBox #cancel").click(function(){
								$("#imageBox").hide();
						 	});
						},
						openBox : function(){		//打开机柜
							var ff = $("#from").val();
							if(ff=="show"){
								var $icon = $('#board').data('active_obj');
								var nl = $icon.data('data');
								$("#iconBox").find('#boxTitle').text("i18n_em.text.ispn_n81i："+nl.ispn);
								qry(nl.nodeId);
							}else{
								if($("#iconBox").is(":visible")==true){//机柜打开着，先保存
									alert("i18n_em.message.iconBox_n81i");
									return;
								}else{
									//先清空
									$('.td').find("span").remove();
									$("#boxNodeId").empty();//清空保存box nodeId 的隐藏域
									var icon = $('#board').data('active_obj');
									var data=icon.data("data");
									$("#boxNodeId").val(data.nodeId);//保存box nodeId
									openBoxqRequest(data,"<%=path %>/nodePosition/nodePosition.do?action=initnodeBox&gId="+$('#gid').val()+"&boxId="+data.nodeId+"&pageName="+data.nodeName);
									$("#boxTitle").text("i18n_em.text.ispn_n81i："+data.ispn+"             42U");
									$("#iconBox").show(function(){
										$("#iconBox").css('top','0px');
									});
								}
							}
						},
						//打开子节点组
						openTopology : function(){
							var icon = $('#board').data('active_obj');
							var data=icon.data("data");
							//alert(data.nodeId);
							//$("#gid").value=data.nodeId;
							var url = "<%=path %>/nodePosition/nodePosition.do?action=editMap&gid="+data.nodeId+"&npGroupId="+data.id;
							url = encodeURI(url);
							url = encodeURI(url);
							window.location.href=url;
						}
					}
				});
				
				
				//右边菜单 UL
				var $content=$("#rightMenuContent");
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
				//从菜单拖到桌面事件(只能是机柜才可以)  ul
				$content.droppable({
				greedy : true,
					drop:function(event,ui){
					//alert("UI拖拽");
						var icon=ui.draggable;
						//alert(icon[0].tagName);
						if(icon[0].tagName=='A' || icon[0].tagName=='SPAN'){
							icon.fadeOut(300,function(){
								//创建列表节点并保存信息
								var data=icon.data("data");
								var node_id=icon.data("node_id");
								if(data.tableName=='node_table'){
									$content.createLiNode(node_id,data);
									//删除格子
									delLattNode(data,"<%=path %>/nodePosition/nodePosition.do?action=deleteLatt");
									icon.hide(500,function(){
										icon.remove();
									});
									//隐藏节点信息div
									if(!$("#span_info1").is(":hidden")){
										$("#span_info1").hide();
										$("#spanIp").empty();
										$("#spanName").empty();
										$("#spanUType").empty();
									}
								}else{
									alert("i18n_em.message.dragDisable_n81i");
									window.localtion.reload();
								}	
							});
						}
					}
				});
				
				//右边菜单 UL
				var $boxList=$("#boxList");
				//从菜单拖到桌面事件(只能是机柜才可以)  ul
				$boxList.droppable({
				greedy : true,
					drop:function(event,ui){
					//alert("boxUL拖拽");
						var icon=ui.draggable;
						//alert(icon[0].tagName);
						if(icon[0].tagName=='A' || icon[0].tagName=='SPAN' ||icon[0].tagName=='LI'){
							icon.fadeOut(300,function(){
								//创建列表节点并保存信息
								var data=icon.data("data");
								var node_id=icon.data("node_id");
								if(data.tableName=='node_box_table'){
									$boxList.createLiNodeBox(node_id,data);
									//删除桌面展示关系线
									//$('#board').find("div[divType='line'][id*='"+node_id+"']").attr('action','delete').hide();
									icon.hide(500,function(){
										icon.remove();
									});
								}else if(data.tableName=='node_table'){
									icon.fadeOut(function() {
										$content.createLiNode(node_id,data);
									});
								}else{
									$('#board').createIconNode(node_id,data,0);
									icon.hide(500,function(){
										icon.remove();
									});
								}
							});
						}
					}
				});
				
				
				
				//桌面拖拽事件
				$('#board').droppable({
					greedy : true,
					drop:function(event,ui){
					//alert("桌面拖拽");
						//添加桌面展示图标
						var icon=ui.draggable;
					
						if(icon[0].tagName=='LI' || icon[0].tagName=='SPAN'){
							var node = icon.data("data");
							var node_id = icon.data("node_id");
							if(node.tableName=='node_box_table'){
								var max=$("a[divType='node'][action='update'][flagType='box']").size();
								var i;
								var checkFlag = true;
								for(i=0;i<max;i++){
									var $node = $("a[divType='node'][action='update'][flagType='box']:eq("+i+")");	
									var nl0 = $node.data('data');
									if(nl0.nodeId==node.nodeId){
										checkFlag = false;
										break;
									}
								}
								
								if(checkFlag == true){// 如果桌面上没有此机柜 则创建
									$('#board').createIconNode(node_id,node,0);
									$("a[divType='node'][id='"+node_id+"']")
									.attr('action','update')
									.css('top',(event.clientY>10 ? (event.clientY-10) : 1)+'px')
									.css('left',(event.clientX>10 ? (event.clientX-10) : 1)+'px');
									
									$("a[divType='node'][id='"+node_id+"']").bind('move',function(){
										$(this).attr('action','update').resetLine();
									});
									window.setTimeout(function(){$("a[divType='node'][id='"+node_id+"']").trigger('move')},100);
									//删除列表节点并保存信息
									icon.hide(500,function(){
										icon.remove();
									});
								}else{
									alert("i18n_em.message.boxExists_n81i");
								}
								$("#suggest1").hide(800);
							}else if(node.tableName=='node_table'){
								icon.fadeOut(function() {
									$content.createLiNode(node_id,node);
								});
							}else{
								alert("i18n_em.message.nodeTable_n81i");
							}
								
						}
					}
				})
				
				$(".td").droppable({
					hoverClass :'tdBackColor',
					greedy : true,
					drop:function(event,ui){
							//alert("机柜拖拽");
								//添加桌面展示图标
						var $aa = $(this);
						//alert($aa[0].outerHTML);
						var icon=ui.draggable;
						
						var node = icon.data("data");
						var node_id = icon.data("node_id");
						//alert(node.nodeType);
						var uType = node.nodeUType;// u位
						var dId = parseInt($aa.attr("id"));//拖放的td 的 id
						
						if(node.nodeType=="nodeBox" && icon[0].tagName=='LI'){
							alert("i18n_em.message.dragBoxDisable_n81i");
							window.location.reload();
						}
						if($aa.context.innerHTML.indexOf("<SPAN")>0){
							var draTdId = icon.parent().attr("id");
							var droTdId = $aa.attr("id");
							if(draTdId==droTdId){//判断是否为拖拽和拖放为同一个格子内的节点
								icon.fadeOut(function() {
									$aa.createSpanNode(node_id,node);
								});
							}else{
								alert("i18n_em.message.dragNodeDisable_n81i");
								icon.fadeOut(function() {
									$content.createLiNode(node_id,node);
								});
							}
							return;
						}else{
							if(icon[0].tagName=='LI'){
									//var uType = node.nodeUType;// u位
									//var dId = parseInt(aa.attr("id"));//拖放的td 的 id
									if(uType+dId-1>42){
										alert("i18n_em.message.tooBigToBox_n81i");
										icon.fadeOut(function() {
											$content.createLiNode(node_id,node);
										});
									}else{
										var j;
										var delTd = new Array();
										var isdro = true;
										for(j=1;j<uType;j++){
											var thisTd = dId + j;
											var sp = $("#"+thisTd);
											if(sp[0].innerHTML.indexOf("<SPAN")>0){
												isdro = false;
												break;
											}else{
												delTd.push(thisTd);
												continue;
											}
										}
										if(isdro){
											$aa.createSpanNode(node_id,node);
											
											//删除站位置的行
											$.each(delTd, function(k, da) {
										        //$("#"+da).parent().remove();
										        $("#"+da).parent().hide();
						   					});
						   					
						   					icon.hide(500,function(){
												icon.remove();
											});
						   					
											//判断列表中节点的物理ID，如果和拖拽到机柜的节点物理ID相等，则将其从列表中干掉
											$("#rightMenuContent > li").each(function(){
												var no = $(this).data("data");
												var no_id = $(this).data("node_id");
												
												if(no.seqId==node.seqId){
													$(this).hide(500,function(){
														$(this).remove();
													});
												}
											});
										}else{
											alert("i18n_em.message.tooBigToBox1_n81i");
											icon.fadeOut(function() {
												$content.createLiNode(node_id,node);
											});
										}
									
									}
					
							}else if(icon[0].tagName=='SPAN'){//从一个格子拖到另外的格子
								var tId = parseInt(icon.parent().attr('id'));//开始拖拽时所在td 的 id
								var $fromTd = $(icon.parent());//开始拖拽时所在td
								if(uType+dId-1>42){
									alert("节点厚度过大，机柜此U位无法放下此节点");
									icon.fadeOut(function() {
										$fromTd.createSpanNode(node_id,node);
									});
								}else{
									var c;
									var delTd = new Array();
									var isdro = true;
									for(c=1;c<uType;c++){
										var thisTd = dId + c;
										var sp = $("#"+thisTd);
										if(sp[0].innerHTML.indexOf("<SPAN")>0){
											isdro = false;
											break;
										}else{
											delTd.push(thisTd);
											continue;
										}
									}
									if(isdro){
										//alert("icon:"+icon[0].outerHTML);
										$aa.createSpanNode(node_id,node);
										icon.fadeOut(500,function(){
											icon.remove();
										});
										//删除站位置的行
										$.each(delTd, function(k, da) {
									      //$("#"+da).parent().remove();
									      	$("#"+da).parent().hide();
						   				});
						   				
						   				//创建删掉的行
						   				//var createTd = new Array();
										var cc;
										for(cc=1;cc<uType;cc++){
											var cTd = tId + cc;
											//createTd.push(cTd);
											$("#"+cTd).parent().removeAttr("style");
										}
						   				//$.each(createTd, function(g, g) {
						   				//var $tr = "<tr><td id='"+g+"' class='td ui-droppable'>"+g+"</td></tr>";
									    //   $($("#"+tId).parent()).after($tr);
									    //   tId++;
						   				//});
						   				
										//alert($("#spanTable")[0].outerHTML);
									}else{
										alert("i18n_em.message.tooBigToBox1_n81i");
										icon.fadeOut(function() {
											$fromTd.createSpanNode(node_id,node);
										});
									}
								
								}
							
							}
						}
					}
				})	
			})
			
			
		</script>
		<div id='menu1'style="display: none;">
			<ul id='menuList'>
				<li id='save' ltype='normal'>i18n_em.menu.save_n81i</li>
				<li id='reset' ltype='normal'>i18n_em.menu.reset_n81i</li>
				<!-- <li id='unLink' ltype='line'>删除关联</li> -->
				<li id='link' ltype='node'>i18n_em.menu.link_n81i</li>
				<!-- <li id='cancel' ltype='node'>取消操作</li> -->
				<li id='unLink' ltype='node'>i18n_em.menu.unLink_n81i</li>
				<li id='changeImg' ltype='node'>i18n_em.menu.changeImg_n81i</li>
				<li id='openBox' ltype='node' lvalue='3'>i18n_em.menu.openBox_n81i</li>
				<li id='openTopology' ltype='node' lvalue='1'>i18n_em.menu.openTopology_n81i</li>
			</ul>
		</div>
  </body>
</html>