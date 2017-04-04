<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript"  src="${ctx}/resource/js/common/jquery-1.9.1.min.js" ></script>
<script type="text/javascript"  src="${ctx}/resource/js/common/commonTool.js" ></script>

<script type="text/javascript" src="${ctx}/resource/plugin/jquery.cookie.js" ></script>
<%-- <script type="text/javascript" src="${ctx}/resource/plugin/jquery.blockUI.js" ></script> --%>

<script type="text/javascript" src="${ctx}/resource/plugin/My97DatePicker-4.72/WdatePicker.js" ></script>

<!-- easyui -->
<script type="text/javascript" src="${ctx}/resource/plugin/jquery-easyui-1.3.4/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${ctx}/resource/plugin/jquery-easyui-1.3.4/locale/easyui-lang-zh_CN.js" ></script>
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css"></link>
<link href="${ctx}/resource/plugin/jquery-easyui-1.3.4/themes/icon.css" rel="stylesheet" type="text/css" />

<!-- easyui portal插件 -->
<link rel="stylesheet" href="${ctx}/resource/plugin/jquery-easyui-portal/portal.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/resource/plugin/jquery-easyui-portal/jquery.portal.js" charset="utf-8"></script>

<!-- <script type="text/javascript" src="/resource/plugin/jquery-validation-1.11.1/dist/jquery.validate.min.js" ></script>
<script type="text/javascript" src="/resource/plugin/jquery-validation-1.11.1/localization/messages_zh.js" ></script>

<link href="/resource/plugin/jquery-validation-engine-2.6.2/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resource/plugin/jquery-validation-engine-2.6.2/js/languages/jquery.validationEngine-zh_CN.js" ></script>
<script type="text/javascript" src="/resource/plugin/jquery-validation-engine-2.6.2/js/jquery.validationEngine.js" ></script>

<link href="/resource/plugin/jquery-ztree-v3.5.14/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resource/plugin/jquery-ztree-v3.5.14/js/jquery.ztree.all-3.5.min.js" ></script>

<link href="/resource/plugin/passwordStrength-my/zhuce.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resource/plugin/passwordStrength-my/passwordStrength.js" ></script>

<script type="text/javascript" src="${ctx}/resource/plugin/xheditor-1.1.14/xheditor-1.1.14-zh-cn.min.js" charset="utf-8"></script>
-->

<!-- easyui tree 扩展 解决easyui tree的checkbox禁用问题 -->
<link href="${ctx}/resource/js/easyui_extends/easyui_tree_extends/easyui_tree_disableCheckbox_extends.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/resource/js/easyui_extends/easyui_tree_extends/easyui_tree_disableCheckbox_extends.js"></script>

<!-- easyui treegrid 扩展 解决easyui treegrid中checkbox级联选中问题 -->
<%-- <script type="text/javascript" src="${ctx}/resource/js/easyui_extends/easyui_extend_treegridCascadeCheckbox.js"></script> --%>

<!-- Easyui layout 折叠后显示title扩展 -->
<script type="text/javascript" src="${ctx}/resource/js/easyui_extends/easyui_extend_expandPanel_title.js"></script>


<!-- 自定义 -->
<link href="${ctx}/resource/css/framecss.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resource/css/iconCls_extends.css" rel="stylesheet" type="text/css" />

<%-- <script type="text/javascript" src="${ctx}/resource/js/jquery.parser.js"></script> --%>
<script type="text/javascript" src="${ctx}/resource/js/easyui_tool.js" ></script>
<script type="text/javascript" src="${ctx}/resource/js/frame_index.js" ></script>

<!-- 全局变量，项目根路径 -->
<script type="text/javascript">
<!--
	var path = "<%=path%>";
	var basePath = "<%=basePath%>";
	var ctx = $("#ctx").val();
// 	console.info(path+"\n\t"+basePath+"\n\t"+ctx);//输出信息到firedebug的console中
//-->
</script>
