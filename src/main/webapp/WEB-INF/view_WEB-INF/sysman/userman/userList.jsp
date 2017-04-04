<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户信息列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
	<script type="text/javascript">
	
		//页面数据初始化
		$(function(){
			
			$('#userList').datagrid({
			    url:'${ctx}/userAction!login.action',
			    fit:true,
			    fitColumns:true,
			    border:false,
			    striped:true,
			    singleSelect:true,
			    remoteSort: false,
			    pageSize:10,
			    pageList:[10,20,30,40,50],
			    pagination:true,
			    loadMsg:'数据加载中...',
			    columns:[[
			        {field:'id',title:'用户编码',width:100,align:'center'},
			        {field:'userName',title:'用户名',width:150,align:'center'},
			        {field:'email',title:'邮箱',width:150,align:'center'},
			        {field:'statu',title:'用户状态',width:100,align:'center'},
			        {field:'createTime',title:'创建日期',width:250,align:'center'},   
			        {field:'remark',title:'备注',width:200,align:'center'}
			    ]]
			});
		});
	</script>
</head>
<body>
	<table id="userList"></table>  
</body>
</html>