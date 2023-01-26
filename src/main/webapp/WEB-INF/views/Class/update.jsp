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
    
     
<title>강의수정</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
<div class="container" >
<h1 class="ClassList" >강의 아이디 : ${lecture.id } 수정</h1>
<br><br>
<%--------------------------------------------------------------------
								강의수정   
--------------------------------------------------------------------%>		
		<form name ="updatelec" action="/updateOk" method="post">
 			<table class="table table-warning table-striped">
 				<thead>
 					<tr>
 						<th scope="col">#</th>
				      	<th scope="col">강의제목</th>
				     	
				        <th scope="col">교재</th>
				      	<th scope="col">담당 선생님</th>
 						<th scope="col">강의시작날짜</th>
				    	<th scope="col">강의종료날짜</th>
 					</tr>
 				</thead>
 				<tbody>
 					<tr>
	                    <td><input type="hidden" class="form-control" name="id" value = ${lecture.id } ></td>
	                    <td><input type="text" class="form-control" name="subject" value = ${lecture.subject }></td>
	                    <td><input type="text" class="form-control" name="textbook" value = ${lecture.textbook }></td>
	                    <td><input type="text" class="form-control" name="teacher" value = ${lecture.teacher }></td>
               			<td><input type="text" class="form-control" name="startdate" value = ${lecture.startdate }></td>
	                    <td><input type="text" class="form-control" name="enddate" value = ${lecture.enddate }></td>
               		</tr>  
 				</tbody>
 			</table>
 		</form>
 		
 		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button id="updatelecture" class="btn btn-primary me-md-2" type="button">강의수정</button>		 
		</div>









</div>