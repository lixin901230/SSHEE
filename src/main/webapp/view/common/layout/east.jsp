<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../taglib.jsp"%>
<script type="text/javascript" charset="utf-8">
	
	//加载在线人数datagrid
	function onlineNumDatagrid(){
		
		$('#layout_east_onlineDatagrid').datagrid({
			url : '${pageContext.request.contextPath}/onlineController/datagrid.action',
			title : '',
			iconCls : '',
			fit : true,
			fitColumns : true,
			pagination : true,
			pageSize : 10,
			pageList : [ 10 ],
			nowarp : false,
			border : false,
			idField : 'id',
			sortName : 'logindatetime',
			sortOrder : 'desc',
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				hidden : true
			} ] ],
			columns : [ [ {
				title : '登录名',
				field : 'loginname',
				width : 100,
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				}
			}, {
				title : 'IP',
				field : 'ip',
				width : 150,
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				}
			}, {
				title : '登录时间',
				field : 'logindatetime',
				width : 150,
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				},
				hidden : true
			} ] ],
			onClickRow : function(rowIndex, rowData) {
			},
			onLoadSuccess : function(data) {
				$('#layout_east_onlinePanel').panel('setTitle', '( ' + data.total + ' )人在线');
			}
		}).datagrid('getPager').pagination({
			showPageList : false,
			showRefresh : false,
			beforePageText : '',
			afterPageText : '/{pages}',
			displayMsg : ''
		});
	}
	
	//创建一个在线人数面板，加载在线人数，并没给10加载更新一次
	function loadOnlieDatagrid(){
		
		//定义在线人员信息面板
		$('#layout_east_onlinePanel').panel({
			tools : [ {
				iconCls : 'icon-reload'
				/* handler : function() {
					$('#layout_east_onlineDatagrid').datagrid('load', {});
				} */
			} ]
		});
		
		//reloadOnlineNum();//每个10秒加载一次
	}
	
	//使用延时器定时轮询加载，每个10秒加载一次
	function reloadOnlineNum(){
		
		window.setInterval(function() {
			$('#layout_east_onlineDatagrid').datagrid('load', {});
		}, 1000 * 60 * 10);
	}
	
	
	//显示east部分的日历
	function showEastCalendar(){
		
		$('#layout_east_calendar').calendar({
			fit : true,
			current : new Date(),
			border : false,
			onSelect : function(date) {
				$(this).calendar('moveTo', new Date());
			}
		});
	}

	//页面初始化
	$(function() {
		
		//onlineNumDatagrid();

		showEastCalendar();

		loadOnlieDatagrid();

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:1">
	<div data-options="region:'north',border:1" style="height:180px;overflow: hidden;border-left: 0px;border-top: 0px;">
		<div id="layout_east_calendar"></div>
	</div>
	<div data-options="region:'center',border:0" style="overflow: hidden;">
		<div id="layout_east_onlinePanel" data-options="fit:true,border:0,iconCls:'index_icon_right_chat'" title="用户互聊">
			<table id="layout_east_onlineDatagrid"></table>
		</div>
	</div>
<!-- 	<div id="chat" class="easyui-accordion" style="width:500px;height:300px;"> -->
<!-- 		<div title="用户互聊" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;"> -->
<!-- 			<h3 style="color:#0099FF;">Accordion for jQuery</h3> -->
<!-- 			<p>Accordion is a part of easyui framework for jQuery. It lets you define your accordion component on web page more easily.</p> -->
<!-- 		</div> -->
<!-- 	</div> -->
</div>