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
		<title>i18n_eil.message.title_n81i</title>
		<link href="<c:url value='/css/nms.css'/>" rel="stylesheet"
			type="text/css" />
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/onmouse.js'/>"></script>
		<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery.suggest.js'/>"></script>
		<script type="text/javascript">
			
		    function addRecord(){
		        document.form1.action = "<%=path%>/sysManage/sysErrorManage!execute.do?action=openAddError&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
			    document.form1.submit();
			}
			function updateRecord(id){
				document.form1.action = "<%=path%>/sysManage/sysErrorManage!execute.do?action=openUpdError&erid="+id+"&pageNo="+'${pageNo }'+"&pageSize="+'${pageSize }';
				document.form1.submit();
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
			});
			
		</script>
	</head>
	<body>
		<div class="middle_list" style="overflow: hidden;">
			<form name=form1 id="form1" action="<c:url value='/sysManage/sysErrorManage!execute.do'/>" method="post" >
				<!--中间部分右边开始-->
				<div id="divTop">
					<div class="box_1">
						&nbsp;
					</div>
					<div class="box_2">&nbsp;
						<input type="button" class=btn3_mouseout
								onmouseover="this.className='btn3_mouseover'"
								onmouseout="this.className='btn3_mouseout'"
								onmousedown="this.className='btn3_mousedown'"
								onmouseup="this.className='btn3_mouseup'" 
								onclick="addRecord();" value="i18n_eil.button.add_n81i"/>
					</div>
				</div>
				<div id="maindiv">
				<table border="0" cellpadding="0" cellspacing="0" class="table" id="info">
					<tr>
						<td class="color_top" width="4%">
							i18n_eil.text.index_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.troubleCode_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.troubleInfo_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.troubleDescr_n81i
						</td>
						<td class="color_top" width="12%">
							i18n_eil.text.systemName_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.createUser_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.createDate_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.lastUpUser_n81i
						</td>
						<td class="color_top" width="8%">
							i18n_eil.text.lastUpDate_n81i
						</td>
						<td class="color_top" width="6%">
							i18n_eil.text.state_n81i
						</td>
						<td class="color_8" width="12%">
							i18n_eil.text.operation_n81i
						</td>
					</tr>
					<c:set var="index" value="${1}" />
					<c:choose>
						<c:when test="${fn:length(allErrorInfo) > 0}">
							<c:forEach items="${allErrorInfo}" var="aui" varStatus="vs">
								<input type="hidden" id="erbh${aui.id }"
									name="erbh${aui.id }" value="${aui.id}" />
								<c:set var="color" value="color_1" />
								<c:set var="color_end" value="color_7" />
								<c:if test="${vs.count%2!=0 }">
									<c:set var="color" value="color_3" />
									<c:set var="color_end" value="color_6" />
								</c:if>
								<tr>
									<td class="${color }">
										${index+(pageNo-1)*pageSize}
									</td>
									<td class="${color }">
										${aui.troubleCode}
									</td>
									<td class="${color }">
										${aui.troubleInfo}
									</td>
									<td class="${color }">
										${aui.troubleDescr}
									</td>
									<td class="${color }">
										${aui.system.systemName}
									</td>
									<td class="${color }">
										${aui.createUser.yhmc}
									</td>
									<td class="${color }">
										<fmt:formatDate
												value="${aui.createDate}" type="both" />
									</td>
									<td class="${color }">
										${aui.lastUpUser.yhmc}
									</td>
									<td class="${color }">
										<fmt:formatDate
												value="${aui.lastUpDate}" type="both" />
									</td>
									<td class="${color }">
										<c:choose>
											<c:when test="${aui.state==0}">
												i18n_eil.message.state0_n81i
											</c:when>
											<c:otherwise>
												<font color="red">i18n_eil.message.state1_n81i</font>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="${color_end }">
										<img src="<c:url value='/images/logo_1.png'/>" class="img_middle" />&nbsp;
										<a href="javascript:updateRecord('${aui.id}')">i18n_eil.text.updateInfo_n81i</a>
									</td>
								</tr>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="11" height="35" class="color_6" align="center">
									i18n_eil.text.noRecord_n81i
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				</div>
				<c:if test="${!empty allErrorInfo}">
					<div id="divBoot">
						<jsp:include page="/common/page.jsp" />
					</div>
				</c:if>
				<!--中间部分右边结束-->
			</form>
		</div>
	</body>
</html>
