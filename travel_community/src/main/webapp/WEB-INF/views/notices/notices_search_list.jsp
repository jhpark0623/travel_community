<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 전체 리스트</title>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div class="container my-5">
		<h2 class="text-center mb-4">📢 Notices 공지 검색 리스트</h2>

		<!-- ✅ paging 변수 설정 -->
		<c:set var="paging" value="${Paging}" />

		<!-- 전체 게시물 수 -->
		<div class="d-flex justify-content-end mb-2">
			<small class="text-muted">전체 게시물 수: ${paging.totalRecord}개</small>
		</div>

		<!-- 게시글 리스트 테이블 -->
		<table
			class="table table-bordered table-striped align-middle text-center">
			<thead class="table-primary">
				<tr>
					<th style="width: 56px;">번호</th>
					<th style="width: 207px;">제목</th>
					<th style="width: 117px;">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${!empty searchPageList}">
					<c:forEach items="${searchPageList}" var="dto">
						<tr>
							<td>${dto.id}</td>
							<td class="text-start position-relative p-0"><a
								href="${pageContext.request.contextPath}/notices_search_content.go?no=${dto.id}&page=${paging.page}"
								class="d-block stretched-link text-decoration-none px-2 py-2">
									${dto.title} </a></td>
							<td>${dto.displayDate}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty searchPageList}">
					<tr>
						<td colspan="6" class="text-center">
							<div class="py-4 fw-bold">공지사항 검색 리스트가 없습니다</div>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<!-- 글쓰기 버튼 -->
		<div class="d-flex justify-content-end my-3">
			<a href="notices_write.go" class="btn btn-success">✍ 글쓰기</a>
		</div>

		<!-- 페이징 처리 -->
		<nav>
			<ul class="pagination justify-content-center">
				<c:if test="${paging.page > paging.block}">
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/notices_list.go?page=1">처음</a>
					</li>
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/notices_list.go?page=${paging.startBlock - 1}">이전</a>
					</li>
				</c:if>

				<c:forEach begin="${paging.startBlock}" end="${paging.endBlock}"
					var="i">
					<li class="page-item ${i == paging.page ? 'active' : ''}"><a
						class="page-link"
						href="${pageContext.request.contextPath}/notices_list.go?page=${i}">${i}</a>
					</li>
				</c:forEach>

				<c:if test="${paging.endBlock < paging.allPage}">
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/notices_list.go?page=${paging.endBlock + 1}">다음</a>
					</li>
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/notices_list.go?page=${paging.allPage}">마지막</a>
					</li>
				</c:if>
			</ul>
		</nav>

		<!-- ✅ 검색 영역 -->
		<form method="post"
			action="${pageContext.request.contextPath}/notices_search.go"
			class="d-flex justify-content-center mt-4">
			<div class="input-group w-50">
				<select class="form-select" name="field">
					<option value="title">제목</option>
					<option value="cont">내용</option>
				</select> <input type="text" name="keyword" class="form-control"
					placeholder="검색어를 입력하세요">
				<button class="btn btn-outline-primary" type="submit">검색</button>
			</div>
		</form>
	</div>



</body>
</html>