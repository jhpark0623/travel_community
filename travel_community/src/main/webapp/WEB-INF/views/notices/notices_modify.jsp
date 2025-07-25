<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 수정</title>

	<!-- ✅ Bootstrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

	<!-- ✅ Custom Style (선택) -->
	<style>
		.card {
			max-width: 600px;
			margin: 50px auto;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		.card-header h3 {
			margin: 0;
			font-weight: bold;
		}
	</style>
</head>
<body>

 

	<div class="container">
		<div class="card">
			<div class="card-header text-center bg-white border-bottom-0">
				<h3>📢 공지사항 수정</h3>
				<c:set var="dto" value="${Modify}" />
			</div>

			<div class="card-body">
				<form method="post" action="${pageContext.request.contextPath}/notices_modify_ok.go">
					
					<!-- Hidden Fields -->
					<input type="hidden" name="id" value="${dto.getId()}">
					<input type="hidden" name="page" value="${Page}">

					<div class="mb-3">
						<label class="form-label">작성자</label>
						<input type="text" class="form-control" value="관리자" readonly>
					</div>

					<div class="mb-3">
					    <label class="form-label">제목</label>
					    <input type="text" class="form-control" name="title" value="${dto.title}" required>
					</div>
					
					<div class="mb-3">
					    <label class="form-label">내용</label>
					    <textarea class="form-control" name="content" rows="6" placeholder="공지 내용을 입력하세요" required>${dto.content}</textarea>
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn-primary">수정 완료</button>
						<button type="reset" class="btn btn-secondary">다시 작성</button>
					</div>

				</form>
			</div>
		</div>
	</div>


 
</body>
</html>
