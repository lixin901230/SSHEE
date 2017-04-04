/**
 * 页面数据初始化
 */
$(function(){
	
	//获取编辑保存完后传递回来的当前页参数
//	var _curPageNum = isNotEmpty($("#curPageTemp").val()) ? parseInt($("#curPageTemp").val()) : 1;
//	var _curPageSize = isNotEmpty($("#pageSizeTemp").val()) ? parseInt($("#pageSizeTemp").val()) : 3;
	
	/**
	 * 初始化用户列表分页参数对象
	 */
	var setting = {
		pagerUrl: basePath + '/sysman/userAction!loadUserlistChildPage.action',	//分页查询url地址
		pagerData: 'requestPageFlag=userlist_data',	//分页列表条件查询参数
		dataType : 'html',				//默认为html方式；支持jquery ajax请求的所有数据类型，推荐使用html或者json格式，便于解析
		curPageNum: 1,//_curPageNum,
		pageSizeNum: 3,//_curPageSize,
		curPageMapperKey: 'pager.curPage',			//对应后台action中pager对象中的curPage属性，在插件中用于自动映射curPage的值到action中的pager对象中，以下四个属性亦同，具体使用视后台结构而定
		pageSizeMapperKey: 'pager.pageSize',
		pageNumGroup: {					
			showCount: 5,
			curPagePositions: 'left',
			isShowPrefix: true,			//前后缀显示控制，true：显示，false：不显示
			isShowSuffix: true,
			prefixCount: 2,
			suffixCount: 2,
			prefixMoreShowText: '...',
			suffixMoreShowText: '...'
		},
		pageSizeArr: [1, 2, 3, 5, 10, 15, 20, 30, 50, 80, 100],		//每页显示数数组
//		isShowPagerToolBarOnePage: true,					//只有一页时是否显示分页栏，true:显示；false:不显示
//		isShowPageLinkToolBar: true,						//是否宣誓分页页码序列显示区域；默认true：显示；false:不显示
//		isShowRowCountToolBar: true,						//是否显示总记录数
//		isShowTotalPageToolBar: false,						//是否显示总页数
//		isShowPageSizeSelectToolBar: false,					//是否显示页大小选择下拉选项
//		isShowJumpPageToolBar: true,						//是否显示跳页栏
		pagerCallHandel: function(pageHtml, pagerParam) {	//pageHtml：已渲染的分页列表子页面，pagerParam：url请求参数，如：key=v1&key2=v2&...
			$("#dataList").html(pageHtml);
		},
		setTotalCount : function(){
		    return $("#page_totalCount1").val();				//dataType：html时，需要在此回调函数中获取子页面更新的总记录数，dataType：json时泽此处不需要调用该回调函数
		}
	};
	/**
	 * 初始化用户列表分页参数对象
	 */
	var setting2 = {
		pagerUrl: basePath + '/sysman/userAction!loadUserlistChildPage.action',	//分页查询url地址
		pagerData: {		//分页列表条件查询参数
			requestPageFlag: 'userlist_data2',
		},	
		dataType : 'html',				//默认为html方式；支持jquery ajax请求的所有数据类型，推荐使用html或者json格式，便于解析
		curPageNum: 1,//_curPageNum,
		pageSizeNum: 2,//_curPageSize,
		curPageMapperKey: 'pager.curPage',			//对应后台action中pager对象中的curPage属性，在插件中用于自动映射curPage的值到action中的pager对象中，以下四个属性亦同，具体使用视后台结构而定
		pageSizeMapperKey: 'pager.pageSize',
		pageNumGroup: {					
			showCount: 5,
			curPagePositions: 'left',
			isShowPrefix: true,			//前后缀显示控制，true：显示，false：不显示
			isShowSuffix: true,
			prefixCount: 0,
			suffixCount: 0,
			prefixMoreShowText: '...',
			suffixMoreShowText: '...'
		},
		pageSizeArr: [1, 2, 3, 5, 10, 15, 20, 30, 50, 80, 100],		//每页显示数数组
//		isShowPagerToolBarOnePage: true,					//只有一页时是否显示分页栏，true:显示；false:不显示
//		isShowPageLinkToolBar: true,						//是否宣誓分页页码序列显示区域；默认true：显示；false:不显示
//		isShowRowCountToolBar: true,						//是否显示总记录数
//		isShowTotalPageToolBar: false,						//是否显示总页数
//		isShowPageSizeSelectToolBar: false,					//是否显示页大小选择下拉选项
//		isShowJumpPageToolBar: true,						//是否显示跳页栏
		pagerCallHandel: function(pageHtml, pagerParam) {	//pageHtml：已渲染的分页列表子页面，pagerParam：url请求参数，如：key=v1&key2=v2&...
			$("#dataList2").html(pageHtml);
		},
		setTotalCount : function(){
			return $("#page_totalCount2").val();				//dataType：html时，需要在此回调函数中获取子页面更新的总记录数，dataType：json时泽此处不需要调用该回调函数
		}
	};
	
	//初始化分页列表
	initUserListPager(setting, "#pagerToolBar");
	initUserListPager(setting2, "#pagerToolBar2");
	
	//删除用户
	deleteUser(setting);
	
	//编辑用户
	editUser();
	
	//编辑保存
	saveEditUser();
	
	//查看用户详情
	showUserDetail();
	
});

