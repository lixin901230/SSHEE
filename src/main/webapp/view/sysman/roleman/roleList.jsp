<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色信息列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<%@ include file="../../common/head.jsp" %>
<script type="text/javascript">

	function fmtShowRoleType(value, row, index){
		if(value == 1){
			return "超级管理员";
		} else if(value == 2){
			return "系统管理员";
		}else if(value == 3){
			return "普通用户";
		} else{
			return "角色类型数据有误";
		}
	}

	//格式化显示角色状态
	function fmtShowRoleState(value, row, index){
		
		if(value == 0){
			return "禁用";
		} else if(value == 1){
			return "启用";
		} else{
			return "角色状态数据有误";
		}
	}
	
	//加載角色信息数据列表
	var datagrid = null;
	function loadRoleDatagrid(){
		
		datagrid = $("#role_datagrid").datagrid({
			iconCls:'icon-ok',
			loadMsg:'数据加载中...',
		    url:'${ctx}/sysman/roleAction!findRoleList.action',
		    fit: true,					//边框自适应
			border: false,
			remoteSort: true,			//定义是否从服务器给数据排序
			pagination: true,			//True就会在 datagrid 的底部显示分页栏。
			rownumbers: true,			//True就会显示行号的列
			fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
			idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
			striped: true,				//奇偶行使用不同背景色
			checkOnSelect : false,		//行选择不映射到复选框
			selectOnCheck : false,		//复选框可以多选
			singleSelect : true,		//之允许选一行
			pageSize: 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortOrder : 'asc',
			nowrap : true, 
		    columns:[[   
		        {field:'id',title:'编号',width:50,align:'center',checkbox:true},   
		        {field:'roleName',title:'角色名称',width:150,align:'center'},   
		        {field:'roleType',title:'角色类型',width:150,align:'center',formatter:fmtShowRoleType},   
		        {field:'createTime',title:'创建时间',width:180,align:'center',sortable:true,formatter:fmtShowDate},   
		        {field:'state',title:'状态',width:150,align:'center',formatter:fmtShowRoleState},   
		        {field:'remark',title:'备注',align:'left'},
		        {field:'action',title:'操作',width:100,align:'center',formatter: function(value,row,index){
// 		        	var id = "id="+row.id;
					var showAction = "<securl:accessRight rightId='roleManDetail'><img onclick='showRoleDetail(\""+row.id+"\");' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>";
					var editAction = "<securl:accessRight rightId='roleManEdit'><img onclick='editRole(\""+row.id+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>";
					if(row.roleType==1){	//超级管理员角色的权限
						return showAction + editAction;
					}
		        	return showAction + editAction +
		        			"<securl:accessRight rightId='roleManDel'><img onclick='deleteRole(\""+row.id+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
		        }}  
		    ]],
		    toolbar : "#role_datagrid_toolbar"/* [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					addRole();
				}
			}, '-', {
				text : '编辑',
				iconCls : 'icon-edit',
				handler : function() {
					//edit();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					//remove();
				}
			}, '-', {
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					//treegrid.treegrid('load');
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					//treegrid.treegrid('unselectAll');
				}
			}, '-' ] */
		});
	}
	
	//查看角色信息
	function showRoleDetail(){
		
	}
	
	//添加角色信息
	function addRole(){
		
		cancelChecked('role_datagrid');//取消所有的选择项
		$("<div/>").attr("id","addRoleDialog").dialog({
			title: '添加角色信息',   
// 			href: '${ctx}/view/sysman/roleman/roleAdd.jsp',   
			href: '${ctx}/sysman/roleAction!toAddRolePage.action',   
			width: 700,
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
	
	//编辑角色信息
	function editRole(id){
		
		if(id == null || id == "" || id == "undefined"){//如果id存在，说明为列表内操作列的操作传值
			id = getCheckeds();	//获取选中的复选框
			if(!id || $(id).size() < 1 || $(id).size() > 1){
				$.messager.alert('提示','请勾选一条记录','warning');
				return false;
			}
			id = $(id).val();
		}
		id = "role.id="+id;
		
		$("<div/>").attr("id","editRoleDialog").dialog({
			title: '编辑角色信息',   
// 			href: '${ctx}/sysman/roleman/roleEdit.jsp',   
			href: '${ctx}/sysman/roleAction!getEditRole.action?'+id,   
			width: 700,
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
	
	//删除用户信息
	function deleteRole(roleId){

		var roleIds = null; 
		var checkeds = getCheckeds();	//获取选中的checkbox
		if($(checkeds).size() > 0) {
			roleIds = $(checkeds).serialize();
		} else {
			roleIds = "id="+roleId;
		}
		
//			var ids = [];
		if($(checkeds).size() > 0 || roleId){
			$.messager.confirm('请确认','确定删除该记录吗？',function(r){
				if(r){
//						for(var i=0;i<rows.length;i++){
//							ids.push(rows[i].id);
//						}
					
					$.ajax({
						url: '${ctx}/sysman/roleAction!deleteRole.action',
						data: roleIds,
						type: "post",
						dataType: "json",
						cache: false,
						async: true,
						success: function(result){
							
							if(result.success){
								refreshDatagrid('role_datagrid');
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
	
	//条件查询
	function roleSearch(url){
		datagrid.datagrid('load',serializeObject($("#role_searchForm")));
	}
	
	$(function(){
		loadRoleDatagrid();
	});
</script>
</head>
<body class="easyui-layout">
	<div region="north" class="tableForm datagrid-toolbar" border="false" title="筛选条件" style="height: 124px;overflow: hidden;" align="left">
		<form id="role_searchForm" action="${ctx}/sysman/roleAction!findRoleList.action" method="post">
			<fieldset style="border: none; border: 1px solid #cccccc;">
				<legend style="color: #888888;">筛选条件</legend>
				<table class="tableForm search_table_form">
				<!-- <table class="tableForm datagrid-toolbar search_table_form"> -->
					<tbody>
						<tr>
							<td>角色名称</td>
							<td><input name="roleVo.roleName" id="roleName" style="width:317px;" /></td>
						</tr>
						<tr>
							<td>创建时间</td>
							<td><input name="roleVo.createTimeStart" id="createTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />至
								<input name="roleVo.createTimeEnd" id="createTimeEnd" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />
								<a href="#" class="easyui-linkbutton" onclick="roleSearch('${ctx}/sysman/roleAction!findUserList.action');">过滤</a> 
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch('role_searchForm');">取消</a>
							</td>
						</tr>
						<%-- <tr>
							<th>最后修改时间</th>
							<td>
								<input name="roleVo.lastUpdateTimeStart" id="lastUpdateTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;" />至
								<input name="roleVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" class="easyui-datetimebox" 
									
								<a href="#" class="easyui-linkbutton" onclick="roleSearch('${ctx}/sysman/roleAction!findUserList.action');">过滤</a> 
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch();">取消</a>
							</td>
						</tr> --%>
					</tbody>
				</table>
			</fieldset>
		</form>
	</div>
	<div region="center" border="false">
		<table id="role_datagrid"></table>
	</div>
	
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="role_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId='roleManAdd'>
					<td><a href="#" onclick="addRole();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">增加</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	
				
				<securl:accessRight rightId='roleManEdit'>
					<td><a href="#" onclick="editRole();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	
				
				<securl:accessRight rightId='roleManDel'>
					<td><a href="#" onclick="deleteRole();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	
				<!-- <td>		
					<a href="#" onclick="refreshDatagrid();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
				</td>
				<td><div class=datagrid-btn-separator></div></td> -->
<%-- 				<securl:accessRight rightId='roleManDel'> --%>
				<td>		
					<a href="#" onclick="cancelChecked('role_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a>
				</td>
				<td><div class=datagrid-btn-separator></div></td>
<%-- 				</securl:accessRight> --%>
			</tr>
		</table>
	</div>
</body>
</html>