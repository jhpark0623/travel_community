package com.boot.commu.model;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class Notices {

	private int id;
	private String title;
	private String content;
	private String created_at;
	private String updated_at;
	private String is_pop;
	private String displayDate;

	public String getDisplayDate() {
		if (this.created_at == null)
			return "";

		try {
			DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime createDateTime = LocalDateTime.parse(this.created_at, inputFormat);
			LocalDate today = LocalDate.now();

			if (createDateTime.toLocalDate().isEqual(today)) {
				return createDateTime.format(DateTimeFormatter.ofPattern("HH:mm"));
			} else {
				return createDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}
		} catch (Exception e) {
			return this.created_at;
		}
	}
}