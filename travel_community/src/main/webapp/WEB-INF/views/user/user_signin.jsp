<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script type="text/javascript">

	function validate() {
	    
	    var objEmail = document.getElementById("email");
	    var objPwd1 = document.getElementById("password1");
	    var objPwd2 = document.getElementById("password2");
	    var objName = document.getElementById("name");
	    var objNickname = document.getElementById("nickname");
	    var objPhone = document.getElementById("phone");
	    
	    // password 값 데이터 정규화 공식
        const regul1 = /^[a-zA-Z0-9]{3,12}$/;
        // email 정규화 공식
	    const regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
        // name,nickname 정규화 공식
        const regul3 = /^[가-힝a-zA-Z]{2,}$/;
        // phone 정규화 공식
        const regul4 = /^01[0-9]-\d{3,4}-\d{4}$/;

     	// 이메일
        if (!regul2.test(objEmail.value)) {
            alert("이메일 형식이 올바르지 않습니다.");
            objEmail.focus();
            return false;
        }

        // 비밀번호
        if (!regul1.test(objPwd1.value)) {
            alert("비밀번호는 3~12자의 영문/숫자만 가능합니다.");
            objPwd1.focus();
            return false;
        }

        // 비밀번호 재확인
        if (objPwd1.value !== objPwd2.value) {
            alert("비밀번호가 일치하지 않습니다.");
            objPwd2.focus();
            return false;
        }

        // 이름
        if (!regul3.test(objName.value)) {
            alert("이름은 한글 또는 영문 2자 이상 입력해주세요.");
            objName.focus();
            return false;
        }

        // 닉네임
        if (!regul3.test(objNickname.value)) {
            alert("닉네임은 한글 또는 영문 2자 이상 입력해주세요.");
            objNickname.focus();
            return false;
        }

        // 전화번호
        if (!regul4.test(objPhone.value)) {
            alert("전화번호 형식이 올바르지 않습니다. -을 포함해서 입력해주세요. (예: 010-1234-5678)");
            objPhone.focus();
            return false;
        }

        return true;
        
    }
	
    
    

</script>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<div class="container mt-5">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-6 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        
        <form method="post" onsubmit="return validate()" action="<%=request.getContextPath()%>/user_signin_ok.go">
          <div class="row">
            <div class="col-md-12 mb-3">
            	<label for="email">이메일</label>
            	<input type="email" class="form-control" id="email" placeholder="예) travler@example.com" name="email" >
            </div>
            
            <div class="col-md-12 mb-3">
            	<label for="password1">비밀번호</label>
            	<input type="password" class="form-control" id="password1" placeholder="비밀번호는 3~12자의 대소문자와 숫자로만 입력 가능" 
            	name="password" >
            </div>
            
            <div class="col-md-12 mb-3">
            	<label for="password2">비밀번호 재확인</label>
            	<input type="password" class="form-control" id="password2" placeholder="동일한 비밀번호를 입력해주세요.">
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" placeholder="" name="name" >
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname" placeholder="" name="nickname" >
              <div class="invalid-feedback">
                별명을 입력해주세요.
              </div>
            </div>
            
            <div class="col-md-12 mb-3">
            	<label for="phone">전화번호</label>
            	<input type="tel" class="form-control" id="phone" placeholder="예) 010-1111-1234" name="phone" 
            	maxlength="13" >
            </div>
            
            <div class="mb-4"></div>
         	<input class="btn btn-primary btn-lg btn-block" type="submit" name="submit" value="회원 가입">
            
          </div>
         
		</form>
	  </div>
	</div>
	</div>
		

</body>
</html>