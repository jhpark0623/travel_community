package com.boot.commu.model;

import lombok.Data;

@Data
public class CommentDTO {
	private int id;
	private int post_id;
	private int user_id;
	private String content;
	private String created_at;
	private int parent_id;
	private String nickname;  // 댓글 작성자 닉네임 (조인해서 가져옴)
}
