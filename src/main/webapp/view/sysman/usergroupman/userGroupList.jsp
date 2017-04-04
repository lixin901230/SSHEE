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
		
		function fmtShowUsers(value,row,index){
			
		}
		
		//加载用户组datagrid
		var datagrid = null;
		function loadUserGroupListDatagrid(){
			
			datagrid = $('#userGroup_datagrid').datagrid({
// 				title:'用户组信息列表',
			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/userGroupAction!findUserGroupList.action',
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
				onDblClickRow: toShowUserGroupDetail,
			    columns:[[
			        {field:'id',title:'用户组编码',align:'center',checkbox:true},
			        {field:'groupName',title:'用户组名',width:120,align:'center'},
// 			        {field:'users',title:'用户',width:120,align:'center',formatter:fmtShowUsers},
			        {field:'statu',title:'状态',align:'center',formatter:fmtShowUserGroupState},
			        {field:'createTime',title:'创建日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
			        {field:'lastUpdateTime',title:'最近修改日期',width:150,sortable:true,align:'center',formatter:fmtShowDate},
// 			        {field:'remark',title:'备注',align:'left'}
			        {field:'ation',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 1){
			        		return '系统用户';
			        	} else {
			        		var userGroupId = row.id;
				        	return "<securl:accessRight rightId='userGroupDetail'><img onclick='showUserGroupDetail(\""+userGroupId+"\");' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userGroupEdit'><img onclick='editUserGroup(\""+userGroupId+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userGroupAddUser'><img onclick='userGroupAuthDialog(\""+userGroupId+"\");' title='用户组加入用户' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userGroupDel'><img onclick='deleteUserGroup(\""+userGroupId+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
					
			    ]],
			    toolbar : '#userGroup_datagrid_toolbar' /* [ {此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						addUserGroup();
					}
				}, '-', {
					text : '编辑',
					iconCls : 'icon-edit',
					handler : function() {
						editUserGroup();
					}
				}, '-', {
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						deleteUserGroup();
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
		function userGroupSearch(){
			datagrid.datagrid('load',serializeObject($("#userGroup_searchForm")));
		}
		
		function toShowUserGroupDetail(rowIndex, rowData){
			showUserGroupDetail(rowData.id);	
		}
		
		//查看用户组详细信息
		function showUserGroupDetail(groupId){
			
			var selectedTabs = parent.$("#layout_center_tabs").tabs('getSelected');// 获取选中的 tab panel 和它的 tab 对象
			var tab = selectedTabs.panel('options');    // 对应的tab对象属性
			var iframeUrl = '${ctx}/sysman/userGroupAction!showUserGroupDetail.action?userGroup.id='+groupId;
			
			changeTabIframeUrl("layout_center_tabs", tab.title, iframeUrl);
		}
		
		//添加用户组信息
		function addUserGroup(){
			
			$("<div/>").attr("id","addUserGroupDialog").dialog({
				title: '添加用户组信息',   
				href: '${ctx}/sysman/userGroupAction!toAddUserGroupPage.action',   
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
		
		//编辑用户组信息
		function editUserGroup(userGroupId){
			
			if(!checkValue(userGroupId)){
				
// 				var rows = $('#userList_dtagrid').datagrid('getChecked');
				var checked = getCheckeds();	//获取选中的checkbox
				
				if($(checked).size() == 0){
					$.messager.alert('警告','请选择一条用户组信息进行修改','warning');
					return;
				}
				if($(checked).size().length > 1){
					$.messager.alert('警告','一次只能修改一条用户组信息','warning');
					return;
				}
				userGroupId = $(checked).val();
			}
			if(!checkValue(userGroupId)){
				$.messager.alert('错误','数据有误，未能获取到要编辑的用户组ID，请联系管理员！','error');
				return;
			}
			
			$("<div/>").attr("id","editUserGroupDialog").dialog({
				title: '编辑用户组信息',   
				href: '${ctx}/sysman/userGroupAction!toEditUserGroupPage.action?userGroup.id='+userGroupId,   
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
									refreshDatagrid('userGroup_datagrid');
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
		
		//用户组授权
		function userGroupAuthDialog(userGroupId){
			
			cancelChecked('userGroup_datagrid');//取消所有的选择项
			$("<div/>").attr("id","userGroupAuthDialog").dialog({
				title: '用户组授权',   
				href: '${ctx}/sysman/userGroupAction!toUserGroupAuthPage.action?userGroup.id='+userGroupId,   
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
			loadUserGroupListDatagrid();
		});
	</script>
</head>
<body class="easyui-layout">
<!-- 	<div> -->
	<div region="north" class="tableForm datagrid-toolbar" border="false" title="筛选条件" style="height: 148px;overflow: hidden;" align="left">
		<form id="userGroup_searchForm" action="${ctx}/sysman/userGroupAction!findUserGroupList.action" method="post">
			<fieldset style="border: none; border: 1px solid #cccccc;">
				<legend style="color: #888888;">筛选条件</legend>
				<table class="tableForm search_table_form">
				<!-- <table class="tableForm datagrid-toolbar search_table_form"> -->
					<tbody>
						<tr>
							<td>用户组名</td>
							<td><input name="userGroup.groupName" id="userName" style="width:317px;" /></td>
							<td style="padding-left: 20px;">用户</td>
							<td><input name="userGroup.groupName" id="userName" style="width:330px;" /></td>
						</tr>
						<tr>
							<td>创建时间</td>
							<td colspan="3">
								<input name="userGroup.createTimeStart" id="createTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />至
								<input name="userGroup.createTimeEnd" id="createTimeEnd" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;height: 24px;" />
							</td>
						</tr>
						<tr>
							<td>最后修改时间</td>
							<td colspan="3">
<!-- 								<input name="userGroup.lastUpdateTimeStart" id="lastUpdateTimeStart" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;" />至
								<input name="userGroup.lastUpdateTimeEnd" id="lastUpdateTimeEnd" class="easyui-datetimebox" 
									data-options="editable:false" style="width: 155px;" />  -->
								<input name="userGroup.lastUpdateTimeStart" id="lastUpdateTimeStart" style="width: 155px;height: 24px;" 
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>至
								<input name="userGroup.lastUpdateTimeEnd" id="lastUpdateTimeEnd" style="width: 155px;height: 24px;"
									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/> 
									
								<a href="#" class="easyui-linkbutton" onclick="userGroupSearch();">过滤</a> 
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch('userGroup_searchForms');">取消</a>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</form>
	</div>
	<div region="center" border="false">
		<table id="userGroup_datagrid"></table>
	</div>
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="userGroup_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId="userGroupAdd">
					<td><a href="#" onclick="addUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">增加</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="userGroupEdit">
					<td><a href="#" onclick="editUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupDel">	
					<td><a href="#" onclick="deleteUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupImportTemplateExcel">
					<td><a href="#" onclick="refreshDatagrid('userGroup_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">下载导入模板（Excel）</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	

				<securl:accessRight rightId="userGroupImport">
					<td><a href="#" onclick="refreshDatagrid('userGroup_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupExport">
					<td><a href="#" onclick="refreshDatagrid('userGroup_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导出</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<td><a href="#" onclick="cancelChecked('userGroup_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a></td>
				<td><div class=datagrid-btn-separator></div></td>
			</tr>
		</table>
	</div>
	
</body>
</html>