package com.boot.commu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Posts;
import com.boot.commu.model.Page;
import com.boot.commu.model.PostsDetailDTO;

@Mapper
public interface PostsMapper {

	List<Posts> list(String i);

	int countByCategory(String i);

	// 게시글 ID로 상세 정보 조회 (JOIN 포함)
	PostsDetailDTO getPostDetailById(int id);

	// 게시글 조회수 1 증가
	void view_countup(int id);

	// 게시글 삭제
	void softDeletePost(int id);

	// 좋아요 기능 추가
	int getLikeCount(int postId);

	int isPostLiked(@Param("postId") int postId, @Param("userId") int userId);

	void insertLike(@Param("postId") int postId, @Param("userId") int userId);

	void deleteLike(@Param("postId") int postId, @Param("userId") int userId);
}
