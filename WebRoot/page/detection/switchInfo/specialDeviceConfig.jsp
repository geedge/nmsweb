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
    <title>i18n_sdc.message.title_n81ii18n_sdc.message.title_n81i</title>
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
              jQuery("#indexStr2").val(a.clientX+","+a.clientY);
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
        
        window.onscroll=function() {
			var scrollTop = document.documentElement.scrollTop;
			if(${devScrollHeight=='0'}) {//devScrollHeight可能为98%
				return false;
			}else if(scrollTop>=${devScrollHeight}){
				return false;
			}
			
			var backBut = document.getElementById("backBut");
			backBut.style.top = scrollTop +5 +"px";
			
			jQuery("div[id^='div_']").each(function() {
				var divId = this.id;
				var  devCode = divId.split("_")[1];//设备型号
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
    	var deviceCount = ${maxDevNum};//${maxDevNum}:不能加单引号，因为要自增1的，加了单引号，按字符串处理了就：0-${maxDevNum}用于存rootDevice，板卡和卡槽对应后生成一组input信息，deviceCount为生成几组input，input组也可能被删除
    	//var deviceCount = 1;
    	//var rootDeviceX=300;//顶级设备的X坐标
    	//var rootDeviceY=30;//顶级设备的Y坐标
    	var zIndexCount = 1000;//zIndex的最大值为20多亿,zIndex必须设置position为absolute或者fixed等      
    	
    	//将设备的div拖到和以下位置有重叠部分的时候，会删除div（设备）
    	/*var delArray = new Array();
    	delArray[0] = 100;
    	delArray[1] = 80;
    	delArray[2] = 400;
    	delArray[3] = 450; */
    	
    	//删除板卡div：只要设备处理顶级设备的范围内，就算删除:多个设备时-----将板卡拖到整个逻辑节点外才删除---yes--
    	var delArray = new Array();
    	//多个物理设备时:如何排列
        if('${sortByXorY}'=='x' || '${sortByXorY}'=='X'){      
	    	delArray[0] = ${rootDeviceX};//XMin
	    	delArray[1] = ${rootDeviceX}+${rootDevice.deviceWidth*maxDevNum}+${(maxDevNum-1)*deviceGap};//XMax
	    	delArray[2] = ${rootDeviceY};//YMin
	    	delArray[3] = ${rootDeviceY}+${rootDevice.deviceHeight};//YMax :${rootDeviceY}+${rootDevice.deviceHeight}
    	}else {
	    	delArray[0] = ${rootDeviceX};//XMin
	    	delArray[1] = ${rootDeviceX}+${rootDevice.deviceWidth};//XMax
	    	delArray[2] = ${rootDeviceY};//YMin
	    	delArray[3] = ${rootDeviceY}+${rootDevice.deviceHeight*maxDevNum}+${(maxDevNum-1)*deviceGap};//YMax :${rootDeviceY}+${rootDevice.deviceHeight}
    	}
    	
    	//顶级设备上的位置数组，每个位置有可以放置的设备:后台直接查询xy，未进行组合
    	var positArray = new Array();	
    	var positionCount = ${fn:length(devicePositionList)};
    	<c:forEach items="${devicePositionList}" var="devicePosition" varStatus="vs">
    		
    		//多个物理设备时:如何排列
            if('${sortByXorY}'=='x' || '${sortByXorY}'=='X'){            	
            	var xMin = ${rootDeviceX}+${devicePosition.devNum*(deviceGap+rootDevice.deviceWidth)}+${devicePosition.figureX};
    			var xMax = xMin+${devicePosition.deviceWidth};
	    		
	    		var yMin = ${rootDeviceY}+${devicePosition.figureY};//第一个root设备的Y坐标+（max-1）*（gap+rootDev.height）+dev.figureY
	    	    var yMax = yMin+${devicePosition.deviceHeight};
            }else {//竖着排列，需要改变y坐标,默认按y排列
	    		var xMin = ${rootDeviceX}+${devicePosition.figureX};
    			var xMax = xMin+${devicePosition.deviceWidth};
	    		
	    		var yMin = ${rootDeviceY}+${devicePosition.devNum*(deviceGap+rootDevice.deviceHeight)}+${devicePosition.figureY};//第一个root设备的Y坐标+（max-1）*（gap+rootDev.height）+dev.figureY
	    	    var yMax = yMin+${devicePosition.deviceHeight};
            }
    		
    		var i = ${vs.count}-1;
    		positArray[i] = new Array();
    		//每个卡槽的位置范围
    		positArray[i][0] = xMin;
    		positArray[i][1] = xMax;
    		positArray[i][2] = yMin;
    		positArray[i][3] = yMax;
    		
    		positArray[i][4] = '${devicePosition.showIndex}';//后台已经处理多个物理设备时的showIndex：index=自身的index+(设备编号*顶级设备位置的个数)
    		positArray[i][5] = '${devicePosition.deviceCode}';//update by jinsj 槽位序号，用于拖动子设备到板卡时验证，板卡和槽位是否对应
    		positArray[i][6] = 0;//对应上此位置是否有设备：1是，0否
    		positArray[i][7] = '';//对应设备的div的ID
    		positArray[i][8] = '${devicePosition.pid}';
    		positArray[i][9] = '';//顶级设备的父设备在祖父设备的位置为空(机框的父设备在祖父设备的位置为空，因为机框没有祖父设备)
    		//positArray[i][9] = ${devicePosition.devNum+1};//父设备(机框)在祖父设备的位置。
    		
    		positArray[i][10] = '${devicePosition.figureX}';//槽的坐标:可以由后台获取，也可以前台传递
    		positArray[i][11] = '${devicePosition.figureY}';//槽的坐标:可以由后台获取，也可以前台传递
    		
    		positArray[i][12] = ${devicePosition.devNum};//当前卡槽位置是第几个机框上的：机框从0到(maxDevNum-1)
		</c:forEach>
    	
    	/*
    	  拖动设备模型（div）:
    	  1.鼠标移动的时候，设备模板跟着移动
    	  2.鼠标up的时候：
    	          (1)设备模板回到原来的位置
                  (2)生成一个div的真实大小的设备：
                         (21)如果当前设备的位置和位置数组中的位置匹配的话，对齐
		                        (211) 如果当前位置已经有设备了，则删除位置对应的设备、设备对应input组、清空positArray[i][7] = ''，并使positArray[i][6] = 0
		                        (212)无论当前位置是否有设备：对齐位置，生成input组，修改positArray[i][7]（当前位置对应设备的divID），positArray[i][6]（当前位置是否有设备）
    			  (3)如果当前设备移动到了回收站的位置，则删除生成的设备div+div对应的input组，修改positArray[i][7]，positArray[i][6]
    	
    	*/
        function drag(objId) {
            if (typeof objId == "string") {
                var obj = document.getElementById(objId);  
            }
            //调用当前div的mousedown事件的同时，调用document的mousemove和mouseup事件
            obj.onmousedown = function (a) {//鼠标按下
            	var oldX = obj.style.left;
            	var oldY = obj.style.top;
                this.style.cursor = "move"; //设置鼠标样式  hand
                zIndexCount = zIndexCount+1;
                this.style.zIndex = zIndexCount;
                var d = document;
                if (!a) a = window.event; //按下时创建一个事件
                
                var x = a.clientX - document.body.scrollLeft - obj.offsetLeft; //x=鼠标相对于网页的x坐标-网页被卷去的宽-待移动对象的左外边距
                var y = a.clientY - document.body.scrollTop - obj.offsetTop; //y=鼠标相对于网页的y左边-网页被卷去的高-待移动对象的左上边距
                
                //设置frame外捕获鼠标事件
                if(obj.setCapture) {
                	obj.setCapture();
                }else if(window.captureEvents) {
					window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
                }
                
                d.onmousemove = function (a) {//鼠标移动
                    if (!a) a = window.event; //移动时创建一个事件
                    obj.style.left = a.clientX + document.body.scrollLeft - x +"px";
                    obj.style.top = a.clientY + document.body.scrollTop - y +"px";
                    
                }
                d.onmouseup = function (a) {//鼠标放开
	                //取消frame外捕获鼠标事件
	                if(obj.releaseCapture) {
	                	obj.releaseCapture();
	                }else if(window.captureEvents) {
						window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
	                }
	                
                	if (!a) a = window.event; //按下时创建一个事件
                	//此处的document.body.scrollLeft获取的值总是0，不起作用，需要使用document.documentElement.scrollTop获取，但是也没有关系，因为x、y的值使用的过程中，和它无关，因为减去一个，又加上了一个？？
                    var x = a.clientX - document.body.scrollLeft - obj.offsetLeft; //x=鼠标相对于网页的x坐标-网页被卷去的宽-待移动对象的左外边距
                	var y = a.clientY - document.body.scrollTop - obj.offsetTop; //y=鼠标相对于网页的y左边-网页被卷去的高-待移动对象的左上边距
                    
                    document.onmousemove = null;
		                     document.onmousemove = function (a) {//鼠标移动
					    	 	if (!a) a = window.event; //移动时创建一个事件
					              jQuery("#indexStr2").val(a.clientX+","+a.clientY);
					         }
                    document.onmouseup = null;
                    obj.style.cursor = "normal"; //设置放开的样式
                    
                    //松开鼠标的时候，使大图显示，小图片回到原来的位置    
                    obj.style.left = oldX;
                    obj.style.top = oldY;
                    
                    var instanceDiv = document.createElement("div");
                    var indstanceId = "instance_"+objId+"_ture"+count;
                    count = count+1;
                    instanceDiv.setAttribute("id",indstanceId);
                    var tmp = document.getElementById(objId);
                    instanceDiv.style.width = getAttributeValueByEle(tmp,"deviceWidth")+"px";
                    instanceDiv.style.height = getAttributeValueByEle(tmp,"deviceHeight")+"px";
                    instanceDiv.style.left = a.clientX + document.body.scrollLeft - x +"px";
                    
                    instanceDiv.style.top = a.clientY + document.body.scrollTop - y +"px";
                    instanceDiv.style.background= getAttributeValueByEle(tmp,"imageTrue");
                    zIndexCount = zIndexCount+1;
                    instanceDiv.style.zIndex = zIndexCount;
                    //设备本身的信息
                    instanceDiv.setAttribute("parDeviceCode",getAttributeValueByEle(tmp,"parDeviceCode"));
                    instanceDiv.setAttribute("deviceCode",getAttributeValueByEle(tmp,"deviceCode"));
                    instanceDiv.setAttribute("deviceHeight",getAttributeValueByEle(tmp,"deviceHeight"));
                    instanceDiv.setAttribute("deviceWidth",getAttributeValueByEle(tmp,"deviceWidth"));
                    instanceDiv.setAttribute("showLevel",getAttributeValueByEle(tmp,"showLevel"));
                    instanceDiv.setAttribute("deviceFill",getAttributeValueByEle(tmp,"deviceFill"));
                    instanceDiv.setAttribute("isLink",getAttributeValueByEle(tmp,"isLink"));
                    instanceDiv.setAttribute("devId",getAttributeValueByEle(tmp,"devId"));
                    //instanceDiv.setAttribute("showIndex",getAttributeValueByEle(ele,"showIndex"));//此为设备的编号，对于板卡来说，没有意义，支持多级时，可能有用-------??
                    instanceDiv.setAttribute("isLeaf",getAttributeValueByEle(tmp,"isLeaf"));
                    instanceDiv.setAttribute("figureX",getAttributeValueByEle(tmp,"figureX"));
                    instanceDiv.setAttribute("figureY",getAttributeValueByEle(tmp,"figureY"));
                     
                    document.deviceConfigForm.appendChild(instanceDiv);
                  
                    //以下语句需要在 document.deviceConfigForm.appendChild(instanceDiv)之后
                    var oldMinX = instanceDiv.offsetLeft;
                    var oldMaxX = instanceDiv.offsetLeft+instanceDiv.offsetWidth;
                    var oldMinY = instanceDiv.offsetTop;
                    var oldMaxY = instanceDiv.offsetTop+instanceDiv.offsetHeight;
                    var halfHeight = instanceDiv.offsetHeight/2-1; //当板卡在两个位置的正中间的时候，此时两个边的距离就可能小于halfHeight一点，所以哪个位置也不符合，所以要减去1像素
                    var halfWidth = instanceDiv.offsetWidth/2-1; //当板卡在两个位置的正中间的时候，此时两个边的距离就可能小于halfWidth一点，所以哪个位置也不符合，所以要减去1像素
                               
                    
                    dragFree(indstanceId);
                    delDivMapInputAndPosition(instanceDiv);//删除div对应的input和位置
                    
                    var areaArray = new Array();
			    	//4个点所在槽位与矩形板卡重合的面积
			    	areaArray[0] = new Array();//点1
			    	areaArray[0][0] = 0;//面积
		    		areaArray[0][1] = '';//positArray[i][6],此位置是否有设备。1：有设备
		    		areaArray[0][2] = '';//对应设备的div的ID
		    		areaArray[0][3] = '';//板卡对齐后的x坐标
		    		areaArray[0][4] = '';//板卡对齐后的y坐标
		    		areaArray[0][5] = '';//parShowIndex
		    		areaArray[0][6] = '';//parShowIndex
		    		areaArray[0][7] = '';//
		    		areaArray[0][8] = '';//
		    		areaArray[0][9] = '';//
		    		areaArray[0][10] = '';//
		    		areaArray[0][11] = '';//
		    		areaArray[0][12] = false;//是否有和板卡div重合的槽位
		    		
		    		
                    for(var i=0;i<positionCount;i++) {
                    	var tmpXMin = 	positArray[i][0];
                    	var tmpXMax = 	positArray[i][1];
                    	var tmpYMin = 	positArray[i][2];
                    	var tmpYMax = 	positArray[i][3];
				    	//jQuery("#kuangPosi"+i).val(tmpXMin+"-"+tmpXMax+","+tmpYMin+"-"+tmpYMax);//调试使用
			    		
			    		//a.clientX和a.clientY为鼠标的坐标
			    		//if(tmpXMin<=a.clientX && tmpXMax>=a.clientX
			    		          //&& tmpYMin<=a.clientY && tmpYMax>=a.clientY) {
			    		/*if(positArray[i][4]=='18'||positArray[i][4]=='17'||positArray[i][4]=='5') {
			    			alert(positArray[i][4]+"="+tmpXMin+","+tmpYMin+","+tmpXMax+","+tmpYMax);
			    		}*/
			    		
			    		//默认的为横向的矩形:矩形的4个点在槽位范围内时，再判断面积:1：左上点，2：左下点，3：右上点，4：右下点			    		
			    		var condetion1 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
			    		var condetion2 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		var condetion3 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
			    		var condetion4 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		
			    		if('${modelSortByXorY}'=='y' || '${modelSortByXorY}'=='Y'){//模型为竖向的矩形
			    		
			    		    condetion1 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
				    		condetion2 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
				    		condetion3 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
				    		condetion4 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		}
			    		
			    		//只有矩形四个点中的一个点和某个槽位有重叠部分，则计算重叠面积（由于有条件>=halfHeight，所以每次符合条件的只有2个点，只会计算2个面积,此时如果重合的部分都没有超过halfHeight的，则不会对齐，这样不对）
			    		if(condetion1 || condetion2 || condetion3 || condetion4) {		    			
			    			var areaTmp = 0;
			    			if(condetion1) {
				    			areaTmp = (Number(tmpXMax)-Number(oldMinX))*(Number(tmpYMax)-Number(oldMinY));
			    			}else if(condetion2) {
				    			areaTmp = (Number(tmpXMax)-Number(oldMinX))*(Number(oldMaxY)-Number(tmpYMin));
			    			}else if(condetion3) {
				    			areaTmp = (Number(oldMaxX)-Number(tmpXMin))*(Number(tmpYMax)-Number(oldMinY));
			    			}else if(condetion4) {
				    			areaTmp = (Number(oldMaxX)-Number(tmpXMin))*(Number(oldMaxY)-Number(tmpYMin));
			    			}
			    			if(areaTmp>areaArray[0][0]) {
			    			
				    			areaArray[0][0] = areaTmp;//面积
					    		areaArray[0][1] = positArray[i][6];//positArray[i][6],此位置是否有设备。1：有设备
					    		areaArray[0][2] = positArray[i][7];//对应设备的div的ID
					    		areaArray[0][3] = tmpXMin;//板卡对齐后的x坐标
					    		areaArray[0][4] = tmpYMin;//板卡对齐后的y坐标
					    		areaArray[0][5] = positArray[i][9];//parShowIndex
					    		areaArray[0][6] = positArray[i][12];//parShowIndex
					    		areaArray[0][7] = positArray[i][4];//
					    		areaArray[0][8] = positArray[i][10];//
					    		areaArray[0][9] = positArray[i][11];//
					    		areaArray[0][10] = positArray[i][8];//
					    		areaArray[0][11] = i;//
					    		areaArray[0][12] = true;//是否有和板卡div重合的槽位
					    		areaArray[0][13] = positArray[i][5];//槽位序号
			    			}
			    		}
			    		
			    	}
			    	
			    	
			    	//板卡div至少和一个槽位重叠
                    if(areaArray[0][12]) {
                    
                    		if(areaArray[0][1]==1) {//此位置已有设备positArray[i][6]
                    			//删除原来的位置上的设备，将当前设备作为新的设备放到位置上                    			
				    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡-????????
				    			var deviceDivId = areaArray[0][2];//positArray[i][7]
				    			//说明当前卡槽的位置已经有板卡了，需要将此板卡div删除，将对应input删除，将positArray[i][7]清空，将positArray[i][6]置为无设备
				    			if(deviceDivId!='') {
					    			delDivMapInputAndPosition(deviceDivId);//包含positArray[i][6] = 0/positArray[i][7] = '';	操作
				    				var divObj = document.getElementById(deviceDivId);
					    			document.deviceConfigForm.removeChild(divObj);
				    			}
                    		}
                    		
			    			instanceDiv.style.left = areaArray[0][3] +"px";//tmpXMin
                    		instanceDiv.style.top = areaArray[0][4] +"px";//tmpYMin
                   		    //此时不用删除div之前对应的input和位置，因为up之前不会有对应的:
                   			var parShowIndex = generatParShowIndex(areaArray[0][5],(areaArray[0][6]+1));//因为设备型号维护时，showIndex默认为1，所以此处的设备编号要从1开始
                    	 	createDeviceInfo(tmp,areaArray[0][7],areaArray[0][8],areaArray[0][9],indstanceId,areaArray[0][10],parShowIndex);
                    		positArray[areaArray[0][11]][6] = 1;
                    		positArray[areaArray[0][11]][7] = indstanceId;
                    		//update by jinsj begin  验证子设备与槽位是否对应
                    		if(areaArray[0][13] != null){
						    	var flag = checkPosition(getAttributeValueByEle(tmp,"parDeviceCode"),getAttributeValueByEle(tmp,"deviceCode"),areaArray[0][13]);
						    	if(!flag){
						    		//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
					    			delDivMapInputAndPosition(indstanceId);
			    					document.deviceConfigForm.removeChild(instanceDiv);
						    		return false;
						    	}
						    }
					    	//update by jinsj end 	
			    	}else{//当移动板子不在任何已定义板子的槽位,但在主机架范围内时,不符合放置条件所以放开鼠标清理移动板子
			    		delDivMapInputAndPosition(indstanceId);
			    		document.deviceConfigForm.removeChild(instanceDiv);
			    		return false;
			    	}
			    	
			    	
			    	//删除div，及关系：由于一移动div板卡则删除关系，所以删除某个板卡时，可以不用再删除关系，不过可以看一下是否有关系存在，有就删除
			    	/*var tmpXMin = 	delArray[0];
                   	var tmpXMax = 	delArray[1];
                   	var tmpYMin = 	delArray[2];
                   	var tmpYMax = 	delArray[3];
                   	
		    		if(((tmpXMin<=oldMinX && oldMinX<=tmpXMax)
		    		             ||  (tmpXMin<=oldMaxX && oldMaxX<=tmpXMax)
		    		             ||  (oldMinX<=tmpXMin && tmpXMin<=oldMaxX)
		    		             ||  (oldMinX<=tmpXMax && tmpXMax<=oldMaxX))
		    		     &&
		    		    ((tmpYMin<=oldMinY && oldMinY<=tmpYMax)
		    		             ||  (tmpYMin<=oldMaxY && oldMaxY<=tmpYMax)
		    		             ||  (oldMinY<=tmpYMin && tmpYMin<=oldMaxY)
		    		             ||  (oldMinY<=tmpYMax && tmpYMax<=oldMaxY))) {
		    			
		    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
		    			delDivMapInputAndPosition(indstanceId);
		    			document.deviceConfigForm.removeChild(instanceDiv);
		    		}*/
		    		var tmpXMin = 	delArray[0];
                   	var tmpXMax = 	delArray[1];
                   	var tmpYMin = 	delArray[2];
                   	var tmpYMax = 	delArray[3];
                   	
		    		if( oldMaxX<tmpXMin 
		    		             || oldMinX>tmpXMax
		    		             ||  oldMinY>tmpYMax 
		    		             ||  oldMaxY<tmpYMin) {
		    			
		    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
		    			delDivMapInputAndPosition(indstanceId);
		    			document.deviceConfigForm.removeChild(instanceDiv);
		    		}
			    	
                }
            }
        }
        
        function checkPosition(deviceTypeCode,subDeviceCode,postion){
        	var isOk = true;
        	var params = {
			  deviceTypeCode:deviceTypeCode, 
			  subDeviceCode: subDeviceCode,
			  postion:postion
			};
        	$.ajax({
				type:"post",
				url:"<c:url value='/detection/switchDetection!checkPostion.do'/>",
				data:$.param(params),
				async:false,
				 success:function (data,textStatus){
					 if(textStatus == "success" && data =="0"){
					 	alert("i18n_sdc.message.checkPosition_n81i");
					 	isOk = false;
					 }
				}
			})
			return isOk;
        }
        
       //此方法暂时无用
        function toDelete(objId) {
        	delDivMapInputAndPosition(objId);
        	var obj = document.getElementById(objId);
		    document.deviceConfigForm.removeChild(obj);
        }
        
        //创建input组，将位置和设备对应,tmp为document.getElementById的来的
        function createDeviceInfo(tmp,showIndex,tmpX,tmpY,instanceId,pid,parShowIndex) {
        		//常量定义
        		var elementType ="input";
        		var inputType ="hidden";
        		var listName ="deviceConfigList";
        		
        		//id:设备在表device_type_info的id
        		var inputEleParDevCode = document.createElement(elementType);
              	var inputEleName0 = listName+"["+deviceCount+"].id";         		
                inputEleParDevCode.setAttribute("id",inputEleName0);
                inputEleParDevCode.setAttribute("name",inputEleName0);
                inputEleParDevCode.setAttribute("value",getAttributeValueByEle(tmp,"devId"));
                inputEleParDevCode.setAttribute("type",inputType);
                inputEleParDevCode.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleParDevCode);
                
        		//pid:设备在表device_type_info的pid,-------------------------------似乎无用？
        		var inputEleParDevCode = document.createElement(elementType);
              	var inputEleName0 = listName+"["+deviceCount+"].pid";         		
                inputEleParDevCode.setAttribute("id",inputEleName0);
                inputEleParDevCode.setAttribute("name",inputEleName0);
                inputEleParDevCode.setAttribute("value",pid);
                inputEleParDevCode.setAttribute("type",inputType);
                inputEleParDevCode.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleParDevCode);
                
        		//parDeviceCode:父设备型号：为空（最顶层设备）或者一个设备型号
        		var inputEleParDevCode = document.createElement(elementType);
              	var inputEleName1 = listName+"["+deviceCount+"].parDeviceCode";  
                inputEleParDevCode.setAttribute("id",inputEleName1);
                inputEleParDevCode.setAttribute("name",inputEleName1);
                inputEleParDevCode.setAttribute("value",getAttributeValueByEle(tmp,"parDeviceCode"));
                inputEleParDevCode.setAttribute("type",inputType);
                inputEleParDevCode.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleParDevCode);
                
        		//deviceCode-设备型号
        		var inputEleDevCode = document.createElement(elementType);
              	var inputEleName2 = listName+"["+deviceCount+"].deviceCode";  
                inputEleDevCode.setAttribute("id",inputEleName2);
                inputEleDevCode.setAttribute("name",inputEleName2);
                inputEleDevCode.setAttribute("value",getAttributeValueByEle(tmp,"deviceCode"));
                inputEleDevCode.setAttribute("type",inputType);
                inputEleDevCode.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleDevCode);
                
        		
                
        		//showIndex-设备在父设备的位置（如卡槽的位置）
        		var inputEleShowIndex = document.createElement(elementType);
              	var inputEleName3 = listName+"["+deviceCount+"].showIndex";                    		
                inputEleShowIndex.setAttribute("id",inputEleName3);
                inputEleShowIndex.setAttribute("name",inputEleName3);
                inputEleShowIndex.setAttribute("value",showIndex);
                inputEleShowIndex.setAttribute("type",inputType);
                inputEleShowIndex.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleShowIndex);
                
        		//showLevel---设备的级别：取当前设备的showLevel
        		var inputEleShowLevel = document.createElement(elementType);
              	var inputEleName4 = listName+"["+deviceCount+"].showLevel";                    		
                inputEleShowLevel.setAttribute("id",inputEleName4);
                inputEleShowLevel.setAttribute("name",inputEleName4);
                inputEleShowLevel.setAttribute("value",getAttributeValueByEle(tmp,"showLevel"));
                inputEleShowLevel.setAttribute("type",inputType);
                inputEleShowLevel.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleShowLevel);
                
        		//figureX--板卡原来的位置等于槽的位置：等于机框的位置加上槽的位置
                var inputEleX = document.createElement(elementType);
              	var inputEleName5 = listName+"["+deviceCount+"].figureX";                    		
                inputEleX.setAttribute("id",inputEleName5);
                inputEleX.setAttribute("name",inputEleName5);
                inputEleX.setAttribute("value",tmpX);
                inputEleX.setAttribute("type",inputType);
                inputEleX.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleX);
                
                //figureY--板卡原来的位置等于槽的位置：等于机框的位置加上槽的位置
                var inputEleY = document.createElement(elementType);
              	var inputEleName6 = listName+"["+deviceCount+"].figureY";                    		
                inputEleY.setAttribute("id",inputEleName6);
                inputEleY.setAttribute("name",inputEleName6);
                inputEleY.setAttribute("value",tmpY);
                inputEleY.setAttribute("type",inputType);
                inputEleY.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleY);
                
        		//deviceWidth
        		var inputEleWidth = document.createElement(elementType);
              	var inputEleName7 = listName+"["+deviceCount+"].deviceWidth";                    		
                inputEleWidth.setAttribute("id",inputEleName7);
                inputEleWidth.setAttribute("name",inputEleName7);
                inputEleWidth.setAttribute("value",getAttributeValueByEle(tmp,"deviceWidth"));
                inputEleWidth.setAttribute("type",inputType);
                inputEleWidth.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleWidth);
                
        		//deviceHeight
        		var inputEleHeight = document.createElement(elementType);
              	var inputEleName8 = listName+"["+deviceCount+"].deviceHeight";                    		
                inputEleHeight.setAttribute("id",inputEleName8);
                inputEleHeight.setAttribute("name",inputEleName8);
                inputEleHeight.setAttribute("value",getAttributeValueByEle(tmp,"deviceHeight"));
                inputEleHeight.setAttribute("type",inputType);
                inputEleHeight.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleHeight);
                
        		//deviceFill：node_figure_info表的figure_fill_model和figure_fill字段
        		var inputEleFill = document.createElement(elementType);
              	var inputEleName9 = listName+"["+deviceCount+"].deviceFill";
                inputEleFill.setAttribute("id",inputEleName9);
                inputEleFill.setAttribute("name",inputEleName9);
                inputEleFill.setAttribute("value",getAttributeValueByEle(tmp,"deviceFill"));
                inputEleFill.setAttribute("type",inputType);
                inputEleFill.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleFill);
                
        		//isLink：是否有链接，1是，0否，node_figure_info表的is_leaf字段
        		var inputEleIsLink = document.createElement(elementType);
              	var inputEleName10 = listName+"["+deviceCount+"].isLink";
                inputEleIsLink.setAttribute("id",inputEleName10);
                inputEleIsLink.setAttribute("name",inputEleName10);
                inputEleIsLink.setAttribute("value",getAttributeValueByEle(tmp,"isLink"));
                inputEleIsLink.setAttribute("type",inputType);    
                inputEleIsLink.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）            
                document.deviceConfigForm.appendChild(inputEleIsLink);
                
        		//isLeaf：是否叶子设备，1是，0否
        		var inputEleIsLeaf = document.createElement(elementType);
              	var inputEleName11 = listName+"["+deviceCount+"].isLeaf";
                inputEleIsLeaf.setAttribute("id",inputEleName11);
                inputEleIsLeaf.setAttribute("name",inputEleName11);
                inputEleIsLeaf.setAttribute("value",getAttributeValueByEle(tmp,"isLeaf"));
                inputEleIsLeaf.setAttribute("type",inputType);    
                inputEleIsLeaf.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）            
                document.deviceConfigForm.appendChild(inputEleIsLeaf);
                
                //parShowIndex-父设备在祖父设备的位置
        		var inputEleParShowIndex = document.createElement(elementType);
              	var inputEleName12 = listName+"["+deviceCount+"].parShowIndex";                    		
                inputEleParShowIndex.setAttribute("id",inputEleName12);
                inputEleParShowIndex.setAttribute("name",inputEleName12);
                inputEleParShowIndex.setAttribute("value",parShowIndex);
                inputEleParShowIndex.setAttribute("type",inputType);
                inputEleParShowIndex.setAttribute("mapDivId",instanceId);//本组input数据对应的板卡的div的id，用于删除设备的对应数据（一组input）
                document.deviceConfigForm.appendChild(inputEleParShowIndex);
                deviceCount = deviceCount + 1;
                
                //jQuery("#listSize").val(deviceCount);
        }
        
        /*
    	  拖动设备（div）:
    	  1.鼠标移动的时候，设备跟着移动
    	  2.鼠标up的时候：
                  (1)删除当前设备相关的：input组，修改positArray[i][7]，positArray[i][6]
                         (11)如果当前设备的位置和位置数组中的位置匹配的话，对齐
		                        (111) 如果当前位置已经有设备了，则删除位置对应的设备div、设备对应input组、清空positArray[i][7] = ''，并使positArray[i][6] = 0
		                        (112) 无论当前位置是否有设备：对齐位置，生成input组，修改positArray[i][7]（当前位置对应设备的divID），positArray[i][6]（当前位置是否有设备）
    			  (2)如果当前设备移动到了回收站的位置，则删除生成的设备div+div对应的input组+修改positArray[i][7]，positArray[i][6]
    	
    	*/
        function dragFree(objId) {
            if (typeof objId == "string") {
                var obj = document.getElementById(objId);
            }
            obj.onmousedown = function (a) {//鼠标按下
                this.style.cursor = "move"; //设置鼠标样式  hand
                zIndexCount = zIndexCount+1;
                this.style.zIndex = zIndexCount;
                //jQuery("#indexStr").val(obj.style.zIndex+",");
                //this.style.zIndex = 1000;
                var d = document;
                if (!a) a = window.event; //按下时创建一个事件
                
                var x = a.clientX - document.body.scrollLeft - obj.offsetLeft; //x=鼠标相对于网页的x坐标-网页被卷去的宽-待移动对象的左外边距
                var y = a.clientY - document.body.scrollTop - obj.offsetTop; //y=鼠标相对于网页的y左边-网页被卷去的高-待移动对象的左上边距
                
                //设置frame外捕获鼠标事件
                if(obj.setCapture) {
                	obj.setCapture();
                }else if(window.captureEvents) {
					window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
                }
                
                d.onmousemove = function (a) {//鼠标移动
                    if (!a) a = window.event; //移动时创建一个事件
                    obj.style.left = a.clientX + document.body.scrollLeft - x +"px";
                    obj.style.top = a.clientY + document.body.scrollTop - y +"px";
                    
                }
                d.onmouseup = function () {//鼠标放开:鼠标移动超出当前frame时，松开鼠标，此时的onmouseup捕捉不到
                	//取消frame外捕获鼠标事件
	                if(obj.releaseCapture) {
	                	obj.releaseCapture();
	                }else if(window.captureEvents) {
						window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
	                }
                    document.onmousemove = null;
                      		document.onmousemove = function (a) {//鼠标移动
					    	 	if (!a) a = window.event; //移动时创建一个事件
					              jQuery("#indexStr2").val(a.clientX+","+a.clientY);
					         }
                    document.onmouseup = null;
                    obj.style.cursor = "normal"; //设置放开的样式
                    
                    //div矩形在鼠标up的时候左上角的坐标，即松开鼠标时矩形div四个点的坐标范围
                    var oldMinX = obj.offsetLeft;
                    var oldMaxX = obj.offsetLeft+obj.offsetWidth;
                    var oldMinY = obj.offsetTop;
                    var oldMaxY = obj.offsetTop+obj.offsetHeight;
                   	var halfHeight = obj.offsetHeight/2-1; //当板卡在两个位置的正中间的时候，此时两个边的距离就可能小于halfHeight一点，所以哪个位置也不符合，所以要减去1像素
                   	var halfWidth = obj.offsetWidth/2-1; //当板卡在两个位置的正中间的时候，此时两个边的距离就可能小于halfWidth一点，所以哪个位置也不符合，所以要减去1像素
                    
                    delDivMapInputAndPosition(objId);//删除当前移动的div（板卡）的input组及对应关系
                    
			    	//4个点所在槽位与矩形板卡重合的面积
                    var areaArray = new Array();
			    	areaArray[0] = new Array();//点1
			    	areaArray[0][0] = 0;//面积
		    		areaArray[0][1] = '';//positArray[i][6],此位置是否有设备。1：有设备
		    		areaArray[0][2] = '';//对应设备的div的ID
		    		areaArray[0][3] = '';//板卡对齐后的x坐标
		    		areaArray[0][4] = '';//板卡对齐后的y坐标
		    		areaArray[0][5] = '';//parShowIndex
		    		areaArray[0][6] = '';//parShowIndex
		    		areaArray[0][7] = '';//
		    		areaArray[0][8] = '';//
		    		areaArray[0][9] = '';//
		    		areaArray[0][10] = '';//
		    		areaArray[0][11] = '';//
		    		areaArray[0][12] = false;//是否有和板卡div重合的槽位
		    		
                    for(var i=0;i<positionCount;i++) {
                    	var tmpXMin = 	positArray[i][0];
                    	var tmpXMax = 	positArray[i][1];
                    	var tmpYMin = 	positArray[i][2];
                    	var tmpYMax = 	positArray[i][3]; 
                    	
                    	
                    	//默认的为横向的矩形:矩形的4个点在槽位范围内时，再判断重叠的面积:1：左上点，2：左下点，3：右上点，4：右下点,
			    		
			    		var condetion1 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
			    		var condetion2 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		var condetion3 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
			    		var condetion4 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		
			    		if('${modelSortByXorY}'=='y' || '${modelSortByXorY}'=='Y'){//模型为竖向的矩形
			    		
			    		    condetion1 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
				    		condetion2 = tmpXMin<=oldMinX && tmpXMax>=oldMinX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
				    		condetion3 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMinY && tmpYMax>=oldMinY;
				    		condetion4 = tmpXMin<=oldMaxX && tmpXMax>=oldMaxX && tmpYMin<=oldMaxY && tmpYMax>=oldMaxY;
			    		}
			    		
			    		//只有矩形四个点中的一个点和某个槽位有重叠部分，则计算重叠面积（由于有条件>=halfHeight，所以每次符合条件的只有2个点，只会计算2个面积）
			    		if(condetion1 || condetion2 || condetion3 || condetion4) {		    			
			    			var areaTmp = 0;
			    			if(condetion1) {
				    			areaTmp = (Number(tmpXMax)-Number(oldMinX))*(Number(tmpYMax)-Number(oldMinY));
			    			}else if(condetion2) {
				    			areaTmp = (Number(tmpXMax)-Number(oldMinX))*(Number(oldMaxY)-Number(tmpYMin));
			    			}else if(condetion3) {
				    			areaTmp = (Number(oldMaxX)-Number(tmpXMin))*(Number(tmpYMax)-Number(oldMinY));
			    			}else if(condetion4) {
				    			areaTmp = (Number(oldMaxX)-Number(tmpXMin))*(Number(oldMaxY)-Number(tmpYMin));
			    			}
			    			if(areaTmp>areaArray[0][0]) {
			    			
				    			areaArray[0][0] = areaTmp;//面积
					    		areaArray[0][1] = positArray[i][6];//positArray[i][6],此位置是否有设备。1：有设备
					    		areaArray[0][2] = positArray[i][7];//对应设备的div的ID
					    		areaArray[0][3] = tmpXMin;//板卡对齐后的x坐标
					    		areaArray[0][4] = tmpYMin;//板卡对齐后的y坐标
					    		areaArray[0][5] = positArray[i][9];//parShowIndex
					    		areaArray[0][6] = positArray[i][12];//parShowIndex
					    		areaArray[0][7] = positArray[i][4];//
					    		areaArray[0][8] = positArray[i][10];//
					    		areaArray[0][9] = positArray[i][11];//
					    		areaArray[0][10] = positArray[i][8];//
					    		areaArray[0][11] = i;//
					    		areaArray[0][12] = true;//是否有和板卡div重合的槽位
					    		areaArray[0][13] = positArray[i][5];//槽位设备型号
			    			}
			    		}
                    	
			    	}
			    	
			    	//板卡div至少和一个槽位重叠
                    if(areaArray[0][12]) {	
                    	
                   			var tmp = document.getElementById(objId);
                    		if(areaArray[0][1]==1) {//此位置已有设备positArray[i][6]
                    			//删除原来的位置上的设备，将当前设备作为新的设备放到位置上                    			
				    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡-????????
				    			var deviceDivId = areaArray[0][2];//positArray[i][7]
				    			//说明当前卡槽的位置已经有板卡了，需要将此板卡div删除，将对应input删除，将positArray[i][7]清空，将positArray[i][6]置为无设备
				    			if(deviceDivId!='') {
					    			delDivMapInputAndPosition(deviceDivId);//包含positArray[i][6] = 0/positArray[i][7] = '';	操作
				    				var divObj = document.getElementById(deviceDivId);
					    			document.deviceConfigForm.removeChild(divObj);
				    			}
                    		}
                    		
			    			obj.style.left = areaArray[0][3] +"px";//tmpXMin
                    		obj.style.top = areaArray[0][4] +"px";//tmpYMin
                   		    //此时不用删除div之前对应的input和位置，因为up之前不会有对应的:
                   			var parShowIndex = generatParShowIndex(areaArray[0][5],(areaArray[0][6]+1));//因为设备型号维护时，showIndex默认为1，所以此处的设备编号要从1开始
                    	 	createDeviceInfo(tmp,areaArray[0][7],areaArray[0][8],areaArray[0][9],objId,areaArray[0][10],parShowIndex);
                    		positArray[areaArray[0][11]][6] = 1;
                    		positArray[areaArray[0][11]][7] = objId;
                    		
                    		//update by jinsj begin  验证子设备与槽位是否对应
                    		if(areaArray[0][13] != null){
						    	var flag = checkPosition(getAttributeValueByEle(tmp,"parDeviceCode"),getAttributeValueByEle(tmp,"deviceCode"),areaArray[0][13]);
						    	if(!flag){
						    		//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
					    			delDivMapInputAndPosition(objId);
					    			document.deviceConfigForm.removeChild(obj);
						    		return false;
						    	}
						    }
					    	//update by jinsj end 
			    	}
			    	
			    	//删除div，及关系：由于一移动div板卡则删除关系，所以删除某个板卡时，可以不用再删除关系，不过可以看一下是否有关系存在，有就删除
			    	/*var tmpXMin = 	delArray[0];
                   	var tmpXMax = 	delArray[1];
                   	var tmpYMin = 	delArray[2];
                   	var tmpYMax = 	delArray[3];
                   	
		    		if(((tmpXMin<=oldMinX && oldMinX<=tmpXMax)
		    		             ||  (tmpXMin<=oldMaxX && oldMaxX<=tmpXMax)
		    		             ||  (oldMinX<=tmpXMin && tmpXMin<=oldMaxX)
		    		             ||  (oldMinX<=tmpXMax && tmpXMax<=oldMaxX))
		    		     &&
		    		    ((tmpYMin<=oldMinY && oldMinY<=tmpYMax)
		    		             ||  (tmpYMin<=oldMaxY && oldMaxY<=tmpYMax)
		    		             ||  (oldMinY<=tmpYMin && tmpYMin<=oldMaxY)
		    		             ||  (oldMinY<=tmpYMax && tmpYMax<=oldMaxY))) {
		    			
		    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
		    			delDivMapInputAndPosition(objId);
		    			document.deviceConfigForm.removeChild(obj);
		    		}*/
		    		
		    		var tmpXMin = 	delArray[0];
                   	var tmpXMax = 	delArray[1];
                   	var tmpYMin = 	delArray[2];
                   	var tmpYMax = 	delArray[3];
                   	
		    		if( oldMaxX<tmpXMin 
		    		             || oldMinX>tmpXMax
		    		             ||  oldMinY>tmpYMax 
		    		             ||  oldMaxY<tmpYMin) {
		    			
		    			//删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
		    			delDivMapInputAndPosition(objId);
		    			document.deviceConfigForm.removeChild(obj);
		    		}
                }
            }
     }
     
     function generatParShowIndex(parShowIndex,showIndex) {
     	 var parShowIndexTmp = "";
     	 if(isNotBlank(parShowIndex) && isNotBlank(showIndex)) {
         		parShowIndexTmp = parShowIndex + "," + showIndex;
         }else {
         		parShowIndexTmp = isNotBlank(showIndex)?showIndex:(isNotBlank(parShowIndex)?parShowIndex:"");
         }
         
         return parShowIndexTmp;
     }
     
     function isNotBlank(obj) {
     	if(obj!="" && obj!=null && obj!='undefined') {
     		return true;
     	}else {
     		return false;
     	}
     }
     
     
     //删除div（板卡设备）对应的input 及 清空父级设备位置已被占用标志，并清空位置对应的div的ID
     function delDivMapInputAndPosition(objId) {
     	 //删除当前移动板卡对应的所有input,将当前板卡所在的位置置为无板卡
     	 var len = jQuery("input[mapDivId="+objId+"]").length;
     	 if(len>0) {
			 var showIndex = jQuery("input[mapDivId="+objId+"][name$='showIndex']").val();
	         jQuery("input[mapDivId="+objId+"]").remove();//删除当前移动板卡对应的所有input
	         for(var j=0;j<positionCount;j++) {
	         	if(showIndex==positArray[j][4]) {//将当前板卡所在的位置置为无板卡
	           		positArray[j][6] = 0;
	           		positArray[j][7] = '';
	         		break;
	         	}
	         }
     	 }
     }
     
     
     function add() {
     	//至少配置一个子设备
     	if(true) {
	     	document.deviceConfigForm.action="<%=path%>/detection/switchDetection.do?action=addSpecialDeviceConfig";
	     	document.deviceConfigForm.submit();
     	
     	    jQuery("#addButton").attr("disabled","true");
			jQuery("#backButton").attr("disabled","true");
     	}
     }
     
     function goBack() {
     	 document.deviceConfigForm.action="<%=path%>/detection/switchDetection.do?action=toConfigSpecialDevice";
	     document.deviceConfigForm.submit();
     }
     
    </script>
