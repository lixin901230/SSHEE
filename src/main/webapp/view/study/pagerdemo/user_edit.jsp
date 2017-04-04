<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../common/head.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- 引入分页插件样式文件和js文件 -->
<%-- 	<link href="${ctx}/view/study/pagerdemo/css/userlist.css" type="text/css" rel="stylesheet"> --%>
	<link href="${ctx}/resource/js/common/pager-1.1.6/css/jquery.whatyPager-1.1.6.css" type="text/css" rel="stylesheet">
	<script src="${ctx}/resource/js/common/pager-1.1.6/js/jquery.whatyPager-1.1.6.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/view/study/pagerdemo/js/userlist.js" ></script>
	
	<title>jquery ajax分页插件使用demo</title>
</head>
<body>
	<input type="text" id="curPageTemp" value="<%=request.getParameter("curPage") %>"/>
	<input type="text" id="pageSizeTemp" value="<%=request.getParameter("pageSize") %>"/>
	<input type="button" value="保存" id="saveEdit"/>
<%-- 	<a href="javascript:window.location.href='${ctx}/view/study/pagerdemo/userlist.jsp?curPage='">返回</a> --%>
</body>
</html>