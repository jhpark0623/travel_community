<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	
	function validate() {
		
		var objEmail = document.getElementById("EmailInput");
		var objPwd = document.getElementById("PwdInput");
		
		// password 값 데이터 정규화 공식
        const regul1 = /^[a-zA-Z0-9]{4,12}$/;
		// email 정규화 공식
	    const regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
	    // 아이디 공백 체크
	    if(objEmail.value === "") {
			alert("아이디를 입력하세요.");
			objEmail.focus();
			return false;
		}
		// 비밀번호 공백 체크
		if(objPwd.value === "") {
			alert("비밀번호를 입력하세요.");
			objPwd.focus();
			return false;
		}
		// 이메일 형식 체크
		if (!regul2.test(objEmail.value)) {
            alert("이메일 형식이 올바르지 않습니다.");
            objEmail.focus();
            return false;
        }
	    // 비밀번호 형식 체크
        if (!regul1.test(objPwd.value)) {
            alert("비밀번호는 4~12자의 영문/숫자만 가능합니다.");
            objPwd.focus();
            return false;
        }
		
		return true;
	}
</script>
<title>로그인</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<div class="container mt-5 w-25">	
	<div class="input-form-backgroud">
      <div class="input-form">
		<form method="post" onsubmit="return validate()" action="<%=request.getContextPath()%>/user_login_ok.go">
			<div class="mt-3">
				<label for="EmailInput" class="form-label">아이디</label>
				<input name="email" type="email" class="form-control" id="EmailInput" placeholder="예) travler@example.com">
			</div>
			
			<div class="mt-3">
				<label for="PwdInput" class="form-label">비밀번호</label>
				<input name="password" type="password" class="form-control" id="PwdInput" placeholder="비밀번호를 입력하세요.">
			</div>
			
			<div class="d-grid mt-3 mb-3">
				<button type="submit" class="btn btn-primary">로그인</button>
			</div>
			
			<div class="d-flex justify-content-center">
				<div class="p-2">
					<a href="<%=request.getContextPath()%>/user_findid.go">아이디 찾기</a>
				</div>
				<div class="p-2">
					<a href="<%=request.getContextPath()%>/user_findpwd.go">비밀번호 찾기</a>
				</div>
				<div class="p-2">
					<a href="<%=request.getContextPath()%>/user_signin.go">회원 가입</a>
				</div>
			</div>
		</form>
		</div>
		</div>
	</div>
	
</body>
</html>