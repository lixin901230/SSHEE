<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加用户组信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
</head>
<body>

<%-- 	<form id="saveAddUserToUserGroup" name="saveAddUserToUserGroup" action="${ctx}/sysman/userGroupAction!saveAddUserToUserGroup.action" method="post"> --%>
		<table id="user_datagrid"></table>
<!-- 	</form>	 -->

	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<!-- <div id="dlg-buttons" align="left">
		<a href="#" onclick="addSaveUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
		<a href="#" onclick="closeDialog('#addUserToUserGroupDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
	</div> -->
	<div id="user_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId="userManAdd">
					<td><a href="#" onclick="addUserToUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">添加到用户组</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				<securl:accessRight rightId="userManDel">	
					<td><a href="#" onclick="closeDialog('#addUserToUserGroupDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
	
		//根据用户状态标记显示用户状态信息
		function fmtShowUserState(value,row,index){
	   		if(value){
	   			if(value == 0){			//注册后未通过注册邮箱激活
	   				return "未激活"; 	
	   			}else if(value == 1){	//注册完并通过注册邮箱激活
	   				return "已激活";
	   			}else if(value == 2){	//连续6次登录失败后用户被自动挂起，需要找管理员解锁
	   				return "挂起";	
	   			}else if(value == 3){	//用户被管理员禁用，需要管理员重新开启后方可使用
	   				return "禁用";
	   			}else {					//不用的账号，可以考虑加过期状态
	   				return "废弃";
	   			}
	   		}else {
	   			return value;
	   		}
		}
	
		//加载用户datagrid
		function loadUserDatagrid(){
			
			$('#user_datagrid').datagrid({
// 					title:'用户信息列表',
			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/userAction!findUserList.action',
			    fit: true,					//边框自适应
				border: false,
				rownumbers: true,			//True就会显示行号的列
				fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
				idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
				striped: true,				//奇偶行使用不同背景色
				checkOnSelect: false,		//行选择不映射到复选框
				selectOnCheck: false,		//复选框可以多选
				singleSelect: true,			//只允许选一行
				sortOrder: 'asc',
				nowrap: true,
				pagination: true,			//True就会在 datagrid 的底部显示分页栏。
				pageSize: 2,
// 				pageList: [ 10, 20, 30, 40, 50 ],
				pageList: [ 2, 4, 6, 8, 10 ],
			    columns:[[
			        {field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'用户名',width:120,align:'center'},
			        {field:'sex',title:'性别',width:40,align:'center'},
			        {field:'statu',title:'用户状态',align:'center',formatter:fmtShowUserState}
			    ]],
			    toolbar : '#user_datagrid_toolbar' /* #dlg-buttons[ {此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						addUser();
					}
				}, '-', {
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						deleteUser();
					}
				}, '-', {
					text : '刷新',
					iconCls : 'icon-reload',
					handler : function() {
						datagrid.treegrid('load');
					}
				}, '-', {
					text : '取消选中',
					iconCls : 'icon-undo',
					handler : function() {
						datagrid.treegrid('unselectAll');
					}
				}, '-' ] */
			});
		}
		
		//保存加入用户组的用户信息
		function addUserToUserGroup(){
			
			var userGroupId = $("#userGroupId").val();
			var rows = $('#user_datagrid').datagrid('getChecked');
			
			var userIds = [];
			for(var i=0; i<rows.length; i++){
				userIds.push(rows[i].id);
			}
			userIds = userIds.join(",");
			
			$.ajax({
				url: '${ctx}/sysman/userGroupAction!addUserToUserGroup.action',
				type: 'post',
				data: 'userGroupId='+userGroupId+'&userIds='+userIds,
				cache: false,
				async: true,
				success: function(data){
					refreshDatagrid('userGroupUser_datagrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#addUserToUserGroupDialog');
		}
	
		$(function(){
			loadUserDatagrid();
		});
	</script>
</body>
</html>