<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编辑角色信息</title>
	<%@ include file="../../common/head.jsp" %>
</head>
<body style="margin: 0px 0px;">
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form action="" id="editRoleForm" method="post">
			
			<input type="hidden" name="role.id" id="id" value="${role.id}"/>
		
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>角色名</th>
					<td><input type="text" id="roleName" name="role.roleName" value="${role.roleName }"/></td>
					<th>角色类型</th>
					<td>
						<select name="role.roleType" id="roleType">
							<option value="1" <c:if test="${role.roleType == 1}">selected="selected"</c:if>>超级管理员</option>
							<option value="2" <c:if test="${role.roleType == 2}">selected="selected"</c:if>>系统管理员</option>
							<option value="3" <c:if test="${role.roleType == 3}">selected="selected"</c:if>>普通用户</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td>
						<input name="role.createTime" id="createTime" style="width: 155px;" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${role.createTime}"></fmt:formatDate>"
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>
					</td>
					<th>状&nbsp;&nbsp;态</th>
					<td>
						<select name="role.state" id="state">
							<option value="1" <c:if test='${role.state == 1}'>selected="selected"</c:if>>启用</option>
							<option value="0" <c:if test='${role.state == 0}'>selected="selected"</c:if>>禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>备&nbsp;&nbsp;注</th>
					<td colspan="3"><textarea name="role.remark" cols="62" rows="3">${role.remark}</textarea></td>
				</tr>
			</table>
			<br/>
			<table class="form_table" style="width: 100%;">
				<th style="vertical-align: top;padding-right: 5px;padding-top: 5p;">角色允许访问的资源</th>
				<td colspan="3">
					<ul id="resource_tree"></ul>
				</td>
			</table>
			<div id="role_buttons" align="center" style="padding-bottom: 5px;padding-top: 5px;">
				<a href="#" onclick="editSaveRole();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="#" onclick="closeDialog('#editRoleDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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
				parentField: 'parentId',
// 				state: 'closed',
				lines: true,
				checkbox: true,
				animate: true,
				onLoadSuccess: function(node, data){
					
					//根据角色id获取该角色拥有的访问资源,并匹配树节点默认选中节点
					$.ajax({
						url: "${ctx}/sysman/userAction!loadResourcesJsonByRoleId.action?role.id=${role.id}",
						dataType: "json",
						cache: false,
						async: true,
						success:function(exitResource){
							
							if(exitResource){
								$(exitResource).each(function(i, obj){
									
									var n = $("#resource_tree").tree('find',obj.id);
									if(n){
										if(n.state){//判断该节点是否为父节点，如果为父节点则不选中，需要根据子节点全选后级联选中
											return true;
										}
										$("#resource_tree").tree('check',n.target);	//选中节点
									}
								});
							}
						},
						error:function(){alert("发送请求失败");}
					});
				}
			});
			
			//给节点绑定点击事件，当点击节点的时候选中复选框
			clickNodeTextChecked("#resource_tree");
		}
		
		//编辑保存角色信息
		function editSaveRole(){

			var resourceIdsTemp = [];
			var checkeds = $("#resource_tree").tree("getChecked");//获取所有选中的复选框
			var checkedNodeParent = $('#resource_tree').tree('getChecked', 'indeterminate');//获取选中节点的父节点（父节点为半选中状态，即其子节点不是全部选中）
			for(var i=0; i<checkeds.length; i++){
				if(checkedNodeParent && checkedNodeParent.length > i){
					resourceIdsTemp.push(checkedNodeParent[i].id);
				}
				resourceIdsTemp.push(checkeds[i].id);
			}
			
			$.ajax({
				url: '${ctx}/sysman/roleAction!editSaveRole.action',
				type: 'post',
				data: $("#editRoleForm").serialize()+"&resourceIds="+resourceIdsTemp.join(','),
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('role_datagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#editRoleDialog');
		}
		
		$(function(){
			getResourceTree();
		});
	</script>
</body>
</html>