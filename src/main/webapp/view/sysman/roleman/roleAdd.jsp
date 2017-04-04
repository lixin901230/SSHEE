<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="../../common/head.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加角色信息</title>
</head>
<body style="margin: 0px 0px;">
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form action="" id="addRoleForm">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>角色名</th>
					<td><input type="text" id="roleName" name="role.roleName" value="${role.roleName }"/></td>
					<th>角色类型</th>
					<td>
						<select name="role.roleType" id="roleType">
							<option value="1">超级管理员</option>
							<option value="2">系统管理员</option>
							<option value="3">普通用户</option>
						</select>
					</td>
				</tr>
				<tr>
					<!-- <th>创建时间</th>
					<td>
						<input name="role.createTime" id="createTime" style="width: 155px;" value=""
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>
					</td> -->
					<th>状&nbsp;&nbsp;态</th>
					<td colspan="3">
						<select name="role.state" id="state">
							<option value="0">禁用</option>
							<option value="1">启用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>备&nbsp;&nbsp;注</th>
					<td colspan="3"><textarea name="role.remark" cols="62" rows="3"></textarea></td>
				</tr>
			</table>
			<br/>
			<table class="form_table" style="width: 100%;">
				<th style="vertical-align: top;padding-right: 5px;padding-top: 5p;">角色允许访问的资源</th>
				<td colspan="3">
					<ul id="resource_tree"></ul>
				</td>
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 5px;padding-top: 5px;">
				<a href="#" onclick="saveRole();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="#" onclick="closeDialog('#addRoleDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		//加载修改对象
		function getResourceTree(){
			$("#resource_tree").tree({
				iconCls: 'icon-save',
				url: '${ctx}/sysman/resourceAction!getAllTeeNode.action',
				id: 'id',
				textField: 'nodeName',
				parentField: 'parentId',
				state: 'closed',
				lines: true,
				checkbox: true,
				animate: true,
			});
			
			//给节点绑定点击事件，当点击节点的时候选中复选框
			clickNodeTextChecked("#resource_tree");
		}
		
		//保存角色信息
		function saveRole(){
			
			var resourceIdsTemp = [];
			var checkeds = $("#resource_tree").tree("getChecked");//获取所有选中的复选框
			var checkedNodeParent = $('#resource_tree').tree('getChecked', 'indeterminate');//获取选中节点的父节点（父节点为半选中状态，及其子节点不是全部选中）
			for(var i=0; i<checkeds.length; i++){
				if(checkedNodeParent && checkedNodeParent.length > i){
					resourceIdsTemp.push(checkedNodeParent[i].id);
				}
				resourceIdsTemp.push(checkeds[i].id);
			}

			$.ajax({
				url: '${ctx}/sysman/roleAction!addSaveRole.action',
				type: 'post',
				data: $("#addRoleForm").serialize()+"&resourceIds="+resourceIdsTemp.join(','),
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('role_datagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#addRoleDialog');
		}
		
		$(function(){
			getResourceTree();
		});
	</script>
</body>
</html>