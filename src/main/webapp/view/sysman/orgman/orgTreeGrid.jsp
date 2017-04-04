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
	
	<table id="org_treegrid"></table>

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
				<%-- <securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="orgInfoSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">条件查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="userGroupDetail">
					<td><a href="#" onclick="cancelSearch('userGroup_searchForms');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">清空查询</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight> --%>
				
				<securl:accessRight rightId="orgInfoAdd">
					<td><a href="#" onclick="addUserToUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新建</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
									
				<securl:accessRight rightId="orgInfoEdit">	
					<td><a href="#" onclick="deleteUserGroup();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">修改</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="orgInfoDel">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">删除</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>

				<securl:accessRight rightId="orgInfoImportTemplateExcel">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入模板下载</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="orgInfoImport">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId="orgInfoExport">
					<td><a href="#" onclick="refreshDatagrid('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导出</a></td>	
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<td><a href="#" onclick="cancelChecked('userGroupUser_datagrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a></td>
				<td><div class=datagrid-btn-separator></div></td>
			</tr>
		</table>
	</div>
    	
	<script type="text/javascript">
	
		function showOrgDetail(orgId){
			
			$('#orgInfo_layout').layout('panel','center').panel({
				title: '', border:false,
				href:'${ctx}/sysman/orgInfoAction!findOrgInfoDetail.action?orgInfo.id='+orgId
			});
		}
		
		//编辑机构信息
		function editOrg(orgId){
			$("<div/>").attr("id","").dialog({
				
			});
		}
		
		//删除机构信息
		function deleteOrg(orgId){
			
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
		
		//加载组织机构treegrid
		function loadOrgTreegrid(){
			
			$('#org_treegrid').treegrid({
				loadMsg:'数据加载中...',
			    iconCls:'icon-ok',
			    url : '${ctx}/sysman/orgInfoAction!findOrgInfoTreegrid.action',
			    idField : 'id',
				treeField : 'text',
				parentField : 'parentId',
				animate:true,
				fit : true,
				fitColumns : true,
				border : false,
// 				showFooter:true,
				checkOnSelect: false,		//航选择映射到复选框
				selectOnCheck: false,		//复选框选择映射到行
				singleSelect: true,			//只允许选一行
				columns:[[
			        {field:'id',title:'编码',align:'center',checkbox:true},
			        {field:'text',title:'机构名称',width:280,align:'left'},
			        {field:'parentId',title:'上级资源编号',width:80,align:'center'},
			        {field:'statu',title:'状态',width:50,align:'center',formatter:function(value,row,index){
			        	if(value == 0){return "禁用";} else {return "可用";}
			        }},
			        {field:'nodeSort',title:'排序',width:30,align:'center'},
			        {field:'state',title:'资源节点状态',width:100,align:'center'},
			        {field:'action',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.parentId == 'ROOT_NODE'){
			        		return '根节点';
			        	} else {
				        	return "<securl:accessRight rightId='orgInfoDetail'><img onclick='showOrgDetail(\""+row.id+"\");' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='orgInfoEdit'><img onclick='editOrg(\""+row.id+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='orgInfoDel'><img onclick='deleteOrg(\""+row.id+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
			    ]],/* 
			    onCheck: function(row, rowData){
			    	cascadeSelectChildren($(this), row, true, true);
			    },
			    onUncheck: function(row, rowData){
			    	cascadeSelectChildren($(this), row, false, false);			    	
			    },
			    onLoadSuccess: function(row, data){
			    	$(this).treegrid("hideColumn", "state");	//隐藏指定列
			    }, */
			    toolbar : '#search_form,#userGroup_datagrid_toolbar'
			});
		}
		
		//页面数据初始化
		$(function(){
			loadOrgTreegrid();
		});
	</script>
</body>
</html>