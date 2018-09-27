<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
        <!-- 弹出对话框 -->
		<script src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />

	</head>

	<script language="javascript" type="text/javascript">	

		$(function() {			
			$( "#downloadDialog" ).dialog({
				autoOpen: false,
				minWidth: 240,
				modal: true
			});
		});
		function download(name){
			$("#downloadDialog").dialog('close');
			window.open("<c:url value='/download/downLoadFile!download.do' />?file=" + name,"","height=0,width=0,top=10000,left=10000");
		}
		function svgDownloadConn(){		
			var fso = new ActiveXObject("Scripting.FileSystemObject");			
			$("#downloadDialog").empty();
		 	$("#downloadDialog").append("i18n_remoteConn.text.svgMsg_n81i！</br></br> <a href='javascript:download(\"SVGView.EXE\");' ><strong>i18n_remoteConn.text.down_n81i</strong></a>");
		 	$("#downloadDialog").dialog("open");
			return;
		}
    </script>
	<body>			
			<div id="downloadDialog" style="display: none;font-size:14px;margin-top:10px;" title="i18n_remoteConn.text.download_n81i" align="center">
			</div>
	</body>
</html>

