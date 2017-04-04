<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="../../common/head.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加组织机构</title>
</head>
<body>
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form id="addUserForm" name="addUserForm" action="${ctx}/sysman/userAction!addUser.action" method="post">
			<table class="form_table">
				<tr>
					<th>用户名</th>
					<td><input type="text" id="userName" name="user.userName" value=""/></td>
					<th>密&nbsp;&nbsp;码</th>
					<td><input type="password" id="password" name="user.password" value=""/></td>
				</tr>
				<tr>
					<th>性&nbsp;&nbsp;别</th>
					<td><input type="text" id="sex" name="user.sex" value=""/></td>
					<th>手&nbsp;&nbsp;机</th>
					<td><input type="text" id="telphone" name="user.telphone" value=""/></td>
				</tr>
				<tr>
					<th>邮&nbsp;&nbsp;箱</th>
					<td><input type="text" id="email" name="user.email" value=""/></td>
					<th>用户状态</th>
					<td>
						<select id="statu" name="user.statu">
							<option>-- 请选择 --</option>
							<option value="1">启用</option>
							<option value="3">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>角&nbsp;&nbsp;色</th>
					<td>
						<select id="roleId" name="role.id">
							<option>-- 请选择 --</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">描&nbsp;&nbsp;述</th>
					<td colspan="3"><textarea id="remark" name="user.remark" cols="40" rows="3"></textarea></td>
<!-- 					<th></th> -->
<!-- 					<td></td> -->
				</tr>
				
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 0px;padding-top: 15px;">
				<a href="#" onclick="addSaveUser();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="#" onclick="closeDialog('#addUserDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	
		//加载角色下拉框数据
		function loadRoles(){
			$.ajax({
				url: '${ctx}/sysman/roleAction!loadRoles.action',
				dataType: 'json',
				cache: false,
				async: false,
				success: function(data){
					if(data){
						$(data).each(function(i, obj){
							$("<option/>").attr("value",obj.id).text(obj.roleName).appendTo("#roleId");
						});
					} else {
						$.messager.alert('错误','加载角色下拉选项失败！','error');
					}	
				},
				error: function(){$.messager.alert('错误', '发送请求失败', 'error');}
			});
		}
	
		//保存编辑的用户信息
		function addSaveUser(){
			
// 			var form = $("#addUserForm").attr({action:"${ctx}/sysman/userAction!addUser.action", method:"post"});
			$.ajax({
				url: '${ctx}/sysman/userAction!addSaveUser.action',
				type: 'post',
				data: $("#addUserForm").serialize(),
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('userList_dtagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#addUserDialog');
		};
		
		$(function(){
			loadRoles();
		});
	</script>
</body>
</html>