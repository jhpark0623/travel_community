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
	
	<h1>프론트 요소 구상중..</h1>
	
	<c:set var="dto" value="${res }" />
	
	<c:if test="${empty dto.password}">
		<b>일치하는 결과 없음.</b>
		
		<button class="btn btn-outline-secondary" onclick="history.back()">뒤로가기</button>
	</c:if>
	
	<c:if test="${!empty dto.password}">
		<span>${dto.name }</span>
		<span>${dto.phone }</span>
		<span>${dto.created_at }</span>		
		<span>${dto.email }</span>
		<span>${dto.password }</span>
		
		<button class="btn btn-outline-secondary"
						onclick="location.href='<%=request.getContextPath()%>/user_login.go'">로그인</button>
	</c:if>

</body>
</html>