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
		
		/**
		 * 用户注册/修改提交验证
		 */
		function validate(){
			var password = $("#password").val();
			var password2 = $("#password2").val();

			if(password.length <3 || password.length > 15){
				$(".errorMessage").html("密码有效长度为2-15");
				$($("#form>div")[1]).addClass("has-error has-feedback");
				return false;
			}
			if(password != password2){
				$(".errorMessage").html("两次输入的密码不相同");
				$($("#form>div")[1]).addClass("has-error has-feedback");
				return false;
			}

			
		};
		
	</script>
  </head>
  
  <body>
  	<s:if test="#session.user.identify==2">
  		<s:include value="/jsps/user/leftMenuUser.jsp"></s:include>
  	</s:if>
  	<s:else>
  		<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
  	</s:else>
	<h1>修改密码</h1>
	<div class="errorMessage">
	
	</div>
	<s:form action="user_updatePassword.do" namespace="/user" method="post" id="form" class="form-horizontal">
		<div class="form-group">
			<label for="password" class="col-sm-2 col-sm-offset-3 control-label">原密码：</label>
			<div class="col-sm-3">
				<s:password name="pwd" id="pwd" class="form-control" placeholder="密码" required="required"></s:password>
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-sm-2 col-sm-offset-3 control-label">密码：</label>
			<div class="col-sm-3">
				<s:password name="newPwd" id="password" class="form-control" placeholder="密码" required="required"></s:password>
			</div>
		</div>
		<div class="form-group">
			<label for="parentId" class="col-sm-2 col-sm-offset-3 control-label">再次输入密码：</label>
			<div class="col-sm-3">
				<s:password id="password2" class="form-control" placeholder="再次输入密码" required="required"></s:password>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-5">
			<button type="submit" class="btn btn-default" id="submit" onclick="return validate();">提交</button>
			<button type="reset" class="btn btn-danger" id="reset">重置</button>
			</div>
		</div>
		<s:actionerror/>
	</s:form>
  </body>
</html>
