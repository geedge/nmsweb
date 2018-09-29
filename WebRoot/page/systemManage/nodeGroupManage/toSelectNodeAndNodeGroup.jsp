<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	response.setHeader("Pragma","No-Cache");
	
	response.setHeader("Cache-Control","No-Cache");
	
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_tsnang.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/dtree/js/dtree_checkbox_multi_choose.js"/>"></script>
		<script type="text/javascript">	
		     
			//点击各节点组触发的事件:dTree
			function onClickNodeGroup(id){
				//点击节点组标题时:若复选框当前选中，则取消选中，若当前未选中，则选中。可以通过点击标题多选
				var isChecked= jQuery("input[type='checkbox'][name='mkid'][value='"+id+"']").attr("checked");
				jQuery("input[type='checkbox'][name='mkid'][value='"+id+"']").attr("checked",!isChecked);
				onClickCheckBox();//同时更新ip列表的显示
				$("#sub").attr('disabled','');
			}
			
			$(function(){
				//获取父页面中选中的监测类别,以及父级页面是哪个(监测设置detecSet和任务nmstask)
				var resu = $(window.parent.document).find("#I3").contents();
				var f = resu.find("#fw").val();
				//var f = resu.document.getElementById("fw").value;
				var type ="";
				var issp ="";
				if(f =="detecSetAdd" || f =="detecSetUpp"){//从监测设置过来才需要下面两个值
					type = resu.find("#checkTypeId").val();
					issp = resu.find("#isSnmpType").val();
					/* type = resu.document.getElementById("checkTypeId").value;
					issp = resu.document.getElementById("isSnmpType").value; */
				}
				var checkedNodeIds = ",${nodeId},";//所选节点id
				$("#nodesTable tr[id!='headTr']").remove();//只留下标题
				<c:forEach var="node" items="${nodeList}"  varStatus="index">//循环选中节点组对应的所有节点
					var nodeGroupName = getNameById('${node.groupId}');//根据节点组id得到节点组name
					var nodeCount = $("#nodesTable tr").length;//获得当前节点记录数
					var nodeId = ",${node.nodeId},";
					var check = "";
					var cla="";
					var dis="";
					var tit="${node.nodeId}";
					var nodeType= "${node.nodeType}";
					var index = '${index.count}';
					if(checkedNodeIds.indexOf(nodeId)!=-1) {
						check = 'checked';
					}
					
					if(type == 7 || type == 6 || issp == 'y'){//可选交换机
						cla="";
						dis="";
					}else{
						if(nodeType!=null && nodeType==0){//服务器/pc
							cla="";
							dis="";
						}else if(nodeType!=null && nodeType==1){//交换机
							if(!(f=='topoManage')){
								cla="alldisabled";
								dis="disabled";
								tit="i18n_tsnang.message.netElement_n81i";
							}
						}
					}
					var sysType ;
					if(${node.nodeSystemType==1}){
						sysType = "Linux";
					}else if(${node.nodeSystemType==2}){
						sysType = "Windows";
					}else{
						sysType = "";
					}
					if(nodeCount%2==0) {
						$("#nodesTable").append("<tr title='"+tit+"'><td class='color_1'>"+
												"<input id='nodeIds' name='nodeCheckBoxName' class='"+cla+"' disabled='"+dis+"' type='checkbox' value='${node.nodeId}' "+check+" />"+index+"</td>"+
												"<td class='color_1'>"+nodeGroupName+"</td>"+
												"<td class='color_1' id='nodeIps'>"+
												"<input type='hidden' id='ip_${node.nodeId}' value='${node.nodeIp}'/>${node.nodeIp}</td>"+
												"<td class='color_1'>"+<c:if test="${node.nodeType=='0'}">'i18n_tsnang.text.server_n81i'</c:if>
																	   <c:if test="${node.nodeType=='1'}">'i18n_tsnang.text.netElement_n81i'</c:if>+
												"</td><td class='color_1'>"+sysType+"</td></tr>");
					}
					if(nodeCount%2!=0) {
						$("#nodesTable").append("<tr title='"+tit+"'><td class='color_3'>"+
												"<input id='nodeIds' name='nodeCheckBoxName' class='"+cla+"' disabled='"+dis+"' type='checkbox' value='${node.nodeId}' "+check+" />"+index+"</td>"+
												"<td class='color_3'>"+nodeGroupName+"</td>"+
												"<td class='color_3' id='nodeIps'>"+
												"<input type='hidden' id='ip_${node.nodeId}' value='${node.nodeIp}'/>${node.nodeIp}</td>"+
												"<td class='color_3'>"+<c:if test="${node.nodeType=='0'}">'i18n_tsnang.text.server_n81i'</c:if>
																	   <c:if test="${node.nodeType=='1'}">'i18n_tsnang.text.netElement_n81i'</c:if>+
												"</td><td class='color_3'>"+sysType+"</td></tr>");
					}
				</c:forEach>
				//若真的无记录，再添加‘没有记录’行
				var nodeCount = $("#nodesTable tr").length;
            	if(nodeCount==1) {
            		$("#nodesTable").append("<tr><td colspan='5' height='35' class='color_6' align='center'>i18n_tsnang.text.noRecord_n81i</td></tr>");
            	}
            	
            	$("#noInDCTable").hide();
				//遍历未包含在分管IP中的节点
            	<c:if test="${fn:length(noInNodeList) > 0}">
            		$("#noInDCTable").show();
	            	<c:forEach var="node1" items="${noInNodeList}">//循环选中节点组对应的所有节点
						var nodeGroupName1 = getNameById('${node1.groupId}');//根据节点组id得到节点组name
						var nodeCount1 = $("#noInDCTable tr").length;//获得当前节点记录数
						var nodeType="";
						<c:if test="${node1.nodeType=='0'}">nodeType ="i18n_tsnang.text.server_n81i";</c:if>
						<c:if test="${node1.nodeType=='1'}">nodeType ="i18n_tsnang.text.netElement_n81i";</c:if>
						var trHtml="";
						var sysType ;
						if(${node.nodeSystemType==1}){
							sysType = "Linux";
						}else if(${node.nodeSystemType==2}){
							sysType = "Windows";
						}else{
							sysType = "";
						}
						if(nodeCount1%2==0) {			
							trHtml +="<tr><td class='color_1'>${node1.nodeIp}</td>"+
										"<td class='color_1'>${node1.nodeName}</td>"+
										"<td class='color_1'>"+nodeGroupName1+"</td>"+
										"<td class='color_1'>"+nodeType+"</td><td class='color_1'>"+sysType+"</td></tr>";
						}
						if(nodeCount1%2!=0) {
							trHtml +="<tr><td class='color_3'>${node1.nodeIp}</td>"+
													"<td class='color_3'>${node1.nodeName}</td>"+
													"<td class='color_3'>"+nodeGroupName1+"</td>"+
													"<td class='color_3'>"+nodeType+"</td><td class='color_3'>"+sysType+"</td></tr>";
						}
						$("#noInDCTable").append(trHtml);
					</c:forEach>
				</c:if>
				
				
				if($("input[id='nodeIds'][name='nodeCheckBoxName'][type='checkbox']:checked").size() > 0){
            		jQuery("input[type='radio'][id='ng1']").trigger('click');
            	}
				
				//如果是从新拓扑配置页面过来根据节点还是节点组隐藏功能
				if(f=='topoManage'){
					var chooseType=resu.find("#chooseType").val();
					if(chooseType!=1){
						$("#changeType").hide();
					}
				}
			});
			
			function setDisabled(){
				$("#nodesTable").find("input[type='checkbox'][name='nodeCheckBoxName']").each(function(){
					$(this).attr('disabled','disabled');
					$(this).attr('checked',false);
				});
				$("#checkAll").attr('disabled','disabled');
				$("#checkAll").attr('checked',false);
				
				$("#checkInvert").attr('disabled','disabled');
				$("#checkInvert").attr('checked',false);
				
				$("#sub").attr('disabled','');
			}
			
			function setNoDisabled(){
				$("#nodesTable").find("input[type='checkbox'][name='nodeCheckBoxName']").each(function(){
					if($(this).attr('class')!='alldisabled'){
						$(this).attr('disabled','');
					}
				});
				$("#checkAll").attr('disabled','');
				$("#checkInvert").attr('disabled','');
				var nn = $("#nodesTable").find("input[type='checkbox'][id!='checkAll'][name='nodeCheckBoxName'][class!='alldisabled']").size();
				$("#sub").attr('disabled','');
			}
			
			//全选节点组，取消所有节点组
			function selectAllAndTriggerClick(checkBox,checkAllName) {
				selectAllCheckBoxByName(checkBox,checkAllName);
				onClickCheckBox();
			}
			
			//全选节点组，取消所有节点组
			function selectAllCheckBoxByName(checkBox,checkAllName) {
				var checks = document.getElementsByTagName("input");
				for(i=0;i<checks.length;i++) {
					if(checks[i].type=='checkbox'&&checks[i].disabled!=true&&checks[i].name==checkAllName) {
				 		checks[i].checked = checkBox.checked;
				 	}
				}
				$("#checkInvert").attr('checked',false);
			}
			
			//节点组反选
			function invertSelect(checkBox,checkAllName) {
				$("input[name='"+checkAllName+"']").not(":disabled").each(function(){
					$(this).attr("checked",!$(this).attr("checked"));
				})
				$("#checkAll").attr('checked',$("input[name='"+checkAllName+"'][checked='true']").length == $("input[name='"+checkAllName+"']").length);
			}
			
			//过滤选择的节点组：只返回最底层的节点组的id，可能是多个，返回后关闭当前窗口
			function selectNodeGroupAndNode(){
				//var resu = window.parent;
				var resu = $(window.parent.document).find("#I3").contents();
				var f = resu.find("#missionName");
				//var f = resu.document.getElementById("missionName");//判断父页面有任务名称字段
				if(f!=null){
					//当前时从任务页面过来 需要添加验证
					if($("#ng1").attr('checked')==true){
						if(!isRigthCheck("nodeCheckBoxName", "remove")){
						 	 alert("i18n_tsnang.message.selectOne_n81i");
						 	 return;
						 }
					}
				}
				var f = resu.find("#fw").val();
				//var f = resu.document.getElementById("fw").value;//从监测页面
				if($("#ng1").attr('checked')==true&&(f =="detecSetAdd" || f =="detecSetUpp")&&$("input[name=nodeCheckBoxName]").length>0&&$("input[name=nodeCheckBoxName]:checked").length==0){
					var flag = true;
					$("#nodesTable tr[title]").each(function(index,item){
						var tit = $(this).attr("title");
						if(isNaN(Number(tit))){// 所有TR的title属性，若有一个为非数字，则是有网元节点
							alert("i18n_tsnang.message.selectOne_n81i");
							flag=false;
							return false;
						}
					});
					if(!flag){
						return;
					}
				}
				if($("#ng0").attr('checked')==true){
				//如果是按节点组的话，必须判断节点组中有无不符合要求的节点
					if($("#nodesTable tr td input").length<=1){
						 alert("i18n_tsnang.message.selectNodeGroup_n81i");
					 	 return;
					}
					if($("#nodesTable tr[title]").length>0){
					    var flag=true;
						$("#nodesTable tr[title]").each(function(){
							var tit = $(this).attr("title");
							if(isNaN(Number(tit))){// 所有TR的title属性，若有一个为非数字，则是有不符合的节点
								alert(tit);
								flag=false;
								return false;
							}
						});
						if(!flag){
							return;
						}
					}
				}
			 	//所选节点组（经过过滤的）id和name
			 	var nodeGroupIdsArray = getBottomNodeGroup();
			 	var nodeGroupIds = nodeGroupIdsArray.join(',');
			 	var nodeGroupNamesArray = getNameStrByArray(nodeGroupIdsArray);
			 	var nodeGroupNames = nodeGroupNamesArray.join(',');
			 		
			 	//所选节点id和name
			 	var nodeIds = getSelectedNodeIds().join();
			 	var nodeIps = getSelectedNodeIps().join();
			 		
				//判断节点ids 和ips的长度
				if(nodeIps.length > 500 || nodeIds.length > 500){
					alert("i18n_tsnang.message.muchNode_n81i");
					return;
				}
					
				//修改为模式窗口-2013-1-24-hyx--
				//var resu = window.parent;
				var resu = $(window.parent.document).find("#I3")[0].contentWindow;
				if('${type}' == "descgroup"){//用于拓扑图配置页面选择源节点组与目标节点组的区分，1：目标节点组
					resu.reciveNodeAndNodeGroup1(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps);
				}else if('${type}' == "topoManage"){//用于新拓扑图配置页面选择
					resu.reciveTopoNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps);
				}else {
					resu.reciveNodeAndNodeGroup(nodeGroupIds,nodeGroupNames,nodeIds,nodeIps);
				}
				//window.close();
				layclose();
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
			}
			
			//获得选中的节点id的数组
			function getSelectedNodeIds() {
				var nodeIdsArray = new Array();
				$("input[type='checkbox'][id='nodeIds']:checked").each(function(k) {
					nodeIdsArray[k] = this.value;
				});
				return nodeIdsArray;
			}
			
			//获得选中的节点ip的数组
			function getSelectedNodeIps() {
				var nodeIpsArray = new Array();
				$("input[type='checkbox'][id='nodeIds']:checked").each(function(k) {
					nodeIpsArray[k] = $("input[id='ip_"+this.value+"']").val();
				});
				return nodeIpsArray;
			}
			
			//过滤得到所选节点组中的最底层id
			function getBottomNodeGroup() {
				var allCheckedIds = $("input[type='checkbox'][name='mkid']:checked");
				for(var i=0;i<allCheckedIds.length;i++) {
					if(allCheckedIds[i].value!='null') {
						var parId = getPid(allCheckedIds[i].value);//得到父id
						while(parId!=0) {
							var index = getIndexOf(allCheckedIds,parId);//父id在数组中的下标
							if(index!=-1) {
								allCheckedIds[index].value = 'null';
							}
							parId = getPid(parId);
						}
					}					
				}		
				
				var bottomNodeGroupIds = new Array;
				var count = 0;
				for(var k=0;k<allCheckedIds.length;k++) {
					if(allCheckedIds[k].value!='null') {
						bottomNodeGroupIds[count] = allCheckedIds[k].value;
						count++;
					}
				}
				return bottomNodeGroupIds;
			}
			
			//得到父id
			function getPid(childId) {
				var tempValue = 'pid'+childId;
				var parId = document.getElementById(tempValue).value;
				return parId;
			}
			
			//根据id数组，获得对应的name数组
			function getNameStrByArray(arr) {
				var tempNameArray = new Array();
				for(i=0;i<arr.length;i++) {
					tempNameArray[i] = getNameById(arr[i]);				
				}
				return tempNameArray;
			}
			
			//根据节点组id得到节点组name
			function getNameById(id) {
				if(id!=null&&id!='undefined') {
					var tempValue = 'name'+id;
					var name = document.getElementById(tempValue).value;
					return name;
				}
			}
			
			//判断value是否在arr数组中，如果在返回在数组中的下标，如果不在返回-1
			function getIndexOf(arr,parId) {
				var index = -1;
				for(var j=0;j<arr.length;j++) {
					if(parId==arr[j].value) {
						index = j;
						break;
					}
				}
				return index;
			}
			
			//选中节点组，右边显示相应的节点 
			function onCheckedCheckBox(groupId){

			}
			//取消选中节点组，右边取消显示相应的节点
			function onCancleCheckBox(groupId){
			
			}
			
			//点击(选中+取消)节点组复选框时执行的内容（右侧节点）:groupId参数没有用到
			function onClickCheckBox(groupId) {
				//获取父页面中选中的监测类别,以及父级页面是哪个(监测设置detecSet和任务nmstask)
				//var resu = window.parent;
				var resu = $(window.parent.document).find("#I3").contents();
				var f = resu.find("#fw").val();
				//var f = resu.document.getElementById("fw").value;
				var type ="";
				var issp ="";
				if(f =="detecSetAdd" || f =="detecSetUpp"){//从监测设置过来才需要下面两个值
					type = resu.find("#checkTypeId").val();
					issp = resu.find("#isSnmpType").val();
					//type = resu.document.getElementById("checkTypeId").value;
					//issp = resu.document.getElementById("isSnmpType").value;
				}
				
				var checkedNodeIds = ","+getSelectedNodeIds().join()+",";//得到之前选中的节点id，当重新选择节点组时，之前选择的节点仍然处于选中状态
				var idsArray = getBottomNodeGroup();//得到选中的最底层的节点组id（去掉非底层的节点组id:非底层指其子孙被选中）
		 		var ids = idsArray.join(',');					
				if(ids!=null && ids!=""){
					jQuery.post("<%=path%>/nodeGroupManage/nodeGroupManage!executeAction.do?action=getNodesByNodeGroupId",{"groupId":ids},
					            function(datas){
					            	$("#nodesTable tr[id!='headTr']").remove();//只留下标题
					            	$("#noInDCTable tr[id!='infoTit']").remove();//只留下标题
					            	//循环删除表中的行（选中节点组对应的节点）
									$.each(datas[0], function(k, da) {
										var index = k+1;
										var nodeGroupName = getNameById(da[2]);
										var nodeCount = $("#nodesTable tr").length;
										var nodeId = ","+da[0]+",";
										var isChecked="";
										var trHtml="";
										var td1="";
										var nodeType="";
										var tit=da[0];//默认title为节点ID
										/*
										if(checkedNodeIds.indexOf(nodeId)!=-1) {
											check = 'checked';
										}
										*/
										if(da[3]==0){
											nodeType ="i18n_tsnang.text.server_n81i";
										}else if(da[3]==1){
											nodeType ="i18n_tsnang.text.netElement_n81i";
										}
										//判断时候可以勾选交换机
										if(f =="addNewTask"){//新增任务--只能选择服务器
											if(da[3]!=null && da[3]==0){//服务器/pc
												td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' checked />"+index;
											}else{//网元
												td1 ="<input id='nodeIds' name='nodeCheckBoxName' class='alldisabled' type='checkbox' disabled='disabled' value='"+da[0]+"' />"+index;
												tit="i18n_tsnang.message.onlyServer_n81i";
											}
										}else if(f =="detecSetAdd"){//监测设置新增--需判断监测类别-nmsclient,ping,snmp可以选择交换机
											if(type == 9){
												if(da[3]!=null && da[3]==0){//服务器/pc
													td1 ="<input id='nodeIds' name='nodeCheckBoxName' class='alldisabled' type='checkbox' disabled='disabled' value='"+da[0]+"'/>"+index;
												}else if(da[3]!=null && da[3]==1 ){//交换机
													td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' checked />"+index;
												}
											}else{
												if(type == 7 || type == 6||issp == 'y'){//可选交换机
													td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' checked />"+index;
												}else{
													if(da[3]!=null && da[3]==0){//服务器/pc
														td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' checked />"+index;
													}else if(da[3]!=null && da[3]==1 ){//交换机
														td1 ="<input id='nodeIds' name='nodeCheckBoxName' class='alldisabled' type='checkbox' disabled='disabled' value='"+da[0]+"'/>"+index;
														tit="i18n_tsnang.message.netElement_n81i";
													}
												}
											}
											
										}else if(f =="detecSetUpp"){//监测设置修改
											if(checkedNodeIds.indexOf(da[0])!=-1) {
												isChecked = 'checked';
											}
											if(type == 7 || type == 6 || issp == 'y'){//可选交换机
												td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' "+isChecked+" />"+index;
											}else{
												if(da[3]!=null && da[3]==0){//服务器/pc
													td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' "+isChecked+" />"+index;
												}else if(da[3]!=null && da[3]==1){//交换机
													td1 ="<input id='nodeIds' name='nodeCheckBoxName' class='alldisabled' type='checkbox' disabled='disabled' value='"+da[0]+"'/>"+index;
													tit="i18n_tsnang.message.netElement_n81i";
												}
											}
										}else if(f =="addSimilarNmstask" ||f =="addConverseSimiTask" || f =="addConverTask"){//新增相似、逆向、相似的逆向(等于修改)
											if(checkedNodeIds.indexOf(da[0])!=-1) {
												isChecked = 'checked';
											}
											if(da[3]!=null && da[3]==0){//服务器/pc
												td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' "+isChecked+" />"+index;
											}else{//交换机
												td1 ="<input id='nodeIds' name='nodeCheckBoxName' class='alldisabled' type='checkbox' disabled='disabled' value='"+da[0]+"' />"+index;
												tit="i18n_tsnang.message.onlyServer_n81i";
											}
										}
										
										if(f=='topoManage'){
											td1 ="<input id='nodeIds' name='nodeCheckBoxName' type='checkbox' value='"+da[0]+"' checked />"+index;
										}
										
										var sysType ;
										if(da[4]==1){
											sysType = "Linux";
										}else if(da[4]==2){
											sysType = "Windows";
										}else{
											sysType = "";
										}
										if(nodeCount%2==0) {
											trHtml += "<tr title='"+tit+"'><td class='color_1'>"+td1+"</td>"+
															"<td class='color_1'>"+nodeGroupName+"</td>"+
															"<td class='color_1' id='nodeIps'>"+
															"<input type='hidden' id='ip_"+da[0]+"' value='"+da[1]+"'/>"+da[1]+"</td>"+
															"<td class='color_1'>"+nodeType+"</td>"+
															"<td class='color_1'>"+sysType+"</td>"+
															"</tr>";
										}else{
											trHtml += "<tr title='"+tit+"'><td class='color_3'>"+td1+"</td>"+
															"<td class='color_3'>"+nodeGroupName+"</td>"+
															"<td class='color_3' id='nodeIps'>"+
															"<input type='hidden' id='ip_"+da[0]+"' value='"+da[1]+"'/>"+da[1]+"</td>"+
															"<td class='color_3'>"+nodeType+"</td>"+
															"<td class='color_3'>"+sysType+"</td>"+
															"</tr>";
										}
										//tr放入table
										$("#nodesTable").append(trHtml);
									});	
									jQuery("input[type='radio'][id='ng0']").trigger('click');
									//若真的无记录，再添加‘没有记录’行
									var nodeCount = $("#nodesTable tr").length;
					            	if(nodeCount==1) {
					            		$("#nodesTable").append("<tr><td colspan='5' height='35' class='color_6' align='center'>i18n_tsnang.message.noRecord_n81i</td></tr>");
					            		$("#checkAll").attr("checked","");
					            	}
					            	if(datas.length > 0){
					            		if(f =="detecSetAdd" || f =="addNewTask"){
											//$("#checkAll").attr("checked","checked");
										}
					            	}
					            	if(datas[1]!=null ){
					            		$("#noInDCTable").show();
					            		//遍历未包含在DC分管IP中的节点
						            	$.each(datas[1], function(k, da) {
											var nodeGroupName = getNameById(da[2]);
											var nodeCount = $("#noInDCTable tr").length;
											var trHtml="";
											var nodeType="";
											
											if(da[3]==0){
												nodeType ="i18n_tsnang.text.server_n81i";
											}else if(da[3]==1){
												nodeType ="i18n_tsnang.text.netElement_n81i";
											}
											var sysType ;
											if(da[4]==1){
												sysType = "Linux";
											}else if(da[4]==2){
												sysType = "Windows";
											}else{
												sysType = "";
											}
											if(nodeCount%2==0) {
												trHtml += "<tr><td class='color_1'>"+da[0]+"</td>"+
																"<td class='color_1'>"+da[1]+"</td>"+
																"<td class='color_1'>"+nodeGroupName+"</td>"+
																"<td class='color_1'>"+nodeType+"</td>"+
																"<td class='color_1'>"+sysType+"</td>"+
																"</tr>";
											}else{
												trHtml += "<tr><td class='color_3'>"+da[0]+"</td>"+
																"<td class='color_3'>"+da[1]+"</td>"+
																"<td class='color_3'>"+nodeGroupName+"</td>"+
																"<td class='color_3'>"+nodeType+"</td>"+
																"<td class='color_3'>"+sysType+"</td>"+
																"</tr>";
											}
											//tr放入table
											$("#noInDCTable").append(trHtml);
										});	
					            	}
					            	
								},
								"json");
				}else {//如果没有选中的节点组
					$("#nodesTable tr[id!='headTr']").remove();//只留下标题
					$("#noInDCTable tr[id!='infoTit']").remove();//只留下标题
					$("#noInDCTable").hide();
					$("#checkAll").attr("checked","");
					$("#nodesTable").append("<tr><td colspan='5' height='35' class='color_6' align='center'>i18n_tsnang.message.noRecord_n81i</td></tr>");
				}
				
			}
			$(function(){
				if(navigator.userAgent.indexOf("MSIE")>0) {  
					$("body").css({"width":"98%"});
				}else{
					$("body").css({"width":"100%"});
				}
			});
			
	function layclose() {
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
		</script>
	</head>
	<body>
		<div class="middle_list">
			 <form action="" name="listForm" id="listForm" method="post" >
				<table border="0" cellpadding="0" cellspacing="0" class="table" >
					<tr>
						<td class="color_8" colspan="2">i18n_tsnang.text.selectNodeGroup_n81i</td>
					</tr>
					<tr>
						<td class="color_1" align="left" width="30%" valign="top" height="500px;" style="padding-left: 12px;">
							<div style="overflow: auto;height: auto;">
											<script type="text/javascript">
												var checkedNodeGroup = ','+'${groupId}'+',';//选中节点组的id
												d = new dTree('d','','','ids');
												var systemName = '${system.systemName}'
												var checkAllName = 'mkid';
												d.add('0','-1','<input type="checkbox" onclick="selectAllAndTriggerClick(this,\'mkid\')"/>'+systemName);
										        <%
										        	List treeList = (List)request.getAttribute("treeList");
										        	List list = MakeTree.getAllResourceList(treeList);
										        	if(list != null && list.size() > 0){
										       		Resource resource = new Resource();
										        		for( int i = 0 ; i < list.size() ; i++ ){
										        			resource = (Resource) list.get(i);        				
										        			%>
										        					var reCode = '<%=resource.getRsCode()%>';
										        					var isChecked = " ";
															 		var nodeGoupId = ','+reCode+',';
															 		if(checkedNodeGroup.indexOf(nodeGoupId)>=0) {//说明当前节点组为选中的节点组
															 			isChecked = 'checked';
															 		}
										        					
										        					d.add(reCode,'<%=resource.getParRsCode()%>','<%=resource.getRsname()%>',isChecked,'javascript:onClickNodeGroup('+reCode+');',reCode);
										        			<%
										        			
										        		}
										        	}
										        %>
												document.write(d);
										</script>
										<c:forEach items="${nodeGroupList}" var="group" varStatus="vs">
											<input type="hidden" id="pid${group.groupId }" name="pid${group.groupId }" value="${group.parentGroupId}" />
											<input type="hidden" id="name${group.groupId }" name="name${group.groupId }" value="${group.groupName}" />
											<input type="hidden" id="leaf${group.groupId }"	name="leaf${group.groupId }" value="${group.leafGroup}" />
										</c:forEach>
							</div>
						</td>
						<td class="color_1" align="center" valign="top" >
							<div style="overflow: auto;height: auto;">
								<span id="changeType">
									<input type="radio" id="ng0" name="anWhat" class="ngstart" value="0" checked="checked" onclick="setDisabled();"/>i18n_tsnang.text.setDisabled_n81i
									<input type="radio" id="ng1" name="anWhat" class="ngstart" value="1" onclick="setNoDisabled();"/>i18n_tsnang.text.setNoDisabled_n81i
								</span>
								
								<table id="nodesTable" border="0" cellpadding="0" cellspacing="0" class="tableTop" align="center" >
									<tr id="headTr">
										<td class="color_top" width="6%" >
											<div style="display: inline-block;text-align: left" >
											<input type="checkbox"  id="checkAll" name="checkAll" onclick="selectAllCheckBoxByName(this,'nodeCheckBoxName')" title="i18n_tsnang.text.selectAll_n81i"/>
											i18n_tsnang.text.index_n81i
										    <br/>
											<input  type="checkbox"  id="checkInvert" name="checkInvert" onclick="invertSelect(this,'nodeCheckBoxName')" title="i18n_tsnang.text.reverse_n81i"/> i18n_tsnang.text.reverse_n81i
											</div>
										</td>
										<td class="color_top" width="7%">
											i18n_tsnang.text.nodeGroup_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.nodeIp_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.nodeType_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.operateSystem_n81i
										</td>
									</tr>
										
									<tr id="endTr">
										<td colspan="5" height="35" class="color_6" align="center">
											i18n_tsnang.text.noRecord_n81i
										</td>
									</tr>
								</table>
								<table id="noInDCTable" border="0" cellpadding="0" cellspacing="0" class="tableTop" align="center">
									<tr id="infoTit">
										<td colspan="4" align="left">i18n_tsnang.message.dcControlIp_n81i：</td>
									</tr>
									<tr id="infoTit">
										<td class="color_top" width="5%">
											i18n_tsnang.message.nodeName_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.nodeIp_n81i
										</td>
										<td class="color_top" width="7%">
											i18n_tsnang.text.nodeGroup_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.nodeType_n81i
										</td>
										<td class="color_top" width="5%">
											i18n_tsnang.text.operateSystem_n81i
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right" class="td_1" >&nbsp;
							<span id="buttons_add">
								<input type="button" class=btn3_mouseout id="sub"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'" 
									onclick="selectNodeGroupAndNode()" value="i18n_tsnang.button.submit_n81i"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="layclose()" value="i18n_tsnang.button.close_n81i"/>
							</span>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
