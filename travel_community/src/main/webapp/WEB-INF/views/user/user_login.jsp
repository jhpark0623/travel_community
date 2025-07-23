<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<div class="container mt-5 w-25">	
		<form method="post" action="<%=request.getContextPath()%>/user_login_ok.go">
			<div class="mt-3">
				<label for="EmailInput" class="form-label">아이디</label>
				<input name="email" type="email" class="form-control" id="EmailInput" placeholder="예) travler@naver.com" required>
			</div>
			
			<div class="mt-3 ">
				<label for="PwdInput" class="form-label">비밀번호</label>
				<input name="password" type="password" class="form-control" id="PwdInput" placeholder="비밀번호를 입력하세요." required>
			</div>
			
			<div class="d-grid mt-3 mb-3">
				<button type="submit" class="btn btn-primary">로그인</button>
			</div>
			
			<div class="d-flex justify-content-center">
				<div class="p-2">
					<a href="<%=request.getContextPath()%>/user_signin.go">회원 가입</a>
				</div>
				<div class="p-2">
					<a href="<%=request.getContextPath()%>/user_findaccount.go">계정 찾기</a>
				<div class="p-1">
			</div>
		</form>
	</div>
	
</body>
</html>