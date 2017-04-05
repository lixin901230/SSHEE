<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>资源信息树列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<%@ include file="../../common/head.jsp" %>
	<script type="text/javascript">
	
		//级联选（取消选中）中子节点
		var oldState = "";	//保存有子节点的节点的状态
		function cascadeSelectChildren(treegridObj, checkedResObj, state, isExpand){
			
			checkedResId = checkedResObj.id;
			if(isExpand){
				oldState = checkedResObj.state;
				treegridObj.treegrid("expand",checkedResId);
			} else if(!isExpand && oldState != "open"){
				treegridObj.treegrid("collapse",checkedResId);
			}
			
			//根据ID获取所有孩子节点
			var children = treegridObj.treegrid('getChildren', checkedResId);
			$(children).each(function(i, child){
				var childId = child.id;//可以根据key取到任意值
				if(state){
					//此处存在jquery版本问题，jquery 1.9.1—2.0.3的版本对 操作复选框(checkbox) attr checked不起作用，第一次选中（取消选中）一个轮回后，第二次就无反应，但prop方法可解决该问题
// 					$("input[type='checkbox'][value='"+childId+"']").attr("checked", true);
					$("input[type='checkbox'][value='"+childId+"']").prop("checked", true);
				}else{
// 					$("input[type='checkbox'][value='"+childId+"']").attr("checked", false); 
// 					$("input[type='checkbox'][value='"+childId+"']").removeAttr("checked");
// 					$("input[type='checkbox'][value='"+childId+"']").removeProp("checked");
					$("input[type='checkbox'][value='"+childId+"']").prop("checked", false);
				}
			});
		}
	
		//加载资源treegrid
		function loadResourceTreegrid(){
			
			$('#resource_treegrid').treegrid({
// 				title:'资源信息列表',
				loadMsg:'数据加载中...',
			    iconCls:'icon-ok',
			    url : '${ctx}/sysman/resourceAction!getAllTeeNode.action',
			    idField : 'id',
				treeField : 'resourceName',
				parentField : 'parentId',
				//attrsField: ['url', 'resourceCode'], // easyui_tool.js 中扩展tree的loadFilter方法来添加自定义属性 
				animate:true,
				fit : true,
				fitColumns : true,
				border : false,
// 				showFooter:true,
				checkOnSelect: false,		//行选择映射到复选框
				selectOnCheck: false,		//复选框选择映射到行
				singleSelect: true,			//只允许选一行
			    columns:[[
			        {field:'id',title:'编码',align:'center',checkbox:true},
			        {field:'resourceName',title:'资源名称',width:200,align:'left'},
			        {field:'url',title:'资源路径',width:200,align:'left'},
			        {field:'statu',title:'状态',width:50,align:'center',formatter:function(value,row,index){
			        	if(value == 0){return "禁用";} else {return "可用";}
			        }},
			        {field:'nodeSort',title:'排序',width:50,align:'center'},
			        {field:'parentId',title:'上级资源编号',width:100,align:'center'},
			        {field:'parentName',title:'上级资源名称',width:150,align:'center'},
			        {field:'isMenu',title:'资源类型',width:100,align:'center'},
			        {field:'state',title:'资源节点状态',width:100,align:'center'},
			        {field:'action',title:'操作',width:100,align:'center',formatter: function(value,row,index){
			        	if(row.id == 0){
			        		return '根节点';
			        	} else {
				        	return "<securl:accessRight rightId='resourceManDetail'><img onclick='showResourceDetail(\""+row.id+"\");' title='查看' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/search.png'>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='resourceManEdit'><img onclick='editResource(\""+row.id+"\");' title='修改' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/pencil.png'/>&nbsp;&nbsp;</securl:accessRight>"+
				        			"<securl:accessRight rightId='resourceManDel'><img onclick='deleteResource(\""+row.id+"\");' title='删除' src='${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icons/cross_1.png'>&nbsp;</securl:accessRight>";
			        	}		
			        }}
			    ]],
			    onCheck: function(row, rowData){
			    	cascadeSelectChildren($(this), row, true, true);
			    },
			    onUncheck: function(row, rowData){
			    	cascadeSelectChildren($(this), row, false, false);			    	
			    },
			    onLoadSuccess: function(row, data){
			    	$(this).treegrid("hideColumn", "state");	//隐藏指定列
			    },
			    toolbar : '#resource_datagrid_toolbar' /* [ {此处工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						addUser();
					}
				}, '-', {
					text : '编辑',
					iconCls : 'icon-edit',
					handler : function() {
						editUser();
					}
				}, '-', {
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						deleteUser();
					}
				}, '-', {
					text : '刷新',
					iconCls : 'icon-reload',
					handler : function() {
						datagrid.treegrid('load');
					}
				}, '-', {
					text : '取消选中',
					iconCls : 'icon-undo',
					handler : function() {
						datagrid.treegrid('unselectAll');
					}
				}, '-' ] */
			});
		}
		
		//折叠节点
		function collseTree(){
			$('#resource_treegrid').treegrid("expandTo");
		}
		
		//条件查询
		function resourceSearch(){
			datagrid.datagrid('load',serializeObject($("#resource_searchForm")));
		}
		
		//显示资源详细信息
		function showResourceDetail(){
			
		}
		
		//添加资源信息
		function addResource(){
			
			$('#resource_treegrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			$("<div/>").attr("id","addResourceDialog").dialog({
				title: '添加资源信息',   
				href: '${ctx}/sysman/resourceAction!toAddResourcePage.action',   
				width: 700,
				height: 400,
				closed: false,
				modal: true,
				resizable: true,
				collapsible: true,
				maximizable: true,
				onClose: function() {
					$(this).dialog('destroy');
				}
			});
		}
		
		//加载资源编辑页面信息
		function editResource(resourceId){
			
			if(!checkValue(resourceId)){
				
				var checkedResourceObj = getCheckeds();	//获取选中的checkbox
				if($(checkedResourceObj).size() > 1){
					$.messager.alert('警告','操作有误，请单击选中要编辑的资源所在的行再编辑！','warning', function(){
						$(".datagrid-body").find(":checkbox:checked").prop("checked", false);
					});
					return;
				}
				
				var resourceObj = $("#resource_treegrid").treegrid("getSelected");
				if($(resourceObj).size() == 0){
					$.messager.alert('警告','请选则一条资源信息进行编辑','warning');
					return;
				}
				if($(resourceObj).size() > 1){
					$.messager.alert('警告','一次只能修改一条资源信息','warning');
					return;
				}
// 				resourceId = $(resourceObj).val();
				resourceId = resourceObj.id;
			}
			
			$("<div/>").attr("id","editResourceDialog").dialog({
				title: '编辑资源信息',   
				href: '${ctx}/sysman/resourceAction!toEditResourcePage.action?resource.id='+resourceId,
				width: 700,
				height: 400,
				closed: false,
				modal: true,
				resizable: true,
				collapsible: true,
				maximizable: true,
				onClose: function() {
					$(this).dialog('destroy');
				}
			});
		}
		
		//删除资源信息
		function deleteResource(resourceId){
			
 			//var rows = $("#resource_treegrid").treegrid("getChecked");
			var resourceIds = null; 
			var checkeds = getCheckeds();	//获取选中的checkbox
			if($(checkeds).size() > 0) {
				resourceIds = $(checkeds).serialize();	//批量删除
			} else {
				resourceIds = "id="+resourceId;	//单个删除
			}
 			//var ids = [];
			if($(checkeds).size() > 0 || resourceId){
				$.messager.confirm('请确认','确定删除该记录吗？',function(r){
					if(r){
						
						
 						/* for(var i=0;i<rows.length;i++){
 							ids.push(rows[i].id);
 						} */
						
						$.ajax({
							url: '${ctx}/sysman/resourceAction!deleteResource.action',
							data: resourceIds,
							type: "post",
							dataType: "json",
							cache: false,
							async: true,
							success: function(result){
								
								if(result.success){
									refreshTreegrid('resource_treegrid');
								}
								$.messager.show({
									title: '提示',
									msg: result.msg
								});
							},
							error:function(){
								$.messager.show({
									title: '提示',
									msg: '发送请求失败',
									timeout: 3000,
									showType: 'slide',
									style: {
										right: '',
										top: parent.document.body.scrollTop + parent.document.documentElement.scrollTop,
										bottom: ''
									}
								});
							}
						});
					}
				});
			} else {
				$.messager.show({
					title: '提示',
					msg: '请勾选要删除的记录',
					timeout: 3000,
					showType: 'slide',
					style: {
						right: '',
						top: document.body.scrollTop + document.documentElement.scrollTop,
						bottom: ''
					}
				});
			}
		}
		
		//页面数据初始化
		$(function(){
			loadResourceTreegrid();
		});
	</script>
