package com.boot.commu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class PostsController {

	@GetMapping("/")
	public String main () {
		return "main";
	}
    
}
