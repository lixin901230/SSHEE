<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>zTreeDemo</title>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<%@ include file="../../../common/head.jsp" %>
	<script type="" src="${ctx}/resource/plugin/jquery-ztree-v3.5.14/js/jquery.ztree.all-3.5.js"></script>
	<link href="${ctx}/resource/plugin/jquery-ztree-v3.5.14/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/plugin/jquery-ztree-v3.5.14/css/demo.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div align="center" style="margin: 0px;">
		<div class="zTreeDemoBackground left" style="padding-left: 20%;float: left;">
			一、简单JSON数据（平滑数据显示）：
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		
		<div class="zTreeDemoBackground left" style="padding-left: 10%;float: left;">
			二、标准JSON数据（后台返回标准json tree数据）
			<ul id="treeDemo2" class="ztree"></ul>
		</div>
	</div>
	
	<script type="text/javascript">
	
		var setting = {
			data: {
				simpleData: {
					enable: true,
				}
			}
		};
		
		var setting2 = {
				data: {
					simpleData: {
						enable: true,
					}
				},
				check: {
					enable: true,
					autoCheckTrigger: true
				}
			};

		//简单数据
		var zNodes =[
			{ id:1, pId:0, name:"父节点1 - 展开", open:true},
			{ id:11, pId:1, name:"父节点11 - 折叠"},
			{ id:111, pId:11, name:"叶子节点111"},
			{ id:112, pId:11, name:"叶子节点112"},
			{ id:113, pId:11, name:"叶子节点113"},
			{ id:114, pId:11, name:"叶子节点114"},
			{ id:12, pId:1, name:"父节点12 - 折叠"},
			{ id:121, pId:12, name:"叶子节点121"},
			{ id:122, pId:12, name:"叶子节点122"},
			{ id:123, pId:12, name:"叶子节点123"},
			{ id:124, pId:12, name:"叶子节点124"},
			{ id:13, pId:1, name:"父节点13 - 没有子节点", isParent:true},
			{ id:2, pId:0, name:"父节点2 - 折叠"},
			{ id:21, pId:2, name:"父节点21 - 展开", open:true},
			{ id:211, pId:21, name:"叶子节点211"},
			{ id:212, pId:21, name:"叶子节点212"},
			{ id:213, pId:21, name:"叶子节点213"},
			{ id:214, pId:21, name:"叶子节点214"},
			{ id:22, pId:2, name:"父节点22 - 折叠"},
			{ id:221, pId:22, name:"叶子节点221"},
			{ id:222, pId:22, name:"叶子节点222"},
			{ id:223, pId:22, name:"叶子节点223"},
			{ id:224, pId:22, name:"叶子节点224"},
			{ id:23, pId:2, name:"父节点23 - 折叠"},
			{ id:231, pId:23, name:"叶子节点231"},
			{ id:232, pId:23, name:"叶子节点232"},
			{ id:233, pId:23, name:"叶子节点233"},
			{ id:234, pId:23, name:"叶子节点234"},
			{ id:3, pId:0, name:"父节点3 - 没有子节点", isParent:true}
		];
		
		//复杂数据
		var zNodes2 =[
 			{ name:"父节点1 - 展开", open:true,
 				children: [
 					{ name:"父节点11 - 折叠",
 						children: [
 							{ name:"叶子节点111"},
 							{ name:"叶子节点112"},
 							{ name:"叶子节点113"},
 							{ name:"叶子节点114"}
 						]},
 					{ name:"父节点12 - 折叠",
 						children: [
 							{ name:"叶子节点121"},
 							{ name:"叶子节点122"},
 							{ name:"叶子节点123"},
 							{ name:"叶子节点124"}
 						]},
 					{ name:"父节点13 - 没有子节点", isParent:true}
 				]},
 			{ name:"父节点2 - 折叠",
 				children: [
 					{ name:"父节点21 - 展开", open:true,
 						children: [
 							{ name:"叶子节点211"},
 							{ name:"叶子节点212"},
 							{ name:"叶子节点213"},
 							{ name:"叶子节点214"}
 						]},
 					{ name:"父节点22 - 折叠",
 						children: [
 							{ name:"叶子节点221"},
 							{ name:"叶子节点222"},
 							{ name:"叶子节点223"},
 							{ name:"叶子节点224"}
 						]},
 					{ name:"父节点23 - 折叠",
 						children: [
 							{ name:"叶子节点231"},
 							{ name:"叶子节点232"},
 							{ name:"叶子节点233"},
 							{ name:"叶子节点234"}
 						]}
 				]},
 			{ name:"父节点3 - 没有子节点", isParent:true}
 		];
	
		zNodes2 = '[{"id":"10705","parentId":"107","parentName":null,"resourceCode":"portalLogoEdit","resourceName":"门户LOGO删除","url":null,"nodeSort":0,"isMenu":0,"statu":0,"iconCls":null,"text":"门户LOGO删除","state":null},{"id":"0","parentId":"ROOT_NODE","parentName":null,"resourceCode":"welcome","resourceName":"主页","url":"view/common/layout/portal.jsp","nodeSort":1,"isMenu":1,"statu":1,"iconCls":"menu_icon_welcome_page","text":"主页","state":"open"},{"id":"1","parentId":"0","parentName":null,"resourceCode":"sysMan","resourceName":"系统管理","url":"","nodeSort":1,"isMenu":0,"statu":1,"iconCls":"menu_icon_sys_man","text":"系统管理","state":""},{"id":"101","parentId":"1","parentName":null,"resourceCode":"userMan","resourceName":"用户管理","url":"/sysman/userAction!toUserListPage.action","nodeSort":1,"isMenu":1,"statu":1,"iconCls":"menu_icon_user_man","text":"用户管理","state":"closed"},{"id":"201","parentId":"2","parentName":null,"resourceCode":"exampleTree","resourceName":"树形示例","url":"","nodeSort":1,"isMenu":1,"statu":1,"iconCls":"menu_icon_resource_man","text":"树形示例","state":"closed"},{"id":"10101","parentId":"101","parentName":null,"resourceCode":"userManList","resourceName":"用户列表","url":"/sysman/userAction!toUserListPage.action","nodeSort":1,"isMenu":2,"statu":1,"iconCls":null,"text":"用户列表","state":"open"},{"id":"10201","parentId":"102","parentName":null,"resourceCode":"roleManList","resourceName":"角色列表","url":"/sysman/roleAction!toRoleListPage.action","nodeSort":1,"isMenu":2,"statu":1,"iconCls":null,"text":"角色...null,"resourceCode":"logMan","resourceName":"日志管理","url":"","nodeSort":8,"isMenu":1,"statu":1,"iconCls":"menu_icon_log_man","text":"日志管理","state":"open"},{"id":"1010107","parentId":"10101","parentName":null,"resourceCode":"userManExport","resourceName":"用户导出","url":"","nodeSort":8,"isMenu":2,"statu":1,"iconCls":null,"text":"用户导出","state":null},{"id":"1020107","parentId":"10201","parentName":null,"resourceCode":"roleManExport","resourceName":"角色导出","url":"","nodeSort":8,"isMenu":2,"statu":1,"iconCls":null,"text":"角色导出","state":null},{"id":"1050108","parentId":"10501","parentName":null,"resourceCode":"userGroupImport","resourceName":"用户组导入","url":"","nodeSort":8,"isMenu":2,"statu":1,"iconCls":"","text":"用户组导入","state":""},{"id":"1060106","parentId":"10601","parentName":null,"resourceCode":"orgInfoImport","resourceName":"机构导入","url":"","nodeSort":8,"isMenu":2,"statu":1,"iconCls":"","text":"机构导入","state":""},{"id":"1020108","parentId":"10201","parentName":null,"resourceCode":"roleManEidtSave","resourceName":"角色编辑保存","url":"","nodeSort":9,"isMenu":2,"statu":1,"iconCls":null,"text":"角色编辑保存","state":null},{"id":"1050109","parentId":"10501","parentName":null,"resourceCode":"userGroupExport","resourceName":"用户组导出","url":"","nodeSort":9,"isMenu":2,"statu":1,"iconCls":"","text":"用户组导出","state":""},{"id":"1060107","parentId":"10601","parentName":null,"resourceCode":"orgInfoExport","resourceName":"机构导出","url":"","nodeSort":9,"isMenu":2,"statu":1,"iconCls":"","text":"机构导出","state":null}]';
		
		//加载简单的json树数据
		function loadSimpleTreeJsonData(){
			
			$.ajax({
				url: '${ctx}/sysman/resourceAction!getAllTeeNode.action',
				type: 'post',
				dataType: 'text',
				cache: false,
				async: true,
				success: function(data){
					//alert(data);
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				},
				error: function(){$.messager.alert('错误','初始化第一颗树时发送请求失败','error');}
			});
		}
		
		//加载标准json树数据，后台组装树形json数据
		function loadStandardTreeJsonData(){
			
			$.ajax({
				url: '${ctx}/sysman/resourceAction!loadIndexMenu.action',
				type: 'post',
				dataType: 'json',
				cache: false,
				async: true,
				success: function(data){
					//alert(data);
					zNodes2 = eval("("+zNodes2+")");
					alert(zNodes2);
					$.fn.zTree.init($("#treeDemo2"), setting2, zNodes2);
				},
				error: function(){$.messager.alert('错误','初始化第一颗树时发送请求失败','error');}
			});
		}

		//页面数据初始化
		$(function(){
			loadSimpleTreeJsonData();
			loadStandardTreeJsonData();
		});
	</script>
</body>
</html>