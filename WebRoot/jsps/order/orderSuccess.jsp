<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsps/common-tags.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'orderSuccess.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap-theme.min.css">
	<script src="${pageContext.request.contextPath}/libs/jquery/jquery-3.2.1.js"></script>
	<script src="${pageContext.request.contextPath}/libs/bootstrap/js/bootstrap.min.js"></script>

  </head>
  
  <body>
	  <div class="container">
	  	<div class="jumbotron">
		  <div class="container">
		    	<h3>已成功收到您的订单，商品正在出库...请亲耐心等待 ^_^ !</h3><br /><br />
		    	<p><a class="btn btn-primary" href="<s:url action='goods_loadAllFront' namespace='/goods' />" role="button">返回商城首页</a>
		  		<a class="btn btn-success" href="<s:url action='order_loadOrderByUserId' namespace='/order' />" role="button">订单中心</a></p>
		  </div>
		</div>
	  </div>
	
  </body>
</html>
