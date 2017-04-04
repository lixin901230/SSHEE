<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>框架学习系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
<%-- 	<%@ include file="head.jsp" %> --%>
	<script type="text/javascript"  src="${ctx}/resource/js/common/jquery-1.9.1.min.js" ></script>

<script type="text/javascript" src="${ctx}/resource/plugin/jquery-easyui-1.3.4/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${ctx}/resource/plugin/jquery-easyui-1.3.4/locale/easyui-lang-zh_CN.js" ></script>
<link href="${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/resource/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/css/framecss.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/resource/js/frame_index.js" ></script>
	<script type="text/javascript">

		/**
		 * 初始化函数
		 */
		$(function(){
			
			showTime();
			addTab("easyui-tabs_center", "welcomePage", "首页", "${ctx}/jumpWelComeAction!welcome.action", true, false, null);
		});
		
		/**
		 * 关于我们
		 */
		function aboutWe(url){
			
			addTab("easyui-tabs_center", "aboutWePage", "关于我们", url, true, true, null);
		}
	</script>
  </head>
  <body class="easyui-layout" style="background: #eaeef5;width: 100%;">
	
	<!-- LOGO部分 -->
	<div id="north" data-options="region:'north'" style="height:31px;background: url('${ctx}/resource/images/myself/top.jpg') repeat-x 50% bottom;border-top: #1d438b 1px solid;padding-bottom: 0px">
		<div style="background: url('${ctx}/resource/images/myself/topicon.gif') no-repeat 10px 5px;color: #e7e7e7;font-weight: bold;line-height: 26px;margin: 0px;padding-left: 45px;padding-bottom: 0px;padding-top: 0px;">
			前端后端框架学习练习应用
		</div>
		<div style="color: #e7e7e7;font-weight: bold;position: absolute;right: 30px;top: 2px;line-height: 8px;height: 24px;margin: 0px;padding-top: 0px;padding-bottom: 1px;padding-left: 0px;padding-right: 0px;">
			<ul>
				<li>当前用户：<a href="#"><sec:authentication property="name"></sec:authentication></a></li>
				<li>|&nbsp;<a href="#" onclick="changePwd();return false;">修改密码</a></li>
				<li>|&nbsp;<a href="#">帮助</a>&nbsp;|</li>
				<li><a href="${ctx}/j_spring_security_logout">退出</a></li>
			</ul>
		</div>
	</div>
	
	<!-- south状态栏部分 -->
	<div data-options="region:'south',split:false" style="height:24px;padding-left: 20px;vertical-align: middle;background: url('resource/images/icons/bottom.bmp') repeat-x;overflow: hidden;">
		<span id="datetime" style="line-height: 24px;"></span>
		<span style="line-height: 24px;padding-left: 20%;">
			Copyright © 2011-2100 无版权限制，让我们共同进步!&nbsp;&nbsp;&nbsp;&nbsp;
			<a onclick="aboutWe('jumpWelComeAction!aboutWe.action');" style="text-decoration: underline;cursor: pointer;">关于我们 </a>
		</span>
	</div>
	
	<!-- 功能菜单部分 -->
	<div id="west" data-options="region:'west',split:true" title="功能菜单" style="width:190px;">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			
			<!-- 此处引入的菜单需要后台根据权限生成菜单，进行菜单鉴权控制，此处后期跟进 -->
			<%@ include file="menu.jsp" %>
			
		</div>
	</div>
	
	<!-- center 框架主体部分 -->
	<div data-options="region:'center',title:'内容'" style="background: #eaeef5">
	
		<!-- 选项卡 -->
		<div id="easyui-tabs_center" class="easyui-tabs" data-options="fit:true,border:false,plain:true"></div>
	</div>
	
  </body>
</html>
