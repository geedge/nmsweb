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
		<title>i18n_tsng.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<link href="<c:url value='/js//dtree/css/dtree.css'/>"
			rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/dtree/js/dtree_checkbox_multi_choose.js"/>"></script>
		<script type="text/javascript">	
		     
			//点击各节点触发的事件:dTree
			function onClickNodeGroup(id){
				//点击节点组标题时:若复选框当前选中，则取消选中，若当前未选中，则选中。可以通过点击标题多选
				var isChecked= jQuery("input[type='checkbox'][name='mkid'][value='"+id+"']").attr("checked");
				jQuery("input[type='checkbox'][name='mkid'][value='"+id+"']").attr("checked",!isChecked);
			}
			
			//全选节点组，取消所有节点组
			function selectAllCheckBox(checkBox) {
				
				var checks = document.getElementsByTagName("input");
				for(i=0;i<checks.length;i++) {
					if(checks[i].type=='checkbox'&&checks[i].disabled!=true) {
				 		checks[i].checked = checkBox.checked;
				 	}
				}
			}
			
			//过滤选择的节点组：只返回最底层的节点组的id，可能是多个，返回后关闭当前窗口
			function selectNodeGroup(){
				if(!isRigthCheck("mkid", "remove")){
			 		 alert("i18n_tsng.message.selectOne_n81i");
			 		 return;
			 	}else {
			 		var idsArray = getBottomNodeGroup();
			 		var ids = idsArray.join(',')
			 		var namesArray = getNameStrByArray(idsArray);
			 		var names = namesArray.join(',');
					window.opener.reciveNodeGroup(ids,names);
					window.close();
				}
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
			
			//根据id得到name
			function getNameById(id) {
				var tempValue = 'name'+id;
				var name = document.getElementById(tempValue).value;
				return name;
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
			
	function resize(){
		//alert("document.listForm.dtree:"+document.all.dtree.style.height+";document.all.dtree.style.height:"+document.all.dtree.style.height);
	 	{document.all.dtree.style.height = document.all.dtree.style.height;}
	}
		</script>
	</head>
	<body >
		<form action="" name="listForm" id="listForm" method="post" >
		<div align="right">
			<span id="buttons_add">
				<input type="button" value="i18n_tsng.button.select_n81i" 
					onclick="selectNodeGroup()"
					class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"/>
				<input type="button" value="i18n_tsng.button.close_n81i" 
					onclick="window.close()"
					class=btn3_mouseout
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"/>
			</span>			
		</div>
		<div class="middle_list1" id="maindiv" name="maindiv" style="overflow-y:auto;overflow-x:auto;height:560px;width:360px;">
			i18n_tsng.button.nodeGroup_n81i
			<br/>
			<br/>
			<div id="dtree" name="dtree">
				<script type="text/javascript">
					var checkedNodeGroup = ','+'${nodeGroupIds}'+',';//选中节点组的id
					d = new dTree('d','','');
					var systemName = '${system.systemName}'
					d.add('0','-1','<input type="checkbox" onclick="selectAllCheckBox(this)"/>'+systemName);
					<%
						List treeList = (List)request.getAttribute("treeList");
						List list = MakeTree.getAllResourceList(treeList);
						if(list != null && list.size() > 0){
						Resource resource = new Resource();
						for( int i = 0 ; i < list.size() ; i++ ){
						resource = (Resource) list.get(i);        				
					%>
						var reCode = '<%=resource.getRsCode()%>';//当前节点id
						var isChecked = " ";
						var nodeGoupId = ','+reCode+',';
						if(checkedNodeGroup.indexOf(nodeGoupId)>=0) {//说明当前节点组为选中的节点组
							isChecked = 'checked';
						}
						d.add(reCode,'<%=resource.getParRsCode()%>','<%=resource.getRsname()%>',isChecked,'javascript:onClickNodeGroup('+reCode+');');
					<%
										        			
						}
					}
					%>
					document.write(d);
				</script>
				<c:forEach items="${nodeGroupList}" var="group" varStatus="vs">
					<input type="hidden" id="pid${group.groupId }" name="pid${group.groupId }" value="${group.parentGroupId}" />
					<input type="hidden" id="name${group.groupId }" name="name${group.groupId }" value="${group.groupName}" />
				</c:forEach>
			</div>
		</div>
		<script type="text/javascript">
	 			resize();
	 	</script>
	 	</form>
	</body>
</html>
