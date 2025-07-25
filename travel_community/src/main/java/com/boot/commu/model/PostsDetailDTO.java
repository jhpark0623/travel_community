package com.boot.commu.model;

import lombok.Data;

@Data
public class PostsDetailDTO {
	
	private int id;
    private int user_id;
    private int category_id;
    private int city_id;
    
    private String title;
    private String content;
    private String created_at;
    private String updated_at;
    private int view_count;
    private int like_count;
    private String state;

    // 조인 결과 컬럼
    private String nickname;         // 작성자 닉네임
    private String category_name;    // 카테고리명
    private String city_name;        // 시/군/구
    private String province_name;    // 도/광역시
    
}
