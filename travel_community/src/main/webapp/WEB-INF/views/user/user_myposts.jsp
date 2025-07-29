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
		<h5 class="text-danger fw-bold">내가 작성한 게시물 </h2>
		
		<table class="table table-bordered table-striped align-middle text-center">
			<thead class="table-primary">
				<tr style="text-align: center">
					<th style="width: 65px;">글번호</th>
					<th style="width: 120px;">제목</th>
					<th style="width: 140px;">작성일자</th>
					<th style="width: 65px;">조회수</th>
					<th style="width: 65px;">좋아요</th>
					
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
						<th colspan="5" class="text-center"> 검색된 게시물이 없습니다!!</th>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<div class="text-center my-4">
		  
		    <ul class="pagination justify-content-center">
		
		      <!-- 이전 페이지 블럭 -->
		      <c:if test="${paging.startBlock > 1}">
		        <li class="page-item">
		          <a class="page-link" href="myposts.go?page=${paging.startBlock - 1}">&laquo;</a>
		        </li>
		      </c:if>
		
		      <!-- 페이지 숫자 반복 -->
		      <c:forEach begin="${paging.startBlock}" end="${paging.endBlock}" var="i">
		        <li class="page-item ${i == currentPage ? 'active' : ''}">
		          <a class="page-link" href="myposts.go?page=${i}">${i}</a>
		        </li>
		      </c:forEach>
		
		      <!-- 다음 페이지 블럭 -->
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
			<input name="myposts_search" placeholder="내용 or 제목">
			<input type="submit" value="검색">
		
		</form>
	
	
	
	</div>

</body>
</html>