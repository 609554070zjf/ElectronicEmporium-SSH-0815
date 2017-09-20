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
	
		.buyCar{
			width: 200px;
			height: 450px;
			position: absolute;
			left: 0px;
			top: 90px;
			border:3px solid #ccc;
			border-radius:10px;
			overflow: auto;
			margin-left: 10px;
		}
		.goodsList{
			margin-left: 220px;
		}
		.goodsItem{
			width: 200px;
			height: 250px;
			float: left;
			border:1px solid #ccc;
			margin: 10px;
			padding: 10px;
		}
		#pageinfo{
			width: 100%;
			text-align: right;
			padding-right: 30px;
			float:none;
			bottom: 20px;
			position: absolute;
		}
		.linkspan{
		   color:blue;
		   text-decoration:underline;
		   cursor:pointer; 
		}
		.goodsItem>img:HOVER{
			cursor: pointer;
		}
		.buyCarItem{
			padding: 10px 20px;
			margin-top: 10px;
		}
		.buyCarTitle{
			text-align:center;
			font-size:20px;
			color:red;
		}
		.buyCarTitle:HOVER {
			cursor: pointer;
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
        
        function getInfoGoods(id){
        	location.href = "<s:url action='goods_infoGoodsFront' namespace='/goods' />?id="+id;
        }
        
        function addInBuyCar(goodsId,goodsCnt){
        	location.href = "<s:url action='goods_addInBuyCarToLoadAll' namespace='/goods' />?goodsId="+goodsId + "&goodsCnt=" + goodsCnt;
        }
        
        function removeFromBuyCar(goodsId){
        	location.href = "<s:url action='goods_removeFromBuyCarToLoadAll' namespace='/goods' />?goodsId="+goodsId;
        }
        
        function toBuyCarMgr(){
        	location.href = "<s:url action='goods_buyCarMgr' namespace='/goods' />";
        }
	</script>
</head>

<body>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="user_toUserMain" namespace="/user" />'>返回上一级</a>
	</button>
	<s:form action="goods_loadAllFront.do" namespace="/goods" method="post"
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
		<s:hidden name="helper.qryParentId" id="hidden_qryParentId"></s:hidden>
		<s:hidden name="helper.qrySubId" id="hidden_qrySubId"></s:hidden>
		<div class="form-group">
			<button type="submit" class="btn btn-default">查询</button>
			<a class="btn btn-danger" onclick="reset()">重置</a>
		</div>
	</s:form>
	<div class="buyCar">
	<div class="buyCarTitle" onclick="toBuyCarMgr()"><b>购物车</b></div>
		<s:iterator value="#session.buycar">
			<div class="buyCarItem">
				<%-- <img style="text-algin:center" alt="" src="goods/<s:url value="goods_loadPicById.do?id=" namespace='/goods'/><s:property value="goodsId"/>" width="100px" height="100px" onclick="getInfoGoods('<s:property value="goodsId"/>');"> --%>
				<img style="text-algin:center" alt="" src="${pageContext.request.contextPath}/images/<s:property value="goodsId"/>.jpg" width="100px" height="100px" onclick="getInfoGoods('<s:property value="goodsId"/>');">
				<div>
					数　　量：<s:property value="goodsCnt"/> 件<br />
					商品单价：<s:property value="goodsPrice"/> 元<br />
					小　　计：<s:property value="money"/> 元
				</div>
			</div>
		</s:iterator>
		<s:if test="#session.buycar != null && #session.buycar.size()>0">
			<div style="margin-left:50px;">
				<button class="btn btn-primary" onclick="toBuyCarMgr()">查看详情</button>
			</div>
		</s:if>
	</div>
	<s:if test="pb.datas.size()>0">
		<div class="goodsList">
			<s:iterator value="pb.datas" var="goods">
				<div class="goodsItem" >
					<img alt="" src="${pageContext.request.contextPath}/images/<s:property value="id"/>.jpg" width="160px" height="160px" onclick="getInfoGoods('<s:property value="id"/>');">
					<%-- <img alt="" src="goods/<s:url value="goods_loadPicById.do?id=" namespace='/goods'/><s:property value="id"/>" width="160px" height="160px" onclick="getInfoGoods('<s:property value="id"/>');"> --%>
					<font size="5px" color="red"><strong>￥<s:property value="goodsPrice"/></strong></font><br>
					<s:property value="goodsName"/><br />
					<button class="btn btn-warning btn-xs" onclick="addInBuyCar('<s:property value="id"/>',1)">加入购物车</button>
					<button class="btn btn-danger btn-xs">购买</button>
				</div>
			</s:iterator>
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
</body>
</html>
