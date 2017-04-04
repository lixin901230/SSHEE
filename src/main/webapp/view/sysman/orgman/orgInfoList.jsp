<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>组织机构列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
	<script type="text/javascript">
	
		//根据用户状态标记显示用户状态信息
		function fmtShowUserState(value,row,index){
       		if(value){
       			if(value == 0){			//注册后未通过注册邮箱激活
       				return "未激活"; 	
       			}else if(value == 1){	//注册完并通过注册邮箱激活
       				return "已激活";
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
		
		//加载组织机构树
		function loadOrgInfoTree(){
			$("#orgTree").tree({
				loadMsg:'数据加载中...',
				url: '${ctx}/sysman/orgInfoAction!findOrgInfoTree.action',
				id: 'id',
				text:'text',
				parentField: 'parentId',
				state: 'state',
				lines: true,
				animate: true,
				onLoadSuccess: function(node, data){
// 					loadOrgTreegrid();
				},
				onClick: function(node){
					
					var orgId = node.id;
					if(node.id == '0'){	//点击根节点是加载机构treegrid
						
						$('#orgInfo_layout').layout('panel','center').panel({title: '组织机构树列表',border:true,href:'${ctx}/view/sysman/orgman/orgTreeGrid.jsp'});
					} else {
						
						/* 组织机构详细信息 */
						$('#orgInfo_layout').layout('panel','center').panel({
							title: '', border:false,
							href:'${ctx}/sysman/orgInfoAction!findOrgInfoDetail.action?orgInfo.id='+orgId
						});
						$('#orgInfo_layout').layout('panel','center').panel('resize',{height:470});
						$('#orgInfo_layout').layout('resize');
					}
				}
			});
		}
		
		//页面数据初始化
		$(function(){
			
			loadOrgInfoTree();
		});
	</script>
</head>
<body>
	
	<div id="orgInfo_layout" class="easyui-layout" data-options="fit:true" style="margin-top: 5px;">
    	
    	<div data-options="region:'west',title:'组织机构树',fit:false,iconCls:'menu_icon_org_man',split:true" class="form_table_div" style="width:200px;border-left: 0px;padding-right: 5px;">
    		<ul id="orgTree" class="easyui-tree"></ul>  
    	</div>
    	
   		<div id="layout_center" data-options="region:'center',href:'${ctx}/view/sysman/orgman/orgTreeGrid.jsp',border:true,title:'组织机构树列表',iconCls:'menu_icon_org_man'" style="border-right: 0px;"></div>
	</div>

</body>
</html>