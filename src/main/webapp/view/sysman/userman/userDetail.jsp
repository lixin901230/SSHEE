<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户信息</title>
</head>
<body style="margin: 0px 0px;">
<!-- 	<div class="form_table_div" style="width: 636px;height: 314px;"> -->
	<div class="form_table_div" style="width: 100%;height: 100%;">
		<form action="">
			<table class="form_table" style="width: 100%;">
				<tr>
					<th>用户名</th>
					<td><input type="text" id="" name="" value=""/></td>
					<th>密&nbsp;&nbsp;码</th>
					<td><input type="password" id="password" name="password" value=""/></td>
				</tr>
				<tr>
					<th>性&nbsp;&nbsp;别</th>
					<td><input type="text" id="" name="" value=""/></td>
					<th>手&nbsp;&nbsp;机</th>
					<td><input type="text" id="" name="" value=""/></td>
				</tr>
				<tr>
					<th>邮&nbsp;&nbsp;箱</th>
					<td><input type="text" id="" name="" value=""/></td>
					<th>用户状态</th>
					<td>
						<select>
							<option>-- 请选择 --</option>
							<option value="1">启用</option>
							<option value="3">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>角色</th>
					<td>
						<select>
							<option value="1">启用</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">描&nbsp;&nbsp;述</th>
					<td colspan="3"><textarea cols="40" rows="3"></textarea></td>
<!-- 					<th></th> -->
<!-- 					<td></td> -->
				</tr>
				
			</table>
			<div id="dlg-buttons" align="center" style="padding-bottom: 0px;padding-top: 15px;">
				<a href="javascript:void(0)" onclick="javascript:alert('save')" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" onclick="javascript:$('#editUserDialog').dialog('close');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
</body>
</html>