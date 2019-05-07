<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="nis.nms.core.*"%>
<%@include file="/common/taglib.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>i18n_nginfo.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/MzTreeView10.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/dtree/js/dtree_checkbox_expand.js"/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script type="text/javascript">		
			 var msg = '${MSG}';
		     if(msg=='1'){
				alert("i18n_nginfo.message.success_n81i");
			 }else if(msg=='2'){
				alert("i18n_nginfo.message.faild_n81i");
			 }	  
			
   			 function EI(t) {return document.getElementById(t);}
   			 var listvalue = new Array();
		 	 <c:if test="${nodeGroupList ne null}">
				<c:forEach var="item" items="${nodeGroupList}" >
					listvalue['${item.groupId}']="${item.groupId};${item.groupName};${item.groupLevel};${item.parentGroupId};${item.groupType};${item.systemIdName};${item.isValid};${item.viewLevel};${item.groupDesc};${item.createUsergroupId};${item.systemId}";	
					//0:id,1:name,2:组级别,3:pid,4:groupType组类型,5:systemIdName业务系统名称,6:isValid是否有效,7:viewLevel查看权限,8:groupDesc组描述,9:createUsergroupId用户组ID（查看权限时选择组的id）,10:systemId业务系统id
				</c:forEach>
			 </c:if>
			/*
			节点组标题显示逻辑：
				1.进入节点组管理页面、点击根节点：显示‘新增节点组信息’
				2.点击新增子节点组按钮：显示‘新增子节点组信息’
				2.点击节点组、复选框：显示‘节点组信息’
				3.点击修改按钮：显示‘修改节点组信息’
			*/			
			
			/*
			操作显示逻辑：
				1.点节点组和复选框：显示所有的操作（新增节点组、修改、节点管理、下线、上线）
				2.点修改和新增子节点组：隐藏所有操作（新增节点组、修改、节点管理、下线、上线）
				3.点根节点：只显示上线、下线，隐藏新增节点组、修改、节点管理
				4.点全选框：只用于全选和取消全选，与操作无关
			*/
			//显示新增节点组、修改、节点管理、下线、上线
			function showAllOperation() {
				//需要显示最外层的div及input
				$("div[id='buttons_oneRecordOperation']").show();//点击节点组标题时，显示新增子节点组和修改按钮
				$("div[id='buttons_oneRecordOperation'] input").removeAttr('disabled');//使得新增子节点组和修改按钮为可用按钮
				$("div[id='buttons_oneRecordOperation'] input").show();//使得新增子节点组和修改按钮为可用按钮
			}
			
			//隐藏新增节点组、修改、节点管理、下线、上线
			function hideAllOperation() {
				//只需要隐藏最外层
				$("div[id='buttons_oneRecordOperation']").hide();//隐藏修改和新增子节点组按钮
			}
			
			//显示对多条记录的操作（上线、下线），隐藏单条记录的操作（新增子节点组、修改、节点管理）
			function showManyRecordOperation() {
				//只显示一部分时，需要先显示最外层的div，再隐藏不需要显示的
				$("div[id='buttons_oneRecordOperation']").show();//点击节点组标题时，显示新增子节点组和修改按钮
				
				$("input[id='button_addSub']").hide();//点击系统标题时，隐藏新增子节点组和修改按钮
				$("input[id='button_update']").hide();//点击系统标题时，隐藏新增子节点组和修改按钮
				$("input[id='button_mngNode']").hide();//点击系统标题时，隐藏新增子节点组和修改按钮
			}
		     
			//点击各节点触发的事件:dTree
			function onClickNodeGroup(id){
				//alert("in check title");
				//$("tr[id=quanxian]").hide();//隐藏查看权限
				//EI("pid").value=values[0];//由于id是按升序派力的，所以[0]是id最小的元素，点击一个节点，新建子节点的时候，被点击的节点就是父节点
				torepair(listvalue[id]);
				//点击节点组标题时，同时勾选对应的复选框，但是同时只能有一个复选框被选中，可以通过点击复选框实现多选
				jQuery("input[type='checkbox'][name='ids'][value='"+id+"']").attr("checked","true");
				jQuery("input[type='checkbox'][name='ids'][value!='"+id+"']").removeAttr("checked");
				$("#isCheckW").val('0');//当点击节点组文字时，将隐藏域的值设为0;
				//显示新增子节点组和修改按钮
				showAllOperation();
				$("#operatTitle").html('<strong>节点组信息</strong>');
				$("#Ich").attr("src","<c:url value='/nodeGroupManage/nodeManage.do?action=queryChild'/>&nodeGroupId="+$("#nodeGroupId").val());
				//document.frames("ich").location.reload();
			}
			
			//选中复选框事件
			function onCheckedCheckBox(id) {
				//alert("in check checkBox");
				torepair(listvalue[id]);
				$("#isCheckW").val('');
				//显示新增子节点组和修改按钮
				showAllOperation();
				$("#operatTitle").html('<strong>i18n_nginfo.message.groupInfo_n81i</strong>');
			}
			
			//显示详细信息:0:id,1:name,2:组级别,3:pid,4:groupType组类型,5:systemIdName业务系统名称,6:isValid是否有效,7:viewLevel查看权限,8:groupDesc组描述,9:createUsergroupId用户组ID（查看权限时选择组的id）,10:systemId业务系统id
			function torepair(txt){
				$("#groupName").next().html("*");
				<c:if test="${ADMFlag eq true}">
					$("#systemId").next().html("*");
				</c:if>
				var arr=txt.split(";");
				$("#nodeGroupId").val(arr[0]);//节点id
				$("#groupName").val(arr[1]);//节点名称
				$("#groupLevel").val(arr[2]);//组级别
				$("#pid").val(arr[3]);//节点父id
				
				$("input[type='radio'][id='groupType']").removeAttr('disabled');
				$("input[type='radio'][id='groupType'][value='"+(arr[4] == '' || arr[4] ==0 ? 0 : arr[4])+"']").trigger('click');//组类型		
				$("input[type='radio'][id='groupType']").attr('disabled','disabled');	
				
				//如果是admin登录，业务系统则是下拉列表
				<c:if test="${ADMFlag eq true}" >
					$("#systemId").removeAttr('disabled');
					$("#systemId option[value='"+arr[10]+"']").attr('selected','true');
					$("#systemId").attr('disabled','disabled');
				</c:if>
				//如果是非admin登录，业务系统则是input
				<c:if test="${ADMFlag eq false}" >
					$("#systemIdName").val(arr[5]);//业务系统名称
					$("#systemId").val(arr[10]);//业务系统id
				</c:if>
				
				$("input[type='radio'][id='isValid']").removeAttr('disabled');
				$("input[type='radio'][id='isValid'][value='"+(arr[6] == '' || arr[6] ==1 ? 1 : arr[6])+"']").trigger('click');//是否有效		
				$("input[type='radio'][id='isValid']").attr('disabled','disabled');	
				
				//$("input[type='radio'][name='nodeGroup.viewLevel']").removeAttr('disabled');
				//$("input[type='radio'][name='nodeGroup.viewLevel'][value='"+(arr[7] == '' || arr[7] ==1 ? 1 : arr[7])+"']").trigger('click');//查看权限
				//$("input[type='radio'][name='nodeGroup.viewLevel']").attr('disabled','disabled');		
				
				$("#groupDesc").val(arr[8]);//组描述
				
				//$("[id='usergroupId']").removeAttr('disabled');
				//$("#usergroupId option[value='"+arr[9]+"']").attr('selected','true');//查看权限为组时，组的名称
				//$("[id='usergroupId']").attr('disabled','disabled');
				$("#ngid").val(arr[0]);
				cancelForm();
				
				//***配置向导过来的传参***
				if('${type}' == "config"){
					var nodeGroupId = $("#nodeGroupId").val();
		 			var yxbz='yxbz'+nodeGroupId;
				    var isValid = document.getElementById(yxbz).value;
					window.parent.setParameter(nodeGroupId,isValid);
				}
				//***配置向导过来的传参***
			}
			
			function activeForm(){
				$("#nodeGroupForm input").removeAttr('disabled');
				$("#nodeGroupForm textarea").removeAttr('disabled');
				$("#nodeGroupForm select").removeAttr('disabled');
			}
			
			function  goBack(){
				document.nodeGroupForm.action="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo";
				document.nodeGroupForm.submit();
			}
			
			$(function(){
				if("true" == "${showStopNGroup }") {
					$("#chkShowStopNGroup").attr("checked", true);
				}
			});
			function query() {
				$("input[name='showStopNGroup']").val($("#chkShowStopNGroup").is(":checked")); // 设置是否显示下线节点组
				document.nodeGroupForm.action="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=queryNodeGroupInfo";
				document.nodeGroupForm.submit();
			}
			
			//设置业务系统信息：id、name
			function setSystemInfo() {
				//如果是admin登录，业务系统则是下拉列表，admin登录时没有当前业务系统
				<c:if test="${ADMFlag eq true}" >
					//$("#systemId option[value='${system.systemId}']").attr('selected','true');
				</c:if>
				//如果是非admin登录，业务系统则是input
				<c:if test="${ADMFlag eq false}" >
					$("#systemIdName").val('${system.systemName}');//业务系统名称
					$("#systemId").val('${system.systemId}');//业务系统id
					$("#systemIdName").attr('disabled','disabled');
				</c:if>
			}
			
			//取消
			function cancelForm(){
				$("#nodeGroupForm input").attr('disabled','disabled');
				$("#nodeGroupForm textarea").attr('disabled','disabled');
				$("#nodeGroupForm select").attr('disabled','disabled');
				$("div[id^=buttons]").hide();
			}
			
			//新增重置
			function reSetForm(){
				document.nodeGroupForm.reset();
			}
			
			//修改重置
			function reSetFormForUp(){
				var id = $("#ngid").val();
				onClickNodeGroup(id);
				updateNodeGroup();
			}
			//修改节点组
			function updateNodeGroup(){
				if($("#nodeGroupId").val()==""){
					alert("i18n_nginfo.message.nodeGroupId_n81i");
					return ;
				}
				//激活表单，业务系统除外
				//activeForm();
				$("#nodeGroupForm input").removeAttr('disabled');
				$("#nodeGroupForm textarea").removeAttr('disabled');
				
				var pid = $("#pid").val();//节点父id
				if(pid!=0) {//修改子节点组时
					//根据pid，获得父节点组的有效性
					yxbz='yxbz'+pid;
					var isValid = document.getElementById(yxbz).value;
					if(isValid ==0) {//父节点组无效，则子节点组不可改变有效性,但是要可用，如果设置为disabled就无法传递给后台了，现在有效性不会显示在页面上，所以不用下面的语句
						//$("input[id='isValid']").attr('disabled','disabled');	
					}
				}
				
				setSystemInfo();//20121206 hyx 修改节点组时，业务系统不可以修改（非超级管理员，在myconfig.properties里配置的common.admin.mark），超级管理员登录后，修改节点组时，业务系统可以修改
				hideAllOperation();//隐藏新增子节点组、修改、节点管理、上线、下线按钮
				$("#buttons_add").hide();
				$("#buttons_update").show();
				$("#operatTitle").html('<strong>i18n_nginfo.message.editGroupInfo_n81i</strong>');
				//jQuery("tr[id=quanxian]").show();
			}
			
			//一级节点组添加，清空所有信息，只生成pid=0 点击系统名称
			function addMainNodeGroup(){
				//点击根节点标题时，取消所有复选框的勾选（包括全选框）
				jQuery("input[type='checkbox'][name='ids']").removeAttr("checked");
				jQuery("input[type='checkbox'][name='chkkAll']").removeAttr("checked");//取消全选框
				
				//$("tr[id=quanxian]").hide();
				$("#nodeGroupForm")[0].reset();//清空部门信息
				$("#nodeGroupForm>#pid").val(0);				
				$("#groupLevel").val(1);//组级别
				activeForm();				
				setSystemInfo();//设置业务系统信息：id、name
				//jQuery("input[type=radio][id=viewLevel1]").trigger('click');//隐藏用户组信息	
				
				//点击系统标题时，只显示上线和下线按钮，隐藏新增子节点组、修改和节点管理
				showManyRecordOperation();
				
				$("#buttons_update").hide();
				$("#buttons_add").show();
				$("#operatTitle").html('<strong>i18n_nginfo.message.addGroupInfo_n81i</strong>');
				$("#Ich").attr("src","<c:url value='/nodeGroupManage/nodeManage.do?action=queryChild'/>");
			}
			//新增子节点组,清空所有信息，生成pid、组级别、是否生效,
			function addSubNodeGroup(){
		        var pid = $("#nodeGroupForm>#nodeGroupId").val();
				if(pid == ""){
					alert("i18n_nginfo.message.selectParent_n81i");
					return;
				}	
				var parentSystemId = $("#systemId").val();
				var groupLevel = $("#groupLevel").val();//组级别		
				var isValid = $("input[id='isValid']:checked").val();//是否有效
				$("#nodeGroupForm")[0].reset();//清空部门信息
				$("#nodeGroupForm>#pid").val(pid)	;//把当前节点当做父节点						
				$("#groupLevel").val(Number(groupLevel)+1);//组级别	
				
				//得先激活，再赋值，再禁用			
				activeForm();	
				$("input[type='radio'][id='isValid'][value='"+(isValid == '' || isValid ==1 ? 1 : isValid)+"']").trigger('click');//是否有效	
				if(isValid ==0) {//新增子节点组时，如果父节点组无效，则子节点组无效且不可变，如果父节点组有效，则子节点组默认有效，但可以改变有效性--现在有效性不在jsp页面显示了
					//$("input[id='isValid']").attr('disabled','disabled');	
				}
				setSystemInfo();//设置业务系统信息：id、name
				//jQuery("input[type=radio][id=viewLevel1]").trigger('click');//隐藏用户组信息	
				if(!$("#systemId").val()) {
					$("#systemId").val(parentSystemId);
					$("#systemId").attr("disabled", "disabled");
				}
				hideAllOperation();//隐藏新增子节点组、修改、节点管理、上线、下线按钮
				
				$("#buttons_update").hide();
				$("#buttons_add").show();
				$("#operatTitle").html('<strong>i18n_nginfo.message.addSubNode_n81i</strong>');
			}
			
			//表单非空等验证
			function checkForm() {
			    //非空校验
			    $("#groupName").val($.trim($("#groupName").val()));//去空格
			    $("#systemId").val($.trim($("#systemId").val()));		
			    //$("#usergroupId").val($.trim($("#usergroupId").val()));	
			    
				if(!$id('groupName','','i18n_nginfo.text.addSubNode_n81i')) {
					$("#groupName").focus();
					return false;
				}
				
				if(containSpecial($("#groupName").val())){
		    		$("#groupName").next().html("i18n_nginfo.message.inputGroupName_n81i");
		    		return false;
		    	}
				
				<c:if test="${ADMFlag eq true}" >
					if(!$id('systemId','xz','i18n_nginfo.text.systemId_n81i')) {
						$("#systemId").focus();
						return false;
					}
				</c:if>
				
				/*
				if(containSpecial($("#groupDesc").val())){
		    		alert("组描述存在特殊字符，请重新输入");
		    		$("#groupDesc").val('');
		    		return false;
		    	}
				*/
				/*if(jQuery("#viewLevel2").attr('checked')==true){
	    				if($("#usergroupId option").length<=1){
			    			alert('您不属于任一用户组，无权限修改该类节点组！');
			    			return false;
			    		}else if($("#usergroupId").val()==''){
			    			alert('请选择用户组！');
			    			$("#usergroupId").focus();
			    			return false;
			    		}else if(!$("#groupName").checkByteLength(64,"组名称")) {
							$("#usergroupId").focus();
							return false;
						}
	    		}*/
				return true;
				
			}
			
			//修改提交
			function commitUpdate(){
				if(checkForm()) {

					var grpDesc = $("#groupDesc").val();
					if (grpDesc && grpDesc.indexOf('"') != -1) {
						$("#groupDesc").val(grpDesc.replace(/\"/g, "\\\""));
					}
					//提交表单
					$("#nodeGroupForm select").removeAttr('disabled');
			    	var actionurl = "<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=updateNodeGroup";
					document.forms.nodeGroupForm.action = actionurl;
					document.forms.nodeGroupForm.submit();
					document.forms.nodeGroupForm.action="";
				}						    
			}
			
			//新增提交
			function commitAdd(){
				if(checkForm()) {
					$("input[id='isValid']").removeAttr('disabled');
					$("#nodeGroupForm select").removeAttr('disabled');
					document.nodeGroupForm.action="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=addNodeGroup";
					document.nodeGroupForm.submit();	
				}
			}
			
			//停用
			function stopNodeGroup() {
				if(!isRigthCheck("ids", "remove")){
			 		alert("i18n_nginfo.message.startNodeGroup1_n81i");
			 	}else{//0是失效，1是生效
			 		if(isOperation("ids", 0)){//当前状态是0，不能停用操作
						alert('i18n_nginfo.message.startNodeGroup2_n81i');
					}else{
					 	document.listForm.action ="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=stopNodeGroup";
						document.listForm.submit();
					}
				}
			}
			
			//启用
			function startNodeGroup() {
				 if(!isRigthCheck("ids", "remove")){
			 		 alert("i18n_nginfo.message.startNodeGroup1_n81i");
			 	 }else{//0是失效，1是生效
			 		 if(isOperation("ids", 1)){//当前状态是1，不能启用操作
						alert('i18n_nginfo.message.startNodeGroup2_n81i');
					 }else if(!isRightValid("ids")) {//判断所选节点组中是否有其父节点组为无效的，且没选中父节点组的节点
					 	alert('i18n_nginfo.message.startNodeGroup3_n81i');
					 }else {
					 	if($("#isCheckW").val()=='0'){
					 		var submit = function (v, h, f) {
							    if (v == 'yes') {
							        document.listForm.action ="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=startNodeGroup&isStartSubNodeGroup=1";
							 		document.listForm.submit();
							    }
							    if (v == 'no') {
							        document.listForm.action ="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=startNodeGroup&isStartSubNodeGroup=0";
							 		document.listForm.submit();
							    }
							    if (v == 'cancel') {
							        return;
							    }
							    //return true;
							};
						 	$.jBox.warning("i18n_nginfo.message.warning_n81i", "i18n_nginfo.message.hint_n81i", submit,{icon: false});
					 	}else{
					 		document.listForm.action ="<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=startNodeGroup&isStartSubNodeGroup=1";
							document.listForm.submit();
					 	}
					 }
				 }
			}
			
			//判断所选节点组中是否有其父节点组为无效的，且没选中父节点组的节点
			//（1）非一级节点组,（2）父无效,（3）父不在所选范围内			
			function isRightValid(name) {
				var idArray = getAllCheckedId(name);
				var allIds = ","+idArray.join(",")+",";
				for(i=0;i<idArray.length;i++) {
					var pidStr='pid'+idArray[i];
					var pid = document.getElementById(pidStr).value;
					if(pid!=0) {//非一级节点组
						yxbz='yxbz'+pid;
					    var isValid = document.getElementById(yxbz).value;//父节点组的有效性
					    if(isValid ==0) {//父节点组无效，则子节点组不可改变有效性
							if(allIds.search(","+pid+",")==-1) {//父不在所选范围内
								return false;
							}
						}
					}
				}
				return true;
			}
	
			//判断是否启用jbox
			function isUseJbox(name){
				var idArray = getAllCheckedId(name);
				//var allIds = ","+idArray.join(",")+",";
				alert(idArray[0]);
				
			}
			//根据name，把选中的复选框的值放到一个数组里
			function getAllCheckedId(name) {
				var n = 0;
				var checkedIds = new Array();
				var checkedElems = document.getElementsByName(name);	
				for(i = 0 ; i <= checkedElems.length ; i++ ){
					if(checkedElems[i]){
						if(checkedElems[i].checked)
						{
							checkedIds[n] = checkedElems[i].value;
							n++;
						}
					}
				}
				return checkedIds;
			}
			
			//管理节点:只有叶子节点才有节点管理，用于顶部菜单，是根据勾选的复选框来操作的--暂时不用
			function nodeManage(){
			 	if(!isRigthCheck("ids", "edit")){
			 		alert("i18n_nginfo.message.nodeManage1_n81i");
			 	}else if(!isLeafGroup("ids",0)) {
			 		alert("i18n_nginfo.message.nodeManage2_n81i");
			 	}else {
			 		var checkedIdsArray = getAllCheckedId("ids");
			 		var isValid;
			 		if(checkedIdsArray.length>0) {
			 			var id = checkedIdsArray[0];
			 			yxbz='yxbz'+id;
					    isValid = document.getElementById(yxbz).value;
			 		}
					document.listForm.action = "<%=path%>/nodeGroupManage/nodeGroupManage!execute.do?action=nodeMgmt&isValid="+isValid;
					document.listForm.submit();
				}		
			}
			
			//管理节点:只有叶子节点才有节点管理，用于详细信息页面菜单，根据当前详细信息来操作的
			function nodeManageInDetail(){
			 	//出现节点管理按钮时，一定是选择了一个节点组，所以不用进行是否选择一条记录的判断
			 	var nodeId = $("#nodeGroupId").val();//获得当前详细信息的节点id
			 	if(!isRigthCheck("ids", "edit")){
			 		alert("i18n_nginfo.message.nodeManage1_n81i");
			 		return;
			 	}
			 	if(!isLeafById(nodeId)) {
			 		alert("i18n_nginfo.message.nodeManage2_n81i");
			 		return;
			 	}else {
		 			//根据节点组id，获得节点组的有效性，以决定节点列表显示的菜单内容
		 			yxbz='yxbz'+nodeId;
				    var isValid = document.getElementById(yxbz).value;
				   // if($("#fguide").val()=='formGuide'){
				   // 	document.listForm.action = "<%=path%>/nodeGroupManage/nodeGroupManage.do?action=nodeMgmt&fromWhere=formGuide&=isValid="+isValid;
				   // 	document.listForm.submit();
				   // }else{
						document.listForm.action = "<%=path%>/nodeGroupManage/nodeGroupManage.do?action=nodeMgmt&isValid="+isValid;
						document.listForm.submit();
					//}
				}		
			}
			
			//根据节点组id，判断节点组是否叶子节点组:返回true：是叶子节点组，false：非叶子节点组
			function isLeafById(nodeId) {
				var nodeLeafElementId = 'leaf'+nodeId;
				var isLeaf = document.getElementById(nodeLeafElementId).value;
				if(isLeaf==1) {//1:叶子节点组
					return true;
				}else {//0：非叶子节点组
					return false;
				}
			}
			
			//根据name，先获得当前选中的复选框id，再获得对应节点组是否为叶子节点组--暂时没用
			function isLeafGroup(name,flagValue) {
				var elems = document.getElementsByName(name);
				for(i=0;i<elems.length;i++) {
					if(elems[i]) {
						if(elems[i].checked) {
							var tempValue = 'leaf'+elems[i].value;
							var elem = document.getElementById(tempValue).value;
							alert(elems[i].value+"="+elem);
							if(elem==flagValue) {
								return false;
							}
						}
					}
				}
				return true;			
			}
					
			//全选节点组，取消所有节点组
			function selectAllCheckBox(checkBox) {
				
				var checks = document.getElementsByTagName("input");
				for(i=0;i<checks.length;i++) {
					if(checks[i].type=='checkbox'&&checks[i].disabled!=true) {
				 		checks[i].checked = checkBox.checked;
				 		//***配置向导过来的传参***
				 		if('${type}' == "config"){
				 			if(checkBox.checked){
								var nodeGroupId = checks[i].value;
								if(parseInt(nodeGroupId)){
						 			var yxbz='yxbz'+nodeGroupId;
								    var isValid = document.getElementById(yxbz).value;
									window.parent.setParameter(nodeGroupId,isValid);
								}
				 			}else{
				 				window.parent.setParameter("","");
				 			}
				 		}
				 		//***配置向导过来的传参***
				 	}
				}
			}
			
			//判断ie浏览器版本
			function ieBrowser(){
				if($.browser.msie){
					if($.browser.version.split('.')[0]<=7){
						return false;
					}else{
						return true;//ie8+
					}
				}
			}
			
			function goGuide(datas) {
				if(datas!=null && datas!=""){
				 	if(datas.resu=='over') {
				 		window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
					}
				}
			}

			// 程辉 2013-5-8 新增 模板下载 
			function downloadExample() {
				document.form2.action = "<c:url value='/'/>/nodeGroupManage/nodeGroupManage.do?action=downloadExample";
				document.form2.submit();
			}

			//程辉 2013-5-8 新增 导入
			function importXls() {
				var myfileVal = document.getElementById("myFile").value;
				if(myfileVal=="") {
					alert("i18n_nginfo.error.selectFile_n81i");
				}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
					alert("i18n_nginfo.error.selectFileType_n81i");
				}else if(confirm('i18n_nginfo.error.isImport_n81i')){
					document.form2.action = "<c:url value='/'/>/nodeGroupManage/nodeGroupManage.do?action=importXls&showStopNGroup=${showStopNGroup}";
					document.form2.submit();
				}
			}
			//程辉 2013-5-8 新增 导出
			function emportXls() {
				document.form2.action = "<c:url value='/'/>/nodeGroupManage/nodeGroupManage.do?action=emportXls&showStopNGroup=${showStopNGroup}";
				document.form2.submit();
			}
			
			
			$(function(){
				$("#nodeGroupForm")[0].reset();//清空部门信息,不行，进来增加子节点就不对了？
				cancelForm();
				//jQuery("td[id=usergroup]").hide();
				//jQuery("tr[id=quanxian]").hide();
				//jQuery("td[id=viewLevel]").attr('colspan',3).addClass('color_6').removeClass('color_3');
				//-- 查看权限事件绑定
			 	/*jQuery("input[type=radio][name=nodeGroup.viewLevel]").click(function(){
			 		if(jQuery(this).val() == 2){	//用户组显示且必选
			 			jQuery("td[id=usergroup]").show();
			 			jQuery("td[id=viewLevel]").attr('colspan',1).addClass('color_3').removeClass('td_6');
			 		}else{	//用户组隐藏
			 			jQuery("td[id=usergroup]").hide();
			 			jQuery("#usergroupId").val("");
			 			jQuery("td[id=viewLevel]").attr('colspan',3).addClass('color_6').removeClass('color_3');
			 		}
			 	});*/
			 	//如果是非admin登录，业务系统则是input
				<c:if test="${ADMFlag eq false}" >
					$("#isadm").empty();
				</c:if>
				
				//调整高度和宽度
				/*
				var dh = document.body.clientHeight; 
				var dhh = dh-30+"px;";
				var tableHeight = $("#info").height();
				if(tableHeight > dh-60){
					$("#maindiv").attr("style","margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
					if(ieBrowser()){
						$("#info").attr("style","width:100%;");
					}else{
						$("#info").attr("style","width:98.5%;");
					}
				}else{
					$("#maindiv").attr("style","margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
					$("#info").attr("style","width:100%;");
				}
				*/
				
				//首次进入---新增一级节点组
				addMainNodeGroup();
				
				if($("#isComplete").val()=='0'){
					//var content = {
				    //    content: '业务系统操作已完成，是否进行下一步操作?',
				    //    buttons: { '下一步': 1, '返回'：0,'取消': -1 },
				    //    buttonsFocus: 0,
				    //    submit: function (v, h, f) {
				    //        if(v == 1) {//执行下一步--用户组
				    //            window.location ="<%=path%>/sysManage/userGroupPerssion.do?action=query";
				    //        }
				    //       if(v == 0){//返回到设置向导页
				    //            window.location ="<%=path%>/sysManage/guideManage!execute.do?action=index";
				    //        }
				    //        if(v == -1){//返回到设置向导页
				    //            return;
				    //        }
				    //    }
					//};
		
					//$.jBox(content);
					var submit = function (v, h, f) {
						if (v == 'yes') {
							$("input[type=hidden][name=fromWhere]").val('formGuide');
					        return;
						}
						if (v == 'no') {
							$.post("<c:url value='/sysManage/guideManage!setComplete.do'/>",
				 				{
				 					packNum:5,
				 					packName:'jdz'
				 				},
				 				function(datas){
				 					goGuide(datas);
				 				},"json");
					
						}
					};
					$.jBox.warning("i18n_nginfo.message.warning1_n81i?", "i18n_nginfo.message.hint_n81i", submit,{icon: false});
				}
				//alert($("#dtreeTD").size());
				// overflow: auto;vertical-align: top; height:400px;
				//$("#dtree")
				//.css("vertical-align","top")
				//.css("height","537px")
				//.css("overflow","auto")
				//.css("display","block");
				//$("#dtree").parent()
				//.css("height","100%");
			});
			
			function resetHeight(){
				var $iframe = $("#Ich")
				if($iframe != null){
					$iframe.parent().css('height',$iframe.css('height'));
				}else{
					//alert('未找到父项');
				}
			}
		</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<!--中间部分右边开始：操作按钮-->
			<form name=form2 action="" method="post" enctype="multipart/form-data">
			<div id="divTop">
				<div class="box_2">
			<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_nginfo.button.downloadExample_n81i"/>
								&nbsp;		
			
			
								<input type="button" value="i18n_nginfo.text.importXls_n81i" title="i18n_nginfo.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_nginfo.button.importXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportXls();" value="i18n_nginfo.button.showDiv_n81i"/>
								&nbsp;
			</div>
			</div>
			</form>
			<div id="maindiv" style="clear:both;">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info" style="">
					<tr>
						<td class="color_8">
							<span>i18n_nginfo.text.nodeGroup_n81i</span><br/>
							<span>(</span>
							<span><input type="checkbox" id="chkShowStopNGroup" onclick="query()" /></span>
							<span><label for="chkShowStopNGroup">i18n_nginfo.text.ShowStopNGroup_n81i</label></span>
							<span>)</span>
						</td>
						<td class="color_8">i18n_nginfo.text.nodeGroupInfo_n81i</td>
					</tr>
					<tr>
						<td class="color_1" align="left" width="20%" style="vertical-align: top;" >
						<form action="" name="listForm" id="listForm" method="post">
							<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
							<input type="hidden" id="fguide" name="fromWhere" value="${fromWhere }"/>
							<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
							<div id="dtree" name="dtree" style="overflow: auto;vertical-align: top; ">
								<script type="text/javascript">
									d = new dTree('d','','','ids','${type}',false);
									<c:if test="${ADMFlag eq true}" >
										d.add('0','-1','<input type="checkbox" name="chkkAll" onclick="selectAllCheckBox(this)"/>'+'&nbsp;&nbsp;<a href="javascript:addMainNodeGroup();">i18n_nginfo.message.nodeGroupList_n81i</a>','');
									</c:if>
									<c:if test="${ADMFlag eq false}" >
										var systemName = '${system.systemName}'
										var systemId = '${system.systemId}'
										d.add('0','-1','<input type="checkbox" name="chkkAll" onclick="selectAllCheckBox(this)"/>'+'&nbsp;&nbsp;<a href="javascript:addMainNodeGroup();">'+systemName+'</a>','');
									</c:if>
									<%
										List treeList = (List)request.getAttribute("treeList");
										List list = MakeTree.getResourceSortbyVaildAndId(treeList);
							        	if(list != null && list.size() > 0){
								       		Resource resource = new Resource();
										    for( int i = 0 ; i < list.size() ; i++ ){
												resource = (Resource) list.get(i);        				
												%>
												   var reCode = '<%=resource.getRsCode()%>';
												   d.add(reCode,'<%=resource.getParRsCode()%>','<%=resource.getRsname()%>','','javascript:onClickNodeGroup('+reCode+');');
												   
												   
												<%
												        			
											}
										}
									%>
									document.write(d);
								</script>
								<c:forEach items="${nodeGroupList}" var="group" varStatus="vs">
									<input type="hidden" id="yxbz${group.groupId }"	name="yxbz${group.groupId }" value="${group.isValid}" />
									<input type="hidden" id="leaf${group.groupId }"	name="leaf${group.groupId }" value="${group.leafGroup}" />
									<input type="hidden" id="pid${group.groupId }" name="pid${group.groupId }" value="${group.parentGroupId}" />
								</c:forEach>
							</div>
							</form>
						</td>  
						<td class="color_3" align="left" valign="top">
							
							<div class="box_2" id="buttons_oneRecordOperation">
									<input type="button" value="i18n_nginfo.button.addSubNodeGroup_n81i" class='btn3_mouseout' id="button_addSub"
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="addSubNodeGroup()"/>
									<input type="button" value="i18n_nginfo.button.update_n81i" class='btn3_mouseout' id="button_update"
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="updateNodeGroup()"/>
									<input type="button" value="i18n_nginfo.button.mngNode_n81i" class='btn3_mouseout' id="button_mngNode"
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="nodeManageInDetail()"/>
									<jsp:include page="/include/include.jsp" />
							</div>
						<input type="hidden" id="ngid" />
						<form action="" name="nodeGroupForm" id="nodeGroupForm" method="post" >
							<input type="hidden" name="showStopNGroup" value="${showStopNGroup }" />
							<input type="hidden" name="position" value="${position }" />
							<input type="hidden" name="nodeGroup.groupId" id="nodeGroupId" />
							<input type="hidden" name="nodeGroup.parentGroupId" id="pid" />							
							<input type="hidden" name="nodeGroup.groupLevel" id="groupLevel" /><!-- 组级别：父亲级别加1 -->
							<input type="hidden" name="isChickTitle" id="isCheckW" />
							<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
							<input type="hidden" name="fromWhere" value="${fromWhere }"/>
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
								<tr>
									<td align="center" colspan="4" class="color_1" id="operatTitle">
										<strong>i18n_nginfo.text.title_n81i</strong>
									</td>
								</tr>
								<tr type='form'>
									<td class="color_1" width="13%" align="right">
										i18n_nginfo.text.groupName_n81i：
									</td>
									<td class="color_3" width="37%" align="left">
										<input type="text"  name="nodeGroup.groupName" id="groupName"  />
										<font color="red">* </font>
									</td>
									<td class="color_1" width="13%" align="right">
										i18n_nginfo.text.groupType_n81i：
									</td>
									<td class="color_6" align="left">
										<input type="radio" name="nodeGroup.groupType" id="groupType"
											value="0" checked />i18n_nginfo.message.groupType0_n81i
										<input type="radio" name="nodeGroup.groupType" id="groupType"
											value="1" />i18n_nginfo.message.groupType1_n81i
									</td>
								</tr>
								<tr type='form'>
									<td class="color_1" align="right">
										i18n_nginfo.text.systemId_n81i：
									</td>
									<td class="color_6" align="left" colspan="3">
										<c:if test="${ADMFlag eq true}" var="flag">
											<select name="nodeGroup.systemId" id="systemId" >
												<option selected="selected" value="">
													i18n_nginfo.message.systemId_n81i
												</option>
												<c:if test="${fn:length(systemList)>0 }">
													<c:forEach items="${systemList }" var="system">
														<option value="${system.systemId }">
															${system.systemName }
														</option>
													</c:forEach>
												</c:if>
											</select>
										</c:if>
										<c:if test="${ADMFlag eq false}">
											<input type="hidden" name="nodeGroup.systemId" id="systemId"
												value="${system.systemId}" />
											<input type="text" name="nodeGroup.systemIdName" id="systemIdName"
												value="${system.systemName}" />
										</c:if>
										<font id="isadm" color="red">* </font>
									</td>
									<td class="color_1" align="right" style="display:none;">
										i18n_nginfo.text.isValid_n81i：
									</td>
									<td class="color_6" align="left" style="display:none;">
										<input type="radio" name="nodeGroup.isValid" id="isValid"
											value="1" checked />
										i18n_nginfo.message.isValid1_n81i
										<input type="radio" name="nodeGroup.isValid" id="isValid"
											value="0" />
										<font color="red">i18n_nginfo.message.isValid0_n81i</font>
									</td>
								</tr>
								<input type="hidden" name="nodeGroup.viewLevel" id="viewLevel3" value="3" />
								<!--    
							        <tr type='form' id="quanxian">
										<td class="color_1" align="right">
											查看权限：
										</td>
										<td class="color_3" align="left" id="viewLevel">
											<input type="radio" name="nodeGroup.viewLevel" id="viewLevel1"
												value="1" />
											发布人&nbsp;
											<input type="radio" name="nodeGroup.viewLevel" id="viewLevel2"
												value="2" />
											发布人所在组&nbsp;
											<input type="radio" name="nodeGroup.viewLevel" id="viewLevel3"
												value="3" checked="checked" />
											系统内全部人&nbsp;
										</td>
										<td class="color_1" align="right" id="usergroup">
											用户组：
										</td>
										<td class="color_6" align="left" id="usergroup">
											<select name="nodeGroup.createUsergroupId" id="usergroupId" >
												<option selected="selected" value="">
													请选择用户组
												</option>
												<c:if test="${fn:length(allUserGroup)>0 }">
													<c:forEach items="${allUserGroup }" var="userG">
														<option value="${userG.jsbh }">
															${userG.jsmc }
														</option>
													</c:forEach>
												</c:if>
											</select>
											<font color="red">* </font>
										</td>
									</tr>   
								-->	
								<tr type='form'>
									<td class="color_1"  align="right">
										i18n_nginfo.text.groupDesc_n81i：
									</td>
									<td class="color_6" colspan="3" align="left">
										<textarea rows="4" cols="80" name="nodeGroup.groupDesc"
											id="groupDesc" style="width: 360px" ></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="right" class="td_1" >&nbsp;
										<div id="buttons_add">
											<input type="button" value="i18n_nginfo.button.submit_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitAdd()"/>
											<input type="reset" value="i18n_nginfo.button.reset_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="reSetForm()"/>
											 <input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="goBack()" value="i18n_nginfo.button.back_n81i"/>
										</div>
										<div id="buttons_update">
											<input type="button" value="i18n_nginfo.button.submit_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitUpdate()"/>
											<input type="button" value="i18n_nginfo.button.reset_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="reSetFormForUp()"/>
											 <input type="button" class=btn3_mouseout
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'"
											onclick="goBack()" value="i18n_nginfo.button.back_n81i"/>
										</div>
										
									</td>
								</tr>
								
								<tr>
									<td colspan="4" align="left" >
										<iframe id="Ich" name="Ich" style="min-height:500px" width="100%" marginwidth="0" marginheight="0" align="top" style="background:#FFFFFF;"	
											frameborder="0" src="<c:url value='/nodeGroupManage/nodeManage.do?action=queryChild'/>" scrolling="auto">
											i18n_nginfo.message.brower_n81i
										</iframe>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>
			</div>
		</div>
	</body>
</html>
