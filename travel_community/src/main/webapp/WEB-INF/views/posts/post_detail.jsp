<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title} - 게시글 상세</title>
<script>
function toggleComments() {
    const area = document.getElementById("commentArea");
    if (area.style.display === "none") {
        area.style.display = "block";
    } else {
        area.style.display = "none";
    }
}

window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('commentOpen') === 'true') {
        const area = document.getElementById("commentArea");
        if (area) {
            area.style.display = "block";
        }
    }
};

function toggleLike(postId) {
    fetch("/like_toggle.go", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "postId=" + postId
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            const btn = document.getElementById("likeBtn");
            const count = document.getElementById("likeCount");
            
         	// 좋아요 수 갱신
            count.innerText = data.likeCount;
            // 하트 변경
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
</head>
<body>

<jsp:include page="../../include/header.jsp" />
<!-- 전체 컨테이너 -->
<div class="container mt-5 mb-5" style="background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); padding: 30px;">

    <!-- 게시글 제목 -->
    <h2 class="mb-3">${post.title}</h2>

    <!-- 작성자/카테고리/지역 -->
    <ul class="list-unstyled text-muted mb-4 fs-6">
	    <li>👤 ${post.nickname}</li>
	    <li>📂${post.category_name}</li>
	    <li>📍 ${post.province_name} ${post.city_name}</li>
	    <li>
	        🕒 
	        <c:choose>
	            <c:when test="${not empty post.updated_at}">
	                수정일: ${post.updated_at}
	            </c:when>
	            <c:otherwise>
	                작성일: ${post.created_at}
	            </c:otherwise>
	        </c:choose>
	    </li>
	</ul>
	
    <hr>

    <!-- 본문 내용 -->
    <div class="mb-4">
        <c:out value="${post.content}" escapeXml="false" />
    </div>

    <!-- 해시태그 -->
    <c:if test="${not empty hashtags}">
        <p>
            <c:forEach var="tag" items="${hashtags}">
                <a href="#" class="badge bg-secondary text-decoration-none">#${tag.hashtag}</a>
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
	        <a href="/post_detail.go?id=${prevId}" class="btn btn-outline-secondary btn-sm">← 이전글</a>
	      </c:when>
	      <c:otherwise>
	        <button class="btn btn-outline-secondary btn-sm invisible">← 이전글</button>
	      </c:otherwise>
	    </c:choose>
	  </div>
	
	  <!-- 가운데: 목록으로 -->
	  <div class="position-absolute start-50 translate-middle-x">
	    <button class="btn btn-outline-dark btn-sm" onclick="history.back()">목록으로</button>
	  </div>
	
	  <!-- 오른쪽: 다음글 -->
	  <div>
	    <c:choose>
	      <c:when test="${not empty nextId}">
	        <a href="/post_detail.go?id=${nextId}" class="btn btn-outline-secondary btn-sm">다음글 →</a>
	      </c:when>
	      <c:otherwise>
	        <button class="btn btn-outline-secondary btn-sm invisible">다음글 →</button>
	      </c:otherwise>
	    </c:choose>
	  </div>	
	</div>
	  <hr>
	<!-- 댓글 토글 버튼 -->
    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="toggleComments()">💬 댓글</button>

    <!-- 댓글 영역 -->
    <!-- 댓글 전체 영역 -->

    <div id="commentArea" style="display: none; margin-top: 20px;">
        <h4>댓글</h4>

        <!-- 댓글 작성 -->
        <c:if test="${empty loginUser}">
            <p style="color: gray;">댓글을 작성하려면 <a href="/user_login.go">로그인</a> 해주세요.</p>
        </c:if>
        <c:if test="${not empty loginUser}">
            <form action="/comment_write.go" method="post">
                <input type="hidden" name="post_id" value="${post.id}">
                <input type="hidden" name="page" value="${page }">
                <textarea name="content" rows="3" style="width: 100%;"></textarea><br>
                <button type="submit">댓글 작성</button>
            </form>
        </c:if>

        <hr>

        <!-- 댓글 목록 -->
        <c:forEach var="comment" items="${comments}">
            <div id="comment-${comment.id}" style="margin-bottom: 15px; padding: 10px; border: 1px solid #ddd;">
                <b>${comment.nickname}</b><br>

                <!-- 기본 보기 -->
                <div id="content-${comment.id}">
                    <div>${comment.content}</div>
                </div>

                <!-- 수정 폼 -->
                <div id="edit-area-${comment.id}" style="display: none;">
                    <textarea id="edit-content-${comment.id}" style="width: 100%;" rows="3">${comment.content}</textarea><br>
                    <button type="button" onclick="submitEdit(${comment.id})">✅ 저장</button>
                    <button type="button" onclick="cancelEdit(${comment.id})">❌ 취소</button>
                </div>

                <small style="color: gray;">${comment.created_at}</small>

                <!-- 수정/삭제 -->
                <c:if test="${not empty loginUser && (loginUser.id == comment.user_id || loginUser.role eq 'ADMIN')}">
                    <button type="button" onclick="editComment(${comment.id})">✏ 수정</button>
                    <form action="/comment_delete.go" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${comment.id}" />
                        <input type="hidden" name="postId" value="${post.id}" />
                        <input type="hidden" name="page" value="${page }">
                        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>

</div>


<!-- 댓글 수정용 스크립트 -->
<script>
function editComment(id) {
    document.getElementById("content-" + id).style.display = "none";
    document.getElementById("edit-area-" + id).style.display = "block";
}

function cancelEdit(id) {
    document.getElementById("edit-area-" + id).style.display = "none";
    document.getElementById("content-" + id).style.display = "block";
}

function submitEdit(id) {
    const content = document.getElementById("edit-content-" + id).value;

    fetch("/comment_update.go", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "id=" + id + "&content=" + encodeURIComponent(content)
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            const container = document.getElementById("content-" + id);
            if (container) {
                while (container.firstChild) {
                    container.removeChild(container.firstChild);
                }
                const newDiv = document.createElement("div");
                newDiv.textContent = content;
                container.appendChild(newDiv);
            }

            document.getElementById("edit-area-" + id).style.display = "none";
            document.getElementById("content-" + id).style.display = "block";
            alert("수정되었습니다.");
        } else {
            alert("댓글 수정 실패");
        }
    })
    .catch(error => {
        alert("요청 처리 중 오류 발생");
        console.error("fetch 오류:", error);
    });
}
</script>

</body>
</html>
