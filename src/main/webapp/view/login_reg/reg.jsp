<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="../common/head.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>新用户注册</title>
	<link href="${ctx}/view/login_reg/templets/style/login.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src='${ctx}/login_reg/templets/js/reg_new.js'></script>
	
	<script type="text/javascript" language="javascript">
	<!--
		/* function changeAuthCode() {
			var num = 	new Date().getTime();
			var rand = Math.round(Math.random() * 10000);
			num = num + rand;
			$('#ver_code').css('visibility','visible');
			if ($("#vdimgck")[0]) {
				$("#vdimgck")[0].src = "../include/vdimgck.php?tag=" + num;
			}
			return false;	
		} */
		
		function hideVc()
		{
			$('#ver_code').css('visibility','hidden');
		}
		
		
		$(document).ready(function(){
			
			$("#passwordLevel").removeClass().addClass("rank r0");
			$("#vdcode").focus(function(){
			  var leftpos = $("#vdcode").position().left;
			  var toppos = $("#vdcode").position().top - 42;
			  $('#ver_code').css('left', leftpos+'px');
			  $('#ver_code').css('top', toppos+'px');
			  $('#ver_code').css('visibility','visible');
			});
			$("input[type='password']").click(function(){
			  hideVc();
			});
			$("#txtUsername").click(function(){
			  hideVc();
			});
			$("input[type='radio']").focus(function(){
			  hideVc();
			});
		});
		
		//刷新验证码
		function changeAuthCode() {
			
			$('#vdimgck').attr('src','${ctx}/imageCodeAction!getImageCode.action?' + Math.floor(Math.random()*100)).fadeIn();
		// 	document.getElementById("imageCode").src="codeImage.do?" + Math.floor(Math.random()*100);
		}
	-->
	</script>
</head>
<body>
	<div id="login" class="bor" >
		<h1>新用户注册</h1>
		<!-- <a class="back" href="/">返回首页&gt;&gt;</a> -->
		<div class="theme">
			<form method="post" action="reg.php" id="regUser" name="form2">
			   	<input type="hidden" value="regbase" name="dopost"/>
			  	<input type="hidden" value="1" name="step"/>
			  	<input type="hidden" value="个人" name="mtype"/>
				<ul>
				  	<li>
					  	<span>用户名：</span>
					  	<input class="intxt w200" id="txtUsername"  name="userid" type="text" id="txtUsername"  onpaste="return false" ondragenter="return false"  style="ime-mode:disabled" class="pwd_inp"/>
				<!--  <input type="text" class="intxt w200" id="txtUsername" name="userid"/> -->
						<em id="_userid"></em> 
					</li>
					<li>
						<span>真实姓名：</span>
						<input type="text" class="intxt w200" id="txtUsername"  name="uname"/>
						<em id="_uname"/></em>&nbsp;重要！请认真填写
					</li>
					<li>
						<span>登陆密码：</span>
					  	<input type="password" onkeyup="setPasswordLevel(this, document.getElementById('passwordLevel'));" style="font-family: verdana;" class="intxt w200" id="txtPassword" name="userpwd"/>
					  	<input id="passwordLevel" class="rank r2" disabled="disabled" name="Input"/>
					</li>
					<li>
						<span>确认密码：</span>
					    <input type="password" class="intxt w200" size="20" value="" id="userpwdok" name="userpwdok"/>
					    <em id="_userpwdok"></em> 
					</li>
					<li>
						<span>电子邮箱：</span>
					    <input type="text" class="intxt w200" id="email" name="email"/> 
					    <em id="_email"></em> 
					</li>
					<li>
						<span>性别：</span>
					    <input type="radio" value="女" name="sex" checked="checked" />女
					    <input type="radio" value="男" name="sex"/>男
					</li>
					<li>
						<span>验证码：</span>
						<input type="text" class="intxt w200" style="width: 50px; text-transform: uppercase;" id="vdcode" name="vdcode"/>&nbsp;&nbsp;
					  	<img id="vdimgck" align="absmiddle" title="看不清？点击更换" onclick="this.src=this.src+'?'" style="cursor: pointer;" alt="看不清？点击更换" src="${ctx}/imageCodeAction!getImageCode.action"/> 看不清？ 
					  	<a href="#" onclick="changeAuthCode();">点击更换</a>
					</li>
					<li>
					  	<span>&nbsp;</span>
					  	<button type="submit" id="btnSignCheck" class="reg-btn">确定注册</button>
					  	<a class="regbt" href="${ctx}/view/login_reg/login.jsp" rel="nofollow">已有账号？</a>
				  	</li>
				</ul>
			
			</form>
		</div>
		<br class="clear"/>
	</div>
	<div class="footer">Copyright &copy; 2014-2020 用于学习，无版权限制，让我们共同进步!     
		<a onclick="javascript:window.open('${ctx}/view/common/layout/portal/aboutWe.jsp');" style="text-decoration: underline;cursor: pointer;">关于我们 </a>
	</div>
</body>
</html>