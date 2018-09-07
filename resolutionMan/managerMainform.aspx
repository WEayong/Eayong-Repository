<%@ Page Language="C#" AutoEventWireup="true" CodeFile="managerMainform.aspx.cs" Inherits="managerMainform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" />
    <script src="dist/js/jquery-3.2.1.min.js"></script>
    <script src="dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
    <title></title>
    <style>
        #quit{
            text-decoration:none;
        }
        body{
            padding-top:70px;
            /*background-color:#faf2f2;*/
            z-index:1;
        }
        @media (min-width: 768px) {
        #content,#sResolution,s_resolution {
            width: 750px;
            }
        #inforPer{
            position:relative;
        }
        }
        @media (min-width: 992px) {
             #content,#sResolution,s_resolution {
             width: 970px;
            }
        }
        @media (min-width: 1200px) { 
            #content,#sResolution,s_resolution {
                width: 1170px;
            }
        }
        #title{
            color:#ffffff;
        }
        .navbar-default{
            background-color:#337ab7;
        }
        #Label1{
            color:#ffffff;
            line-height:30px;
        }
        #container1{
            position:relative;
            top:30px;
            z-index:3;
        }
        a.list-group-item:hover,a.list-group-item:focus{
            background-color:#337ab7;
            color:white;
        }
        .side-bar .list-group-item{
            border:0;
            margin-bottom:5px;
            border-radius:3px;
            text-align:center;
        }
        .left .list-group-item{
            box-shadow: 5px 5px 3px #888888;
        }
        #maincontent{
            text-align:center;
        }
        #s_resolution{
            box-shadow: 10px 10px 5px #888888;
        }
        #inforPer,#newUser{
            width:600px;
            margin:0 auto;
            display:none;
            box-shadow: 10px 10px 5px #888888;
        }
        #Label2{
            float:right;
        }
        .navbar-right a:hover{
            border-bottom:1px #ffffff solid;
        }
    </style>
    <script>
        $(function () {
            $("#s_btn").click(function () {
                $("#maincontent").hide();
                $("#inforPer").hide();
                $("#opResolu").hide();
                $("#newUser").hide();
                $("#s_resolution").show();
            })
        })
        $(function () {
            $("#hpbtn").click(function () {
                $("#s_resolution").hide();
                $("#inforPer").hide();
                $("#newUser").hide();
                $("#opResolu").hide();
                $("#maincontent").show();
            })
        })
        $(function () {
            $("#inforP").click(function () {
                $("#s_resolution").hide();
                $("#maincontent").hide();
                $("#newUser").hide();
                $("#opResolu").hide();
                $("#inforPer").show();
            })
        })
        $(function () {
            $("#newUser1").click(function () {
                $("#s_resolution").hide();
                $("#maincontent").hide();
                $("#inforPer").hide();
                $("#opResolu").hide();
                $("#newUser").show();
            })
        })
        $(function () {
            $("#o_btn").click(function () {
                $("#s_resolution").hide();
                $("#maincontent").hide();
                $("#inforPer").hide();
                $("#newUser").hide();
                $("#opResolu").show();
            })
        })
        $(function () {
            $("#yes").click(function () {
                var userNum = $("#userNum").val();
                var userName = $("#userName").val();
                var userAge = $("#userAge").val();
                var userSex = $("#userSex").val();
                var userPhone = $("#userPhone").val();
                var userType = $("#userType").val();
                var userEmail = $("#userEmail").val();
                var userPwd = '123456';
                var Depart = $("#Depart").val();
                if (userNum!=""&&userName!=""&&userAge!=""&&userSex!=""&&userPhone!=""&&Depart!=""&&userEmail!="") {
                    $.ajax({
                        type: 'post',
                        contentType: "application/json;utf-8",
                        url: "managerMainform.aspx/addUser",
                        dataType: 'json',
                        data: "{method:'addUser',userNum:'" + userNum + "',userName:'" + userName + "',userAge:'" + userAge + "',userSex:'" + userSex + "',userPhone:'" + userPhone + "',userType:'" + userType + "',userEmail:'" + userEmail + "',userPwd:'" + userPwd + "',Depart:'" + Depart + "'}",
                        success: function (result) {
                            if (result.d == "1") {
                                alert("已成功添加该用户！");
                                document.getElementById("userNum").value = "";
                                document.getElementById("userName").value = "";
                                document.getElementById("userAge").value = "";
                                document.getElementById("userSex").value = "";
                                document.getElementById("userPhone").value = "";
                                document.getElementById("userEmail").value = "";
                                $("#exampleModal").modal("hide");
                            } else {
                                alert("添加用户失败，请重试！");
                                $("#exampleModal").modal("hide");
                            }
                        },
                        error: function () {
                            alert("服务器端异常");
                            $("#exampleModal").modal("hide");
                        }
                    })
                }
                else {
                    alert("请填写完整信息！");
                    $("#exampleModal").modal("hide");
                    return false;
                }
                return false;
            })
        })
        $(function () {
            $("#s_btn").click(function () {
                $("#maincontent").hide();
                $("#inforPer").hide();
                $("#s_resolution").show();
            })
        })
        $(function () {
            $("#yesquit").click(function () {
                window.location.href = "Login.aspx";
            })
        })
        //$(function () {
        //    $("#opbtn").click(function () {
        //        var opinion = $("input[name='apply']:checked").val();
        //        if (opinion != "同意" && opinion != "不同意") {
        //            document.getElementById("opRadio").innerHTML = "&nbsp请选择审批意见！";
        //            return false;
        //        } //else {
        //        //    var res = "＜%=applyResolu()%＞";
        //        //    if (res == "1") {
        //        //        alert("审批成功！");
        //        //    } else {
        //        //        alert("审批失败！");
        //        //    }
        //        //}
        //    })
        //})
    </script>
