<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<style type="text/css">
.deleteButton {
	height: 15px;
	width: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-left: 10px;
	font-size: small;
}

.deleteButton:hover {
	
}

span:hover {
	border-color: black;
}
</style>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div style="width: 800px; margin: 50px auto;">


		<form method="post"
			action="<%=request.getContextPath()%>/post_modify_ok.go"
			class="needs-validation">

			<input type="hidden" name="id" value="${post.getId() }">

			<div class="container my-4 d-flex align-items-center">

				<div class="d-flex flex-column" style="margin-right: 50px;">
					<label for="selectCity" class="form-label fw-bold mb-1">카테고리</label>
					<select id="category" class="form-select" style="width: 200px;"
						name="category_id">
						<option>카테고리</option>
						<option value=1
							<c:if test="${post.getCategory_id() == 1 }">selected</c:if>>자유
							게시판</option>
						<option value=2
							<c:if test="${post.getCategory_id() == 2 }">selected</c:if>>정보
							게시판</option>
						<option value=3
							<c:if test="${post.getCategory_id() == 3 }">selected</c:if>>질문
							게시판</option>
					</select>
				</div>
				<div class="d-flex flex-column" style="margin-right: 50px;">
					<label for="selectCity" class="form-label fw-bold mb-1">시/광역시</label>
					<select id="provinceSelect" class="form-select"
						style="width: 200px;" name="province">
						<option value="">시/광역시</option>
						<c:forEach items="${provinceList }" var="province">
							<option value="${province.getId() }"
								<c:if test="${post.getProvince_id() == province.getId() }">selected</c:if>>${province.getName() }</option>
						</c:forEach>
					</select>
				</div>

				<div class="d-flex flex-column" style="margin-right: 50px;">
					<label for="selectDistrict" class="form-label fw-bold mb-1">시/군/구</label>
					<select id="citySelect" class="form-select" style="width: 200px;"
						name="city_id">
						<option>시/군/구</option>
						<c:forEach items="${cityList }" var="city">
							<option value="${city.getId() }"
								<c:if test="${post.getCity_id() == city.getId() }">selected</c:if>>${city.getName() }</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="mb-3">
				<input type="text" class="form-control" name="title"
					placeholder="제목을 입력해 주세요" required value="${post.getTitle() }">
				<div class="invalid-feedback">Looks good!</div>
			</div>

			<div class="mb-3 pb-3 border-bottom">
				<textarea name="content" id="summernote"></textarea>
				<input type="hidden" id="value" value='${post.getContent() }'>
			</div>

			<div class="mb-3 d-flex align-items-center">
				<input type="text" class="form-control border-0" id="hashtagInput"
					placeholder="# 해시태그를 입력해 주세요 (최대 10개)">
			</div>

			<div id="hashtag" class="d-flex flex-wrap border-bottom">
				<input type="hidden" id="hashtags" name="hashtags[]"
					value="${hashtags }">
			</div>

			<input class="btn btn-outline-secondary mt-3 float-end" type="submit"
				value="글작성">

		</form>

	</div>

	<script>
	
		// post 수정 시 게시글 가져와서 화면에 출력
		window.onload = function () {
			$('#summernote').summernote('code', $('#value').val())
		}

		var hashtags;
		

		$(document).ready(function() {
			
			hashtags = []
			
			const hashtagList = $('#hashtags').val();
			
			for(const hashtag of hashtagList.substring(1, hashtagList.length - 1).split(", ")){
				hashtags.push(hashtag)
				const hashtagElement = $('<span id="' + hashtag + '" class="m-1 px-2 py-1 border rounded-pill d-flex align-items-center">#'+hashtag+' <button type="button" id="deleteBtn" class="btn-close border-0 rounded-circle deleteButton" aria-label="Close"></button></span>'); 
				$('#hashtag').append(hashtagElement);
			}
			
			$('#hashtags').val(hashtags)
			
			$('#provinceSelect').change(function(){
				
				const provinceCode = $(this).val();
				
				$.ajax({
					type: "POST",
					url: "/getCityCode",
					data: {"provinceCode" : provinceCode},
					success: function(res){
						const cityList = res.cityList;
						const cityArray = cityList.substring(1, cityList.length - 1).split(", ")
						
						$('#citySelect').empty();
						$('#citySelect').append(
								"<option>시/군/구</option>"
								);
						
						for(const cityItem of cityArray) {
							const city = JSON.parse(cityItem);
							const option = $("<option value="+city.id+">"+city.name+"</option>");
							$('#citySelect').append(option);
						}
					}
				})
				
			});
			
			// summernote 기본 설정
			$('#summernote').summernote({
				placeholder:"내용을 입력해 주세요",
				height: 420,
				disableResizeEditor: true,
				lang: "ko-KR",
				background: "white",
				
				
				toolbar: [
	            	// [groupName, [list of button]]
	            	['Font Style', ['fontname']],
	            	['style', ['bold', 'italic', 'underline']],
	            	['font', ['strikethrough']],
	            	['fontsize', ['fontsize']],
	            	['color', ['color']],
	            	['para', ['paragraph']],
	            	['height', ['height']],
	            	['Insert', ['picture']],
	            	['Insert', ['link']],
	            	['Misc', ['fullscreen']]
	            ],

	            fontSizes: [
	                '8', '9', '10', '11', '12', '14', '16', '18',
	                '20', '22', '24', '28', '30', '36', '50', '72',
	            ], // 글꼴 크기 옵션
	            
	            // 파일 업로드를 위한 콜백함수
	            callbacks: {
	                onImageUpload: function (files, editor, welEditable) {
	                    // 파일 업로드 (다중 업로드를 위해 반복문 사용)
	                    for (let file of files) {
	                    	
	                        // 이미지 alt 속성 삽일을 위한 설정
	                        const alt = file.name
	                        if (alt == '') alt = '이미지'
	                        
	                        uploadImageFile(file, this, alt)
	                    }
	                },
	            },
			});
		});
		
		
		// text type input 에서 enter 입력시 submit 발동 안되게 설정
		$('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) event.preventDefault();
		});
		
		
		
		// hashtag input 설정
		$(document).on('keyup', '#hashtagInput', function(e){
			// enter 입력시 입력값 가져오기
			if(e.keyCode == 13){
				const hashtag = $('#hashtagInput').val();
				
				if(hashtag == "") return;
				
				const wndqhr = $("#hashtag").children("#" + hashtag);
				
				if(wndqhr.length != 0) {
					alert("중복된 태그입니다.")
					return
				};
				
				if($('#hashtag').children('span').length == 10){
					alert("해시태그는 10개까지 작성 가능합니다.")
					return
				}
					
				hashtags.push(hashtag);
				
				// hidden input 태그에 해시태그 저장
				$('#hashtags').val(hashtags)
				
				
				const hashtagElement = $('<span id="' + hashtag + '" class="m-1 px-2 py-1 border rounded-pill d-flex align-items-center">#'+hashtag+' <button type="button" id="deleteBtn" class="btn-close border-0 rounded-circle deleteButton" aria-label="Close"></button></span>'); 
				$('#hashtag').append(hashtagElement);
				$('#hashtagInput').val("");
			}
		})
		
		// 해시태그 삭제 버튼 클릭 시
		$(document).on('click', '#deleteBtn', function(){
			const inputValue = $("#hashtags").val().split(",");
			const delID = $(this).parent().attr("id");
			
			for(let i = 0; i < inputValue.length; i++){
				if(inputValue[i] == delID)
					hashtags.splice(i, 1);
			}
			
			$('#hashtags').val(hashtags)
			
			$(this).parent().remove();
		})
		
	
		
		 // 이미지 업로드 함수 ajax 활용
	    function uploadImageFile(file, el, alt) {
	        const data = new FormData()
	        data.append('file', file)
	        console.log(file);
	        $.ajax({
	            data: data,
	            type: 'POST',
	            url: '/uploadImageFile',
	            contentType: false,
	            enctype: 'multipart/form-data',
	            processData: false,
	            success: function (data) {
	            	console.log(data);
	                $(el).summernote(
	                    'editor.insertImage',
	                    data.url,
	                     function ($image) {
	                        $image.attr('alt', alt) // 캡션 정보를 이미지의 alt 속성에 설정
	                    } 
	                )
	            },
	        })
	    }
	</script>

</body>
</html>
