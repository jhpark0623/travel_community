<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title} - 게시글 상세</title>
<style type="text/css">
/* 제목 강조 */
h2.mb-3 {
  font-size: 1.8rem;
  font-weight: 600;
  color: #2b2b2b;
}
/* 카테고리 링크 스타일 */
ul li a.text-dark:hover {
  color: #0d6efd;
  text-decoration: underline;
}

/* 해시태그 스타일 */
.custom-hashtag {
  background-color: #6c757d;
  color: #fff;
  font-size: 0.9rem;
  margin-right: 6px;
  padding: 6px 12px;
  border-radius: 15px;
  display: inline-block;
  text-decoration: none;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.custom-hashtag:hover {
  background-color: #495057;
  transform: scale(1.05);
}

/* 댓글 입력창 */
#commentArea textarea {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 10px;
  font-size: 0.95rem;
  width: 100%;
}

/* 댓글 말풍선 스타일 */
[id^="comment-"] {
  background-color: #f9f9f9;
  border-radius: 8px;
  padding: 10px;
  border: 1px solid #ddd;
  margin-bottom: 15px;
}

/* 댓글 수정/저장/삭제 버튼 간격 */
#commentArea button {
  margin-right: 6px;
}

/* 목록/이전/다음 버튼 공통 */
.post-nav-btn {
  font-size: 0.95rem;
  padding: 6px 14px;
  border-radius: 6px;
  font-weight: 500;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 2px 6px rgba(0,0,0,0.04);
  text-decoration: none;
}

/* 이전/다음 버튼 */
.btn-prev-next {
  border: 1px solid #ced4da;
  background-color: #f8f9fa;
  color: #495057;
}

.btn-prev-next:hover {
  background-color: #e2e6ea;
  color: #212529;
}

/* 목록으로 버튼 */
.btn-list {
  background-color: #212529;
  color: white;
  border: none;
}

.btn-list:hover {
  background-color: #343a40;
}
.container:hover {
  box-shadow: 0 6px 18px rgba(0,0,0,0.08);
}

