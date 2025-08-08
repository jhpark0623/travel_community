package com.boot.commu.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Posts;
import com.boot.commu.model.Notices;
import com.boot.commu.model.Hashtags;
import com.boot.commu.model.Page;
import com.boot.commu.model.PostModify;
import com.boot.commu.model.PostsDetailDTO;
import com.boot.commu.model.Region_city;
import com.boot.commu.model.Region_province;

@Mapper
public interface PostsMapper {

	Posts cont(int no);

	List<Posts> search(Page pdto);

	int scount(Map<String, String> map);

	// category_id 에 해당하는 게시글 전체 리스트 조회.
	List<Posts> list(Page pdto);

	// category_id 에 해당하는 게시글의 수 조회.
	int countByCategory(int i);

	// notices 테이블의 is_pop = 'Y' 인 게시글의 수 조회
	int countByNotice();

	// 게시글 전체 수 반환.
	int countByAll();

	// category_id에 해당하는 게시글 전체 리스트 + notices 공지사항 (is pop = 'Y') 리스트 조회.
	List<Posts> c_list(Page pdto);

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
	Integer getPrevPostId(@Param("id") int id, @Param("category_id") int categoryId);

	// 현재 게시글 ID 기준으로 다음글 ID 가져오기
	Integer getNextPostId(@Param("id") int id, @Param("category_id") int categoryId);

	// DB 좋아요 증가
	void incrementLikeCount(@Param("postId") int postId);

	// DB 좋아요 감소
	void decrementLikeCount(@Param("postId") int postId);

	// 시/광역시 정보 출력
	List<Region_province> getProvinceList();

	// 시/군/구 정보 출력
	List<Region_city> getCityList(int provinceCode);

	// 게시글 정보 저장
	int insertPost(Posts posts);

	// 해시태그가 DB에 있는지 검색
	int findHashtag(String hashtag);

	// 해시태그 저 장
	void insertHashtag(Hashtags hash);

	// 해시태그 id 검색
	int selectHashtagId(String hashtag);

	// post_hashtag 저장
	void insertPostHashtag(HashMap<String, Integer> map);

	// 인기글 반환(조회수, 좋아요, 출력될 게시글수)
	List<Posts> hotPosts(@Param("viewPoint") int viewPoint, @Param("likePoint") int likePoint,
			@Param("hotPostsCount") int hotPostsCount, @Param("hotPostsDuration") int hotPostsDuration);

	// 인기글 반환(조회수, 좋아요, 출력될 게시글수, 카테고리 필터링)
	List<Posts> hotPostsByCategory(@Param("viewPoint") int viewPoint, @Param("likePoint") int likePoint,
			@Param("hotPostsCount") int hotPostsCount, @Param("hotPostsDuration") int hotPostsDuration,
			@Param("category_id") int category_id);

	// 게시글 수정 시 수정 폼에 보여줄 데이터 호출
	PostModify selectPostModifyDetail(int id);

	// 게시글에 등록되있던 해시태그 호출
	List<String> getHashtag(int id);

	// 게시글에서 삭제된 해시태그 제거
	void deletePostHashtag(HashMap<String, Object> map);

	// 게시글 업데이트
	int updatePost(Posts posts);
	
	// 카테고리 + 시(city_id) 게시글 수 조회
	int countByCategoryAndCity(@Param("categoryId") int categoryId, @Param("cityId") int cityId);

	// 카테고리 + 시(city_id) 게시글 리스트 조회 (공지사항 포함 방식 유지 시 추가 가공 필요)
	List<Posts> c_list_by_city(@Param("pdto") Page pdto, @Param("cityId") int cityId);

	List<Posts> getPostsByCity(int city_id);
 
 
	int countByCategoryCityAndKeyword(Map<String, Object> map);

	List<Posts> c_list_by_city_and_keyword(Map<String, Object> map);

	List<Posts> c_list_by_keyword(Map<String, Object> map);


}
