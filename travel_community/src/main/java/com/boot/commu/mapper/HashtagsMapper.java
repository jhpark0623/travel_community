package com.boot.commu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.commu.model.Hashtags;

@Mapper
public interface HashtagsMapper {
    List<Hashtags> getHashtagsByPostId(int postId);
}