</head>
<body class="easyui-layout">
<!-- 	<div> -->
	<div region="north" class="tableForm datagrid-toolbar" border="false" title="筛选条件" style="height: 94px;overflow: hidden;" align="left">
		<form id="resource_searchForm" action="${ctx}/sysman/resourceAction!findResourceList.action" method="post">
			<fieldset style="border: none; border: 1px solid #cccccc;">
				<legend style="color: #888888;">筛选条件</legend>
				<table class="tableForm search_table_form">
				<!-- <table class="tableForm datagrid-toolbar search_table_form"> -->
					<tbody>
						<tr>
							<td>资源名称</td>
							<td>
								<input name="resourceVo.resourceName" id="resourceName" style="width:317px;" />
								<a href="#" class="easyui-linkbutton" onclick="resourceSearch();">过滤</a>
								<a href="#" class="easyui-linkbutton" onclick="cancelSearch();">取消</a>
							</td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th>创建时间</th> -->
<!-- 							<td> -->
<!-- 								<input name="userVo.createTimeStart" id="createTimeStart" class="easyui-datetimebox"  -->
<!-- 									data-options="editable:false" style="width: 155px;" />至 -->
<!-- 								<input name="userVo.createTimeEnd" id="createTimeEnd" class="easyui-datetimebox"  -->
<!-- 									data-options="editable:false" style="width: 155px;" /> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<th>最后修改时间</th> -->
<!-- 							<td> -->
<!-- <!-- 								<input name="userVo.lastUpdateTimeStart" id="lastUpdateTimeStart" class="easyui-datetimebox"  -->
<!-- 									data-options="editable:false" style="width: 155px;" />至 -->
<!-- 								<input name="userVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" class="easyui-datetimebox"  -->
<!-- 									data-options="editable:false" style="width: 155px;" />  -->
<!-- 								<input name="userVo.lastUpdateTimeStart" id="lastUpdateTimeStart" style="width: 155px;"  -->
<!-- 									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>至 -->
<!-- 								<input name="userVo.lastUpdateTimeEnd" id="lastUpdateTimeEnd" style="width: 155px;" -->
<!-- 									onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"/>  -->
									
