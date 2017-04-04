<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户组列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
	<script type="text/javascript">
	
		//根据用户组状态标记显示用户组状态信息
		function fmtShowUserGroupState(value,row,index){
       		if(value){			
       			if(value == 0){
       				return "禁用";
       			}else if(value == 1){
       				return "启用";
       			}
       		} else {
       			return value;
       		}
		}
		
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
		
		//加载用户组下的用户datagrid
		var datagrid = null;
		function loadUserDatagrid(){
			
			datagrid = $('#userGroupUser_datagrid').datagrid({
// 				title:'用户组信息列表',
// 			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/userGroupAction!findUserListByUserGroupId.action?userGroup.id=${userGroup.id}',
			    fit: false,					//边框自适应
				border: false,
// 				remoteSort: true,			//定义是否从服务器给数据排序
				rownumbers: true,			//True就会显示行号的列
				fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
// 				idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
				striped: true,				//奇偶行使用不同背景色
				checkOnSelect: false,		//行选择不映射到复选框
				selectOnCheck: false,		//复选框可以多选
				singleSelect: true,			//只允许选一行
				sortOrder: 'asc',
				nowrap: true,
				pagination: true,			//True就会在 datagrid 的底部显示分页栏。
				pageSize: 10,
				pageList: [ 10, 20, 30, 40, 50 ],
// 				pageList: [ 2, 4, 6, 8, 10 ],
			    columns:[[
			        {field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'用户名',width:120,align:'center'},
// 			        {field:'user.roleList[0].roleName',title:'角色',width:120,align:'center'},
			        {field:'sex',title:'性别',width:40,align:'center'},
			        {field:'telphone',title:'手机',width:80,align:'center'},
			        {field:'email',title:'邮箱',width:140,align:'center'},
			        {field:'statu',title:'用户状态',align:'center',formatter:fmtShowUserState},
			        {field:'createTime',title:'创建日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
			        {field:'lastUpdateTime',title:'最近修改日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
// 			        {field:'remark',title:'备注',align:'left'}
			        {field:'ation',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 1){
			        		return '系统用户';
			        	} else {
			        		var userId = row.id;
				        	return "<securl:accessRight rightId='userManDetail'><img onclick='showUserDetail(\""+userId+"\")' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
// 				        			"<securl:accessRight rightId='userManEdit'><img onclick='editUser(\""+userId+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
// 				        			"<securl:accessRight rightId='userManAuth'><img onclick='userAuthDialog(\""+userId+"\");' title='授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManDel'><img onclick='removeUser(\""+userId+"\");' title='移出' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
			    ]],
			    toolbar : '#userGroup_datagrid_toolbar,#search_form' //此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
			});
		}
		
		//条件查询
		function userGroupSearch(){
			datagrid.datagrid('load',serializeObject($("#userGroup_searchForm")));
		}
		
		//添加用户到用户组
		function addUserToUserGroup(){
			
			$("<div/>").attr("id","addUserToUserGroupDialog").dialog({
				title: '添加用户到用户组',   
				href: '${ctx}/sysman/userGroupAction!toAddUserToUserGroupPage.action',   
				width: 650,
				height: 400,
				closed: false,
				modal: true,
				resizable: true,
				collapsible: true,
				maximizable: true,
				onClose: function() {
					$(this).dialog('destroy');
				}
			});
		}
		
		//删除用户组信息
		function deleteUserGroup(userGroupId){

// 			var rows = $("#userList_dtagrid").datagrid("getChecked");
			var userGroupIds = null; 
			var checkeds = getCheckeds();	//获取选中的checkbox
			if($(checkeds).size() > 0) {
				userGroupIds = $(checkeds).serialize();
			} else {
				userGroupIds = "id="+userGroupId;
			}
// 			var ids = [];
			if($(checkeds).size() > 0 || userGroupId){
				$.messager.confirm('请确认','确定删除该记录吗？',function(r){
					if(r){
						
// 						for(var i=0;i<rows.length;i++){
// 							ids.push(rows[i].id);
// 						}
						
						$.ajax({
							url: '${ctx}/sysman/userGroupAction!deleteUserGroup.action',
							data: userGroupIds,
							type: "post",
							dataType: "json",
							cache: false,
							async: true,
							success: function(result){
								
								if(result.success){
									refreshDatagrid('userGroupUser_datagrid');
								}
								$.messager.show({
									title: '提示',
									msg: result.msg
								});
							},
							error:function(){
								$.messager.show({
									title: '提示',
									msg: '发送请求失败',
									timeout: 3000,
									showType: 'slide',
									style: {
										right: '',
										top: parent.document.body.scrollTop + parent.document.documentElement.scrollTop,
										bottom: ''
									}
								});
							}
						});
					}
				});
			} else {
				$.messager.show({
					title: '提示',
					msg: '请勾选要删除的记录',
					timeout: 3000,
					showType: 'slide',
					style: {
						right: '',
						top: document.body.scrollTop + document.documentElement.scrollTop,
						bottom: ''
					}
				});
			}
		}
		
		//页面数据初始化
		$(function(){
			loadUserDatagrid();
		});
	</script>
</head>
<body>
	<div title="用户组详细信息" class="easyui-panel" data-options="iconCls:'menu_icon_user_group_man',collapsible:true">
		<div class="form_table_div">
			<input type="hidden" id="userGroupId" value="${userGroup.id}"/>
	    	<table class="form_table">
	    		<tr>
	    			<th>用户组名</th>
	    			<td>${userGroup.groupName }</td>
	    			<th>状态</th>
	    			<td>
	    				<c:if test="${userGroup.statu == 1}">启用</c:if>
	    				<c:if test="${userGroup.statu == 0}">禁用</c:if>
	    			</td>
	    		</tr>
	    		<tr>
	    			<th>创建时间</th>
	    			<td><fmt:formatDate value="${userGroup.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	    			<th>最近修改时间</th>
	    			<td><fmt:formatDate value="${userGroup.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	    		</tr>
	    		<tr>
	    			<th>备注</th>
	    			<td colspan="3">${userGroup.remark}</td>
	    		</tr>
	    	</table>
	    </div>
	    <!-- <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">Submit</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">Clear</a>
	    </div> -->
	</div>
	
	<div style="text-align:center;padding:5px">
    	<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">Submit</a> -->
    	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="changeTabIframeUrl('layout_center_tabs', null, '${ctx}/sysman/userGroupAction!toUserGroupListPage.action');" title="点击返回用户组列表">返回</a>
    </div>
    
<!--     <br/> -->
	<div class="easyui-panel" title="用户组中的用户" data-options="iconCls:'menu_icon_user_man',collapsible:true" style="height:auto;"><!-- 399px -->
		<div region="center" border="false">
			<table id="userGroupUser_datagrid"></table>
		</div>
	</div>
	
	
	<!-- 搜索表单和工具栏 -->
	
	<div id="search_form">
		<form id="userGroup_searchForm" action="${ctx}/sysman/userGroupAction!findUserGroupList.action" method="post">
			<table class="tableForm datagrid-toolbar search_table_form">
				<tbody>
					<tr>
						<td>组织机构名</td>
						<td><input id="userName" name="userGroup.groupName" class="easyui-searchbox" style="width:300px"
							data-options="prompt:'请输入查询内容...'"></input></td>
				</tbody>
			</table>
		</form>
	</div>
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="userGroup_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="orgInfoSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">条件查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="cancelSearch('userGroup_searchForms');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">清空查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupAdd">
					<td><a href="#" onclick="addUserToUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">加入用户</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="userGroupDel">	
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
	
</body>
</html>