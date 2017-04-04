1、页面引入：jquery.whatyPager-1.1.6.js和jquery.whatyPager-1.1.6.css

2、初始化分页,数据返回支持html和json方式，此处已html数据返回方式为例：
/**
 * 加载课程通知分页列表
 */
$(function(){
	var courseId = $("#courseId").val();
	$("#question_contents").initWhatyPager({
		curPageNum: 1,
		pageSizeNum: 10,
		dataType : 'html',		//支持json
		pagerUrl: basePath+'/learn/blue/coursenotice/course_notice_list.action',
		pagerData: 'params.courseId='+courseId+'&params.curPage=1',
		pagerCallHandel: function(pageHtml, pagerParam) {	//pageData:分页数据，若dataType：'html'则此处pageHtml则为更新后的列表html片段（适合模板开发，不用js拼更新列表数据），若dataType：'json'则pageHtml为Page的json对象形式，自己解析page对象更新列表
			
			$("#notice_list").html(pageHtml);
		},
		setTotalCount : function(){	//dataType : 'html'类型时才需要次回调函数获取总记录数，此处后期有待优化
		    var totalCount = $("#page_totalCount").val();
		    return totalCount;
		}
	});
});


3.分页栏信息显示控制参数如下，详见插件核心js文件内的配置参数:
	isShowPageLinkToolBar: true,			//是否宣誓分页页码序列显示区域；默认true：显示；false:不显示
	isShowRowCountToolBar: true,			//是否显示总记录数
	isShowTotalPageToolBar: true,			//是否显示总页数
	isShowPageSizeSelectToolBar: false,		//是否显示页大小选择下拉选项
	isShowJumpPageToolBar: true,			//是否显示跳页栏
	isShowJumpPageToolBar: true,			//是否显示跳页栏