</head>
<body runat="server" style="background-color:#f2f2f2;">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation" runat="server">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=" #bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    </button>
                    <span class="navbar-brand" id="title" >提案管理系统后台管理</span>
                </div>
                <div class="navbar-form navbar-right">
                    <a href="#" id="quit" data-toggle="modal" data-target="#quitUser" ><asp:Label ID="Label1" runat="server" >退出登录</asp:Label></a>
                </div>
            </div>
        </nav>
        <div class="container" id="container1" runat="server" >
            <div class="row">
                <div class="col-sm-2 left">
                    <div class="list-group side-bar">
                        <a href="#" id="hpbtn" class="list-group-item active">首页</a>
                        <a href="#" id="newUser1" class="list-group-item">新建用户</a>
                        <a href="#" id="checkUser" class="list-group-item">查看用户</a>
                        <a href="#" id="o_btn" class="list-group-item">待审批提案</a>
                        <a href="#" id="s_btn" class="list-group-item">查看提案</a>
                        <a href="#" id="inforP" class="list-group-item">个人信息</a>
                        <a href="#" class="list-group-item">通知公告</a>
                    </div>
                </div>
                <div class="col-sm-8 mid" >
                    <div id="newUser" class="panel panel-primary" runat="server" style="display:none;">
                    <div class="panel-heading">
                        <h3 class="panel-title">添加用户</h3>
                    </div>
                    <div class="panel-body" runat="server">
                        <div class="form-group col-lg-6" runat="server">
                            <label >工号：</label><input class="form-control" id="userNum" type="text" runat="server">
                          </div>
                          <div class="form-group col-lg-6">
                            <label >姓名：</label><input class="form-control " id="userName" type="text" runat="server">
                          </div>
                        <div class="form-group col-lg-3">
                              <label>年龄：</label><input type="text" id="userAge" class="form-control" runat="server">
                            </div>
                            <div class="form-group col-lg-3">
                              <label>性别：</label><asp:DropDownList ID="userSex" class="btn btn-default dropdown-toggle " Width="115px" runat="server">
                                    <asp:ListItem>男</asp:ListItem>
                                    <asp:ListItem>女</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-6">
                            <label >邮箱：</label><input class="form-control " id="userEmail" type="text" runat="server">
                          </div>
                        <div class="form-group col-lg-6">
                            <label >密码：</label>&nbsp&nbsp <label style="color:red;font-size:1px;">*默认初始密码</label><input class="form-control " id="userPwd" type="text" disabled placeholder="123456" runat="server">
                          </div>
                           
                        <div class="form-group col-lg-6">
                            <label >联系方式：</label><input class="form-control " id="Text1" type="text" runat="server">
                        </div>
                         <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <div class="form-group col-lg-6">
                                 &nbsp&nbsp<label >用户类型：</label>
                                <asp:DropDownList ID="DropDownList1" class="btn btn-default dropdown-toggle " data-toggle="dropdown" runat="server" DataTextField="uesrType" DataValueField="id" Width="255px" DataSourceID="SqlDataSource">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString2 %>" SelectCommand="SELECT * FROM [userType]"></asp:SqlDataSource>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="form-group col-lg-6">
                                 &nbsp&nbsp<label >所属学院：</label>
                                <asp:DropDownList ID="Depart" class="btn btn-default dropdown-toggle " data-toggle="dropdown" runat="server" DataSourceID="SqlDataSource5" DataTextField="teach_depart" DataValueField="id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString2 %>" SelectCommand="SELECT * FROM [teachDepart]"></asp:SqlDataSource>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div style="float:right;">
                            <br /><br />
                        <button type="button" id="addbtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" >添加</button>&nbsp&nbsp&nbsp
                        <button type="reset" class="btn btn-primary">重置</button>
                        </div>
                    </div>
                </div>
                    <div id="opResolu" runat="server" style="display:none;" >
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                     <ContentTemplate>
                          <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="811px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="编号" InsertVisible="False" ReadOnly="True" SortExpression="id" >
                            <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="resoluTitle" HeaderText="提案标题" SortExpression="resoluTitle" >
                            <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="teach_name" HeaderText="申请人" SortExpression="teach_name" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Expr1" HeaderText="联名人1"  SortExpression="Expr1" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Expr2" HeaderText="联名人2"  SortExpression="Expr2" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="time" HeaderText="申请时间"  SortExpression="time" >
                            <ItemStyle Width="18%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="操作" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" OnClick="s_Resolu2" runat="server" CommandArgument='<%# Eval("id") %>' CausesValidation="false" CommandName="Operate" Text="审批"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle Width="10%" />
                                <FooterStyle Wrap="True" />
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="30px" HorizontalAlign="Center"  VerticalAlign="Middle" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Height="35px" Wrap="True" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        <PagerTemplate>

                            当前第:
                                <%--//((GridView)Container.NamingContainer)就是为了得到当前的控件--%>
                                <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
                                 页/共:
                                 <%--//得到分页页面的总数--%>
                                <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
                                页
                                <%--//如果该分页是首分页，那么该连接就不会显示了.同时对应了自带识别的命令参数CommandArgument--%>
                                <asp:LinkButton ID="LinkButtonFirstPage" runat="server" CommandArgument="First" CommandName="Page"
                                Visible='<%#((GridView)Container.NamingContainer).PageIndex != 0 %>' ForeColor="Black">首页</asp:LinkButton>
                                <asp:LinkButton ID="LinkButtonPreviousPage" runat="server" CommandArgument="Prev"
                                    CommandName="Page" Visible='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>' ForeColor="Black">上一页</asp:LinkButton>
                                    <%--//如果该分页是尾页，那么该连接就不会显示了--%>
                                    <asp:LinkButton ID="LinkButtonNextPage" runat="server" CommandArgument="Next" CommandName="Page"
                                    Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>' ForeColor="Black">下一页</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButtonLastPage" runat="server" CommandArgument="Last" CommandName="Page"
                                        Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>' ForeColor="Black">尾页</asp:LinkButton>
                                    转到第
                                    <asp:TextBox ID="txtNewPageIndex" runat="server" Width="40px" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1 %>' ForeColor="Black" />页
                                    <%--//这里将CommandArgument即使点击该按钮e.newIndex 值为3 --%>
                                    <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-2"
                                        CommandName="Page" Text="GO" ForeColor="Black" />
                                </PagerTemplate>
                    </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString2 %>" SelectCommand="SELECT C.id, C.resoluTitle, D.teach_name, A.teach_name AS Expr1, B.teach_name AS Expr2, C.time FROM applyResolu AS C INNER JOIN teachers AS A ON C.teach1 = A.id INNER JOIN teachers AS B ON C.teach2 = B.id INNER JOIN teachers AS D ON C.mainteach = D.id"></asp:SqlDataSource>
                     </ContentTemplate>
                 </asp:UpdatePanel>
                    </div>
                    <div id="maincontent">
                        <h2>欢迎使用肇庆学院提案管理系统</h2>
                        <h3>用户须知</h3>
                        <h4>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX<br />
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
                        </h4>
                    </div>
                    <div id="s_resolution" runat="server" style="display:none;" >
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" >
                     <ContentTemplate>
                          <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None" Width="811px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="编号" InsertVisible="False" ReadOnly="True" SortExpression="id" >
                            <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="resoluTitle" HeaderText="提案标题" SortExpression="resoluTitle" >
                            <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="teach_name" HeaderText="申请人" SortExpression="teach_name" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Expr1" HeaderText="联名人1"  SortExpression="Expr1" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Expr2" HeaderText="联名人2"  SortExpression="Expr2" >
                            <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="subTime" HeaderText="申请时间"  SortExpression="subTime" >
                            <ItemStyle Width="18%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="操作" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" OnClick="s_Resolu" runat="server" CommandArgument='<%# Eval("id") %>' CausesValidation="false" CommandName="Check" Text="查看"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle Width="7%" />
                                <FooterStyle Wrap="True" />
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="30px" HorizontalAlign="Center"  VerticalAlign="Middle" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Height="35px" Wrap="True" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        <PagerTemplate>

                            当前第:
                                <%--//((GridView)Container.NamingContainer)就是为了得到当前的控件--%>
                                <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
                                 页/共:
                                 <%--//得到分页页面的总数--%>
                                <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
                                页
                                <%--//如果该分页是首分页，那么该连接就不会显示了.同时对应了自带识别的命令参数CommandArgument--%>
                                <asp:LinkButton ID="LinkButtonFirstPage" runat="server" CommandArgument="First" CommandName="Page"
                                Visible='<%#((GridView)Container.NamingContainer).PageIndex != 0 %>' ForeColor="Black">首页</asp:LinkButton>
                                <asp:LinkButton ID="LinkButtonPreviousPage" runat="server" CommandArgument="Prev"
                                    CommandName="Page" Visible='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>' ForeColor="Black">上一页</asp:LinkButton>
                                    <%--//如果该分页是尾页，那么该连接就不会显示了--%>
                                    <asp:LinkButton ID="LinkButtonNextPage" runat="server" CommandArgument="Next" CommandName="Page"
                                    Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>' ForeColor="Black">下一页</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButtonLastPage" runat="server" CommandArgument="Last" CommandName="Page"
                                        Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>' ForeColor="Black">尾页</asp:LinkButton>
                                    转到第
                                    <asp:TextBox ID="txtNewPageIndex" runat="server" Width="40px" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1 %>' ForeColor="Black" />页
                                    <%--//这里将CommandArgument即使点击该按钮e.newIndex 值为3 --%>
                                    <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-2"
                                        CommandName="Page" Text="GO" ForeColor="Black" />
                                </PagerTemplate>
                    </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString2 %>" SelectCommand="SELECT C.id, C.resoluTitle, D.teach_name, A.teach_name AS Expr1, B.teach_name AS Expr2, C.subTime FROM resolution AS C INNER JOIN teachers AS A ON C.teach1 = A.id INNER JOIN teachers AS B ON C.teach2 = B.id INNER JOIN teachers AS D ON C.mainteach = D.id"></asp:SqlDataSource>
                     </ContentTemplate>
                 </asp:UpdatePanel>
                    </div>
                    <div id="inforPer" class="panel panel-primary" runat="server">
                    <div class="panel-heading">
                        <h3 class="panel-title">个人信息</h3>
                    </div>
                    <div class="panel-body" runat="server">
                        <div class="form-group col-lg-6" runat="server">
                            <label >工号：</label><input class="form-control" id="inforNum" type="text" disabled runat="server">
                          </div>
                          <div class="form-group col-lg-6">
                            <label >姓名：</label><input class="form-control " id="inforName" type="text" disabled runat="server">
                          </div>
                        <div class="form-group col-lg-6">
                              <label>年龄：</label><input type="text" id="inforAge" class="form-control" disabled runat="server">
                            </div>
                            <div class="form-group col-lg-6">
                              <label>性别：</label><input type="text" id="inforSex" class="form-control" disabled runat="server">
                            </div>
                        <div class="form-group col-lg-6">
                            <label >联系方式：</label><input class="form-control " id="inforPhone" type="text" disabled runat="server">
                          </div>
                        <div class="form-group col-lg-6">
                            <label >用户类型：</label><input class="form-control " id="inforType" type="text" disabled runat="server">
                          </div>
                            <div class="form-group col-lg-12">
                            <label >邮箱：</label><input class="form-control " id="inforEmail" type="text" disabled runat="server">
                          </div>
                        <div class="form-group col-lg-12" runat="server">
                            <label >所属学院：</label><input class="form-control " id="inforDepart" type="text" disabled runat="server">
                          </div>
                    </div>
                </div>
                </div>
                <div class="col-sm-2 ">
                    <asp:Label ID="Label2" runat="server" ></asp:Label>
                </div>
            </div>
        </div>
        <footer class="footer navbar-fixed-bottom " style="background-color:#337ab7;z-index:0;">
            <div class="container" style="text-align:center;" >
            <span id="title2" style="color:white;" ><h5>@2018 by 肇庆学院</h5></span>
            </div>
        </footer>
        <div class="modal fade" id="checkRes" tabindex="-1" role="dialog" aria-labelledby="checkModalLabel" runat="server">  
        <div class="modal-dialog" role="document" runat="server">  
            <div class="modal-content" runat="server">  
                <div class="modal-header">  
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
                    <h4 class="modal-title" id="checkModalLabel">确认框</h4>  
                </div>  
            <div class="modal-body" runat="server">  
                <div class="container" id="ab" runat="server" >
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
		                    <div  runat="server">
                                <h4 id="reTitle" runat="server"></h4>
                                <div style=" width:500px;" runat="server">
                                <span id="mteach" runat="server"></span><span id="mtime" style="float:right;" runat="server"></span><br />
                                    <span id="teach1Text" runat="server"></span>&nbsp&nbsp&nbsp&nbsp&nbsp
                                    <span id="teach2Text" runat="server"></span>
                                </div><br />
                                <label>正文：</label><br />
                                <p id="reContent" style="display:inline-block; width:500px;text-indent:2em;" runat="server"></p>
                                <%--<textarea id="reContent" style="width:500px; height:300px;" runat="server"></textarea>--%>
		                    </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </div> 
            </div> 
            <div class="modal-footer">   
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>  
        </div>
      </div>
    </div>
    <div class="modal fade" id="opRes" tabindex="-1" role="dialog" aria-labelledby="opModalLabel" runat="server">  
        <div class="modal-dialog" role="document" runat="server">  
            <div class="modal-content" runat="server">  
                <div class="modal-header">  
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
                    <h4 class="modal-title" id="opModalLabel">确认框</h4>  
                </div>  
            <div class="modal-body" runat="server">  
                <div class="container" id="Div2" runat="server" >
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
		                    <div  runat="server">
                                <h4 id="reTitle2" runat="server"></h4>
                                <div style=" width:500px;" runat="server">
                                <span id="mteach2" runat="server"></span><span id="mtime2" style="float:right;" runat="server"></span><br />
                                    <span id="teach1Text2" runat="server"></span>&nbsp&nbsp&nbsp&nbsp&nbsp
                                    <span id="teach2Text2" runat="server"></span>
                                </div><br />
                                <label>正文：</label><br />
                                <p id="reContent2" style="display:inline-block; width:500px;text-indent:2em;" runat="server"></p>
                                <%--<textarea id="reContent" style="width:500px; height:300px;" runat="server"></textarea>--%>
		                    </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </div> 
            </div> 
            <div class="modal-footer">   
                <div style="float:left;"><label>是否通过：</label>&nbsp&nbsp&nbsp<input id="T_yes" type="radio" name="apply" value="同意"  runat="server"/>&nbsp<asp:Label ID="Label3" runat="server" Text="Label">同意申请</asp:Label>
              &nbsp&nbsp&nbsp&nbsp<input id="T_no" type="radio" name="apply" value="不同意" runat="server" />&nbsp<asp:Label ID="Label4" runat="server" Text="Label">不同意申请</asp:Label>
                  <asp:Label ID="Label5" runat="server" ForeColor="Red"></asp:Label>
                    <asp:Label ID="opRadio" runat="server" ForeColor="Red"></asp:Label>
                </div><br /><br />
                <asp:Button ID="opbtn" class="btn btn-primary" onclick="applyResolu" runat="server" Text="确认" />
                <%--<button type="button" class="btn btn-primary" onclick="applyResolu" id="opbtn" runat="server">确认</button>  --%>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>  
        </div>
      </div>
    </div>
    </form>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">  
        <div class="modal-dialog" role="document">  
            <div class="modal-content">  
                <div class="modal-header">  
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
                    <h4 class="modal-title" id="exampleModalLabel">确认框</h4>  
                </div>  
            <div class="modal-body">  
        <form>  
            <div class="form-group">  
                <label for="message-text" class="control-label">确认信息无误，添加该用户？</label>  
            </div>  
        </form>  
        </div>  
            <div class="modal-footer">  
                <button type="button" class="btn btn-primary" id="yes">确认</button>    
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>  
        </div>
      </div>
    </div>
    <div class="modal fade" id="quitUser" tabindex="-1" role="dialog" aria-labelledby="quitModalLabel">  
        <div class="modal-dialog" role="document">  
            <div class="modal-content">  
                <div class="modal-header">  
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
                    <h4 class="modal-title" id="quitModalLabel">确认框</h4>  
                </div>  
            <div class="modal-body">  
        <form>  
            <div class="form-group">  
                <label for="message-text" class="control-label">确定要退出登录？</label>  
            </div>  
        </form>  
        </div>  
            <div class="modal-footer">  
                <button type="button" class="btn btn-primary" id="yesquit">确认</button>    
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>  
        </div>
      </div>
    </div>
</body>
</html>
