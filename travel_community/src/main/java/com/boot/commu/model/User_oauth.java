package com.boot.commu.model;

import lombok.Data;

@Data
public class User_oauth {
	private int id;
	private int user_id;
	private String provider;
	private String provider_id;
	private String connected_at;
}
