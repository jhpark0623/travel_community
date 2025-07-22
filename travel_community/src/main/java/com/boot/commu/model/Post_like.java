package com.boot.commu.model;

import lombok.Data;

@Data
public class Post_like {
	private int id;
	private int post_id;
	private int user_id;
}
