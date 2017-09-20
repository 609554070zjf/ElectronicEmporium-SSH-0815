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
		.container-fluid{
			top: 30px;
			position: absolute;
			font-family: "microsoft yahei";
		}
		#goodsImg{
			width: 410px;
			height: 410px;
			border:1px solid #ccc;
			position: absolute;
			left: 20px;
		}
		#goodsName{
			font: 700 20px Arial,"microsoft yahei";
		    color: #666;
		    padding-top: 10px;
		    line-height: 28px;
		    margin: 10px;
		    height: 56px;
		}
		#goodsInfo{
			/* border:1px solid red; */
			position: absolute;
			left: 450px;
			width: 720px;
		}
		.goodsInfoItem{
			margin: 20px;
			font-size: 20px;
		}
		
		.buyBtn{
			margin:20px;
		}
		.btn{
			margin-right: 20px;
		}
	</style>
	<script type="text/javascript">
	   
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
	<button type="button" class="btn btn-link" id="return">
		<a href='<s:url action="goods_loadAllFront" namespace="/goods" />'>返回上一级</a>
	</button>
	<div class="container-fluid">
        <div id="goodsImg">
            <%-- <img alt="" src="goods/<s:url value="goods_loadPicById.do?id=" namespace='/goods'/><s:property value="id"/>" width="400px" height="400px"> --%>
            <img alt="" src="${pageContext.request.contextPath}/images/<s:property value="id"/>.jpg" width="400px" height="400px">
        </div>
        <div id="goodsInfo">
            <div id="goodsName">
                <s:property value="goods.goodsName"/>&nbsp;&nbsp;<s:property value="goods.desc"/>
            </div>
            <div class="goodsInfoItem">
            	促销价：&nbsp;<font size="5px" color="red">￥<s:property value="goods.goodsPrice"/> 元</font><br>
            	原　价：&nbsp;<font size="2px" style="text-decoration: line-through;">￥<s:property value="goods.goodsPrice+268"/> 元</font><br>
            </div>
            <div class="goodsInfoItem">
            	商品所属大类：<s:property value="goods.parentType.goodsTypeName"/><br /><br />
            	商品所属小类：<s:property value="goods.subType.goodsTypeName"/>
            </div>
			<div class="goodsInfoItem">
				商品库存:<s:property value="goods.leftCnt"/>&nbsp;件
			</div>            
            <div class="buyBtn">
            	<button class="btn btn-warning">加入购物车</button>
				<button class="btn btn-danger">购买</button>
            </div>
        </div>
    </div>
</body>
</html>
