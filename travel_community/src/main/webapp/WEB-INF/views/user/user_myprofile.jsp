<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 정보</title>

<style>
.table-wrapper {
  width: 600px;        /* 테이블 가로 크기 */
  height: 600px;       /* 테이블 세로 크기 */
  overflow: auto;      /* 내용이 넘치면 스크롤 */
  margin: 0 auto;      /* 가운데 정렬 */
}

.custom-table {
  width: 100%;
  height: 100%;
  table-layout: fixed;
}
</style>

</head>
<body>

  <jsp:include page="../../include/header.jsp" />

  <div  class="text-center mt-5">
    <h2>${UserProfile.name }님 정보</h2>
  </div>

  <c:set value="${UserProfile }" var="user" />

  <div class="table-wrapper mt-3">
    <form method="post" action="#">
      <table class="table table-borderless table-hover custom-table">
        <tr>
          <th>이 름</th>
          <td><input class="form-control" value="${user.name }" readonly></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input class="form-control" value="${user.email }" readonly></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input class="form-control" value="${user.phone }" readonly></td>
        </tr>
        <tr>
          <th>닉네임</th>
          <td><input class="form-control" value="${user.nickname }"></td>
        </tr>
        <tr>
          <th>가입일자</th>
          <td><input class="form-control" value="${user.created_at }" readonly></td>
        </tr>
      </table>

      <div class="text-center">
        <input type="submit" value="수정하기" class="btn btn-primary me-2">
        <input type="button" onclick="history.back()" value="취소" class="btn btn-secondary me-2">
        <input type="button" onclick="#" value="회원 탈퇴" class="btn btn-danger">
      </div>
    </form>
  </div>

</body>
</html>
