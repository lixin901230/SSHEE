<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../taglib.jsp"%>
<script type="text/javascript" charset="utf-8">
	$(function() {
		panels = [ {
			id : 'p1',
			title : 'about',
			height : 200,
			collapsible : true,
			href:'${pageContext.request.contextPath}/view/common/layout/portal/about.jsp'
		}, {
			id : 'p2',
			title : 'link',
			height : 200,
			collapsible : true,
			href:'${pageContext.request.contextPath}/view/common/layout/portal/link.jsp'
		}, {
			id : 'p3',
			title : '修复数据库',
			height : 200,
			collapsible : true,
			href:'${pageContext.request.contextPath}/view/common/layout/portal/repair.jsp'
		}, {
			id : 'p4',
			title : '说明',
			height : 200,
			collapsible : true,
			content : '<h1><!-- 可以拖动面板的顺序，他会记住的，下次打开的时候，还是你之前调节过的顺序哦 --></h1>'
		}, {
			id : 'p5',
			title : '说明2',
			height : 200,
			collapsible : true,
			href:'${pageContext.request.contextPath}/view/common/layout/portal/about2.jsp'
		} , {
			id : 'p6',
			title : 'EasyUI的QQ群',
			height : 200,
			collapsible : true,
			href:'${pageContext.request.contextPath}/view/common/layout/portal/qun.jsp'
		} ];

		 $('#layout_portal_portal').portal({
			border : false,
			fit : true,
			onStateChange : function() {
				$.cookie('portal-state', getPortalState(), {
					expires : 7
				});
			}
		});
		var state = $.cookie('portal-state');
		if (!state) {
			state = 'p1,p2,p3:p4,p5,p6';/*冒号代表列，逗号代表行*/
		}
		addPortalPanels(state);
		$('#layout_portal_portal').portal('resize');

	});

	function getPanelOptions(id) {
		for ( var i = 0; i < panels.length; i++) {
			if (panels[i].id == id) {
				return panels[i];
			}
		}
		return undefined;
	}
	function getPortalState() {
		var aa=[];
		for(var columnIndex=0;columnIndex<2;columnIndex++) {
			var cc=[];
			var panels=$('#layout_portal_portal').portal('getPanels',columnIndex);
			for(var i=0;i<panels.length;i++) {
				cc.push(panels[i].attr('id'));
			}
			aa.push(cc.join(','));
		}
		return aa.join(':');
	}
	function addPortalPanels(portalState) {
		var columns = portalState.split(':');
		for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
			var cc = columns[columnIndex].split(',');
			for (var j = 0; j < cc.length; j++) {
				var options = getPanelOptions(cc[j]);
				if (options) {
					var p = $('<div/>').attr('id', options.id).appendTo('body');
					p.panel(options);
					$('#layout_portal_portal').portal('add', {
						panel : p,
						columnIndex : columnIndex
					});
				}
			}
		}
	}
</script>
<div id="layout_portal_portal" style="position:relative">
	<div></div>
	<div></div>
</div>