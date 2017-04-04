<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>jQuery弹出框插件wBox1.0实例 | jQuery plugin wBox Demo | By WYQ</title>  
<meta name='keywords' content='wBox,jQuery插件,wBox plugin,wBox弹出框,Ajax,iframe,轻量级,灯箱效果'>
<meta name='description' content='wBox轻量级的弹出窗口jQuery插件，基于jQuery1.4.2开发，主要实现弹出框的效果，并且加入了很多有趣的功能，比如可img灯箱效果，callback函数，显示隐藏层，Ajax页面，iframe嵌入页面等功能'>
<script type="text/javascript" src="jquery1.4.2.js"></script> 
<script type="text/javascript" src="mapapi.js"></script> 
<script type="text/javascript" src="wbox.js"></script> 
<link rel="stylesheet" type="text/css" href="wbox/wbox.css" />
<style type="text/css">
	body{
		width:920px;
		margin:0 auto;
		background-color:#ffffff;
	}
	#wBoxInfo{
		width:918px;
	}
	#wBoxInfo h1{
		text-align:center;
	}
	#wBoxUL,#wBoxChange{
		width:400px;
		float:left;
	}
	#wBoxDemos{
		width:918px;
		float:left;
	}
	#wBoxDemos li{
		width:450px;
		float:left;
	}
	.code{
		margin-left:30px;
	}
	h2{
		font-size:15px;
	}
	.demo {
		width:360px;
	}
</style>
</head> 
<body>
<div id="wBoxInfo"> 
<h1>wBox Demo</h1>
<p style="text-align:center;">
	<a href='http://www.js8.in/' title='断桥残雪部落格' target='_blank'>断桥残雪部落格</a> | <a href='http://www.js8.in/wbox-jquery' title='wBox留言' target='_blank'>wBox留言讨论</a> | <a href='http://love.js8.in/' title='断桥残雪爱墙' target='_blank'>断桥残雪爱墙</a> | <a href='http://www.js8.in/wordpress-weather' title='WordPress天气' target='_blank'>WordPress天气</a> | <a href='http://www.js8.in/352.html' title='Follow5插件' target='_blank'>Follow5插件</a> | <a href='http://www.js8.in/projects' title='其他项目' target='_blank'>其他项目</a>
</p>
<p><b><a href='http://code.google.com/p/jquery-wbox' title='点击下载wBox' target='_blank'>wBox 1.0正式发布！</a></b>——轻量级的弹出窗口jQuery插件，压缩后仅仅3.65Kb，基于jQuery1.4.2开发，主要实现弹出框的效果，并且加入了很多有趣的功能，比如callback函数，显示隐藏层，Ajax页面，iframe嵌入页面……</p>
<div style="float:left;width:100%;"><div  id="wBoxUL"><ul>
	<h2>wBox特点</h2>
	<li>背景透明度可以根据实际情况进行调节</li>
	<li>可以根据需要添加wBox标题</li>
	<li>支持callback函数</li>
	<li>支持html内容自定义</li>
	<li>支持在wBox显示#ID的内容</li>
	<li>支持Ajax页面内容</li>
	<li>支持iFrame</li>
	<li>支持wBox拖拽功能</li>
	<li>ESC键，或者在背景上双击即可关闭wBox</li>
	<li>class为wBox_close点击可以关闭wBox，无论是组装的html，还是隐藏的html，甚至于iframe的内容中的.wBox_close</li>
<div style="clear:both;"/></ul></div><div id="wBoxChange">
	<h2>新功能</h2>
<ul id="wBoxChange">
	<li>优化代码~</li>
    <li>美化界面~</li>
    <li>默认可拖动，drag为false关闭</li>
    <li>新增wBox关闭方法：wBox.close()</li>
    <li>新增wBox打开方法：wBox.showBox()</li>
	<li>新增wBox定时关闭设置：通过参数timeout设置定时关闭时间</li>
    <li>新增在不触发click事件的前提，显示wBox，$(s).wBox({show:true})</li>
    <li>去除灯箱功能（准备做一个单独的jQuery灯箱插件）</li>
	<li>去除设置窗口位置</li>
