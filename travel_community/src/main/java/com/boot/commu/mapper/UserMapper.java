package com.boot.commu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Comments;
import com.boot.commu.model.Posts;
import com.boot.commu.model.Users;

@Mapper
public interface UserMapper {
	// 로그인을 시도하는 메서드. => id, nickname, role 받아서 Users 객체에 저장.
	Users login(@Param("email") String email, @Param("password") String password);
	
	// DB에 이메일이 있는지 확인하는 메서드.
	int chkId(@Param("email") String email);
	
	// DB에 전화번호 / 닉네임이 있는지 확인하는 메서드.
	int chkPhone(String phone);
	int chkNickname(String nickname);
	
	// users dto 객체를 매개변수로 DB users 테이블에 추가하는 메서드.
	int addUser(Users dto);

	// phone과 name으로 Users 테이블에서 검색해 email을 반환시켜주는 메서드.
	String findId(Users dto);
	
	// email에 해당하는 회원의 가입일(created_at)을 반환해주는 메서드.
	String findCreated(String email);
	
	// email ,phone, name으로 Users 테이블에서 검색해 password을 반환시켜주는 메서드.
	String findPwd(Users dto);
	

	// 내 게시물 받아오는 메서드
	List<Posts> myPosts(int id);
	
	// 내 댓글목록 받아오는 메서드
	List<Comments> myComments(int id);
	
	// 내 게시물 검색
	List<Posts> search(Map<String, Object> map);

}
