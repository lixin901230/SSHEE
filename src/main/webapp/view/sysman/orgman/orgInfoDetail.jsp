<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>组织机构列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
</head>
<body>
	
	<!-- 组织机构详细信息 -->
<!-- 	<div style="height: 105px;"> -->
		<div class="easyui-panel" title="组织机构详细信息" data-options="fit:false,iconCls:'menu_icon_org_man',collapsible:true,border:true">
			<div class="form_table_div">
				<input type="hidden" id="id" name=orgInfo.id value="${orgInfo.id}"/>
		    	<table class="form_table">
		    		<tr>
		    			<th>用户组名</th>
		    			<td>${orgInfo.orgName }</td>
		    			<th>状态</th>
		    			<td>
		    				<c:if test="${orgInfo.statu == 1}">启用</c:if>
		    				<c:if test="${orgInfo.statu == 0}">禁用</c:if>
		    			</td>
		    		</tr>
		    		<tr>
		    			<th>创建时间</th>
		    			<td><fmt:formatDate value="${orgInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		    			<th>最近修改时间</th>
		    			<td><fmt:formatDate value="${orgInfo.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		    		</tr>
		    		<tr>
		    			<th>备注</th>
		    			<td colspan="3">${orgInfo.remark}</td>
		    		</tr>
		    	</table>
		    </div>
		</div>
<!-- 	</div> -->
	
	<div style="text-align:center;padding:5px">
    	<a href="#" class="easyui-linkbutton" data-options="iconCls:''" onclick="goBack();" title="点击返回组织机构列表">返回</a>
    	<a href="#" class="easyui-linkbutton" data-options="iconCls:''" onclick="changeTabIframeUrl('layout_center_tabs', null, '${ctx}/sysman/orgInfoAction!toUserGroupListPage.action');" title="点击编辑机构信息">编辑</a>
    </div>
	
	<div style="height: 332px;">
		<div class="easyui-panel" title="组织机构人员列表" data-options="fit:true,iconCls:'menu_icon_user_man',collapsible:true,border:true" style="height: 308px;">
			<table id="orgUser_datagrid"></table>
		</div>
	</div>
	
	<div id="search_form">
		<form id="orgInfo_searchForm" action="${ctx}/sysman/userGroupAction!findUserGroupList.action" method="post">
			<table class="tableForm datagrid-toolbar search_table_form">
				<tbody>
					<tr>
						<td>用户名</td>
						<td><input id="userName" name="userGroup.groupName" class="easyui-searchbox" style="width:300px"
							data-options="prompt:'请输入查询内容...'"></input></td>
				</tbody>
			</table>
		</form>
	</div>
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="orgInfo_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<%-- <securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="orgInfoSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">条件查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="cancelSearch('userGroup_searchForms');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">清空查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight> --%>
				
				<securl:accessRight rightId="orgInfoAddUser">
					<td><a href="#" onclick="addUserToUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">加入用户</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="orgInfoRemoveUser">	
					<td><a href="#" onclick="deleteUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">移除用户</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupImport">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupExport">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导出</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<td><a href="#" onclick="cancelChecked('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a></td>
				<td><div class=datagrid-btn-separator></div></td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
	
		//加载机构详细信息和机构用户
		function loadOrgUsers(orgId){
// 			alert(orgId);
			$('#orgUser_datagrid').datagrid({
	//			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/orgInfoAction!findOrgUsers.action?orgInfo.id='+orgId,
			    fit: true,					//边框自适应
				border: false,
				rownumbers: true,			//True就会显示行号的列
				fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
	//	 				idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
				striped: true,				//奇偶行使用不同背景色
				checkOnSelect: false,		//行选择不映射到复选框
				selectOnCheck: false,		//复选框可以多选
				singleSelect: true,			//只允许选一行
				sortOrder: 'asc',
				nowrap: true,
				pagination: true,			//True就会在 datagrid 的底部显示分页栏。
				pageSize: 10,
				pageList: [ 10, 20, 30, 40, 50 ],
				columns:[[
			    	{field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'用户名',width:120,align:'center'},
	//		 			        {field:'user.roleList[0].roleName',title:'角色',width:120,align:'center'},
			        {field:'sex',title:'性别',width:40,align:'center'},
			        {field:'telphone',title:'手机',width:80,align:'center'},
			        {field:'email',title:'邮箱',width:140,align:'center'},
			        {field:'statu',title:'用户状态',align:'center',formatter:fmtShowUserState},
			        {field:'createTime',title:'创建日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
			        {field:'lastUpdateTime',title:'最近修改日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
			        {field:'ation',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 1){
			        		return '系统用户';
			        	} else {
			        		var userId = row.id;
				        	return "<securl:accessRight rightId='userManDetail'><img onclick='showUserDetail(\""+userId+"\")' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
	//		 				        			"<securl:accessRight rightId='userManEdit'><img onclick='editUser(\""+userId+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
	//		 				        			"<securl:accessRight rightId='userManAuth'><img onclick='userAuthDialog(\""+userId+"\");' title='授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManDel'><img onclick='removeUser(\""+userId+"\");' title='移出' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
			    ]],
			    toolbar : '#orgInfo_datagrid_toolbar,#search_form' //此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
			});
		}
		
		function goBack(){
			$('#orgInfo_layout').layout('panel','center').panel({title: '组织机构树列表',border:true,href:'${ctx}/view/sysman/orgman/orgTreeGrid.jsp'});
		}
		
		
		//页面数据初始化
		$(function(){
			loadOrgUsers('1');
		});
	</script>
</body>
</html>