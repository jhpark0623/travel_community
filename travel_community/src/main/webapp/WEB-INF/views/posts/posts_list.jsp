<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Posts 리스트</title>
<style>
td a.text-dark:hover {
	color: #0d6efd !important;
	text-decoration: underline !important;
}

td a.d-block:hover {
	color: #0d6efd !important;
	text-decoration: underline !important;
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div class="container my-5" style="width: 900px">

		<h2 class="text-center mb-4">📋 Posts 게시물 리스트</h2>



		<div class="container my-4 d-flex align-items-center">

				<div class="container my-4 d-flex align-items-center">
					<div class="d-flex flex-column" style="margin-right: 20px;">
						<label for="selectCity" class="form-label fw-bold mb-1">시/광역시</label>
						<select id="provinceSelect" class="form-select"
							style="width: 200px;" name="province">
							<option value="">시/광역시</option>
							<c:forEach items="${provinceList }" var="province">
								<option value="${province.getId() }">${province.getName() }</option>
							</c:forEach>
						</select>
					</div>

					<div class="d-flex flex-column" style="margin-right: 60px;">
						<label for="selectDistrict" class="form-label fw-bold mb-1">시/군/구</label>
						<select id="citySelect" class="form-select" style="width: 200px;"
							name="city_id">
							<option>시/군/구</option>
						</select>
					</div>
				</div>

		<!-- ✅ 검색 영역 -->
		<form method="get" action="${pageContext.request.contextPath}/posts_list.go/${CategoryId}" class="d-flex justify-content-center mt-4">
		    <div class="input-group" style="width: 600px;">
		        <select class="form-select" name="field" style="max-width: 120px;">
				    <option value="title" <c:if test="${field == 'title'}">selected</c:if>>제목</option>
				    <option value="cont" <c:if test="${field == 'cont'}">selected</c:if>>내용</option>
				    <option value="nickname" <c:if test="${field == 'nickname'}">selected</c:if>>작성자</option>
				    <option value="hashtag" <c:if test="${field == 'hashtag'}">selected</c:if>>해시태그</option>
				</select>
		        <input type="text" name="keyword" class="form-control" style="max-width: 280px;" placeholder="검색어를 입력하세요" value="${keyword}">
		        <c:if test="${not empty cityId}">
		            <input type="hidden" name="cityId" value="${cityId}" />
		        </c:if>
		        <button class="btn btn-outline-primary" type="submit">검색</button>
		    </div>
		</form>

	</div>

			<!-- ✅ 전체 게시물 수 -->
			<div class="d-flex justify-content-end mb-2">
				<small class="text-muted">전체 게시물 수: ${Paging.totalRecord}개</small>
			</div>

			<!-- ✅ 게시글 리스트 테이블 -->

			<!-- cList 영역 -->
			<table
				class="table table-bordered table-striped align-middle text-center">
				<thead class="table-primary">
					<tr>
						<th style="width: 90px;">글번호</th>
						<th>제목</th>
						<th style="width: 120px;">작성자</th>
						<th style="width: 140px;">작성일</th>
						<th style="width: 65px;">조회수</th>
						<th style="width: 65px">좋아요</th>
					</tr>
				</thead>
				<tbody>

					<c:if test="${!empty cList}">
						<c:forEach items="${cList}" var="dto">

							<!-- 공지사항 목록 출력 -->
							<c:if test="${empty dto.nickname }">
								<tr>
									<td style="color: #ff0000; font-weight: bold;">공지사항</td>
									<td class="text-start position-relative p-0"><a
										href="${pageContext.request.contextPath}/notices_content.go?no=${dto.id}&page=${Paging.page}"
										class="d-block stretched-link text-decoration-none px-2 py-2">
											${dto.title} </a></td>
									<td>관리자</td>
									<td>${dto.displayDate}</td>
									<td>${dto.view_count}</td>
									<td>${dto.like_count}</td>
								</tr>
							</c:if>

							<!-- 게시글 목록 출력 -->
							<c:if test="${!empty dto.nickname }">
								<tr>
									<td>${dto.id }</td>
									<td class="text-start position-relative p-0"
										style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
										<a
										href="<%=request.getContextPath() %>/post_detail.go?id=${dto.id}&page=${Paging.page}"
										class="d-block stretched-link text-decoration-none px-2 py-2 text-dark fw-bold">
											${dto.title} </a>
									</td>
									<td>${dto.nickname }</td>
									<td>${dto.displayDate}</td>
									<td>${dto.view_count}</td>
									<td>${dto.like_count}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>


					<c:if test="${empty cList}">
						<tr>
							<td colspan="6" class="text-center">
								<div class="py-4 fw-bold">전체 게시물 목록이 없습니다.</div>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			
	<!-- ✅ 페이징 처리  -->
	<nav>
	  <ul class="pagination justify-content-center">
	
	    <!-- 처음 페이지로 이동 -->
	    <c:if test="${Paging.page > Paging.block}">
	      <li class="page-item">
	        <a class="page-link"
	           href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=1
	           <c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>
	           <c:if test='${not empty cityId}'>&cityId=${cityId}</c:if>">
	          처음
	        </a>
	      </li>
	    </c:if>
	
	    <!-- 이전 블럭으로 이동 -->
	    <c:if test="${Paging.page > Paging.block}">
	      <li class="page-item">
	        <a class="page-link"
	           href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.startBlock - 1}
	           <c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>
	           <c:if test='${not empty cityId}'>&cityId=${cityId}</c:if>">
	          이전
	        </a>
	      </li>
	    </c:if>
	
	    <!-- 페이지 번호 출력 -->
	    <c:forEach var="i" begin="${Paging.startBlock}" end="${Paging.endBlock}">
	      <li class="page-item ${Paging.page == i ? 'active' : ''}">
	        <a class="page-link"
	           href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${i}
	           <c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>
	           <c:if test='${not empty cityId}'>&cityId=${cityId}</c:if>">
	          ${i}
	        </a>
	      </li>
	    </c:forEach>
	
	    <!-- 다음 블럭으로 이동 -->
	    <c:if test="${Paging.endBlock < Paging.allPage}">
	      <li class="page-item">
	        <a class="page-link"
	           href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.endBlock + 1}
	           <c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>
	           <c:if test='${not empty cityId}'>&cityId=${cityId}</c:if>">
	          다음
	        </a>
	      </li>
	    </c:if>
	
	    <!-- 마지막 페이지로 이동 -->
	    <c:if test="${Paging.endBlock < Paging.allPage}">
	      <li class="page-item">
	        <a class="page-link"
	           href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.allPage}
	           <c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>
	           <c:if test='${not empty cityId}'>&cityId=${cityId}</c:if>">
	          마지막
	        </a>
	      </li>
	    </c:if>
	
	  </ul>
	</nav>


			<!-- ✅ 글쓰기 버튼 -->
			<div class="d-flex justify-content-end my-3">
				<a href="<%=request.getContextPath()%>/post_write.go"
					class="btn btn-success">✍ 글쓰기</a>
			</div>
			<!-- ✅ 지역 데이터 및 연동 스크립트 -->
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		</div>

	<script>
		$(document).ready(function() {	 
		    // 1. 시/도 선택 시 시/군/구 목록 가져오기
		    $('#provinceSelect').change(function(){
		        const provinceCode = $(this).val();
		
		        $.ajax({
		            type: "POST",
		            url: "<%=request.getContextPath()%>/getCityCode",
		            data: { "provinceCode": provinceCode },
		            success: function(res) {
		            	  console.log("응답 받은 데이터:", res); // 👈 이 줄 추가

		                $('#citySelect').empty();
		                $('#citySelect').append("<option value=''>시/군/구</option>");
		
		                for (const city of res) {
		                    const option = $("<option>").val(city.id).text(city.name);
		                    $('#citySelect').append(option);
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error("AJAX 실패:", error);
		            }
		        });
		    });
		
		    // 2. 시/군/구 선택 시 게시글 리스트 필터 적용
		    $('#citySelect').change(function() {
		        const selectedCityId = $(this).val();
		        if (selectedCityId && selectedCityId !== "") {
		            const categoryId = "<c:out value='${CategoryId}'/>";
		            const contextPath = "<%=request.getContextPath()%>";
		            const url = `/posts_list.go/`+categoryId+`?page=1&cityId=` + selectedCityId;
		            window.location.href = url;
		        }
		    });
		});
		</script>
</body>
</html>