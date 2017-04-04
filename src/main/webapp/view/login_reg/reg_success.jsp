<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../common/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="refresh" content="10;url=index.php">
<title>注册成功</title>
<link href="templets/style/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var time = 10;
function returnUrlByTime() {
   window.setTimeout('returnUrlByTime()', 1000);
   time = time - 1;
   document.getElementById("loadtime").innerHTML = time;
}
</script>
</head>
<body>

<div id="login" class="bor" >
  <h1>注册成功</h1><a class="back" href="/">返回首页&gt;&gt;</a>
  <div class="theme">
  <p class="success">恭喜您：<?php echo $userid=empty($userid)? '' : '<b style="color:#FF1155;">'.$userid.'</b> ';?>注册成功!<br />
    <?php if($cfg_mb_spacesta=="-10") echo '就差最后一步了，<font color="#FF1155">马上进入刚填写的邮箱验证!</font><br />';?>
    <a href="<?php echo $cfg_cmspath; ?>/member/">进入会员中心</a>&nbsp;&nbsp;<a href="<?php echo $cfg_cmspath; ?>/">返回网站首页</a></p>
    </div>
  <br class="clear"/>
</div>
<div class="footer">Copyright &copy; 2009-2013 Fun68.Cn <a href="http://www.fun68.cn">炫狐网-（炫狐观点）</a> 版权所有
</div>
</body>
</html>