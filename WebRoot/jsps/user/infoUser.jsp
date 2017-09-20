<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/css/bootstrap-theme.min.css">
	<script src="${pageContext.request.contextPath}/libs/jquery/jquery-3.2.1.js"></script>
	<script src="${pageContext.request.contextPath}/libs/bootstrap/js/bootstrap.min.js"></script>
	<style type="text/css">
		h1{
			text-align: center;
			width: 20%;
			margin: 20px 40%;
		}
		
		#form{
			/* width: 250px;
			height: 300px; */
			padding: 20px;
			margin:20px auto;
		}
		#reset{
			margin-left:130px;
		}
		.errorMessage{
			list-style-type: none;
			color:red;
			font-size:25px;
			margin:10px auto;
			font-weight:bold;
			text-align: center;
			padding: 0px;
		}
		
		input[type="radio"]{
			margin-left: 15px;
		}
		
		#return{
			position: absolute;
			top: 20px;
			right: 20px;
		}
		.goodsPic{
			position:absolute;
			top: 260px;
			right: 170px;
			width: 200px;
			height: 2000px;
		}
	</style>
	<script type="text/javascript">
		
		
	</script>
  </head>
  
  <body>
  	<s:include value="/jsps/user/leftMenuUser.jsp"></s:include>
	<h1>用户详细信息</h1>
	<s:form action="admin_update.do" namespace="/admin" method="post" id="form" class="form-horizontal">
		<div class="form-group">
			<label for="userName" class="col-sm-2 col-sm-offset-4 control-label">用户ID：</label>
			<div class="col-sm-3">
				<s:property value="user.userId"/>
			</div>
		</div>
		<div class="form-group">
			<label for="userName" class="col-sm-2 col-sm-offset-4 control-label">用户名：</label>
			<div class="col-sm-3">
				<s:property value="user.userName"/>
			</div>
		</div>
		<div class="form-group">
			<label for="realName" class="col-sm-2 col-sm-offset-4 control-label">真实姓名：</label>
			<div class="col-sm-3">
				<s:property value="user.realName"/>
			</div>
		</div>
		<div class="form-group">
			<label for="sex" class="col-sm-2 col-sm-offset-4 control-label">性别：</label>
			<div class="col-sm-3" style="margin-top:5px">
				<s:if test="user.sex==1">男</s:if>
				<s:else>女</s:else>
			</div>
		</div>
		<div class="form-group">
			<label for="identify" class="col-sm-2 col-sm-offset-4 control-label">身份：</label>
			<div class="col-sm-3" style="margin-top:5px">
				<s:if test="user.identify==2">普通用户</s:if>
			</div>
		</div>
		<div class="form-group">
			<label for="birthday" class="col-sm-2 col-sm-offset-4 control-label">出生日期：</label>
			<div class="col-sm-3">
				<s:date name="user.birthday" format="yyyy-MM-dd"/>
			</div>
		</div>
		<div class="form-group">
			<label for="email" class="col-sm-2 col-sm-offset-4 control-label">电子邮箱：</label>
			<div class="col-sm-3">
				<s:property value="user.email" />
			</div>
		</div>
		<div class="form-group">
			<label for="phone" class="col-sm-2 col-sm-offset-4 control-label">电话号码：</label>
			<div class="col-sm-3">
				<s:property value="user.phone" />
			</div>
		</div>
		<div class="form-group">
			<label for="postCode" class="col-sm-2 col-sm-offset-4 control-label">邮政编码：</label>
			<div class="col-sm-3">
				<s:property value="user.postCode" />
			</div>
		</div>
		<div class="form-group">
			<label for="postCode" class="col-sm-2 col-sm-offset-4 control-label">地址：</label>
			<div class="col-sm-3">
				<s:property value="user.address" />
			</div>
		</div>
	</s:form>
  </body>
</html>
