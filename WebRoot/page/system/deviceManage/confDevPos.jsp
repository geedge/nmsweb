<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib uri="/jstl/fn" prefix="fn"%>
<%@ taglib uri="/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Pragma","No-Cache");	
	response.setHeader("Cache-Control","No-Cache");	
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=" http://www.w3.org/1999/xhtml">
<head>
    <title>i18n_cdp.message.title_n81i</title>
    <link href="<c:url value='/css/nms.css'/>" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript"
			src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
    <style type="text/css">
        div
        {
            position: absolute;  /*Div设置为position: absolute;才可以设置zIndex*/
        }
		
	</style>
    <script type="text/javascript">
    	document.onmousemove = function (a) {//鼠标移动
    	 	if (!a) a = window.event; //移动时创建一个事件
        }
        
        //暂时无用
        function replaceSpecChars(str) {
        	return str.replace(new RegExp("[+]","g"),"\\\\+");//替换+，+为特殊字符
        }
        
        function getAttributeValueById(id,attrStr) {
        	var ele = document.getElementById(id);
        	return ele.getAttribute(attrStr);
        }
        
        function getAttributeValueByEle(ele,attrStr) {
        	return ele.getAttribute(attrStr);
        }
        var keydownscrollTop;
        window.onscroll=function() {
			var scrollTop = document.documentElement.scrollTop;
			if(${devScrollHeight=='0'}) {//devScrollHeight可能为98%
				return false;
			}else if(scrollTop>=${devScrollHeight}){
				return false;
			}
			
			var backBut = document.getElementById("backBut");
			backBut.style.top = scrollTop +5;
			
			jQuery("div[id^='div_']").each(function() {
				var divId = this.id;
				//var  devCode = divId.split("_")[1];//设备型号
				var  devCode = divId.substring(4);//设备型号
				var initDivId = "initDivTop_"+devCode;
				var initTextId = "initTextTop_"+devCode;
				var initDivTop = document.getElementById(initDivId).value;//当ID中包含"+"时,jQuery获取不到元素
				var initTextTop = document.getElementById(initTextId).value;
				
				var newTop = "";
				if(isEndWith(divId,'_name')) {
					newTop = initTextTop;
				}else if(isEndWith(divId,'_backImg')) {
					newTop = initDivTop;
				}else {
					newTop = initDivTop;
				}				
				var sum = Number(newTop)+Number(scrollTop);//不能再加字符，否则之前的数字也按字符串进行相加
				this.style.top = sum+"px";	
				
			});
			
			var subDevSele = document.getElementById("subDevSelect");
			var sumSubTop = Number(40) + Number(scrollTop);
			subDevSele.style.top = sumSubTop+"px";	
			  
			var noteStrELe = document.getElementById("noteStr");
			var sumNoteTop = Number(130) + Number(scrollTop);
			noteStrELe.style.top = sumNoteTop+"px";	
			
		} 
		
		//判断str是否以endStr结尾
		function isEndWith(str,endStr) {
			var strLen = str.length;
			var endStrLen = endStr.length;
			if(endStrLen<=strLen) {
				var subStr = str.substring((strLen-endStrLen),strLen);
				if(subStr==endStr) {
					return true;
				}else {
					return false;
				}
			}else{ 
				return false;
			}
		}
        
    	var count = 1;//设备div的ID为：div_${device.deviceCode}+"_ture"+count;
    	var deviceCount = 1;
    	var zIndexCount = 1000;//zIndex的最大值为20多亿,zIndex必须设置position为absolute或者fixed等      
    	
        
        //鼠标down时的坐标
        var startX;
        var startY;
        var selectedDiv;
        var indstanceDivId = "selectedDivInstance";
        
        function createInstanceDiv() {
        	var instanceDiv = document.createElement("div");
            instanceDiv.setAttribute("id",indstanceDivId);
            instanceDiv.style.width = "1"+"px";
            instanceDiv.style.height = "1"+"px";
            instanceDiv.style.left = 10+"px";
            instanceDiv.style.top = 10+"px";
            instanceDiv.style.border = "1px solid red";
            instanceDiv.style.zIndex = 1000;
             
            document.deviceConfigForm.appendChild(instanceDiv);
            
            //给选中区域添加选中事件---暂时不使用
            dragMouseToCreateDiv(indstanceDivId);
        }
        
        function dragMouseToCreateDiv(objId) {
            if (typeof objId == "string") {
                var obj = document.getElementById(objId);  
            }
            //调用当前div的mousedown事件的同时，调用document的mousemove和mouseup事件            
            //调用document的mousemove和mouseup事件
            obj.onmousedown = function(event) {
                //jQuery("#indexStr2").val("mouseDown"+countTmp);   
                //countTmp = countTmp+1;
                //底图的范围：只可在底图范围内进行选择（选择区域也可以选择）
                var widthTmp = ${devType.figureWidth};
                var heightTmp = ${devType.figureHeight};
                var xTmp = ${rootDeviceX};
                var yTmp = ${rootDeviceY};
                var xMaxTmp =  xTmp+widthTmp;
                var yMaxTmp =  yTmp+heightTmp;
                
                //当前鼠标的坐标          
	    	 	var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
	    	 	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	    	 	
	    	 	if(navigator.userAgent.indexOf("MSIE")>0) {  
       		  		var startX = Number(window.event.clientX)+Number(scrollLeft);
	    	        var startY = Number(window.event.clientY)+Number(scrollTop);
   				}else if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
	   				var e = event ? event : window.event;
			        	x = e.clientX;
			        	y = e.clientY;
				    var startX = Number(x)+Number(scrollLeft);
	    	        var startY = Number(y)+Number(scrollTop);
   				}
	    	 	
                if(xTmp<=startX && startX<=xMaxTmp && yTmp<=startY && startY<=yMaxTmp) {
	            	//设置frame外捕获鼠标事件
	                if(obj.setCapture) {
	                	obj.setCapture();
	                }else if(window.captureEvents) {
						window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
	                }
	                
	            	var curDevCode = jQuery("input:checked[name=devTypeForPosition]").val();//单选钮方式
	            	
	            	var selecDevCode = jQuery("select[id='confDevCode'] option:selected").val();//下拉列表方式
	            	var a = window.event;
	            	//鼠标down的时候，创建一个div
	            	var selectDiv = document.getElementById(indstanceDivId);
	            	selectDiv.style.width = "1"+"px";
	                selectDiv.style.height = "1"+"px";
	            	selectDiv.style.left = startX+"px";
	            	selectDiv.style.top = startY+"px";
	            	selectDiv.style.zIndex = 1000;
	            	var divFinalWidth = 1;
	            	var divFinalHeight = 1;
	            	
	            	document.onmousemove = function (event) {//鼠标移动
	                    if (!a) a = window.event; //移动时创建一个事件
	                    //改变div的大小和位置
	                    var curScrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
		    	 		var curScrollTop = document.documentElement.scrollTop || document.body.scrollTop;
		    	 		if(navigator.userAgent.indexOf("MSIE")>0) {  
       		  				var curX = Number(window.event.clientX)+Number(curScrollLeft);
		    	 			var curY = Number(window.event.clientY)+Number(curScrollTop);
   						}else if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
	   						var s = event ? event : window.event;
				        		x = s.clientX;
				        		y = s.clientY;
				    		var curX = Number(x)+Number(curScrollLeft);
		    	 			var curY = Number(y)+Number(curScrollTop);
   						}
	                    
	                    var subtractX  = Number(curX)-Number(startX);
	                    var subtractY  = Number(curY)-Number(startY);
	                    divFinalWidth = Math.abs(subtractX);
	                    divFinalHeight = Math.abs(subtractY);
	                    selectDiv.style.width = divFinalWidth+"px";
	            		selectDiv.style.height = divFinalHeight+"px";
		                
		                var finalX = startX-${rootDeviceX};
		                var finalY = startY-${rootDeviceY};
	            		jQuery("#PosSelect_X_"+selecDevCode).val(finalX);
		                jQuery("#PosSelect_Y_"+selecDevCode).val(finalY);
		                jQuery("#PosSelect_Width_"+selecDevCode).val(divFinalWidth);
		                jQuery("#PosSelect_Height_"+selecDevCode).val(divFinalHeight);
		                //jQuery("#Pos_Show_For_All").val(startX+","+startY);
		                //jQuery("#Pos_Show_For_All").val(startX+","+startY+","+divFinalWidth+","+divFinalHeight);
		                jQuery("#Pos_Show_For_All").val("X:"+finalX+",Y:"+finalY+",W:"+divFinalWidth+",H:"+divFinalHeight);
	                
	                }
	                
	                document.onmouseup = function (a) {//鼠标up：为div增加双击事件（双击时，生成input：子设备对应的坐标位置,双击时，div的大小为0）；单击拖拽事件（可以拖动div的位置）；改变div大小的事件
	                 	document.onmousemove = null;
	                 	  //取消frame外捕获鼠标事件
		                if(obj.releaseCapture) {
		                	obj.releaseCapture();
		                }else if(window.captureEvents) {
							window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
		                }
	                }
                }
            };
             document.getElementById("confDevCode").blur();
      }
      
     
     function isNotBlank(obj) {
     	if(obj!="" && obj!=null && obj!='undefined') {
     		return true;
     	}else {
     		return false;
     	}
     }
     
     
     //新增位置配置
     function add() {
	    /*for(var prop in map){
	     	alert(prop);
	     	alert(map[prop]);
	     }*/
	    var jsonMap = JSON.stringify(map);
	    $("input[name=jsonStr]").val(jsonMap);
	   	document.deviceConfigForm.action="<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=addDevicePos&devtype="+'${devType.deviceTypeCode}';
	   	document.deviceConfigForm.submit();
     	
    	jQuery("#addButton").attr("disabled","true");
		jQuery("#backButton").attr("disabled","true");
     }
     
     function goBack() {
     	 document.deviceConfigForm.action="<%=path%>/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch=${devTypeCodeForSearch}&devRandCodeForSearch=${devRandCodeForSearch}&parDevId=${parDevId}";
	     document.deviceConfigForm.submit();
     }
     
     var map = {};//key子设备--value板卡集合
     function changeDevCode() {
        var selecDevCode = jQuery("select[id='confDevCode'] option:selected").val();//下拉列表方式
        var xTmp = jQuery("#PosSelect_X_"+selecDevCode).val();
		var yTmp = jQuery("#PosSelect_Y_"+selecDevCode).val();
		var widthTmp = jQuery("#PosSelect_Width_"+selecDevCode).val();
		var heightTmp = jQuery("#PosSelect_Height_"+selecDevCode).val();
        
        if(isNotBlank(xTmp) || isNotBlank(yTmp)) {
            var xSum = Number(xTmp)+Number(${rootDeviceX});
            var ySum = Number(yTmp)+Number(${rootDeviceY});
			jQuery("#Pos_Show_For_All").val("X:"+xTmp+",Y:"+yTmp+",W:"+widthTmp+",H:"+heightTmp);
		}else {
			jQuery("#Pos_Show_For_All").val('');
		}
		var selectDiv = document.getElementById(indstanceDivId);
		if(isNotBlank(selectDiv) && isNotBlank(xTmp) && isNotBlank(yTmp) && isNotBlank(widthTmp) && isNotBlank(heightTmp)) {
		    var xSum = Number(xTmp)+Number(${rootDeviceX});
            var ySum = Number(yTmp)+Number(${rootDeviceY});
	        selectDiv.style.left = xSum+"px";
	        selectDiv.style.top = ySum+"px";
	 		selectDiv.style.width = widthTmp+"px";
	        selectDiv.style.height = heightTmp+"px";
		}else {
			selectDiv.style.width = "0"+"px";
	        selectDiv.style.height = "0"+"px";
	        selectDiv.style.left = 10+"px";
	        selectDiv.style.top = 10+"px";
		}
		var count = 0;
		jQuery("#banka").find("option").each(function (){
			count++;
			});
		if(count == 1){
			jQuery("#bkwz").hide();
			jQuery("#banka").hide();
			}
		if(map[$("#confDevCode").val()]!=undefined){
			$("#bankaVal").val("");
			var arr = map[$("#confDevCode").val()];
			var str = arr.join(",");
			$("#bankaVal").val(str);
			$("#banKaTip").html("");
			var str = arr.join("<br>");
			$("#banKaTip").html(str);
		}else{
			jQuery.post("<c:url value='/sysManage/deviceBrandManage!ajaxGetBanKa.do' />",{bcname:jQuery("select[id='confDevCode'] option:selected").val(),deviceTypeCode:'${devType.deviceTypeCode}'},function(data,textStatus){
				$("#bankaVal").val("");
				var arr = eval(data);
				var str = arr.join(",");
				$("#bankaVal").val(str);
				$("#banKaTip").html("");
				var str = arr.join("<br>");
				$("#banKaTip").html(str);
				map[$("#confDevCode").val()]=eval(data);
			});
		}
		document.getElementById("confDevCode").blur();
     }


     function checkVal(){
     	var selecDevCode = jQuery("select[id='confDevCode'] option:selected").val();//下拉列表方式
        var xTmp = jQuery("#PosSelect_X_"+selecDevCode).val();
		var yTmp = jQuery("#PosSelect_Y_"+selecDevCode).val();
		var widthTmp = jQuery("#PosSelect_Width_"+selecDevCode).val();
		var heightTmp = jQuery("#PosSelect_Height_"+selecDevCode).val();
        
        if(isNotBlank(xTmp) || isNotBlank(yTmp)) {
            
            var xSum = Number(xTmp)+Number(${rootDeviceX});
            var ySum = Number(yTmp)+Number(${rootDeviceY});
			jQuery("#Pos_Show_For_All").val("X:"+xTmp+",Y:"+yTmp+",W:"+widthTmp+",H:"+heightTmp);
		}else {
			jQuery("#Pos_Show_For_All").val('');
		}
     }
     
     $(function(){
    	 keydownFun();
     });

  function keydownFun(event){
     document.onkeydown = function switchDev(event) {
        var e = event ? event : window.event;
        var keyValTmp = e.keyCode||e.which;
        
        //38:上箭头，40：下箭头, 37:左箭头，39：右箭头  width  height
        var selecDevCode = jQuery("select[id='confDevCode'] option:selected").val();//下拉列表方式
       	
       	var selectDiv = document.getElementById(indstanceDivId);
       	var oldHeight = 1;
       	var oldWidth = 1;
       	var oldLeft = 10;
       	var oldTop = 10;
       	if(isNotBlank(selectDiv)) {
			   oldHeight = selectDiv.style.height;
			   oldWidth = selectDiv.style.width;
			   oldLeft = selectDiv.style.left;
			   oldTop = selectDiv.style.top;
			   if(oldHeight.length>=3) {
			    	oldHeight = oldHeight.substr(0,oldHeight.length-2);
			   }
			   if(oldWidth.length>=3) {
			    	oldWidth = oldWidth.substr(0,oldWidth.length-2);
			   }
			   if(oldLeft.length>=3) {
			    	oldLeft = oldLeft.substr(0,oldLeft.length-2);
			   }
			   if(oldTop.length>=3) {
			    	oldTop = oldTop.substr(0,oldTop.length-2);
			   }
	    }
	    
        if(e.ctrlKey && keyValTmp==38)　{//ctrl+↑:向上切换设备
        	var prevText = $("#confDevCode option:selected").prev().text();
        	if(prevText!=""){
				$("#confDevCode option:selected").prev().attr("selected","selected");	
				$("#confDevCode").change();        	
        	}
        	if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
        }else if(e.ctrlKey && keyValTmp==40) {//ctrl+↓:向下切换设备
        	var nextText = $("#confDevCode option:selected").next().text();
        	if(nextText!=""){
	        	$("#confDevCode option:selected").next().attr("selected","selected");
	        	$("#confDevCode").change();
        	}
        	if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
        }else if(e.shiftKey && keyValTmp==38)　{//shift+↑:缩小高度
			if(oldHeight>1) {
		    	var heightVal = Number(oldHeight)-Number(1)
		        selectDiv.style.height = heightVal+"px";
		        
		        oldLeft = oldLeft-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_Height_"+selecDevCode).val(heightVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+oldTop+",W:"+oldWidth+",H:"+heightVal);
			}
			if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
        }else if(e.shiftKey && keyValTmp==40) {//shift+↓:扩大高度
		    //if(oldHeight>=1) {//此处可以不加条件，因为是增加高度
		    	var heightVal = Number(oldHeight)+Number(1)
		        selectDiv.style.height = heightVal+"px";
		        
		        oldLeft = oldLeft-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_Height_"+selecDevCode).val(heightVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+oldTop+",W:"+oldWidth+",H:"+heightVal);
		    //}
			if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
        }else if(e.shiftKey && keyValTmp==37)　{//shift+←:缩小宽度
		    if(oldWidth>1) {
		    	var widthVal = Number(oldWidth)-Number(1);
		        selectDiv.style.width = widthVal+"px";
		        
		        oldLeft = oldLeft-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_Width_"+selecDevCode).val(widthVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+oldTop+",W:"+widthVal+",H:"+oldHeight);
		    }
        	
        }else if(e.shiftKey && keyValTmp==39) {//shift+→:扩大宽度
        	 //if(oldWidth>=1) {
		    	var widthVal = Number(oldWidth)+Number(1);
		        selectDiv.style.width = widthVal+"px";
		        
		        oldLeft = oldLeft-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_Width_"+selecDevCode).val(widthVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+oldTop+",W:"+widthVal+",H:"+oldHeight);
		    //}
        	
        }else if(keyValTmp==37)　{//←:向左移动选中区域
		    if(oldLeft>=1) {
		    	var xVal = Number(oldLeft)-Number(1);
		        selectDiv.style.left = xVal+"px";
		        
		        xVal = xVal-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_X_"+selecDevCode).val(xVal);
		        jQuery("#Pos_Show_For_All").val("X:"+xVal+",Y:"+oldTop+",W:"+oldWidth+",H:"+oldHeight);
		    }
			
        }else if(keyValTmp==39) {//→:向右移动选中区域
        	 if(oldLeft>=1) {
		    	var xVal = Number(oldLeft)+Number(1);
		        selectDiv.style.left = xVal+"px";
		        
		        xVal = xVal-${rootDeviceX};
		        oldTop = oldTop-${rootDeviceY};
		        jQuery("#PosSelect_X_"+selecDevCode).val(xVal);
		        jQuery("#Pos_Show_For_All").val("X:"+xVal+",Y:"+oldTop+",W:"+oldWidth+",H:"+oldHeight);
		    }
			
        }else if(keyValTmp==38)　{//↑：向上移动选中区域
		    if(oldTop>=1) {
		    	var yVal = Number(oldTop)-Number(1);
		        selectDiv.style.top = yVal+"px";
		        
		        yVal = yVal-${rootDeviceY};
		        oldLeft = oldLeft-${rootDeviceX};
		        jQuery("#PosSelect_Y_"+selecDevCode).val(yVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+yVal+",W:"+oldWidth+",H:"+oldHeight);
		    }
			
			if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
			
        }else if(keyValTmp==40) {//↓：向下移动选中区域
        	if(oldTop>=1) {
		    	var yVal = Number(oldTop)+Number(1);
		        selectDiv.style.top = yVal+"px";
		        
		        yVal = yVal-${rootDeviceY};
		        oldLeft = oldLeft-${rootDeviceX};
		        jQuery("#PosSelect_Y_"+selecDevCode).val(yVal);
		        jQuery("#Pos_Show_For_All").val("X:"+oldLeft+",Y:"+yVal+",W:"+oldWidth+",H:"+oldHeight);
		    }
			
			if(e.preventDefault) {
	        	e.preventDefault();//FF
	        }else {
	        	e.returnValue = false;//IE
	        }
        }
     };
     document.getElementById("confDevCode").blur();
     }
     document.onclick = function devFocus() {
     	//document.getElementById("confDevCode").focus();
     };
     
     function selectBanKa(){
     	var url = "<%=path%>/sysManage/deviceBrandManage!executeAction.do?action=selectBanKa&posParDevId=${devType.deviceTypeCode }&bcname="+jQuery("select[id='confDevCode'] option:selected").val();
     	/* var result = window.showModalDialog(url, window, 'dialogHeight:430px;dialogWidth:850px;status:no;resizable:no'); */
     	//改为layer-20180831-chenjs---
		parent.layer.open({
			type: 2,
			title: "i18n_sbk.text.selectBK_n81i",
			area:['850px', '470px'],
			shade: 0.6,
			closeBtn: 1,
			maxmin:true,
			content: url,
			end: function(){
				var str = $("#temp").val();
				if (str) {
					var arr = str.split(",");
			     	$("#bankaVal").val(str);
			     	$("#banKaTip").html("");
					var str = str.replace(/,/g, "<br>");
					$("#banKaTip").html(str);
					map[jQuery("select[id='confDevCode'] option:selected").val()]=arr;
				}
			}
		});
		/* var loop = setInterval(function(){
			if(newWindow.closed) {
				clearInterval(loop);
				var str = $("#temp").val();
				var arr = str.split(",");
		     	$("#bankaVal").val(str);
		     	$("#banKaTip").html("");
				var str = str.replace(/,/g, "<br>");
				$("#banKaTip").html(str);
		     	map[jQuery("select[id='confDevCode'] option:selected").val()]=arr;
			};
		}, 500); */
		
     	//把选择的板卡显示到文本框中
     	/* if(result!=undefined){
	     	$("#bankaVal").val("");
	     	var str = result.join(",");
	     	$("#bankaVal").val(str);
	     	$("#banKaTip").html("");
			var str = result.join("<br>");
			$("#banKaTip").html(str);
	     	map[jQuery("select[id='confDevCode'] option:selected").val()]=result;
     	} */
     }
     function showTitle(showContentSpanId,obj,event) {
		//当前鼠标的坐标          
   	 	var scrollLeft = document.documentElement.scrollLeft;
   	 	var event = event ? event : window.event;
   	 	var startX = Number(event.clientX)+Number(scrollLeft);
		//span的坐标及宽度
		var instanceDiv = document.getElementById(showContentSpanId);
        var spanRealWidth = 200;
        if(instanceDiv!=null && instanceDiv!='undefined') {
	       if(navigator.userAgent.indexOf("MSIE")>0) {  
        		 instanceDiv.style.left = startX-80+"px";
   		   }  
		   if(navigator.userAgent.indexOf("Firefox")>0){  
		       instanceDiv.style.left = startX-100+"px";
		   }
	        instanceDiv.style.top =60+"px";
	        $(instanceDiv).css("width",spanRealWidth);//宽度为当前鼠标的位置到最右边窗口的距离  
	        instanceDiv.style.zIndex = 1000;
        }  
		$("#"+showContentSpanId).show();
	}
	function hideTitle(showContentSpanId) {
		$("#"+showContentSpanId).hide();
	}
    </script>
