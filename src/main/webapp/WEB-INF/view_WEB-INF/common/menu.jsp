<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div title="学生信息管理" data-options="selected:true" style="padding:10px;">
	<ul style="padding-left: 0px;">
		<li><a href="#" id="welcome" onclick="accessMenuLink('${ctx}/jumpWelComeAction!welcome.action','easyui-tabs_center', 'tabs_id_welcome', '首页')">首页</a></li>
		<li><a href="#" id="noticeList" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '通知信息管理')">通知信息管理</a></li>
	</ul>	
</div>
<div title="系统管理" style="padding:10px">
	<ul style="padding-left: 0px;">
		<li><a href="#" onclick="accessMenuLink('${ctx}/view/common/index.jsp','easyui-tabs_center', 'tabs_id_noticeList', '用户信息管理')">用户信息管理</a></li>
		<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '用户组信息管理')">用户组信息管理</a></li>
		<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '机构信息管理')">机构信息管理</a></li>
		<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '角色信息管理')">角色信息管理</a></li>
		<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '权限信息管理')">权限信息管理</a></li>
		<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '日志信息管理')">日志信息管理</a></li>
		<div title="日志信息管理" style="padding:10px">
			<ul style="padding-left: 0px;">
				<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '认证日志管理')">认证日志管理</a></li>
				<li><a href="#" onclick="accessMenuLink('','easyui-tabs_center', 'tabs_id_noticeList', '系统日志管理')">系统日志管理</a></li>
			</ul>
		</div>
	</ul>
</div>
