<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>검색사항 상세보기</title>
</head>
<body class="bg-light">
<jsp:include page="../../include/header.jsp" />

<div class="container my-5" style="max-width: 750px;">
    <c:set var="dto" value="${Cont}" /> 

    <!-- ✅ 제목 -->
    <h2 class="text-center mb-4 fw-bold text-primary">
        <i class="bi bi-megaphone-fill me-2 text-danger"></i> 게시글 검색내용
    </h2>

    <!-- ✅ 부트스트랩 테이블 -->
    <table class="table table-bordered bg-white shadow-sm">
        <tbody>
            <tr>
                <th scope="row" class="bg-light text-center text-secondary">작성자</th>
                <td>관리자</td>
            </tr>
            <tr>
                <th scope="row" class="bg-light text-center text-secondary">제목</th>
                <td>${dto.title}</td>
            </tr>
            <tr>
                <th scope="row" class="bg-light text-center text-secondary">내용</th>
                <td style="white-space: pre-wrap;">${dto.content}</td>
            </tr>
            <tr>
                <th scope="row" class="bg-light text-center text-secondary">작성일자</th>
                <td>${dto.created_at}</td>
            </tr>
            <c:if test="${not empty dto.updated_at}">
                <tr>
                    <th scope="row" class="bg-light text-center text-secondary">수정일자</th>
                    <td>${dto.updated_at}</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- ✅ 목록 버튼 -->
    <div class="text-end mt-4">
        <a href="/posts_list.go/${CategoryId}?page=${Page}" class="btn btn-outline-secondary">
		    <i class="bi bi-arrow-left-circle"></i> 목록으로
		</a>

    </div>
</div>

</body>
</html>