<!-- 								<a href="#" class="easyui-linkbutton" onclick="resourceSearch();">过滤</a>  -->
<!-- 								<a href="#" class="easyui-linkbutton" onclick="cancelSearch();">取消</a> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
			</fieldset>
		</form>
	</div>
	<div region="center" border="false">
		<table id="resource_treegrid"></table>
	</div>
	
	<!-- 工具栏按钮 ，之所以不使用js生成toolbar，是为了方便使用SpringSecurity的tag标签在页面进行细粒度鉴权显示控制 -->
	<div id="resource_datagrid_toolbar" class="datagrid-toolbar">
		<table>
			<tr>
				<securl:accessRight rightId='resourceManAdd'>
					<td><a href="#" onclick="addResource();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">增加</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId='resourceManEdit'>
					<td><a href="#" onclick="editResource();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId='resourceManDel'>	
					<td><a href="#" onclick="deleteResource();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>	
				
				<securl:accessRight rightId='resourceManImport'>
					<td><a href="#" onclick="refreshTreegrid('resource_treegrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导入</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<securl:accessRight rightId='resourceManExport'>	
					<td><a href="#" onclick="refreshTreegrid('resource_treegrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">导出</a></td>
					<td><div class=datagrid-btn-separator></div></td>
				</securl:accessRight>
				
				<td><a href="#" onclick="refreshTreegrid('resource_treegrid');" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a></td>
				<td><div class=datagrid-btn-separator></div></td>
				
				<td><a href="#" onclick="cancelChecked('resource_treegrid');" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">取消选中</a></td>
				<td><div class=datagrid-btn-separator></div></td>
			</tr>
		</table>
	</div>
	
</body>
</html>