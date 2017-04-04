<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp" %>

<c:forEach var="user" items="${pager.data}">
	<ul>
		<li class="tableCaseOne">${user.userName }</li>
		<li class="tableCaseTwo">${user.sex }</li>
		<li class="tableCaseThree">${user.email }</li>
		<li class="tableCaseFive">${user.telphone }</li>
		<li class="tableCaseFive">${user.sex }</li>
		<li class="tableCaseFive"><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd"/></li>
		<li class="tableCaseFive" id="${user.id }">
			<span id="showUserDetail" style="cursor: pointer;color: #56aaef;">查看</span>
			
			<!-- 系统权限关联的用户，测试示例中不让删除，免得引起系统出现脏数据 -->
			<c:if test="${(user.userName != 'lx') and (user.userName != 'admin') and (user.userName != 'initAdmin')}">
			 | <span id="editUser" style="cursor: pointer; color: #56aaef;">编辑</span>
			 | <span id="deleteUser" style="cursor: pointer; color: #56aaef;">删除</span>
			</c:if> 
		</li>
	</ul>
</c:forEach>

<!-- 维护分页总数
	注意：若分页初始化返回数据类型为html(即dataType:html)时，必须在数据列表子页面上加入总页数影藏域，
		并在分页初始化回调函数setTotalCount中获取该影藏域的值并返回给回调函数内部，若数据返回类型为json,则不需要
 -->
<input type="hidden" id="page_totalCount1" value="${pager.totalRow}"></input>