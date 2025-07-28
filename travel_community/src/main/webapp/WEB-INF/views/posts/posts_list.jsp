<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Posts 리스트</title>
 
</head>
<body>

<jsp:include page="../../include/header.jsp" />

	<div class="container my-5" style="width: 900px">
	
	    <h2 class="text-center mb-4">📋 Posts 게시물 리스트</h2>
	
	    <!-- ✅ 전체 게시물 수 -->
	    <div class="d-flex justify-content-end mb-2">
	        <small class="text-muted">전체 게시물 수: ${Paging.totalRecord}개</small>
	    </div>
	     
		<div class="container my-4 d-flex align-items-center">
		  <div class="d-flex flex-column" style="margin-right: 50px;">
		    <label for="selectCity" class="form-label fw-bold mb-1">시/광역시</label>
		    <select id="selectCity" class="form-select" style="width: 200px;">
			  <option value="">선택하세요</option>
			  <option value="서울특별시">서울특별시</option>
			  <option value="부산광역시">부산광역시</option>
			  <option value="인천광역시">인천광역시</option>
			  <option value="광주광역시">광주광역시</option>
			  <option value="대전광역시">대전광역시</option>
			  <option value="울산광역시">울산광역시</option>
			  <option value="세종특별자치시">세종특별자치시</option>
			  <option value="경기도">경기도</option>
			  <option value="강원특별자치도">강원특별자치도</option>
			  <option value="충청북도">충청북도</option>
			  <option value="충청남도">충청남도</option>
			  <option value="전라남도">전라남도</option>
			  <option value="전라북도">전라북도</option>
			  <option value="경상남도">경상남도</option>
			  <option value="경상북도">경상북도</option>
			  <option value="제주특별자치도">제주특별자치도</option>
			</select>

		  </div>
		
		  <div class="d-flex flex-column" style="margin-right: 50px;">
            <label for="selectDistrict" class="form-label fw-bold mb-1">시/군/구</label>
            <select id="selectDistrict" class="form-select" style="width: 200px;">
                <option value="">선택하세요</option>
            </select>
        </div>
		  
		
		  <a href="posts_write.go" class="btn btn-success ms-auto" style="height: 38px; margin-top: 24px; ">
		    ✍ 글쓰기
		  </a>
		</div>


	    <br> <br>
	
	    <!-- ✅ 공지사항 영역 -->
	    <c:if test="${!empty popNotice}">
		    <div class="mb-3">
		        <h5 class="text-danger fw-bold">📢 공지사항</h5>
		        <table class="table table-bordered table-hover align-middle bg-light">
		            <thead class="table-secondary">
		                <tr>
		                    <th style="text-align:center;">제목</th> 
		                    <th class="text-center" style="width: 120px;">작성자</th> 
		                    <th class="text-center" style="width: 140px;">작성일</th> 
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach items="${popNotice}" var="notice">
		                    <tr>
		                        <td>
		                            <a href="${pageContext.request.contextPath}/notices_content.go?no=${notice.id}&page=${Paging.page}" class="d-block  text-decoration-none px-2 py-2">
		                                ${notice.title}
		                            </a>
		                        </td>
		                        <td class="text-center">관리자</td>  
		                        <td class="text-center">${notice.displayDate}</td>  
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</c:if>
	
	    <!-- ✅ 게시글 리스트 테이블 -->
	    <table class="table table-bordered table-striped align-middle text-center">
	        <thead class="table-primary">
	            <tr>
	                <th style="width: 65px;">글번호</th>
	                <th>제목</th>
	                <th style="width: 120px;">작성자</th>
	                <th style="width: 140px;">작성일</th>
	                <th style="width: 65px;">조회수</th>
	                <th style="width: 65px">좋아요</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:if test="${!empty List}">
	                <c:forEach items="${List}" var="dto">
	                    <tr>
	                        <td>${dto.id}</td>
	                        <td class="text-start position-relative p-0">
	                            <a href="<%=request.getContextPath() %>/post_detail.go?id=${dto.id}&page=${Paging.page}" 
	                               class="d-block stretched-link text-decoration-none px-2 py-2">
	                                 ${dto.title}
	                            </a>
	                        </td>
	                        <td>${dto.nickname}</td>
	                        <td>${dto.displayDate}</td>
	                        <td>${dto.view_count}</td>
	                        <td>${dto.like_count}</td>
	                    </tr>
	                </c:forEach>
	            </c:if>
	            <c:if test="${empty List}">
	                <tr>
	                    <td colspan="6" class="text-center">
	                        <div class="py-4 fw-bold">전체 게시물 목록이 없습니다.</div>
	                    </td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	
	  
	    <!-- ✅ 페이징 처리 -->
	    <nav>
		    <ul class="pagination justify-content-center">
		        <c:if test="${Paging.page > Paging.block}">
		            <li class="page-item">
		                <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=1">처음</a>
		            </li>
		            <li class="page-item">
		                <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.startBlock - 1}">이전</a>
		            </li>
		        </c:if>
		
		        <c:forEach begin="${Paging.startBlock}" end="${Paging.endBlock}" var="i">
		            <li class="page-item ${i == Paging.page ? 'active' : ''}">
		                <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${i}">${i}</a>
		            </li>
		        </c:forEach>
		
		        <c:if test="${Paging.endBlock < Paging.allPage}">
		            <li class="page-item">
		                <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.endBlock + 1}">다음</a>
		            </li>
		            <li class="page-item">
		                <a class="page-link" href="${pageContext.request.contextPath}/posts_list.go/${CategoryId}?page=${Paging.allPage}">마지막</a>
		            </li>
		        </c:if>
		    </ul>
		</nav>
	
	    <!-- ✅ 검색 영역 -->
	   <form method="post" action="<%=request.getContextPath() %>/posts_search.go" class="d-flex justify-content-center mt-4">

	      <div class="input-group w-50">
	         <select class="form-select" name="field">
	            	<option value="title">제목</option>
	                <option value="cont">내용</option>
	                <option value="nickname">작성자</option>
	                <option value="hashtag">해시태그</option>
	         </select>
	         <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">
	         <button class="btn btn-outline-primary" type="submit">검색</button>
	      </div>
	   </form>
	</div> 
	<!-- ✅ 지역 데이터 및 연동 스크립트 -->
	
	<script>
	const districtData = {
		    '서울특별시': ['종로구', '중구', '용산구', '성동구', '광진구', '동대문구', '중랑구', '성북구', '강북구', '도봉구', '노원구', '은평구', '서대문구', '마포구', '양천구', '강서구', '구로구', '금천구', '영등포구', '동작구', '관악구', '서초구', '강남구', '송파구', '강동구'],
		    '부산광역시': ['중구', '서구', '동구', '영도구', '부산진구', '동래구', '남구', '북구', '해운대구', '사하구', '금정구', '강서구', '연제구', '수영구', '사상구', '기장군'],
		    '인천광역시': ['중구', '동구', '미추홀구', '연수구', '남동구', '부평구', '계양구', '서구', '강화군', '옹진군'],
		    '광주광역시': ['동구', '서구', '남구', '북구', '광산구'],
		    '대전광역시': ['동구', '중구', '서구', '유성구', '대덕구'],
		    '울산광역시': ['중구', '남구', '동구', '북구', '울주군'],
		    '세종특별자치시': ['세종시'],
		    '경기도': ['수원시', '고양시', '용인시', '성남시', '부천시', '화성시', '남양주시', '안산시', '평택시', '의정부시', '시흥시', '파주시', '김포시', '광명시', '광주시', '군포시', '오산시', '이천시', '안성시', '구리시', '의왕시', '하남시', '여주시', '양평군', '동두천시', '과천시', '가평군', '연천군'],
		    '강원특별자치도': ['춘천시', '원주시', '강릉시', '동해시', '태백시', '속초시', '삼척시', '홍천군', '횡성군', '영월군', '평창군', '정선군', '철원군', '화천군', '양구군', '인제군', '고성군', '양양군'],
		    '충청북도': ['청주시', '충주시', '제천시', '보은군', '옥천군', '영동군', '증평군', '진천군', '괴산군', '음성군', '단양군'],
		    '충청남도': ['천안시', '공주시', '보령시', '아산시', '서산시', '논산시', '계룡시', '당진시', '금산군', '부여군', '서천군', '청양군', '홍성군', '예산군', '태안군'],
		    '전라북도': ['전주시', '군산시', '익산시', '정읍시', '남원시', '김제시', '완주군', '진안군', '무주군', '장수군', '임실군', '순창군', '고창군', '부안군'],
		    '전라남도': ['목포시', '여수시', '순천시', '나주시', '광양시', '담양군', '곡성군', '구례군', '고흥군', '보성군', '화순군', '장흥군', '강진군', '해남군', '영암군', '무안군', '함평군', '영광군', '장성군', '완도군', '진도군', '신안군'],
		    '경상북도': ['포항시', '경주시', '김천시', '안동시', '구미시', '영주시', '영천시', '상주시', '문경시', '경산시', '군위군', '의성군', '청송군', '영양군', '영덕군', '청도군', '고령군', '성주군', '칠곡군', '예천군', '봉화군', '울진군', '울릉군'],
		    '경상남도': ['창원시', '진주시', '통영시', '사천시', '김해시', '밀양시', '거제시', '양산시', '의령군', '함안군', '창녕군', '고성군', '남해군', '하동군', '산청군', '함양군', '거창군', '합천군'],
		    '제주특별자치도': ['제주시', '서귀포시']
		};
	
		const selectCity = document.getElementById('selectCity');
		const selectDistrict = document.getElementById('selectDistrict');
	
		selectCity.addEventListener('change', () => {
		    const city = selectCity.value;
		    const districts = districtData[city] || [];
	
		    // 시/군/구 select 초기화
		    selectDistrict.innerHTML = '<option value="">선택하세요</option>';
	
		    // districts가 비어있지 않으면 option 추가
		    districts.forEach(district => {
		        const option = document.createElement('option');
		        option.value = district;
		        option.textContent = district;
		        selectDistrict.appendChild(option);
		    });
		});

	</script>
	
	
</body>
</html>