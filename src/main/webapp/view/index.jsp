<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>框架学习系统</title>
	<meta http-equiv="content-type" content="text/html;charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="">
	<meta http-equiv="description" content="struts+spring+hibernate+springsecurity+easyui">
	<%@ include file="common/head.jsp" %>
	<%-- <jsp:include page="common/head.jsp"></jsp:include> --%>
</head>
<body class="easyui-layout">

	<div data-options="region:'north',border:1,href:'${ctx}/view/common/layout/north.jsp',split:true" style="height: 80px;overflow: hidden;" class="logo"></div>
	<div id="west" data-options="region: 'west',title: '功能导航',iconCls: 'index_icon_left_menu',split: true,href: '${ctx}/menuAction!dynamicMenu.action',tools: [{
					iconCls : 'icon-reload',
					handler : function() {
						$('#west').panel('refresh');
					}
				}, {
					iconCls : 'icon-redo',
					handler : function() {
						var node = $('#mainMenuTree').tree('getSelected');
						if (node) {
							$('#mainMenuTree').tree('expandAll', node.target);
						} else {
							$('#mainMenuTree').tree('expandAll');
						}
					}
				}, {
					iconCls : 'icon-undo',
					handler : function() {
						var node = $('#mainMenuTree').tree('getSelected');
						if (node) {
							$('#mainMenuTree').tree('collapseAll', node.target);
						} else {
							$('#mainMenuTree').tree('collapseAll');
						}
					}
				}]" style="width: 200px;overflow: hidden;border-bottom: 0px;"></div>
	<div data-options="region:'center',title:' 欢迎使用，用户：[${authentication != null and authentication != 'anonymousUser' ? authentication.username : '匿名用户'}]',iconCls:'index_icon_center',border:1,href:'${ctx}/view/common/layout/center.jsp'" style="overflow: hidden;"></div>
	<div data-options="region:'east',title:'日历',iconCls:'index_icon_right_calendar',split:true,border:1,href:'${ctx}/view/common/layout/east.jsp'" style="width: 200px;overflow: hidden;"></div>
	<div data-options="region:'south',border:1,href:'${ctx}/view/common/layout/south.jsp',split:true" style="height: 30px;overflow: hidden;"></div>
	<script type="text/javascript">
	
		//消息框显示登陆信息
		function showLoginMsg(){
			
			var userName = "${authentication != null and authentication != 'anonymousUser' ? authentication.username : '匿名用户'}";
			
			$.messager.show({
				title: '登陆信息',
				msg: '登陆成功，欢迎访问本系统！<br/>用户名：'+userName,
				width: 250,
				height: 150,
				showType: 'slide',
				showSpeed: 5000,
				timeout: 9000
			});
		}
		
		
		//============================== 此处是个bug：清楚浏览器缓存不应该退出登陆=======================================
			
		//检查用户是否因为清楚缓存而导致退出登陆
		function isLoginOut(){
			if("${authentication == 'anonymousUser'}" == "true"){
				$.messager.alert("警告","您已退出登录，请重新登陆...","warning",function(){
					window.location.href="${ctx}";
				});
			}
		}
	
		$(function(){
			isLoginOut();
			showLoginMsg();
		});
	</script>
</body>
</html>