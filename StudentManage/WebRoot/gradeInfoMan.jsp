<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'gradeInfoMan.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/icon.css">
	<script type="text/javascript" src="jquery-easyui-1.5.5/jquery.min.js"></script>
	<%-- <script type="text/javascript" src='<c:url value="images/jquery-3.2.1.min.js"></c:url>'></script> --%>
	<script type="text/javascript" src="jquery-easyui-1.5.5/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5/locale/easyui-lang-zh_CN.js"></script>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%
    	if(session.getAttribute("sessionUser")==null){
    		response.sendRedirect("index.jsp");
    		return;
    	}
     %>
	<script type="text/javascript">
	var url;
	var flag=true;
	function searchGrade(){
		$('#dg').datagrid('load',{
			gradeName:$("#s_gradeName").val()
		});
	}
	function deleteGrade(){
		var selectRows=$("#dg").datagrid('getSelections');
		if(selectRows.length==0){
			$.messager.alert("系统提示","请选择要删除的记录！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectRows.length;i++){
			strIds.push(selectRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red size=5px>"+selectRows.length+"</font>条记录吗？",function(r){
			if(r){
				var gradeNames="";
				$.post(
					"${pageContext.request.contextPath }/GradeServlet?method=searchStu",
					{delIds1:ids},
					function(result){
						if(result.success1){
							for(var i=0;i<result.searchstu.length;i++){
								if(i==0){
									gradeNames=gradeNames+result.searchstu[i].gradeName;
								}else{
									gradeNames=gradeNames+","+result.searchstu[i].gradeName;
								}
							}
							$.messager.alert("警告","您选择的班级<font color=red size=5px>"+gradeNames+"</font>学生人数不为零，请先清空学生信息再进行删除操作！",'error');
							/* $.messager.alert("警告","您选择的班级学生人数不为零，请先清空学生信息再进行删除操作！",'error'); */
							$("#dg").datagrid("reload");
						}else{
							$.post(
								"${pageContext.request.contextPath }/GradeServlet?method=delList",
								{delIds:ids},
								function(result){
									if(result.success){
										$.messager.alert("系统提示","您已成功删除<font color=red size=5px>"+result.delnum+"</font>条数据！");
										$("#dg").datagrid("reload");
									}else{
								$.messager.alert("系统提示",result.errorMsg);
									}
								},"json");
						}
					},"json");
			}
		});
	}
	function openGradeAdddialog(){
			$("#dlg").dialog("open").dialog("setTitle","添加班级信息");
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/GradeServlet?method=comData",
				dataType:"json",
				success:function(data){
					 var options=$("#insti").combobox("options");
					options.valueField="id";
					options.textField="insti_Name";
					options.editable=false;
					$("#insti").combobox("loadData",data.data);
					$("#insti").combobox('setText', '------------请选择所属学院-----------'); 
				}
			});
			flag=true;
	}
	$(function(){
		$.extend($.fn.validatebox.defaults.rules, {
     		selectValueRequired: {
          		validator: function(){
               		//return $("#insti").find("option:contains('"+id+"')").val() != '';
               		 if($("#insti").combobox('getValue')!='' && $("#insti").combobox('getValue')!=null){
                			return true;
            		}
            				return false;
               		
          		},
     			message: '请选择所属学院'
     		}
		});
		$("#dlg").dialog({
			onClose: function () {
				$("#gradeName").val("");
				$("#gradeDesc").val("");
				$("#insti").combobox('setText', '------------请选择所属学院-----------'); 
				var id=$("#insti").combobox('getValue');
				$("#insti").combobox('unselect',id);
			}
		});
	});
	function dlgClose(){
		$("#gradeName").val("");
		$("#gradeDesc").val("");
		$("#insti").combobox('setText', '------------请选择所属学院-----------'); 
		var id=$("#insti").combobox('getValue');
		$("#insti").combobox('unselect',id);
		$("#dlg").dialog("close");
	}
	function gradeUpdate(){
		if(flag==true){
			if($("#insti").combobox('getValue')=='' || $("#insti").combobox('getValue')==null){
						$.messager.alert("系统提示","请填写完整信息！");
						return;
			}
			$.messager.confirm("系统提示","信息无误，确认添加？",function(r){
				if(r){
					var instiId=$("#insti").combobox('getValue');
					$("#addFm").form("submit",{
						url:"${pageContext.request.contextPath }/GradeServlet?method=addGrade&instiId="+instiId+"&op=Add",
						onSubmit:function(){
							return $(this).form("validate");
						},
						success:function(result){
						if(result.errorMsg){
							$.messager.alert("系统提示",result.errorMsg);
							return;	
						}else{
							$.messager.alert("系统提示","保存成功!");
							$("#gradeName").val("");
							$("#gradeDesc").val("");
							$("#insti").combobox('setText', '------------请选择所属学院-----------'); 
							var id=$("#insti").combobox('getValue');
							$("#insti").combobox('unselect',id);
							$("#dlg").dialog("close");
							$("#dg").datagrid("reload");
						}					
						}
					});
				}			
			});
		}else{
			var selectRows=$("#dg").datagrid('getSelections');
			var row=selectRows[0];
			var gradeId=row.id;
			if($("#gradeName").val()!=row.gradeName||$("#gradeDesc").val()!=row.gradeDesc||$("#insti").combobox("getText")!=row.insti_Name){
				$.messager.confirm("系统提示","信息无误，确认修改？",function(r){
					if(r){
						var instiId=$("#insti").combobox("getValue");
						$("#addFm").form("submit",{
							url:"${pageContext.request.contextPath }/GradeServlet?method=addGrade&instiId="+instiId+"&op=Mod&id="+gradeId+"",
						onSubmit:function(){
							return $(this).form("validate");
						},
						success:function(result){
						if(result.errorMsg1){
							$.messager.alert("系统提示",result.errorMsg1);
							return;	
						}else{
							$.messager.alert("系统提示","修改成功!");
							$("#gradeName").val("");
							$("#gradeDesc").val("");
							$("#insti").combobox('setText', '------------请选择所属学院-----------'); 
							var id=$("#insti").combobox('getValue');
							$("#insti").combobox('unselect',id);
							$("#dlg").dialog("close");
							$("#dg").datagrid("reload");
						}					
						}
						});
					}
				});
			}else{
				$.messager.confirm("系统提示","没有信息修改，点击确定关闭窗口",function(r){
				if(r){
					$("#dlg").dialog("close");
					flag=true;
					}else{
						flag=false;
					}
				});
			}
			/* $("#addFm").form("submit",{
				
			}); */
		}
	}
	function openGradeModidialog(){
		var selectRows=$("#dg").datagrid('getSelections');
		if(selectRows.length!=1){
			$.messager.alert("系统提示","请选择一条要修改的记录");
			return;
		}
		flag=false;
		var row= selectRows[0];
		loadingWindow();
		var title=$("#dlg").dialog("options").Title;
		$("#addFm").form("load",row);
		$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/GradeServlet?method=comData",
				dataType:"json",
				success:function(data){
					var options=$("#insti").combobox("options");
					options.valueField="id";
					options.textField="insti_Name";
					options.editable=false;
					$("#insti").combobox("loadData",data.data);
					var text=$("#insti").combobox("getValue");
					var d=$("#insti").combobox("getData");
					for (var i=0;i<d.length;i++){
						if(d[i].insti_Name==row["insti_Name"]){
							$("#insti").combobox("select",d[i].id); 
							break;
						}
					}
				}
			});
		disLoadWindow();	
	}
	//弹出加载层
	var loadingWindow=(function (){
		return function(){
		$("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", 
		height: $(window).height() }).appendTo("body");
   	 	$("<div class=\"datagrid-mask-msg\"></div>").html("正在加载，请稍候。。。").appendTo("body").css({ display: "block",
   	 	 left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 ,width:200,height:40});
		}
	})();
    

 
	//取消加载层  
	var disLoadWindow=(function disLoadWindow() {
		return function(){
			setTimeout(function (){
			$(".datagrid-mask").remove();
		    $(".datagrid-mask-msg").remove();
		    $("#dlg").dialog("open").dialog("setTitle","修改班级信息");
			},1000);
	    
		}
	})();
	</script>
  </head>
  
  <body style="margin: 5px;">
    	<table id="dg" title="班级信息" class="easyui-datagrid" fitColumns="true" pagination="true" 
    	 rownumbers="true" fit="true" url="${pageContext.request.contextPath }/GradeServlet?method=pagelist"
    	 toolbar="#tb">
    		<thead>
    			<tr>
    				<th field="id" width="20px" checkbox="true"align="center" >编号</th> 
    				<th field="insti_Name" width="80px" align="center">学院名称</th>
    				<th field="gradeName" width="70px" align="center">班级名称</th>
    				<th field="gradeDesc" width="250px" align="center">班级描述</th>
    			</tr>
    		</thead>
    	</table>
    	<div id="tb">
    		<a href="javascript:openGradeAdddialog()" class="easyui-linkbutton" iconCls="icon-add"  plain="true" >添加</a>
    		<a href="javascript:openGradeModidialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
    		<a href="javascript:deleteGrade()" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" >删除</a>
    		<div style="float: right;">班级名称：&nbsp;<input type="text"  id="s_gradeName" name="s_gradeName">
    		<a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true" >搜索</a></div>
    	</div>
    	<div id="dlg" class="easyui-dialog" style="width:400px;height: 330;padding: 10px 20px;"
    		closed="true" buttons="#dlg-buttons" >
    		<form id="addFm" method="post">
    		<table>
    			<tr>
    				<td>班级名称：</td>
    				<td><input type="text" name="gradeName" id="gradeName" class="easyui-validatebox" required="true"></td>
    			</tr><br> 
    			<tr>
    				<td>所属学院：</td>
    				<td><input id="insti" class="easyui-combobox "data-options="editable:false,panelHeight: '200',width:200" required="true" validType="selectValueRequired['#insti']" name="insti_id" ></td>
    			</tr><br> 
    			<tr>
    				<td valign="top">班级描述：</td>
    				<td><textarea rows="7" cols="30" name="gradeDesc" id="gradeDesc" class="easyui-validatebox" required="true" ></textarea></td>
    			</tr>
    		</table>
    		</form>
    	</div>
    	<div id="dlg-buttons">
    		<a href="javascript:gradeUpdate()" class="easyui-linkbutton" iconCls="icon-save">保存</a>
    		<a href="javascript:dlgClose()" class="easyui-linkbutton" iconCls="icon-no">关闭</a>
    	</div>
  </body>
</html>
