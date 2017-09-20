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
		$(function(){
			getParentGoodsType();
		
		
			document.getElementById("goodsPic").onchange = function() {
			    var imgFile = this.files[0];
			    var fr = new FileReader();
			    fr.onload = function() {
			        document.getElementById("img").src = fr.result;
			        document.getElementById("img").style.display = "block";
			    };	
			    fr.readAsDataURL(imgFile);
			};
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
		
		
		function getSubGoodsTypeByParent(){
			var parentId = $("#parentId").val();
			/* console.log("onchange:"+parentId); */
			$("#subId").empty();
			$("#subId").append('<option value="">===请选择===</option>');
			$.getJSON("<s:url action='goodsType_loadSubJson.do?parentId=' namespace='/goodsType'></s:url>"+parentId,function(json){
				/* console.log("sub:" + json.length); */
			  for(var i = 0; i < json.length; i++){
			  	$("#subId").append("<option value='" +json[i].id+ "'>"+ json[i].goodsTypeName+"</option>");
			  }
			});
		}
		
		/**
		 * 新增/修改商品类别提交验证
		 */
		function validate(){
			var goodsName = $("#goodsName").val();
			var goodsPrice = $("#goodsPrice").val();
			
			if(goodsName.length <2 || goodsName.length > 15){
				$(".errorMessage").html("商品名称有效长度为2-15");
				$($("#form>div")[0]).addClass("has-error has-feedback");
				return false;
			}
			if(isNaN(goodsPrice)){
			  	$(".errorMessage").html("商品单价必须为数字");
			  	$($("#form>div")[1]).addClass("has-error has-feedback");
				return false;
			}
			 
			 str = goodsPrice.split(".");
			 if(str.length > 1){
			 	 console.log(str[1].length);
				 if(str[1].length > 2){
				  	$(".errorMessage").html("商品价格最多包含2位小数");
				  	$($("#form>div")[1]).addClass("has-error has-feedback");
					return false;
				}
			 }
		};
		
		function picCheck(){
			var goodsPic = $("#goodsPic").val();
			if(goodsPic != ""){
				var picStr = goodsPic.split(".");
				var fileType = ["jpg","jpeg","gif","png","bmp"];
				for(var i = 0; i < fileType.length; i++){
					if(picStr[picStr.length-1] === fileType[i]){
						return true;
					}
				}
				$(".errorMessage").html("只允许上传后缀为jpg, gif, png, bmp格式的图片");
			}
		}
	</script>
  </head>
  
  <body>
  	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
  	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="goods_loadAll" namespace="/goods" />'>返回上一级</a>
	</button>
	<h1>添加商品信息</h1>
	<s:form action="goods_add.do" namespace="/goods" method="post" id="form" class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group">
			<label for="goodsName" class="col-sm-2 col-sm-offset-3 control-label">商品名称：</label>
			<div class="col-sm-3">
				<input name="goodsName" id="goodsName" type="text" class="form-control" placeholder="商品名称" required/>
			</div>
		</div>
		<div class="form-group">
			<label for="goodsPrice" class="col-sm-2 col-sm-offset-3 control-label">商品单价：</label>
			<div class="col-sm-3">
				<input name="goodsPrice" id="goodsPrice" type="text" class="form-control" placeholder="商品单价" required/>
			</div>
		</div>
		<div class="form-group">
			<label for="parentId" class="col-sm-2 col-sm-offset-3 control-label">商品大类别：</label>
			<div class="col-sm-3">
				<select class="form-control" name="parentId" id="parentId" onclick="getParentGoodsType();" onchange="getSubGoodsTypeByParent();">
				  <option value="">===请选择===</option>		  
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="subId" class="col-sm-2 col-sm-offset-3 control-label">商品小类别：</label>
			<div class="col-sm-3">
				<select class="form-control" id="subId" name="subId">
				  <option value="">===请选择===</option>		  
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="desc" class="col-sm-2 col-sm-offset-3 control-label">商品描述：</label>
			<div class="col-sm-3">
				<textarea class="form-control" id="desc" name="desc" rows="5" required></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="active" class="col-sm-2 col-sm-offset-3 control-label">是否有货：</label>
			<div class="col-sm-3" style="margin-top:5px">
				<s:radio name="enough" list="#{\"1\":'有货',\"0\":'无货'}" value="1"></s:radio>
			</div>
		</div>
		<div class="form-group">
			<label for="desc" class="col-sm-2 col-sm-offset-3 control-label">存货数量：</label>
			<div class="col-sm-3">
				<input name="leftCnt" id="leftCnt" type="number" class="form-control" placeholder="存货数量" value="0" required/>
			</div>
		</div>
		<div class="form-group">
		    <label for="goodsPic" class="col-sm-2 col-sm-offset-3 control-label">商品图片：</label>
		    <div class="col-sm-3">
		    	<input type="file" id="goodsPic" name="goodsPic" onchange="picCheck();">
		    	<p class="help-block">请上传后缀为jpg, gif, png, bmp格式的图片</p>
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
	<div class="errorMessage">
	
	</div>
	<div class="goodsPic">
		<img src="" alt="" id="img" width="200px" height="200px"/>
	</div>
  </body>
</html>
