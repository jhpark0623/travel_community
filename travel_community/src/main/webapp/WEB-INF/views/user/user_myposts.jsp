<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="../../include/header.jsp" />
	
	<div align="center">
		<c:set var="posts" value="${myPosts }" />
		<h2>내가 작성한 게시물 </h2>
		
		<table border="1" width="800">
			<tr>
				<th>지역</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성일자</th>
				<th>수정일자</th>
				
			</tr>
			
				<c:forEach items="${posts}" var="post">
					<tr>
						<td> ${post.city_id } </td>
						<td> ${post.title } </td>
						<td> ${post.content } </td>
						<td> ${post.created_at} </td>
						<c:choose>
							<c:when test="${!empty post.updated_at }">
								<td>${post.updated_at }</td>
							</c:when>
							<c:otherwise>
								<td>-------</td>
							</c:otherwise>
							
						</c:choose>
					</tr>
				</c:forEach>
				
				<c:if test="${empty posts }">
					<tr>
						<th colspan="5"> 검색된 게시물이 없습니다!!</th>
					</tr>
				</c:if>
		</table>
	</div>
	<br><br>
	<div align="center">
		<form method="get" action="<%= request.getContextPath() %>/myposts_search.go">
			<input name="myposts_search" placeholder="내용 or 제목">
			<input type="submit" value="검색">
		
		</form>
	
	
	
	</div>

</body>
</html>