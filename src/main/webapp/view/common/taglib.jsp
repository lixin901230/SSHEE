<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://mytag.security.net" prefix="securl"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="basePath" value="<%=request.getContextPath() %>"/>

<sec:authentication property="principal" var="authentication" scope="session"/>
<c:set var="currentUser" value="${authentication}" scope="session"/>

<input type="hidden" id="ctx" value="${ctx}" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript" src="${ctx}/resource/js/global.js" ></script>