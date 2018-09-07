<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" />
    <script src="dist/js/jquery-3.2.1.min.js"></script>
    <script src="dist/js/bootstrap.min.js"></script>
    <title>肇庆学院提案管理系统</title>
    <script type="text/javascript">
        /*
            用户注册ajax
        
        $(function () {
            $("#teachloginnum").blur(function () {
                if (document.getElementById("teachloginnum").value == "") {
                            document.getElementById("lblShow").innerHTML = "&nbsp用户名不能为空";
                                  return;
                               }
                var tn = $("#teachloginnum").val();
                $.ajax({
                    type: 'POST',
                    contentType: "application/json",
                    url: "Login.aspx?teachloginnum=" + tn,
                    success: function (msg) {
                        if(msg=="1")
                            document.getElementById("lblShow").innerHTML = "&nbsp×该用户不存在";
                        $("#lblShow").css("color", "red");
                    },
                    error: function (msg) {
                        //document.getElementById("lblShow").innerHTML = msg.responseText.toString();
                    }
                    })
                })
            })
            */
         
        //$(function () {
        //    $("#btn1").click(function () {
        //        var usertype = $("input[name='userType']:checked").val();
        //        if (checkname()) {
        //            var username = $("#teachloginnum").val();
        //            var pwd = $("#teachpwd").val();
        //            var xmlHttp;
        //            if(window.XMLHttpRequest) { // code for IE7+
        //                xmlHttp = new XMLHttpRequest();
        //            }
        //            else { // code for IE5/IE6
        //                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        //            }
             
        //            xmlHttp.onreadystatechange = function () {
        //                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        //                    //document.getElementById("myDiv").innerHTML=xmlHttp.responseText;
        //                    //document.getElementById("lblShow").innerHTML = xmlHttp.responseText.toString();
        //                    if (xmlHttp.responseText.toString() == "2") {
        //                        alert("用户名或密码错误，请重试！");
        //                    } else if (xmlHttp.responseText.toString() == "1") {
        //                        alert("登陆成功！");
        //                    } else {
        //                        alert("登录异常，请重试！");
        //                    }
        //                }
        //            }
        //            // get
        //            xmlHttp.open("POST", "Login.aspx?teachloginnum=" + username+"&teachpwd="+pwd+"&userType="+usertype , true);
        //            xmlHttp.send();
        //        }
        //    })
        //    })
        function checkname(){
            if($("#teachloginnum").val().length==0){
                document.getElementById("lblShow").innerHTML = "&nbsp用户名不能为空";
                return false;
            }else{
                return true;
            }
        }
        
        $(function () {
            $("#btn1").click(function () {
                var usertype = $("input[name='userType']:checked").val();
                    if (checkname()) {
                        var username = $("#teachloginnum").val();
                        var pwd = $("#teachpwd").val();
                        $.ajax({
                            type: 'post',
                            contentType: "application/json;charset= utf-8",
                            url: "Login.aspx?teachloginnum=" + username + "&teachpwd=" + pwd + "&userType=" + usertype,
                            dataType: 'text',
                            //data: "{'teachloginnum':'" + username + "','teachpwd':'" + pwd + "','usertype':'" + usertype + "'}",
                            success: function (result) {
                                if (result == "1") {
                                    if (usertype == "普通用户")
                                        window.location.href = "mainForm.aspx";
                                    else {
                                        window.location.href = "managerMainform.aspx";
                                    }
                                } else if (result == "2") {
                                    alert("用户名或密码错误，请重试！");
                                } else if (result == "4") {
                                    document.getElementById("Label3").innerHTML = "&nbsp请选择用户类型";
                                }
                                else {
                                    alert("登录异常，请重试！");
                                }
                            },
                            error: function () {
                                alert("服务器端异常");
                            }
                        })
                        //$.post('Login.aspx', { 'username': '" + username + "', 'password': '" + pwd + "', 'usertype': '" + usertype + "' }, function (result) {
                        //    alert(result);
                        //});
                    
                }
                return false;
            })
        })
        function delData() {
            document.getElementById("lblShow").innerHTML = "";
        }
    </script>
    <style>
        body {
            font-family: 'microsoft yahei',Arial,sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('59e579066a3f6.png');
        }
        #loginModal{
            margin-top:100px;
        }
        #Logintitle{
             font-family:"隶书"; font-size:50px; font-style:italic;
             color:#00ff90;
             margin-top:40px;
        }
    </style>
</head>
<body runat="server">
      <div id="Logintitle" class="container" style="text-align:center;">
        <p>肇庆学院提案管理系统</p>
    </div>
    <div id="loginModal" class="modal show">
  <div class="modal-dialog" runat="server">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="text-center text-primary">登录</h1>
      </div>
      <div class="modal-body" runat="server">
        <form  id="f1" class="form col-md-12 center-block" runat="server">
          <div class="form-group">
            <input id="teachloginnum" type="text"  class="form-control input-lg" onblur="checkname()" onfocus="delData()" name="teachloginnum" placeholder="账号" runat="server">
              <asp:Label ID="lblShow" runat="server" ForeColor="Red"></asp:Label>
          </div>
          <div class="form-group" runat="server">
            <input id="teachpwd" type="password" class="form-control input-lg" name="teachpwd" placeholder="登录密码" runat="server">
          </div>
          <div class="form-group" runat="server">
              <div><input id="T_user" type="radio" name="userType" value="普通用户"  runat="server"/>&nbsp<asp:Label ID="Label1" runat="server" Text="Label">普通用户</asp:Label>
              &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input id="C_user" type="radio" name="userType" value="管理员" runat="server" />&nbsp<asp:Label ID="Label2" runat="server" Text="Label">管理员</asp:Label>
                  <asp:Label ID="Label3" runat="server" ForeColor="Red"></asp:Label>
            </div><br />
                  <asp:Button id="btn1" class="btn btn-primary btn-lg btn-block" runat="server" Text="立刻登录"   ></asp:Button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</body>
</html>
