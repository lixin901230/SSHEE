
/**
 * @DOTO: jQuery Ajax通用分页插件 jquery.whatyPager-1.2.1.js
 * 		已测试支持jquery-1.9.1+
 * 		待优化点：
 * 			1、插件内分页核心数据统一化管理，优化使用$.data()缓存更新后的分页核心数据，取代pagerToolBar中的隐藏域
 * 			2、（v_1.2.1以优化）连续分页页码显示数配置控制，且连续分页页码为偶数时当前页码显示居中偏左还是偏右
 * 			3、（v_1.2.1以优化）连续分页前后配置控制是否显示多余页码省略按钮，显示，则点击该按钮重新定位当前页为该省略按钮的钱一页为当前页，并拉出后面的页码
 * 			4、分页栏重构、分页栏各个元素独立初始化，不采用html代码片段初始化，不利于用户定制分页栏显示风格，
 * 			5、分页栏各个元素显示顺序实现配置控
 * 			6、分页栏元素样式优化，多提供几套默认主题皮肤，分页栏按钮样式采用默认模板同时，实现可佩控制，能通过配置使用图片或样式替换当前默认按钮
 * @version: version_1.2.1ss
 * @author: lixin
 */
(function($){
	
	var options = null;
	var methods = {

		/**
		 * 初始化分页
		 */
		initPager: function(opts){
			
			var target = this;
			return $(this).each(function(){
					
				//默认设置对象与初始化散列参数对象合并
				options = $.extend(true, $.defaultSetting, opts || {});

				methods.initPaperToolBar.apply(target);	//初始化分页栏html
				
				//初始化按钮事件处理函数
				methods._initPageNum();
				methods._initPageBtn();
				methods._initPageSizeSelect(options);	//初始化每页显示条数下拉选项
				methods.controlPaperToolBarShow(options);		//分页栏元素显示控制
				
				//执行分页查询
				methods._pageSubmit(options.curPageNum, options.pageSizeNum);
			});
		},
		
		/**
		 * 分页操作后，更新总页数
		 * @param totalCount 	总记录数
		 * @param pageSize		页面显示条数
		 * @returns
		 */
		_getTotalPage: function(totalCount, pageSize) {
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
			
			return $(this).each(function() {
				
				var totalPage = this._getTotalPage(totalCount, pageSize);
				
				var currentPage = parseInt(curPage);
				$(options.showCurPage).text(curPage);
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
				
				var continuePagerArr = [];	//连续页码数据数组
				var prefixPagerArr = [];	//前缀页码数组
				var suffixPagerArr = [];	//后缀也爱数组
				
				var _prefixCount = options.pageNumGroup.prefixCount;
				var _suffixCount = options.pageNumGroup.suffixCount;
				var _isShowPrefix = options.pageNumGroup.isShowPrefix;
				var _isShowSuffix = options.pageNumGroup.isShowSuffix;
				var _prefixMoreShowText = options.pageNumGroup.prefixMoreShowText;
				var _suffixMoreShowText = options.pageNumGroup.suffixMoreShowText;
				
				var _showCount = options.pageNumGroup.showCount;
				var allLength = _showCount;	//连续分页总长度=连续分页+前缀（含省略按钮）+后缀（含省略按钮）
				if( _isShowPrefix && _prefixCount > 0 ){
					allLength += _prefixCount + 1;
				}
				if( _isShowSuffix && _suffixCount > 0 ){
					allLength += _suffixCount + 1;
				}
				
				if(totalPage <= allLength){		//没有前后缀的情况
					continuePagerArr.push(1);
					continuePagerArr.push(totalPage);
				}else{							//有前缀后缀的情况
					allLength = _showCount;
					//var _showCount = Math.min(totalPage, options.pageNumGroup.showCount);		//连续页码显示个数
					var _middlePager = Math.ceil(_showCount / 2);	//中间页位置，（基数为中间位置，偶数时为中间靠左位置）
					var _leftCount = _rightCount = Math.floor(_showCount / 2);
					if( _showCount % 2 == 0 ) {
						
						if(options.pageNumGroup.curPagePositions == "left") {
							_leftCount -= 1;
						} else if(options.pageNumGroup.curPagePositions == "right") {
							_rightCount -= 1;
						} else {
							alert("“省略页码”按钮位置参数设置错误；\r\n如：options.pageNumGroup: {curPagePositions: 'left' | 'right'}");
						}
					}
					
					//容错处理1：开始位置、结束位置极限值处理
					var startPager = Math.max(1, currentPage - _leftCount);
					var endPager = Math.min(totalPage, currentPage + _rightCount);
					
					//容错处理2：开始位置为1时重新确定结束位置
					endPager = startPager == 1 ? _showCount : endPager;	//开始位置为1时，滚动的连续页码结束位置则为连续页码显示数处
					startPager = endPager == totalPage ? endPager - _showCount + 1 : startPager; //结束位置等于总页数时，开始位置 = 结束位置（总页数） - 连续分页显示数(showCount) + 1（此处再加1则为其实位置的页码）
					
					//前缀数据处理
					if(_isShowPrefix && _prefixCount > 0) {
						//前缀和开始位置重叠，默认开始位置为1（即前缀与开始位置刚好连续，没有页码省略按钮），否则为原有开始位置
						startPager = _prefixCount + 1 >= startPager  ? 1 : startPager;
						//前缀与开始位置未重叠，加上前缀页码及省略按钮
						if(_prefixCount + 1 < startPager) {	//显示前缀，总长度allLength不需要加上前缀长度
							if(_isShowPrefix){
								for (var i = 1; i <= _prefixCount; i++) {
									prefixPagerArr.push(i);
								}
							}
							prefixPagerArr.push(_prefixMoreShowText);	//省略页码按钮
						}else{	//不显示前缀，总长度allLength需要加上前缀长度
							//连续分页显示总长度 = 现有总长度（ 连续页码显示数） + 前缀总长度（前缀产犊 + 1个省略页码按 ）
							allLength += _prefixCount + 1;
						}
					} else if(_isShowPrefix && _prefixCount == 0 && startPager != 1) {		//只要省略按钮，不要前缀页码
						prefixPagerArr.push(_prefixMoreShowText);		//省略页码按钮
					}
					
					//后缀数据处理
					if(_isShowSuffix && _suffixCount > 0) {
						
						//后缀与结束位置重叠，默认结束位置为总页数大小（即后缀与结束位置刚好连续，没有页码省略按钮），否则为原有结束位置
						//endPager = endPager + _suffixCount + 1 >= totalPage ? totalPage : endPager;
						
						//后缀与结束位置未重叠
						if(endPager + _suffixCount + 1 < totalPage) {	//显示后缀，总长度allLength不用加上后缀长度
							suffixPagerArr.push(_suffixMoreShowText);	//省略页码按钮
							if(_isShowSuffix) {
								for (var i = totalPage - (_suffixCount - 1); i <= totalPage ; i++) {
									suffixPagerArr.push(i);
								}
							}
						}else{	//不显示后缀，总长度allLength需要加上后缀长度
							//连续分页显示总长度 = 现有总长度(前缀总长度(前缀产犊 + 1个省略页码按 ) + 连续页码显示数) + 整个后缀长度(后缀长度 + 1个省略页码按钮)
							allLength += (_suffixCount + 1);
							endPager = endPager + _suffixCount + 1 >= totalPage ? totalPage : endPager;
						}
					} else if(_isShowSuffix && _suffixCount == 0 && endPager != totalPage) {	//只要省略按钮，不要后缀页码
						suffixPagerArr.push(_prefixMoreShowText);		//省略页码按钮
					}
					
					allLength = Math.min(allLength, totalPage);
					
					endPager = startPager == 1 ? allLength : endPager;	//开始位置为1时，结束位置始终为连续页码显示数showCount（注意，不是连续页码总数）
					startPager = endPager == totalPage ? endPager - allLength + 1 : startPager;//结束位置等于总页数时，开始位置 = 结束位置（总页数） - 连续页码总数(前缀总长度(前缀长度 + 1个省略页码) + 连续分页显示数(showCount)) + 1（此处再加1则为其实位置的页码）
					
					continuePagerArr.push(startPager);
					continuePagerArr.push(endPager);
				}
				
				//生成连续分页页码按钮
				methods._appendContinuePager(currentPage, continuePagerArr, prefixPagerArr, suffixPagerArr);
			});
		},
		
		/**
		 * 
		 */
		_appendContinuePager: function(_currentPage, _continuePagerArr, prefixPagerArr, suffixPagerArr){
			
			var startPager = _continuePagerArr[0];	//连续分页页码的起始位置页码
			var endPager = _continuePagerArr[_continuePagerArr.length - 1];	//连续分页页码的结束位置页码
			
			//渲染前缀
			var prefixHtml = "";
			for(var i = 0; i < prefixPagerArr.length; i++) {
				if(i < prefixPagerArr.length - 1) {
					prefixHtml += "<li><a href='javascript:void(0);' class='p3' _continue_pageNum_='"+prefixPagerArr[i]+"' title='"+prefixPagerArr[i]+"'>" + prefixPagerArr[i] + "</a></li>";
				} else {
					prefixHtml += "<li><a href='javascript:void(0);' class='p3' _continue_pageNum_='"+(startPager - 1)+"' title='"+(startPager - 1)+"'>" + prefixPagerArr[i] + "</a></li>";
				}
			}
			
			//渲染后缀
			var suffixHtml = "";
			for(var i = 0; i < suffixPagerArr.length; i++) {
				if(i == 0) {
					suffixHtml += "<li><a href='javascript:void(0);' class='p3' _continue_pageNum_='"+(endPager + 1)+"' title='"+(endPager + 1)+"'>" + suffixPagerArr[i] + "</a></li>";
				} else {
					suffixHtml += "<li><a href='javascript:void(0);' class='p3' _continue_pageNum_='"+suffixPagerArr[i]+"' title='"+suffixPagerArr[i]+"'>" + suffixPagerArr[i] + "</a></li>";
				}
			}
			//渲染连续分页
			var pageLink = prefixHtml;
			for(var i = startPager; i <= endPager; i++) {
				if (i == _currentPage) {
					pageLink += "<li><a href='javascript:void(0);' class='p3 p_current' _continue_pageNum_='"+i+"' title='"+i+"'>" + i + "</a></li>";
				} else {
					pageLink += "<li><a href='javascript:void(0);' class='p3' _continue_pageNum_='"+i+"' title='"+i+"'>" + i + "</a></li>";
				}
			}
			pageLink += suffixHtml;
			$(options.pageLinkSelector).html(pageLink);
			
			//更新分页栏后，重新初始化分页栏页码分页按钮事件
			this._initPageNum();
		},

		/**
		 * 分页按钮事件处理
		 */
		_pageJump: function(btnType, curPage) {
			
			return $(this).each(function() {
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
			});
		},
		
		/**
		 * 分页查询
		 */
		_pageSubmit: function(curPage, pageSize) {
			
			return $(this).each(function() {
				options = $.extend(options, {curPageNum: curPage, pageSizeNum: pageSize});
				
	//			var searchParam = methods._getSearchParam();	//获取合并了分页参数和条件查询参数字符串
				var pagerParam = methods._getPageParam();
				var searchParam = options.pagerData;
	//			alert("url："+options.pagerUrl+"\r\ndata："+searchParam+"\r\npagerParam："+pagerParam);
				
				$.ajax({
					url: options.pagerUrl + "?" + pagerParam,//url后面传递分页参数
					data: searchParam,	//条件查询参数，可能是string、Array、json、或者jsonArray
					type: 'post',
					dataType: options.dataType,
					cache: false,
					async: false,
					success: function(pageData){
						
						options.pagerCallHandel(pageData, searchParam);	//更新列表数据,这里最好将查询参数（searchParam）解析成json字符串返回给回调函数，方便页面分页查询后取条件查询参数
						
						var totalCount = 0;
						if(options.dataType.toLowerCase() === 'html' && typeof options.setTotalCount === "function"){
							totalCount = options.setTotalCount.call(this); 
						}else if(options.dataType.toLowerCase() === 'json'){
							totalCount = pageData.totalRow;
						}
						methods._updatePageShow(curPage, pageSize, totalCount);	//更新分页控制栏数据
					},
					error: function(){
						alert("pager请求失败，请重试或联系管理员!");
					}
				});
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
			if(!isNotEmpty(searchParam)) {
				
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
			
			return $(this).each(function() {
				$(options.pageLinkObjs).off("click");
				$(options.pageLinkObjs).on("click", function(){
					
					var _pageNum = $(this).attr("_continue_pagenum_");
					methods._pageJump(_pageNum);
				});
			});
		},
		
		/**
		 * 初始化分页按钮事件（首页、上一页、下一页、尾页）
		 */
		_initPageBtn: function(){
			
			return $(this).each(function() {
				$(options.firstPage +","+ options.prePage+","+options.nextPage +","+ options.lastPage+","+ options.jumpPageNum).on("click", function(){
					var pagerBtnType = $(this).attr("id");
					var currentPage = $(options.currentPageSelector).val();
					methods._pageJump(pagerBtnType, currentPage);
				});
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
			
			return $(this).each(function() {
				if(isShow) {
					$(toolBarSelector).show().css("display", "block");
				} else {
					$(toolBarSelector).hide().css("display", "none");
				}
			});
		},
		
		/**
		 * 初始化每页显示条数下拉框选项
		 */
		_initPageSizeSelect: function(options){
			
			return $(this).each(function() {
				
				if(options.isShowPageSizeSelectToolBar){	//如果显示页大小下拉选项，则初始化下拉选项
					
					var _pageSizeArr = options.pageSizeArr;
					if(_pageSizeArr.length > 0) {
						
						var selectOption = "";
						for(var i=0; i<_pageSizeArr.length; i++) {
							selectOption += '<option value="'+_pageSizeArr[i]+'">'+_pageSizeArr[i]+'</option>';
						}
						$(options.pageSizeSelectSelector).html(selectOption)
							.find("option[value='"+options.pageSizeNum+"']").prop("selected", "selected");
					}
					
					//改变页大小时重新加载分页
					$(options.pageSizeSelectSelector).on("change", function(){
						var _pageSize = $(this).find("option:selected").val();
						methods._pageSubmit(1, _pageSize);
					});
				}
			});
		},
		
		/**
		 * 分页具栏元素显示控制
		 */
		controlPaperToolBarShow: function(optsions){
			
			return $(this).each(function() {
				methods.showHide(options.pageLinkSelector, optsions.isShowPageLinkToolBar);
				methods.showHide(options.pageRowCountSelector, optsions.isShowRowCountToolBar);
				methods.showHide(options.pageTotalPageSelector, optsions.isShowTotalPageToolBar);
				methods.showHide(options.pageSizeToolBarSelector, optsions.isShowPageSizeSelectToolBar);
				methods.showHide(options.pageJumpPageSelector, optsions.isShowJumpPageToolBar);
			});
		},
		
		/**
		 * 获取分页信息对象，包含：当前页码、每页显示条数、总记录数、总页数
		 */
		getPage: function(){
			
			return {
				curPage: $(options.currentPageSelector).val(),
				pageSize: $(options.pageSizeSelector).val(),
				totalRow: methods.convertStrToNumber($(options.rowCountSelector).text()),
				totalPage: methods.convertStrToNumber($(options.totalPageSelector).text())
			};
		},
		
		/**
		 * 重新加载分页数据，默认加载当前页，可通过options散列对象中的curPage指定加载第几页
		 * @params reloadOptions 重新加载分页三列参数对象，该散列参数对象属性见：reloadDefualtSetting默认设置
		 */
		reloadPager: function(reloadOptions){
			
			return $(this).each(function() {
				
				var pageData = methods.getPage();
				var _curPage = pageData.curPage;
				var _pageSize = pageData.pageSize;
				
				//默认设置
				var reloadDefualtSetting = {
					curPageNum: _curPage || 1,		//当前页码
					pageSizeNum: _pageSize || 10,	//每页显示条数
					changeRowNum: 0,				//changeRowNum: n; n<0 表示减去n条记录；n==0 表示刷新当前页：n>0 表示加上n条记录
					loadPage: 'curPage'				//属性changeRowNum>0 时（即为添加操作），loadPage属性才生效，表示添加完成后重新加载分页时去到哪页；'firstPage':首页、'curPage': 当前页、'lastPage':末页
				};
				
				//合并对象参数
				reloadDefualtSetting = $.extend(reloadDefualtSetting, reloadOptions || {});
				//reloadDefualtSetting = $.extend($.defaultSetting, reloadDefualtSetting || {});
				
				var changeRowNum = reloadDefualtSetting.changeRowNum;	//改变的记录数
				if(!isNotEmpty(changeRowNum)) {
					 
					alert("reloadPager方法调用参数错误，属性changeRowNum不能为空; \r\n如：$.fn.whatyPager('reloadPager', {changeRowNum: n});\r\n[changeRowNum: n；n<0 表示减去了n条记录；n==0 表示刷新当前页：n>0 表示添加了n条记录]");
					return false;
				} else if(isNaN(changeRowNum)) {
					
					alert("reloadPager方法调用参数错误; 属性changeRowNum只能是数字;\r\n如：$.fn.whatyPager('reloadPager', {changeRowNum: n});\r\n[changeRowNum: n；n<0 表示减去了n条记录；n==0 表示刷新当前页：n>0 表示添加了n条记录]");
					return false;
				} else if(parseInt(changeRowNum) < 0 && parseInt(changeRowNum) > parseInt(pageData.totalRow)) {	//删除记录后，留在当前页时变更的记录条数不能大于总记录数（批量删除的条数不可能大余总记录条数）
					
					alert("reloadPager方法调用参数错误; 属性changeRowNum的值的绝对值必须小于总记录数；\r\n如：$.fn.whatyPager('reloadPager', {changeRowNum: n});\r\n[changeRowNum: n；n<0 表示减去了n条记录；n==0 表示刷新当前页：n>0 表示添加了n条记录]");
					return false;
				}
				changeRowNum = parseInt(changeRowNum);
				
				//修改、查看、添加、删除 操作后，回到分页列表当前页逻辑处理
				if(changeRowNum < 0) {					//删除
					
					var newTotalRow = parseInt(pageData.totalRow) + changeRowNum;
					var newTotalPage = Math.ceil(newTotalRow / _pageSize);	//获取删除n条记录后的实际总页数
					if(newTotalPage < _curPage) {		//若总页数小于原来的当前页，则默认当前页为最后一页
						_curPage = newTotalPage;
					}
				} else if(changeRowNum > 0) {			//添加
					
					var loadPage = reloadDefualtSetting.loadPage;
					if(loadPage == 'firstPage') {		//第一页
						
						_curPage = 1;
					} else if(loadPage == 'lastPage') {	//最后一页
						
						_curPage = Math.ceil((page.totalRow + changeRowNum) / _pageSize);	//获取添加n条记录后的实际总记录数
					} else if(loadPage == 'curPage'){	//当前页
						
						//_curPage = pageData.curPage;	默认的就是为当前页
					} else {
						
						alert("添加记录后，调用$.fn.whatyPager('reloadPager',{...});方法参数错误；\r\n如：$.fn.whatyPager('reloadPager', {loadPage: 'firstPage | curPage | lastPage'});");
						return false;
					}
					
				} else if(changeRowNum == 0) {			//刷新当前页
					
					//_curPage = pageData.curPage;	默认的就是为当前页
				}
				methods._pageSubmit(_curPage, _pageSize);
			});
		},
		
		/**
		 * 初始化分页栏默认模板
		 */
		initPaperToolBar: function(optsions){
			
			return $(this).each(function() {
				
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
					 + '    		<li id="toolBar_curPage"><span id="showCurPage">1</span></li>'
					 + '    		<li id="toolBar_totalPage">/<span id="totalPage">1</span>页</li>'
					 + '    		<li id="toolBar_rowCount">&nbsp;共<span id="rowCount">0</span>条</li>'
					 + '    		<li id="toolBar_jumpPage">&nbsp;跳到<input type="text" id="pageNum" value=""/>页<a href="javascript:void(0);" id="jumpPageNum" class="p4">跳转</a></li>'
					 + '    		<li id="toolBar_pageSizeSelect">&nbsp;每页<select id="pageSize_select"><option value="10">10</option></select>条</li>'
					 + '    	</ul>'
					 + '	</div>'
				 	 + ' </div>';
				 
//				 paperToolBar = optsions.paperToolBar || paperToolBar;
				 
				 var options = null;
				 var pageSizeArr = $.defaultSetting.pageSizeArr;
				 if(pageSizeArr) {
					 $.each($.defaultSetting.pageSizeArr, function(index, object){
						 
					 });
				 }
				 $(this).html(paperToolBar);
			});
		},
		
		/**
		 * 销毁分页栏
		 * 	1、移除分页栏
		 * 	2、清空分页信息
		 */
		destroy: function(options) {
			
			return $(this).each(function(){
				$(pageContainerSelector).remove();		// 移除分页栏
				$(this).removeDate('pagerPluginData');	// 删除元素对应的数据
			});	
		}
	};
	
	/**
	 * 分页插件初始化函数，该函数
	 * 		已作废，被$.fn.whatyPager函数取代
	 */
	$.fn.initWhatyPager = function() {
		methods.initPager.apply(this, arguments);
	};
	
	/**
	 * 插件主方法
	 * @param {String}
	 *            method (optional) action
	 */
	 $.fn.whatyPager = function() {

		 var method = arguments[0];	//获取参数列表中第一个字符串参数，即为要调用的方法名
		 if(methods[method]){	 	// 检验方法是否存在
			 
			 method = methods[method];	// 如果方法存在，存储起来以便使用, 注意：我这样做是为了等下更方便地使用each（）
			 // 获取调用参数，由于要调用的方法是作为参数传入的（第一个参数），把它从参数列表中删除即可得到我们方法调用时需要的参数列表
			 arguments = Array.prototype.slice.call(arguments, 1);
		 } else if(typeof(method) == 'object' || !method){
			 
			 method = methods.initPager;
		 } else {
			 $.error( 'Method ' +  method + ' does not exist on jQuery.whatyPager' );
			 return this;
		 }
		 return method.apply(this, arguments);	// 用apply方法来调用指定的方法并传入参数
	};
	
	/**
	 * 插件参数默认值 
	 */
	$.defaultSetting = {
		
		pageContainerSelector: '#pager_plugin',		//分页栏容器
		pagelistSelector: '#pagelist',				//分页div，控制当列表数据不超过1页时，隐藏分页栏
		pageLinkObjs: '#toolBar_pageLink li a',		//显示的所有页码

		pageLinkSelector: '#toolBar_pageLink',		//页码显示区域
		pageCurPageSelector: '#toolBar_curPage',	//页码显示区域
		pageRowCountSelector: '#toolBar_rowCount',	//页码显示区域
		pageTotalPageSelector: '#toolBar_totalPage',//页码显示区域
		pageSizeToolBarSelector: '#toolBar_pageSizeSelect',//页码显示区域
		pageJumpPageSelector: '#toolBar_jumpPage',	//页码显示区域
		
		showCurPage: '#showCurPage',				//分页栏显示当前码元素
		currentPageSelector: '#currentPage',		//当前页隐藏域
		pageSizeSelector: '#pageSize',				//每页显示条数隐藏域
		totalPageSelector: '#totalPage',			//分页栏：总页数显示区域
		rowCountSelector: '#rowCount',				//分页栏：总条数显示区域
		pageNumSelector: '#pageNum',				//跳页输入栏
		pageSizeSelectSelector:	'#pageSize_select',	//每页显示条数下拉选择框
		
		//首页、上一页、下一页、尾页、跳页
		firstPage: "#start",
		prePage: "#previous",
		nextPage: "#next", 
		lastPage: "#end", 
		jumpPageNum: "#jumpPageNum",

		//连续分页设置参数
		pageNumGroup: {					
			showCount: 5,				//连续分页页码显示个数，默认取值5
			curPagePositions: 'left',	//连续分页页码个数为偶数且总页数大于连续分页页码个数时，当前页码显示在中间位置向右偏移一个数还是向左偏移一个数，right:向右偏移一个数；left:向左偏移一个数
			isShowPrefix: false,		//前后缀显示控制，true：显示，false：不显示；默认取值false
			isShowSuffix: false,		//前后缀显示控制，true：显示，false：不显示；默认取值false
			prefixCount: 0,				//前缀页码显示个数；缺省为0；取值说明：[prefixCount: n; n==0：表示不显示前缀页码，n>0：表示显示n个前缀页码]
			suffixCount: 0,				//后缀页码显示个数；缺省为0；取值说明：[suffixCount: n; n==0：表示不显示前缀页码，n>0：表示显示n个前缀页码]
			prefixMoreShowText: '...',	//页码省略按钮显示内容，缺省为"..."
			suffixMoreShowText: '...',	//页码省略按钮显示内容，缺省为"..."
			
			curPageShowClass: '',		//连续分页页码当前页显示的颜色样式Class，默认蓝色
		},
				
		//控制分页栏元素显示
		isShowPagerToolBarOnePage: true,			//只有一页或不足一页时是否显示分页栏，默认显示
		isShowPageLinkToolBar: true,				//是否显示分页页码序列显示区域；默认true：显示；false:不显示
		isShowRowCountToolBar: true,				//是否显示总记录数
		isShowTotalPageToolBar: true,				//是否显示总页数
		isShowPageSizeSelectToolBar: true,			//是否显示页大小选择下拉选项
		isShowJumpPageToolBar: true,				//是否显示跳页栏
		isOpenLimitPagerPrompt: false,				//是否开启极限页跳页提示，到第一页或最后一页后再点上一页或下一页时给出提示，false:不提示；true:提示；默认false
		
		//后台参数映射名称
		curPageMapperKey: 'pager.curPage',			//对应后台action中pager对象中的curPage属性，在插件中用于自动映射curPage的值到action中的pager对象中，以下四个属性亦同，具体使用视后台结构而定
		pageSizeMapperKey: 'pager.pageSize',
		totalRowMapperKey: 'pager.totalRow',
		totalPageMapperKey: 'pager.totalPage',
		
		dataType: 'html',	                      	//分页请求返回的数据类型，支持json、html
		curPageNum: 1,								//当前页码
		pageSizeNum: 10,							//每页显示条数
		totalPageNum: 0,							//总页数
		totalRowNum: 0,								//总记录数
		pageSizeArr: [10, 15, 20, 30, 50, 80, 100],	//每页显示数数组
		pagerUrl: '',								//分页请求URL
		pagerData: '',								//分页请求参数，注意：分页参数curPage必须放到最后；如：param.curPage=1
		
		pagerCallHandel: function(){},				//分页数据处理回调函数；1、dataType:'html'时，该回调函数参数返回的是分页渲染后的html页面片段；dataType:'json'时；2、回调函数参数返回的是分页数据对象（如：pager的json对象形式）
		setTotalCount:null                 			//设置记录数，返回一个整数,html请求方式时使用，即dataType=html时必须该函数从列表子页面获取总记录数
	};
	
})(jQuery);