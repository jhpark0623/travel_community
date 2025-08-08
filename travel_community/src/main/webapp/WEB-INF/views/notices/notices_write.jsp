<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>



<style>
body {
	background-color: #f5f9ff;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
	max-width: 600px;
	background-color: white;
	padding: 30px 40px;
	margin-top: 40px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgb(0 0 0/ 0.1);
}

h3.page-title {
	font-weight: 500;
	font-size: 24px;
	color: #222;
	text-align: center;
	margin-bottom: 8px;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
}

hr.divider {
	width: 60px;
	border: 2px solid #20c997; /* 사진 테마색 (teal) */
	margin: 0 auto 30px auto;
}

label.form-label {
	font-weight: 600;
	color: #222;
}

input.form-control, textarea.form-control {
	border: 1px solid #ced4da;
	font-size: 14px;
	padding: 10px 12px;
}

input.form-control:focus, textarea.form-control:focus {
	border-color: #20c997;
	box-shadow: 0 0 0 0.2rem rgb(32 201 151/ 0.25);
}

.btn-group-custom {
	display: flex;
	justify-content: center;
	gap: 16px;
	margin-top: 20px;
}

.btn-custom {
	border: 1.5px solid black;
	background-color: transparent;
	color: black;
	min-width: 120px;
	font-weight: 600;
	font-size: 14px;
	transition: background-color 0.3s ease, color 0.3s ease, border-color
		0.3s ease;
}

.btn-custom:hover {
	background-color: #20c997;
	border-color: #20c997;
	color: white;
}

.mb-4 {
	margin-bottom: 32px;
}
</style>
</head>
<body>

	<!-- header include -->
	<jsp:include page="../../include/header.jsp" />

	<div class="container" style="width: 800px; margin: 50px auto;">
		<h3 class="page-title">📢 공지사항 작성</h3>
		<hr class="divider">

		<form method="post"
			action="<%=request.getContextPath()%>/notices_write_ok.go">
			<div class="mb-4">
				<label for="title" class="form-label">제목</label> <input type="text"
					class="form-control" id="title" name="title" placeholder="공지 제목"
					required>
			</div>

			<div class="mb-4">
				<label for="summernote" class="form-label">내용</label>
				<textarea class="form-control" id="summernote" name="content"
					rows="6" placeholder="공지 내용을 입력하세요" required></textarea>
			</div>

			<div class="btn-group-custom">
				<button type="submit" class="btn btn-custom">작성 완료</button>
				<button type="reset" class="btn btn-custom">다시 작성</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">

//summernote 기본 설정
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

</script>

</body>
</html>