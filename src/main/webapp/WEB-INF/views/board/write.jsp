<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%-- 로그인한 사용자 정보 Authentication 객체의 필요한 property 들을 변수에 담아 사용 가능  --%>
<%--
<sec:authentication property="name" var="username"/>  
<sec:authentication property="authorities" var="authorities"/> 
<sec:authentication property="principal" var="userdetails"/> 
 --%>
<sec:authentication property="name" var="username"/>  
<sec:authentication property="authorities" var="authory"/> 
<sec:authentication property="principal" var="userdetails"/> 
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 항상 jqeury를 먼저로드한뒤에 밑에 external javascript를 추가해야 정상작동됨. 순서가 중요함!!! -->
	<script src="${pageContext.request.contextPath }/JS/default.js"></script>
	<!-- 
	<script src="/ckeditor5-build-classic/ckeditor.js"></script>
	<script src="/ckeditor5-build-classic/translations/ko.js"></script>
	 -->
	 
	 
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/board/list.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>질문작성</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
<div class="container" >

<%--------------------------------------------------------------------
								작성
--------------------------------------------------------------------%> 
		<div class="div">
			<h1 id="board_list">질문작성</h1>
		</div>
		<br> 
		<form action="/board/write" method="post" onsubmit="return chkSubmit()" enctype="Multipart/form-data">
			<div style="border: 0px solid green;border-radius:5px;">
				<div class="p-form">
					<lable> 제목 : <br>
						<input class="input" type="text" name="subject" placeholder="제목을 입력하세요!">
					</lable>
				</div>
				<div class="p-form">
					<lable> 작성자 :  </lable>
					<span>${username }(${userdetails.user.name })</span>
					<!-- 
						<input class="input" type="text" name="name" placeholder="이름을 입력하세요!"  >
					 -->
						
					 
				</div>
				
				
				<div class="p-form">
						
					<lable > 내용 : <br>
						<textarea  name="content" id = "editor" placeholder="내용을 입력하세요!"></textarea>
						 
					</lable> 
				</div>
				<div id="supplements">
						
					<lable > 첨부파일 : </lable> 
					<div id="files">
					
					</div><br> 
					<button type="button" id="btnAdd" style="border-radius:5px;">추가</button>	 
					 
				</div>
				
			</div>
			 
		    <!-- 첨부파일 -->
			<%-- 상단에 jQuery 추가하기--%>
			<!-- 
			<div class="container mt-3 mb-3 border rounded">
				<div class="mb-3 mt-3">
					<label>첨부파일:</label>
					<div id="files">
						
					</div>
					<button type="button" id="btnAdd" class="btn btn-secondary">추가</button>
				</div>
			</div>
			<script>
			<%-- 주의! jsp 파일 안에서 Template Literal 사용하면 ${} 는 EL 구문으로 인식되어 서버단에서 먼저 처리된다
		     응답에 출력해야 하는 경우 \${ }  처럼 escaping 해야 한다 --%>
			var i = 0;
			$("#btnAdd").click(function(){
				$("#files").append(`
							<div class="input-group mb-2">
							<input class="form-control col-xs-3" type="file" name="upfile\${i}"/>
							<button type="button" class="btn btn-outline-danger" onclick="$(this).parent().remove()">삭제</button>
							</div>`);
				i++;
			});
			</script>
			 -->
			
			<script>
			<%-- 주의! jsp 파일 안에서 Template Literal 사용하면 ${} 는 EL 구문으로 인식되어 서버단에서 먼저 처리된다
		     응답에 출력해야 하는 경우 \${ }  처럼 escaping 해야 한다 --%>
			var i = 0;
			$("#btnAdd").click(function(){
				$("#files").append(`
							<div>
							<input type="file" name="upfile\${i}"/>
							<button style="border-radius:5px;" type="button" onclick="$(this).parent().remove()">삭제</button>
							</div>`);
				i++;
			});
			</script>
			<!-- 첨부파일 -->
			<br>
			<button class="button" type="submit" style="padding:5px;height:75px;">작성완료</button>
			<button class="button" type="button" onclick="location.href='/board/list'">목록</button>
	 	
	 		 
	 	</form> 

		<script>
			function chkSubmit(){
				if($("input[name=subject]").val().trim() == ""){ // name으로 받을때는 [name='']으로 해도된다.
					alert("제목입력은 필수입니다.");
					$("input[name=subject]").focus();
					return false; 
				}
				if($("input[name=name]").val().trim() == ""){
					alert("작성자입력은 필수입니다.");
					$("input[name=name]").focus();
					return false; 
				}
				 
				 
			}
		</script>
		<%-- 
		ckeditor 밑에 스크립트를 위에 입력하면 안되고 아래에 둬야하고, 
		<script src="/ckeditor/ckeditor.js"></script>	
		의 위치는 상관이 없다. 위에 두었다. 
		 --%>
 		<script>
			CKEDITOR.replace('editor');	//ckeditor 치환할 id 	
		</script>

		
		
<%--  
		<script>
		ClassicEditor
			.create(document.querySelector('#editor'),{
				language: 'ko'	//언어설정
			},
			{
				toolbar:{
					items: [
				        'heading', '|'
				         
				    ]	
				}
			}
			
			)
			.catch( error => {
				console.error( error );
			});
		</script>
--%>






	</div>	
<br><br> 
<hr>
<div class="container" id="footerAbove">
			<span><a href="#" style="color: black">회사소개</a></span>&nbsp; | &nbsp;
			<span><a href="#" style="color: black">선생님 모집</a></span>&nbsp; |
			&nbsp; <span><a href="#" style="color: black">저작권 신고</a></span>
	</div>
	<br> 
	 <footer>
	 <div class="container" id="footer">
	 <br>
	 Copyrights Since 2022 K-학원 All Rights Reserved<br>
	 EMAIL : it@naver.com<br> 
	 PHONE : 010-1234-5678<br>
	 사업자등록번호: <br>
	 <br>
	 </div>
	 </footer>
</body>
</html>
		<%-- 
		ckeditor 밑에 스크립트를 위에 입력하면 안되고 아래에 둬야하고, 
		<script src="/ckeditor/ckeditor.js"></script>	
		의 위치는 상관이 없다. 위에 두었다. 
		 --%>
		<script src="/ckeditor/ckeditor.js"></script>	 
 		<script>
			CKEDITOR.replace('editor',{
				allowedContent: true,	//HTML 태그 자동삭제 방지 설정 
				height: '400px'
				
			});	//ckeditor 치환할 id 	
		</script>