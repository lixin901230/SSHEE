<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>用户信息列表</title>
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
		
		//初始化进度条
		function initProgressbar(){
			var value = $('#p').progressbar('getValue');
			if (value < 100){
				value += Math.floor(Math.random() * 10);
				$('#p').progressbar('setValue', value);
				setTimeout(arguments.callee, 200);
			}
		};
		
		//遮罩层进度条
		function initDialogProgressBar(){
			$("#p").dialog({
				modal: true,
				closed: false,
				cache: false
			});
		}
	
		//加载用户datagrid
		var datagrid = null;
		function loadUserListDatagrid(){
			
			datagrid = $('#userList_dtagrid').datagrid({
// 				title:'用户信息列表',
			    iconCls:'icon-ok',
				//loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/userAction!findUserList.action',
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
				/*
				启动进度条
				onBeforeLoad: function(param){
					initProgressbar();
				},
				onLoadSuccess: function(data){
					$('#p').progressbar('setValue', 100);
				},*/
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
				        			"<securl:accessRight rightId='userManEdit'><img onclick='editUser(\""+userId+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManAuth'><img onclick='userAuthDialog(\""+userId+"\");' title='授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManDel'><img onclick='deleteUser(\""+userId+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
					
			    ]],
			    toolbar : '#user_datagrid_toolbar' /* [ {此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						addUser();
					}
				}, '-', {
					text : '编辑',
					iconCls : 'icon-edit',
					handler : function() {
						editUser();
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
		
		//条件查询
		function userSearch(){
			datagrid.datagrid('load',serializeObject($("#user_searchForm")));
		}
		
		//查看用户详细信息
		function showUserDetail(){
			
		}
		
		//添加用户信息
		function addUser(){
			
			$("<div/>").attr("id","addUserDialog").dialog({
				title: '添加用户信息',   
				href: '${ctx}/sysman/userAction!toAddUserPage.action',   
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
		
		//页面数据初始化
		$(function(){
			loadUserListDatagrid();
		});
	</script>
</head>
<body class="easyui-layout">
<!-- 	<div> -->
	<div region="north" class="tableForm datagrid-toolbar" border="false" title="筛选条件" style="height: 148px;overflow: hidden;" align="left">
		<form id="user_searchForm" action="${ctx}/sysman/userAction!findUserList.action" method="post">
			<fieldset style="border: none; border: 1px solid #cccccc;">
				<legend style="color: #888888;">筛选条件</legend>
				<!-- <table class="tableForm datagrid-toolbar search_table_form"> -->
				<table class="tableForm search_table_form">
					<tbody>
						<tr>
							<td>用户名</td>
							<td><input name="userVo.userName" id="userName" style="width:317px;" /></td>
						</tr>
						<tr>
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
<!-- 								<input name="userVo.lastUpdateTimeStart" id="lastUpdateTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;" />至
								<input name="userVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;" />  -->
								<input name="userVo.lastUpdateTimeStart" id="lastUpdateTimeStart" style="width: 155px;height: 24px;" 
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>至
								<input name="userVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" style="width: 155px;height: 24px;"
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/> 
									
								<a href="#" class="easyui-linkbutton" onclick="userSearch();">过滤</a> 
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch('user_searchForms');">取消</a>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</form>
	</div>
	<div region="center" border="false">
		<!-- 进度条div -->
		<!-- <div id="p" class="easyui-progressbar" data-options="value:0" style="width:400px;"></div> -->
		<table id="userList_dtagrid"></table>
	</div>
	
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="user_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId="userManAdd">
					<td><a href="#" onclick="addUser();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">增加</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="userManEdit">
					<td><a href="#" onclick="editUser();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userManDel">	
					<td><a href="#" onclick="deleteUser();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userManImportTemplate">
					<td><a href="#" onclick="refreshDatagrid('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">下载导入模板（Excel）</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	

				<securl:accessRight rightId="userManImport">
					<td><a href="#" onclick="refreshDatagrid('userList_dtagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userManExport">
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