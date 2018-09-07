<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'StudentInfoMan.jsp' starting page</title>
	<%
    	if(session.getAttribute("sessionUser")==null){
    		response.sendRedirect("index.jsp");
    		return;
    	}
     %>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5/themes/icon.css">
	<script type="text/javascript" src="jquery-easyui-1.5.5/jquery.min.js"></script>
	<%-- <script type="text/javascript" src='<c:url value="images/jquery-3.2.1.min.js"></c:url>'></script> --%>
	<script type="text/javascript" src="jquery-easyui-1.5.5/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		flag=true;
		$(function (){
            var buttons = $.extend([], $.fn.datebox.defaults.buttons);
            buttons.splice(1, 0, {
                text: '清除',
                handler: function (target) {
                    $(target).datebox("setValue","");
                    $(target).datebox("hidePanel");
                }
            });
            $(".easyui-datebox").datebox({  
                buttons: buttons  
            });
            $.extend($.fn.validatebox.defaults.rules, {
     			selectValueRequired: {
          			validator: function(){
               		//return $("#insti").find("option:contains('"+id+"')").val() != '';
               		 	if($("#gradeId").combobox('getValue')!='' && $("#gradeId").combobox('getValue')!=null){
                			return true;
            			}
            				return false;
               		
          			},
     				message: '请选择所属班级'
     			},
     			selectSexRequired: {
          			validator: function(){
               		//return $("#insti").find("option:contains('"+id+"')").val() != '';
               		 	if($("#stuSex").combobox('getValue')!='' && $("#stuSex").combobox('getValue')!=null){
                			return true;
            			}
            				return false;
               		
          			},
     				message: '请选择学生性别'
     			},
     			minLength: {
                validator: function (value, param) {
                    return value.length >= param[0];
                },
                message: '请选择学生性别'
           		},
     			intOrFloat: {// 验证整数或小数
                validator: function (value) {
                    return /^\d+(\.\d+)?$/i.test(value);
                },
                message: '请输入数字，并确保格式正确'
     			},
     			chinese: {// 验证中文
                validator: function (value) {
                    return /^[\Α-\￥]+$/i.test(value);
                },
                message: '请输入中文'
     			}
			});
			$("#dlg").dialog({
				onClose:function(){
					$("#stuNo").val("");
					$("#stuName").val("");
					$("#stuBirth").datebox("setValue","");
					$("#stuEmail").val("");
					$("#stuDesc").val("");
					var instiid=$("#s_instiId2").combobox('getValue');
					$("#s_instiId2").combobox('unselect',instiid);
					var gradeid=$("#gradeId").combobox('getValue');
					$("#gradeId").combobox('unselect',gradeid);
					var sexid=$("#stuSex").combobox('getValue');
					$("#stuSex").combobox('unselect',sexid);
				}
			});
		});
		function searchGrade(){
		 $('#dg').datagrid('load',{
			stuName:$("#s_stuName").val(),
			stuNo:$("#s_stuNo").val(),
			stuSex:$("#s_sex").combobox('getValue'),
			bgstuBirth:$("#s_bgstuBirth").datebox('getValue'),
			endstuBirth:$("#s_endstuBirth").datebox('getValue'),
			gradeId:$("#s_gradeId").combobox('getValue'),
			insti_id:$("#s_instiId").combobox('getValue')
		});
		}
		function deleteStudent(){
			var selectRows=$("#dg").datagrid('getSelections');
			if(selectRows.length==0){
				$.messager.alert("系统提示","请选择要删除的记录！");
				return;
			}
			var strIds=[];
			for(var i=0;i<selectRows.length;i++){
				strIds.push(selectRows[i].stuId);
			}
			var ids=strIds.join(",");
			$.messager.confirm("系统提示","您确定要删除这<font color=red size=5px>"+selectRows.length+"</font>条记录吗？",function(r){
				if(r){
					$.post(
						"${pageContext.request.contextPath }/StudentServlet?method=delList",
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
			});
	}
	function openStudentAdddialog(){
			$("#dlg").dialog("open").dialog("setTitle","添加学生信息");
			flag=true;
	}
	function openStudentModidialog(){
		loadingWindow();
		var selectRows=$("#dg").datagrid('getSelections');
		if(selectRows.length!=1){
			$.messager.alert("系统提示","请选择一条要修改的记录");
			return;
		}
		flag=false;
		var row= selectRows[0];
		
		var title=$("#dlg").dialog("options").Title;
		$("#addFm").form("load",row);
		var dataSex=$("#stuSex").combobox("getData");
		for (var i=0;i<dataSex.length;i++){
			if(dataSex[i].value==row["stuSex"]){
				$("#stuSex").combobox("select",dataSex[i].value); 
				break;
			}
		}
		var dataInstiName=$("#s_instiId2").combobox("getData");
		var instiid=$("#s_instiId2").combobox('getValue');
		$("#s_instiId2").combobox('unselect',instiid);
		for (var i=0;i<dataInstiName.length;i++){
			if(dataInstiName[i].insti_Name==row["insti_Name"]){
				$("#s_instiId2").combobox("select",dataInstiName[i].id);
				break;
			}
		}
		setTimeout(function(){
			var dataGradedata=$("#gradeId").combobox("getData");
			for (var i=0;i<dataGradedata.length;i++){
			if(dataGradedata[i].gradeName==row["gradeName"]){
				$("#gradeId").combobox("select",dataGradedata[i].id);
				break;
			}
		}
		},999);
		disLoadWindow();
	}
	function dlgClose(){
		$("#stuNo").val("");
		$("#stuName").val("");
		$("#stuBirth").datebox("setValue","");
		$("#stuEmail").val("");
		$("#stuDesc").val("");
		var instiid=$("#s_instiId2").combobox('getValue');
		$("#s_instiId2").combobox('unselect',instiid);
		var gradeid=$("#gradeId").combobox('getValue');
		$("#gradeId").combobox('unselect',gradeid);
		var sexid=$("#stuSex").combobox('getValue');
		$("#stuSex").combobox('unselect',sexid);
		$("#dlg").dialog("close");
	}
	function studentUpdate(){
		if(flag==true){
			if($("#stuSex").combobox('getValue')=='' || $("#stuSex").combobox('getValue')==null){
						$.messager.alert("系统提示","请填写完整信息！");
						return;
			}
			$.messager.confirm("系统提示","信息无误，确认添加？",function(r){
				if(r){
					var gradeid=$("#gradeId").combobox('getValue');
					$("#addFm").form("submit",{
						url:"${pageContext.request.contextPath }/StudentServlet?method=updateStu&gradeid="+gradeid+"&op=Add",
						onSubmit:function(){
							return $(this).form("validate");
						},
						success:function(result){
						if(result.errorMsg){
							$.messager.alert("系统提示",result.errorMsg);
							return;	
						}else{
							$.messager.alert("系统提示","添加成功!");
							$("#stuNo").val("");
							$("#stuName").val("");
							$("#stuBirth").datebox("setValue","");
							$("#stuEmail").val("");
							$("#stuDesc").val("");
							var instiid=$("#s_instiId2").combobox('getValue');
							$("#s_instiId2").combobox('unselect',instiid);
							var gradeid=$("#gradeId").combobox('getValue');
							$("#gradeId").combobox('unselect',gradeid);
							var sexid=$("#stuSex").combobox('getValue');
							$("#stuSex").combobox('unselect',sexid);
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
			var stuId=row.stuId;
			if($("#stuNo").val()!=row.stuNo||$("#stuName").val()!=row.stuName||$("#stuEmaul").val()!=row.stuEmail||$("#stuBirth").datebox("getText")!=row.stuBirth||
			$("#s_instiId2").combobox("getText")!=row.insti_Name||$("#gradeId").combobox("getText")!=row.gradeName||
			$("#stuSex").combobox("getText")!=row.stuSex||$("#stuDesc").val()!=row.stuDesc){
				$.messager.confirm("系统提示","信息无误，确认修改？",function(r){
					if(r){
						var gradeid=$("#gradeId").combobox("getValue");
						$("#addFm").form("submit",{
							url:"${pageContext.request.contextPath }/StudentServlet?method=updateStu&gradeid="+gradeid+"&op=Mod&id="+stuId+"",
						onSubmit:function(){
							return $(this).form("validate");
						},
						success:function(result){
						if(result.errorMsg1){
							$.messager.alert("系统提示",result.errorMsg1);
							return;	
						}else{
							$.messager.alert("系统提示","修改成功!");
							$("#stuNo").val("");
							$("#stuName").val("");
							$("#stuBirth").datebox("setValue","");
							$("#stuEmail").val("");
							$("#stuDesc").val("");
							var instiid=$("#s_instiId2").combobox('getValue');
							$("#s_instiId2").combobox('unselect',instiid);
							var gradeid=$("#gradeId").combobox('getValue');
							$("#gradeId").combobox('unselect',gradeid);
							var sexid=$("#stuSex").combobox('getValue');
							$("#stuSex").combobox('unselect',sexid);
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
		}
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
		    $("#dlg").dialog("open").dialog("setTitle","修改学生信息");
			},1000);
	    
		}
	})();
 
	
	</script>
  </head>
  
  <body style="margin: 5px;">
    	<table id="dg" title="班级信息" class="easyui-datagrid" fitColumns="true" pagination="true" 
    	 rownumbers="true" fit="true" url="${pageContext.request.contextPath }/StudentServlet?method=pagelist"
    	 toolbar="#tb">
    		<thead>
    			<tr>
    				<th field="stuId" width="20px" checkbox="true" >编号</th> 
    				<th field="stuNo" width="30px" align="center" >学号</th>
    				<th field="stuName" width="20px" align="center">学生姓名</th>
    				<th field="stuSex" width="10px" align="center">性别</th>
    				<th field="stuBirth" width="30px" align="center">出生日期</th>
    				<th field="insti_Name" width="60px" align="center">学院</th>
    				<th field="gradeName" width="20px" align="center">班级名称</th>
    				<th field="stuEmail" width="30px" align="center">Email</th>
    				<th field="stuDesc" width="70px" align="center">学生备注</th>
    			</tr>
    		</thead>
    	</table>
    	<div id="tb">
    		<a href="javascript:openStudentAdddialog()" class="easyui-linkbutton" iconCls="icon-add"  plain="true" >添加</a>
    		<a href="javascript:openStudentModidialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
    		<a href="javascript:deleteStudent()" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" >删除</a>
    		<div >&nbsp;学生姓名：<input type="text"  id="s_stuName" name="s_stuName" size="5">
    		学生学号：<input type="text"  id="s_stuNo" name="s_stuNo" size="10">
    		性别：<select class="easyui-combobox" id="s_sex" name="s_sex" editable="false"  panelHeight="auto">
    			<option value="">请选择.......</option><option value="男">男</option><option value="女">女</option>
    		</select>
    		&nbsp;出生日期：<input class="easyui-datebox" id="s_bgstuBirth"  name="s_bgstuBirth" data-options="editable:false" size="10"> ->
    		<input class="easyui-datebox" id="s_endstuBirth" name="s_endstuBirth" editable="false" size="10">
    		&nbsp;班级名称：&nbsp;<input class="easyui-combobox" id="s_instiId" name="s_instiId" panelHeight="200" data-options="editable:false,
    		valueField:'id',
    		textField:'insti_Name',
    		url:'${pageContext.request.contextPath }/StudentServlet?method=InsticomboData',
    		onSelect:function(rec){
    			var url='${pageContext.request.contextPath }/StudentServlet?method=GradecomboData&id='+rec.id;
    			$('#s_gradeId').combobox('clear');
    			$('#s_gradeId').combobox('reload',url);
    		}
    		" >
    		<input class="easyui-combobox" size="12" id="s_gradeId" name="s_gradeId" panelHeight="200" data-options="editable:false,valueField:'id',textField:'gradeName'"> 
    		<a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true" >搜索</a></div>
    	</div>
    	<div id="dlg" class="easyui-dialog" style="width:400px;height: 450;padding: 10px 20px;"
    		closed="true" buttons="#dlg-buttons" >
    		<form id="addFm" method="post">
    		<table >
    			<tr>
    				<td>学生学号：</td>
    				<td><input type="text" name="stuNo" size="16" id="stuNo" class="easyui-validatebox" required="true" validType="intOrFloat['#stuNo']"></td>
    			</tr>
    			<tr>
    				<td>学生姓名：</td>
    				<td><input type="text" name="stuName" size="16" id="stuName" class="easyui-validatebox" required="true" validType="chinese['#stuName']"></td>
    			</tr>
    			<tr>
    				<td>学生性别：</td>
    				<td>
    				<select class="easyui-combobox" id="stuSex" name="stuSex" data-options="width:150" editable="false" panelHeight="auto">
    						<option value="">请选择.......</option><option value="男">男</option><option value="女">女</option>
    				</select>
    				</td>
    			</tr>
    			<tr>
    				<td>出生日期：</td>
    				<td><input class="easyui-datebox" id="stuBirth"  name="stuBirth" data-options="editable:false" required="true" size="17"></td>
    			</tr>
    			<tr>
    				<td>所属学院：</td>
    				<td>
    					<input class="easyui-combobox" id="s_instiId2" name="s_instiId2" panelHeight="200" data-options="editable:false,
    						valueField:'id',
    						textField:'insti_Name',
    						url:'${pageContext.request.contextPath }/StudentServlet?method=InsticomboData',
    						onSelect:function(rec){
    							var url='${pageContext.request.contextPath }/StudentServlet?method=GradecomboData&id='+rec.id;
    							$('#gradeId').combobox('clear');
    							$('#gradeId').combobox('reload',url);
    						}
    					" >
    				</td>
    			</tr>
    			<tr>
    				<td>所属班级：</td>
    				<td><input class="easyui-combobox" size="20" id="gradeId" name="gradeId" panelHeight="200" validType="selectValueRequired['#gradeId']" data-options="editable:false,valueField:'id',textField:'gradeName'"> </td>
    			</tr>
    			<tr>
    				<td>学生邮箱：</td>
    				<td><input type="text" name="stuEmail" size="20" id="stuEmail" class="easyui-validatebox" required="true" validType="email"></td>
    			</tr>
    			<tr>
    				<td valign="top">学生描述：</td>
    				<td><textarea colspan="3" rows="6" cols="30" name="stuDesc" id="stuDesc"  ></textarea></td>
    			</tr>
    		</table>
    		</form>
    	</div>
    	<div id="dlg-buttons">
    		<a href="javascript:studentUpdate()" class="easyui-linkbutton" iconCls="icon-save">保存</a>
    		<a href="javascript:dlgClose()" class="easyui-linkbutton" iconCls="icon-no">取消</a>
    	</div>
  </body>
</html>
