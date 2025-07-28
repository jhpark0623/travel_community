package com.boot.commu.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Posts;
import com.boot.commu.model.Hashtags;
import com.boot.commu.model.Page;
import com.boot.commu.model.PostsDetailDTO;
import com.boot.commu.model.Region_city;
import com.boot.commu.model.Region_province;

@Mapper
public interface PostsMapper {

    // 게시글 ID로 상세 정보 조회 (작성자, 카테고리, 지역 JOIN 포함)
    PostsDetailDTO getPostDetailById(int id);

	List<Posts> list(String i);

	int countByCategory(String i);

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
    
    List<Region_province> getProvinceList();
    
    List<Region_city> getCityList(int provinceCode);
    
    
    
    int insertPost(Posts posts);
    
    int findHashtag(String hashtag);

	void insertHashtag(Hashtags hash);

	int selectHashtagId(String hashtag);

	void insertPostHashtag(HashMap<String, Integer> map);
}
