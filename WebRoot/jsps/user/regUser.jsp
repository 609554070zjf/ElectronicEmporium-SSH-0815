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
		.btn{
			margin-left: 30px;
			margin-right: 20px;
		}
	</style>
	<script type="text/javascript">
		
		/**
		 * 用户注册/修改提交验证
		 */
		function validate(){
			var userName = $("#userName").val();
			var password = $("#password").val();
			var password2 = $("#password2").val();
			var realName = $("#realName").val();
			var birthday = $("#birthday").val();
			var phone = $("#phone").val();
			var postCode = $("#postCode").val();
			var email = $("#email").val();
			
			if(userName.length < 3 || userName.length > 15){
				$(".errorMessage").html("用户名有效长度为2-15");
				$($("#form>div")[0]).addClass("has-error has-feedback");
				return false;
			}
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
			if(realName.length <2 || realName.length > 10){
				$(".errorMessage").html("真实姓名有效长度为2-10");
				$($("#form>div")[2]).addClass("has-error has-feedback");
				return false;
			}
			var datePattern = /^(\d{4})\-(\d{2})\-(\d{2})$/;
			var flag1 = datePattern.test(birthday);
			var date = new Date(email);
			console.log("flag1:"+flage1);
			console.log("2:"+ date == "Invalid Date");
			if(!flag1 || date == "Invalid Date"){
				$(".errorMessage").html("出生日期格式不正确，正确格式：yyyy-mm-dd");
			  	$($("#form>div")[6]).addClass("has-error has-feedback");
				return false;
			}
			
			var emailPattern = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;     
			var flag2 = emailPattern.test(email);
			if(!flag2){
				$(".errorMessage").html("邮箱格式不正确");
			  	$($("#form>div")[7]).addClass("has-error has-feedback");
				return false;
			}
			if(isNaN(phone)){
			  	$(".errorMessage").html("电话号码必须为数字");
			  	$($("#form>div")[8]).addClass("has-error has-feedback");
				return false;
			}
			if(isNaN(postCode) || postCode.length != 6){
			  	$(".errorMessage").html("邮政编码必须为6位数字");
			  	$($("#form>div")[9]).addClass("has-error has-feedback");
				return false;
			}
			
		};
		
	</script>
  </head>
  
  <body>
  	<button type="button" class="btn btn-link" id="return">
		<a href='/'>返回</a>
	</button>
	<h1>用户注册</h1>
	<div class="errorMessage">
	
	</div>
	<s:form action="login_add.do" namespace="/login" method="post" id="form" class="form-horizontal">
		<div class="form-group">
			<label for="userName" class="col-sm-2 col-sm-offset-3 control-label">用户名：</label>
			<div class="col-sm-3">
				<s:textfield name="userName" id="userName" class="form-control" placeholder="用户名" required="required"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-sm-2 col-sm-offset-3 control-label">密码：</label>
			<div class="col-sm-3">
				<s:password name="password" id="password" class="form-control" placeholder="密码" required="required"></s:password>
			</div>
		</div>
		<div class="form-group">
			<label for="parentId" class="col-sm-2 col-sm-offset-3 control-label">再次输入密码：</label>
			<div class="col-sm-3">
				<s:password id="password2" class="form-control" placeholder="再次输入密码" required="required"></s:password>
			</div>
		</div>
		<div class="form-group">
			<label for="realName" class="col-sm-2 col-sm-offset-3 control-label">真实姓名：</label>
			<div class="col-sm-3">
				<s:textfield name="realName" id="realName" class="form-control" placeholder="真实姓名" required="required"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="sex" class="col-sm-2 col-sm-offset-3 control-label">性别：</label>
			<div class="col-sm-3" style="margin-top:5px">
				<s:radio name="sex" list="#{'1':'男','0':'女'}"  value="1"></s:radio>
			</div>
		</div>
		<s:hidden name="identify" value="2"></s:hidden>
		<s:hidden name="freezes" value="0"></s:hidden>
		<div class="form-group">
			<label for="birthday" class="col-sm-2 col-sm-offset-3 control-label">出生日期：</label>
			<div class="col-sm-3">
				<s:textfield name="birthday" id="birthday" placeholder="出生日期" required="required" class="form-control"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="email" class="col-sm-2 col-sm-offset-3 control-label">电子邮箱：</label>
			<div class="col-sm-3">
				<s:textfield name="email" id="email" class="form-control" placeholder="电子邮箱" required="required"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="phone" class="col-sm-2 col-sm-offset-3 control-label">电话号码：</label>
			<div class="col-sm-3">
				<s:textfield name="phone" id="phone" class="form-control" placeholder="电话号码" required="required"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="postCode" class="col-sm-2 col-sm-offset-3 control-label">邮政编码：</label>
			<div class="col-sm-3">
				<s:textfield name="postCode" id="postCode" class="form-control" placeholder="邮政编码" required="required"></s:textfield>
			</div>
		</div>
		<div class="form-group">
			<label for="postCode" class="col-sm-2 col-sm-offset-3 control-label">地址：</label>
			<div class="col-sm-3">
				<s:textarea id="address" name="address" class="form-control" required="required" rows="3"></s:textarea>
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
