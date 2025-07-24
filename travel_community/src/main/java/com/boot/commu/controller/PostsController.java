package com.boot.commu.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.commu.mapper.CommentsMapper;
import com.boot.commu.mapper.HashtagsMapper;
import com.boot.commu.mapper.PostsMapper;
import com.boot.commu.model.CommentDTO;
import com.boot.commu.model.Comments;
import com.boot.commu.model.Hashtags;
import com.boot.commu.model.PostsDetailDTO;
import com.boot.commu.model.Users;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class PostsController {

    @Autowired
    private PostsMapper pmapper;

    @Autowired
    private HashtagsMapper hmapper;

    @Autowired
    private CommentsMapper commentsMapper;

    // 메인 페이지 이동
    @RequestMapping("/")
    public String main() {
        return "main";
    }

    // 게시글 상세 페이지 진입
    @RequestMapping("/post_detail.go")
    public String postDetail(@RequestParam("id") int id, Model model, HttpSession session, HttpServletResponse response) throws IOException {
        // 게시글 상세 정보 먼저 조회
        PostsDetailDTO post = pmapper.getPostDetailById(id);

        // 삭제된 게시글이면 차단
        if (post == null || "N".equals(post.getState())) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('삭제된 게시글입니다.');");
            out.println("location.href='/'");
            out.println("</script>");
            return null;
        }

        // 조회수 증가
        pmapper.view_countup(id);

        // 나머지 데이터 조회
        List<Hashtags> hashtags = hmapper.getHashtagsByPostId(id);
        List<CommentDTO> comments = commentsMapper.getCommentsByPostId(id);
        Users loginUser = (Users) session.getAttribute("loginUser");

        // 모델에 데이터 추가
        model.addAttribute("post", post);
        model.addAttribute("hashtags", hashtags);
        model.addAttribute("comments", comments);
        model.addAttribute("loginUser", loginUser);

        return "posts/post_detail";
    }

    // 게시글 삭제 처리 
    @RequestMapping("/post_delete.go")
    public void deletePost(@RequestParam("id") int id,
                           HttpSession session,
                           HttpServletResponse response) throws IOException {

        Users loginUser = (Users) session.getAttribute("loginUser");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 로그인 안 한 경우
        if (loginUser == null) {
            out.println("<script>alert('로그인이 필요합니다.'); location.href='/user_login.go';</script>");
            return;
        }

        // 게시글 작성자 또는 관리자만 삭제 가능
        PostsDetailDTO post = pmapper.getPostDetailById(id);
        if (post != null && (post.getUser_id() == loginUser.getId() || "ADMIN".equals(loginUser.getRole()))) {
            pmapper.softDeletePost(id);
        }

        out.println("<script>alert('게시글이 삭제되었습니다.'); location.href='/'</script>");
    }

    // 댓글 작성 처리
    @RequestMapping("/comment_write.go")
    public String writeComment(@RequestParam("post_id") int postId,
                               @RequestParam("content") String content,
                               HttpSession session) {
        // 로그인 여부 확인
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        // 댓글 객체 생성 후 DB 저장
        Comments comment = new Comments();
        comment.setPost_id(postId);
        comment.setUser_id(loginUser.getId());
        comment.setContent(content);
        commentsMapper.insertComment(comment);

        // 다시 상세 페이지로 이동 + 댓글창 열림
        return "redirect:/post_detail.go?id=" + postId + "&commentOpen=true";
    }

    // 댓글 삭제 처리 
    @RequestMapping("/comment_delete.go")
    public String deleteComment(@RequestParam("id") int commentId,
                                @RequestParam("postId") int postId,
                                HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        // 작성자 또는 관리자만 삭제 가능
        CommentDTO targetComment = commentsMapper.getCommentById(commentId);
        if (targetComment != null &&
            (targetComment.getUser_id() == loginUser.getId() || "ADMIN".equals(loginUser.getRole()))) {
            commentsMapper.deleteComment(commentId);
        }

        // 다시 상세 페이지로 이동 + 댓글창 열림
        return "redirect:/post_detail.go?id=" + postId + "&commentOpen=true";
    }

    // 댓글 수정 처리 (AJAX)
    @RequestMapping("/comment_update.go")
    @ResponseBody
    public Map<String, Object> updateComment(@RequestParam("id") int id,
                                             @RequestParam("content") String content,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Users loginUser = (Users) session.getAttribute("loginUser");

        // 로그인 확인
        if (loginUser == null) {
            result.put("status", "not_logged_in");
            return result;
        }

        // 권한 확인 후 수정
        CommentDTO targetComment = commentsMapper.getCommentById(id);
        if (targetComment != null &&
            (targetComment.getUser_id() == loginUser.getId() || "ADMIN".equals(loginUser.getRole()))) {
            Comments comment = new Comments();
            comment.setId(id);
            comment.setContent(content);
            commentsMapper.updateComment(comment);
            result.put("status", "success");
        } else {
            result.put("status", "fail");
        }

        return result;
    }
}
