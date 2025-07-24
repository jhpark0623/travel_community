package com.boot.commu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.CommentDTO;
import com.boot.commu.model.Comments;

@Mapper
public interface CommentsMapper {

    // 게시글 ID로 댓글 목록 조회
    List<CommentDTO> getCommentsByPostId(int postId);
    
    // 댓글 등록
    void insertComment(Comments comment);

    // 댓글 삭제
    void deleteComment(int id);
    
    // 댓글 ID로 댓글 1건 조회 (닉네임 포함)
    CommentDTO getCommentById(@Param("id") int id);
    
    // 댓글 수정
    void updateComment(Comments comment);
}
