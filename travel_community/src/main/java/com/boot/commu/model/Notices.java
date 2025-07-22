package com.boot.commu.model;

import lombok.Data;

@Data
public class Notices {
	private int id;
	private String title;
	private String content;
	private String created_at;
	private String updated_at;
	private String is_pop;
}
