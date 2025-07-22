<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
	crossorigin="anonymous"></script>

<style>
body {
	margin: 0;
	background: linear-gradient(135deg, #f0f4f9, #ffffff);
	height: 100vh;
	min-height:900px;
	width: 100%;
	position: relative;
}

.header-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 20px;
	backdrop-filter: blur(6px);
	margin-bottom: 30px;
	width: 100%;
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
</style>

</head>

<body>

	<div class="header-container">

		<div class="header-left">
			<c:choose>
				<c:when test="${sessionScope.loginMember.store_code == 0}">
					<a href="<%=request.getContextPath()%>/admin_main.go">Admin
						Home</a>
				</c:when>
				<c:when test="${sessionScope.loginMember.store_code > 0}">
					<a href="<%=request.getContextPath()%>/store_page.go">Store
						Home</a>
				</c:when>
				<c:otherwise>
					<a href="<%=request.getContextPath()%>/">Home</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="header-right">
			<button class="btn btn-primary"
				onclick="location.href='<%=request.getContextPath()%>/parking_in.go?floor=1'">입차</button>

			<button class="btn btn-primary"
				onclick="location.href='<%=request.getContextPath()%>/parking_out.go'">출차</button>

			<c:choose>
				<c:when test="${empty sessionScope.loginMember}">
					<button class="btn btn-outline-secondary"
						onclick="location.href='<%=request.getContextPath()%>/admin_login.go'">로그인</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-outline-secondary"
						onclick="location.href='<%=request.getContextPath()%>/admin_logout.go'">로그아웃</button>
				</c:otherwise>
			</c:choose>
		</div>

	</div>

</body>
</html>
