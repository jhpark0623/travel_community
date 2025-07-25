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


@Controller
public class PostsController {
	
	@Autowired
	private PostsMapper postsMapper;
	
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
	public String list(@PathVariable("i") String i, @RequestParam(value = "page", defaultValue = "1") 
			int page, Model model) {
		
	    // DB 상의 전체 게시물 수
	    int totalRecord = postsMapper.countByCategory(i);

	    // 페이징 객체 생성
	    Page pdto = new Page(page, rowsize, totalRecord);

	    
	    List<Posts> list = postsMapper.list(i);
	    		
	    // ✅ displayDate 세팅
	    for (Posts post : list) {
	        post.setDisplayDateFromCreatedAt();
	    }
	    
	    List<Notices> popNoticesList = noticesMapper.popNoticeList();

	    //System.out.println(popNoticesList);
	    
	    model.addAttribute("List", list)
	         .addAttribute("Paging", pdto)
	         .addAttribute("CategoryId", i)
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
	
	
	@GetMapping("/notices_search.go")
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
}
