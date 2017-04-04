/**
 * Easyui layout 折叠后title不显示问题，扩展panel使其折叠后能显示title
 */
//在layout的panle全局配置中,增加一个onCollapse处理title
var opts = "";
$.extend($.fn.layout.paneldefaults, {
	onBeforeCollapse: function(){
		opts = $(this).panel("options");
	},
	onCollapse: function () {
		
		//针对横向和竖向的不同处理方式
		if (opts.region == "west" || opts.region == "east") {
			
			//针对panel收缩后图标的处理
			if(opts.iconCls){
				//$(".layout-expand").find(".panel-body").css("vertical-align", "top").append($("<div/>").addClass("panel-icon "+opts.iconCls));
			}
			
			//竖向的文字打竖,其实就是切割文字加br
			var split = [];
			for (var i = 0; i < opts.title.length; i++) {
				split.push(opts.title.substring(i, i + 1));
			}
			$(".layout-expand").find(".panel-body").css("text-align", "center").html("<b>"+split.join("<br/>")+"</b>");
		} else {
			
			//针对panel收缩后图标的处理
			if(opts.iconCls){
				$(".panel-title").after($("<div/>").addClass("panel-icon "+opts.iconCls));
			}
			
			//设置影藏的panel的title
			$(".panel-title").text(opts.title);
		}
//		$(".layout-expand").panel("setTitle", opts.title);
	}
});


//在layout的panle全局配置中,增加一个onCollapse处理title
/*$.extend($.fn.layout.paneldefaults, {
	onCollapse : function () {
		//获取layout容器
		var layout = $(this).parents("div.layout");
		//获取当前region的配置属性
		var opts = $(this).panel("options");
		//获取key
		var expandKey = "expand" + opts.region.substring(0, 1).toUpperCase() + opts.region.substring(1);
		//从layout的缓存对象中取得对应的收缩对象
		var expandPanel = layout.data("layout").panels[expandKey];
		//针对横向和竖向的不同处理方式
		if (opts.region == "west" || opts.region == "east") {
			//竖向的文字打竖,其实就是切割文字加br
			var split = [];
			for (var i = 0; i < opts.title.length; i++) {
				split.push(opts.title.substring(i, i + 1));
			}
			expandPanel.panel("body").addClass("panel-title").css("text-align", "center").html(split.join("＜ｂｒ＞"));
		} else {
			expandPanel.panel("setTitle", opts.title);
		}
	}
});*/
