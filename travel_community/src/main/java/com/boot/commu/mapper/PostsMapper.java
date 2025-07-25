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


	  List<Posts> list(Page pdto);

	  int countByCategory(int i);

    // 게시글 ID로 상세 정보 조회 (JOIN 포함)
    PostsDetailDTO getPostDetailById(int id);

    // 게시글 소프트 삭제 (state = 'N')
    void softDeletePost(int id);

    // 게시글의 현재 좋아요 수 조회 (a_post_likes 테이블 기준 count)
    int getLikeCount(int postId);

    // 해당 사용자가 해당 게시글에 좋아요 눌렀는지 여부
    int isPostLiked(@Param("postId") int postId, @Param("userId") int userId);

    // 게시글 조회수 1 증가
    void view_countup(int id);

    // 게시글 좋아요 등록
    void insertLike(@Param("postId") int postId, @Param("userId") int userId);

    // 게시글 좋아요 취소
    void deleteLike(@Param("postId") int postId, @Param("userId") int userId);

    // 현재 게시글 ID 기준으로 이전글 ID 가져오기
    Integer getPrevPostId(int currentId);

    // 현재 게시글 ID 기준으로 다음글 ID 가져오기
    Integer getNextPostId(int currentId);
}
