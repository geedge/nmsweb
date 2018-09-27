<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_ft.message.title_n81i</title>
		<link href="<c:url value='/css/styles.css'/>" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<c:url value="/topo/swfobject.js"/>"></script>

		<script type="text/javascript">
		function inint()
		{
			if(document.getElementById("topo") != null)
			{
				document.getElementById("topo").focus();
			}
		}
		</script>

		<script language="javascript" type="text/javascript">
			var contentpath = "<%=request.getContextPath()%>";
		
		   	var swfVersionStr = "10.0.0";
            var xiSwfUrlStr = contentpath+"/topo/playerProductInstall.swf";
          	var pathflash =  contentpath+"/topo/topo.swf";
          	var flashvars = {"context":contentpath};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.wmode="transparent";
            var attributes = {};
            attributes.id = "topo";
            attributes.name = "topo";
            attributes.align = "middle";
            swfobject.embedSWF(
            		pathflash, "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
	</head>

	<body onload="inint();" style="margin:0 0;padding:0 0" style="overflow: hidden;">
		<!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
			 JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
			 when JavaScript is disabled.
		-->
		<div id="flashContent"  align="center" style="font-size:14px; visibility:hidden;margin: 100 200">
			<p>
				i18n_ft.message.flashContent_n81i
				<script type="text/javascript"> 
					var contentpathforimage = "<%=request.getContextPath()%>";
					document.write("<a href='"+contentpathforimage+"/download/downLoadFile!download.do?file=flashplayer11_install.exe'>i18n_ft.message.flashUrl_n81i</a>" );
				</script>
			</p>
		</div>

		<noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="topo">
                <param name="movie" value="<%=request.getContextPath()%>/topo/topo.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
                <param name="wmode" value="transparent">
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="<%=request.getContextPath()%>/topo/topo.swf" width="100%" height="100%">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowFullScreen" value="true" />
                <!--<![endif]-->
                    <div align="center" style="font-size:14px;margin: 100 200">
						i18n_ft.message.noJsOrFlash_n81i
						<a href='<%=request.getContextPath()%>/download/downLoadFile!download.do?file=flashplayer11_install.exe'>i18n_ft.message.flashUrl_n81i</a>
					</div>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
	    </noscript>
	</body>
</html>
