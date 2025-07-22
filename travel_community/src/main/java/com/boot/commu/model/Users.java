package com.boot.commu.model;

import lombok.Data;

@Data
public class Users {
	private int id;
	private String email;
	private String password;
	private String phone;
	private String name;
	private String nickname;
	private String role;
	private String state;
	private String created_at;
	private String deleted_at;	
}
