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
	</style>
	<script type="text/javascript">
		$(function(){
			getParentGoodsType();
		});
		/**
		 * 获取父级商品类别列表(下拉选择select)
		 */
		function getParentGoodsType(){
			var value = $("#parentId").val();
			$("#parentId").empty();
			$("#parentId").append('<option value="">===请选择===</option>');
			$.getJSON("<s:url action='goodsType_loadParentJson.do' namespace='/goodsType'></s:url>", function(json){
			  for(var i = 0; i < json.length; i++){
			  	$("#parentId").append("<option value='" +json[i].id+ "'>"+ json[i].goodsTypeName+"</option>");
			  }
			  $("#parentId").val(value);
			});
		}
		
		/**
		 * 新增/修改商品类别提交验证
		 */
		function validate(){
			var goodsTypeName = $("#goodsTypeName").val();
			console.log(goodsTypeName.length);
			if(goodsTypeName.length <2 || goodsTypeName.length > 15){
				console.log("fail");
				$(".errorMessage").html("商品类别名称有效长度为2-15");
				$($("#form>div")[0]).addClass("has-error has-feedback");
				$($(".form-group>span")[0]).attr("aria-hidden","false");
				return false;
			}
		};
	</script>
  </head>
  
  <body>
  	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
  	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="goodsType_loadAll" namespace="/goodsType" />'>返回上一级</a>
	</button>
	<h1>添加商品类别</h1>
	<s:form action="goodsType_add.do" namespace="/goodsType" method="post" id="form" class="form-horizontal">
		<div class="form-group">
			<label for="goodsTypeName" class="col-sm-2 col-sm-offset-3 control-label">商品类别名称：</label>
			<div class="col-sm-3">
				<input name="goodsTypeName" id="goodsTypeName" type="text" class="form-control" placeholder="商品类别名称" required/>
			</div>
		</div>
		<div class="form-group">
			<label for="parentId" class="col-sm-2 col-sm-offset-3 control-label">父类别：</label>
			<div class="col-sm-3">
				<select class="form-control" name="parentId" id="parentId" onclick="getParentGoodsType();">
				  <option value="">===请选择===</option>		  
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="active" class="col-sm-2 col-sm-offset-3 control-label">是否可用：</label>
			<div class="col-sm-3" style="margin-top:5px">
				<s:radio name="active" list="#{\"1\":'可用',\"0\":'不可用'}" value="1"></s:radio>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-5">
			<button type="submit" class="btn btn-default" id="submit" onclick="return validate()">提交</button>
			<button type="reset" class="btn btn-danger" id="reset">重置</button>
			</div>
		</div>
		<s:actionerror/>
	</s:form>
	<div class="errorMessage">
	
	</div>
  </body>
</html>
