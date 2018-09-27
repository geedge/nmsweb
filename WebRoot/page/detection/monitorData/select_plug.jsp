<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/jstl/c" prefix="c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<%@ taglib prefix="fmt" uri="/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>i18n_sp.message.title_n81i</title>
		<script type='text/javascript' src="<c:url value='/js/jquery-1.4.2.min.js'/>"></script>
  
		<style type="text/css">
		body{
			font-size:12px;
		}
.item {
	display: block;
	float: left;
	margin: 1px;
}
</style>
<script type="text/javascript">
$(function() {
	$("#clearQuery").click(function() {
		$("#query").val("");
		$(".item").show();
	})
	//multi
	$("#query").keyup(function(key) {
		var str = $(this).val();
		query(str);
	})

	$("#ok").click(function() {
		var result = "";
		var num = $(".checks:checked").size();
		if(num>5){
				alert("i18n_sp.message.selectToDraw_n81i");
				return;
		}else{
			$(".checks:checked").each(function() {
				var lable = $(this).closest("label");
				result += lable.attr("ids")+',';
			});
			if (result == "") {
				alert("i18n_sp.message.selectTodrawID_n81i");
				return;
			} else {
				//parent.window.returnValue = result;
				var ctId= $("#ctid").val();
				var disId= $("#did").val();
				var metaId= $("#mid").val();
				var seqId= $("#seqId").val();
				var drwTo= $("#drIndex").val();
				
				//var resu = window.opener.dialogArguments;
				var resu = $(window.parent.document).find("#I3")[0].contentWindow;
				//alert("父窗体引用："+resu);
				resu.getPicScorce(metaId,disId,ctId,seqId,result,drwTo)
			}
			layclose();
		}
	})
	
	$("#clear").click(function() {
		$(".checks").removeAttr("checked");
		resetBg();
	})

	$("#cancel").click(function() {
		layclose();
	})

	$(".checks").click(function() {
		resetBg();
	})

})

$(function() {
	$("#query").focus();
})
function layclose() {
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}
function resetBg() {
	$(".checks").each(function() {
		var label = $(this).closest("label");
		if ($(this).is(":checked")) {
			label.css("background-Color", "#B5C19B");
		} else {
			label.css("background-Color", "");
		}
	})
}

function query(str) {
	if ($.trim(str) == "") {
		$(".item").show();
	} else {
		$(".item").hide();
		$(".item[title^='" + str + "']").show();
	}
}

</script>
	</head>
	<body>
	<form action="" name="Mkform" method="post">
			<input type="hidden" id="seqId" name="seqId"  value="${sqId}"/>
			<input type="hidden" id="did" name ="dsiId" value="${dsiId }"/>
			<input type="hidden" id = "ctid" name="ctid" value = "${ctId}"/>
			<input type="hidden" id = "mid" name="mid" value = "${metaId}"/>
			<input type="hidden" id="drIndex" name="drIndex" value="${drIndex}"/>
		<table class="STYLE1" width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr style="">
				<td style="padding: 5px 0px 0px 5px">
					i18n_sp.text.query_n81i：
					<input type="text" id="query"
						style="height: 15px; border: solid 1px; border-right-width: 0px;" />
					<span title="清空" id="clearQuery"
						style="cursor: pointer; margin-left: -3px; border: solid 1px; border-left-width: 0px; padding: 2px 5px 0px 5px">×</span>
					&nbsp;&nbsp;i18n_sp.message.query_n81i

				</td>
			</tr>
			<tr>
				<td>
					<div id="listDiv"
						style="margin:5px 0px;background-color: #d3eaef; height: 260px; overflow: auto;border:1px solid gray;">
						<c:forEach items="${dataList}" var="item">
							<label class="item" title="${item}" ids="${item}"style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 120px;">
								<input class="checks" type="checkbox" value="${item}"/>
								${item}
							</label>
						</c:forEach>
					</div>
				</td>
			</tr>
			<tr>
				<td style="padding: 0px 5px">
					<input class="btn" style="width: 80px;float:left" id="clear"
						type="button" value="i18n_sp.button.clear_n81i" />
					<input class="btn" style="width: 80px;margin-left: 5px;float:right;" id="ok" type="button"
						value="i18n_sp.button.ok_n81i" />
					<input class="btn" style="width: 80px;margin-left: 5px;float:right;" id="cancel" type="button"
						value="i18n_sp.button.cancel_n81i" />
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>