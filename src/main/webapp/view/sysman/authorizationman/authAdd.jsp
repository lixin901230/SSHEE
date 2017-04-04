<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>增加授权</title>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<%@ include file="../../common/head.jsp" %>
</head>
<body>
	<div align="center" style="margin:0px;padding:0px;height: 100%; padding-left: 1%;" class="form_table_div">
<!-- 	<div id="p" class="easyui-panel" title="用户授权" style="overfloat: auto;width: 700px;height: 480px;padding-left: 15px;"> -->
		
		<!-- 搜索、操作div -->
		<div style="padding: 8px 8px 8px; overfloat: auto;" align="left">
			<div id="roleComboDiv" style="width: 240px;">角色：<input id="roleCombo" name="roleCombo" value=""></div>
		</div>
		
		<!-- 数据显示div -->
		<div style="float:left;">
			<div id="p" class="easyui-panel" title="未授权用户" style="width:362px;height:350px;">
				<table id="unAuthUserDatagrid"></table>
			</div>
		</div>
		
		<div style="float:left;">
			<div style="width:40px;height:100px; padding: 140px 10px 100px; vertical-align: middle;text-align: center;">
				<input type='button' value=" &gt;&gt; " title="选择"/>
				<input type='button' value=" &lt;&lt; " title="移除" style="margin-top:15px;"/>
			</div>
		</div>
		
		<div style="float: left;">
			<div id="p" class="easyui-panel" title="已选择用户" style="width:340px;height:350px;padding-left:15px;">
				<table id="authUserDatagrid"></table>
			</div>
		</div>
	</div>
	
	<div id="roleComboPanel"></div>
	
		<!-- <div id="dlg-buttons" style="padding-bottom: 0px;" align="center">
			<a href="javascript:void(0)" onclick="saveAuth();return false;" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
			<a href="javascript:void(0)" onclick="closeDialog('#userAuthDialog');return false;" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div> -->
	<script type="text/javascript">
		
		//初始化角色combo下拉选项
		function loadRoleCombo(){
			
			$.ajax({
				url: '${ctx}/sysman/authAction!loadRole.action',
				type: 'post',
				dataType: 'json',
				cache: false,
				async: false,
				success: function(data){
					
					//角色下拉面板
					var $Panel = $("#roleComboPanel");
					$('<div style="color:#99BBE8;background:#fafafa;padding:5px;">请选择角色</div>').appendTo($Panel);
					$('<div><label><input id="selectAll" type="checkbox" value="all"/><span>全选</span></label></div>').appendTo($Panel);
					if(data){
						$(data).each(function(index, obj){
							$('<div><label><input type="checkbox" name="roleId" value="'+this.id+'"/>'
								+'<span>'+this.roleName+'</span></label></div>').appendTo($Panel);
						});
					}
					
					//初始化下拉框
					$("#roleCombo").combo({
						width: 200,
						multiple: true,
						required: true,
						editable: false,
						missingMessage: '必选项！',
						invalidMessage: '请选择角色进行授权！'
					});
					$Panel.appendTo($("#roleCombo").combo('panel'));	//给combo绑定下拉面板
					
					//初始化全选单选复选框
					checkedAll("#selectAll", "input[name='roleId']");
					
					$("#roleComboPanel>div:gt(0)").bind({
						mouseenter: function(){
							$(this).css("background", "#e6e6e6");
						},
						mouseleave: function(){
							$(this).css("background", "");
						}
					});
					
					var textStr = null;
					var values = null;
					$("#roleComboPanel>").find("input:checkbox").change(function(){
						textStr = "";
						values = "";
						var checkedBox = null;
						if($(this).attr('id') == 'selectAll'){
							if(this.checked){
								checkedBox = $("input[name='roleId']");
							} else {
								checkedBox = null;
							}
						} else {
							checkedBox = $("input[name='roleId']:checked");
						}
						
						if(checkedBox){
							$(checkedBox).each(function(index, obj){
								values += $(this).val();
								textStr += $(this).next("span").text();
								if(index < checkedBox.length - 1){
									values += ",";
									textStr += ",";
								}
							});
						}
						$("#roleCombo").combo('setValue', values).combo('setText', textStr);
						
						$("#roleComboDiv").mouseover(function(){
							if(textStr){
								$(this).tooltip({
									position: 'bottom',	//'left','right','top','bottom'
									content: '<span style="color:#fff">'+textStr+'</span>',
									/*onShow: function(){
										$(this).tooltip('tip').css({
											backgroundColor: '#666',
											borderColor: '#666'
										});
									}*/
									onHide: function(e){
										$(this).tooltip('destroy');
									}
								});
							}
						});
					});
				},
				error: function(){$.messager.alert('错误','加载角色下拉选项时发送请求失败','error');}
			});
		}
		
		//根据用户状态标记显示用户状态信息
		function fmtShowUserState(value,row,index){
       		if(value){
       			if(value == 0){			//注册后未通过注册邮箱激活
       				return "未激活"; 	
       			}else if(value == 1){	//注册完并通过注册邮箱激活
       				return "激活";
       			}else if(value == 2){	//连续6次登录失败后用户被自动挂起，需要找管理员解锁
       				return "挂起";	
       			}else if(value == 3){	//用户被管理员禁用，需要管理员重新开启后方可使用
       				return "禁用";
       			}else {					//不用的账号，可以考虑加过期状态
       				return "废弃";
       			}
       		}else {
       			return value;
       		}
		}
		
		//加载未授权用户列表
		function loadUnAuthUserDatagrid(){
			
			$("#unAuthUserDatagrid").datagrid({
				//title:'未授权用户',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/authAction!findUnAuthUserList.action',
			    fit: true,					//边框自适应
				border: false,
// 				remoteSort: true,			//定义是否从服务器给数据排序
				rownumbers: true,			//True就会显示行号的列
				fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
				idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
				striped: true,				//奇偶行使用不同背景色
				checkOnSelect: false,		//行选择不映射到复选框
				selectOnCheck: false,		//复选框可以多选
				singleSelect: true,			//只允许选一行
				sortOrder: 'asc',
				nowrap: true,
				pagination: true,			//True就会在 datagrid 的底部显示分页栏。
				pageSize: 10,
				pageList: [ 10, 20, 30,],
			    columns:[[
			        {field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'账号',width:120,align:'center'},
			        {field:'userName',title:'用户名',width:120,align:'center'},
			        {field:'statu',title:'用户状态',align:'center',formatter: fmtShowUserState}
			    ]],
			    onLoadSuccess: function(data){
			    	 var pager = $('#unAuthUserDatagrid').datagrid('getPager');
			    	 if(pager) {
			    		 $(pager).pagination({ //设置分页功能栏
			    			 //showRefresh: false
			    			 displayMsg: '共{total}记录'
			    		 });
			    	 }
			    }
			});
		}
		
		//加载已授权用户列表
		function loadSelectedUserDatagrid(){
			
			$("#authUserDatagrid").datagrid({
				title:'选中的授权用户',
			    iconCls:'icon-ok',
				loadMsg:'数据加载中...',
			    url:'${ctx}/sysman/userAction!findAuthUserList.action',
			    fit: true,					//边框自适应
				border: false,
// 				remoteSort: true,			//定义是否从服务器给数据排序
				rownumbers: true,			//True就会显示行号的列
				fitColumns: true,			//设置为true将自动使列适应表格宽度以防止出现水平滚动
				idField: 'id',				//标识字符串,设置后，复选框选中后翻页后会记住选择状态 (如果不标明这个属性，getSelections方法不能使用)
				striped: true,				//奇偶行使用不同背景色
				checkOnSelect: false,		//行选择不映射到复选框
				selectOnCheck: false,		//复选框可以多选
				singleSelect: true,			//只允许选一行
				sortOrder: 'asc',
				nowrap: true,
				pagination: true,			//True就会在 datagrid 的底部显示分页栏。
				pageSize: 10,
				pageList: [ 10, 20, 30,],
			    columns:[[
			        {field:'id',title:'用户编码',align:'center',checkbox:true},
			        {field:'userName',title:'用户名',width:120,align:'center'},
			        {field:'state',title:'用户状态',align:'center',formatter: fmtShowUserState}
			        /*{field:'ation',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 1){
			        		return '系统用户';
			        	} else {
			        		var userId = row.id;
				        	return "<securl:accessRight rightId='userManDetail'><img onclick='showUserDetail(\""+userId+"\")' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManEdit'><img onclick='editUser(\""+userId+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManAuth'><img onclick='userAuthDialog(\""+userId+"\");' title='授权' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/auth16.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='userManDel'><img onclick='deleteUser(\""+userId+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}*/
			    ]]
			});
		}
		
		//初始化表单
		$(function(){
			loadRoleCombo();//初始化角色下拉选项面板
			loadUnAuthUserDatagrid(); //初始化未授权用户表格
			//loadSelectedUserDatagrid();
		});
	</script>

</body>
</html>