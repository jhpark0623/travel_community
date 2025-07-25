package com.boot.commu.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class Posts {
	
	private int id;
	private int user_id;
	private int category_id;
	private int city_id;
	private String title;
	private String content;
	private String created_at;
	private String update_at;
	private int view_count;
	private int like_count;
	private String state;
	private String nickname;
	private String categoryName;
	private String displayDate;
	
	public void setDisplayDateFromCreatedAt() {
		
		try {
			DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime createDateTime = LocalDateTime.parse(this.created_at, inputFormat);
			LocalDate today = LocalDate.now();
			
			if(createDateTime.toLocalDate().isEqual(today)) {
				this.displayDate = createDateTime.format(DateTimeFormatter.ofPattern("HH:mm"));
			} else {
				this.displayDate = createDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}
		}catch (Exception e) {
			this.displayDate = this.created_at;
		}
	}
}
	
 