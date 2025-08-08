<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>

    

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

        .bg {
            margin-top: 30px;
            text-align: center;
        }

        .bg .btn {
            min-width: 100px;
            margin: 0 5px;
            font-size: 15px;
            padding: 10px 18px;
        }
    </style>
</head>
<body>
 
 	<jsp:include page="../../include/header.jsp" />
	
<div class="container" style="max-width: 750px; padding: 30px;"> <!-- ✅ 너비+패딩 증가 -->
    <c:set var="dto" value="${Content}" />

    <!-- 제목 -->
    <div class="main-title">
        <i class="bi bi-megaphone-fill"></i> 공지사항 상세보기
    </div>

	<table class="table table-bordered shadow-sm rounded bg-white">
	    <tbody>
	        <!-- 제목 -->
	        <tr class="table-primary">
	            <th class="text-center align-middle" style="width: 15%;">제목</th>
	            <td colspan="3" class="fw-bold fs-5 text-dark">${dto.title}</td>
	        </tr>
	
	        <!-- 작성자 / 작성일 or 수정일 -->
	        <tr>
	            <th class="text-center align-middle">작성자</th>
	            <td class="text-secondary" style="width: 25%;">관리자</td>
	
	            <c:if test="${not empty dto.updated_at}">
	                <th class="text-center align-middle">수정일자</th>
	                <td class="text-secondary">${dto.updated_at}</td>
	            </c:if>
	
	            <c:if test="${empty dto.updated_at}">
	                <th class="text-center align-middle">작성일자</th>
	                <td class="text-secondary">${dto.created_at}</td>
	            </c:if>
	        </tr>
	
	        <!-- 내용 -->
	        <tr>
	            <th class="text-center align-middle">내용</th>
	            <td colspan="3" style="padding: 0;">
	                <div class="p-4 bg-light text-dark" style="min-height: 200px; border-radius: 0 0 6px 6px;">
	                    ${dto.content}
	                </div>
	            </td>
	        </tr>
	    </tbody>
	</table>

    <!-- 버튼 -->
    <div class="btn-group bg">
	    <c:if test="${loginUser.role eq 'ADMIN'}">
	        <button class="btn btn-outline-primary"
	                onclick="location.href='notices_modify.go?no=${dto.id}&page=${Page}'">글수정</button>
	
	        <button class="btn btn-outline-danger"
	                onclick="if(confirm('게시글을 정말로 삭제하시겠습니까?')) {
	                             location.href='notices_delete.go?no=${dto.id}&page=${Page}'
	                         }">글삭제</button>
	    </c:if>
	
	    <button class="btn btn-outline-secondary"
	            onclick="location.href='notices_list.go?page=${Page}'">전체목록</button>
	</div>
</div>


</body>
</html>
