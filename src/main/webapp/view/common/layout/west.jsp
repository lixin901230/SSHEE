<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
	<head>
		<%@ include file="../head.jsp" %>
		<style type="text/css">
			/**
			 * west菜单栏部分 <a> 超链接样式
			 */
			#west a:LINK {
				color: black;
				text-decoration: none;
			}
			#west a:HOVER {
				color:red;
				text-decoration: none;
				cursor: pointer;
			}
			#west a:ACTIVE {
				color:red;
				text-decoration: none;
			}
			#west a:VISITED {
				color: black;
				text-decoration: none;
			}
		</style>
	</head>
<body>
	<div class="easyui-accordion" data-options="fit:true,border:false">
	${menuStr}
		
		<%-- <div title="系统管理" style="padding:10px" data-options="isonCls:'icon-save',tools : [ {
					iconCls : 'icon-reload',
					handler : function() {
						$('#layout_west_tree').tree('reload');
					}
				}, {
					iconCls : 'icon-redo',
					handler : function() {
						var node = $('#layout_west_tree').tree('getSelected');
						if (node) {
							$('#layout_west_tree').tree('expandAll', node.target);
						} else {
							$('#layout_west_tree').tree('expandAll');
						}
					}
				}, {
					iconCls : 'icon-undo',
					handler : function() {
						var node = $('#layout_west_tree').tree('getSelected');
						if (node) {
							$('#layout_west_tree').tree('collapseAll', node.target);
						} else {
							$('#layout_west_tree').tree('collapseAll');
						}
					}
				} ]">
			<ul id="layout_west_tree"></ul>
			
			<ul style="padding-left: 0px;">
				<li><a href="#" onclick="accessMenuLink('${ctx}/sysman/userAction!toUserListPage.action','layout_center_tabs', 'tabs_id_userList', '用户管理')">用户管理</a></li>
				<li><a href="#" onclick="accessMenuLink('${ctx}/sysman/roleAction!toRoleListPage.action','layout_center_tabs', 'tabs_id_roleList', '角色管理')">角色管理</a></li>
				<li><a href="#" onclick="accessMenuLink('${ctx}/sysman/resourceAction!toResourceListPage.action','layout_center_tabs', 'tabs_id_noticeList', '权限管理')">权限管理</a></li>
				<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '用户组管理')">用户组管理</a></li>
				<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '组织结构')">组织结构</a></li>
				<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '日志管理')">日志管理</a></li>
				<div title="日志信息管理" style="padding:10px">
					<ul style="padding-left: 0px;">
						<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '认证日志管理')">认证日志管理</a></li>
						<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '系统日志管理')">系统日志管理</a></li>
					</ul>
				</div>
				<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '数据字典')">数据字典</a></li>
				<li><a href="#" onclick="accessMenuLink('','layout_center_tabs', 'tabs_id_noticeList', '门户管理')">门户管理</a></li>
			</ul>
		</div>
		<div title="业务管理" data-options="iconCls:'icon-reload'">
			<jsp:include page="../easyuiDemo.jsp"></jsp:include>
		</div> --%>
	</div>
	<script type="text/javascript">
	
		//加载导航菜单
// 		function loadMenu(){
			
// 			$.ajax({
// 				url:"${ctx}/menuAction!dynamicMenu.action",
// 				type:"post",
// 				dataType:"text",
// 				success:function(data){
// 					$(".easyui-accordion").append(data);
// 				},
// 				error:function(){alert("发送请求失败");}
// 			});
// 		}
		
		$(function() {
			
// 			loadMenu();
// 			$.parser.parse();
		});
	</script>
	
</body>
</html>