</style>
</head>
<body>
<jsp:include page="../../include/header.jsp" />
<!-- 전체 컨테이너 -->
<div class="container mt-5 mb-5"
     style="width: 820px;border-radius: 2px; box-shadow: 0 3px 9px rgba(0,0,0,0.2); padding: 30px;margin-bottom: 100px;">
	
	<!-- 지역 -->
	<li class="list-inline-item d-flex align-items-center">
	    📍 <span class="ms-1">${post.province_name} ${post.city_name}</span>
	</li>
	
    <!-- 게시글 제목 -->
    <h2 class="mb-3">${post.title}</h2>

    <!-- 작성자/카테고리/날짜 정보 -->
	<ul class="list-inline text-muted mb-4 fs-6 d-flex flex-wrap gap-3">
	  <li class="list-inline-item d-flex align-items-center">
	    👤 <span class="ms-1">${post.nickname}</span>
	  </li>
	  <li class="list-inline-item d-flex align-items-center">
	    📂 <span class="ms-1">${post.category_name}</span>
	  </li>	  
	  <li class="list-inline-item d-flex align-items-center">
	    🕒 
	    <span class="ms-1">
	      <c:choose>
	        <c:when test="${not empty post.updated_at}">
	          수정일: ${post.updated_at}
	        </c:when>
	        <c:otherwise>
	          작성일: ${post.created_at}
	        </c:otherwise>
	      </c:choose>
	    </span>
	  </li>
	</ul>
    <hr>
    <!-- 본문 내용 -->
	<div class="mb-4 p-3">
	  <article class="lh-lg fs-6 text-dark">
	    <c:out value="${post.content}" escapeXml="false" />
	  </article>
	</div>
    <!-- 해시태그 -->
    <c:if test="${not empty hashtags}">
        <p>
            <c:forEach var="tag" items="${hashtags}">
                <a href="#" class="badge custom-hashtag">#${tag.hashtag}</a>
            </c:forEach>
        </p>
    </c:if>
    <hr>
	<!-- 조회수 / 좋아요 수 -->
    <div class="d-flex align-items-center mb-3">
    <span class="me-2">조회수: ${post.view_count}</span>
    <span class="me-2">좋아요: <span id="likeCount">${likeCount}</span></span>
    <!-- 좋아요 하트 버튼 -->
	<c:choose>
	  <c:when test="${not empty loginUser}">
	    <button id="likeBtn"
	            onclick="toggleLike(${post.id})"
	            class="btn p-0 border-0 bg-transparent"
	            style="cursor: pointer;">
	      <c:choose>
	        <c:when test="${postLiked}">
	          <!-- ❤️ 꽉 찬 하트 -->
	          <svg fill="red" width="24" height="24" viewBox="0 0 24 24">
	            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5
	                     2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09
	                     C13.09 3.81 14.76 3 16.5 3
	                     19.58 3 22 5.42 22 8.5
	                     c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
	          </svg>
	        </c:when>
	        <c:otherwise>
	          <!-- 🤍 빈 하트 -->
	          <svg fill="gray" width="24" height="24" viewBox="0 0 24 24">
	            <path d="M16.5 3c-1.74 0-3.41 0.81-4.5 2.09
	                     C10.91 3.81 9.24 3 7.5 3
	                     4.42 3 2 5.42 2 8.5
	                     c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32
	                     C18.6 15.36 22 12.28 22 8.5
	                     22 5.42 19.58 3 16.5 3z"/>
	          </svg>
	        </c:otherwise>
	      </c:choose>
	    </button>
	  </c:when>
	
	  <c:otherwise>
	    <!-- 비로그인: 클릭 시 알림 -->
	    <button class="btn p-0 border-0 bg-transparent"
	            style="cursor: pointer;"
	            onclick="alert('로그인 후 이용해주세요.')">
	      <svg fill="gray" width="24" height="24" viewBox="0 0 24 24">
	        <path d="M16.5 3c-1.74 0-3.41 0.81-4.5 2.09
	                 C10.91 3.81 9.24 3 7.5 3
	                 4.42 3 2 5.42 2 8.5
	                 c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32
	                 C18.6 15.36 22 12.28 22 8.5
	                 22 5.42 19.58 3 16.5 3z"/>
	      </svg>
	    </button>
	  </c:otherwise>
	</c:choose>
	</div>

    <!-- 수정/삭제 버튼 -->
    <c:if test="${not empty loginUser && (loginUser.id == post.user_id || loginUser.role eq 'ADMIN')}">
        <div class="mb-3">
            <button class="btn btn-outline-primary btn-sm" onclick="location.href='/post_edit.go?id=${post.id}'">✏ 수정</button>
            <form action="/post_delete.go" method="post" class="d-inline">
                <input type="hidden" name="id" value="${post.id}" />
                <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</button>
            </form>
        </div>
    </c:if>

    <hr>

	<!-- 이전/다음글 + 목록버튼 가운데 정렬 -->
	<div class="d-flex justify-content-between align-items-center position-relative mt-4">
	  <!-- 왼쪽: 이전글 -->
	  <div>
	    <c:choose>
	      <c:when test="${not empty prevId}">
	        <a href="/post_detail.go?id=${prevId}&page=${page}" class="post-nav-btn btn-prev-next text-decoration-none">← 이전글</a>
	      </c:when>
	      <c:otherwise>
	        <button class="post-nav-btn btn-prev-next invisible">← 이전글</button>
	      </c:otherwise>
	    </c:choose>
	  </div>
	
	  <!-- 가운데: 목록으로 -->
	  <div class="position-absolute start-50 translate-middle-x">
	    <button class="post-nav-btn btn-list" onclick="location.href='<%=request.getContextPath() %>/posts_list.go/${post.category_id}?page=${page}'">
	      목록으로
	    </button>
	  </div>
	
	  <!-- 오른쪽: 다음글 -->
	  <div>
	    <c:choose>
	      <c:when test="${not empty nextId}">
	        <a href="/post_detail.go?id=${nextId}&page=${page}" class="post-nav-btn btn-prev-next text-decoration-none">다음글 →</a>
	      </c:when>
	      <c:otherwise>
	        <button class="post-nav-btn btn-prev-next invisible">다음글 →</button>
	      </c:otherwise>
	    </c:choose>
	  </div>
	</div>
	  <hr>
	<!-- 댓글 토글 버튼 -->
	<button type="button" class="btn btn-outline-secondary btn-sm" onclick="toggleComments()">💬 댓글</button>
	
	<!-- 댓글 전체 영역 -->
	<div id="commentArea" class="mt-4" style="display: none;">
	    <h5 class="mb-3">댓글</h5>
	
	    <!-- 댓글 작성 -->
	    <c:if test="${empty loginUser}">
	        <div class="bg-light text-muted rounded p-3 small mb-3">
			  댓글을 작성하려면 <a href="/user_login.go" class="text-primary text-decoration-none fw-semibold">로그인</a> 해주세요.
			</div>
	    </c:if>
	
	    <c:if test="${not empty loginUser}">
		    <form action="/comment_write.go" method="post" class="mb-4">
		        <input type="hidden" name="post_id" value="${post.id}">
		        <input type="hidden" name="page" value="${page}">
		        
		        <div class="mb-2">
		            <textarea name="content" class="form-control" rows="3" placeholder="댓글을 입력하세요." style="resize: none"></textarea>
		        </div>
		        
		        <div class="text-end">
		            <button type="submit" class="btn btn-success btn-sm">💬 댓글 작성</button>
		        </div>
		    </form>
		</c:if>
	
	    <hr>
	
	    <!-- 댓글 목록 -->
	    <c:forEach var="comment" items="${comments}">
	        <div id="comment-${comment.id}" class="border rounded p-3 mb-3">
	            <div class="d-flex justify-content-between mb-1">
	                <strong>${comment.nickname}</strong>
	                <small class="text-muted">${comment.created_at}</small>
	            </div>
	
	            <!-- 기본 보기 -->
	            <div id="content-${comment.id}" class="mb-2">
	                <div>${comment.content}</div>
	            </div>
	
	            <!-- 수정 폼 -->
	            <div id="edit-area-${comment.id}" class="mb-2" style="display: none;">
	                <textarea id="edit-content-${comment.id}" class="form-control mb-2" rows="3">${comment.content}</textarea>
	                <button type="button" class="btn btn-success btn-sm me-1" onclick="submitEdit(${comment.id})">✅ 저장</button>
	                <button type="button" class="btn btn-secondary btn-sm" onclick="cancelEdit(${comment.id})">❌ 취소</button>
	            </div>
	
	            <!-- 수정/삭제 버튼 -->
	            <c:if test="${not empty loginUser && (loginUser.id == comment.user_id || loginUser.role eq 'ADMIN')}">
				    <div class="text-end mt-2">
				        <button type="button" class="btn btn-outline-primary btn-sm me-1" onclick="editComment(${comment.id})">✏ 수정</button>
				        <form action="/comment_delete.go" method="post" class="d-inline">
				            <input type="hidden" name="id" value="${comment.id}" />
				            <input type="hidden" name="postId" value="${post.id}" />
				            <input type="hidden" name="page" value="${page}">
				            <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</button>
				        </form>
				    </div>
				</c:if>
	        </div>
	    </c:forEach>
	</div>

