
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
		_getTotalPage: function(totalCount,pageSize) {
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
		_updatePageShow: function(curPage, pageSize, totalCount) {
			
			var totalPage = this._getTotalPage(totalCount, pageSize);
			
//			$(options.showCurPage).text(curPage);
			var currentPage = parseInt(curPage);
			$(options.rowCountSelector).text(totalCount);
			$(options.pageSizeSelector).val(pageSize);
			$(options.totalPageSelector).text(totalPage);
			$(options.currentPageSelector).val(currentPage);
			$(options.pageNumSelector).val(currentPage);
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
			
			if(totalPage > 1){
				$("#pager_plugin").parent().show();
			} else {
				$("#pager_plugin").parent().hide();
			}
			
			//生成5个分页页码
			var pageLink = "";
			if (currentPage <= 3 && totalPage > 0) {
				$(options.pagelistSelector).css("display","block");
		        for (var i = 1; i <= (totalPage <= 5 ? totalPage : 5); i++) {
		            if (i == currentPage) {
						pageLink += "<li><a href='#' class='p3 p_current'>" + i + "</a></li>";
					}else {
						pageLink += "<li><a href='#' class='p3'>" + i + "</a></li>";
					}
		        }
		    }else if (currentPage > 3 && totalPage <= (currentPage + 2)) {  
		    	$(options.pagelistSelector).css("display","block");
		        for (var i = totalPage > 4 ? (totalPage - 4) : 1; i <= totalPage; i++) {
		        	if (i == currentPage) {
		 				pageLink += "<li><a href='#' class='p3 p_current'>" + i + "</a></li>";
		 			}else {
	 					pageLink += "<li><a href='#' class='p3'>" + i + "</a></li>";
		 			}
		        }  
		    }else if (currentPage > 3 && totalPage > (currentPage + 2)) {  
		    	$(options.pagelistSelector).css("display","block");
		        for (var i = currentPage - 2; i <= currentPage + 2; i++) {
		        	if (i == currentPage) {
		 				pageLink += "<li><a href='#' class='p3 p_current'>" + i + "</li>";
		 			} else {
	 					pageLink += "<li><a href='#' class='p3'>" + i + "</a></li>";
	 				}
		        }
		    } else if(totalPage < 2 && !options.isShowPagerToolBarOnePage){
		    	$(options.pagelistSelector).css("display", "none");
		    }
			$(options.pageLinkSelector).html(pageLink);
			
			//更新分页栏后，重新初始化分页栏页码分页按钮事件
			this._initPageNum();
		},

		/**
		 * 分页按钮事件处理
		 */
		_pageJump: function(btnType, curPage) {
			
			var currentPage = curPage ? curPage : $(options.currentPageSelector).val();
			var pageSize = $(options.pageSizeSelector).val();
			var totalPage = $(options.totalPageSelector).text();
			
			// 设置跳转页面开始记录数
			if (btnType == "start") {
				
				currentPage = 1;
			} else if (btnType == "previous") {
				
				currentPage = parseInt(currentPage) - 1;
				if (parseInt(currentPage) < 1) {
					if(options.isOpenLimitPagerPrompt) {
						alert("已经是第一页了！");
					}
					return;
				}
			} else if (btnType == "next") {
				
				currentPage = parseInt(currentPage) + 1;
				if (parseInt(currentPage) > parseInt(totalPage)) {
					if(options.isOpenLimitPagerPrompt) {
						alert("已经是最后一页了！");
					}
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
			this._pageSubmit(currentPage, pageSize);
		},
		
		/**
		 * 分页查询
		 */
		_pageSubmit: function(curPage, pageSize) {
			
			options = $.extend(options, {curPageNum: curPage, pageSizeNum: pageSize});
			
//			var searchParam = methods._getSearchParam();	//获取合并了分页参数和条件查询参数字符串
			var pagerParam = methods._getPageParam();
			var searchParam = options.pagerData;
//			alert("url："+options.pagerUrl+"\r\ndata："+searchParam+"\r\npagerParam："+pagerParam);
			
			$.ajax({
				url: options.pagerUrl + "?" + pagerParam,//url后面传递分页参数
				data: searchParam,	//条件查询参数，可能是string、json、或者jsonArray
				type: 'post',
				dataType: options.dataType,
				cache: false,
				async: false,
				success: function(pageData){
					
					options.pagerCallHandel(pageData, searchParam);	//更新列表数据,这里最好将查询参数（searchParam）解析成json字符串返回给回调函数，方便页面分页查询后取条件查询参数
					var totalCount = 0;
					if(typeof options.setTotalCount === "function"){
						totalCount = options.setTotalCount.call(this); 
					}else if(options.dataType.toLowerCase()  == 'json'){
						totalCount = pageData.totalRow;
					}
					methods._updatePageShow(curPage, pageSize, totalCount);	//更新分页控制栏数据
				},
				error: function(){
					alert("pager请求失败，请重试或联系管理员!");
				}
			});
		},
		
		/**
		 * 获取分页参数
		 */
		_getPageParam: function(){
			return options.pageSizeMapperKey +"=" + options.pageSizeNum + "&" + options.curPageMapperKey + "=" + options.curPageNum;
		},
		
		/**
		 * 获取分页条件查询条件参数
		 */
		_getSearchParam: function(){
			
			var searchParam = options.pagerData;	//查询参数
			if(!methods.isNotEmpty(searchParam)) {
				
				return methods._getPageParam();
			} else {
				if(typeof searchParam === "string") {	//说明查询参数为字符串结构，如："name=vic&age=90&sex=男"
					
					searchParam += "&"+ methods._getPageParam();	//讲分页参数
				} else if(searchParam.indexOf("{") > -1 && searchParam.indexOf("[") == -1){	//纯json对象参数；如：{name:'vic',age:'90',sex:'男'}
					
				} else if(searchParam.indexOf("[") > -1 && searchParam.indexOf("{") > -1){	//数组；如：[{name:'vic'},{age:'90'},{sex:'男'}]{foo:["bar1", "bar2"]}
					
				} else {
					alert("分页查询参数结构不支持，请按jQuery Ajax data属性的标准传值形式传输！");
				}
			}
			return searchParam;
		},
		
		/**
		 * 初始化分页栏页码分页
		 */
		_initPageNum: function(){
			
			$(options.pageLinkObjs).off("click");
			$(options.pageLinkObjs).on("click", function(){
				var _pageNum = $(this).text();
				methods._pageJump(_pageNum);
			});
		},
		
		/**
		 * 初始化分页按钮事件（首页、上一页、下一页、尾页）
		 */
		_initPageBtn: function(){
			
			$(options.firstPage +","+ options.prePage+","+options.nextPage +","+ options.lastPage+","+ options.jumpPageNum).on("click", function(){
				var pagerBtnType = $(this).attr("id");
				var currentPage = $(options.currentPageSelector).val();
				methods._pageJump(pagerBtnType, currentPage);
			});
		},
		
		/**
		 * 工具方法，判断传入字符是否为空
		 * 		true: 不为空；false: 为空
		 * @param str
		 * @returns {Boolean}
		 */
		isNotEmpty: function(str){
			
			var isEmpty = false;
			if(str != null && str != "" && str != 'undefined'){
				isEmpty = true;
			}
			return isEmpty;
		},
		
		/**
		 * 将数字字符串转换为Number类型
		 * @param str
		 */
		convertStrToNumber: function(str){
			
			if(!methods.isNotEmpty(str)) {
				alert("["+str+"]不能为空！");
				return;
			}
			if(isNaN(str)) {
				alert("["+str+"]不是数字字符！");
				return;
			}
			return parseInt(str);
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
		_initPageSizeSelect: function(options){
			
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
					methods._pageSubmit(1, _pageSize);
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
//		target.data('_pagerData', options);
		if(target != undefined && target != null && target != ""){
			
			$(target).initPaperToolBar();	//初始化分页栏html

			//初始化按钮事件处理函数
			methods._initPageNum();
			methods._initPageBtn();
			methods._initPageSizeSelect(options);	//初始化每页显示条数下拉选项
			$.controlPaperToolBarShow(options);		//分页栏元素显示控制
			
			//执行分页查询
			methods._pageSubmit(options.curPageNum, options.pageSizeNum);
		} else {
			
			alert("初始化分页栏失败！");
			return false;
		}
	};
	
	/**
	 * 内部方法调用总入口
	 * @param {String}
	 *            method (optional) action
	 */
	 /*$.fn.initWhatyPagerMethodCall = function(method) {

		 var form = $(this);
		 if(!form[0]) return form;  // stop here if the form does not exist

		 if (typeof(method) == 'string' && method.charAt(0) != '_' && methods[method]) {

			 // make sure init is called once
			 if(method != "showPrompt" && method != "hide" && method != "hideAll")
			 methods.init.apply(form);

			 return methods[method].apply(form, Array.prototype.slice.call(arguments, 1));
		 } else if (typeof method == 'object' || !method) {

			 // default constructor with or without arguments
			 methods.init.apply(form, arguments);
			 return methods.attach.apply(form);
		 } else {
			 $.error('Method ' + method + ' does not exist in jQuery.validationEngine');
		 }
	};*/
	
	/**
	 * 分页插件初始化总入口
	 */
	$.fn.initWhatyPager = function(options) {
		
		return this.each(function(){
			$.initPager(this, options);
		});
	};
	
	/**
	 * 获取分页信息对象，包含：当前页码、每页显示条数、总记录数、总页数
	 */
	$.fn.initWhatyPager.getPage = function(){
		
		return {
			curPage: $(options.currentPageSelector).val(),
			pageSize: $(options.pageSizeSelector).val(),
			totalRow: methods.convertStrToNumber($(options.rowCountSelector).text()),
			totalPage: methods.convertStrToNumber($(options.totalPageSelector).text())
		};
	};
	
	/**
	 * 重新加载分页数据，默认加载当前页，可通过options散列对象中的curPage指定加载第几页
	 * @params reloadOptions 重新加载分页三列参数对象，该散列参数对象属性见：reloadDefualtSetting默认设置
	 */
	$.fn.initWhatyPager.reloadPager = function(reloadOptions){
		
		var pageData = $.fn.initWhatyPager.getPage();
		var _curPage = pageData.curPage;
		var _pageSize = pageData.pageSize;
	
		//默认设置
		var reloadDefualtSetting = {
			curPageNum: _curPage || 1,			//当前页码
			pageSizeNum: _pageSize || 10,		//每页显示条数
			changeRowNum: 0,		//减去或新增的记录数
			loadPage: 'curPage'		//属性loadType:'add'时（添加操作后），loadPage属性才生效，重新加载分页时去到哪页；'firstPage':首页、'curPage': 当前页、'lastPage':末页
		};
		
		//合并对象参数
		reloadDefualtSetting = $.extend(reloadDefualtSetting, reloadOptions || {});
		//reloadDefualtSetting = $.extend($.initPager.defaultSetting, reloadDefualtSetting || {});
		
		var changeRowNum = methods.convertStrToNumber(reloadDefualtSetting.changeRowNum);	//改变的记录数
		if(changeRowNum < 0) {				//删除
			
			var newTotalRow = methods.convertStrToNumber(pageData.totalRow) + methods.convertStrToNumber(changeRowNum);
			var newTotalPage = Math.ceil(newTotalRow / _pageSize);	//获取删除n条记录后的实际总页数
			if(newTotalPage < _curPage) {	//若总页数小于原来的当前页，则默认当前页为最后一页
				_curPage = newTotalPage;
			}
		} else  if(changeRowNum > 0) {		//添加
			
			var loadPage = reloadDefualtSetting.loadPage;
			if(loadPage == 'firstPage') {		//首页
				
				_curPage = 1;
			} else if(loadPage == 'lastPage') {	//末页
				
				var newTotalRow = methods.convertStrToNumber(pageData.totalRow) + methods.convertStrToNumber(changeRowNum);
				_curPage = Math.ceil(newTotalRow / _pageSize);	//获取添加n条记录后的实际总记录数，并设置当前页尾最后一页
			} else if(loadPage == 'curPage'){	//当前页
				
				//_curPage = pageData.curPage;	默认的就是为当前页
			} else {
				
				alert("参数错误；\n如：$.fn.initWhatyPager.reloadPager(loadPage: 'firstPage|curPage|lastPage'});");
				return false;
			}
		} else if(changeRowNum = 0) {		//刷新当前页
			
			//_curPage = pageData.curPage;	默认的就是为当前页
		} else {
			
			console.info("reloadPager调用参数错误; \n如：$.fn.initWhatyPager.reloadPager({changeRowNum: -1|1|0, loadType: 'refresh|delete|add'});");
			alert("reloadPager调用参数错误; \n如：$.fn.initWhatyPager.reloadPager({changeRowNum: -1|1|0, loadType: 'refresh|delete|add'});");
			return false;
		}
		methods._pageSubmit(_curPage, _pageSize);
	};
	
	/**
	 * 初始化分页栏默认模板
	 */
	$.fn.initPaperToolBar = function(optsions){
		
		return this.each(function() {
			
			 $(this).empty();
			 var paperToolBar = ""
				 + '<div id="pager_plugin" class="pager_plugin"><div >'
				 + '	<span id="pager_data" class="recordtotal">'
				 + '		<input type="hidden" id="currentPage" value="1"/>'	//当前页默认为1
				 + '		<input type="hidden" id="pageSize"/>'
				 + '	</span>'
				 + '	<div id="pagelist" class="paging">'
				 + '		<ul>'
				 + '			<li><a href="#" id="start" class="p1">首页</a></li>'
				 + '			<li><a href="#" id="previous" class="p2">上一页</a></li>'
				 + '		</ul>'
				 + '		<ul id="toolBar_pageLink">'
				 + '			<li><a href="#" class="p3 p_current">1</a></li>'
				 + ' 			<!-- <li><a href="#" class="p3">2</a></li> -->'
				 + '		</ul>'
				 + '    	<ul>'
				 + '    		<li><a href="#" id="next" class="p2">下一页</a></li>'
				 + '    		<li><a href="#" id="end" class="p1">尾页</a></li>'
//				 + '    		<li id="toolBar_curPage"><span id="showCurPage">1</span>/</li>'
				 + '    		<li id="toolBar_totalPage">共<span id="showTotalPage">1</span>页</li>'
				 + '    		<li id="toolBar_rowCount">　共<span id="showRowCount">0</span>条</li>'
				 + '    		<li id="toolBar_jumpPage">　跳到<input type="text" id="pageNum" value=""/>页<a href="#" id="jumpPageNum" class="p4">跳转</a></li>'
				 + '    		<li id="toolBar_pageSizeSelect">每页<select id="pageSize_select"><option value="10">10</option></select>条</li>'
				 + '    	</ul>'
				 + '	</div></div>'
			 	+ ' </div>';
			 
//			 paperToolBar = optsions.paperToolBar || paperToolBar;
			 
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
		if(optsions.isShowPageLinkToolBar) {
			$(options.pageLinkSelector).show().css("display", "");
		} else {
			$(options.pageLinkSelector).hide().css("display", "none");
		}
		methods.showHide(options.pageRowCountSelector, optsions.isShowRowCountToolBar);
		methods.showHide(options.pageTotalPageSelector, optsions.isShowTotalPageToolBar);
		methods.showHide(options.pageSizeSelectToolBarSelector, optsions.isShowPageSizeSelectToolBar);
		methods.showHide(options.pageJumpPageSelector, optsions.isShowJumpPageToolBar);
	};
	
	/**
	 * 插件参数默认值 
	 */
	$.initPager.defaultSetting = {
		
		pagelistSelector: '#pagelist',				//分页div，控制当列表数据不超过1页时，隐藏分页栏
		pageLinkObjs: '#toolBar_pageLink li a',		//显示的所有页码

		pageLinkSelector: '#toolBar_pageLink',		//页码显示区域
		pageCurPageSelector: '#toolBar_curPage',	//页码显示区域
		pageRowCountSelector: '#toolBar_rowCount',	//页码显示区域
		pageTotalPageSelector: '#toolBar_totalPage',//页码显示区域
		pageSizeSelectToolBarSelector: '#toolBar_pageSizeSelect',//页码显示区域
		pageJumpPageSelector: '#toolBar_jumpPage',	//页码显示区域
		
		showCurPage: '#showCurPage',				//分页栏显示当前码元素
		currentPageSelector: '#currentPage',		//当前页隐藏域
		pageSizeSelector: '#pageSize',				//每页显示条数隐藏域
		totalPageSelector: '#showTotalPage',		//分页栏：总页数显示区域
		rowCountSelector: '#showRowCount',			//分页栏：总条数显示区域
		pageNumSelector: '#pageNum',				//跳页输入栏
		pageSizeSelectSelector:	'#pageSize_select',	//每页显示条数下拉选择框
		
		//首页、上一页、下一页、尾页、跳页
		firstPage: "#start",
		prePage: "#previous",
		nextPage: "#next", 
		lastPage: "#end", 
		jumpPageNum: "#jumpPageNum",
		
		//控制分页栏元素显示
		isShowPagerToolBarOnePage: true,			//只有一页或不足一页时是否显示分页栏，默认显示
		isShowPageLinkToolBar: true,				//是否显示分页页码序列显示区域；默认true：显示；false:不显示
		isShowRowCountToolBar: true,				//是否显示总记录数
		isShowTotalPageToolBar: true,				//是否显示总页数
		isShowPageSizeSelectToolBar: false,			//是否显示页大小选择下拉选项
		isShowJumpPageToolBar: true,				//是否显示跳页栏
		isOpenLimitPagerPrompt: false,				//是否开启极限页跳页提示，到第一页或最后一页后再点上一页或下一页时给出提示，false:不提示；true:提示；默认false
		
		//后台参数映射名称
		curPageMapperKey: 'pager.curPage',			//对应后台action中pager对象中的curPage属性，在插件中用于自动映射curPage的值到action中的pager对象中，以下四个属性亦同，具体使用视后台结构而定
		pageSizeMapperKey: 'pager.pageSize',
		totalRowMapperKey: 'pager.totalRow',
		totalPageMapperKey: 'pager.totalPage',
		
		dataType : 'html',                      	//分页请求返回的数据类型，支持json、html
		curPageNum: 1,								//当前页码
		pageSizeNum: 10,							//每页显示条数
		totalPageNum: 0,							//总页数
		totalRowNum: 0,								//总记录数
		pageSizeArr: [10, 15, 20, 30, 50, 80, 100],	//每页显示数数组
		pagerUrl: '',								//分页请求URL
		pagerData: '',								//分页请求参数，注意：分页参数curPage必须放到最后；如：param.curPage=1
		
		pagerCallHandel: function(){},				//分页数据处理回调函数
		setTotalCount:null                 			//设置记录数，返回一个整数,html请求方式时使用，即dataType=html时必须该函数从列表子页面获取总记录数
	};
	
})(jQuery);