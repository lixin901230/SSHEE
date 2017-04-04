<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../common/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>完善详细资料</title>
<link href="templets/style/login.css" rel="stylesheet" type="text/css" />
<script src="templets/js/j.js" language="javascript" type="text/javascript"></script>
<script type="text/javascript" src="templets/js/main.js"></script>
<script type="text/javascript" src="templets/js/calendar/calendar.js"></script>
<script src="templets/js/base.js" language="javascript" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
<!--
var reMethod = "<?php echo ($cfg_soft_lang == 'utf-8') ? 'POST' : 'GET';?>",pwdmin = <?php echo $cfg_mb_pwdmin; ?>;

function changeAuthCode() {
	var num = 	new Date().getTime();
	var rand = Math.round(Math.random() * 10000);
	num = num + rand;
	$('#ver_code').css('visibility','visible');
	if ($("#vdimgck")[0]) {
		$("#vdimgck")[0].src = "../include/vdimgck.php?tag=" + num;
	}
	return false;	
}

function hideVc()
{
	$('#ver_code').css('visibility','hidden');
}


$(document).ready(function(){ 
	$("#vdcode").focus(function(){
	  var leftpos = $("#vdcode").position().left;
	  var toppos = $("#vdcode").position().top - 42;
	  $('#ver_code').css('left', leftpos+'px');
	  $('#ver_code').css('top', toppos+'px');
	  $('#ver_code').css('visibility','visible');
	});
	$("input[type='password']").click(function(){
	  hideVc()
	});
	$("#txtUsername").click(function(){
	  hideVc()
	});
	$("input[type='radio']").focus(function(){
	  hideVc()
	});
	/*
	$("#vdcode").blur(function(){
		  $('#ver_code').css('visibility','hidden');
	});
	*/
})

-->
</script>
</head>
<body>
<div id="login" class="bor" >
  <h1>完成详细资料</h1>
  <div class="theme">
    <form method="post" action="reg.php" id="regUser" name="form1">
      <input type="hidden" value="reginfo" name="dopost"/>
      <input type="hidden" value="2" name="step"/>
      <input type="hidden" value="<?php echo $membermodel->modid;?>" name="modid"/>
      <p style="text-align: right;" class="mB10"/>
    <?php
        echo '<ul>';
        echo '<li><span>用户名：</span><div class="lform">'.$cfg_ml->M_UserName.'</div></li>';
        echo '<li><span>会员类型：</span><div class="lform">'.$cfg_ml->M_MbType.'</div></li>';
        echo $postform;
        echo '</ul>';
    ?>
      <ul>
        <li><span>&nbsp;</span>
          <button type="submit" id="btnSignCheck" class="login-btn">完 成 注 册</button>
        </li>
      </ul>
    </form>
  </div>
  <br class="clear"/>
</div>

</body>
</html>