/**
 * 加载分页列表，数据类型为html方式
 */
function initUserListPager(options, pageToolBarId){
	$(pageToolBarId).whatyPager(options);
}

/**
 * 删除用户信息
 */
function deleteUser(setting){
	
	//初始化删除链接点击事件
	$("div[class='tableCase']").on("click", "#deleteUser", function(){

		var userId = $(this).parent("li").prop("id");
		if(!isNotEmpty(userId)) {
			alert("参数错误，userId不能为空！");
			return false;
		}
		
		$.ajax({
			url: basePath + "/sysman/userAction!deleteUser.action",
			data: {'id': userId},
			type: 'post',
			cache: false,
			async: false,
			success: function(data){
				
				if(data.success){
					//alert('删除成功！');
				}
				
				/*
				//方式一：自己计算新的总页数然后重新加载当前页
				var page = $.fn.initWhatyPager.getPage();
				var curPage = page.curPage;
				var totalPageTemp = Math.ceil((page.totalRow - 1) / page.pageSize);	//获取删除一条记录后的实际总页数
				if(totalPageTemp < curPage) {	//删除最后一页的唯一一条记录后，新的总页数会小于当前页，则默认当前页为最后新计算的最后一页
					curPage = totalPageTemp;
				}
				
				var opts = {
					curPageNum: curPage, 
					pageSizeNum: page.pageSize
				};
				
				$.extend(setting, opts || {});
				initUserListPager(setting);*/
				
				//方式二：使用插件内置的$.fn.initWhatyPager.reloadPager(reloadOptions);函数
				//$.fn.initWhatyPager.reloadPager({changeRowNum: -1});
				
				//v_1.1.9 调用方式调整
				$.fn.whatyPager("reloadPager", {changeRowNum: -1});
			},
			error: function(){alert('发送请求失败！');}
		});
	});
}

/**
 * 编辑用户信息
 */
function editUser(){
	
	//初始化删除链接点击事件
	$("div[class='tableCase']").off("click", "#editUser");
	$("div[class='tableCase']").on("click", "#editUser", function(){
		
//		var pageData = $.fn.initWhatyPager.getPage();
		var pageData = $("#pagerToolBar").whatyPager("getPage");;
		window.location.href= basePath + "/view/study/pagerdemo/user_edit.jsp?curPage="+pageData.curPage+"&pageSize="+pageData.pageSize;
		/*$.ajax({
			url: '',
			data: '',
			type: '',
			cache: false,
			async: false,
			success: function(data){
				
			},
			error: function(){alert('发送请求失败！');}
		});*/
	});
}

function saveEditUser(){
	
	$("#saveEdit").off("click");
	$("#saveEdit").on("click", function(){
		
		//以下代码应在保存编辑成功后的ajax的succes回调函数中
		var curPage = $("#curPageTemp").val();
		var pageSize = $("#pageSizeTemp").val();
//		window.location.href= basePath + '/view/study/pagerdemo/userlist.jsp?operateFlag=editSave&curPage='+curPage;
		window.location.href= basePath + '/sysman/userAction!loadUserListPage.action?operateFlag=editSave&pager.curPage='+curPage+"&pager.pageSize="+pageSize;
		/*$.ajax({
			url: basePath + '/sysman/userAction!loadUserListPage.action?operateFlag=editSave&pager.curPage='+curPage',
			data: 'pager.curPage='+curPage,
			type: 'POST',
			cache: false,
			async: false,
			success: function(data){
				
			},
			error: function(){alert('发送请求失败！');}
		});*/
	});
	
}

/**
 * 查看用户详细信息
 */
function showUserDetail(){
	
	//初始化删除链接点击事件
	$("div[class='tableCase']").on("click", "#showUserDetail", function(){
		
		$.ajax({
			url: '',
			data: '',
			type: '',
			cache: false,
			async: false,
			success: function(data){
				
			},
			error: function(){alert('发送请求失败！');}
		});
	});
}

