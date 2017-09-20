<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/jsps/common-tags.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN>
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<title>My JSP 'index.jsp' starting page</title>
	
	
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
		
		#pageInfo{
		  text-align:right;
		  padding:10px;
		  font-family:verdana;
		  margin-top:3px;
		}
		
		.linkspan{
		   color:blue;
		   text-decoration:underline;
		   cursor:pointer; 
		}
		
		#return {
			float: left;
		}
		
		/* #form {
			margin: 30px auto 20px auto;
			width: 1075px;
		} */
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
		
		function reset(){
			$("#qryGoodsName").val("");
			$("#minPrice").val("0.0");
			$("#maxPrice").val("0.0");
			$("#hidden_qryParentId").val("");
			$("#hidden_qrySubId").val("");
		}
		
		function getSubGoodsTypeByParent(){
			var parentId = $("#parentId").val();
			if(parentId) $("#hidden_qryParentId").val(parentId);
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
		
		function subIdChange(){
			var subId = $("#subId").val();
			if(subId) $("#hidden_qrySubId").val(subId);
		}
		
		/**
		 * 新增/修改商品类别提交验证
		 */
		function validate(){
		};
		
		
		
		function getDeleteGoods(id,goodsName){
			$("#delete_goodsId").html(id);
			$("#delete_goodsName").html(goodsName);
		}
		
		function removeGoods(){
			var goodsId = $("#delete_goodsId").html();
			location.href = "<s:url action='goods_delete' namespace='/goods' />?id="+goodsId;
		}
		
		function updateGoods(id){
	       location.href="<s:url action="goods_toUpdate" namespace="/goods"/>?id="+id;
	   }
	   
       function doQuery(pageno)
        {
        	console.log("doQuery");
           if(pageno<1 || pageno><s:property value="pb.totalPage"/>)
           {
              alert("页号超出范围，有效范围：[1-<s:property value="pb.totalPage"/>]!");
              $('#pageCode').select();
              return;
           }
           
            /* var f=document.forms[0]; */
            var f = $("#form")[0];
            console.log(f);
            f.action=f.action+"?pb.pageCode="+pageno;
            f.submit();
        }
	</script>
</head>

<body>
	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="" namespace="/" />'>返回上一级</a>
	</button>
	<h1>商品类别管理</h1>
	<s:form action="goods_loadAll.do" namespace="/goods" method="post"
		id="form" class="form-inline col-sm-offset-2">
		<div class="form-group">
			<label for="qryGoodsName">商品名称：</label>
			<s:textfield name="helper.qryGoodsName" id="qryGoodsName" class="form-control" placeholder="商品名称" size="20"></s:textfield>
		</div>
		<div class="form-group" width="70px">
			<label for="minPrice">价格范围：</label>
			<s:textfield name="helper.minPrice" id="minPrice" class="form-control" size="4"></s:textfield>
			<s:textfield name="helper.maxPrice" id="maxPrice" class="form-control" size="4"></s:textfield>
		</div>
		<div class="form-group">
			<label for="parentId" class="control-label">商品大类别：</label>
				<select class="form-control"  id="parentId" onclick="getParentGoodsType();" onchange="getSubGoodsTypeByParent();">
				  <option value="">===请选择===</option>		  
				</select>
		</div>
		<div class="form-group">
			<label for="subId" class="control-label">商品小类别：</label>
				<select class="form-control" id="subId"  onchange="subIdChange();">
				  <option value="">===请选择===</option>		  
				</select>
		</div>
		<%-- <s:textfield name="helper.qryParentId" id="hidden_qryParentId"></s:textfield>
		<s:textfield name="helper.qrySubId" id="hidden_qrySubId"></s:textfield> --%>
		<s:hidden name="helper.qryParentId" id="hidden_qryParentId"></s:hidden>
		<s:hidden name="helper.qrySubId" id="hidden_qrySubId"></s:hidden>
		<div class="form-group">
			<button type="submit" class="btn btn-default">查询</button>
			<a class="btn btn-danger" onclick="reset()">重置</a>
		</div>
	</s:form>
	<s:if test="pb.datas.size()>0">
	<div class="col-sm-10 col-sm-offset-2">
	<table class="table table-striped table-hover table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>商品图片</th>
				<th>商品名称</th>
				<th>商品单价</th>
				<th>商品大类</th>
				<th>商品小类</th>
				<th>是否有货</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="pb.datas" status="status" var="goods" id="goods">
				<tr>
					<td><s:property value="#status.index+1" /></td>
					<td>
						<%-- <img alt="" src="goods/<s:url value="goods_loadPicById.do?id=" namespace='/goods'/><s:property value="id"/>" width="80px" height="80px"> --%>
						<img alt="" src="${pageContext.request.contextPath}/images/<s:property value="id"/>.jpg" width="80px" height="80px" onclick="getInfoGoods('<s:property value="id"/>');">
					</td> 
					<td><s:property value="goodsName" /></td>
					<td><s:property value="goodsPrice" /></td>
					<td><s:property value="parentType.goodsTypeName" /></td>
					<td><s:property value="subType.goodsTypeName" /></td>
					<td>
						<s:if test="enough==1">有货</s:if>
						<s:else>无货</s:else>
					</td>
					<td>
						<button class="btn btn-warning btn-sm" data-toggle="modal"
							data-target="#updateModal" onclick="updateGoods('<s:property value="id" />');">修改</button>
						<button class="btn btn-danger btn-sm" data-toggle="modal"
							data-target="#deleteModal" onclick="getDeleteGoods('<s:property value="id" />','<s:property value="goodsName"/>')">删除</button>
					</td>
				</tr>
			</s:iterator>
		</tbody>
	</table>
	</div>
	<div id="pageinfo">
	            共<s:property value="pb.totalRecord"/>条, 当前显示<s:property value="pb.startIndex+1"/>-<s:property value="pb.endIndex"/>条,
	             第<s:property value="pb.pageCode"/>/<s:property value="pb.totalPage"/>页
	           |
	           <s:if test="pb.pageCode>1">
	             <span class="linkspan" onclick="doQuery(1)">首页</span>&nbsp;
	           </s:if>
	           <s:if test="pb.prePage">
	             <span class="linkspan" onclick="doQuery(<s:property value="pb.pageCode-1"/>)">上一页</span>&nbsp;
	           </s:if>
	           <s:if test="pb.nextPage">
	             <span class="linkspan" onclick="doQuery(<s:property value="pb.pageCode+1"/>)">下一页</span>&nbsp;
	           </s:if>
	           <s:if test="pb.pageCode!=page.totalPage">
	             <span class="linkspan" onclick="doQuery(<s:property value="pb.totalPage"/>)">末页</span>&nbsp;
	           </s:if>
	           |
	            到<input type="text" id="pageCode" size=4 style="text-align:right;" onkeypress="onlynumber();"/> 页
	           <button onclick="doQuery($('#pageCode').val());"> 跳 转 </button>		           		           	           	              
	    </div>	    
    </s:if>
    <s:else>
        <div style="margin:20px; text-align:center">
         <h4>没有符合条件的商品信息被找到！</h4> 
        </div>
    </s:else>
	
	<!-- 弹出删除窗口 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">删除商品信息</h4>
				</div>
				<div class="modal-body">
					您确定删除id为
					<span id="delete_goodsId" class="delete"></span>
					<span>的商品：</span>
					<span id="delete_goodsName" class="delete"></span>
					吗？
				</div>
				<div class="modal-footer">
					<button type=button class="btn btn-primary" onclick="removeGoods()">删除</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
