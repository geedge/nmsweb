<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>

<%-- 
	/**
	 * 远程连接
	 * 1、流程：先查看节点类型，若是交换机直接Telnet连接；若是服务器，先查看是否有指定操作系统类型
	 * 	  A、有，直接连接，Linux下用putty.exe(检查文件是否存在，不存在提供下载),Windows下用mstsc远程桌面
	 *    B、没有，提示选择操作系统类型
	 * 2、操作步骤：
	 *    A、在调用远程连接之前，要在原有的SQL基础上添加对note_table的node_system_type和node_type的查询
	 *    B、在调用远程连接的页面，include引入/common/remoteConn.jsp页面
	 *    C、在相应IP连接处调用JS--romoteConn(nodeSysType,ip)
	 */
--%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_remoteConn.text.title_n81i</title>
        <!-- 弹出对话框 -->
		<script src="<c:url value='/js/ui/jquery-ui.min.js'/>"></script>
		<link rel="stylesheet" href="<c:url value='/css/themes/base/jquery.ui.all.css'/>" />

	

	<script language="javascript" type="text/javascript">
	//---------2012-7-2 用于远程连接时，若没有指定操作系统弹出选择框
	$(function() {
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		var	tips = $( ".validateTips" );
	
		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}
		
		$( "#dialog" ).dialog({
			autoOpen: false,
			//resizable: true,
			//height: 160,
			width: 260,
			modal: true,
			buttons: {
				"i18n_remoteConn.text.sure_n81i": function() {
				    var valStr = document.getElementById("osType").value;
					if($("#nodeSysType>option:selected").size()>0 && valStr!='i18n_remoteConn.text.select_n81i'){
				 		runRemoteConn(valStr,$("#ip").val());
						$(this).dialog( "close" );
	    			}else {
	    				updateTips("i18n_remoteConn.text.unknow_n81i！");
	    			}
				},
				"i18n_remoteConn.text.cancel_n81i": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		$( "#downloadDialog" ).dialog({
			autoOpen: false,
			minWidth: 260,
			modal: true
		});
	});
	
	var isDone = true;
	var timeout;
	var assistEl;
	var triggerEl;
	
	function remoteConn(nodeSysType,ip,nodeType, btn){//nodeSysType 操作系统类型   ip 远程连接的节点IP nodeType 节点类型
		assistEl = btn;
		triggerEl = document.getElementById('trigger_protocol_ifrm');
		
		if(nodeType != null && nodeType != "" && nodeType != "0"){// 节点类型不是服务器，即是交换机，则默认使用Telnet连接
			runRemoteConn('3', ip)
		} else if (nodeSysType == null || nodeSysType == "") {// 节点类型是服务器，则判断系统类型
			$("#ip").val(ip);
			$("#dialog").dialog("open");
		} else {
			runRemoteConn(nodeSysType, ip);
		}
	}
	
	function download(name){
		$("#downloadDialog").dialog("close");
		window.open("<c:url value='/download/downLoadFile!download.do' />?file=" + name,"","height=0,width=0,top=10000,left=10000");
	}
	
	function runRemoteConn(sysType, ip) { //sysType 操作系统类型   ip 远程连接的节点IP
		var protocolUrl = "nmsweb.yuanchenglianjie://establishing?";
		if (sysType == "1") {
			protocolUrl += "method=putty&ip=" + ip
		} else if (sysType == "2") {
			protocolUrl += "method=mstsc&ip=" + ip
		} else {
			protocolUrl += "method=telnet&ip=" + ip
		}
		
		launchApplication(protocolUrl, 
			function(){<%--success --%>}, 
			function() {<%--fail --%>
				$("#downloadDialog").empty();
			 	$("#downloadDialog").append("i18n_remoteConn.text.downMsg_n81i！ <a href='javascript:download(\"nmsweb.msi\");'>i18n_remoteConn.text.down_n81i</a>");
			 	$("#downloadDialog").dialog("open");
				return;
			}
		);
	}

    function done(){
        isDone = true;  
        assistEl.onblur = null;
        triggerEl.onerror = null;
        clearTimeout(timeout);
    }

    function launchApplication(url, success, fail){

        if (!isDone) return;//如果上次调起客户端没有完成，则直接返回，防止重复调用。  
            isDone = false;  
      
            assistEl.focus();  
            assistEl.onblur = function () {
            if (document.activeElement && document.activeElement !== assistEl) {  
                assistEl.focus(); //防止用户因为随机操作，而误认为是调起了客户端。  
            } else {  
                done();  
                success();//如果焦点元素，快速失去了焦点，说明客户端已经被调起。  
            }  
        };
        timeout = setTimeout(function () {
            done();
            fail();//如果超过一定时间仍然没有变化，说明没有注册协议  
        },1200);
        triggerEl.onerror = function () {
            done();
            fail();//进入错误事件回调函数说明没有注册协议
        };  
        try {
            triggerEl.src = url;  
        } catch(e) {
            done();
            fail(); //捕获到异常说明没有注册协议
        }   
    }
	</script>
    </head>
	<body>
	
			<iframe id="trigger_protocol_ifrm" style="display:none">
			</iframe>
	
			<div id="dialog" style="display: none" title="i18n_remoteConn.message.title_n81i">
			<fieldset style="padding:0; border:0; margin-top:0px;margin-buttom:10px;">
				<p class="validateTips"></p>
				<label>i18n_remoteConn.text.sysType_n81i</label>
				<select name="nodeSysType" id="nodeSysType" class="text ui-widget-content ui-corner-all" onchange="document.getElementById('osType').value=this.value;">
					<option>i18n_remoteConn.text.select_n81i</option>
					<option value="1">Linux</option>
					<option value="2">Windows</option>
					<option value="3">Other</option>
				</select>
				<input type="hidden" name="ip" id="ip" value=""/>
				<input type="hidden" name="osType" id="osType" value=""/>
			</fieldset>
			</div>
			
			<div id="downloadDialog" style="display: none;font-size:14px;margin-top:10px;" title="i18n_remoteConn.text.download_n81i">
			</div>
	</body>
</html>

