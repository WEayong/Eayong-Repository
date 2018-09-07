<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mainForm.aspx.cs" Inherits="mainForm" EnableEventValidation="false" EnableViewState= "false "%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" />
    <script src="dist/js/jquery-3.2.1.min.js"></script>
    <script src="dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
    <title>肇庆学院提案管理系统</title>
    <script type="text/javascript">
        function checktitle() {
            if ($("#titleid").val().length == 0) {
                document.getElementById("lblShow").innerHTML = "&nbsp标题不能为空";
                return false;
            } else {
                return true;
            }
        }
        function checkcontent() {
            if ($("#texa1").val().length == 0) {
                document.getElementById("lblShow1").innerHTML = "&nbsp提案内容不能为空";
                return false;
            } else {
                return true;
            }
        }
        function checkSession() {
            var userSession='<%=Session["id"]%>'
            if ($("#dropteach").val() == null || $("#DropDownList2").val() == null) {
                alert("联名人不能为空！");
                return false;
            } else if ($("#dropteach").val() == $("#DropDownList2").val() || $("#dropteach").val() == userSession || $("#DropDownList2").val() == userSession) {
                alert("联名人与申请人不能互为相同！");
                return false;
            } else {
                return true;
            }
        }
        function delTitleData() {
            document.getElementById("lblShow").innerHTML = "";
        }
        function delTexaData() {
            document.getElementById("lblShow1").innerHTML = "";
        }
        $(function () {
            $("#smbtn").click(function () {
                if (checktitle() && checkcontent()&&checkSession()) {
                    var userSession='<%=Session["id"]%>'
                    var title = $("#titleid").val();
                    var texa1 = $("#texa1").val();
                    //var dt = document.getElementById("dropteach");
                    //var index1 = dt.seletedIndex;
                    //var teach1 = dt.options[index1].value;
                    var teach1 = $("#dropteach").val();
                    var teach2 = $("#DropDownList2").val();
                    $.ajax({
                        type: 'post',
                        contentType: "application/json;charset= utf-8",
                        url: "mainForm.aspx/submit",
                        dataType: 'json',
                        data: "{method:'submit',title:'" + title + "',texa1:'" + texa1 + "',mainteach:'" + userSession + "',teach1:'" + teach1 + "',teach2:'" + teach2 + "'}",
                        success: function (result) {
                            if (result.d == "1") {
                                alert("提案申请表已提交，请等待审批！");
                                document.getElementById("titleid").value = "";
                                document.getElementById("texa1").value = "";
                            } else {
                                alert("提案申请表提交失败，请重试！");
                            }
                        },
                        error: function () {
                            alert("服务器端异常");
                        }
                    })
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
            $("#hpbtn").click(function () {
                $("#s_resolution").hide();
                $("#inforPer").hide();
                $("#maincontent").show();
            })
        })
        $(function () {
            $("#inforP").click(function () {
                $("#s_resolution").hide();
                $("#maincontent").hide();
                $("#inforPer").show();
            })
        })
        $(function () {
            $("#yesquit").click(function () {
                window.location.href = "Login.aspx";
            })
        })
    </script>
    <style>
        body{
            padding-top:70px;
            /*background-color:#faf2f2;*/
            z-index:1;

        }
        #quit{
            text-decoration:none;
        }
        .navbar-right a:hover{
            border-bottom:1px #ffffff solid;
        }
	 #content{
            margin-top:100px;
        }
     #sResolution{
         border:1px red solid;
         margin:30px auto;
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
            nav {
                z-index: 2;
            }

            #ct1 {
                width: 100%;
            }
            .s1 {
                float: right;
                line-height: 0px;
                font-weight: bold;
            }
            .side-bar .list-group-item{
                border-radius:3px;
                text-align:center;
            }
           .navbar-default{
               background-color:#337ab7;
           }
           #title{
               color:#ffffff;
           }
           #Label2{
               float:right;
           }
           #container1{
               position:relative;
               top:30px;
               z-index:3;
           }
           .left{
               border-right:1px #808080 solid;
           }
           .gridView_th{
               text-align:center;
           }
           #Label1{
               color:#ffffff;
               line-height:30px;
           }
           #maincontent{
               text-align:center;
           }
           #inforPer{
               width:600px;
               margin:0 auto;
               display:none;
               box-shadow: 10px 10px 5px #888888;
           }
           a.list-group-item:hover,a.list-group-item:focus{
               background-color:#337ab7;
               color:white;
           }
           #s_resolution{
               box-shadow: 10px 10px 5px #888888;
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
</style>
</head>
<body  runat="server" style="background-color:#f2f2f2;">
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
                <span class="navbar-brand" id="title" >肇庆学院提案管理系统</span>
                
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
                    <a href="#" class="list-group-item" data-toggle="modal" data-target="#mymodal-data">新建提案</a>
                    <a href="#" id="s_btn" class="list-group-item">查看提案</a>
                    <a href="#" id="inforP" class="list-group-item">个人信息</a>
                    <a href="#" class="list-group-item">通知公告</a>
                </div>
            </div>
            <div class="col-sm-8 mid" >
                <div id="maincontent">
                     
                </div>
                
                
                <div id="s_resolution" runat="server" style="display:none;">
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                     <ContentTemplate>
                          <asp:GridView ID="GridView1" runat="server" OnRowCommand="abc" AllowPaging="True"  AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None" Width="811px">
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
                                    <asp:LinkButton ID="LinkButton1"  runat="server" OnClick="abcd" CausesValidation="false" CommandArgument='<%# Eval("id") %>' CommandName="Check" Text="查看"></asp:LinkButton>
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
                <div id="checkRe" style="display:none;" runat="server">
                    <label for="name">提案标题：</label><input type="text" size="40" runat="server"/><br />
                    <label id="mainteach"></label>
                    <label id="timeRe"></label><br />
                    <label>新建提案内容：</label>
                    <%--<textarea id="texaRe"rows="18"runat="server"></textarea><br />--%>
                    <label >联名人一：</label><label id="teach1"></label>
                    <label >联名人二：</label><label id="teach2"></label>
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
    <div class="modal" id="mymodal-data" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" >
     <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 style="font-weight:bold;text-align:center;" class="modal-title">新建提案</h4>
            </div>
            <div role="form" id="newR1" class="modal-body" runat="server" >
                <div class="form-group" runat="server">
                    <label for="name">新建提案标题：</label><input id="titleid" type="text" onfocus="delTitleData()" onblur="checktitle()" size="40" runat="server"/>
                    <asp:Label ID="lblShow" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <label>新建提案内容：</label><asp:Label ID="lblShow1" runat="server" ForeColor="Red"></asp:Label>
                    <textarea id="texa1" class="form-control" rows="18" onfocus="delTexaData()" onblur="checkcontent()" runat="server"></textarea><br />
              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                  <ContentTemplate>
                      <label >联名人一：</label>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString %>" SelectCommand="SELECT [id], [teach_depart] FROM [teachDepart]"></asp:SqlDataSource>
                        <asp:DropDownList ID="dropdepart" runat="server" Width="260px" AutoPostBack="true" DataSourceID="SqlDataSource1" DataTextField="teach_depart" DataValueField="id">
                        </asp:DropDownList>
                        <asp:DropDownList ID="dropteach" runat="server" Width="70px" AutoPostBack="true" DataSourceID="SqlDataSource2" DataTextField="teach_name" DataValueField="id">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString %>" SelectCommand="SELECT [id], [teach_name] FROM [teachers] WHERE ([depart_id] = @depart_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="dropdepart" Name="depart_id" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource><br />
                      <label >联名人二：</label>
                        <asp:DropDownList ID="DropDownList1"  runat="server" Width="260px" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="teach_depart" DataValueField="id">
                        </asp:DropDownList>
                        <asp:DropDownList ID="DropDownList2" runat="server" Width="70px" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="teach_name" DataValueField="id">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:resolutionManConnectionString %>" SelectCommand="SELECT [id], [teach_name] FROM [teachers] WHERE ([depart_id] = @depart_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList1" Name="depart_id" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                     </ContentTemplate>
    </asp:UpdatePanel>
    </div>
        <div class="modal-footer" runat="server">
            <asp:Button ID="smbtn" class="btn btn-primary" runat="server"  Text="提交" />&nbsp&nbsp
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        </div>
         </div>
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
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
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
    </form>
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
