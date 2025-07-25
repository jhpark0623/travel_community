<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">
	/* .auth-box {
      display: none;
      margin-top: 20px;
    } */
	
</style>
<script type="text/javascript">

	/* function showBox(method) {
	  document.getElementById("phoneBox").style.display = "none";
	  document.getElementById("emailBox").style.display = "none"; 
	  if (method === "phone") {
	    document.getElementById("phoneBox").style.display = "block";
	  }  else if (method === "email") {
	    document.getElementById("emailBox").style.display = "block";
	  } 
	} */

	function validateByPhone() {
		
		var objPhone = document.getElementById("phone");
		var objNamePhone = document.getElementById("namePhone");
		
        // name,nickname 정규화 공식
        const regul3 = /^[가-힝a-zA-Z]{2,}$/;
        // phone 정규화 공식
        const regul4 = /^01[0-9]-\d{3,4}-\d{4}$/;
        
     	// 이름
        if (!regul3.test(objNamePhone.value)) {
            alert("이름은 한글 또는 영문 2자 이상 입력해주세요.");
            objNamePhone.focus();
            return false;
        }	
        
     	// 전화번호
        if (!regul4.test(objPhone.value)) {
            alert("전화번호 형식이 올바르지 않습니다. -을 포함해서 입력해주세요.");
            objPhone.focus();
            return false;
        }
     	return true;
	}
	
	/* function validateByEmail() {
		
		var objEmail = document.getElementById("email");
		var objNameEmail = document.getElementById("nameEmail");
		
		// email 정규화 공식
	    const regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
        // name,nickname 정규화 공식
        const regul3 = /^[가-힝a-zA-Z]{2,}$/;
        
     	// 이름
        if (!regul3.test(objNameEmail.value)) {
            alert("이름은 한글 또는 영문 2자 이상 입력해주세요.");
            objNameEmail.focus();
            return false;
        }
        
     	// 이메일
        if (!regul2.test(objEmail.value)) {
            alert("이메일 형식이 올바르지 않습니다.");
            objEmail.focus();
            return false;
        }     	
     	return true;
	} */
		
</script>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	
	<div class="container mt-5 w-25">
		
		<!-- 인증방식 선택 -->
		<!-- <div class="mb-3">
		    <label class="form-label">인증 방법을 선택하세요:</label>
		    <div class="form-check">
		      <input class="form-check-input" type="radio" name="authMethod" id="radioPhone" onclick="showBox('phone')">
		      <label class="form-check-label" for="radioPhone">휴대전화로 찾기</label>
		    </div>
		    <div class="form-check">
		      <input class="form-check-input" type="radio" name="authMethod" id="radioEmail" onclick="showBox('email')">
		      <label class="form-check-label" for="radioEmail">이메일로 찾기</label>
    		</div> 
	  	</div> -->
		
		<!-- 휴대전화로 찾기 -->
		<div id="phoneBox" class="auth-box border p-3 rounded">
		   	<h5>휴대전화로 찾기</h5>
		   	
		   	<form method="post" onsubmit="return validateByPhone()" action="<%=request.getContextPath()%>/user_findid_ok.go">
		   		<div class="input-form-background">
			    <div class="mb-2">
			      <label for="namePhone" class="form-label">이름</label>
			      <input type="text" class="form-control" id="namePhone" name="name" placeholder="홍길동">
			    </div>
			    <div class="mb-2">
			      <label for="phone" class="form-label">휴대전화 번호</label>
			      <input type="tel" class="form-control" id="phone" name="phone" placeholder="예) 010-1111-1234">
			    </div>
			    <input class="btn btn-success mt-3" type="submit" value="아이디 찾기" name="submit">
			    </div>
		    </form>
		</div>
	
		<%-- <!-- 이메일로 찾기 -->
		<div id="emailBox" class="auth-box border p-3 rounded">
			<h5>이메일로 찾기</h5>
			
			<form method="post" onsubmit="return validateByEmail()" action="<%=request.getContextPath()%>/user_findid_ok.go">
				<div class="mb-2">
				  <label for="nameEmail" class="form-label">이름</label>
				  <input type="text" class="form-control" id="nameEmail" name="name" placeholder="홍길동">
				</div>
				<div class="mb-2">
				  <label for="email" class="form-label">이메일 주소</label>
				  <input type="text" class="form-control" id="email" name="email" placeholder="예) travler@example.com">
				</div>
				<input class="btn btn-success" type="submit" value="아이디 찾기" name="submit">
			</form>
		</div> --%>
	
	</div>
	
	

</body>
</html>