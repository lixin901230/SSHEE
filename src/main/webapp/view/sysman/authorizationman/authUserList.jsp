<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>授权用户列表</title>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<%@ include file="../../common/head.jsp" %>
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
		var datagrid = null;
		function loadUserListDatagrid(){
			
			datagrid = $('#userList_dtagrid').datagrid({
// 				title:'用户信息列表',
			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/authAction!findAuthUsers.action',
			    fit: true,					//边框自适应
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
			    columns:[[
			        {field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'用户名',width:120,align:'center'},
			        {field:'role',title:'角色',width:140,align:'center'},
			        {field:'statu',title:'用户状态',align:'center',formatter:fmtShowUserState},
			        {field:'ation',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 1){
			        		return '系统用户';
			        	} else {
			        		var userId = row.id;
				        	return "<securl:accessRight rightId='authShow'><img onclick='showUserDetail(\""+userId+"\")' title='查看授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='authEdit'><img onclick='editUser(\""+userId+"\");' title='编辑授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='authRemove'><img onclick='deleteUser(\""+userId+"\");' title='移除授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";// +
				        			//"<securl:accessRight rightId='userManAuth'><img onclick='userAuthDialog(\""+userId+"\");' title='授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>";
			        	}		
			        }}
					
			    ]],
			    toolbar : '#user_datagrid_toolbar'
			});
		}
		
		//条件查询
		function userSearch(){
			datagrid.datagrid('load',serializeObject($("#authUser_searchForm")));
		}
		
		//添加用户信息
		function addAuthUser(){
			
			$("<div/>").attr("id","addAuthDialog").dialog({
				title: '新增授权',
				iconCls: 'menu_icon_user_man',
				href: '${ctx}/sysman/authAction!toAuthAddPage.action',   
				width: 802,//700,
				height: 470,
				closed: false,
				modal: true,
				resizable: false,
				collapsible: true,
				maximizable: false,
				buttons : [ {
					text : '授权',
					iconCls : 'icon-save',
					handler : function() {
						var d = $(this).closest('.window-body');
						$('#user_userInfo_form').form('submit', {
							url : '${pageContext.request.contextPath}/userController/modifyCurrentUserPwd.action',
							success : function(result) {
								try {
									var r = $.parseJSON(result);
									if (r.success) {
										d.dialog('destroy');
									}
									$.messager.show({
										title : '提示',
										msg : r.msg
									});
								} catch (e) {
									$.messager.alert('提示', result);
								}
							}
						});
					}
				},{
					text : '取消',
					iconCls : 'icon-cancel',
					handler : function() { 
						
					}
				}],
				onClose: function() {
					$(this).dialog('destroy');
				}
			});
		}
		
		//编辑用户信息
		function editUser(userId){
			
			if(!checkValue(userId)){
				
// 				var rows = $('#userList_dtagrid').datagrid('getChecked');
				var checked = getCheckeds();	//获取选中的checkbox
				
				if($(checked).size() == 0){
					$.messager.alert('警告','请选择一条用户信息进行修改','warning');
					return;
				}
				if($(checked).size().length > 1){
					$.messager.alert('警告','一次只能修改一条用户信息','warning');
					return;
				}
				userId = $(checked).val();
			}
			if(!checkValue(userId)){
				$.messager.alert('错误','数据有误，未能获取到要编辑的用户ID，请联系管理员！','error');
				return;
			}
			
			$("<div/>").attr("id","editUserDialog").dialog({
				title: '编辑用户信息',   
				href: '${ctx}/sysman/userAction!toEditUserPage.action?user.id='+userId,   
				width: 650,
				height: 350,
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
		function deleteUser(userId){

// 			var rows = $("#userList_dtagrid").datagrid("getChecked");
			var userIds = null; 
			var checkeds = getCheckeds();	//获取选中的checkbox
			if($(checkeds).size() > 0) {
				userIds = $(checkeds).serialize();
			} else {
				userIds = "id="+userId;
			}
// 			var ids = [];
			if($(checkeds).size() > 0 || userId){
				$.messager.confirm('请确认','确定删除该记录吗？',function(r){
					if(r){
						
						
// 						for(var i=0;i<rows.length;i++){
// 							ids.push(rows[i].id);
// 						}
						
						$.ajax({
							url: '${ctx}/sysman/userAction!deleteUser.action',
							data: userIds,
							type: "post",
							dataType: "json",
							cache: false,
							async: true,
							success: function(result){
								
								if(result.success){
									refreshDatagrid('userList_dtagrid');
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
		
		//用户授权
		function userAuthDialog(userId){
			
			cancelChecked('userList_dtagrid');//取消所有的选择项
			$("<div/>").attr("id","userAuthDialog").dialog({
				title: '用户授权',   
				href: '${ctx}/sysman/userAction!toUserAuthPage.action?user.id='+userId,   
				width: 720,
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
		
		//页面数据初始化
		$(function(){
			loadUserListDatagrid();
		});
	</script>
</head>
<body class="easyui-layout">
<!-- 	<div> -->
	<div region="north" class="tableForm datagrid-toolbar" border="false" title="筛选条件" style="height:59px;overflow: hidden;" align="left">
		<form id="authUser_searchForm" action="${ctx}/sysman/userAction!findUserList.action" method="post">
<!-- 			<fieldset> -->
<!-- 				<legend>筛选条件</legend> -->
				<table class="tableForm datagrid-toolbar search_table_form">
					<tbody>
						<tr>
							<td>搜 索</td>
							<td><input id="userName" name="userVo.userName" class="easyui-searchbox" style="width:300px"
								 onclick="userSearch();" data-options="prompt:'请输入查询内容...'"></input></td>
							<td>
						</tr>
						<!-- <tr>
							<td>创建时间</td>
							<td>
								<input name="userVo.createTimeStart" id="createTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />至
								<input name="userVo.createTimeEnd" id="createTimeEnd" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />
							</td>
						</tr>
						<tr>
							<td>最后修改时间</td>
							<td>
								<input name="userVo.lastUpdateTimeStart" id="lastUpdateTimeStart" style="width: 155px;height: 24px;" 
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>至
								<input name="userVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" style="width: 155px;height: 24px;"
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/> 
									
								<a href="#" class="easyui-linkbutton" onclick="userSearch();">过滤</a> 
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch('user_searchForms');">取消</a>
							</td>
						</tr> -->
					</tbody>
				</table>
<!-- 			</fieldset> -->
		</form>
	</div>
	<div region="center" border="false">
		<securl:accessRight rightId="authList">
			<table id="userList_dtagrid"></table>
		</securl:accessRight>
	</div>
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="user_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId="authAdd">
					<td><a href="#" onclick="addAuthUser();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">用户授权</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="authRemove">
					<td><a href="#" onclick="deleteUser();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">移除授权</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="authEdit">
					<td><a href="#" onclick="editUser();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userManImportTemplate">
					<td><a href="#" onclick="refreshDatagrid('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">下载导入模板（Excel）</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>

				<securl:accessRight rightId="authImport">
					<td><a href="#" onclick="refreshDatagrid('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="authExport">
					<td><a href="#" onclick="refreshDatagrid('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导出</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<td><a href="#" onclick="cancelChecked('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a></td>
				<td><div class=datagrid-btn-separator></div></td>
			</tr>
		</table>
	</div>
	
</body>
</html>