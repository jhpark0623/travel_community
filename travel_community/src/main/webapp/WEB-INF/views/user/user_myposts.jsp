<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="../../include/header.jsp" />
	
	<div class="container my-5" style="width: 900px">
		<c:set var="posts" value="${myPosts }" />
		<h5 class="text-danger fw-bold">���� �ۼ��� �Խù� </h2>
		
		<table class="table table-bordered table-striped align-middle text-center">
			<thead class="table-primary">
				<tr style="text-align: center">
					<th style="width: 65px;">�۹�ȣ</th>
					<th style="width: 120px;">����</th>
					<th style="width: 140px;">�ۼ�����</th>
					<th style="width: 65px;">��ȸ��</th>
					<th style="width: 65px;">���ƿ�</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${posts}" var="post">
					<tr>
						<td> ${post.id } </td>
						<td class="text-start position-relative p-0">
						<a href="<%=request.getContextPath()%>/post_detail.go?id=${post.id}&page=1"class="d-block stretched-link text-decoration-none px-2 py-2">${post.title }</a>
						</td>
						<td> ${post.created_at} </td>
						<td> ${post.view_count} </td>
						<td> ${post.like_count} </td>
						
					</tr>
				</c:forEach>
				
				<c:if test="${empty posts }">
					<tr>
						<th colspan="5" class="text-center"> �˻��� �Խù��� �����ϴ�!!</th>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<div class="text-center my-4">
		  
		    <ul class="pagination justify-content-center">
		
		      <!-- ���� ������ �� -->
		      <c:if test="${paging.startBlock > 1}">
		        <li class="page-item">
		          <a class="page-link" href="myposts.go?page=${paging.startBlock - 1}">&laquo;</a>
		        </li>
		      </c:if>
		
		      <!-- ������ ���� �ݺ� -->
		      <c:forEach begin="${paging.startBlock}" end="${paging.endBlock}" var="i">
		        <li class="page-item ${i == currentPage ? 'active' : ''}">
		          <a class="page-link" href="myposts.go?page=${i}">${i}</a>
		        </li>
		      </c:forEach>
		
		      <!-- ���� ������ �� -->
		      <c:if test="${paging.endBlock < paging.allPage}">
		        <li class="page-item">
		          <a class="page-link" href="myposts.go?page=${paging.endBlock + 1}">&raquo;</a>
		        </li>
		      </c:if>
		
		    </ul>
		  
		</div>

	</div>
	
	<div align="center">
		<form method="get" action="<%= request.getContextPath() %>/myposts_search.go">
			<input name="myposts_search" placeholder="���� or ����">
			<input type="submit" value="�˻�">
		
		</form>
	
	
	
	</div>

</body>
</html>