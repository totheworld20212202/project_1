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
			<h1 id="board_list">질문작성</h1>
		</div>
		<br>
		<div class="write_info">
            <span class="float-start me-2">id: ${write.id }</span>
            <span class="float-end ms-4">작성일: ${write.regDateTime }</span>
            <span class="float-end">조회수: ${write.viewCnt }</span>
        </div>
		<div class="clear"></div>
		<form action="/board/write" method="post">
			
		</form> 
		<section>
			<div style="border: 0px solid green;border-radius:5px;">
				<hr>
				<div class="p-form">
					 
					<lable> 제목 : <br>
						<span class="input">${write.subject }</span>  
						  
					</lable>
				</div>
				<hr> 
				<div class="p-form">
					
					<lable> 작성자 : <br>
						<span class="input">${write.user.name }</span>
						 
					</lable>
				</div>
				<hr> 
				<div class="p-form p-form_after">
					
					<lable> 내용 : <br>
						<div>${write.content }</div>
						 
					</lable> 
				</div>
				<hr>
				<!-- 첨부파일목록 -->
				<div class="container mt-3 mb-3 border rounded">
					<div class="mb-3 mt-3">
						<label>첨부파일:</label>
						<!--첨부파일 이름, 다운로드 링크 -->
						<ul class="list-group mb-1">
							<c:forEach var="fileDto" items="${write.files }">
								<li class="list-group-item"><a href="download?id=${fileDto.id }" style="color:blue;">${fileDto.source }</a></li>
							</c:forEach>
						</ul>
						<%-- 이미지인 경우 보여주기 --%>
						<c:forEach var="fileDto" items="${write.files }">
							<c:if test="${fileDto.image == true }"> <%--getter가 getimage인것 같은데 el에서는 get이 빠진다.  --%>
							<div>									<%-- getter가 getImage()이렇게 되어야하는데 isImage()로 되어있다. 뭔가 lombok에러다 user에도 transient있는데 정상작동되므로 transient문제는 아니다 --%>
								<img src="${pageContext.request.contextPath}/upload/${fileDto.file }" class="img-thumbnail">
							</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<!-- 첨부파일목록 -->
				
				
			</div>
		 		<sec:authorize access="hasAnyRole('ROLE_MEMBER')">
				<button class="button" onclick='location.href="/board/update?id=${write.id }"'>수정</button>
				</sec:authorize>
			
				<button class="button" onclick='location.href="/board/list"'>목록</button>
				<sec:authorize access="hasAnyRole('ROLE_MEMBER')">
				<button class="button" id="del">삭제</button>
				<button class="button" onclick='location.href="/board/write"'>작성</button>
				</sec:authorize>
			 
			 
			
			 
			
	 </section>	
	 <%--onclick='location.href="/board/delete?id=${write.id }"' --%>
	 
	 <script>
	 	$(function(){	// 그냥 function(){} 으로하면 이 함수가 호출이 안됨. $(function(){})으로 하면 처음에 등록이 됨. 호출된상태 
	 					// onclick일때는 그냥 함수를 호출해도 된다. 그때는 그 클릭행위가 그 함수를 호출하는것 
	 					// 아니면 바로 $("#del").click으로 $(function(){})  없이 등록해도 된다. 
	 		$("#del").click(function(){
	 			//alert("${write.subject}를 삭제하시겠습니까?");
	 			let answer = confirm("${write.subject}를 삭제하시겠습니까?");
	 			if(answer){
	 				location.href="/board/delete?id=${write.id }";
	 			}
	 		});
	 	})
	 
	 </script>









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