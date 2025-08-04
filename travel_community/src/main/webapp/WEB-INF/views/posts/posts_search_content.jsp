<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
 
<meta charset="UTF-8">
<title>검색사항 상세보기</title>



<style>
body {
	background-color: #f1f5f9;
	font-family: 'Segoe UI', sans-serif;
}

.main-title {
	font-size: 1.8rem;
	font-weight: bold;
	color: #2c3e50;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 40px;
	margin-bottom: 30px;
}

.main-title i {
	font-size: 1.8rem;
	color: #e74c3c;
	margin-right: 10px;
}

.notice-table {
	width: 100%;
	background-color: white;
	border-collapse: collapse;
	border-radius: 6px;
	overflow: hidden;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	font-size: 16px; /* ✅ 글자 크기 키움 */
}

.notice-table th {
	background-color: #dbeafe;
	text-align: center;
	vertical-align: middle;
	color: #1e3a8a;
	font-weight: 600;
	width: 20%;
	padding: 20px; /* ✅ 셀 높이 증가 */
}

.notice-table td {
	background-color: #ffffff;
	padding: 20px 24px; /* ✅ 여백 증가 */
	color: #333;
	vertical-align: middle;
}

.notice-table tr:nth-child(even) td {
	background-color: #f8fafc;
}

.btn-group {
	margin-top: 30px;
	text-align: center;
}

.btn-group .btn {
	min-width: 100px;
	margin: 0 5px;
	font-size: 15px;
	padding: 10px 18px;
}
</style>

</head>

<body class="bg-light">
<jsp:include page="../../include/header.jsp" />
 

	<div class="container" style="max-width: 750px; padding: 30px;">
		<!-- ✅ 너비+패딩 증가 -->
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
</div>
</body>
</html>
