package com.boot.commu.model;

import lombok.Data;

@Data
public class Comments {
	private int id;
	private int post_id;
	private int user_id;
	private String content;
	private String created_at;
	private String state;
	private int parent_id;
	
	// 댓글단 게시물 제목 추가
	private String post_title;
	private String post_content;
}
