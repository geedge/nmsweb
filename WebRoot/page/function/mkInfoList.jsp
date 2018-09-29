<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>i18n_mkil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" type="text/css" rel="stylesheet"	/>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value="/js/MzTreeView10.js"/>"></script>
		<script type="text/javascript"> 
		    var tree = new MzTreeView("tree");
			 window.onload=function(){
       			<c:if test="${allMkInfo ne null}">
				</c:if>
   			 }
   			 function EI(t) {return document.getElementById(t);}
   			 tree.icons["property"] = "property.gif";
	  		 tree.icons["css"] = "collection.gif";
	  		 tree.icons["book"]  = "book.gif";
	  		 tree.setIconPath("<%=basePath%>"+"/images/tree/"); //可用相对路径
	  
   			 var listvalue = new Array();
		 	 <c:if test="${allMkInfo ne null}">
				<c:forEach var="item" items="${allMkInfo}">	
					<c:if test="${item.zxbz==1}" var="zxFlag">
						tree.nodes["${item.pid}_${item.id}"]="text:<font color='#999999'>${item.mkmc}</font>;hint:${item.mkmc};icon:css;data:id=${item.id};leaf:true";
					</c:if>
					<c:if test="${!zxFlag}">
						tree.nodes["${item.pid}_${item.id}"]="text:${item.mkmc};hint:${item.mkmc};icon:css;data:id=${item.id};leaf:true";
					</c:if>
					listvalue['${item.id}']="${item.id};${item.handler};${item.mkurl};${item.mkmc};${item.iconimage};${item.mktype};${item.showorder};${item.mkms};${item.pid};${item.zxbz};${item.showlevel}";	
				</c:forEach>
			</c:if>
		  tree.setTarget("MzMain");
		//点击各节点触发的事件
		function myclick(id){
			$("#btn_sort").hide();
			var node=tree.currentNode;
			var values = listvalue[id].split(";");
			EI("pid").value=values[0];
			torepair(listvalue[id]);
		}
		
		function initshow(){
			$("#tabl1").html("<table id='tabl1' class='table1' width='100%' border=0 cellpadding='0' cellspacing='1' width=\"100%\"><tr><th class=\"tdhead\">i18n_mkil.message.table.name_n81i</th><th class=\"tdhead\">i18n_mkil.message.table.type_n81i</th><th class='tdhead'>i18n_mkil.message.table.serial_n81i</th><th class=\"tdhead\">i18n_mkil.message.table.description_n81i</th><th  class=\"tdhead\" style=\"\">i18n_mkil.message.table.operations_n81i</th></tr></table>");
		}
		
		//按钮排序
		function functionsort(sort){
		   
			var id = $("#id").val();
			if(!id){
		      alert('i18n_mkil.message.selectNode_n81i');
		      return;
		    }
		    
		    var pid = $("#pid").val();
		    var showNum = $("#forder").val();
		    
		    var actionurl = "<%=path%>/functionManager/functionManager.do?action=update&sort="+sort;
			
			$.ajax( {
				url : actionurl+"&r="+new Date(),
				type : "POST",
				dataType : "html",
				data:{'module.pid':pid,'module.id':id,'module.showorder':showNum},
				async:false,
				success : function(data) {
					if(data == '1'){
						//alert('操作成功,请重新登录');
						//window.parent.location="<%=path%>/login.do?type=refresh";
						//window.parent.location.reload;
						alert('i18n_mkil.message.success_n81i');
						window.location.href="<%=path%>/functionManager/functionManager.do?action=queryMkInfo";
					}else if(data == '2'){
						alert('i18n_mkil.message.faild_n81i');
					}else if(data == '3'){
						alert('i18n_mkil.message.upDisable_n81i');
					}else if(data == '4'){
						alert('i18n_mkil.message.downDisable_n81i');
					}
				}
			})
		}
		
		//修改
		function torepair(txt){
			$("#pathAndjs").html("*");
			var arr=txt.split(";");
			//父id
			$("#pid").val(arr[8]);
			//主键
			$("#id").val(arr[0]);
			//调用的js
			$("#handler").val(arr[1]);
			$("#mkurl").val(arr[2]);
			$("#mkmc").val(arr[3]);
			$("#iconimage").val(arr[4]);
			$("#forder").val(arr[6]);
			$("#mkms").val(arr[7]);
			$("#mktype").val(arr[5]);
			$("#levelTemp").val(arr[10]);
			$("#level").val(arr[10]);
			//alert(arr[10]);
			//alert($("#showlevel").val());
			$("input[type='radio'][name='module.mktype']").removeAttr('disabled');
			$("input[type='radio'][name='module.mktype'][value='"+(arr[5] == '' || arr[5] ==0 ? 0 : 1)+"']").trigger('click');
			$("input[type='radio'][name='module.mktype']").attr('disabled','disabled');
			$("input[type='radio'][name='module.zxbz']").removeAttr('disabled');
			$("input[type='radio'][name='module.zxbz'][value='"+(arr[9] == '' || arr[9] ==0 ? 0 : 1)+"']").trigger('click');
			$("input[type='radio'][name='module.zxbz']").attr('disabled','disabled');
			cancelForm();
			if($("#mktype").val()=='1'){//选中的是按钮，禁止添加子节点
				$("input[class=btn3_mouseout][type=button][value='i18n_mkil.message.andSubnode_n81i']").hide();
			}else{
				$("input[class=btn3_mouseout][type=button][value='i18n_mkil.message.andSubnode_n81i']").show();
			}
		}
		function cancelForm(){
			$("#yhForm input").attr('disabled','disabled');
			$("#yhForm textarea").attr('disabled','disabled');
			$("span[id^=buttons]").hide();
			$("#btn_sort").hide();
		}
		function activeForm(){
			$("#yhForm input").removeAttr('disabled');
			$("#yhForm textarea").removeAttr('disabled');
		}
		//模块管理的按钮修改
		function updateMk(){
			if($("#id").val()==""){
				alert("i18n_mkil.message.updateMK_n81i");
				return ;
			}
			activeForm();
			$("#buttons_add").hide();
			$("#buttons_update").show();
			$("#btn_sort").show();
			$("#showNum").val($("#forder").val());
			$("#level").removeAttr('readonly');//菜单级别可修改
		}
		
		//模块管理的添加按钮
		function addMk(){
			$("#yhForm")[0].reset();
			activeForm();
			$("#buttons_update").hide();
			$("#buttons_add").show();
			getMaxShowOrder();
			$("input[type='radio'][name='module.mktype'][value='1'").attr('disabled','disabled');//不能为按钮
			$("#level").val(1);
		}
		//子模块管理的添加按钮
		function addZMk(){
			var pid = $("#yhForm>#id").val();
			if(pid == ""){
				alert("i18n_mkil.message.addZMK_n81i");
				return;
			}
			
			$("#yhForm")[0].reset();
			$("#yhForm>#pid").val(pid);
			activeForm();
			$("#buttons_update").hide();
			$("#buttons_add").show();
			getMaxShowOrder();
			if($("#levelTemp").val()=='1'){//主菜单，只能添加菜单
				$("input[type='radio'][name='module.mktype'][value='1'").attr('disabled','disabled');//不能为按钮
				$("input[type='radio'][name='module.mktype'][value='0'").attr('checked','checked');
				$("#level").val(2);
				$("input[type='radio'][name='module.mktype']:checked").trigger('click');
			}else if($("#levelTemp").val()=='2'){//子菜单 只能添加按钮
				$("input[type='radio'][name='module.mktype'][value='0'").attr('disabled','disabled');//不能为菜单
				$("input[type='radio'][name='module.mktype'][value='1'").attr('checked','checked');
				$("#level").val("");
				$("input[type='radio'][name='module.mktype']:checked").trigger('click');
			}
			
		}
		//获取最大排列序号
		function getMaxShowOrder(){
			$.post("<c:url value='/functionManager/functionManager!getMaxShowOrder.do'/>",
		 					{pid:$("#pid").val()},
		 					function(data){
		 						if(data!=null && data!=""){
			 						$("#forder").val(data.maxShowOrder);
		 						}
		 					},"json");
		}
		//验证数字
		function checkNum(num){
			var cs = /^[0-9]*$/;
			var resu = cs.test(num);
			return resu;
		}
		
		function commitUpdate(){
			//校验
			if(!$id("mkmc","","i18n_mkil.text.mkmc_n81i")){
				$("#mkmc").trigger('focus');
				return false;
			}
		
			if(checkSpecial($("#mkmc").val())){
				$("#mkmc").next().html("i18n_mkil.message.mkmc_n81i");
				$("#mkmc").trigger('focus');
				return false;
			}
			
			if($("input[type='radio'][name='module.mktype']:checked").val()!="1"){	//菜单
				if(!$id("mkurl","","i18n_mkil.text.mkurl_n81i")){
					$("#mkurl").trigger('focus');
					return false;
				}
				if(!$id("level","sz","i18n_mkil.text.level_n81i")){
					$("#level").trigger('focus');
					return false;
				}
			}else{	//方法
				if($("#handler").size()==0 || $("#handler").val()==""){
					$("#pathAndjs").html("i18n_mkil.message.pathAndjs_n81i");
					$("#handler").trigger('focus');
					return false;
				}
			}
			if(!$id("forder","sz","i18n_mkil.text.forder_n81i")){
				$("#forder").trigger('focus');
				return false;
			}
			var actionurl = "<%=path%>/functionManager/functionManager.do?action=update";
			document.forms.yhForm.action = actionurl;
			document.forms.yhForm.submit();
			document.forms.yhForm.action="";
		}
		function commitAdd(){
			//校验
			if(!$id("mkmc","","i18n_mkil.text.mkmc_n81i")){
				$("#mkmc").trigger('focus');
				return false;
			}
		
			if(checkSpecial($("#mkmc").val())){
				$("#mkmc").next().html("i18n_mkil.message.mkmc_n81i");
				$("#mkmc").trigger('focus');
				return false;
			}
			if($("input[type='radio'][name='module.mktype']:checked").val()!="1"){	//菜单
				if(!$id("mkurl","","i18n_mkil.text.mkurl_n81i")){
					$("#mkurl").trigger('focus');
					return false;
				}
				if(!$id("level","sz","i18n_mkil.text.level_n81i")){
					$("#level").trigger('focus');
					return false;
				}
			}else{	//方法
				if($("#handler").size()==0 || $("#handler").val()==""){
					$("#pathAndjs").html("i18n_mkil.message.pathAndjs_n81i");
					$("#handler").trigger('focus');
					return false;
				}
			}
			
			//$("#level").val($("#levelTemp").val());
			var actionurl = "<%=path%>/functionManager/functionManager.do?action=add";
			document.forms.yhForm.action = actionurl;
			document.forms.yhForm.submit();
			document.forms.yhForm.action="";
		}
		
		$(function(){
			cancelForm();
			$("span[id^=buttons]").hide();
			$("#btn_sort").hide();
			$("input[type='radio'][name='module.mktype']").click(function(){
				
				if($(this).val()!=1){//菜单
					$("#mkurl").show();
					$("#sl").show();
					$("#handler").hide();
				}else{//按钮
					$("#pathAndjs").html("*");
					$("#mkurl").hide();
					$("#handler").show();
					$("#sl").hide();
				}
			});
			$("input[type='radio'][name='module.mktype']:checked").trigger('click');
			$("#forder").attr('readonly','readonly');//序号只读
			$("#level").attr('readonly','readonly');//菜单级别只读
		});
		</script>
	</head>
	<body>
		<div class="middle_list">
			<!--中间部分右边开始-->
			<div class="box_2">
				<jsp:include page="/include/include.jsp" />
			</div>
				<table border="0" cellpadding="0" cellspacing="0" class="table" >
					<tr>
						<td class="color_8" colspan="2">i18n_mkil.text.mkManage_n81i</td>
					</tr>
					<tr>
						<td class="color_1" align="left">
							<div id="functionTree"
								style="overflow: scroll; height:500px">
								<script language="javascript">
								<%-- 动态定义树的可显示高度 --%>
								document.write(tree.toString());
								<%-- 生成功能树 --%>
								</script>
							</div>
						</td>
						<td class="color_3" align="left" valign="top">
						<input type="hidden" id="levelTemp" />
						<form action="" name="yhForm" id="yhForm" method="post" >
							<input type="hidden" name="position" value="${position }" />
							<input type="hidden" name="module.pid" id="pid" />
							<input type="hidden" name="module.id" id="id" />
							<input type="hidden" name="mktype" id="mktype" />
							<input type="hidden" id="showNum" />
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" style="padding-left: 5px; padding-right: 5px;">
								<tr>
									<td align="center" colspan="4" class="color_1">
										<strong>i18n_mkil.text.title_n81i</strong>
									</td>
								</tr>
								<tr type='form'>
									<td class="td_1">
										i18n_mkil.text.mkmc_n81i：
									</td>
									<td  class="td_3">
										<input type="text" name="module.mkmc" id="mkmc"  />
										<font color="red">*</font>
									</td>
									<td class="td_1">
										i18n_mkil.text.pathAndjs_n81i：
									</td>
									<td class="td_2"> 
										<input type="text" name="module.handler" id="handler" />
										<input type="text" name="module.mkurl" id="mkurl" />
										<font color="red" id="pathAndjs">*</font>
									</td>
								</tr>
								<tr type='form'>
									<td  class="td_1">
										i18n_mkil.text.mktype_n81i：
									</td>
									<td class="td_3">
										<input type="radio" name="module.mktype" value="0" checked="checked" id="menu"/>i18n_mkil.message.menu_n81i
										<input type="radio" name="module.mktype" value="1" id="btn"/>i18n_mkil.message.button_n81i
									</td>
									<td class="td_1">
										i18n_mkil.text.state_n81i：
									</td>
									<td class="td_2">
										<input type="radio" name="module.zxbz" value="0"
											checked="checked" />
										  i18n_mkil.message.valid_n81i
										<input type="radio" name="module.zxbz" value="1"/>
										  i18n_mkil.message.invalid_n81i 
									</td>
								</tr>
								<tr type='form'>
									<td class="td_1">
										i18n_mkil.text.mkms_n81i：
									</td>
									<td class="td_2" >
										<textarea rows="3" cols="18" name="module.mkms" id="mkms" ></textarea>
									</td>
									<td class="td_1">
										i18n_mkil.text.showorder_n81i：
									</td>
									<td class="td_2" valign="middle" style="display: inline;">
										<input type="text" maxlength="10" size="9" name="module.showorder" id="forder" />
										<font color="red">*</font>
										<div id = "btn_sort" style="display: inline;" >
											<img align="middle" src="<%=path %>/images/sort_up.png" alt="i18n_mkil.message.btnsortup_n81i" onclick="functionsort('up')"/>
											<img align="middle" src="<%=path %>/images/sort_down.png" alt="i18n_mkil.message.btnsortdown_n81i" onclick="functionsort('down')"/>
										</div>
									</td>
								</tr>
								<tr type='form' id="sl">
									<td class="td_1">
										i18n_mkil.text.level_n81i：
									</td>
									<td class="td_2" valign="middle" >
										<input type="text" maxlength="10" size="9" name="module.showlevel" id="level" />
										<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="right" class="td_1" >&nbsp;
										<span id="buttons_add">
											<input type="button" value="i18n_mkil.button.submit_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitAdd()"/>
											<input type="button" value="i18n_mkil.button.cancel_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="cancelForm()"/>
										</span>
										<span id="buttons_update">
											<input type="button" value="i18n_mkil.button.submit_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="commitUpdate()"/>
											<input type="button" value="i18n_mkil.button.cancel_n81i" class='btn3_mouseout'
											onmouseover="this.className='btn3_mouseover'"
											onmouseout="this.className='btn3_mouseout'"
											onmousedown="this.className='btn3_mousedown'"
											onmouseup="this.className='btn3_mouseup'" 
											onclick="cancelForm()"/>
										</span>
									</td>
								</tr>
							</table>
						</form>
						</td>
					</tr>
				</table>
				<!--中间部分右边结束-->
		</div>
	</body>
</html>
