package com.boot.commu.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.commu.mapper.NoticesMapper;
import com.boot.commu.mapper.PostsMapper;
import com.boot.commu.model.Notices;
import com.boot.commu.model.Page;
import com.boot.commu.model.Posts;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.commu.mapper.CommentsMapper;
import com.boot.commu.mapper.HashtagsMapper;
import com.boot.commu.model.CommentDTO;
import com.boot.commu.model.Comments;
import com.boot.commu.model.Hashtags;
import com.boot.commu.model.PostsDetailDTO;
import com.boot.commu.model.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostsController {
	
	@Autowired
    private PostsMapper pmapper;

    @Autowired
    private HashtagsMapper hmapper;

    @Autowired
    private CommentsMapper commentsMapper;
	
	@Autowired
	private NoticesMapper noticesMapper;
	
	// 한 페이지당 보여질 게시물의 수. 
	private final int rowsize = 5;
	
	// DB 상의 전체 게시물의 수. 
	private int totalRecord = 0;

	@GetMapping("/")
	public String main() {
		return "main";
	}
	
 
	
	@GetMapping("/posts_list.go/{i}")
	public String list(@PathVariable("i") int pCategory, @RequestParam(value = "page", defaultValue = "1") 
			int page, Model model) {
		
	    // DB 상의 전체 게시물 수
	    int totalRecord = this.pmapper.countByCategory(pCategory);

	    // 페이징 객체 생성
	    Page pdto = new Page(page, rowsize, totalRecord, pCategory);

	    List<Posts> postList = this.pmapper.list(pdto);
	    		
	    // ✅ displayDate 세팅
	    for (Posts post : postList) {
	        post.setDisplayDateFromCreatedAt();
	    }
	    
	    List<Notices> popNoticesList = noticesMapper.popNoticeList();
	        
	    model.addAttribute("List", postList)
	         .addAttribute("Paging", pdto)
	         .addAttribute("CategoryId", pCategory)
	    	 .addAttribute("popNotice", popNoticesList);

	    return "posts/posts_list";
	}
	
	
	@GetMapping("/notices_list.go")
	public String noticeList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

	    int rowsize = 5;  // 한 페이지당 게시물 수
	    int totalRecord = noticesMapper.countNotices();  // 전체 게시물 수 가져오기

	    Page pdto = new Page(page, rowsize, totalRecord);

	    List<Notices> pagedNotices = noticesMapper.pagedNoticeList(pdto);

	    model.addAttribute("Notices", pagedNotices);
	    model.addAttribute("Paging", pdto);

	    return "notices/notices_list";
	}
	
	
	@GetMapping("/notices_write.go")
	public String write() {
		
		return "notices/notices_write";
	}
	
	
	@PostMapping("notices_write_ok.go")
	public void write_ok(Notices dto, HttpServletResponse response) throws IOException {
		
		int res = this.noticesMapper.add(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('게시글 등록 성공')");
			out.println("location.href='notices_list.go'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	
	@GetMapping("/notices_content.go")
	public String cont(@RequestParam("no") int no, @RequestParam("page") int nowPage, Model model) {
		
		// 게시물 번호에 해당하는 상세 내역을 조회하는 메서드 호출. 
		Notices cont = this.noticesMapper.cont(no);
		
		model.addAttribute("Content", cont)
		     .addAttribute("Page", nowPage);
		
		return "notices/notices_content";
	}
	
	
	@GetMapping("/notices_modify.go")
	public String modify(@RequestParam("no") int no, @RequestParam("page") int nowPage, Model model) {
		
		Notices cont = this.noticesMapper.cont(no);
		
		model.addAttribute("Modify", cont)
		     .addAttribute("Page", nowPage);
		
		return "notices/notices_modify";
	}
	
	
	@PostMapping("notices_modify_ok.go")
	public void modifyOk(Notices dto, @RequestParam("page") int nowPage, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		int res = this.noticesMapper.edit(dto);
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('게시글 수정 성공!!!')");
			out.println("location.href='notices_content.go?no="+dto.getId()+"&page="+nowPage+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 수정 실패!!!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	
	
	@GetMapping("/notices_delete.go")
	public void delete(@RequestParam("no") int no, @RequestParam("page") int nowPage, 
				HttpServletResponse response) throws IOException {
		
		int check = this.noticesMapper.del(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			// 삭제된 공지사항 번호보다 큰 번호에 대해서 다시 번호를 재작업 하는 메서드 
			this.noticesMapper.seq(no);
			
			out.println("<script>");
			out.println("alert('게시글 삭제 성공!!!')");
			out.println("location.href='notices_list.go'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 삭제 실패!!!')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	
	@PostMapping("/notices_search.go")
	public String search(@RequestParam("field") String field, 
						@RequestParam("keyword") String keyword,
						@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		// 검색 페이징 작업 
		
		// 검색분류와 검색어에 해당하는 게시글의 수를 DB에서 확인하는 작업.
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("Field", field);
		map.put("Keyword", keyword);
		
		totalRecord = this.noticesMapper.scount(map);
		
		Page pdto = new Page(page, rowsize, totalRecord, field, keyword);
		
		// 검색 시 한 페이지당 보여질 게시물의 수만큼
		// 검색한 게시물을 List로 가져오는 메서드 호출.
		List<Notices> searchList = this.noticesMapper.search(pdto);
		
		model.addAttribute("searchPageList", searchList)
		     .addAttribute("Paging", pdto);
		
		return "notices/notices_search_list";
		
	}

    // 게시글 상세 페이지 진입
    @RequestMapping("/post_detail.go")
    public String postDetail(@RequestParam("id") int id,  @RequestParam("page") int nowPage,
    		Model model, HttpSession session, HttpServletResponse response) throws IOException {
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

        // 좋아요 여부 확인
        boolean liked = false;
        if (loginUser != null) {
            liked = (pmapper.isPostLiked(id, loginUser.getId()) > 0);
        }

        // 좋아요 수 조회 추가
        int likeCount = pmapper.getLikeCount(id);
        
        // 이전글 / 다음글 ID 조회
        Integer prevId = pmapper.getPrevPostId(id);
        Integer nextId = pmapper.getNextPostId(id);
        
        // 모델에 데이터 추가
        model.addAttribute("post", post);
        model.addAttribute("hashtags", hashtags);
        model.addAttribute("comments", comments);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("postLiked", liked);
        model.addAttribute("likeCount", likeCount); 
        // 페이지도 추가
        model.addAttribute("page", nowPage);

        model.addAttribute("prevId", prevId); 
        model.addAttribute("nextId", nextId);


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
    public void writeComment(@RequestParam("post_id") int postId,
                             @RequestParam("content") String content,
                             @RequestParam("page") int nowPage,
                             HttpSession session,
                             HttpServletResponse response) throws IOException {

        Users loginUser = (Users) session.getAttribute("loginUser");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 로그인 체크
        if (loginUser == null) {
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location.href='/user_login.go';");
            out.println("</script>");
            return;
        }

        // 댓글 내용 비어있을 경우
        if (content == null || content.trim().isEmpty()) {
            out.println("<script>");
            out.println("alert('댓글을 작성해주세요.');");
            out.println("location.href='/post_detail.go?id=" + postId + "&page="+nowPage+"&commentOpen=true';");
            out.println("</script>");
            return;
        }

        // 댓글 저장
        Comments comment = new Comments();
        comment.setPost_id(postId);
        comment.setUser_id(loginUser.getId());
        comment.setContent(content);
        commentsMapper.insertComment(comment);

        // 성공 후 이동
        out.println("<script>");
        out.println("location.href='/post_detail.go?id=" + postId + "&page="+nowPage+"&commentOpen=true';");
        out.println("</script>");
    }


    // 댓글 삭제 처리 
    @RequestMapping("/comment_delete.go")
    public String deleteComment(@RequestParam("id") int commentId,
                                @RequestParam("postId") int postId,
                                @RequestParam("page") int nowPage,
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
        return "redirect:/post_detail.go?id=" + postId + "&page="+nowPage+"&commentOpen=true';";
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
    
    @PostMapping("/like_toggle.go")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam("postId") int postId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Users loginUser = (Users) session.getAttribute("loginUser");

        // 로그인하지 않은 경우
        if (loginUser == null) {
            result.put("status", "not_logged_in");
            return result;
        }

        int userId = loginUser.getId();
        boolean alreadyLiked = (pmapper.isPostLiked(postId, userId)>0);

        if (alreadyLiked) {
            // 좋아요 취소
            pmapper.deleteLike(postId, userId);
        } else {
            // 좋아요 등록
            pmapper.insertLike(postId, userId);
        }
        
        int newLikeCount = pmapper.getLikeCount(postId); 

        // 클라이언트에게 현재 상태를 알려줌
        result.put("status", "success");
        result.put("liked", !alreadyLiked);  // 누른 후 상태 전달
        result.put("likeCount", newLikeCount);

        return result;
    }
}
