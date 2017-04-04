<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../../common/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户组信息</title>
</head>
<body style="margin: 0px 0px;">
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form id="editUserGroupForm" action="editSaveUserGroup" method="post">
		
			<input type="hidden" name="userGroup.id" value="${userGroup.id }">
			<input type="hidden" name="userGroup.createTime" value="<fmt:formatDate value="${userGroup.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>用户组名</th>
					<td><input type="text" id="groupName" name="userGroup.groupName" value="${userGroup.groupName }"/></td>
					<th>用户组状态</th>
					<td>
						<select id="statu" name="userGroup.statu">
							<!-- <option>-- 请选择 --</option> -->
							<option value="1" <c:if test="${userGroup.statu eq 1}">selected="selected"</c:if>>启用</option>
							<option value="3" <c:if test="${userGroup.statu eq 0}">selected="selected"</c:if>>禁用</option>
						</select>
					</td>
				</tr>
				<!-- <tr>
					<th>角&nbsp;&nbsp;色</th>
					<td>
						<select id="roleId" name="role.id">
							<option>-- 请选择 --</option>
						</select>
					</td>
				</tr> -->
				<tr>
					<th style="vertical-align: middle;">描&nbsp;&nbsp;述</th>
					<td colspan="3"><textarea id="remark" name="userGroup.remark" cols="40" rows="3">${userGroup.remark }</textarea></td>
<!-- 					<th></th> -->
<!-- 					<td></td> -->
				</tr>
				
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 0px;padding-top: 15px;">
				<a href="javascript:void(0)" onclick="editSaveUserGroup();return false;" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" onclick="closeDialog('#editUserGroupDialog');return false;" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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
										if("${userGroup.userList[0].id}" == obj.id){
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
	
		//保存编辑的用户组信息
		function editSaveUserGroup(){
			
			$.ajax({
				url: '${ctx}/sysman/userGroupAction!editSaveUserGroup.action',
				type: 'post',
				data: $("#editUserGroupForm").serialize(),
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('userGroup_dtagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#editUserGroupDialog');
		};
		
		$(function(){
// 			loadRoles();
		});
	</script>
</body>
</html>