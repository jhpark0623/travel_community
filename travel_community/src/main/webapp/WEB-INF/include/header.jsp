<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>

<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
	crossorigin="anonymous"></script>

<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

<style>
body {
	margin: 0;
	background: #fcfcfc;
	height: 100vh;
	min-height: 900px;
	width: 100%;
	position: relative;
	padding-bottom: 20px;
	min-width: 950px;
}

.header-container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 15px 20px;
	backdrop-filter: blur(6px);
	width: 100%;
	box-shadow : 0 1px 5px rgba(0,0,0,0.2);
}

.header-left a {
	font-size: 1.3rem;
	font-weight: 600;
	color: #333;
	text-decoration: none;
	transition: color 0.2s;
}

.header-left a:hover {
	color: #0d6efd; /* Bootstrap primary color */
}

.header-right button {
	min-width: 70px;
}

button:hover, input[type="submit"]:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
}

a {
	text-decoration: none;
}

.header-container a.text-dark:hover {
	color: #0d6efd !important;
	text-decoration: underline !important;
}
</style>

</head>

<body>

	<div class="header-container">
		<div
			style="width: 950px; display: flex; justify-content: space-between; align-items: center">


			<div class="header-left">
				<a href="<%=request.getContextPath()%>/">Home</a>
			</div>

			<div style="display: flex; gap: 35px">
				<a class="text-dark"
					href="<%=request.getContextPath()%>/posts_list.go/1">[자유 게시판]</a> <a
					class="text-dark"
					href="<%=request.getContextPath()%>/posts_list.go/2">[정보 게시판]</a> <a
					class="text-dark"
					href="<%=request.getContextPath()%>/posts_list.go/3">[질문 게시판]</a> <a
					class="text-dark"
					href="<%=request.getContextPath()%>/notices_list.go">[공지사항]</a>
			</div>

			<div class="header-right">
				<c:choose>
					<c:when test="${empty sessionScope.loginUser}">
						<button class="btn btn-outline-secondary"
							onclick="location.href='<%=request.getContextPath()%>/user_login.go'">로그인</button>
					</c:when>
					<c:otherwise>

						<div class="btn-group-vertical" role="group"
							aria-label="Vertical button group">
							<div class="btn-group" role="group" style="position: relative;">
								<button type="button" class="btn btn-primary dropdown-toggle"
									data-bs-toggle="dropdown" aria-expanded="false">마이페이지</button>
								<ul class="dropdown-menu"
									style="z-index: 1111; position: absolute;">
									<li><a class="dropdown-item"
										href="<%=request.getContextPath()%>/myprofile.go">내 정보</a></li>
									<li><a class="dropdown-item"
										href="<%=request.getContextPath()%>/myposts.go">내 게시물</a></li>
									<li><a class="dropdown-item"
										href="<%=request.getContextPath()%>/mycomments.go">내 답글</a></li>
									<li><hr class="dropdown-divider"></li>
									<li>
										<a class=" dropdown-item"
											onclick="if(confirm('정말로 로그아웃하시겠습니까?')) {
						location.href='<%=request.getContextPath()%>/user_logout.go'
					}">로그아웃</a>
									</li>
								</ul>
							</div>
						</div>
					</c:otherwise>
				</c:choose>


			</div>
		</div>
	</div>
</body>
</html>