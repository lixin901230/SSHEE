<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../taglib.jsp"%>

<script type="text/javascript">
	/**
	 * 关于我们
	 */
	function aboutWe(url){
		
		addTab("layout_center_tabs", "aboutWePage", "关于我们", url, true, true, "menu_icon_welcome_about");
	}
	
	$(function(){
		showTime();
	});
</script>

<div class="panel-header panel-header-noborder" style="text-align: center;vertical-align: middle;height: 100%;">
	<div style="line-height:24px;text-align: left;padding-left: 5px;">
		<span><img alt="加载中..." src="${ctx}/resource/images/icons/clock1.png"></span>
		<span id="datetime" style="padding-left: 5px;"></span>
		<span style="padding-left: 20%;">
			Copyright © 2011-2100 无版权限制，让我们共同进步!&nbsp;&nbsp;&nbsp;&nbsp;
			<a onclick="aboutWe('/view/common/layout/portal/aboutWe.jsp');" style="text-decoration: underline;cursor: pointer;">关于我们 </a>
		</span>
	</div>
</div>