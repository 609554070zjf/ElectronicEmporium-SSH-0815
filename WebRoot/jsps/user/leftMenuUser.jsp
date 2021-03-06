<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'leftMenu.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	    <style type="text/css">
	    body,html{
			margin:0px;
			height:100%;
		}
	    
	    table{
			z-index: 1;
		}

        .menuTitle{
            text-align: center;
            margin-bottom: 50px;
        }

        .leftMenu{
        	z-index:2;
        	color:white;
            width: 200px;
            height: 100%;
            /* border: 1px solid red; */
            background-color: #444;
            position: fixed;
        }

        .menuBar ul{
            list-style-type: none;
            padding: 0;
        }

        .menuBar{
            font-size: 15px;
            font-weight: bold;
        }
        
        .menuItem{
        	width: 198px;
        	border:1px solid #fff;
            height: 50px;
            line-height: 50px;
            padding-left:50px;
            margin-bottom: 20px;
        }
        
        .menuItem:hover{
            background-color: #666;
            cursor: pointer;
        }

        .menuSubGroup{
        	z-index:1000;
            position: relative;
            left: 146px;
            top: -50px;
            background-color: #444;
            display: none;
        }
        
        .menuItemSub{
            height: 40px;
            line-height: 40px;
            padding-left: 30px;
            border-bottom: 1px solid #fff;
        }

        .menuItemSub>a{
            text-decoration: none;
            color:white;
        }

        .menuItemSub:hover{
            background-color: #666;
            cursor: pointer;
        }
        
        .menuItem>a{
        	text-decoration: none;
        	color:white;
        	
        }
        
        h1{
        	margin-top: 0;
        }

    </style>
   	<script src="${pageContext.request.contextPath}/libs/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".menuItem").hover(
                function(){
                     $(".menuSubGroup").css("display","none");
                     $(this).children(".menuSubGroup").css("display","block");
                },
                function(){
                    $(this).children(".menuSubGroup").css("display","none");
                });

        })
    </script>

  </head>
  
  <body>
    <div class="leftMenu">
        <div class="menuTitle">
            <h3>易乐商城后台管理系统</h3>
        </div>
        <div class="menuBar">
            <ul>
                <li class="menuItem"><a href="<s:url action="user_infoUser" namespace="/user"></s:url>">个人资料</a>
                </li>
                <li class="menuItem"><a href="<s:url action="user_toUpdatePwd" namespace="/user"></s:url>">密码修改</a>
                </li>
                <li class="menuItem"><a href="<s:url action="order_loadOrderByUserId" namespace="/order"></s:url>">订单中心</a>
                </li>
                <li class="menuItem"><a href="<s:url action="goods_loadAllFront" namespace="/goods"></s:url>">返回商城</a>
                </li>
                <li class="menuItem"><a href="<s:url action="user_quitSys" namespace="/user"></s:url>">退出商城</a>
                </li>	
            </ul>
        </div>
    </div>    
  </body>
</html>
