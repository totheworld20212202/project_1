<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 항상 jqeury를 먼저로드한뒤에 밑에 external javascript를 추가해야 정상작동됨. 순서가 중요함!!! -->
	<script src="${pageContext.request.contextPath }/JS/default.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>세부내용</title>
</head>
<body>
<br><br>
<h2>1. 강의 제목 : ${lecture.subject }</h2>
<h2>2. 교재 : ${lecture.textbook }</h2>
<h2>3. 담당 선생님 : ${lecture.teacher }</h2>
<h2>4. 강의시작날짜 : ${lecture.startdate }</h2>
<h2>5. 강의종료날짜 : ${lecture.enddate }</h2>
<br><br>
<hr>
<h2>6. 특이사항</h2>
<hr>
<div class="detail" >세부사항</div>
</body>
</html>