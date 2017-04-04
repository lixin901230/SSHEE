<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../taglib.jsp"%>

<script type="text/javascript">
	
	//创建选项卡工具栏按钮，刷新、关闭
	function createTabs(){
		
		$('#layout_center_tabs').tabs({
			fit : true,
			border : false,
			onContextMenu : function(e, title) {
				e.preventDefault();
				$('#layout_center_tabsMenu').menu('show', {
					left : e.pageX,
					top : e.pageY
				}).data('tabTitle', title);
			},
			tools : [ {
				iconCls : 'icon-reload',
				handler : function() {
					var href = $('#layout_center_tabs').tabs('getSelected').panel('options').href;
					if (href) {/*说明tab是以href方式引入的目标页面*/
						var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
						$('#layout_center_tabs').tabs('getTab', index).panel('refresh');
					} else {/*说明tab是以content方式引入的目标页面*/
						var panel = $('#layout_center_tabs').tabs('getSelected').panel('panel');
						var frame = panel.find('iframe');
						try {
							if (frame.length > 0) {
								for ( var i = 0; i < frame.length; i++) {
									frame[i].contentWindow.document.write('');
									frame[i].contentWindow.close();
									frame[i].src = frame[i].src;
								}
								if ($.browser.msie) {
									CollectGarbage();
								}
							}
						} catch (e) {
						}
					}
				}
			}, {
				iconCls : 'icon-cancel',
				handler : function() {
					var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
					var tab = $('#layout_center_tabs').tabs('getTab', index);
					if (tab.panel('options').closable) {
						$('#layout_center_tabs').tabs('close', index);
					} else {
						$.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭', 'error');
					}
				}
			} ]
		});
	}
	
	//选项卡tabs上的菜单绑定事件
	function tabsMenu(){
		
		$('#layout_center_tabsMenu').menu({
			onClick : function(item) {
				var curTabTitle = $(this).data('tabTitle');
				var type = $(item.target).attr('type');

				if (type === 'refresh') {
					layout_center_refreshTab(curTabTitle);
					return;
				}

				if (type === 'close') {
					var t = $('#layout_center_tabs').tabs('getTab', curTabTitle);
					if (t.panel('options').closable) {
						$('#layout_center_tabs').tabs('close', curTabTitle);
					}
					return;
				}

				var allTabs = $('#layout_center_tabs').tabs('tabs');
				var closeTabsTitle = [];

				$.each(allTabs, function() {
					var opt = $(this).panel('options');
					if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
						closeTabsTitle.push(opt.title);
					} else if (opt.closable && type === 'closeAll') {
						closeTabsTitle.push(opt.title);
					}
				});

				for ( var i = 0; i < closeTabsTitle.length; i++) {
					$('#layout_center_tabs').tabs('close', closeTabsTitle[i]);
				}
			}
		});
	}
	
	//刷新选项卡
	function layout_center_refreshTab(title) {
		$('#layout_center_tabs').tabs('getTab', title).panel('refresh');
	}
	
	//添加选项卡
	function layout_center_addTabFun(opts) {
		var t = $('#layout_center_tabs');
		if (t.tabs('exists', opts.title)) {
			t.tabs('select', opts.title);
			layout_center_refreshTab(opts.title);
		} else {
			t.tabs('add', opts);
		}
	}

	$(function() {
		
		tabsMenu();
		createTabs();
	});
</script>
<div id="layout_center_tabs" style="overflow: hidden;">
	<div title="首页" data-options="href:'${ctx}/view/common/layout/portal.jsp',iconCls:'icon-home'"></div>
</div>
<div id="layout_center_tabsMenu" style="width: 120px;display:none;border:0">
	<div type="refresh">刷新</div>
	<div class="menu-sep"></div>
	<div type="close">关闭</div>
	<div type="closeOther">关闭其他</div>
	<div type="closeAll">关闭所有</div>
</div>