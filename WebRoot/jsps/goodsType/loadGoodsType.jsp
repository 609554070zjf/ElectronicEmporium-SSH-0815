<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/jsps/common-tags.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		h1 {
			text-align: center;
		}
		
		.table th,.table td {
			text-align: center;
		}
		
		nav {
			right: 20px;
			position: absolute;
			display: inline-block;
		}
		
		#page {
			margin-top: 25px;
			font-size: 15px;
			position: absolute;
			right: 340px;
		}
		
		#return {
			float: left;
		}
		
		#form {
			margin: 30px auto 20px auto;
			width: 1075px;
		}
		.delete{
			font-size: 15px;
			font-weight: bold;
			color:red;
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
		
		function stop() {
			return false;
		}
		
		window.onload=function(){
			var a = document.getElementsByTagName("A");
			for (var i = 1; i < a.length; i++) {
				var href = a[i].href;
				var pageUrl = "<s:property value='pageUrl'/>";
				var url = "&" + pageUrl.substring(5);
				if(pageUrl!=""){
					a[i].href = href + url;
				}
				//a[i].href = href+"&amp;student.sex=m";
			}
		};
		
		/* function getStudent(stuName){
			console.log(stuName);
			document.getElementById("update_stuName").value = stuName;
		} */
		
		function getUpdateGoodsType(id,goodsTypeName,parentId){
			$("#update_goodsTypeId1").html(id);
			$("#update_goodsTypeId2").val(id);
			$("#update_goodsTypeName").val(goodsTypeName);
			$("#parentId").val(parentId);
		}
		
		function getDeleteGoodsType(id,goodsTypeName,parentId){
			$("#delete_goodsTypeId").html(id);
			$("#delete_goodsTypeName").html(goodsTypeName);
			if(parentId != ""){
				$("#delete_goodsTypeParent").html(parentId);
			}
		}
		
		function removeGoodsType(){
			var goodsTypeId = $("#delete_goodsTypeId").html();
			location.href = "<s:url action='goodsType_delete' namespace='/goodsType' />?parentId="+goodsTypeId;
		}
	</script>
</head>

<body>
	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="" namespace="/" />'>返回上一级</a>
	</button>
	<h1>商品类别管理</h1>
	<div class="col-sm-9 col-sm-offset-3">
	<table class="table table-striped table-hover table-condensed">
		<thead>
			<tr>
				<!-- <th>序号</th> -->
				<th>父商品类别名称</th>
				<th>子商品类别名称</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="goodsTypeList" status="status" var="parent" id="parent">
				<tr>
					<%-- <td><s:property value="#status.index+1" /></td> --%>
					<td><s:property value="goodsTypeName" /></td>
					<td></td>
					<td>
						<button class="btn btn-warning btn-sm" data-toggle="modal"
							data-target="#updateModal" onclick="getUpdateGoodsType('<s:property value="id" />','<s:property value="goodsTypeName" />','');">修改</button>
						<button class="btn btn-danger btn-sm" data-toggle="modal"
							data-target="#deleteModal" onclick="getDeleteGoodsType('<s:property value="id" />','<s:property value="goodsTypeName"/>','')">删除</button>
					</td>
				</tr>
				<s:iterator value="#parent.subGoodsType" var="sub" id="sub">
					<s:if test="#sub.active==1">
						<tr>
	<%-- 						<td><s:property value="#status.index+1+#idx.index" /></td> --%>
							<td></td>
							<td><s:property value="#sub.goodsTypeName" /></td>
							<td>
								<button class="btn btn-warning btn-sm" data-toggle="modal"
									data-target="#updateModal" onclick="getUpdateGoodsType('<s:property value="id" />','<s:property value="goodsTypeName" />','<s:property value="#parent.id" />');">修改</button>
								<button class="btn btn-danger btn-sm" data-toggle="modal"
									data-target="#deleteModal" onclick="getDeleteGoodsType('<s:property value="id" />','<s:property value="goodsTypeName"/>','<s:property value="#parent.id" />')">删除</button>
							</td>
						</tr>
					</s:if>
				</s:iterator>
			</s:iterator>
		</tbody>
	</table>
	</div>
	
	<!-- 弹出修改窗口 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改商品类别信息</h4>
				</div>
				<div class="modal-body">
					<s:form action="goodsType_update.do" namespace="/goodsType" method="post" id="updateForm">
						<div class="form-group">
							<label for="update_goodsTypeId2" class="control-label">商品类别id：</label> 
							<span id="update_goodsTypeId1"></span>
							<input name="id" id="update_goodsTypeId2" name="id" type="hidden" />
						</div>
						<div class="form-group">
							<label for="update_goodsTypeName" class="control-label">商品类别名称：</label> 
							<input name="goodsTypeName" id="update_goodsTypeName" type="text" />
						</div>
						<div class="form-group">
							<label for="parentId" class="control-label">父类别：</label>
								<select class="form-control" name="parentId" id="parentId" onclick="getParentGoodsType();">
								  <option value="">===请选择===</option>		  
								</select>
						</div>
						<s:actionerror />
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" onclick="return validate()">修改</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
				</s:form>
			</div>
		</div>
	</div>
	
	
	<!-- 弹出删除窗口 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">删除商品类别信息</h4>
				</div>
				<div class="modal-body">
					您确定删除id为
					<span id="delete_goodsTypeId" class="delete"></span>
					,父类别为：<span id="delete_goodsTypeParent" class="delete">无</span>
					<span>的商品类别：</span>
					<span id="delete_goodsTypeName" class="delete"></span>
					吗？
				</div>
				<div class="modal-footer">
					<button type=button class="btn btn-primary" onclick="removeGoodsType()">删除</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
