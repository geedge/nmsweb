<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/jstl/c"%>
<%@ taglib prefix="fn" uri="/jstl/fn"%>
<records>
	<c:forEach items="${listJsMkInfo}" var="jsMkInfo">
		 <record nodeId="${jsMkInfo.MKBH }" nodeType="0" nodePid="${jsMkInfo.PID }" nodeName="${jsMkInfo.MKMC }" url="javascript:queryMkGnInfo('${jsMkInfo.MKBH }')"/> 
	   
	</c:forEach>
</records>