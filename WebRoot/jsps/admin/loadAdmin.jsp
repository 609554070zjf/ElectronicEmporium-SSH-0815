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
		
		function reset(){
			$("#qryUserName").val("");
			$("#qryUserSex").val("");
		}
		
		function getDeleteAdmin(id,delete_userName){
			$("#delete_userId").html(id);
			$("#delete_userName").html(delete_userName);
		}
		
		function removeUser(){
			var userId = $("#delete_userId").html();
			location.href = "<s:url action="admin_delete" namespace="/admin" />?userId="+userId;
		}
		
		function updateAdmin(id){
	       location.href="<s:url action="admin_toUpdate" namespace="/admin"/>?userId="+id;
	   }
	   
	   function infoAdmin(id){
	       location.href="<s:url action="admin_infoAdmin" namespace="/admin"/>?userId="+id;
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
	<h1>管理员信息管理</h1>
	<s:form action="admin_loadAllAdmin.do" namespace="/admin" method="post"
		id="form" class="form-inline col-sm-offset-5">
		<div class="form-group">
			<label for="qryGoodsName">用户名：</label>
			<s:textfield name="helper.qryUserName" id="qryUserName" class="form-control" placeholder="用户名" size="20"></s:textfield>
		</div>
		<div class="form-group">
			<label for="minPrice">性别：</label>
			<s:select list="#{\"\":'请选择',\"0\":'女',\"1\":'男'}" name="helper.qryUserSex" id="qryUserSex" class="form-control"></s:select>
		</div>
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
				<th>用户编号</th>
				<th>用户名</th>
				<th>性别</th>
				<th>身份</th>
				<th>真实姓名</th>
				<th>出生日期</th>
				<th>邮箱</th>
				<th>电话号码</th>
				<!-- <th>地址</th> -->
				<th>邮编</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="pb.datas" status="status" var="admin" id="admin">
				<tr>
					<td><s:property value="#status.index+1" /></td>
					<td><s:property value="userId"/></td>
					<td><s:property value="userName" /></td>
					<td>
						<s:if test="sex==1">男</s:if>
						<s:else>女</s:else>
					</td>
					<td>
						<s:if test="identify==1">普通管理员</s:if>
						<s:else>超级管理员</s:else>
					</td>
					<td><s:property value="realName" /></td>
					<td><s:date name="birthday" format="yyyy-MM-dd"/></td>
					<td><s:property value="email" /></td>
					<td><s:property value="phone" /></td>
					<%-- <td><s:property value="address" /></td> --%>
					<td><s:property value="postCode" /></td>
					<td>
						<button class="btn btn-primary btn-sm" data-toggle="modal"
							data-target="#updateModal" onclick="infoAdmin('<s:property value="userId" />');">查看详情</button>
						<button class="btn btn-warning btn-sm" data-toggle="modal"
							data-target="#updateModal" onclick="updateAdmin('<s:property value="userId" />');">修改</button>
						<button class="btn btn-danger btn-sm" data-toggle="modal"
							data-target="#deleteModal" onclick="getDeleteAdmin('<s:property value="userId" />','<s:property value="userName"/>')">删除</button>
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
         <h4>没有符合条件的管理员信息被找到！</h4> 
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
					<h4 class="modal-title" id="myModalLabel">删除管理员信息</h4>
				</div>
				<div class="modal-body">
					您确定删除id为
					<span id="delete_userId" class="delete"></span>
					<span>的管理员：</span>
					<span id="delete_userName" class="delete"></span>
					吗？
				</div>
				<div class="modal-footer">
					<button type=button class="btn btn-primary" onclick="removeUser()">删除</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
