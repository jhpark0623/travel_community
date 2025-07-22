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
}
