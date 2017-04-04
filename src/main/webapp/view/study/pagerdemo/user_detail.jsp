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
	
	<title>jquery ajax分页插件使用demo</title>
	<style type="text/css"> 
/* 		body{ width:auto; height:auto; padding:0; margin:20px 0; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; }  */
		.tableFrame ul{ clear:both; padding:0; margin:0; list-style:none; } 
		.tableFrame{ 
			width:625px; height:auto; border-top:#000 1px solid; border-left:#000 1px solid; padding:0; margin:0 auto; font-size:12px; 
		} 
		.tableFrame:after { content: "."; display: block; height: 0; clear: both; visibility: hidden; } 
		.tableFrame li{ 
			float: left; display: block; width:120px; height:auto; padding:2px; margin:0; 
			border-right:#000 1px solid; border-bottom:#000 1px solid; line-height:16px; color:000;
			text-align: center;
		} 
		
		/* 表格标题*/ 
		.tableFrameTitle ul{} 
		.tableFrameTitle ul li{ background:gray; text-align:center; color:#fff; } 
		
		/* 表格内容*/ 
		.tableCase ul{} 
		.tableCase ul li{} 
		
		/* 单个表格特定样式*/ 
		.tableCaseThree{color:#329A02;} 
		.tableCaseFive{color:#f00;} 
		.tableCaseSeven{color:#f00;} 
	</style> 
	<script type="text/javascript">
		
		var setting = {
			pagerUrl: '${ctx}/sysman/userAction!loadUserlistChildPage.action',
			pagerData: 'pager.curPage=1',		//curPage参数必须放到最后一个
			dataType : 'html',	//默认为html方式；支持jquery ajax请求的所有数据类型，推荐使用html或者json格式，便于解析
			curPageNum: 1,
			pageSizeNum: 3,
			pageSizeArr: [3, 5, 10, 15, 20, 30, 50, 80],	//每页显示数数组
			isShowPageLinkToolBar: true,					//是否宣誓分页页码序列显示区域；默认true：显示；false:不显示
			isShowRowCountToolBar: true,					//是否显示总记录数
			isShowTotalPageToolBar: true,					//是否显示总页数
			isShowPageSizeSelectToolBar: true,				//是否显示页大小选择下拉选项
			isShowJumpPageToolBar: true,					//是否显示跳页栏
			pagerCallHandel: function(pageHtml, pagerParam) {	//pageData:分页对象json数据
				$("#dataList").html(pageHtml);
			},
			setTotalCount : function(){
			    var totalCount = $("#page_totalCount").val();
			    return totalCount;
			}
		};
	
		//加载分页列表，数据类型为html方式
		function initCourseNoticeListPager(options){
			
			$("#pagerToolBar").initWhatyPager(options);
		}
		
		//页面数据初始化
		$(function(){
			initCourseNoticeListPager(setting);
		});
	</script>
	
</head>
<body>

	<div class="tableFrame">
		<div class="tableFrameTitle">
			<ul>
				<li>用户名</li>
				<li>性别</li>
				<li>邮箱</li>
				<li>手机</li>
				<li>操作</li>
			</ul>
		</div>
		<div class="tableCase" id="dataList">
			
		</div>
	</div>
	<center>
		<div id="pagerToolBar" style="margin: 0 auto; width: 625px;"></div>
	</center>
</body>
</html>