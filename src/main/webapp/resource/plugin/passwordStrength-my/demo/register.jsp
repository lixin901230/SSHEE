<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>密码强度demo</title>
<link rel="stylesheet" href="${ctx}/resource/js/passwordStrength-my/zhuce.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/resource/js/passwordStrength-my/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javaScript" src="${ctx}/resource/js/passwordStrength-my/passwordStrength.js"></script>
<script type="text/javascript">

//初始化密码强度
function initPwdStrength(){
	$('#staffPass').passwordStrength();
}

//页面、数据初始化
$(function(){
	initPwdStrength();
});
</script>
</head>
<body style="text-align: center;">
     <label for="staffPass">密码：</label>
     <input type="password" name="staff.staffPass" id="staffPass" class="txt validate[required,minSize[6],maxSize[12]]" value="" onfocus="fn_focus(this);" onblur="fn_blur(this);"/>
     <div class="lenbox lenH" style="display:none" id="pwdPower"><span class="s1">弱</span><span class="s2">中</span><span class="s3">强</span></div>
</body>
</html>