package com.boot.commu.model;

import lombok.Data;

@Data
public class PostModify {
	
	private int id;
    private int user_id;
    private int category_id;
    private int city_id;
    private String title;
    private String content;
    private int province_id;
}
