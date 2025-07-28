package com.boot.commu.controller;

import static org.assertj.core.api.Assertions.assertThatIllegalStateException;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.commu.mapper.UserMapper;
import com.boot.commu.model.Comments;
import com.boot.commu.model.Posts;
import com.boot.commu.model.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserMapper mapper;

	@GetMapping("user_login.go")
	public String login(HttpServletRequest request) {

		// 로그인 페이지 이전의 페이지를 저장시키는 과정.
		String prevPage = request.getHeader("Referer");

		System.out.println(prevPage);

		// 폼 페이지가 포함된 경우에 오류가 생기기때문에 방지하는 과정. => 이를 이용한 페이지 이동시 메인페이지로 이동(일종의 예외처리)
		if (prevPage != null && !prevPage.contains("/user_login") && !prevPage.contains("/user_signin")
				&& !prevPage.contains("/user_find")) { // 이전 페이지가 로그인 페이지가 아니고 이전 페이지 정보가 null이 아닌 경우
			request.getSession().setAttribute("prevPage", prevPage); // 이전 페이지 정보 세션에 저장
		}

		return "user/user_login";
	}

	@PostMapping("user_login_ok.go")
	public void login_ok(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {

		// 이전 페이지 가져오기
		String prevPage = (String) session.getAttribute("prevPage");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		Users login = this.mapper.login(email, password);

		if (login != null) {
			session.setAttribute("loginUser", login);

			out.println("<script>");
			out.println("alert('로그인 성공')");
			out.println("location.href='" + prevPage + "'"); // 기존에 보고있던 페이지로 이동
			out.println("</script>");
		} else {
			int chkId = this.mapper.chkId(email);

			if (chkId > 0) {
				// 아이디는 DB에 있는 경우 -> 비밀번호가 일치하지 않는 경우
				out.println("<script>");
				out.println("alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.')");
				out.println("history.back()");
				out.println("</script>");
			} else {
				// 아이디가 DB에 없는 경우
				out.println("<script>");
				out.println("alert('가입되지 않은 아이디입니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
	}

	@GetMapping("user_logout.go")
	public void logout(HttpServletResponse response, HttpServletRequest request, HttpSession session)
			throws IOException {

		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");

		// 로그인 아웃 이전의 페이지를 저장시키는 과정.
		String prevPage = request.getHeader("Referer");

		System.out.println(prevPage);

		// 로그아웃 실행
		session.invalidate();

		out.println("<script>");
		out.println("location.href='/'"); // 기존에 보고있던 페이지로 이동 <= 에러 방지용으로 일단 메인페이지로 이동
		out.println("</script>");
	}

	@GetMapping("user_signin.go")
	public String signin() {

		return "user/user_signin";
	}

	@PostMapping("user_signin_ok.go")
	public void signin_ok(Users dto, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		int chkId = this.mapper.chkId(dto.getEmail());
		int chkPhone = this.mapper.chkPhone(dto.getPhone());
		int chkNickname = this.mapper.chkNickname(dto.getNickname());

		if (chkId == 0) {
			if (chkNickname == 0) {
				if (chkPhone == 0) {
					int chk = this.mapper.addUser(dto);

					if (chk > 0) {
						out.println("<script>");
						out.println("alert('회원가입 완료되었습니다.')");
						out.println("location.href='user_login.go'");
						out.println("</script>");
					} else {
						out.println("<script>");
						out.println("alert('회원가입 실패...')");
						out.println("history.back()");
						out.println("</script>");
					}
				} else {
					// 닉네임 중복시
					out.println("<script>");
					out.println("alert('해당 전화번호는 중복된 전화번호입니다.')");
					out.println("history.back()");
					out.println("</script>");
				}
			} else {
				// 전화번호 중복시
				out.println("<script>");
				out.println("alert('해당 닉네임은 중복된 닉네임입니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		} else {
			// 아이디 중복시
			out.println("<script>");
			out.println("alert('해당 이메일은 중복된 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}

	}

	@GetMapping("user_findid.go")
	public String findId() {

		return "user/user_findId";
	}

	@GetMapping("user_findpwd.go")
	public String findPwd(@RequestParam(value = "email" , defaultValue = "") String email, Model model) {

		// 아이디 찾기 결과에서 넘어왔을 경우 email 값 받고 보내주는 과정.
		model.addAttribute("email", email);
		
		return "user/user_findPwd";
	}

	@PostMapping("user_findid_ok.go")
	public String findIdOk(Users dto, Model model) throws IOException {

		String email = this.mapper.findId(dto);

		if (email != null) {
			String created_at = this.mapper.findCreated(email);

			dto.setEmail(email);
			dto.setCreated_at(created_at);

			model.addAttribute("res", dto);
		}

		return "user/user_findId_res";
	}

	@PostMapping("user_findpwd_ok.go")
	public String findPwdOk(Users dto, Model model) {

		String pwd = this.mapper.findPwd(dto);
		if (pwd != null) {
			String created_at = this.mapper.findCreated(dto.getEmail());

			dto.setPassword(pwd);
			dto.setCreated_at(created_at);

			model.addAttribute("res", dto);
		}

		return "user/user_findPwd_res";
	}

	// 내 게시물 출력
		@GetMapping("myposts.go")
		public String myposts(HttpSession session, Model model, HttpServletResponse response) throws IOException {
			
			if(!loginalert(response, session)) {
				return null;
			}
			
			int users = ((Users) session.getAttribute("loginUser")).getId();

			List<Posts> myPosts = this.mapper.myPosts(users);

			model.addAttribute("myPosts", myPosts);

			return "user/user_myposts";

		}

		// 내 댓글 출력
		@GetMapping("mycomments.go")
		public String mycomments(HttpSession session, Model model, HttpServletResponse response) throws IOException {
			
			if(!loginalert(response, session)) {
				return null;
			}
			
			int users = ((Users) session.getAttribute("loginUser")).getId();

			List<Comments> myComments = this.mapper.myComments(users);

			System.out.println(myComments);

			model.addAttribute("myComments", myComments);

			return "user/user_mycomments";
		}

		// 내 정보 출력
		@GetMapping("myprofile.go")
		public String myprofile(HttpSession session, Model model, HttpServletResponse response) throws IOException {
			
			if(!loginalert(response, session)) {
				return null;
			}
			
			int users = ((Users)session.getAttribute("loginUser")).getId();
			
			Users user = this.mapper.myProfile(users);
			
			model.addAttribute("UserProfile", user);
			
			return "user/user_myprofile";

		}

		// 내 게시물 내의 검색
		@GetMapping("myposts_search.go")
		public String myposts_search(@RequestParam("myposts_search") String search, Model model, HttpSession session) {

			int users = ((Users) session.getAttribute("loginUser")).getId();

			Map<String, Object> map = new HashMap<>();

			map.put("search", search);
			map.put("id", users);

			List<Posts> myPosts = this.mapper.search(map);

			model.addAttribute("myPosts", myPosts);

			return "user/user_myposts";

		}
		
		// 내 댓글 내의 검색
		@GetMapping("mycomment_search.go")
		public String mycomment_search(@RequestParam("mycomment_search") String search, Model model, HttpSession session) {
			
			int user = ((Users)session.getAttribute("loginUser")).getId();
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("search", search);
			map.put("id", user);
			
			List<Comments> myComment_search = this.mapper.myComments_search(map);
			
			model.addAttribute("myComments", myComment_search);
			
			return "user/user_mycomments";
		}
		
		// 내 정보 수정
		@PostMapping("myprofileModify.go")
		public void MyProfileModify(@RequestParam("pwd") String pwd, Users user, HttpServletResponse response ) throws IOException{
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			
			if(user.getPassword().equals(pwd)) {
				
				int res = this.mapper.modify(user);
				
				if(res == 0) {
					out.println("<script>");
					out.println("alert('수정 실패')");
					out.println("history.back()");
					out.println("</script>");
					
				}else {
					out.println("<script>");
					out.println("alert('수정 성공')");
					out.println("location.href='myprofile.go'");
					out.println("</script>");
				}
			}else {
				out.println("<script>");
				out.println("alert('비밀번호가 일치하지 않습니다')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		
		// 회원 탈퇴
		@GetMapping("deleteUser.go")
		public void deleteUser(@RequestParam("pwd") String pwd, Users user, HttpServletResponse response ) throws IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(user.getPassword().equals(pwd)) {
				
				int res = this.mapper.deleteUser(user);
				
				if(res == 0) {
					out.println("<script>");
					out.println("alert('삭제 실패')");
					out.println("history.back()");
					out.println("</script>");
					
				}else {
					out.println("<script>");
					out.println("alert('삭제 성공')");
					out.println("location.href='myprofile.go'");
					out.println("</script>");
				}
			}else {
				out.println("<script>");
				out.println("alert('비밀번호가 일치하지 않습니다')");
				out.println("history.back()");
				out.println("</script>");
			}
				
		}
	
		
		
		
		
		
		// 로그인 안하고 접속시 로그인 페이지로 보내주는 메서드
		public static boolean loginalert(HttpServletResponse response, HttpSession session) throws IOException {
			
			Users loginUser = (Users) session.getAttribute("loginUser");
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(loginUser == null) {
				
				
				out.println("<script>");
				out.println("alert('로그인이 필요합니다')");
				out.println("location.href='user_login.go'");
				out.println("</script>");
				
				return false;
			}
			
			return true;
		}
		

	}
