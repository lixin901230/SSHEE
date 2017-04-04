/**
 * @desc 数字时钟	页面框架状态栏中的数字时钟显示
 * @author lixin
 */
function showTime(){
	var myweekday = "";
	var year = "";
	var myHours = "";
	var myMinutes = "";
	var mySeconds = "";

	mydate = new Date();
	myweekday = mydate.getDay();
	mymonth = parseInt(mydate.getMonth() + 1) < 10 ? "0"+(mydate.getMonth() + 1) : mydate.getMonth() + 1;
	myday = mydate.getDate();
	myyear = mydate.getYear();
	myHours = mydate.getHours();
	myMinutes = mydate.getMinutes();
	mySeconds = parseInt(mydate.getSeconds()) < 10 ? "0"+mydate.getSeconds() : mydate.getSeconds();
	year=(myyear > 200) ? myyear : 1900 + myyear;
	
	if(myweekday == 0)weekday=" 星期日 ";
	else if(myweekday == 1)weekday=" 星期一 ";
	else if(myweekday == 2)weekday=" 星期二 ";
	else if(myweekday == 3)weekday=" 星期三 ";
	else if(myweekday == 4)weekday=" 星期四 ";
	else if(myweekday == 5)weekday=" 星期五 ";
	else if(myweekday == 6)weekday=" 星期六 ";
	
	datetime.innerText = year + "年" + mymonth + "月" + myday + "日 " +
		myHours + ":" + myMinutes + ":" + mySeconds + " " + weekday;setTimeout("showTime()",1000);
}

/**
 * @desc 获取当前日期时间字符串
 * <li>eg:2014-01-21 16:02:12</li> 
 * @author lixin
 */
function getCurrDateTime(){
	
	var d = new Date();
	var currDate = d.getFullYear()+"-"+d.getMonth()+1+"-"+d.getDate();
	
	var currHours = d.getHours() < 10 ? "0"+d.getHours() : d.getHours();
	var currMinutes = d.getMinutes < 10 ? "0"+d.getMinutes() : d.getMinutes();
	var currSeconds = d.getSeconds < 10 ? "0"+d.getSeconds() : d.getSeconds();
	
	var currDateTimeStr = currDate+" "+currHours+":"+currMinutes+":"+currSeconds;
	return currDateTimeStr;
}

/**
 * @desc 刷新打开的选项卡
 * @param tabsParentDivId 选项卡所在的父div的id
 * @param tabTitle 选项卡标题
 * @param url 选项卡的url
 * @author lixin
 */
function refreshTab(tabsParentDivId,tabTitle,url){
	
	var tabsParentDiv = $("#"+tabsParentDivId);
	var refresh_tab = tabTitle ? tabsParentDiv.tabs('getTab',tabTitle) : tabsParentDiv.tabs('getSelected');  
	
	if(refresh_tab && refresh_tab.find('iframe').length > 0){  
	    
    	var _refresh_ifram = refresh_tab.find('iframe')[0];
	    var refresh_url = url ? url : _refresh_ifram.src;  
	    //_refresh_ifram.src = refresh_url;//设置永远只打开一个选项卡
	    _refresh_ifram.contentWindow.location.href = refresh_url;  
    }  
}

/**
 * @desc 选项卡Iframe的url重定向
 * @param tabsParentDivId 选项卡所在的父div的id
 * @param tabTitle 选项卡标题
 * @param url 选项卡的url
 * @author lixin
 */
function changeTabIframeUrl(tabsParentDivId,tabTitle,url){
	
	//获取当前选中的 tab
	var selectedTab = /*$("#"+tabsParentDivId).tabs('getSelected') ? $("#"+tabsParentDivId).tabs('getSelected') 
			: */parent.$("#"+tabsParentDivId).tabs('getSelected');

	//根据tabs的title获取指定的tab
	var tab = /*$("#"+tabsParentDivId).tabs('getTab',tabTitle) ? $("#"+tabsParentDivId).tabs('getTab',tabTitle) 
			: */parent.$("#"+tabsParentDivId).tabs('getTab',tabTitle);
	
	var refresh_tab = tabTitle ? tab : selectedTab;  
	if(refresh_tab && refresh_tab.find('iframe').length > 0){  
	    
    	var _refresh_ifram = refresh_tab.find('iframe')[0];
	    var refresh_url = url ? url : _refresh_ifram.src;  
	    //_refresh_ifram.src = refresh_url;//设置永远只打开一个选项卡
	    _refresh_ifram.contentWindow.location.href = refresh_url;  
    }  
}

