<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
	<script src="${pageContext.request.contextPath }/JS/atpresent/atpresent.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/atpresent/atpresent.css">
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>현재개설강의</title>
</head>
<body>
<div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 
<div class="container" >
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
<h1 class="ClassList" ><strong style="color:blue;">${lecture.subject }</strong> 수강신청</h1>

<br>
<%--------------------------------------------------------------------
								현재개설강의 목록  
--------------------------------------------------------------------%> 
 	 

	<form action="" method="post">
 
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label">회원이름</label>
	  <div class="col-sm-10">
	    <input type="email" class="form-control" id="colFormLabel" placeholder="${userdetails.user.username }" readonly>
	  </div>
	</div>
	
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label">수강신청과목</label>
	  <div class="col-sm-10">
	    <input type="email" class="form-control" id="colFormLabel" placeholder="${lecture.subject }">
	  </div>
	</div>
	
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label">Email</label>
	  <div class="col-sm-10">
	    <input type="email" class="form-control" id="colFormLabel" placeholder="it@google.com">
	  </div>
	</div>
	<br><br><br><br><br>
	<button type="submit" class="btn btn-primary">결제</button>
	 
	</form> 
	 
		 
<br><br><br><br><br><br><br><br>
<div class="clear"></div> 
<br>

</div>
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