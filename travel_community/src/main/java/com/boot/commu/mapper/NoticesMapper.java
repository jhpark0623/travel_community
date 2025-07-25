package com.boot.commu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boot.commu.model.Notices;
import com.boot.commu.model.Page;

@Mapper
public interface NoticesMapper {

	List<Notices> popNoticeList();     // 게시판 상단용
    
	List<Notices> noticeList(); // 전체 게시판 용 
    
	int countNotices(); // 현재 페이지 게시글 수 

	List<Notices> pagedNoticeList(Page pdto); // 페이지 처리 
	
	int add(Notices dto);
	
	Notices cont(int no);
	
	int edit(Notices dto);
	
	int del(int no);
	
	void seq(int no);
	
	List<Notices> search(Page pdto);
	
	int scount(Map<String, String> map);

	
}