/**
 * @desc 添加新选项卡或选中已存在选显卡
 * @param tabsDivId 选项卡父div的id
 * @param id 选项卡的id
 * @param title 选项卡的标题
 * @param url 选项卡的url
 * @param selected 选项卡是否默认选中
 * @param closable 选项卡是否可关闭
 * @param iconCls 选项卡面板标题图标的CSS类
 * @author lixin
 */
function addTab(tabsDivId, id, title, url, selected, closable, iconCls){
	
	url = g_ctx + url;
	var tabs_div = $("#"+tabsDivId);
	if (tabs_div.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab   
		
		tabs_div.tabs('select', title);
		refreshTab(tabsDivId,title,url);
	} else {
		var content = '';
		if (url){
			content = '<iframe src="' + url + '" scrolling="auto" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>';  
		} else {
			content = '未实现';  
		}
		tabs_div.tabs('add',{
			id: id,
	   	    title: title,
	   	    content: content,
	   	    selected: selected,
	   	    closable: closable,
//	   	    iconCls: iconCls || 'icon-default'
	   	    iconCls: iconCls || 'icon-default'
		});
		tabs_div.tabs('select', title);//打开选项卡后，选中新打开你的选项卡
	}
}

/**
 * @desc 获取选中的 tab panel 和它的 tab 对象
 * @param tabsDivIdSelector 选项卡父div选择器对象
 * @author lixin
 */
function getSelectedTabs(tabsDivIdSelector){
	return $(tabsDivIdSelector).tabs('getSelected');
}

/**
 * @desc 菜单访问，访问的的内容会在中间内容区域选项卡中显示
 * @param url：访问的菜单的url
 * @param tabs_parent_div_id：选项卡所在的父div
 * @param tabs_id：选项卡的id属性
 * @param tabs_title：像卡的title值
 * @param iconCls: 选项卡图标
 * @author lixin
 */
function accessMenuLink(url, tabs_parent_div_id, tabs_id, tabs_title, iconCls){
	
	//获取要访问的选项卡是否存在，存在则直接选中该选项卡，否则创建一个新的选项卡
	addTab(tabs_parent_div_id, tabs_id, tabs_title, url, false, true, iconCls);
}

/**
 * @desc 关闭dialog
 * @param dialogSelector 弹窗的id选中器 eg：#Id
 * @author lixin
 */
function closeDialog(dialogSelector){
	$(dialogSelector).dialog('close');
}

/**
 * @desc 给节点绑定点击事件，当点击节点的时候选中复选框
 * @param treeSelector 树ul 标签的id选中器 eg：#treeId
 * @author lixin
 */
function clickNodeTextChecked(treeSelector){
	$(treeSelector).tree({
		onClick: function(none){
			if(none.checked){
				$(treeSelector).tree("uncheck", none.target);
			} else {
				$(treeSelector).tree("check", none.target);
			}
		}
	});
}

/**
 * @desc 折叠树
 * @param selector1 操作的树的选择器
 * @param selector2 操作的树的选择器，第二个参数selector2可以不要
 * @author lixin
 */
function collapseTree(selector1, selector2){
	var none = $(selector1).tree("getSelected");
	if(none){
		$(selector1).tree("collapseAll", none.target);
		if(selector2){
			none = $(selector2).tree("find", none.id);
			if(none){
				$(selector2).tree("collapseAll", none.target);
			}
		}
	} else {
		$(selector1).tree("collapseAll");
		if(selector2){
			$(selector2).tree("collapseAll");
		}
	}
}

