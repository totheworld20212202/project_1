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
			<h1 id="board_list">질문수정</h1>
		</div>
		<br>
		<div class="write_info">
            <span class="float-start me-2">id: ${write.id }</span>
            <span class="float-end ms-4">작성일: ${write.regDateTime }</span>
            <span class="float-end">조회수: ${write.viewCnt }</span>
        </div>
		<div class="clear"></div>
		<form action="update" method="POST">
			<input type="hidden" name="id" value="${write.id }">
			<div style="border: 0px solid green;border-radius:5px;height:800px;">
				<div class="p-form">
					<lable> 제목 : <br>
						<input class="input" type="text" name="subject" placeholder="제목을 입력하세요!" value="${write.subject }">
					</lable>
				</div>
				<div class="p-form">
					<lable> 작성자 : <br>
						<input class="input" type="text" name="name" placeholder="이름을 입력하세요!" value="${write.name }" >
					</lable>
				</div>
				<div class="p-form">
						
					<lable> 내용 : <br>
						<textarea name="content" id="editor"placeholder="내용을 입력하세요!" value="${write.content }"></textarea>
						
						 
					</lable> 
				</div>
			</div>
		 
			<br>
			<button class="button" type="submit" style="padding:5px;height:75px;">수정완료</button>
			<button class="button" type="button" onclick="history.back()" style="padding:5px;height:75px;">이전으로</button>
			<button class="button" type="button" onclick='location.href="/board/list"'>목록</button>
			<%-- button tag에서는 type을 button을 안해주면, 기본적으로 submit으로 동작한다. form안에서 
			그래서, type을 button으로 명시해주어야한다. 
			 --%> 
	 	</form> 









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