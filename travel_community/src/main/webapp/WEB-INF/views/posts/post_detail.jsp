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

    <!-- 해시태그 -->
    <c:if test="${not empty hashtags}">
        <p>
            <c:forEach var="tag" items="${hashtags}">
                <a>#${tag.hashtag}</a>&nbsp;
            </c:forEach>
        </p>
    </c:if>

    <hr>

    <!-- 본문 내용 -->
    <div>
        <c:out value="${post.content}" escapeXml="false" />
    </div>

    <hr>

    <!-- 조회수 / 좋아요 수 -->
    <p>조회수: ${post.view_count}</p>
    <p>좋아요 수: ${post.like_count}</p>

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
            <p style="color: gray;">댓글을 작성하려면 <a href="/login">로그인</a> 해주세요.</p>
        </c:if>
        <c:if test="${not empty loginUser}">
            <form action="/comment_write.go" method="post">
                <input type="hidden" name="post_id" value="${post.id}">
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
                        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>

    <br>
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
