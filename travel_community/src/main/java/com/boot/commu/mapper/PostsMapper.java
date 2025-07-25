package com.boot.commu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.commu.model.Posts;
import com.boot.commu.model.Page;

@Mapper
public interface PostsMapper {

	List<Posts> list(String i);

	int countByCategory(String i);
	
}