</div>

<!-- 스크립트 -->
<script>
// 댓글 수정 버튼 클릭 시 - 기존 내용을 숨기고 수정 폼 표시
function editComment(id) {
    document.getElementById("content-" + id).style.display = "none";     // 기존 댓글 숨김
    document.getElementById("edit-area-" + id).style.display = "block";  // 수정 폼 표시
}

// 댓글 수정 취소 버튼 클릭 시 - 수정 폼 숨기고 기존 내용 다시 표시
function cancelEdit(id) {
    document.getElementById("edit-area-" + id).style.display = "none";   // 수정 폼 숨김
    document.getElementById("content-" + id).style.display = "block";    // 기존 댓글 다시 보이게
}

// 댓글 수정 저장 버튼 클릭 시 - 서버로 수정 요청 전송
function submitEdit(id) {
    const content = document.getElementById("edit-content-" + id).value; // 수정된 내용 가져오기

    // fetch를 이용해 서버에 수정 요청 전송
    fetch("/comment_update.go", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "id=" + id + "&content=" + encodeURIComponent(content)     // 데이터 전송
    })
    .then(res => res.json()) // 서버 응답을 JSON으로 파싱
    .then(data => {
        if (data.status === "success") {
            // 기존 댓글 내용 요소를 업데이트
            const container = document.getElementById("content-" + id);
            if (container) {
                while (container.firstChild) {
                    container.removeChild(container.firstChild); // 기존 내용 삭제
                }
                const newDiv = document.createElement("div");   // 새 div 생성
                newDiv.textContent = content;                   // 수정된 텍스트 삽입
                container.appendChild(newDiv);                  // 새로운 내용 삽입
            }

            // 수정 폼 닫고, 수정된 댓글 보여줌
            document.getElementById("edit-area-" + id).style.display = "none";
            document.getElementById("content-" + id).style.display = "block";

            alert("수정되었습니다.");  // 성공 메시지
        } else {
            alert("댓글 수정 실패");   // 실패 시 경고
        }
    })
    .catch(error => {
        alert("요청 처리 중 오류 발생");  // 통신 오류 시 알림
        console.error("fetch 오류:", error); // 콘솔에 상세 오류 출력
    });
}
//댓글 영역 토글 함수
function toggleComments() {
    const area = document.getElementById("commentArea");
    if (area.style.display === "none") {
        area.style.display = "block";  // 숨김 상태 → 보이게
    } else {
        area.style.display = "none";   // 보임 상태 → 숨김
    }
}