<div style="clear:both;"/></ul></div></div></div>
<h2>wBox演示部分：</h2>
 <div id='wBoxDemos'>
 	<div><h2>设置名字的wBox</h2><div class="code">代码：<br/><span style="color:red;font-weight:bold;">var wBox</span>=$("#wbox1").wBox({<br/>
    title: "Test Title Name",<br/>
    html: "&lt;div class='demo'&gt;点击弹出设置名字的wBox&lt;/div&gt;"<br/>
   });<br/><a href='' id="wbox1">点击弹出设置名字的wBox</a><br/>
   <button onclick="wBox.showBox()">显示wBox,wBox.showBox()</button><br/>关闭使用<span style="color:red">wBox.close()</span>，显示使用<span style="color:red">wBox.showBox()</span></div></div>
	<div><h2>背景为透明的wBox</h2><div class="code">代码：<br/> $("#wbox2").wBox({opacity:0,html:"&lt;div class='demo'&gt;点击弹出背景为透明的wBox&lt;/div&gt;"});<br/><a href='' id="wbox2">点击弹出2背景为透明的wBox</a></div></div>
	<div><h2>弹出5秒钟自动关闭wBox</h2><div class="code">代码：<br/>$("#wbox3").wBox({target:"#info",timeout:5000});<br/><a href='' id="wbox3">弹出5秒钟自动关闭wBox</a></div></div>
	<div><h2>图片wBox</h2><div class="code">代码：<br/>$('.wboxImg').wBox({target:"004.jpg",requestType:"img"});<br/><a class="wboxImg" href="004.jpg">图片wBox</a></div></div>
	<div><h2>隐藏id为#info的层</h2><div class="code">代码：<br/>$('.wbox').wBox({target:"#info"});<br/><a class="wbox" href="#info">隐藏id为#info的层</a></div></div>
	<div><h2>不可拖拽的#wBoxUL层</h2><div class="code">代码：<br/>$('#drag').wBox({drag:false,title:'wBox功能简介部分的层',target:"#info"});<br/><a id="drag" href="#wBoxUL">不可拖拽的#wBoxUL层</a></div></div>
	<div><h2>iframe Google</h2><div class="code">代码：<br/>$("#isFrame").wBox({requestType:"iframe",iframeWH:{width:800,height:400},target:"http://google.com"}<br/><a id="isFrame" href="http://google.com">iframe google</a></div></div>
	<div><h2>本地iframe 自适用高度</h2><div class="code">代码：<br/>$("#isFrame2").wBox({<br/>
    requestType: "iframe",<br/>
    target:"500x400.html"<br/>
   });<br/><a id="isFrame2" href="500x400.html">本地iframe 自适用高度</a></div></div>
	
	<div><h2>Ajax加载内容</h2><div class="code">代码：<br/>$("#ajax").wBox({requestType: "ajax",target:"1.html"});<br/><a id="ajax" href="1.html">ajax 1.html</a></div></div>
	<div><h2>没有标题的弹出框</h2><div class="code">代码：<br/>$("#noTitle").wBox({noTitle:true,html:"&lt;div class='demo'&gt;这是一个没有标题的wBox<br/>ESC键关闭，或者双击背景关闭&lt;/div&gt;"});<br/><a id="noTitle" href="1.html">没有标题的弹出框</a></div></div>
    <div><h2>利用callback添加地图的wBox</h2><div class="code">代码：<br/>var maplet=null;<br/>
   oo=false;<br/>
   var callback=function(){<br/>
   maplet = new Maplet('myMap');<br/>
   maplet.centerAndZoom(new MPoint('HEUIDVZVVHUEEU'),8);<br/>
    maplet.addControl(new MStandardControl({view: {pan:false,ruler: false}})); <br/>
   }<br/>
   $("#map").wBox({<br/>title:'&lt;span style="font-size:14px"&gt;普加地图&lt;/span&gt;--&lt;span style="font-size:12px"&gt;可拖拽&lt;/span&gt;',<br/>html:"&lt;div id='myMap' style='width:500px;height:400px;'&gt;&lt;/div&gt;",<br/>callBack:callback,drag:true});<br/><a href='' id="map" >加载地图-利用callback函数</a></div></div>
</div>
  <div style="display:none" id="info" class="demo">这是来自隐藏div#info的消息<a class='wBox_close' href="javascript:void(0);">关闭</a></div>
  <div id='wBoxDown' style="width:160px;margin:10px auto;"><a style='font-size:18px;color:#5db0e6;font-weight:bold;' href='http://code.google.com/p/jquery-wbox/downloads/list' title='点击下载wBox' target='_blank'>点击此处下载wBox</a></div>
  <ul id="wBoxUse">
  	<li>首先下载wBox文件，然后将wBox中的</li>
  	<li>引入wbox.js文件</li>
	<li>引入wbox.css文件</li>
	<li><span style="color:red">注意</span>：通过wbox的wBoxURL路径设置图片地址~例如：$("div").wBox({wBoxURL:"wbox/"})</li>
  </ul>
 <script type="text/javascript"> 
   var wBox=$("#wbox1").wBox({
   	title: "Test Title Name",
   	html: "<div class='demo'>点击弹出设置名字的wBox</div>"
   });
   $("#wbox2").wBox({opacity:0,html:"<div class='demo'>点击弹出2背景为透明的wBox</div>"});
   $('.wboxImg').wBox({target:"004.jpg",requestType:"img"});
   $("#wbox3").wBox({target:"#info",timeout:5000});
   $('#drag').wBox({drag:false,title:"<div class='demo'>wBox功能简介部分的层</div>",target:"#info"});
   $('.wbox').wBox({target:"#info"});
   $("#isFrame").wBox({requestType:"iframe",iframeWH:{width:800,height:400},target:"http://google.com"});
   $("#isFrame2").wBox({
   	requestType: "iframe",
	target:"500x400.html"
   });
   $("#ajax").wBox({
    requestType: "ajax",
	target:"1.html"
   });
   $("#noTitle").wBox({noTitle:true,html:"<div class='demo'>这是一个没有标题的wBox<br/>ESC键关闭，或者双击背景关闭</div>"});
   $('#setPos').wBox({title:"自动弹出实例，8秒后可关闭",show:true,html:"<div class='demo'>欢迎光临~这里是wBox的实例！<br/>此实例代码：<br/>$('#setPos').wBox({show:true,html:'欢迎光临~这里是wBox的实例！</div>',timeout:8000});",timeout:8000});
   var maplet=null;
   oo=false;
   var callback=function(){
   maplet = new Maplet('myMap');
   maplet.centerAndZoom(new MPoint('HEUIDVZVVHUEEU'),8);
    maplet.addControl(new MStandardControl({view: {pan:false,ruler: false}})); 
   }
   $("#map").wBox({title:'<span style="font-size:14px">普加地图</span>--<span style="font-size:12px">可拖拽</span>',html:"<div id='myMap' style='width:500px;height:400px;'></div>",callBack:callback});
</script>
<script type="text/javascript" src="http://js.tongji.linezing.com/1370845/tongji.js"></script><noscript><a href="http://www.linezing.com"><img src="http://img.tongji.linezing.com/1370845/tongji.gif"/></a></noscript> 
</body>
</html>