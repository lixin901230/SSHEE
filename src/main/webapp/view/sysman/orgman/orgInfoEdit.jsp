<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../../common/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑组织机构信息</title>
</head>
<body style="margin: 0px 0px;">
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form id="editUserForm" action="editSaveUser" method="post">
		
			<input type="hidden" name="user.id" value="${user.id }">
			<input type="hidden" name="user.createTime" value="<fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>用户名</th>
					<td><input type="text" id="userName" name="user.userName" value="${user.userName }"/></td>
					<th>密&nbsp;&nbsp;码</th>
					<td><input type="password" id="password" name="user.password" value="${user.password }"/></td>
				</tr>
				<tr>
					<th>性&nbsp;&nbsp;别</th>
					<td><input type="text" id="sex" name="user.sex" value="${user.sex}"/></td>
					<th>手&nbsp;&nbsp;机</th>
					<td><input type="text" id="telphone" name="user.telphone" value="${user.telphone}"/></td>
				</tr>
				<tr>
					<th>邮&nbsp;&nbsp;箱</th>
					<td><input type="text" id="email" name="user.email" value="${user.email}"/></td>
					<th>用户状态</th>
					<td>
						<select id="statu" name="user.statu">
							<option>-- 请选择 --</option>
							<option value="1" <c:if test="${user.statu eq 1}">selected="selected"</c:if>>启用</option>
							<option value="3" <c:if test="${user.statu eq 3}">selected="selected"</c:if>>禁用</option>
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
					<td colspan="3"><textarea id="remark" name="user.remark" cols="40" rows="3">${user.remark }</textarea></td>
<!-- 					<th></th> -->
<!-- 					<td></td> -->
				</tr>
				
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 0px;padding-top: 15px;">
				<a href="javascript:void(0)" onclick="editSaveUser();return false;" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" onclick="closeDialog('#editUserDialog');return false;" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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
							$("<option/>").attr({
									value: obj.id, 
									selected: function(){
										if("${user.roleList[0].id}" == obj.id){
											return "selected";
										} else {
											false;
										}
									}
							}).text(obj.roleName).appendTo("#roleId");
						});
					} else {
						$.messager.alert('错误','加载角色下拉选项失败！','error');
					}	
				},
				error: function(){$.messager.alert('错误', '发送请求失败', 'error');}
			});
		}
	
		//保存编辑的用户信息
		function editSaveUser(){
			
			$.ajax({
				url: '${ctx}/sysman/userAction!editSaveUser.action',
				type: 'post',
				data: $("#editUserForm").serialize(),
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('userList_dtagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#editUserDialog');
		};
		
		$(function(){
			loadRoles();
		});
	</script>
</body>
</html>