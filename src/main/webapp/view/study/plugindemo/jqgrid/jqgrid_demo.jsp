<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../common/taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>jqGrid demo</title>
	<%@ include file="../../../common/head.jsp" %>
</head>
<body align="center" style="margin: 0px;">

	<div id="main_div" style="width: 1024px; margin: 10px;" align="center">
		<div style="text-align: center; margin: auto;">
			<fieldset style="border: none; border: 1px solid #cccccc;padding: 0px; height: 50px;">
				<legend style="color: #888888;">筛选条件</legend>
				<div id="search_form" style="margin: 0; height: 30px;">
					用户名：<input type="text" id="userName" value="">
					电    话：<input type="text" id="telephone" value="">
					<input type="button" id="searchBut" value="搜索">
				</div>
			</fieldset>	
			<table id="jqGrid_demo"></table>
			<div id="jqGrid_pager"></div>
		</div>
		
	</div>
	
	<!-- 为了页面加载速度，建议在最后面引入js、css库 -->
	<link rel="stylesheet" href="${ctx}/resource/plugin/jquery-ui-1.9.2/themes/blitzer/jquery-ui.css" type="text/css"></link>
	<link rel="stylesheet" href="${ctx}/resource/plugin/jquery.jqGrid-4.5.2/css/ui.jqgrid.css" type="text/css"></link>
	<script type="text/javascript" src="${ctx}/resource/plugin/jquery.jqGrid-4.5.2/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="${ctx}/resource/plugin/jquery.jqGrid-4.5.2/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="${ctx}/view/study/plugindemo/jqgrid/js/jqgrid_demo.js"></script>
</body>
</html>