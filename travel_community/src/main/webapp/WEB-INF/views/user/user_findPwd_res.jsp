<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	
	<c:set var="dto" value="${res }" />	
	
	<div class="card mx-auto" style="width: 22rem;">
	  <div class="card-body">
	  	<c:if test="${!empty dto.password}">
		    <h5 class="card-title">비밀번호 찾기 결과</h5>
		    <h6 class="card-subtitle mt-1 mb-2 text-muted">${dto.name }님의 비밀번호를 찾았습니다.</h6>
		    <p class="card-text"><b>비밀번호 : ${dto.password }</b></p>
		    <p class="card-text">아이디 : ${dto.email }</p>
		    <p class="card-text">휴대전화 번호 : ${dto.phone }</p>
		    <p class="card-text">회원 가입일 : ${dto.created_at }</p>
		    <button class="btn btn-outline-primary"
						onclick="location.href='<%=request.getContextPath()%>/user_login.go'">로그인</button>
		</c:if>
		
		<c:if test="${empty dto.password}">
			<h5 class="card-title">비밀번호 찾기 결과</h5>
		    <h6 class="card-subtitle mt-1 mb-2 text-muted">${name }님의 비밀번호를 찾지 못했습니다.</h6>
		    <button class="btn btn-outline-secondary" onclick="history.back()">뒤로가기</button>
		</c:if>
		
	  </div>
	</div>
	
</body>
</html>