</head>
<body style="font-size: 12px;-moz-user-select:none;" onselectstart="return false;" unselectable="on" >
<form id="deviceConfigForm"  action="" name="deviceConfigForm" method="post">
	
	<input id="temp" type="hidden"/>
	
	<input  name="jsonStr" type="hidden" />

	<input id="indexStr" type="hidden" />
	<input id="kuangPosi0" type="hidden" />
	<input id="kuangPosi1" type="hidden" />
	<input id="kuangPosi2" type="hidden" />
	<input id="kuangPosi3" type="hidden" />
	<input id="kuangPosi4" type="hidden" />
	<input id="kuangPosi5" type="hidden" />
	<input id="kuangPosi6" type="hidden" />
	<input id="kuangPosi7" type="hidden" />
	<input id="kuangPosi8" type="hidden" />
	<input id="kuangPosi9" type="hidden" />
	<input id="kuangPosi10" type="hidden" />
	<input id="kuangPosi11" type="hidden" />
	<input id="oldXY" type="hidden" />
	<input id="listSize" type="hidden" />
	<!-- 以上均为调试使用的input -->

	<input id="seqId" name="seqId" value="${seqId}" type="hidden"/>
	<input id="BanKaAndBanCao" name="pzbkbc" value="" type="hidden"/>
	<input name="posParDevId" value="${devType.deviceTypeCode }" type="hidden"/>
	<input id="bankaselect" value="" type="hidden"/>
	<input id="nouse" value="" type="hidden"/>
	<input id="bankanouse" value="" type="hidden"/>
	 <table border="0" cellpadding="0" cellspacing="0"  style="width:100%;height: 90%;margin-top: 5px;">
	   <tr>
	   		<td width="5%">
		     <div style="left: 550px;top:7px;">
			   	i18n_cdp.text.deviceTypeCode_n81i：${devType.deviceTypeCode}
		   	 <div>
		   	</td>
		   <td width="20%">  
		   <div id="subDevSelect" style="left: 80px;top:40px;">
				   i18n_cdp.text.confDevCode_n81i：<select id="confDevCode" onchange="changeDevCode();" onkeyup="this.blur();this.focus();" style="margin-left:10px;">
				            <c:forEach items="${devTypeForPosList}" var="device" >
							  	  <option  value="${device.deviceTypeCode}"  >${device.deviceTypeCode}</option>
							</c:forEach>
				   </select>
				   <input type="text" value=""  id="Pos_Show_For_All"  readonly="readonly" size="20"  onfocus="checkVal();"/>  
				   <br/><br/>
				  <c:if test="${devType.showLevel==1 && devType.isLeaf==0 && devType.pid==0 }">
					 <font id="bkwz">i18n_cdp.text.bkwz_n81i：</font> 
			 		 	<input onmouseover="showTitle('banKaTip',this,event);" onmouseout="hideTitle('banKaTip');"  type="text" readonly="readonly" value="" id="bankaVal" title="" name="bankaVal" style="width:  175px;height: 20px"/>
			 		  		<span id="banKaTip" class="infoTip" style="display:none;"></span>
			 		  		 <input type="button" value="i18n_cdp.button.select_n81i" onclick="selectBanKa()" style="height: 21px;" class=btn3_mouseout />
					&nbsp;
			  </c:if>
			  </div>
		   <div id="noteStr" style="top: 130px; left: 80px;">
		 	i18n_cdp.text.setComments.config_n81i：<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i18n_cdp.text.setComments.selectSubDevice_n81i<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i18n_cdp.text.setComments.configPosition_n81i<br /><br />
		 	i18n_cdp.text.shortcut_n81i：<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. ctrl+↑ i18n_cdp.text.or_n81i ctrl+↓ ：i18n_cdp.text.changeSubDevice_n81i<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. ↑&nbsp; ↓&nbsp; ←&nbsp; → ：i18n_cdp.text.movePosition_n81i<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. shift+↑ i18n_cdp.text.or_n81i shift+↓ ：i18n_cdp.text.setHeigh_n81i<br /><br />
		 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. shift+← i18n_cdp.text.or_n81i shift+→ ：i18n_cdp.text.setWiedth_n81i<br /><br />
	       </div>
		   
		   <c:forEach items="${devTypeForPosList}" var="device" varStatus="devCount">
		  	  <input type="hidden" value="${device.id}"  id="PosSelect_Id_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].id"/>
	          <input type="hidden" value="${device.deviceTypeCode}"  id="PosSelect_DeviceTypeCode_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].deviceTypeCode"/>
	          <input type="hidden" value="${device.figureX}"  id="PosSelect_X_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].figureX"/>
	          <input type="hidden" value="${device.figureY}"  id="PosSelect_Y_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].figureY"/>
	          <input type="hidden" value="${device.figureWidth}"  id="PosSelect_Width_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].figureWidth"/>
	          <input type="hidden" value="${device.figureHeight}"  id="PosSelect_Height_${device.deviceTypeCode}"  name="devTypeForPosList[${devCount.count-1}].figureHeight"/>
		   </c:forEach>
		   
		  
		  <div id="rootDev"  style="display:inline;width:${devType.figureWidth}px;height:${devType.figureHeight}px;left: ${rootDeviceX}px;top:${rootDeviceY}px;background:no-repeat;  background-image: url('<%=path %>/images/svg/${devType.figureFill}');"  >
		  </div>
		  
		  </td>
		  <td width="30%" valign="top" >
		 	 <div id="backBut" style="position: absolute; top: 5; left: 90%;width: 90px">
				  <input type="button" class="btn3_mouseout" id="addButton" style="display: inline"
														onmouseover="this.className='btn3_mouseover'"
														onmouseout="this.className='btn3_mouseout'"
														onmousedown="this.className='btn3_mousedown'"
														onmouseup="this.className='btn3_mouseup'" 
														onclick="add()" value="i18n_cdp.button.add_n81i"/>
				  &nbsp;
				  <input type="button" class="btn3_mouseout" id="backButton" style="display: inline"
														onmouseover="this.className='btn3_mouseover'"
														onmouseout="this.className='btn3_mouseout'"
														onmousedown="this.className='btn3_mousedown'"
														onmouseup="this.className='btn3_mouseup'" 
														onclick="goBack()" value="i18n_cdp.button.back_n81i"/>
															<input id="indexStr2" type="hidden" />
			 </div>
	      </td>
	  </tr> 
   </table>
    <script type="text/javascript">
			//先创建一个公用的div,默认大小为0，当鼠标move的时候，div的大小改变
            createInstanceDiv();
			dragMouseToCreateDiv('rootDev');
			document.getElementById("confDevCode").focus();
			changeDevCode();
    </script> 
  		
	</form>
</body>
</html>


