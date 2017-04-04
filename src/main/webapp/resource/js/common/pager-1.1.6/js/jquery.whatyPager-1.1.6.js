
/**
 * @DOTO: 分页插件 jquery.whatyPager-1.1.6.js，未完善版，正在优化中，支持jquery-1.9.1以上版本
 * 		1、优化代码结构
 * 		2、加入获取指定页包装器方法：$.fn.initWhatyPager.reloadPager(options);
 * 		3、加入创建HTML分页栏模板方法：$.fn.initPaperToolBar(options);	通过此方法可在插件儿内部自动创建默认分页栏模板
 * @version: version_1.1.6
 * @author: lixin
 */
(function($){
	
	var options = null;
	
	var methods = {
		
		/**
		 * 分页请求数据类型dataType为html时，需要调用此方法获取分页数据列表子页面中的总记录数
		 * @param totalCount
		 * @param pageSize
		 * @returns
		 */
		getTotalPage: function(totalCount,pageSize) {
			var count = 0;
			if (totalCount > 0) {
				var count = Math.floor(totalCount / pageSize);
				if (totalCount % pageSize > 0){
					count++;
				}
			}
			return count;
		},
		
		/**
		 * 更新分页控制栏
		 */
		updatePageShow: function(curPage,pageSize,totalCount) {
			
			var totalPage = this.getTotalPage(totalCount,pageSize);
			var currentPage = parseInt(curPage);
			$(options.rowCountSelector).text(totalCount);
			$(options.pageSizeSelector).val(pageSize);
			$(options.totalPageSelector).text(totalPage);
			$(options.currentPageSelector).val(currentPage);
			$(options.pageLinkSelector).html("");
			
			//如果当前页是最第一页则禁用首页和上一页操作，如果是最后一页则禁用下一页和尾页操作
			if(currentPage == 1) {
				
				$(options.nextPage +","+ options.lastPage).removeClass("p_disable");
				$(options.firstPage +","+ options.prePage).addClass("p_disable");
			} else if(currentPage == totalPage) {
				
				$(options.firstPage +","+ options.prePage).removeClass("p_disable");
				$(options.nextPage +","+ options.lastPage).addClass("p_disable");
			} else {
				
				$(options.firstPage +","+ options.prePage+","+options.nextPage +","+ options.lastPage).removeClass("p_disable");
			}
			
			//生成5个分页页码
			var pageLink = "";
			if (currentPage <= 3 && totalPage > 1) {
				$(options.pagelistSelector).css("display","block");
		        for (var i = 1; i <= (totalPage <= 5 ? totalPage : 5); i++) {
		            if (i == currentPage) {
						pageLink += "<li><a href='javascript:void(0);' class='p3 p_current'>" + i + "</a></li>";
					}else {
						pageLink += "<li><a href='javascript:void(0);' class='p3'>" + i + "</a></li>";
					}
		        }
		    }else if (currentPage > 3 && totalPage <= (currentPage + 2)) {  
		    	$(options.pagelistSelector).css("display","block");
		        for (var i = totalPage > 4 ? (totalPage - 4) : 1; i <= totalPage; i++) {
		        	if (i == currentPage) {
		 				pageLink += "<li><a href='javascript:void(0);' class='p3 p_current'>" + i + "</a></li>";
		 			}else {
	 					pageLink += "<li><a href='javascript:void(0);' class='p3'>" + i + "</a></li>";
		 			}
		        }  
		    }else if (currentPage > 3 && totalPage > (currentPage + 2)) {  
		    	$(options.pagelistSelector).css("display","block");
		        for (var i = currentPage - 2; i <= currentPage + 2; i++) {
		        	if (i == currentPage) {
		 				pageLink += "<li><a href='javascript:void(0);' class='p3 p_current'>" + i + "</li>";
		 			} else {
	 					pageLink += "<li><a href='javascript:void(0);' class='p3'>" + i + "</a></li>";
	 				}
		        }
		    } else if(totalPage < 2){
//		    	$(options.pagelistSelector).css("display","none");
		    }
			$(options.pageLinkSelector).html(pageLink);
			
			//更新分页栏后，重新初始化分页栏页码分页按钮事件
			this.initPageNum();
		},

		/**
		 * 分页按钮时间处理
		 */
		pageJump: function(btnType, curPage) {
			
			var currentPage = curPage ? curPage : $(options.currentPageSelector).val();
			var pageSize = $(options.pageSizeSelector).val();
			var totalPage = $(options.totalPageSelector).text();
			
			// 设置跳转页面开始记录数
			if (btnType == "start") {
				
				currentPage = 1;
			} else if (btnType == "previous") {
				
				currentPage = parseInt(currentPage) - 1;
				if (parseInt(currentPage) < 1) {
//					alert("已经是第一页了！");
					return;
				}
			} else if (btnType == "next") {
				
				currentPage = parseInt(currentPage) + 1;
				if (parseInt(currentPage) > parseInt(totalPage)) {
//					alert("已经是最后一页了！");
					return;
				}
			} else if (btnType == "end") {
				
				currentPage = totalPage;
			} else if (btnType == "jumpPageNum") {		//跳页
				
				var pageNum=$(options.pageNumSelector).val();
				var reg="^[0-9]*[1-9][0-9]*$";
				var re = new RegExp(reg);
		   	 	if(pageNum.match(re)==null){
		       	 	alert( "请输入大于零的整数!");
		      	  	return;
		   		}else{
		   			
		    		if(parseInt(pageNum) > parseInt(totalPage)){
		    			$(options.pageNumSelector).val(totalPage);
		    			currentPage = totalPage;
		    		}else{
		    			currentPage = pageNum;
		    		}
		   		}
			} else {
				currentPage  = btnType;	//页码序号
			}
			
			// 更新页面显示
			this.pageSubmit(currentPage, pageSize);
		},
		
		/**
		 * 分页查询
		 */
		pageSubmit: function(curPage, pageSize) {

			var _pagerData = "pager.pageSize="+ pageSize + "&" + options.pagerData;
			if(parseInt(curPage) > 1) {
				
				_pagerData = _pagerData.substring(0, _pagerData.lastIndexOf("=")+1) + curPage;
			}
//			alert("url："+options.pagerUrl+"\r\ndata："+_pagerData);
			
			var methodsObj = this;
			//这里后期需要将url参数（_pagerData）解析成json字符串返回给回调函数，方便页面分页查询后取条件查询参数
			//var pagerParam = _pagerData;	
			$.ajax({
				url: options.pagerUrl,
				data: _pagerData,
				type: 'post',
				dataType: options.dataType,
				cache: false,
				async: false,
				success: function(pageData){
					
					options.pagerCallHandel(pageData, _pagerData);	//更新列表数据
					var totalCount = 0;
					if(typeof options.setTotalCount === "function"){
						totalCount = options.setTotalCount.call(this); 
					}else if(options.dataType.toLowerCase()  == 'json'){
						totalCount = pageData.totalCount;
					}
					methodsObj.updatePageShow(curPage,pageSize,totalCount);	//更新分页控制栏数据
				},
				error: function(){
					alert("pager请求失败，请重试或联系管理员!");
				}
			});
		},
		
		/**
		 * 初始化分页栏页码分页
		 */
		initPageNum: function(){
			
			var methodsObj = this;
			$(options.pageLinkObjs).off("click");
			$(options.pageLinkObjs).on("click", function(){
				var _pageNum = $(this).text();
				methodsObj.pageJump(_pageNum);
			});
		},
		
		/**
		 * 初始化分页按钮事件（首页、上一页、下一页、尾页）
		 */
		initPageBtn: function(){
			
			var methodsObj = this;
			$(options.firstPage +","+ options.prePage+","+options.nextPage +","+ options.lastPage+","+ options.jumpPageNum).on("click", function(){
				var pagerBtnType = $(this).attr("id");
				var currentPage = $(options.currentPageSelector).val();
//				alert(idAttr+"====="+currentPage);
				methodsObj.pageJump(pagerBtnType, currentPage);
			});
		},
		
		/**
		 * 工具方法，控制分页栏元素隐藏显示
		 */
		showHide: function(toolBarSelector, isShow){
			if(isShow) {
				$(toolBarSelector).show().css("display", "block");
			} else {
				$(toolBarSelector).hide().css("display", "none");
			}
		},
		
		/**
		 * 初始化每页显示条数下拉框选项
		 */
		initPageSizeSelect: function(options){
			
			var methodsObj = this;
			if(options.isShowPageSizeSelectToolBar){	//如果显示页大小下拉选项，则初始化下拉选项
				
				var _pageSizeArr = options.pageSizeArr;
				if(_pageSizeArr.length > 0) {
					
					var selectOption = "";
					for(var i=0; i<_pageSizeArr.length; i++) {
						selectOption += '<option value="'+_pageSizeArr[i]+'">'+_pageSizeArr[i]+'</option>';
					}
					$(options.pageSizeSelectSelector).html(selectOption);
				}
				
				//给每页显示条数下拉选项初始化选择事件
				$(options.pageSizeSelectSelector).on("change", function(){
					var _pageSize = $(this).find("option:selected").val();
					methodsObj.pageSubmit(1, _pageSize);
				});
			}
		}
	};
	
	/**
	 * 初始化分页
	 */
	$.initPager = function(target, opts){
		
		//模式设置对象与初始化散列参数对象合并
		options = $.extend($.initPager.defaultSetting, opts || {});
		
		if(target != undefined && target != null && target != ""){
			
			$(target).initPaperToolBar();	//初始化分页栏html

			//初始化按钮事件处理函数
			methods.initPageNum();
			methods.initPageBtn();
			$.controlPaperToolBarShow(options);		//分页栏元素显示控制
			methods.initPageSizeSelect(options);	//初始化每页显示条数下拉选项
			
			//执行分页查询
			methods.pageSubmit(options.curPageNum, options.pageSizeNum);
		} else {
			
			alert("初始化分页栏失败！");
			return false;
		}
	};
	
	/**
	 * 初始化分页入口
	 */
	$.fn.initWhatyPager = function(options) {
		
		return this.each(function(){
			$.initPager(this, options);
		});
	};
	
	/**
	 * 获取分页信息对象，包含：当前页码、每页显示条数、总记录数、总页数
	 */
	$.fn.initWhatyPager.getPage = function(options){
		
		var page = {
			curPage: $(options.currentPageSelector).val(),
			pageSize: $(options.pageSizeSelector).val(),
			totalRowCount: $(options.rowCountSelector).text(),
			totalPageCount: $(options.totalPageSelector).val()
		};
		return page;
	};
	
	
	/**
	 * 重新加载分页数据，默认加载当前页，可通过options散列对象中的curPage指定加载第几页
	 * @params reloadPager_options 重新加载分页三列参数对象，改三列参数对象属性见：reloadDefualtSetting默认设置
	 */
	$.fn.initWhatyPager.reloadPager = function(reloadPager_options){
		
		return this.each(function(){
			
			//默认设置
			var reloadDefualtSetting = {
					curPageNum: 1,			//当前页码
					pageSizeNum: 10			//每页显示条数
			};
			
			reloadDefualtSetting = $.extend(reloadDefualtSetting, reloadPager_options || {});
//			reloadDefualtSetting = $.extend($.initPager.defaultSetting, reloadDefualtSetting || {});
			
			var _curPage = $(reloadDefualtSetting.currentPageSelector).val();
			var _pageSize = $(reloadDefualtSetting.pageSizeSelector).val();
			
			if(reloadDefualtSetting.curPageNum) {	//若未指定要加载第几页页码，则默认加载当前页
				_curPage = reloadDefualtSetting.curPageNum;
			}
			if(reloadDefualtSetting.pageSizeNum) {
				_pageSize = reloadDefualtSetting.pageSizeNum;
			}
			methods.pageSubmit(_curPage, _pageSize);
		});
	};
	
	/**
	 * 初始化分页栏默认模板
	 */
	$.fn.initPaperToolBar = function(optsions){
		
		return this.each(function() {
			
			 $(this).empty();
			 var paperToolBar = ""
				 + '<div id="pager_plugin">'
				 + '	<span id="pager_data" class="recordtotal">'
				 + '		<input type="hidden" id="currentPage" value="1"/>'	//当前页默认为1
				 + '		<input type="hidden" id="pageSize"></input>'
				 + '	</span>'
				 + '	<div id="pagelist" class="paging">'
				 + '		<ul>'
				 + '			<li><a href="javascript:void(0);" id="start" class="p1">首页</a></li>'
				 + '			<li><a href="javascript:void(0);" id="previous" class="p2">上一页</a></li>'
				 + '		</ul>'
				 + '		<ul id="toolBar_pageLink">'
				 + '			<li><a href="javascript:void(0);" class="p3 p_current">1</a></li>'
				 + ' 			<!-- <li><a href="javascript:void(0);" class="p3">2</a></li> -->'
				 + '		</ul>'
				 + '    	<ul>'
				 + '    		<li><a href="javascript:void(0);" id="next" class="p2">下一页</a></li>'
				 + '    		<li><a href="javascript:void(0);" id="end" class="p1">尾页</a></li>'
				 + '    		<li id="toolBar_totalPage"><span id="totalPage">1</span></li>'
				 + '    		<li id="toolBar_rowCount">/<font id="rowCount">0</font>页</li>'
				 + '    		<li id="toolBar_pageSizeSelect">&nbsp;&nbsp;每页<select id="pageSize_select"><option value="10">10</option></select>条</li>'
				 + '    		<li id="toolBar_jumpPage"><input type="text" id="pageNum" value=""/>页<a href="javascript:void(0);" id="jumpPageNum" class="p4">跳转</a></li>'
				 + '    	</ul>'
				 + '	</div>'
			 	+ ' </div>';
			 
//			 paperToolBar = optsions.paperToolBar || paperToolBar;
			 
			 var options = null;
			 var pageSizeArr = $.initPager.defaultSetting.pageSizeArr;
			 if(pageSizeArr) {
				 $.each($.initPager.defaultSetting.pageSizeArr, function(index, object){
					 
				 });
			 }
			 
			 $(this).html(paperToolBar);
		});
	};
	
	/**
	 * 分页具栏元素显示控制
	 */
	$.controlPaperToolBarShow = function(optsions){
		
		methods.showHide("#toolBar_pageLink", optsions.isShowPageLinkToolBar);
		methods.showHide("#toolBar_rowCount", optsions.isShowRowCountToolBar);
		methods.showHide("#toolBar_totalPage", optsions.isShowTotalPageToolBar);
		methods.showHide("#toolBar_pageSizeSelect", optsions.isShowPageSizeSelectToolBar);
		methods.showHide("#toolBar_jumpPage", optsions.isShowJumpPageToolBar);
	};
	
	/**
	 * 插件参数默认值 
	 */
	$.initPager.defaultSetting = {
		
		pagelistSelector: '#pagelist',				//分页div，控制当列表数据不超过1页时，隐藏分页栏
		pageLinkSelector: '#toolBar_pageLink',		//页码显示区域
		pageLinkObjs: '#toolBar_pageLink li a',		//显示的所有页码
		
		rowCountSelector: '#rowCount',				//分页栏：总条数显示区域
		pageSizeSelector: '#pageSize',				//每页显示条数隐藏域
		currentPageSelector: '#currentPage',		//当前页隐藏域
		totalPageSelector: '#totalPage',			//分页栏：总页数显示区域
		pageNumSelector: '#pageNum',				//跳页输入栏
		pageSizeSelectSelector:	'#pageSize_select',	//每页显示条数下拉选择框
		
		//首页、上一页、下一页、尾页、跳页
		firstPage: "#start",
		prePage: "#previous",
		nextPage: "#next", 
		lastPage: "#end", 
		jumpPageNum: "#jumpPageNum",
		
		//控制分页栏元素显示
		isShowPageLinkToolBar: true,				//是否宣誓分页页码序列显示区域；默认true：显示；false:不显示
		isShowRowCountToolBar: true,				//是否显示总记录数
		isShowTotalPageToolBar: true,				//是否显示总页数
		isShowPageSizeSelectToolBar: false,			//是否显示页大小选择下拉选项
		isShowJumpPageToolBar: true,				//是否显示跳页栏
		
		//后台参数映射名称
		curPageMapperKey: 'pager.curPage',
		pageSizeMapperKey: 'pager.pageSize',
		totalRowMapperKey: 'pager.totalRow',
		totalPageMapperKey: 'pager.totalPage',
		
		dataType : 'html',                      	//分页请求返回的数据类型，支持json、html
		curPageNum: 1,								//当前页码
		pageSizeNum: 10,							//每页显示条数
		pageSizeArr: [10, 15, 20, 30, 50, 80, 100],	//每页显示数数组
		pagerUrl: '',								//分页请求URL
		pagerData: '',								//分页请求参数，注意：分页参数curPage必须放到最后；如：param.curPage=1
		
		
		pagerCallHandel: function(){},				//分页数据处理回调函数
		setTotalCount:null                 			//设置记录数，返回一个整数
	};
	
})(jQuery);