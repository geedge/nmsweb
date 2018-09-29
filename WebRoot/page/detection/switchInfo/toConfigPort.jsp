<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=" http://www.w3.org/1999/xhtml">
	<head>
		<title>i18n_tcp.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.tools.js'/>"></script>
		<script type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js' />"></script>
		<script type="text/javascript">
     function qry(){
     	document.form3.action="<c:url value='/detection/switchDetection.do?action=toConfigPort'/>";
     	document.form3.submit();
     }
     
     function save(index){
     	document.form3.action="<c:url value='/detection/switchDetection.do?action=saveConfigPort&index="+index+"'/>";
     	document.form3.submit();
     }
     
      function batchSave(){
      	/*var length = $("input[name=selectOne]").filter(":checked").length;
		if(length <= 0){
			alert("请至少选择一条记录");
			return;
		}*/
     	document.form3.action="<c:url value='/detection/switchDetection.do?action=saveConfigPort'/>";
     	document.form3.submit();
     }

    function batchAllUpDown(num){
    	var checks = document.getElementsByTagName("input");
    	if(num == 1){
	    	for(i=0;i<checks.length;i++){
	    		if(checks[i].type=='radio' && checks[i].value=='1'){
	     			checks[i].checked='checked';
	         	}else if(checks[i].type=='radio' && checks[i].value=='2'){
	         		checks[i].checked='';
	            }else if(checks[i].type=='checkbox' && checks[i].value=='DOWN'){
	         		checks[i].checked='';
	            }
	    	}
    	}else if(num == 2){
    		for(i=0;i<checks.length;i++){//alert(checks[i].type);alert(checks[i].value);
	    		if(checks[i].type=='radio' && checks[i].value=='2'){
	     			checks[i].checked='checked';
	         	}else if(checks[i].type=='radio' && checks[i].value=='1'){
	         		checks[i].checked='';
	            }else if(checks[i].type=='checkbox' && checks[i].value=='UP'){
	         		checks[i].checked='';
	            }
	    	}
        }	
    }
     
	 //全选
	$("input[ name='selectAll']").click(function(){
	 	$("input[name=selectOne]").attr('checked',$(this).attr('checked'));
	 });
	 
	 // 单选
	 $("input[name=selectOne]").click(function(){
	 	$("input[ name='selectAll']").attr('checked',$("input[name=selectOne]").length ==$("input[name=selectOne]").filter(":checked").length);
	 });
	 
	 var set_Id;
	var ajaxProperties = "";
	var ajaxTableName = "";
	var ajaxType = "";
	var id = "";
	var returnDiv = "";
	var ajaxValue = "";
	 
	 function lianxiangkeydown() {
		clearTimeout(set_Id);
	}
	 
	 function lianxiangkeyup(ajaxProperties1,ajaxTableName1,ajaxType1,id1,returnDiv1,ajaxValue1) {
		if(parent.document.getElementById("lianxiangStatus").value=="2")
		{
			if(jQuery.trim(ajaxValue1)=="") return false;
			
			ajaxProperties = ajaxProperties1;
			ajaxTableName = ajaxTableName1;
			ajaxType = ajaxType1;
			id = id1;
			returnDiv = returnDiv1;
			
			if(!checkStrNoDian(ajaxValue1)){
				ajaxValue = ajaxValue1;
			}else{
				clearTimeout(set_Id);
				alert('i18n_tcp.message.inputInfo_n81i');
				$("#"+id).val('');
				return;
			}
			clearTimeout(set_Id);
			set_Id = setTimeout(ajaxForLianxiang,500);
		}
	}
	
	function ajaxForLianxiang() 
	{
		jQuery.post("<%=path%>/detection/switchDetection!queryInfoForAjax.do",
		{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
		{
			var lianxiangList = data.split(",");
			jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			if(lianxiangList == ''){
				$("#"+id).css("color","#CBC0B6");
			}else{
				$("#"+id).css("color","#000000");
			}
		});
	}
    </script>
		<script type="text/javascript">
					function ieBrowser(){
						if($.browser.msie){
							if($.browser.version.split('.')[0]<=7){
								return false;
							}else{
								return true;//ie8+
							}
						}
					}
						$(function(){
							var dh = document.body.clientHeight;
							var dhh = dh-60+"px;";
							var tableHeight = $("#info").height();
							if(tableHeight > dh-60){
								$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:99%;font-size:12px;height: "+dhh);
								if(ieBrowser()){
									$("#info").attr("style","width:100%;");
								}else{
									$("#info").attr("style","width:98.5%;");
								}
							}else{
								$("#maindiv").attr("style","clear:both;margin-left:6px;overflow-y:auto;overflow-x:auto;width:98%;font-size:12px;height: "+dhh);
								$("#info").attr("style","width:100%;");
							}
								$("#info").floatHeaderDiv();
						});
						
						window.onresize = function(){
							$("#info").floatHeader();//用于浏览器调整大小后 列表表头自动适应
						}
						
						/*------ 滚动条滚动 延迟加载页面操作--------------*/
						var hght=0;//初始化滚动条总长
						var topH=0;//初始化滚动条的当前位置
						var pagePoint = ${pageNo};
						var memoryData ;
						var intervalID ;
						var currentPage = 0; //当前页数
						var currenttotalPage = 0; //总页数
						$(function(){//DOM的onload事件
							$("#maindiv").scroll( function() {//定义滚动条位置改变时触发的事件。
							    hght=this.scrollHeight;//得到滚动条总长，赋给hght变量
							    topH=this.scrollTop+this.clientHeight;//得到滚动条当前值，赋给top变量
							});
							intervalID = setInterval(function(){cando();},1000);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
							function cando(){
								currentPage = $("#currentPage").html(); 
							    currenttotalPage = $("#currenttotalPage").html();
							    if(Number(currentPage) < Number(currenttotalPage)){
									if(topH!=0 && hght!=0 && topH == hght ){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
								    	show();//如果是，调用show函数加载内容。
								    }
								}else if(Number(currentPage) == Number(currenttotalPage)){
									clearInterval(intervalID);
								}
							}
							function show(){
							    hght=0;//恢复滚动条总长，因为$(”#mypage”).scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载……
							    topH=0;//原因同上。
							    var nodeIp= $("#nodeIp").val();
							    var url2 = encodeURI("<c:url value='/detection/switchDetection.do?action=toConfigPortChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+"&nodeIp="+nodeIp);
								$.ajax({
									url:url2,
									type : "get",
									async:false,
									success : function(data) {
										$("#info").append($(data));//用append方法追加内容到mypage元素。
									   	$("#currentPage").html(pagePoint);//修改页码
								    	$("#pageNo").val(pagePoint);
									}
								});
								loadButton();
							}
						});
						/*------ 滚动条滚动 延迟加载页面操作--------------*/
			</script>
	</head>
	<body>
		<div class="middle_list" id="box">
			<!--中间部分右边开始-->

			<form name="form3" id="form3"
				action="<c:url value='/detection/switchDetection.do?action=toConfigPort'/>"
				method="post" enctype="multipart/form-data">
				<div class="box_1">
					<label class="divTopText"><font class="selectText">i18n_tcp.text.nodeIp_n81i</font>：
					<input type="text" id="nodeIp"
						onkeyup="lianxiangkeyup('nodeIp','NodeTable','String','nodeIp','suggest1',this.value);"
						name="nodeIp" title="i18n_tcp.message.nodeIp_n81i" value="${nodeIp}" size="20" />
					<div id='suggest1' class="ac_results"></div></label>
					<img id="queryBut" src="<c:url value='/images/button_chaxun.png'/>"
						class="img_middle2" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
					<input type="button" class=btn3_mouseout
						onmouseover="this.className='btn3_mouseover'"
						onmouseout="this.className='btn3_mouseout'"
						onmousedown="this.className='btn3_mousedown'"
						onmouseup="this.className='btn3_mouseup'"
						onclick="javascript:batchSave();" value="i18n_tcp.button.batchSave_n81i" />
				</div>
				<div id="maindiv">
					<table width="90%" border="0" cellpadding="0" cellspacing="0"
						class="table" align="center" style="clear: both" id="info">
						<tr>
							<td class="color_top" width="10%">
								i18n_tcp.text.index_n81i
							</td>
							<td class="color_top" width="30%">
								i18n_tcp.text.processIdenName_n81i
							</td>
							<td class="color_top" width="30%">
								i18n_tcp.text.portState_n81i&nbsp;
								<input type="checkbox" onclick="javascript:batchAllUpDown(1);"
									value="UP" id="UP"/>
								UP&nbsp;
								<input type="checkbox" onclick="javascript:batchAllUpDown(2);"
									value="DOWN" id="DOWN"/>
								DOWN
							</td>
							<td class="color_top" width="30%">
								i18n_tcp.text.option_n81i
							</td>
						</tr>
						<c:choose>
							<c:when test="${fn:length(nodeFigureInfoList) > 0}">
								<c:set var="index" value="${1}" />
								<c:forEach items="${nodeFigureInfoList}" var="nodeFigureInfo"
									varStatus="vs">
									<c:set var="color" value="color_1" />
									<c:if test="${vs.count%2!=0 }">
										<c:set var="color" value="color_3" />
									</c:if>
									<tr>
										<td class="${color }">
											${index+(pageNo-1)*pageSize}
										</td>
										<td class="${color }">
											${nodeFigureInfo.nameFlag}
										</td>
										<td class="${color }">
											<input type="hidden"
												name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].id"
												value="${nodeFigureInfo.id }" />
											<input type="radio"
												name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].portsetState"
												value="1"
												<c:if test="${nodeFigureInfo.portsetState !=2 }">checked</c:if> />
											<font color="green">UP</font>
											<input type="radio"
												name="batchNodeFigureInfo[${index+(pageNo-1)*pageSize}].portsetState"
												value="2"
												<c:if test="${nodeFigureInfo.portsetState ==2 }">checked</c:if> />
											<font color="red">DOWN</font>
										</td>
										<td class="${color }">
											<input type="button" class=btn3_mouseout
												onmouseover="this.className='btn3_mouseover'"
												onmouseout="this.className='btn3_mouseout'"
												onmousedown="this.className='btn3_mousedown'"
												onmouseup="this.className='btn3_mouseup'"
												onclick="javascript:save('${index+(pageNo-1)*pageSize}');" value="i18n_tcp.button.save_n81i" />
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" height="20" class="color_6" align="center"
										style="color: #000000;">
										i18n_tcp.text.noRecord_n81i
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<c:if test="${!empty nodeFigureInfoList}">
					<jsp:include page="/common/page.jsp" />
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>


