<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap-theme.min.css">
	<script src="${pageContext.request.contextPath}/libs/jquery/jquery-3.2.1.js"></script>
	<script src="${pageContext.request.contextPath}/libs/bootstrap/js/bootstrap.min.js"></script>
	<style type="text/css">
		h1{
			text-align: center;
		}
		
		#form{
			width: 250px;
			height: 300px;
			margin:20px auto;
		}
		#reset{
			margin-left:130px;
		}
		.errorMessage{
			list-style-type: none;
			color:red;
			font-size:15px;
			margin:10px auto;
			font-weight:bold;
			text-align: center;
			padding: 0px;
		}
		#submit_group{
			margin-top: 10px;
		}
		.btn{
			margin-left: 30px;
			margin-right: 20px;
		}
	</style>
  </head>
  
  <body>
	<h1>欢迎登陆</h1>
	<s:form action="login_login.do" namespace="/login" method="post" id="form">
		<div class="form-group">
			<label for="userName">用户名：</label>
			<input name="userName" id="userName" type="text" class="form-control" placeholder="用户名"/>
			<s:fielderror fieldName="userName"></s:fielderror>
		</div>
		<div class="form-group">
			<label for="password">密　码：</label>
			<input name="password" id="password" type="password" class="form-control" placeholder="密码"/>
			<s:fielderror fieldName="password"></s:fielderror>
		</div>
		<div>
			<label for="identify">身　份：</label>
			<select class="form-control" name="identify">
			  <option value="0">超级管理员</option>
			  <option value="1">普通管理员</option>
			  <option value="2">普通用户</option>
			</select>
		</div>
		<div id="submit_group" class="form-group">
			<button type="submit" class="btn btn-default" id="submit">登录</button>
			<a class="btn btn-danger" href="<s:url action="login_toReg" namespace="/login"></s:url>">注册</a>
		</div>
		<s:actionerror/>
	</s:form>
  </body>
</html>
