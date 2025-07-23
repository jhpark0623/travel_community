package com.boot.commu.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Users;

@Mapper
public interface UserMapper {
	// 로그인을 시도하는 메서드.
	Users login(@Param("email") String email, @Param("password") String password);
	
	// DB에 이메일이 있는지 확인하는 메서드.
	int chkId(@Param("email") String email);
	
	// DB에 전화번호 / 닉네임이 있는지 확인하는 메서드.
	int chkPhone(String phone);
	int chkNickname(String nickname);
	
	// users dto 객체를 매개변수로 DB users 테이블에 추가하는 메서드.
	int addUser(Users dto);
}
