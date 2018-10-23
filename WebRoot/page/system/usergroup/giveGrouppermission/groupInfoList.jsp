<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ page import="nis.nms.core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_gil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/js/jBox/Skins/Gray/jbox.css'/>" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/onmouse.js'/>" ></script>
		<script language="javascript" type="text/javascript" src="<c:url value='/js/WebCalendar.js'/>"></script>
		<link href="<c:url value='/css/suggest.css'/>" rel="stylesheet"	type="text/css" />	
		<script type="text/javascript" src="<c:url value='/js/jquery.suggest.js' />"></script>	
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/fileInput.js"/>"></script>
		<script language="javascript" type="text/javascript" 
			src="<c:url value="/js/jBox/jquery.jBox-2.3.min.js"/>"></script>
			<style type="text/css">				
				.mydiv {
				background-color:#fff;
				border: 1px solid #000;
				text-align: center;
				line-height: 40px;
				font-size: 12px;
				font-weight: bold;
				z-index:99;
				width: 220px;
				height: 80px;
				left:50%;/*FF IE7*/
				top: 50%;/*FF IE7*/
				
				margin-left:-150px!important;/*FF IE7 该值为本身宽的一半 */
				margin-top:-60px!important;/*FF IE7 该值为本身高的一半*/
				
				margin-top:0px;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				
				
				.bg {
				background-color: #ccc;
				width: 100%;
				height: 100%;
				left:0;
				top:0;/*FF IE7*/
				filter:alpha(opacity=50);/*IE*/
				opacity:0.5;/*FF*/
				z-index:1;
				
				position:fixed!important;/*FF IE7*/
				position:absolute;/*IE6*/
				
				_top:       expression(eval(document.compatMode &&
				            document.compatMode=='CSS1Compat') ?
				            documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
				            document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
				
				}
				/*The END*/
				
			</style>
    <script language="javascript" type="text/javascript">
		var msg = '${MSG}';
	    if(msg=='1'){
			alert("i18n_gil.message.success_n81i");
		}else if(msg=='2'){
			alert("i18n_gil.message.faild_n81i");
		 }
		
		//添加记录
		 function addRecord(){
		  document.form2.action =  "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=openAddgroupPage&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		  document.form2.submit();
		 }
		 
		 //修改记录
		 function openUpdateRecord(jsbh){
		     document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=toupdate&jsbh="+jsbh+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		     document.form2.submit();
		 	}
		 	
		 //查看
		 function viewUpdateRecord(jsbh){
		     document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=viewdateForGuide&jsbh="+jsbh+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
		     document.form2.submit();
		 	}
		 //配置权限
		 function configJsMkGnRecord(jsbh){
		 	var url = "<c:url value='/'/>/sysManage/sSysPopedomManage.do?action=openConfigJsPage&jsbh="+jsbh;
			//窗体名称\路径、宽度、高度、是否全屏0；1
			winObj.init("",url,800,590,0);
			winObj.show();
		  	//window.open("<c:url value='/'/>/SysPopedomManage!execute.do?action=openConfigJsPage&jsbh="+jsbh,"","fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,width=800,height=600,left=300,top=200");
		 }
		 function qry(){
				document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
				document.form2.submit();		
			}
		//parent.document.all("listFrame").style.height = document.body.scrollHeight + 16;
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
		    //var lianxiangStatusTmp = parent.document.getElementById("lianxiangStatus");
			//if(lianxiangStatusTmp!=null && lianxiangStatusTmp.value=="2")
			//{
				if(jQuery.trim(ajaxValue1)=="") return false;
				
				ajaxProperties = ajaxProperties1;
				ajaxTableName = ajaxTableName1;
				ajaxType = ajaxType1;
				id = id1;
				returnDiv = returnDiv1;
				
				if(!containSpecial(ajaxValue1)){
					ajaxValue = ajaxValue1;
				}else{
					clearTimeout(set_Id);
					alert('i18n_gil.message.inputInfo_n81i');
					$("#"+id).val('');
					return;
				}
				clearTimeout(set_Id);
				set_Id = setTimeout(ajaxForLianxiang,500);
			//}
		}
		
		function ajaxForLianxiang() 
		{
			jQuery.post("<c:url value='/'/>/sysManage/sysPopedomManage!queryInfoForAjax.do",
			{"ajaxProperties":ajaxProperties,"ajaxTableName":ajaxTableName,"ajaxType":ajaxType,"ajaxValue":ajaxValue},function(data)
			{
				var lianxiangList = data.split(",");
				jQuery("#"+id).suggest(lianxiangList,{hot_list:lianxiangList,attachObject:"#"+returnDiv});
			});
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

		// 程辉 2013-5-8 新增 模板下载 
		function downloadExample() {
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=downloadExample";
			document.form2.submit();
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
		}

		//程辉 2013-5-8 新增 导入
		function importXls() {
			var myfileVal = document.getElementById("myFile").value;
			if(myfileVal=="") {
				alert("i18n_gil.message.importFile_n81i");
			}else if((myfileVal.lastIndexOf(".xlsx")+5)!=myfileVal.length && (myfileVal.lastIndexOf(".xls")+4)!=myfileVal.length){
				alert("i18n_gil.message.importCorrectFile_n81i");
			}else if(confirm('i18n_gil.message.sureToImport_n81i')){
				document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=importXls";
				document.form2.submit();
				document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
			}
		}
		//程辉 2013-5-8 新增 导出当前页
		function emportCurrentXls() {
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=emportCurrentXls&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }'+"&jsmc="+$("#jsmc").val();
			document.form2.submit();
			closeDiv();
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
		}
		//程辉 2013-5-8 新增 导出全部
		function emportAllXls() {
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=emportAllXls&jsmc="+$("#jsmc").val();
			document.form2.submit();
			closeDiv();
			document.form2.action = "<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
		}
		function showDiv(){
			document.getElementById('popDiv').style.display='block';
			document.getElementById('bg').style.display='block';
		}

		function closeDiv(){
			document.getElementById('popDiv').style.display='none';
			document.getElementById('bg').style.display='none';
		}
		
		function goGuide(datas) {
			if(datas!=null && datas!=""){
			 	if(datas.resu=='over') {
			 		window.location ="<c:url value='/'/>/sysManage/guideManage!execute.do?action=index";
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
			$("#maindiv").attr("style","clear:left");
			
			if($("#isComplete").val()=='0'){
			//var content = {
		    //    content: '业务系统操作已完成，是否进行下一步操作?',
		    //    buttons: { '下一步': 1, '返回'：0,'取消': -1 },
		    //    buttonsFocus: 0,
		    //    submit: function (v, h, f) {
		    //        if(v == 1) {//执行下一步--用户组
		    //            window.location ="<c:url value='/'/>/sysManage/userGroupPerssion.do?action=query";
		    //        }
		    //       if(v == 0){//返回到设置向导页
		    //            window.location ="<c:url value='/'/>/sysManage/guideManage!execute.do?action=index";
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
		 					packNum:2,
		 					packName:'yhz'
		 				},
		 				function(datas){
		 					goGuide(datas);
		 				},"json");
			
				}
			};
			$.jBox.warning("i18n_gil.message.warning_n81i", "i18n_gil.message.hint_n81i", submit,{icon: false});
		}
			$("#info").floatHeaderDiv();
		});
	</script>
	</head>
	<body>
	<!--中间部分右边开始-->
	<div class="middle_list" style="overflow: hidden;">
		<form name=form2 id="frmArticleType" action="<c:url value='/sysManage/userGroupPerssion.do?action=query'/>" method="post" enctype="multipart/form-data">
		<input type="hidden" name = "isComplete" id="isComplete" value="${isComplete}"/>
		<input type="hidden" name="fromWhere" value="${fromWhere }"/>
		<div id="divTop">
			<div class="box_1"><label class="divTopText"><font class="selectText">i18n_gil.text.userGroup_n81i</font>
				<input type="text"  id="jsmc" onkeyup="lianxiangkeyup('jsmc','XtJsJbxx','String','jsmc','suggest1',this.value);"name="jsmc" title="请输入角色名称" value="${jsmc}" size="30" />
				<div id='suggest1' class="ac_results"></div></label>
				<img src="<c:url value='/images/button_chaxun.png'/>" class="img_middle2" onclick="javascript:qry();"/>
			</div>
			<div class="box_2">
			<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:downloadExample();" value="i18n_gil.button.downloadExample_n81i"/>
								&nbsp;		
			
			<input type="button" value="i18n_gil.text.importXls_n81i" title="i18n_gil.text.importXls_n81i" class="btn3_mouseout" onclick="javascript:uploadFile(this)"/>
								<input type="file" name="myFile" id="myFile" value="" class="filebtn" onchange="javascript:setValue(this.value)"/>
								&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:importXls();" value="i18n_gil.button.importXls_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:showDiv();" value="i18n_gil.button.showDiv_n81i"/>
								&nbsp;					
									
				<jsp:include page="/include/include.jsp"/>
			</div>
			</div>
			<div id="maindiv" >
			<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
				<tr>
					<td class="color_top"> i18n_gil.text.index_n81i </td>
				  	<td class="color_top">i18n_gil.text.userGroup_n81i</td>
					<td class="color_top" >i18n_gil.text.userGroupDesc_n81i</td>
					<td class="color_top">i18n_gil.text.state_n81i</td>
					<td class="color_8" >i18n_gil.text.operation_n81i</td>
				</tr>
				<c:set var="index" value="${(pageNo-1)*page.pageSize+ 1}" />
        		<c:choose>
					<c:when test="${fn:length(allJsInfo) > 0}">
						<c:forEach items="${allJsInfo}" var="aji">
							<c:if test="${index%2 eq 1}">
								<c:set var="tdClass" value="color_1" />
								<c:set var="tdClassR" value="color_7" />
							</c:if>
							<c:if test="${index%2 eq 0}">
								<c:set var="tdClass" value="color_3" />
								<c:set var="tdClassR" value="color_6" />
							</c:if>
							<tr>  
								<td class="${tdClass }">${index}</td> 
			 					<td class="${tdClass }"><a href="javascript:viewUpdateRecord('${aji.jsbh}')">${aji.jsmc}</a></td>								
								<td class="${tdClass }">${aji.jsms}</td>							
								<td class="${tdClass }">
								  <c:if test="${aji.zxbz==0}">
						             <font size="2">i18n_gil.message.state0_n81i</font>
						          </c:if>
						          <c:if test="${aji.zxbz==1}">
							      	<font color="red" size=2>i18n_gil.message.state1_n81i</font>
						          </c:if>
					            </td>
							    <td class="${tdClassR }">
							    	<c:if test="${aji.jsbh gt 100100}">
							    	<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
									<a href="javascript:openUpdateRecord('${aji.jsbh}')">i18n_gil.text.updateInfo_n81i</a>
							  	 	</c:if>
							    </td >							
							</tr>
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5" align="center" class="color_6">
								i18n_gil.text.noRecord_n81i
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			</div>
			<c:if test="${!empty allJsInfo}">
				<div id="divBoot">
					<jsp:include page="/common/page.jsp" />
				</div>
			</c:if>
		</form>
		</div>
		<br/>
		<div id="popDiv" class="mydiv" style="display:none;">
		<input type="hidden" />
			<input type="button" class=btn3_mouseout style="width:100px;"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportCurrentXls();" value="i18n_gil.button.exportCurrentPage_n81i"/>
									&nbsp;
								<input type="button" class=btn3_mouseout style="width:80px"
									onmouseover="this.className='btn3_mouseover'"
									onmouseout="this.className='btn3_mouseout'"
									onmousedown="this.className='btn3_mousedown'"
									onmouseup="this.className='btn3_mouseup'"
									onclick="javascript:emportAllXls();" value="i18n_gil.button.exportAllData_n81i"/>
								&nbsp;<br/>
								<a href="javascript:closeDiv()">i18n_gil.button.closeWindow_n81i</a></div>
								
		<div id="bg" class="bg" style="display:none;"></div>
	</body>
</html>