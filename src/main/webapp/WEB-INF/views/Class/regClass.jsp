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
 	<br>

	<form  action="payment" method="post">
 
	 
	<div style="border:1px solid gray;border-radius:5px;padding:30px;">
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>강의명</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="${lecture.subject }" readonly>
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>기간</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="3개월" readonly>
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>일정</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="${lecture.startdate } ~ ${lecture.enddate}" readonly>
	  </div>
	  
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>장소</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder=" " readonly>
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>문의</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="문의를 남겨주세요" >
	  </div>
	</div>
	
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>이름</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="${userdetails.user.name }" readonly>
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>이메일</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="it@google.com">
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>휴대전화</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="010-1234-5678">
	  </div>
	</div>
	<div class="row mb-3">
	  <label for="colFormLabel" class="col-sm-2 col-form-label form-control-lg"><strong>가격</strong></label>
	  <div class="col-sm-10">
	    <input type="text" class="form-control form-control-lg" id="colFormLabel" placeholder="50만원" readonly>
	  </div>
	</div>
	 
	<fieldset class="row mb-3">
    <legend class="col-form-label col-sm-2 pt-0 form-control-lg"><strong>마케팅 수신에 <br>동의합니다.<br>(이메일/SMS)</strong></label></legend>
    <div class="col-sm-10">
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
        <label class="form-check-label" for="gridRadios1">
          동의
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
        <label class="form-check-label" for="gridRadios2">
          비동의
        </label>
      </div>
       
    </div>
 	</fieldset> 
 	</div>
	<br><br> 
	<button type="submit" class="btn btn-primary btn-lg">결제</button>
	
		<input type="hidden" name = "lectureid" value="${lecture.id }">
		<input type="hidden" name = "userid" value="${userdetails.user.id }">
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