// 페이지 로드시 URL 파라미터에 따라 댓글 영역 자동 열기
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('commentOpen') === 'true') {
        const area = document.getElementById("commentArea");
        if (area) {
            area.style.display = "block";
        }
    }
};

// 좋아요 버튼 클릭 시 호출되는 함수
function toggleLike(postId) {
    fetch("/like_toggle.go", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "postId=" + postId
    })
    .then(res => res.json()) // JSON 응답 파싱
    .then(data => {
        if (data.status === "success") {
            const btn = document.getElementById("likeBtn");
            const count = document.getElementById("likeCount");

            // 좋아요 수 갱신
            count.innerText = data.likeCount;

            // 하트 아이콘 상태 변경 (좋아요 or 해제)
            if (data.liked) {
                btn.innerHTML = `
                <svg fill="red" width="24" height="24" viewBox="0 0 24 24">
                  <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5
                  2 5.42 4.42 3 7.5 3c1.74 0 3.41 0.81 4.5 2.09
                  C13.09 3.81 14.76 3 16.5 3
                  19.58 3 22 5.42 22 8.5
                  c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                </svg>`;
            } else {
                btn.innerHTML = `
                <svg fill="gray" width="24" height="24" viewBox="0 0 24 24">
                  <path d="M16.5 3c-1.74 0-3.41 0.81-4.5 2.09
	                     C10.91 3.81 9.24 3 7.5 3
	                     4.42 3 2 5.42 2 8.5
	                     c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32
	                     C18.6 15.36 22 12.28 22 8.5
	                     22 5.42 19.58 3 16.5 3z"/>
                </svg>`;
            }
        } else if (data.status === "not_logged_in") {
            alert("로그인 후 이용해주세요.");
        }
    })
    .catch(err => {
        alert("오류 발생: 좋아요 처리 실패");
        console.error(err);
    });
}
</script>

</body>
</html>