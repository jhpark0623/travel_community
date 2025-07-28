<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 정보</title>

<!-- ✅ Bootstrap CDN 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

  <jsp:include page="../../include/header.jsp" />

  <c:set value="${UserProfile }" var="user" />

  <div class="container mt-5" style="max-width: 700px;">
    <div class="card shadow-sm">
      <div class="card-header bg-primary text-white text-center">
        <h4 class="mb-0">${user.name} 님의 정보</h4>
      </div>
      <div class="card-body">
        <form method="post" action="<%=request.getContextPath()%>/myprofileModify.go">
          <input type="hidden" name="id" value="${user.id}">
          <input type="hidden" name="password" value="${user.password}">

          <div class="mb-3">
            <label class="form-label">이름</label>
            <input class="form-control" value="${user.name}" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">이메일</label>
            <input class="form-control" value="${user.email}" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">전화번호</label>
            <input class="form-control" name="phone" value="${user.phone}">
          </div>

          <div class="mb-3">
            <label class="form-label">닉네임</label>
            <input class="form-control" name="nickname" value="${user.nickname}">
          </div>

          <div class="mb-3">
            <label class="form-label">가입일자</label>
            <input class="form-control" value="${user.created_at}" readonly>
          </div>

          <div class="mb-4">
            <label class="form-label">현재 비밀번호 입력</label>
            <input type="password" class="form-control" name="pwd" required>
          </div>

          <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">수정하기</button>
            <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
            <button type="button" class="btn btn-danger"
              onclick="if(confirm('정말 회원 탈퇴하시겠습니까?')) location.href='<%=request.getContextPath()%>/deleteUser.go';">
              회원 탈퇴
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

</body>
</html>
