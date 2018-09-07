<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>欢迎登陆</title>
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src='<c:url value="jquery-easyui-1.3.3/jquery.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="images/jquery-3.2.1.min.js"></c:url>'></script>
<script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	function resetValue(){
		document.getElementById("userName").value="";
		document.getElementById("password").value="";
		document.getElementById("verifyCode").value="";
	}
	function _change(){
  		var ele=document.getElementById("vCode");
  		ele.src="<c:url value='/VerifyCodeServlet'/>?xxx=" +new Date().getTime();
  	}
  	function login1(){
  			var userName=$("#userName").val();
  			var password=$("#password").val();
  			var verifyCode=$("#verifyCode").val();
  			if($("#userName").val()==""||$("#userName").val().length==0){
  				alert("请输入用户名！");
  				$("#userName").focus();
  				return false;
  			}
  			if($("#password").val()==""||$("#password").val().length==0){
  				alert("请输入密码！");
  				$("#password").focus();
  				return false;
  			}
  			if($("#verifyCode").val()==""||$("#verifyCode").val().length==0){
  				alert("请输入验证码！");
  				$("#verifyCode").focus();
  				return false;
  			}
  			var param="<c:url value='/UserServlet?method=login&userName="+userName+"&password="+password+"&verifyCode="+verifyCode+"'/>";
  			$.ajax({
  				url:param,
  				type:"post",
  				dataType:"text",
  				contentTpye:"application/x-www-form-urlencoded; charset=UTF-8",
  				success:function(data){
  					if(data == "1"){
  					//window.setTimeout("window.location='main.jsp'",500); 
                		//window.location.href = "main.jsp";//跳转到主页
                		loadingWindow();
                		disLoadWindow();
            		}else if(data=="-1"){
                		alert("您输入的用户名或密码有误！");
                		var ele=document.getElementById("vCode");
  						ele.src="<c:url value='/VerifyCodeServlet'/>?xxx=" +new Date().getTime();
                		$("#userName").focus();
                		return false;
            		}else {
            			alert("您输入的验证码有误！");
                		var ele=document.getElementById("vCode");
  						ele.src="<c:url value='/VerifyCodeServlet'/>?xxx=" +new Date().getTime();
                		$("#verifyCode").focus();
                		return false;
            		}
  				}
  			});
  		}
  	$(document).ready(function(){
  		$("#password").focus(function(){
  			$("#p_span").hide();
  		});
  		$("#userName").focus(function(){
  			$("#u_span").hide();
  		});
  		$("#verifyCode").focus(function(){
  			$("#v_span").hide();
  		});
  		function _checkpassw43(){
  			if($("#password").val()==""||$("#password").val().length==0){
  				document.getElementById("p_span").innerHTML = "请输入用户名！";
  				$("#p_span").show();
  			}
  			}
  			
  		/* $("#password").blur(function(){
  			if($("#password").val()==""||$("#password").val().length==0){
  				//$("#p_span").innerHTML="请输入用户名！";
  				document.getElementById("p_span").innerHTML = "请输入用户名！";
  				$("#p_span").show();
  				}
  		}); */
  		
  		
  		
  	});
  	//弹出加载层
	var loadingWindow=(function (){
		return function(){
		$("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", 
		height: $(window).height() }).appendTo("body");
   	 	$("<div class=\"datagrid-mask-msg\"></div>").html("登陆中，请稍候。。。").appendTo("body").css({ display: "block",
   	 	 left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 ,width:200,height:40});
		}
	})();
    

 
	//取消加载层  
	var disLoadWindow=(function disLoadWindow() {
		return function(){
			setTimeout(function (){
			$(".datagrid-mask").remove();
		    $(".datagrid-mask-msg").remove();
		    window.location.href = "main.jsp";
			},1000);
	    
		}
	})();
  	
</script>
<style type="text/css">
	body {
            font-family: 'microsoft yahei',Arial,sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('<c:url value="/images/59e579066a3f6.png"></c:url>');
        }
	#password{
		margin-top: 20px;
		border-radius:4px;
		height: 25px;
	}
	#loginDiv{
		background-color:#efefef;
		margin:0,auto;
		width:500px;
		height:350px;
		border:0px red solid;
		position:absolute;
		top:20%;
		left:32%;
		border-radius:8px;
		box-shadow:4px 4px 10px #f00;
		opacity:1;
	}
	#submit,#reset,#codeDiv{
		margin-top: 20px;
	}
	#userName{
		margin-top: 30px;
		border-radius:4px;
		height: 25px;
	}
	#submit{
		margin-right: 20px;
		margin-left: 50px;
		border-radius:4px;
		font-size:16px;
	}
	#reset{
		border-radius:4px;
		font-size:16px;
		margin-left: 40px;
	}
	#vCode{
		width:50px;
		height: 30px;
	}
	#content{
		position: absolute;
		top:20%;
		left:22%;
	}
	#Logintitle{
       	font-family:"隶书"; font-size:50px; font-style:italic;
      	color:#00ff90;
      	margin-top:40px;
  	}
  	span{
  		font-size: 10px;
  	}
</style>
</head>
<body>
	<div id="Logintitle" class="container" style="text-align:center;">
        <p>肇庆学院学生信息管理系统</p>
    </div>
	<div id="loginDiv">
		<form  method="post">
		<h1 align="center" style="color: #337ab7;">登陆</h1>
		<div id="content">
		用户名：&nbsp<input type="text"  value="${user.userName }" onblur="checkUsername()" id="userName" name="userName">&nbsp<span style="color: red" id="u_span" >${errors.username}</span><br>
		密  &nbsp  码：    <input type="password"id="password" name="password" onblur="_checkpassw43();">&nbsp <span style="color: red" id="p_span" ></span><br>
		<div id="codeDiv">
		验证码：&nbsp<input type="text" name="verifyCode" id="verifyCode" style="border-radius:4px;height: 25px;" size="4" >
    		<img id="vCode"src="<c:url value='/VerifyCodeServlet'/>" border="1">
    		<a href="javascript:_change()">换一张</a>&nbsp <span style="color: red" id="v_span" >${errors.verifyCode }</span>
    		</div><br>
    		<div style="color: red"align="center">${error}</div>
		<input type="button" id="submit" value="登陆" onclick="login1()" value="登陆">
		<input type="button" id="reset" onclick="resetValue()" value="重置">
		</div>
		</form>
	</div>
</body>
</html>