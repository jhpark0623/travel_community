<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Posts 리스트</title>
    <!-- ✅ Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../../include/header.jsp" />

	<div class="container my-5" style="width: 900px">
	
	    <h2 class="text-center mb-4">📋 Posts 게시물 리스트</h2>
	    
	    <!-- ✅ 전체 게시물 수 -->
	    <div class="d-flex justify-content-end mb-2">
	        <small class="text-muted">전체 게시물 수: ${Paging.totalRecord}개</small>
	    </div>
	    
	    <!-- tList 영역 -->
	    <table class="table table-bordered table-striped align-middle text-center">
	        <thead class="table-primary">
	            <tr>
	                <th style="width: 90px;">글번호</th>
	                <th>제목</th>
	                <th style="width: 120px;">작성자</th>
	                <th style="width: 140px;">작성일</th>
	                <th style="width: 65px;">조회수</th>
	                <th style="width: 65px">좋아요</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:if test="${!empty tList}">
	                <c:forEach items="${tList}" var="dto">
	                	
	                	<!-- 게시글 목록 출력 -->
	                	<c:if test="${!empty dto.nickname }">	
		                    <tr>
		                        <td>${dto.id }</td>
		                        <td class="text-start position-relative p-0">
		                            <a href="<%=request.getContextPath() %>/post_detail.go?id=${dto.id}&page=${Paging.page}" 
		                               class="d-block stretched-link text-decoration-none px-2 py-2">
		                                 ${dto.title}
		                            </a>
		                        </td>
		                        <td>${dto.nickname }</td>
		                        <td>${dto.displayDate}</td>
		                        <td>${dto.view_count}</td>
		                        <td>${dto.like_count}</td>
		                    </tr>
	                    </c:if>
	                    
	                    <!-- 공지사항 목록 출력 -->
	                    <c:if test="${empty dto.nickname }">	
		                    <tr>
		                        <td>공지사항</td>
		                        <td class="text-start position-relative p-0">
		                            <a href="${pageContext.request.contextPath}/notices_content.go?no=${dto.id}&page=${Paging.page}"  
		                               class="d-block stretched-link text-decoration-none px-2 py-2">
		                                 ${dto.title}
		                            </a>
		                        </td>
		                        <td>관리자</td>
		                        <td>${dto.displayDate}</td>
		                        <td>${dto.view_count}</td>
		                        <td>${dto.like_count}</td>
		                    </tr>
	            		</c:if>
	            	</c:forEach>
	            </c:if>
	            
	            
	            <c:if test="${empty tList}">
	                <tr>
	                    <td colspan="6" class="text-center">
	                        <div class="py-4 fw-bold">전체 게시물 목록이 없습니다.</div>
	                    </td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	    
	
	    <!-- ✅ 글쓰기 버튼 -->
	    <div class="d-flex justify-content-end my-3">
	        <a href="<%=request.getContextPath() %>/post_write.go" class="btn btn-success">✍ 글쓰기</a>
	    </div>
	
	    <!-- ✅ 페이징 처리 -->
	    <nav>
	        <ul class="pagination justify-content-center">
	            <c:if test="${Paging.page > Paging.block}">
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId }?page=1">처음</a>
	                </li>
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId }?page=${Paging.startBlock - 1}">이전</a>
	                </li>
	            </c:if>
	
	            <c:forEach begin="${Paging.startBlock}" end="${Paging.endBlock}" var="i">
	                <li class="page-item ${i == Paging.page ? 'active' : ''}">
	                    <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId }?page=${i}">${i}</a>
	                </li>
	            </c:forEach>
	
	            <c:if test="${Paging.endBlock < Paging.allPage}">
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId }?page=${Paging.endBlock + 1}">다음</a>
	                </li>
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId }?page=${Paging.allPage}">마지막</a>
	                </li>
	            </c:if>
	        </ul>
	    </nav>
	
	    <!-- ✅ 검색 영역 -->
	    <!-- ✅ 검색 영역 -->		<!-- 공지로 검색되서 url 뺐습니다. 현재 작동 x -->
	   <form method="post" action="#" class="d-flex justify-content-center mt-4">
	      <div class="input-group w-50">
	         <select class="form-select" name="field">
	            	<option value="title">제목</option>
	                <option value="cont">내용</option>
	                <option value="nickname">작성자</option>
	                <option value="hashtag">해시태그</option>
	         </select>
	         <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
	         <button class="btn btn-outline-primary" type="submit">검색</button>
	      </div>
	   </form>
	
	</div>

<!-- ✅ Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>