</head>
<body style="font-size: 12px;-moz-user-select:none;" onselectstart="return false;" unselectable="on" >
<form id="deviceConfigForm"  action="<%=path%>/detection/switchDetection.do?action=addSpecialDeviceConfig" name="deviceConfigForm" method="post">
	<input id="indexStr" type="hidden" />
	<input id="indexStr2" type="hidden" />
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
<!--	<div style="font-size: 12px;">
	  配置节点IP：<select id="" name="">
	  	<option id="" value="seqId">10.0.6.102</option>
	  	<option id="" value="">10.0.6.250</option>
	  	<option id="" value="">10.0.6.253</option>
	  	<option id="" value="">10.0.6.254</option>
	  </select>
	   <br/><br/>
	  设备类型：<select id="" name="">
	  	<option id="" value="DPtech">迪普分流设备</option>
	  	<option id="" value="H3C">华三交换机</option>
	  </select>
	  <br/><br/>
	  设备型号：<select id="" name="">
	  	<option id="" value="DPX8000-A12">DPX8000-A12</option>
	  	<option id="" value="S5048E">S5048E</option>
	  </select>
	</div>  
	   -->	 
	 <table border="0" cellpadding="0" cellspacing="0"  style="width:100%;height: 90%;margin-top: 5px;">
	   <tr>
	   		<td width="5%">
		     <div style="left: ${rootDeviceX}px;top:7px;">
			   	i18n_sdc.text.ip_n81i：${ip}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   	i18n_sdc.text.deviceBrandTypeCode_n81i：${deviceBrandTypeCode}
		   	 <div>
		   	</td>
		   <td width="20%">
		  <c:choose>
				<c:when test="${fn:length(deviceModelList) > 0}">
				    <!-- model的宽和高：如果板卡的宽大于高：model 宽128，高14，如果板卡的宽小于高：model 宽14,高128 -->
				    <c:if test="${modelSortByXorY=='x' || modelSortByXorY=='X'}">
					    <c:set var="modelWidth" value="128" />
					    <c:set var="modelHeight" value="14" />
					    <!-- model距离页面左边和上边的距离、及文字和model图的距离 -->
					    <c:set var="topStart" value="60" /><!-- 第一行距离顶部的距离 -->
					    <c:set var="topLen" value="60" /><!-- 每行的高度 -->
					    <c:set var="leftStart" value="100" /><!-- 第一列模型距离左边的距离 -->
					    <c:set var="columnSpace" value="148" /><!--每列之间的距离 -->
					    <c:set var="space" value="15" /><!-- 文字顶部和图片顶部之间的距离 -->
				    </c:if>
				    
				    <c:if test="${modelSortByXorY=='y' || modelSortByXorY=='Y'}">
					    <c:set var="modelWidth" value="14" />
					    <c:set var="modelHeight" value="100" />
					    <!-- model距离页面左边和上边的距离、及文字和model图的距离 -->
					    <c:set var="topStart" value="40" /><!-- 第一行距离顶部的距离 -->
					    <c:set var="topLen" value="130" /><!-- 每行的高度 -->
					    <c:set var="leftStart" value="100" /><!-- 第一列模型距离左边的距离 -->
					    <c:set var="columnSpace" value="120" /><!--每列之间的距离 -->
					    <c:set var="space" value="105" /><!-- 文字顶部和图片顶部之间的距离 -->
				    </c:if>
				    
					<c:set var="dec2Count" value="1" />
					<c:set var="columnCount" value="1" />
					
					<c:forEach items="${deviceModelList}" var="device" >
						   <c:set var="leftTmp" value="${(columnCount-1)*columnSpace+leftStart}" />
						   <c:set var="topTmp" value="${(dec2Count-1)*topLen+topStart}" />
						   
						   <c:if test="${(topTmp+topLen)>600}"><!-- 如果排列的model超过了一屏幕的高度，则新起一列 -->
						        <c:set var="columnCount" value="${columnCount+1}" />
						        <c:set var="dec2Count" value="1" />
						        
						   		<c:set var="leftTmp" value="${(columnCount-1)*columnSpace+leftStart}" />
						   		<c:set var="topTmp" value="${(dec2Count-1)*topLen+topStart}" />
						   </c:if>
						   
						   
						   
				           <div id="div_${device.deviceCode}_backImg" style="left: ${leftTmp}px;top: ${topTmp}px;" align="center"  >
					               <img src="<%=path %>/images/svg/model/${device.deviceFillMini}"  width="${modelWidth}px" height="${modelHeight}px;" /> 
			               </div><!-- 用于显示 -->
			               <div id="div_${device.deviceCode}" widthTrue="${device.deviceWidth}" heightTrue="${device.deviceHeight}" 
						                imageTrue="url('<%=path %>/images/svg/model/${device.deviceFill}')" 
						                devId="${device.id}"
						                parDeviceCode="${device.parDeviceCode}"
						                deviceCode="${device.deviceCode}"
						                deviceHeight="${device.deviceHeight}"
						                deviceWidth="${device.deviceWidth}"
						                showLevel="${device.showLevel}"
						                deviceFill="${device.deviceFill}"
						                isLink="${device.isLink}"
						                showIndex="${device.showIndex}"
						                isLeaf="${device.isLeaf}"
						                figureX="${device.figureX}"
						                figureY="${device.figureY}"
						                style="left: ${leftTmp}px;top: ${topTmp}px;width:${modelWidth}px;height:${modelHeight}px; background:no-repeat ; background-image: url('<%=path %>/images/svg/model/${device.deviceFillMini}');"  
						                >
				           </div>
					       
					       <input id="initDivTop_${device.deviceCode}" type="hidden" value="${topTmp}" />
					       
				           <c:if test="${modelSortByXorY=='x' || modelSortByXorY=='X'}">
					           <div id="div_${device.deviceCode}_name" style="left: ${leftTmp}px;top: ${topTmp+space}px;width:${modelWidth}px;height:12px;" align="center" >
					           		${device.deviceCode}
					           </div>
					           
						   	   <input id="initTextTop_${device.deviceCode}" type="hidden" value="${topTmp+space}" />
				           </c:if>
				           <c:if test="${modelSortByXorY=='y' || modelSortByXorY=='Y'}">
				           	   <div id="div_${device.deviceCode}_name" style="left: ${leftTmp+17}px;top: ${topTmp+modelHeight/2-15}px;width:85px;height:30px;" align="center" >
					           		${device.deviceCode}
					           </div>
					           
						       <input id="initTextTop_${device.deviceCode}" type="hidden" value="${topTmp+modelHeight/2-15}" />
				           </c:if>
				           
				           <c:set var="dec2Count" value="${dec2Count+1}" />
					</c:forEach>
				</c:when>
				<c:otherwise>
						
				</c:otherwise>
		  </c:choose>		
		   <!--		  	
		  <div id="rootDev"  style="display:inline;width:${rootDevice.deviceWidth}px;height:${rootDevice.deviceHeight}px;left: ${rootDeviceX}px;top:${rootDeviceY}px;background:no-repeat; " >
			  <img src="<%=path %>/images/svg/model/${rootDevice.deviceFill}"   id="" width="${rootDevice.deviceWidth}px" height="${rootDevice.deviceHeight}px;" />
			  <input  id="" name="deviceConfigList[0].id"  value="${rootDevice.id}" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].pid"  value="0" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].parDeviceCode"  value="" type="hidden"/>
			  
			  <input  id="" name="deviceConfigList[0].deviceCode"  value="${rootDevice.deviceCode}" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].showIndex"  value="${rootDevice.showIndex}" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].showLevel"  value="${rootDevice.showLevel}" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].figureX"  value="${rootDevice.figureX}" type="hidden"/>
			  <input  id="" name="deviceConfigList[0].figureY"  value="${rootDevice.figureY}" type="hidden"/>
			  
		  </div>
		  -->
		  
		  <c:set var="rootDevTopCount" value="0" />
		  <c:forEach begin="1" end="${maxDevNum}"  varStatus="devCount">
			  <c:if test="${sortByXorY=='x' || sortByXorY=='X'}">
			  		<c:set var="rootLeftTmp" value="${rootDeviceX+(rootDevice.deviceWidth+deviceGap)*rootDevTopCount}" />
			  		<c:set var="rootTopTmp" value="${rootDeviceY}" />
			  </c:if>  
			  <c:if test="${sortByXorY!='x'&& sortByXorY!='X'}">
			  		<c:set var="rootLeftTmp" value="${rootDeviceX}" />
			  		<c:set var="rootTopTmp" value="${rootDeviceY+(rootDevice.deviceHeight+deviceGap)*rootDevTopCount}" />
		      </c:if>  
		      
			  <div id="rootDev_${rootDevTopCount}"  style="display:inline;width:${rootDevice.deviceWidth}px;height:${rootDevice.deviceHeight}px;left: ${rootLeftTmp}px;top:${rootTopTmp}px;background:no-repeat; " >
				  <img src="<%=path %>/images/svg/model/${rootDevice.deviceFill}"   id="" width="${rootDevice.deviceWidth}px" height="${rootDevice.deviceHeight}px;" />
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].id"  value="${rootDevice.id}" type="hidden"/>
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].pid"  value="0" type="hidden"/>
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].parDeviceCode"  value="" type="hidden"/>
				  
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].deviceCode"  value="${rootDevice.deviceCode}" type="hidden"/>
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].showIndex"  value="${rootDevice.showIndex+rootDevTopCount}" type="hidden"/>
				  <input  id="" name="deviceConfigList[${rootDevTopCount}].showLevel"  value="${rootDevice.showLevel}" type="hidden"/>
				  <c:if test="${sortByXorY=='x' || sortByXorY=='X'}">
					  <input  id="" name="deviceConfigList[${rootDevTopCount}].figureX"  value="${rootDevice.figureX+(rootDevice.deviceWidth+deviceGap)*rootDevTopCount}" type="hidden"/>
					  <input  id="" name="deviceConfigList[${rootDevTopCount}].figureY"  value="${rootDevice.figureY}" type="hidden"/>
				  </c:if>  
				  <c:if test="${sortByXorY!='x'&& sortByXorY!='X'}">
					  <input  id="" name="deviceConfigList[${rootDevTopCount}].figureX"  value="${rootDevice.figureX}" type="hidden"/>
					  <input  id="" name="deviceConfigList[${rootDevTopCount}].figureY"  value="${rootDevice.figureY+(rootDevice.deviceHeight+deviceGap)*rootDevTopCount}" type="hidden"/>
				  </c:if>  
				  
			  </div>
			  <c:set var="rootDevTopCount" value="${rootDevTopCount+1}" />
		  </c:forEach> 
		 
		  </td>
		  <td width="10%" valign="top" >
		 	 <div id="backBut" style="position: absolute; top: 5; left: 85%;">
				  <input type="button" class="btn3_mouseout" id="addButton"
														onmouseover="this.className='btn3_mouseover'"
														onmouseout="this.className='btn3_mouseout'"
														onmousedown="this.className='btn3_mousedown'"
														onmouseup="this.className='btn3_mouseup'" 
														onclick="add()" value="i18n_sdc.button.submit_n81i"/>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    
				  <input type="button" class="btn3_mouseout" id="backButton"
														onmouseover="this.className='btn3_mouseover'"
														onmouseout="this.className='btn3_mouseout'"
														onmousedown="this.className='btn3_mousedown'"
														onmouseup="this.className='btn3_mouseup'" 
														onclick="goBack()" value="i18n_sdc.button.back_n81i"/>
			 </div>
	      </td>
	  </tr> 
   </table>
    <script type="text/javascript">
        <c:forEach items="${deviceModelList}" var="device" varStatus="vs">
			drag("div_${device.deviceCode}");
		</c:forEach>
    </script> 
  		
	</form>
</body>
</html>


