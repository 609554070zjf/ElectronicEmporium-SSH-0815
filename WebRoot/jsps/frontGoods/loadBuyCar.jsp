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
			height: 570px;
			position: absolute;
			left: 0px;
			top: 90px;
			border:1px solid red;
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
			padding: 10px 30px;
			margin-top: 10px;
		}
		
		.totalMoney{
				text-align: right;
				margin-right: 50px;		
		}
		
		.btn-buy{
			width: 96px;
		    height: 52px;
		    /* line-height: 52px; */
		    /* text-align: center;
		     */
		    color: #fff;
		    font-size: 18px;
		    font-family: "Microsoft YaHei";
		    background: #e54346;
		    text-decoration: none;
		    margin-left: 100px;
		}
		.btn-primary{
		    height: 52px;
		    font-size: 18px;
		    font-family: "Microsoft YaHei";
		}
		.btn-buy:HOVER {
			color: #fff;
		}
		.totalMoneyValue{
			display: inline-block;
			font-size:25px;
			color: #e54346;
			font-weight: bold;
			margin-right: 10px;
		}
	</style>
	<script type="text/javascript">
	
		$(function(){
			setMoneyValue();
		});
		
		function setMoneyValue(){
			var moneyValue = 0.0;
			var money = $(".money");
			money.each(function(){
				console.log("moneyValue="+moneyValue);
				moneyValue += parseFloat($(this).html());
			});
			$("#totalMoney").html(moneyValue);
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
        
        function removeFromBuyCar(goodsId){
        	location.href = "<s:url action='goods_removeFromBuyCarToMgr' namespace='/goods' />?goodsId="+goodsId;
        }
        
        function clearBuyCar(){
        	location.href = "<s:url action='goods_clearBuyCar' namespace='/goods' />";
        }
        
        function calcMoney(elem){
        	var idx = $(elem).parent().parent().index();
        	var goodsCnt = $(elem).val();
        	if(goodsCnt < 1){
        		 $(elem).val(1);
        		 goodsCnt = $(elem).val();
        	}
        	var goodsPrice = $(elem).parent().siblings(".goodsPrice").children()[0].innerHTML;
        	console.log(goodsPrice);
        	console.log(goodsCnt);
        	var money = parseFloat(goodsCnt*goodsPrice);
        	$($(".money")[idx]).html(money);
        	setMoneyValue();
        }
        
        function toOrderPage(){
        	location.href = "<s:url action='goods_toOrder' namespace='/goods' />";
        }
        
        function clearBuyCar(){
        	location.href = "<s:url action='goods_clearBuyCar' namespace='/goods' />";
        }
        
	</script>
</head>

<body>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action='goods_loadAllFront' namespace='/goods' />'>返回上一级</a>
	</button>
	<div class="container">
		<s:if test="#session.buycar.size()>0">
			<table class="table table-striped table-hover table-condensed">
				<thead>
					<tr>
						<th>序号</th>
						<th>商品图片</th>
						<th>商品名称&简介</th>
						<th>商品单价</th>
						<th>商品数量</th>
						<th>商品小计</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#session.buycar" status="status">
						<tr>
							<td><s:property value="#status.index+1" /></td>
							<td>
								<img alt="" src="${pageContext.request.contextPath}/images/<s:property value="goodsId"/>.jpg" width="80px" height="80px" onclick="getInfoGoods('<s:property value="goodsId"/>');">
							</td>
							<%-- <td><img alt="" src="goods/<s:url value="goods_loadPicById.do?id=" namespace='/goods'/><s:property value="goodsId"/>" width="100px" height="100px" onclick="getInfoGoods('<s:property value="goodsId"/>');"></td> --%>					
							<td>
								<s:property value="goodsName"/><br />
								<s:property value="goodsDesc"/>
							</td>
							<td class="goodsPrice"><span class="goodsPrice"><s:property value="goodsPrice"/></span>元</td>
							<td>
								<s:textfield name="goodsCnt" type="number" style="width:50px;" onchange="calcMoney(this);"></s:textfield>
							</td>
							<td>
								<span class="money"><s:property value="money"/></span>元
							</td>
							<td>
								<button class="btn btn-danger" onclick="removeFromBuyCar('<s:property value="goodsId"/>');">删除</button>						
							</td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
			<div class="totalMoney">
				<div class="totalMoneyValue">
					总计： ￥<span id="totalMoney"></span> 元
				</div>
				<button class="btn btn-buy" onclick="toOrderPage();">去结算</button>
				<button class="btn btn-primary" onclick="clearBuyCar();">清空购物车</button>
			</div>
	    </s:if>
	    <s:else>
	        <div style="margin:20px; text-align:center">
	         <h4>没有符合条件的购物车信息被找到！</h4> 
	        </div>
	    </s:else>
    </div>
</body>
</html>
