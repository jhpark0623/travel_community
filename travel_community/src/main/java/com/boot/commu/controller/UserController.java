package com.boot.commu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.commu.model.Users;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UserController {
	
	@GetMapping("user_login.go")
	public String login() {
		
		return "user/user_login";
	}
	
	@PostMapping("user_login_ok.go")
	public void login_ok(Users users ,Model model, HttpServletResponse response) {
		// 미완성
	}
	
}
