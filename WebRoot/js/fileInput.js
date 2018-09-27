var clickBtn;
$(function(){
	
//	$("input[type='file']").change(function(){
//		var fileName=this.value;
//		var subName=fileName.substring(0,fileName.lastIndexOf("\."));
//		if(subName.length>10){
//			fileName=fileName.substring(0,9)+"*"+fileName.substring(fileName.lastIndexOf("\."));
//		}
//	//	$(clickBtn).val(fileName);
//		$(clickBtn).after("<input type='text' value="+fileName+" readonly='readonly' style='width:120px;margin-left:5px'/>");
//		
//	});
});
function setValue(inVal){
	var splitObj=inVal.split("\\");
	if(splitObj.length>1){
	inVal=splitObj[splitObj.length-1];	
	}
	if($(clickBtn).next("input[type='text']").length<1){
		var inputObj=document.createElement("input");
		inputObj.setAttribute("type","text");
		inputObj.setAttribute("value",inVal);
		inputObj.setAttribute("readonly","readonly");
		inputObj.setAttribute("style","width:120px;margin-left:5px");
		insertAfter(inputObj,clickBtn);
	}else{
		$(clickBtn).next("input[type='text']").attr("value",inVal);
	}
}
function uploadFile(btn){
	clickBtn=btn;
	$(btn).siblings("input[type='file']").click();
	
}

function insertAfter(newElement,targetElement){
	var parent=targetElement.parentNode;
	if(parent.lastChaild == targetElement){
		parent.appendChild(newElement);
	}else{
		parent.insertBefore(newElement,targetElement.nextSibling);
	}
}