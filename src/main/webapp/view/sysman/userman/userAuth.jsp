<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../../common/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户授权</title>
</head>
<body style="margin: 0px 0px;">
	<div style="width: 100%;height: 100%;">
		<form action="" id="userAuthForm" method="post">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th rowspan="4">根据角色授权（推荐）</th>
					<!-- <td align="left"></td> -->
				</tr>
				<c:forEach var="r" items="${roles}">
					<tr>
						<td align="left">
							<input type="checkbox" onclick="changeTreeByRole();" id="role_${r.id}" name="roleIds" value="${r.id}"
								<c:forEach var="role" items="${rolesTemp}"><c:if test="${role.id == r.id}">checked="checked"</c:if></c:forEach>/>
							<label for="role_${r.id}">${r.roleName}</label>
						</td>
					</tr>
				</c:forEach>
			</table>
			<br/>
			<table class="data_table" style="width: 100%;">
				<thead>
					<tr>
						<th>根据资源授权（不推荐）</th>
						<th>用户已拥有权限</th>
					</tr>
				</thead>
				<tbody>	
					<tr>
						<td style="vertical-align: top;">
							<div style="border-bottom: 1px solid #dddddd;height: 20px;vertical-align: middle;padding-top: 0px;padding-left: 15px;">
								<label class="icon-remove" title="展开" onclick="expandTree('#auth_resource_tree', '#view_resource_tree');">&nbsp;&nbsp;&nbsp;</label>&nbsp;&nbsp;
								<label class="icon-add" title="折叠" onclick="collapseTree('#auth_resource_tree', '#view_resource_tree');">&nbsp;&nbsp;&nbsp;</label>
								<label class="icon-reload" title="刷新" onclick="reloadTree('#auth_resource_tree');">&nbsp;&nbsp;&nbsp;</label>
							</div>	
							<ul id="auth_resource_tree"></ul>
						</td>
						<td style="vertical-align: top;">
							<div style="border-bottom: 1px solid #dddddd;height: 20px;vertical-align: middle;padding-top: 0px;padding-left: 15px;">
								<label class="icon-remove" title="展开" onclick="expandTree('#view_resource_tree', '#auth_resource_tree');">&nbsp;&nbsp;&nbsp;</label>&nbsp;&nbsp;
								<label class="icon-add" title="折叠" onclick="collapseTree('#view_resource_tree', '#auth_resource_tree');">&nbsp;&nbsp;&nbsp;</label>
								<label class="icon-reload" title="刷新" onclick="reloadTree('#view_resource_tree');">&nbsp;&nbsp;&nbsp;</label>
							</div>	
							<ul id="view_resource_tree"></ul>
						</td>
					</tr>
				</tbody>	
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 5px;padding-top: 5px;">
				<a href="javascript:void(0)" onclick="saveAuth();return false;" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" onclick="closeDialog('#userAuthDialog');return false;" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	
		//加载资源树数据
		function getResourceTree(resource_tree, param){
			
			$(resource_tree).tree({
				iconCls: 'icon-save',
				url: '${ctx}/sysman/resourceAction!getAllTeeNode.action',
				id: 'id',
				text:'text',
				parentField: 'parentId',
				state: 'closed',
				lines: true,
				checkbox: true,
				animate: true,
				onLoadSuccess: function(node, data){
				
					//根据用户id获取该用户所对应的角色拥有的访问资源,并匹配树节点默认选中节点
					$.ajax({
						url:"${ctx}/sysman/userAction!loadResourcesJsonByRoleId.action",
						data: param,
						dataType:"json",
						success:function($data){
							
							if($data){
								$($data).each(function(i, obj){
									//授权树：处理根据资源授权树
									var n = $(resource_tree).tree('find',obj.id);
									if(n){
										if(obj.state){//判断该节点是否为父节点，如果为父节点则不选中，需要根据子节点全选后级联选中
											return true;
										}
										$(resource_tree).tree('check',n.target);
									}
								});
							}
						},
						error:function(){
							$.messager.alert('错误','发送请求失败','error');
						}
					});
					
					if(resource_tree == '#view_resource_tree'){
						$.ajax({
							url: '${ctx}/sysman/resourceAction!getAllTeeNode.action',
							dataType:"json",
							success:function(_$data){
								if(_$data){
									$(_$data).each(function(i, obj){
										$('#view_resource_tree').tree('disableCheck',obj.id);
									});
								}
							},
							error:function(){
								$.messager.alert('错误','发送请求失败','error');
							}
						});
					}
				},
				onLoadError: function(){
					$.messager.alert('错误','加载数据出错','error');
				}
			});
		}
		
		//在[根据角色授权]时，改变角色的选项时，重载[根据资源授权]树，默认选中当前角色允许访问的资源
		function changeTreeByRole(){
			
			var checkedRoles = $("input[name='roleIds']:checked");
			if(checkedRoles && $(checkedRoles).size() > 0){	//如果有选中的角色，则根据该角色更新tree
				
				getResourceTree("#auth_resource_tree", $(checkedRoles).serialize());
			} else {	//没有选中的角色，则情况授权树中的复选框的选项
				
				var rootNode = $("#auth_resource_tree").tree("getRoot");
				$("#auth_resource_tree").tree('uncheck',rootNode.target);
			}
		}
		
		//禁用tree的checkbox，不让修改
		function disableTreeCheckbox(treeSelector){
			/* var treeNodeDatas = null;
			$(treeNodeDatas).each(function(i, obj){
				$(treeSelector).tree('disableCheck',obj.id);
			}); */
			
			$(treeSelector).tree('getRoots',function(none){
				alert(none);
			});
		}
		
		//保存用户授权
		function saveAuth(){
			
			$.messager.confirm('提示','确定保存当前授权信息吗？',function(r){
				
				var roleIdsTemp = [];
				var roleCheckeds = $("input[name='roleIds']:checked");
				$(roleCheckeds).each(function(i, obj){
					var checkedVal = $(this).val();
					roleIdsTemp.push(checkedVal);
				});
				
				var resourceIdsTemp = [];
				var checkeds = $("#auth_resource_tree").tree("getChecked");//获取所有选中的复选框
				for(var i=0; i<checkeds.length; i++){
					resourceIdsTemp.push(checkeds[i].id);
				}
				
				$.ajax({
					url: '${ctx}/sysman/userAction!saveUserAuth.action',
					type: 'post',
					data: {
						id: "${user.id}",
						roleIds: roleIdsTemp.join(','),
						resourceIds: resourceIdsTemp.join(',')
					},
					dataType: 'json',
					cache: false,
					async: false,
					success: function(data){
						refreshDatagrid('userList_dtagrid');
						$.messager.confirm('选择', '授权成功，是否关闭[用户授权]窗口？', function(r){
							if(r){
								closeDialog('#userAuthDialog');	
							}
						});
					},
					error: function(){$.messager.alert('错误','发送请求失败','error');}
				});
			});
			
			
		}
		
		
		//重新加载树
		function reloadTree(){
			initTree();
		}
		
		//初始化树
		function initTree(){
			getResourceTree("#auth_resource_tree", "user.id=${user.id}");
			getResourceTree("#view_resource_tree", "user.id=${user.id}");
			clickNodeTextChecked("#auth_resource_tree");
// 			disableTreeCheckbox('#view_resource_tree');
		}
		
		$(function(){
			initTree();
		});
	</script>
</body>
</html>