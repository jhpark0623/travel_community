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

<div style="width: 800px; margin: 50px auto;">

    <!-- 게시글 제목 -->
    <h2>${post.title}</h2>

    <!-- 작성자/카테고리/지역 -->
    <p>
        작성자: ${post.nickname}<br>
        카테고리: ${post.category_name}<br>
        지역: ${post.province_name} ${post.city_name}
    </p>

    <!-- 작성일 or 수정일 -->
    <c:if test="${not empty post.updated_at}">
        <p>수정일: ${post.updated_at}</p>
    </c:if>
    <c:if test="${empty post.updated_at}">
        <p>작성일: ${post.created_at}</p>
    </c:if>

    

    <hr>

    <!-- 본문 내용 -->
    <div>
        <c:out value="${post.content}" escapeXml="false" />
        <!-- 해시태그 -->
	    <c:if test="${not empty hashtags}">
	        <p>
	            <c:forEach var="tag" items="${hashtags}">
	                <a href="#">#${tag.hashtag}</a>&nbsp;
	            </c:forEach>
	        </p>
	    </c:if>
    </div>

    <hr>

    <!-- 조회수 / 좋아요 수 -->
    <p>조회수: ${post.view_count}</p>
    <p>좋아요: <span id="likeCount">${likeCount}</span></p>
    <!-- 좋아요 하트 버튼 (좋아요 수는 출력 안 함) -->
	<c:choose>
	  <c:when test="${not empty loginUser}">
	    <button id="likeBtn" onclick="toggleLike(${post.id})" style="background: none; border: none;">
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
	    <!-- 비로그인: 하트 클릭 시 alert -->
	    <button onclick="alert('로그인 후 이용해주세요.')" style="background:none; border:none;">
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

    <!-- 게시글 수정/삭제 버튼 -->
    <c:if test="${not empty loginUser && (loginUser.id == post.user_id || loginUser.role eq 'ADMIN')}">
        <div style="margin-top: 10px;">
            <button type="button" onclick="location.href='/post_edit.go?id=${post.id}'">✏ 게시글 수정</button>
            <form action="/post_delete.go" method="post" style="display:inline;">
                <input type="hidden" name="id" value="${post.id}" />
                <button type="submit" onclick="return confirm('정말 게시글을 삭제하시겠습니까?');">🗑 게시글 삭제</button>
            </form>
        </div>
    </c:if>

    <hr><br>

    <!-- 댓글 토글 버튼 -->
    <button type="button" onclick="toggleComments()">💬 댓글</button><br>

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

    <br>
    <!-- 목록으로 가는게 아니라 이전 페이지로 이동중 <= 수정 필요. -->
    <button onclick="history.back()">← 목록으로</button>
    

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
