<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>travel_community</title>
<meta charset="UTF-8">


</head>
<body>
	<jsp:include page="../include/header.jsp" />


	<div class="container my-5" style="width: 950px; border-radius: 3px; box-shadow: 0 3px 9px rgba(0,0,0,0.2); padding: 20px">
	
	    <h2 class="text-center mb-4">📋 Posts 메인 페이지</h2>
	    <h4 class="text-center mb-3">현재 전체 게시글 목록 <- 바뀔수있음</h4>
	    
	    <!-- ✅ 전체 게시물 수 -->
	    <div class="d-flex justify-content-end mb-2">
	        <small class="text-muted">전체 게시물 수: ${Paging.totalRecord}개</small>
	    </div>
	    
	    <!-- aList 영역 -->
	    <table class="table table-bordered table-striped align-middle text-center">
	        <thead class="table-primary">
	            <tr>
	                <th style="width: 120px;">게시판</th>
	                <th>제목</th>
	                <th style="width: 120px;">작성자</th>
	                <th style="width: 140px;">작성일</th>
	                <th style="width: 65px;">조회수</th>
	                <th style="width: 65px">좋아요</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:if test="${!empty aList}">
	                <c:forEach items="${aList}" var="dto">
	                
	                	<!-- 공지사항 목록 출력 -->
	                    <c:if test="${empty dto.nickname }">	
		                    <tr>
		                        <td style="color: red;">공지사항</td>
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
	                	
	                	<!-- 게시글 목록 출력 -->
	                	<c:if test="${!empty dto.nickname }">	
		                    <tr>
		                    	<td>${categoryMap[dto.category_id]}</td> 
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
	            	</c:forEach>
	            </c:if>
	            
	            
	            <c:if test="${empty aList}">
	                <tr>
	                    <td colspan="6" class="text-center">
	                        <div class="py-4 fw-bold">전체 게시물 목록이 없습니다.</div>
	                    </td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	    
	    <!-- ✅ 페이징 처리 -->
	    <nav>
	        <ul class="pagination justify-content-center">
	            <c:if test="${Paging.page > Paging.block}">
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/?page=1">처음</a>
	                </li>
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${Paging.startBlock - 1}">이전</a>
	                </li>
	            </c:if>
	
	            <c:forEach begin="${Paging.startBlock}" end="${Paging.endBlock}" var="i">
	                <li class="page-item ${i == Paging.page ? 'active' : ''}">
	                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${i}">${i}</a>
	                </li>
	            </c:forEach>
	
	            <c:if test="${Paging.endBlock < Paging.allPage}">
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${Paging.endBlock + 1}">다음</a>
	                </li>
	                <li class="page-item">
	                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${Paging.allPage}">마지막</a>
	                </li>
	            </c:if>
	        </ul>
	    </nav>
	    
	    
	</div>
</body>
</html>