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
		.errorMessage{
			list-style-type: none;
			color:red;
			font-size:25px;
			margin:10px auto;
			font-weight:bold;
			text-align: center;
			padding: 0px;
		}
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
		.payTypeImg{
			margin: 20px;
		}
		.payTypeImg-active{
			border:2px solid red;
		}
		
		.payType{
			font-size:20px;
			margin: 10px;
			color:#e54346;
			font-weight: bold;
		}
	</style>
	<script type="text/javascript">
      
        function toOrderPage(){
        	location.href = "<s:url action='goods_toOrder' namespace='/goods' />";
        }
        
        function cancel(){
        	location.href = "<s:url action='goods_loadAllFront' namespace='/goods' />";
        }
        
	</script>
</head>

<body>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action='order_loadOrderByUserId' namespace='order' />'>返回个人订单中心</a>
	</button>
	<div class="container">
			<table class="table table-striped table-hover table-condensed">
				<thead>
					<tr>
						<th>序号</th>
						<th>商品图片</th>
						<th>商品名称&简介</th>
						<th>商品单价</th>
						<th>商品数量</th>
						<th>商品小计</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="order.buycarList" status="status">
						<tr>
							<td><s:property value="#status.index+1" /></td>
							<td>
								<img alt="" src="${pageContext.request.contextPath}/images/<s:property value="goodsId"/>.jpg" width="80px" height="80px" onclick="getInfoGoods('<s:property value="goodsId"/>');">
							</td>
							<td>
								<s:property value="goodsName"/><br />
								<s:property value="goodsDesc"/>
							</td>
							<td class="goodsPrice"><span class="goodsPrice"><s:property value="goodsPrice"/></span>元</td>
							<td>
								<span class="goodsCnt"><s:property value="goodsCnt"/></span>
							</td>
							<td>
								<span class="money"><s:property value="money"/></span>元
							</td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
			<div class="totalMoney">
				<div class="totalMoneyValue">
					共<s:property value="order.goodsTypeCnt"/>种商品&nbsp;&nbsp;&nbsp;
					<span id="totalCnt"><s:property value="order.goodsCnt"/></span>件商品&nbsp;&nbsp;&nbsp;
					总计： ￥<span id="totalMoney"><s:property value="order.totalMoney"/></span> 元
				</div>
			</div>
			<div>
				<div class="payType">
					<span>付款方式:</span>
					<span id="payTypeValue">
						<s:if test="order.payType==0">
							支付宝支付
						</s:if>
						<s:elseif test="order.payType==1">
							微信支付
						</s:elseif>
						<s:else>
							银联在线支付
						</s:else>
					</span>
				</div>
				<div style="display: inline-block;" class="col-sm-4">
					<s:if test="order.payType==0">
						<img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/zfb.jpg" alt="支付宝支付" width="200px" height="60px"/>
					</s:if>
					<s:elseif test="order.payType==1">
						<img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/wx.jpg" alt="微信支付" width="200px" height="60px"/>
					</s:elseif>
					<s:else>
						<img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/yl.jpg" alt="银联在线支付" width="200px" height="60px"/>
					</s:else>
				</div>
				<div class="col-sm-8">
					<s:form action="#" namespace="/order" method="post" id="form" class="form-horizontal">
						<s:hidden name="payType" id="hidden_payType"></s:hidden>
						<s:hidden name="goodsTypeCnt" id="hidden_goodsTypeCnt"></s:hidden>
						<s:hidden name="goodsCnt" id="hidden_goodsCnt"></s:hidden>
						<s:hidden name="totalMoney" id="hidden_totalMoney"></s:hidden>
						<div class="form-group">
							<label for="receiverName" class="col-sm-3 col-sm-offset-3 control-label">收件人姓名：</label>
							<div class="col-sm-6">
								<s:property value="order.receiverName"/>
							</div>
						</div>
						<div class="form-group">
							<label for="realName" class="col-sm-3 col-sm-offset-3 control-label">收货方式：</label>
							<div class="col-sm-6">
								<s:if test="order.postType==1">自提</s:if>
								<s:else>送货上门</s:else>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-sm-3 col-sm-offset-3 control-label">电子邮箱：</label>
							<div class="col-sm-6">
								<s:property value="order.email"/>
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-sm-3 col-sm-offset-3 control-label">电话号码：</label>
							<div class="col-sm-6">
								<s:property value="order.phone"/>
							</div>
						</div>
						<div class="form-group">
							<label for="postCode" class="col-sm-3 col-sm-offset-3 control-label">邮政编码：</label>
							<div class="col-sm-6">
								<s:property value="order.postCode"/>
							</div>
						</div>
						<div class="form-group">
							<label for="postCode" class="col-sm-3 col-sm-offset-3 control-label">地址：</label>
							<div class="col-sm-6">
								<s:property value="order.address"/>
							</div>
						</div>
					</s:form>
				</div>
			</div>
    </div>
</body>
</html>
