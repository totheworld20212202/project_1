<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/JS/default.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
     
<title>Welcome to Home</title>
</head>
<body>
	<%--
	<div id="test">Hi!</div>
	--%>
	 
	 
	  
	  
	 
	 <div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 
	 <div class="container"  >
	 
	 <jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
	 
	 <image src="${pageContext.request.contextPath }/IMAGE/Home/School_01.jpg"
	 width="100%" height="auto" style="margin-left: auto; margin-right: auto; display: block;">
	 <br>
	 <div class="break-out" style="background-color:#F8F9F9">	<!-- begin break-out -->
	 <!-- break-out은 default.css에 있음.  -->
	 <div class="container" style="text-align:left">
	 
	 <h1 style="text-align:left;"><i class="fa-solid fa-landmark"></i>&nbsp; 소개</h1>
	 <hr>
	 <br>
	 <h2 class="intro">
	 1. 교육목표 
	 </h2>
	 <br><br>
	 <p class="text">
	  물리공부를 통하여 유능한 자연과학자와 공학자를 양성한다. 
	 </p>
	 <br><br>
	 <h2 class="intro">
	 2. 교육방식 
	 </h2>
	 <br><br>
	  <p class="text">
	  (1) 정확하고 간결한 설명을 통하여 이해를 돕는다.<br><br>
	  (2) 많은 질문을 통하여 학생의 이해도를 확인한다.<br><br>
	  (3) 많은 질문을 받아서 학생의 이해도를 향상시킨다. 
	 </p>
	 <br><br>
	 <h2 class="intro">
	 3. 교육방법 
	 </h2>
	 <br><br>
	 <p class="text">
	  (1) 오프라인 강의 <br><br>
	  (2) 온라인 강의<br><br>
	  (3) 녹화 강의 
	  
	 </p> 
	 </div>
	 </div>	<!-- end break-out -->
	 <br><br><br><br><br><br><br> 
	 
	 
	 </div> <!-- end container -->
	 <hr>
	 <div class="container" id="footerAbove">
	 <span><a href="#" style="color:black">회사소개</a></span>&nbsp; | &nbsp;
	 <span><a href="#" style="color:black">선생님 모집</a></span>&nbsp; | &nbsp; 
	 <span><a href="#" style="color:black">저작권 신고</a></span> 
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