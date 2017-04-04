<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.web.WebAttributes" %>
<%@ include file="../common/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="../common/head.jsp" %>
	<title>用户登录</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link href="${ctx}/view/login_reg/templets/style/login.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
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
		
		//刷新验证码
		function changeAuthCode() {
			
			$('#vdimgck').attr('src','${ctx}/imageCodeAction!getImageCode.action?' + Math.floor(Math.random()*100)).fadeIn();
		// 	document.getElementById("imageCode").src="codeImage.do?" + Math.floor(Math.random()*100);
		}
	
	</script>
</head>
<body>
	<div id="login" class="bor">
	  	<h1>用户登录</h1>
	<!--   <a class="back" href="/">返回首页&gt;&gt;</a> -->
	  	<div class="theme">
		   	<form name="form1" action="${ctx}/j_spring_security_check" method="post">
		      	<input type="hidden" name="fmdo" value="login">
		      	<input type="hidden" name="dopost" value="login">
		      
			  	<span style="color: red;width: 80%;text-align: center;">${SPRING_SECURITY_LAST_EXCEPTION.message}</span>
		      
		      	<ul>
		        	<li> 
		        		<span>用户名：</span>
		          		<input id="txtUsername" name="j_username" class="intxt login_from" type="text"/>
		        	</li>
			        <li> 
			        	<span>密&nbsp;&nbsp;&nbsp;码：</span>
			          	<input id="txtPassword" name="j_password" class="intxt login_from2" type="password"/>
			        </li>
			        <li>
			        	<span>验证码：</span>
			          	<input type="text" class="intxt w200" style="width: 50px; text-transform: uppercase;" id="vdcode" name="vdcode"/>&nbsp;&nbsp;
			          	<img id="vdimgck" align="absmiddle" onclick="this.src=this.src+'?'" title="看不清？点击更换" style="cursor: pointer;" alt="看不清？点击更换" src="${ctx}/imageCodeAction!getImageCode.action"/> 看不清？ 
			          	<a href="#" onclick="changeAuthCode();">点击更换</a>
			        </li>
			        <!-- <li>
			        	<span>Remember me on this computer</span>
			        	<input name="_spring_security_remember_me" type="checkbox" value="on"/>
			        </li> -->
			        <li> 
			        	<span>有效期：</span>
			          	<input type="radio" value="2592000" name="keeptime" id="ra1"/>
			          	<label for="ra1">一个月</label>
			          	<input type="radio" checked="checked" value="604800" name="keeptime" id="ra2"/>
			          	<label for="ra2">一周</label>
			          	<input type="radio" value="86400" name="keeptime"  id="ra3"/>
			         	<label for="ra3">一天</label>
			          	<input type="radio" value="0" name="keeptime"  id="ra4"/>
			          	<label for="ra4">即时</label>
			        </li>
			        <li> 
			        	<span>&nbsp;</span>
			          	<button id="btnSignCheck" class="login-btn" type="submit">登&nbsp;录</button>
			          	<a class="regbt" href="${ctx}/view/login_reg/reg.jsp" rel="nofollow">注册账号</a>
					</li>
		      	</ul>
			</form>
	  </div>
	  <br class="clear"/>
	</div>
	<div class="footer">
		Copyright &copy; 2014-2020 用于学习，无版权限制，让我们共同进步!     
		<a onclick="javascript:window.open('${ctx}/view/common/layout/portal/aboutWe.jsp');" style="text-decoration: underline;cursor: pointer;">关于我们 </a>
	</div>
</body>
</html>
