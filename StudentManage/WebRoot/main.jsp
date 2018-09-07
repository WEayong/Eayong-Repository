<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>学生信息管理系统主界面</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/icon.css">
	<script type="text/javascript" src='<c:url value="jquery-easyui-1.5.5/jquery.min.js"></c:url>'></script>
	<%-- <script type="text/javascript" src='<c:url value="images/jquery-3.2.1.min.js"></c:url>'></script> --%>
	<script type="text/javascript" src="jquery-easyui-1.5.5/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5/locale/easyui-lang-zh_CN.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <title>学生信息管理系统主界面</title>
    <%
    	if(session.getAttribute("sessionUser")==null){
    		response.sendRedirect("index.jsp");
    		return;
    	}
     %>
	<script type="text/javascript">
		$(function(){
			//初始化菜单树数据
			var treeData=[{
				text:"模块",
				children:[{
					text:"班级信息管理",
					attributes:{
						url:"gradeInfoMan.jsp"
					}
				},{
					text:"学生信息管理",
					attributes:{
						url:"studentInfoMan.jsp"
					}
				}]
			}];
			//实例化树
			$("#tree").tree({
				data:treeData,
				lines:true,
				onClick:function(node){
					if(node.attributes){
						openTab(node.text,node.attributes.url);
					}
				}
			});
			//新增tab页
			function openTab(text,url){
				if($("#tabs").tabs('exists',text)){
					$("#tabs").tabs('select',text);
				}else{
					//用iframe嵌套
					var content ="<iframe src="+url+" frameborder='0' scrolling='auto' style='height:100%;width:100%'></iframe>";
					$("#tabs").tabs('add',{
					title:text,
					closable:true,
					content:content
				});
				}
			}
		});
		
	</script>
  </head>
  
  <body class="easyui-layout">
  
  	<div region="north" style="height:60px;background-color: #e0edff">
		<img  src="images/main.jpg" style="height: 50px">
		<div style="padding-top: 40px;float: right;padding-right: 70px">当前用户：&nbsp<font color="red">${sessionUser.userName }</font></div>
	</div>   
    <div region="center" >
		<div class="easyui-tabs" fit="true" border="false" id="tabs" >
			<div title="首页">
				<div align="center" style="padding-top: 50px;">
					<h1>欢迎使用肇庆学院学生管理系统</h1>
                    <h2>用户须知</h2>
                    <h3>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
                    </h3>
				</div>
			</div>
		</div>
	</div>  
	<div region="west" style="width:140px" title="导航菜单" split="true">
		<ul id="tree"></ul>
	</div> 
	<div region="south" style="height:23px;line-height: 20px" align="center">@2018 by 肇庆学院</div> 
  </body>
</html>
