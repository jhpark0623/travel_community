<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>travel_community</title>
<meta charset="UTF-8">
<style type="text/css">
	
</style>

</head>
<body>
	<jsp:include page="../include/header.jsp" />
	
	<h2 class="text-center mb-4">📋 Posts 메인 페이지 - 인기글</h2>

	<div class="container my-5" style="width: 700px;">
	    
	    <!-- 전체적으로 이미지 출력시 깨지는 문제있음. -->
	    <!-- 아래 반복문에서 post.content 값이 출력될때 조정 필요? -->
	    
	    <!-- carousel slide 형식 -->
	    <div id="hotPostsCarousel" class="carousel carousel-dark" data-bs-ride="false"
     		data-bs-interval="false">
	      
		  <div class="carousel-inner">
		    <c:forEach var="post" items="${hotPosts}" varStatus="loop">
		      <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
		        <div class="card text-center mx-auto shadow" style="width: 24rem;">
		          <div class="card-body position-relative">
		            <h5 class="card-title">
		              <a href="/post_detail.go?id=${post.id}" class="stretched-link text-decoration-none text-dark">
		                ${post.title}
		              </a>
		            </h5>
		            <h6 class="card-subtitle mb-2 text-muted">by ${post.nickname} · ${post.displayDate}</h6>
		            <p class="card-text">${post.content}</p>
		            <div class="mt-3">
		              <span class="badge bg-info">조회수: ${post.view_count}</span>
		              <span class="badge bg-success">좋아요: ${post.like_count}</span>
		            </div>
		          </div>
		        </div>
		      </div>
		    </c:forEach>
		  </div>
		
		  <!-- ◀ Prev 버튼 -->
		  <button class="carousel-control-prev" type="button" data-bs-target="#hotPostsCarousel" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </button>
		
		  <!-- ▶ Next 버튼 -->
		  <button class="carousel-control-next" type="button" data-bs-target="#hotPostsCarousel" data-bs-slide="next">
		  	<span class="carousel-control-next-icon"></span>
		  </button>
		  
		</div>
		
		<div class="mt-5 mb-5"></div>
		
		<!-- card 형식 -->
	    <div class="row row-cols-1 row-cols-md-3 g-4">
		  <c:forEach var="post" items="${hotPosts}">
		    <div class="col">
		      <div class="card h-100">
		        <div class="card-body">
		          <h5 class="card-title"><a href="/post_detail.go?id=${post.id }" class="stretched-link text-decoration-none text-dark">
		          	${post.title}
		          </a></h5>
		          <h6 class="card-subtitle mb-2 text-muted">by ${post.nickname}</h6>
		          <p class="card-text">${post.content}</p>
		          <h6 class="card-subtitle mb-2 text-muted">${post.displayDate}</h6>
		        </div>
		        <div class="card-footer">
		          <small class="text-muted">조회수: ${post.view_count} · 좋아요: ${post.like_count}</small>
		        </div>
		      </div>
		    </div>
		  </c:forEach>
		</div>
		
		<div class="mt-5 mb-5">		<!-- 제대로 사용된다면 반복문 처리 가능. -->
			<a href="hotposts_category.go?category_id=1">카테고리1</a>
			<a href="hotposts_category.go?category_id=2">카테고리2</a>
			<a href="hotposts_category.go?category_id=3">카테고리3</a>
		</div>
	</div>
	
	
</body>
</html>