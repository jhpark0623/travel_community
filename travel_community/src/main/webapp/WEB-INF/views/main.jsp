<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>travel_community</title>
<meta charset="UTF-8">


</head>
<body>

	<jsp:include page="../include/header.jsp" />


	<div align="center">
	   <hr width="30%" color="gray">
	      <h3>POSTS 테이블 메인 페이지</h3>
	   <hr width="30%" color="gray">
	   <br> <br>
 
	   <a href="<%=request.getContextPath() %>/posts_list.go/1">[자유 게시판]</a>
	   <a href="<%=request.getContextPath() %>/posts_list.go/2">[정보 게시판]</a>
	   <a href="<%=request.getContextPath() %>/posts_list.go/3">[질문 게시판]</a>
	   <a href="<%=request.getContextPath() %>/notices_list.go">[공지사항]</a>
	</div>



</body>
</html>
