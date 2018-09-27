<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
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
		<title>i18n_pil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
	</head>

	<script language="javascript" type="text/javascript">
	  
	//添加记录
	 function addPlugin(){		 	
		document.form3.action ="<%=path%>/pluginManage/pluginManage.do?action=openAdd&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		document.form3.submit();
	 } 
	//修改记录
	 function updatePlugin(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_pil.message.selectOne_n81i");
	 	}else{
		 	document.form3.action ="<%=path%>/pluginManage/pluginManage.do?action=openUpdate&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //删除记录
	 function delPlugin(){
	 	if(!isRigthCheck("ids", "remove")){
	 		alert("i18n_pil.message.selectOne_n81i");
	 	}else if(confirm("i18n_pil.message.delPlugin_n81i")){
		 	document.form3.action ="<%=path%>/pluginManage/pluginManage.do?action=del&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
		}
	 }
	 //下载插件
	 function downPlugin(){
	 	if(!isRigthCheck("ids", "edit")){
	 		alert("i18n_pil.message.selectOne_n81i");
	 	}else {
		 	document.form3.action ="<%=path%>/pluginManage/pluginManage.do?action=downloadPlugin&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			document.form3.submit();
			document.form3.action ="<%=path%>/pluginManage/pluginManage.do?action=queryInfo&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		}
	 }
	 //查询记录
	 function qry(){
		document.form3.action = "<%=path%>/pluginManage/pluginManage.do?action=queryInfo";
		document.form3.submit();		
	}
	
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

	/*------ 滚动条滚动 延迟加载页面操作--------------*/
	var hght=0;//初始化滚动条总长
	var topH=0;//初始化滚动条的当前位置
	var pagePoint = ${pageNo};
	var flashFlag = false;
	var memoryData ;
	var intervalID ;
	var params;//页面查询条件
	$(document).ready(function(){//DOM的onload事件
		params = "&name="+$("#name").val()+"&fileName="+$("#fileName").val();
		//$(”#mypage”).load(”table.html”);//table.html的内容被加载到mypage元素
		$("#maindiv").scroll( function() {//定义滚动条位置改变时触发的事件。
		    hght=this.scrollHeight;//得到滚动条总长，赋给hght变量
		    topH=this.scrollTop+this.clientHeight;//得到滚动条当前值，赋给top变量
		});
		$.get("<c:url value='/pluginManage/pluginManage.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+params, function(data){//利用jquery的get方法得到table.html内容
		    memoryData = data;
		    flashFlag = true;
		});
      
		intervalID = setInterval(function(){cando();},1000);//每隔2秒钟调用一次cando函数来判断当前滚动条位置。
		function cando(){
			//alert(topH+" " +hght);
			if(topH!=0 && hght!=0 && topH == hght && flashFlag){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
		    	show();//如果是，调用show函数加载内容。
		    }
			//if(topH>parseInt(hght/3)*2){//判断滚动条当前位置是否超过总长的3/2，parseInt为取整函数
		    //	show();//如果是，调用show函数加载内容。
		    //}
		}
		
		function show(){
			flashFlag=false;
		    hght=0;//恢复滚动条总长，因为$(”#mypage”).scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载……
		    topH=0;//原因同上。
		    var flag2 = true;
		    if(memoryData!=null&&memoryData!=""&&memoryData.replace(/(^\s*)|(\s*$)/g,"")!=""){
		    	 try{				    	
				    	$("#info").append($(memoryData));//用append方法追加内容到mypage元素。
				    	$("#currentPage").html(pagePoint);
				    	$("#pageNo").val(pagePoint);
				    	flag2 = false;
					}catch(err){
						    
					}
		    }
		    
			$.get("<c:url value='/pluginManage/pluginManage.do?action=queryChild'/>&pageSize="+'${pageSize }'+"&pageNo="+(++pagePoint)+params, function(data){//利用jquery的get方法得到table.html内容
			    if(flag2){
			   		try{
				   		$("#info").append($(data));//用append方法追加内容到mypage元素。
					  }catch(err){
						    
					}
			    }else{
			   		flag2 = true;
			   		memoryData = data;
			    }
			    //无数据
			    if(data==null||data==""){
			    	clearInterval(intervalID);
			    }
			    flashFlag = true;
			});
		}
	});	
	/*------ 滚动条滚动 延迟加载页面操作--------------*/
    </script>
	<body>
	<div class="middle_list" style="overflow: hidden;">
		<form name=form3 id="frmArticleType" action="<c:url value='/pluginManage/pluginManage.do?action=queryInfo'/>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="pageNoforexp" id="pageNo" value="${pageNo }"/>
			<div id="divTop">
				<div class="box_1">		 
						<label class="divTopText"><font class="selectText">i18n_pil.text.name_n81i</font><input type="text" id="name"  name="name" title="i18n_pil.text.name_n81i" value="${name}" size="20" maxlength="50"/></label>
						<label class="divTopText"><font class="selectText">i18n_pil.text.fileName_n81i</font><input type="text" id="fileName"  name="fileName" title="文件名" value="${fileName}" size="20" maxlength="100"/></label>
						<img src="<c:url value='/images/button_chaxun.png'/>"
							class="img_middle2" onclick="javascript:qry();" />
				</div>
				<div class="box_2">
					<jsp:include page="/include/include.jsp" />
				</div>
			</div>
			<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr >
						<td width="6%" class="color_top">
							<input type="checkbox" name="checkbox62" value="checkbox" onClick="checkAll(this)" />序号
						</td>
						<td width="12%" class="color_top">
							i18n_pil.text.name_n81i
						</td>
						<td width="12%" class="color_top">
							i18n_pil.text.des_n81i
						</td>
						<td width="10%" class="color_top">
							i18n_pil.text.fileName_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_pil.text.createUsername_n81i
						</td>
						<td width="11%" class="color_top">
							i18n_pil.text.createTime_n81i
						</td>
						<td width="5%" class="color_top">
							i18n_pil.text.updateUsername_n81i
						</td>
						<td width="11%" class="color_8">
							i18n_pil.text.udateTime_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(pluginList) > 0}">
							<c:forEach items="${pluginList}" var="plugin" varStatus="vs">
								<c:set var="color" value="color_1"/>
								<c:set var="color_end" value="color_7"/>
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3"/>
									<c:set var="color_end" value="color_6"/>
								</c:if>
								<tr >
									<td class="${color }">										
										<input type="checkbox" name="ids" id="ids"
												value="${plugin.id}"/>
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										${plugin.name}
									</td>
									<td class="${color }">
										${plugin.des}
									</td>
									<td class="${color }">
										${plugin.fileName}
									</td>
									<td class="${color }">
										${plugin.creatUserName}
									</td>
									<td class="${color }">
									 	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${plugin.creatTime}"  />
									</td>
									<td class="${color }">
										${plugin.updateUserName}
									</td>
									<td class="${color_end }">
									 	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${plugin.updateTime}"  />
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="8" class="color_6" align="center">
									i18n_pil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<c:if test="${!empty pluginList}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>
		</div>
	</body>
</html>

