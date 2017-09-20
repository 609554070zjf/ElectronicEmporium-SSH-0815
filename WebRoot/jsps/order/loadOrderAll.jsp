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
		function toOrderByOrderId(id){
			location.href = "<s:url action='order_getOrderByOrderIdAdmin' namespace='/order' />?orderId="+id;
		}
	
		function reset(){
			$("#qryOrderDate").val("");
			$("#orderState").val("");
		}
		
		function validate(){
			var orderDate = $("#orderDate").val();
			console.log(orderDate);
			if(orderDate!=""){
				var datePattern = /^(\d{4})\-(\d{1,2})\-(\d{1,2})$/;
				var flag1 = datePattern.test(orderDate);
				var date = new Date(orderDate);
				console.log("flag1:"+flag1);
				console.log("2:"+ date == "Invalid Date");
				if(!flag1 || date == "Invalid Date"){
					alert("输入的查询条件：订单日期格式不正确，正确格式为：yyyy-MM-dd");
					return false;
				}
			}
			$("#form").submit();
		}	
		
	</script>
</head>

<body>
	<s:include value="/jsps/menu/leftMenu.jsp"></s:include>
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="" namespace="/" />'>返回上一级</a>
	</button>
	<h1>订单管理</h1>
	<s:form action="order_loadAll.do" namespace="/order" method="post"
		id="form" class="form-inline col-sm-offset-2">
		<div class="form-group">
			<label for="qryGoodsName">下单日期：</label>
			<s:textfield name="helper.qryOrderDate" id="orderDate"  placeholder="下单日期" class="form-control">
					<s:param name="value">
			        	<s:date name="helper.qryOrderDate" format="yyyy-MM-dd"/>
			        </s:param>
			</s:textfield>
		</div>
		<div class="form-group">
			<label for="parentId" class="control-label">订单状态：</label>
				<s:select class="form-control"  id="orderState" name="helper.orderState" list="#{'':'===请选择===','0':'未完成','1':'已完成'}">
				</s:select>
		</div>
		<div class="form-group">
			<button type="button" class="btn btn-default" onclick="validate();">查询</button>
			<button type="button" class="btn btn-danger" onclick="reset()">重置</button>
		</div>
	</s:form>
	<s:if test="pb.datas.size()>0">
	<div class="col-sm-10 col-sm-offset-2">
	<table class="table table-striped table-hover table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>订单编号</th>
				<th>所属用户ID</th>
				<th>所属用户</th>
				<th>下单时间</th>
				<th>订单状况</th>
				<th>订单金额</th>
				<th>商品总数</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="pb.datas" status="status" var="goods" id="goods">
				<tr onclick="toOrderByOrderId('<s:property value="orderId" />')">
					<td><s:property value="#status.index+1" /></td>
					<td><s:property value="orderId" /></td>
					<td><s:property value="user.userId" /></td>
					<td><s:property value="user.userName" /></td>
					<td><s:date name="orderDate" format="yyyy-MM-dd"/></td>
					<td>
						<s:if test="orderState==1">已完成</s:if>
						<s:else>未完成</s:else>
					</td>
					<td><s:property value="totalMoney" /></td>
					<td><s:property value="goodsCnt"/></td>
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
         <h4>没有符合条件的订单信息被找到！</h4> 
        </div>
    </s:else>
</body>
</html>
