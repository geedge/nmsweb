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
    <title>i18n_sm.message.title_n81i</title>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.processing.plugin.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ui/jquery-ui.min.js"></script>
	<script src="<%=path %>/js/jquery.topology-2.0.js"></script>
	<script src="<%=path %>/js/jquery.contextmenu.r2.js"></script>
	<link href="<%=path%>/css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css"></link>
	<link href="<%=path%>/css/show/topology.css" rel="stylesheet" type="text/css"></link>
	<script type="text/javascript">
		jQuery(function(){
			$(document).progressDialog.showDialog("i18n_sm.message.loading_n81i...");
		});
	</script>
  </head>
  
  <body oncontextmenu="event.returnValue=false">
    	<div id="border_Div">
			<div id="board"  class="board">
				<!-- 图片修改窗口 -->
				<div id="imageBox" class="imageBox">
					<div id="imgList">
					
					</div>
					<span style="vertical-align:bottom;float: right;"><input type='button' value='i18n_sm.button.ok_n81i' id="apply" /><input type='button' value='i18n_sm.button.cancle_n81i' id="cancel" /></span>
				</div>
				<!-- 右侧菜单列表 -->
				
				<div style="position: absolute; height: 100%; right: 0;">
					<div id="rightMenuFlag"
						style="float: left;width: 20px;text-align: center;">					
						<img src="<%=path%>/images/show/anniu_1.png" border="0" />
					</div> 
					<ul id="rightMenuContent" 
						style="width: 150px; height: 50%;list-style-type: none;margin:0px;display: none;"
						class="menucenter">
					</ul>				
				</div>
				<!-- 操作信息窗口 -->
				<div id="action_info" class="actionInfo">
				</div>
				<input type="hidden" id="gid" value="${groupId }"/>
				<input type="hidden" id="sysNpId" value="${sysPositionId }"/>
				<input id= "del_Npids" type="hidden" value=""/>
				<input id= "del_Nodeids" type="hidden" value=""/>
			</div>
    	</div>
		<script >
			jQuery(function(){
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
			
				//发送请求，载入节点及关联关系
				$('#board').editTopology("<%=path %>/nodePosition/nodePosition.do?action=getIconModules");
				
				//新右键菜单
				$('#board').contextMenu('menu1',{
					onShowMenu: function(e,menu){
						//获取触发点的图标对象
						var $a_obj = $(e.srcElement).closest('A');
						if($a_obj.size()>0){	//存在保存
							$('#board').data('active_obj',$a_obj);
						}
						//事件对象判断
						var $Obj = $(e.srcElement);
						if($a_obj.size()>0 ){//当前对象是图标
							$("li[ltype!='node']",menu).hide();
							var data = $a_obj.data('data');
							
							if(data.nodeType == 'system'){//要是系统先把删除干掉
									$("li[ltype='node'][lvalue='del']",menu).hide();
									$("li[ltype='node'][lvalue='1']",menu).hide();
							}else{
								if(data.id == '0'){//先保存再就行节点组机柜编辑
									$("ul li[ltype!='normal'][lvalue='1']",menu).hide();
								}else if(data.viewType == '1'){//节点组
									//$("li[lvalue]",menu).hide();
									$("li[ltype='node'][lvalue='1']",menu).show();
								}
							}
						}else if($Obj[0].tagName == 'DIV' && $Obj.attr('divType') == 'line'){//线
							//$("ul li[ltype!='line']",menu).hide();
							$("ul[id='menuList']",menu).hide();
						}else{//桌面
							$("ul li[ltype!='normal']",menu).hide();
						}
						
						return menu;
					},
					bindings : {
						save : function(){//保存操作
							if($("#del_Npids").val()!=""){
								var resu = deleteNode("<%=path %>/nodePosition/nodePosition.do?action=deleteNodes",$('#del_Npids').val(),$('#del_Nodeids').val());
								if(resu==true){
									saveNode("<%=path %>/nodePosition/nodePosition.do?action=updateNodes",0);
								}
							}else{
								saveNode("<%=path %>/nodePosition/nodePosition.do?action=updateNodes",0);
							}
						},
						reset : function(){//页面重置
							document.location.reload();
						},
						link : function(){//开始创建关联关系
							$('#board').data('action_flag',true);//事件标志对象——开始
							var $fromNode = $('#board').data('active_obj');
							var nl1 = $fromNode.data('data');
							if(!nl1){alert("i18n_sm.message.data_n81i");return;}
							var node_id1 = $fromNode.data('node_id');
							$("#action_info").html("<input type='button' value='i18n_sm.button.cancle_n81i' id='exitLink'><br/>i18n_sm.message.actionInfo_n81i：<br/>"+ nl1.nodeName).show();
							$("#board A[divType='node']").bind('click',function(){if($('#board').data('action_flag'))addLinkInPage(); else return; });
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
						openTopology : function(){  //打开拓扑页面
							var icon = $('#board').data('active_obj');
							var data=icon.data("data");
							//alert(data.nodeId);
							//$("#gid").value=data.nodeId;
							var url;
							if(data.childNum >0){//有子节点组
								url = "<%=path %>/nodePosition/nodePosition.do?action=getChildNg&gid="+data.nodeId+"&npGroupId="+data.id+"&from=edit";
							}else{
								url = "<%=path %>/nodePosition/nodePosition.do?action=editMap&gid="+data.nodeId+"&npGroupId="+data.id;
							}
							url = encodeURI(url);
							url = encodeURI(url);
							window.location.href=url;
							
						}
					}
				});
				
				//右边菜单
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
				//从桌面拖到菜单事件
				$content.droppable({
				greedy : true,
					drop:function(event,ui){
						var icon=ui.draggable;
						if(icon[0].tagName=='A' || icon[0].tagName=='SPAN'){
							icon.fadeOut(300,function(){
								//创建列表节点并保存信息
								var data=icon.data("data");
								var node_id=icon.data("node_id");
								$content.createLiNode(node_id,data);
								//$("#"+node_id).draggable({
								//	cursorAt : {cursor :"move"},
								//	revert:false
								//});
								//删除桌面展示关系线
								$('#board').find("div[divType='line'][id*='"+node_id+"']").attr('action','delete').hide();
								icon.hide(500,function(){
									icon.remove();
								});
							});
						}else{
						
						}
					}
				});
				
				//从菜单拖到桌面事件
				$('#board').droppable({
					greedy : true,
					drop:function(event,ui){
						//添加桌面展示图标
						var icon=ui.draggable;
						//alert(icon[0].tagName);
						if(icon[0].tagName=='LI' || icon[0].tagName=='SPAN'){
							var node_id = icon.data("node_id");
							$('#board').createIconNode(node_id,icon.data("data"));
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
						}
					}
				})
				
			})
		</script>
		<div id='menu1'style="display: none;">
			<ul id='menuList'>
				<li id='save' ltype='normal'>i18n_sm.menu.save_n81i</li>
				<li id='reset' ltype='normal'>i18n_sm.menu.reset_n81i</li>
				<li id='unLink' ltype='line'>i18n_sm.menu.unLink_n81i</li>
				<li id='link' ltype='node'>i18n_sm.menu.link_n81i</li>
				<!-- <li id='cancel' ltype='node'>取消操作</li> -->
				<li id='unLink' ltype='node' lvalue='del'>i18n_sm.menu.unNode_n81i</li>
				<li id='changeImg' ltype='node'>i18n_sm.menu.changeImg_n81i</li>
				<li id='openTopology' ltype='node' lvalue='1'>i18n_sm.menu.openTopology_n81i</li>
			</ul>
		</div>
  </body>
</html>