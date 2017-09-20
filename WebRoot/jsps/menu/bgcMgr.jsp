<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>易乐商城后台管理系统</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/leftMenu.css"></c:url>">
	<link rel="stylesheet" type="text/css" href="<c:url value="/libs/bootstrap/css/bootstrap.min.css"></c:url>">
	<script type="text/javascript" src="<c:url value="/libs/jquery/jquery-3.2.1.js"></c:url>"></script>
	<script type="text/javascript" src="<c:url value="/libs/bootstrap/js/bootstrap.min.js"></c:url>"></script>
 	<style type="text/css">
 		body,html{
			margin:0px;
			height:100%;
		}
 	
 		.mainPanel{
 			background-color: #3388FF;
 			width: 100%;
 			height: 100%;
 			color: #fff;
 			padding-top: 200px;
 			padding-left: 500px;
 			font-size: 60px;
 		}
 	</style>
  </head>
  	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
  	<div class="mainPanel">
  		易乐商城后台管理系统
  	</div>
  <body>
  		
  </body>
</html>
