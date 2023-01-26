<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
     
<title>Insert title here</title>
</head>
<body>
	 
 
	 결제완료<br>
	 
	<button type="submit" class="btn btn-primary btn-lg" onclick="location.href = '/home'">홈</button>
	
	 
	
</body>
</html>