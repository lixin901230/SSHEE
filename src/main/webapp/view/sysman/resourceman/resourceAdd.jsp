<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加资源信息</title>
	<%@ include file="../../common/head.jsp" %>
</head>
<body style="margin: 0px 0px;">
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form id="addResourceForm" action="" method="post">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>资源名称</th>
					<td><input type="text" id="resourceName" name="resource.resourceName" value=""/></td>
					<th>资源代码</th>
					<td><input type="text" id="resourceCode" name="resource.resourceCode" value=""/></td>
				</tr>
				<tr>
					<th>节点类型</th>
					<td>
						<select id="isMenu" name="resource.isMenu">
							<option>-- 请选择 --</option>
							<option value="0">模块</option>
							<option value="1">菜单</option>
							<option value="2">功能点</option>
						</select>
					</td>
					<th>节点状态</th>
					<td>
						<select id="state" name="resource.state">
							<option>-- 请选择 --</option>
							<option value="open" selected="selected">打开</option>
							<option value="closed">折叠</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>资源路径 </th>
					<td colspan="3"><input type="text" id="url" name="resource.url" value="" style="width: 70%;"/></td>
					<th></th>
					<td></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input type="text" id="createTime" name="resource.createTime" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',skin:'default'});" class="Wdate" style="height: 22px;"/></td>
					<th>上级资源</th>
					<td><input type="text" id="parentResourceName" name="resource.parentResourceName" value=""/>
						<input type="hidden" id="parentId" name="resource.parentId" value=""/>
						<input type="button" id="clearComboTreeVal" onclick="clearComboTreeValue();" value="清空"/></td>
				</tr>
				
				<tr>
					<th>资源排序</th>
					<td><input id="nodeSort" name="resource.nodeSort" class="easyui-numberspinner" style="width:90px;" data-options="value:1,min:1,max:1000,editable:true">
<!-- 						<input type="text" id="nodeSort" name="resource.nodeSort" value="" style="width: 90px;"/> -->
					</td>
					<th>资源状态</th>
					<td>
						<select id="statu" name="resource.statu">
							<option value="-1">-- 请选择 --</option>
							<option value="1" selected="selected">启用</option>
							<option value="2">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">资源图标</th>
					<td colspan="3"><input id="resorce_iconCls_combobox" name="resource.iconCls" value=""/></td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">描&nbsp;&nbsp;述</th>
					<td colspan="3"><textarea name="resource.remark" cols="40" rows="3"></textarea></td>
				</tr>
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 5px;padding-top: 5px;">
				<a href="#" onclick="addSaveResource();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="#" onclick="closeDialog('#addResourceDialog');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	
		//设置时间空间默认为当前时间
		function setCreateTime(){
			var currDateTime = getCurrDateTime();
			//词句有问题，建议使用mydatepicker97设置插件的默认值
			//$("#createTime").val(currDateTime);
		}
	
		//菜单图标combobox数据加载
		function resourceIconClsCombobox(){
			$("#resorce_iconCls_combobox").combobox({
				url: '${ctx}/resource/js/iconData.json',
				valueField: 'value',
				textField: 'text',
				panelHeight: '240',
				panelWidth: '200',
				formatter: function(row){
					if(row){
						return formatString('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span> {1}', row.value, row.text);
					}
				}
			});
		}
		
		//初始化资源Combotree
		function initResCombotree(){
			$("#parentResourceName").combotree({
				//继承自combo的属性
				editable: false,
				panelWidth: 230,
				panelHeight: 300,
				//value:'请选择...',
				required: true,
				
				//继承自tree的属性				
				iconCls: 'icon-save',
				url: '${ctx}/sysman/resourceAction!getAllTeeNode.action',
				id: 'id',
				parentField: 'parentId',
				lines: true,
				checkbox: true,
				animate: true,
				onClick: function(none){
					if(none){
						$("#parentId").val(none.id);
					}
				}
			});
		}
		
		//清空资源combotree的值
		function clearComboTreeValue(){
			
			$("#parentResourceName").combotree('setValue','');
			$("#parentResourceName").combotree('setText','');
			$("#parentId").val('');
		}
		
		//是否为菜单选项处理
		function isMenuDeal(){
			
			$("#isMenu").change(function(){
				
				var selectedOpt = $(this).find("option:selected");
				var selectedVal = $(selectedOpt).val();
				
				if(selectedVal == 0){	//如果是模块时，禁用url输入框和菜单节点状态下拉框
					$("#state, #url").attr("disabled", "disabled").css("backgroud-color","#c5c5c5");
				}
				if(selectedVal == 2){	//如果是功能点时，启用url输入框禁用菜单节点状态下拉框
					$("#state").attr("disabled", "disabled").css("backgroud-color","#c5c5c5");
					$("#url").removeAttr("disabled").removeAttr("backgroud-color");
				}
				if(selectedVal == 1){		//如果是菜单时，启用url输入框和菜单节点状态下拉框
					$("#state, #url").removeAttr("disabled").removeAttr("backgroud-color");
				}
			});
		}
		
		//保存新建资源信息
		function addSaveResource(){
			
			$.ajax({
				url: '${ctx}/sysman/resourceAction!addSaveResource.action',
				type: 'post',
				data: $("#addResourceForm").serialize(),
				cache: false,
				async: true,
				success: function(data){
					refreshTreegrid('resource_treegrid');
				},
				error: function(){$.messager.alert('错误','发送请求失败','error');}
			});
			closeDialog('#addResourceDialog');
		}
		
		$(function(){
			initResCombotree();
			isMenuDeal();
			resourceIconClsCombobox();
			setCreateTime();
		});
	</script>
</body>
</html>