/**
 * @desc 展开树
 * @param selector1 操作的树的选择器
 * @param selector2 操作的树的选择器，第二个参数selector2可以不要
 * @author lixin
 */
function expandTree(selector1, selector2){
	var none = $(selector1).tree("getSelected");
	if(none){
		$(selector1).tree("expandAll", none.target);
		if(selector2){
			none = $(selector2).tree("find", none.id);
			if(none){
				$(selector2).tree("expandAll", none.target);
			}
		}
	} else {
		$(selector1).tree("expandAll");
		if(selector2){
			$(selector2).tree("expandAll");
		}
	}
}



/** 
 * @desc 判断值知否可用
 * @param val 要判断的只是否为null、""、或者'undefined'，是则返回false，否则返回true
 * @returns {Boolean}
 * @author lixin
 */
function checkValue(val){
	var isValid = false;
	if(val != null && val != "" && val != 'undefined'){
		isValid = true;
	}
	return isValid;
}

/**
 * @desc 取消搜索
 * @param searchFormSelector 搜索表单ID
 * @author lixin
 */
function cancelSearch(searchFormSelector){
	datagrid.datagrid('load', {});
	$("#"+searchFormSelector).find("input").val("");
}

/**
 * @desc 刷新数据表格datagrid
 * @param datagridSelector 	datagrid表格的id值
 * @author lixin
 */
function refreshDatagrid(datagridSelector){
	$("#"+datagridSelector).datagrid('load',{});
}

/**
 * @desc 刷新数据表格treegrid
 * @param treegridSelector 	treegrid表格的id值
 * @author lixin
 */
function refreshTreegrid(treegridSelector){
	$("#"+treegridSelector).treegrid('load',{});
}

/**
 * @desc 取消选中
 * @param datagridSelector	 datagrid表格的id值
 * @author lixin
 */
function cancelChecked(datagridSelector){
	$("#"+datagridSelector).datagrid("uncheckAll").datagrid("unselectAll");
}

/**
 * @desc 获取datagrid中选中的复选框对象
 * @returns 返回datagrid中选中的checkbox对象数组
 * @author lixin
 */
function getCheckeds(){
	var ids = $(".datagrid-body").find(":checkbox:checked");
//		var rows = $(".datagrid-body").datagrid("getSelections");
	
	if(!ids){
		return false;
	}
	return ids;
}

/**
 * @desc datagrid中格式化显示日期
 * @param value：字段的值。
 * @param row：行数据。
 * @param index：行索引
 * @author lixin
 */
function fmtShowDate(value,row,index){
	if(value){
		var unixTimestamp = new Date(value);  
		return unixTimestamp.toLocaleString();  
	}else {
		return value;
	}
}

/**
 * 启用遮罩层  插件 jquery.blockUI.js 
 */
function beginLoading(){
	$.blockUI({
		css: {
		    border: 'none',
		    background: 'none'
		},
		message: '<img src="../img/loading.gif" style="border:none"/> ' 
    });
}
/**
 * 关闭遮罩层  插件 jquery.blockUI.js 
 */
function endLoading(){
	$.unblockUI();
}

/**
 * 复选框单选全选
 * @param checkAllSelecotr 全选复选框选择器
 * @param subCheckSelector 单选框选择器
 */
function checkedAll(checkAllSelecotr, subCheckSelector){
	
	
	$(checkAllSelecotr).click(function(){	//权限复选框选中后，选中所有子复选框
		$(subCheckSelector).prop("checked", this.checked);//此处使用prop()替换attr()，jQuery 1.9.1版本中attr设置选择一次全选，再调用一次反选，再去调用全选就没效果了
	});
	
	var subCheckbox = $(subCheckSelector);
	subCheckbox.click(function(){	//子复选框选中的数量等于未选中的数量，则默认选中全选框
		$(checkAllSelecotr).prop("checked", subCheckbox.length == $(subCheckSelector+":checked").length ? true : false);
	});
}
