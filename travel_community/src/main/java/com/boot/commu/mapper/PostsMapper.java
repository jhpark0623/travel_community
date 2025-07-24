package com.boot.commu.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.boot.commu.model.PostsDetailDTO;

@Mapper
public interface PostsMapper {

    // 게시글 ID로 상세 정보 조회 (JOIN 포함)
    PostsDetailDTO getPostDetailById(int id);

    // 게시글 조회수 1 증가
    void view_countup(int id);
    
    // 게시글 삭제
    void softDeletePost(int id);


}
