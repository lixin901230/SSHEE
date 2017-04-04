<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../common/head.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- 引入分页插件样式文件和js文件 -->
	<link href="${ctx}/resource/js/common/pager-1.1.6/css/jquery.whatyPager-1.1.6.css" type="text/css" rel="stylesheet">
	<script src="${ctx}/resource/js/common/pager-1.1.6/js/jquery.whatyPager-1.2.3.js" type="text/javascript"></script>

	<link href="${ctx}/view/study/pagerdemo/css/userlist.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="${ctx}/view/study/pagerdemo/js/userlist.js" ></script>
	
	<title>jquery ajax分页插件使用demo</title>
</head>
<body>
	<a ></a>
	<!-- 存储编辑保存时带回来的分页数据，用于保存后回到编辑操作室的当前页 -->
	<input type="hidden" id="curPageTemp" value="${pager.curPage}"/>
	<input type="hidden" id="pageSizeTemp" value="${pager.pageSize}"/>
	
	<div class="tableFrame">
		<div class="tableFrameTitle">
			<ul>
				<li>用户名</li>
				<li>性别</li>
				<li>邮箱</li>
				<li>手机</li>
				<li>性别</li>
				<li>备注</li>
				<li>操作</li>
			</ul>
		</div>
		<!-- 分页数据列表容器 -->
		<div class="tableCase" id="dataList">
			
		</div>
	</div>
	
	<!-- 分页栏容器div -->
	<div id="pagerToolBar" style="margin: 0 auto; /* width: 750px; */">
	
	</div>
	
	</br>
	
	<div class="tableFrame">
		<div class="tableFrameTitle">
			<ul>
				<li>用户名</li>
				<li>性别</li>
				<li>邮箱</li>
				<li>手机</li>
				<li>性别</li>
				<li>备注</li>
				<li>操作</li>
			</ul>
		</div>
		<!-- 分页数据列表容器 -->
		<div class="tableCase" id="dataList2">
			
		</div>
	</div>
	
	<!-- 分页栏容器div -->
	<div id="pagerToolBar2" style="margin: 0 auto; /* width: 750px; */">
	
	</div>
	
</body>
</html>