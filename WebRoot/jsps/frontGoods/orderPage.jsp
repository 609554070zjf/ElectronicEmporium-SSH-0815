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
	
		$(function(){
			setMoneyValue();
			setTotalCnt();
			var cnt = $("table>tbody").children().length;
			console.log("cnt="+cnt);
			$("#hidden_goodsTypeCnt").val(cnt);
			
			$(".payTypeImg").click(function(){
				$(".payTypeImg").each(function(){
					$(this).removeClass("payTypeImg-active");
				});
				$(this).addClass("payTypeImg-active");
				var idx = $(this).index(".payTypeImg");
				var payTypeValue = "未选择";
				if(idx == 0){
					payTypeValue = "支付宝支付";
				}
				else if(idx == 1){
					payTypeValue = "微信支付";
				}
				else if(idx == 2){
					payTypeValue = "银联在线支付";
				}
				$("#payTypeValue").html(payTypeValue);
				$("#hidden_payType").val(idx);
							
			});
		});
		
		function setMoneyValue(){
			var moneyValue = 0.0;
			var money = $(".money");
			money.each(function(){
				moneyValue += parseFloat($(this).html());
			});
			$("#totalMoney").html(moneyValue);
			$("#hidden_totalMoney").val(moneyValue);
		}
		
		function setTotalCnt(){
			var totalCnt = 0;
			var goodsCnt = $(".goodsCnt");
			goodsCnt.each(function(){
				totalCnt += parseInt($(this).html());
			});
			$("#totalCnt").html(totalCnt);
			$("#hidden_goodsCnt").val(totalCnt);
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
        
        function calcMoney(elem){
        	var idx = $(elem).parent().parent().index();
        	var goodsCnt = $(elem).val();
        	if(goodsCnt < 1){
        		 $(elem).val(1);
        		 goodsCnt = $(elem).val();
        	}
        	var goodsPrice = $(elem).parent().siblings(".goodsPrice").children()[0].innerHTML;
        	var money = parseFloat(goodsCnt*goodsPrice);
        	$($(".money")[idx]).html(money);
        	setMoneyValue();
        }
        
        function toOrderPage(){
        	location.href = "<s:url action='goods_toOrder' namespace='/goods' />";
        }
        
        function cancel(){
        	location.href = "<s:url action='goods_loadAllFront' namespace='/goods' />";
        }
        
        /**
		 * 用户注册/修改提交验证
		 */
		function validate(){
			if(!$("#hidden_payType").val()){
				$(".errorMessage").html("请选择支付方式");
				return false;
			}
		
			var receiverName = $("#receiverName").val();
			var phone = $("#phone").val();
			var postCode = $("#postCode").val();
			var email = $("#email").val();
			
			if(receiverName.length < 3 || receiverName.length > 15){
				$(".errorMessage").html("用户名有效长度为2-15");
				$($("#form>div")[0]).addClass("has-error has-feedback");
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
		<a href='<s:url action='goods_loadAllFront' namespace='/goods' />'>返回上一级</a>
	</button>
	<div class="container">
		<s:if test="#session.buycar.size>0">
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
								<span class="goodsCnt"><s:property value="goodsCnt"/></span>
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
					共<s:property value="#session.buycar.size()"/>种商品&nbsp;&nbsp;&nbsp;
					<span id="totalCnt"></span>件商品&nbsp;&nbsp;&nbsp;
					总计： ￥<span id="totalMoney"></span> 元
				</div>
			</div>
			<div>
				<div class="payType">
					<span>付款方式:</span><span id="payTypeValue">未选择</span>
				</div>
				<div style="display: inline-block;" class="col-sm-4">
					<ul style="list-style-type: none">
						<li><img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/zfb.jpg" alt="支付宝支付" width="200px" height="60px"/></li>
						<li><img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/wx.jpg" alt="微信支付" width="200px" height="60px"/></li>
						<li><img class="payTypeImg" src="${pageContext.request.contextPath}/images/payType/yl.jpg" alt="银联在线支付" width="200px" height="60px"/></li>
					</ul>
				</div>
				<div class="col-sm-8">
					<s:form action="order_createOrder.do" namespace="/order" method="post" id="form" class="form-horizontal">
						<s:hidden name="payType" id="hidden_payType"></s:hidden>
						<s:hidden name="goodsTypeCnt" id="hidden_goodsTypeCnt"></s:hidden>
						<s:hidden name="goodsCnt" id="hidden_goodsCnt"></s:hidden>
						<s:hidden name="totalMoney" id="hidden_totalMoney"></s:hidden>
						<div class="form-group">
							<label for="receiverName" class="col-sm-3 col-sm-offset-3 control-label">收件人姓名：</label>
							<div class="col-sm-6">
								<s:textfield name="receiverName" id="receiverName" class="form-control" placeholder="收件人姓名" required="required"></s:textfield>
							</div>
						</div>
						<div class="form-group">
							<label for="realName" class="col-sm-3 col-sm-offset-3 control-label">收货方式：</label>
							<div class="col-sm-6">
								<s:select list="#{'1':'自提','0':'送货上门'}" name="postType" value="0" class="form-control"></s:select>
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-sm-3 col-sm-offset-3 control-label">电子邮箱：</label>
							<div class="col-sm-6">
								<s:textfield name="email" id="email" class="form-control" placeholder="电子邮箱" required="required"></s:textfield>
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-sm-3 col-sm-offset-3 control-label">电话号码：</label>
							<div class="col-sm-6">
								<s:textfield name="phone" id="phone" class="form-control" placeholder="电话号码" required="required"></s:textfield>
							</div>
						</div>
						<div class="form-group">
							<label for="postCode" class="col-sm-3 col-sm-offset-3 control-label">邮政编码：</label>
							<div class="col-sm-6">
								<s:textfield name="postCode" id="postCode" class="form-control" placeholder="邮政编码" required="required"></s:textfield>
							</div>
						</div>
						<div class="form-group">
							<label for="postCode" class="col-sm-3 col-sm-offset-3 control-label">地址：</label>
							<div class="col-sm-6">
								<s:textarea id="address" name="address" class="form-control" required="required" rows="3"></s:textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-7">
							<button type="submit" class="btn btn-default" id="submit" onclick="return validate();">提交</button>
							<button class="btn btn-danger" onclick="cancel();">取消</button>
							</div>
						</div>
						<s:actionerror/>
						<div class="errorMessage">
	
						</div>
					</s:form>
				</div>
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
