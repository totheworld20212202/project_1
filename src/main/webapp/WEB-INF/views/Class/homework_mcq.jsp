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
	<script src="${pageContext.request.contextPath }/JS/list.js"></script>
	<script src="${pageContext.request.contextPath }/JS/HW/hw.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/board/list.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/HW/hw.css"> 
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>숙제제출</title>
</head>
<body style="background-color:#EAF2F8;height:100%;">
<div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 

<div class="container" id="container">
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
		<div id="user">			 
			<span style="color:red;">${userdetails.user.name }</span>님이 수강하고 있는 현재 수강하고 있는 과목은 다음과 같습니다!<br><br>
			해당 과목의 숙제리스트를 클릭해서 숙제를 제출하여 주세요!
		</div>
		<div id="courselist">	<!-- begin 수강과목 리스트 -->	 
		
			<div style="margin-top:30px;">
				<h1 id="board_list">수강목록</h1>
			</div>
			<br>
<%--------------------------------------------------------------------
								BEGIN 수강목록 리스트 
--------------------------------------------------------------------%> 
	        <table class="board_table">
				<colgroup>
					<col class="col1">
					<col class="col2">
					<col class="col3">
					<col class="col4">
					<col class="col5">
					 
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>수강과목</th>
						<th>숙제리스트 확인</th>
						<th>수강시작일</th>
						<th>수강완료일</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${userdetails.user.lectures }" varStatus="loop">
						<c:if test="${dto.status == true }"> 
							<tr>
								<td>${loop.count }</td>	<!-- loop.count는 1부터 출발, loop.index는 0부터 출발  -->
								<td>${dto.subject }</td>
								<td class="homeworkConfirm"><a>homework list</a></td>
								<td>${dto.startdate }</td>
								<td>${dto.enddate }</td>	 
							</tr>
							<input type="hidden" value="${dto.id }">	
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>	<!-- end 수강과목 리스트 -->	 
<%--------------------------------------------------------------------
								END 수강목록 리스트 
--------------------------------------------------------------------%> 
			<br><br>
		<div id="homeworklist">	<!-- BEGIN 숙제리스트 -->
			<h1 id="board_list">숙제리스트</h1>
			<%-- 
			<input type="hidden" >${userdetails.user.lectures[0] }
			${userdetails.user.lectures[0].homeworks[0].name }
			 --%>
			<%--${userdetails.user.lectures[0] }  --%>
			<%--
			${homeworks }
			 --%>
			<form id="target-1" action="/hwSelected" method="post">
				<input type="hidden"  id="hwSelected" name="hwSelected" value="abc">
				<input type="hidden" name="userid" value="${userdetails.user.id }">
				<input type="hidden" id="lecSelected" name="lectureid" value ="lectureid">
			</form>
			<%--
			userid와 몇번째 과목인지 보내야함. 
			 --%>
			 
		   
			<br>
<%--------------------------------------------------------------------
								BEGIN 숙제 리스트 
--------------------------------------------------------------------%> 
		 	 	
		<div class="homeworkList">
	 		
	 		<table class="board_table">
				<colgroup>
					<col class="col1">
					<col class="col2">
					<col class="col3">
					<col class="col4">
					<col class="col5">
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>숙제이름</th>
						<th>숙제내용</th>
						<th>마감일</th>
						<th>숙제업로드</th>
						<th>제출</th>
						
					</tr>
				</thead>
				
				 <tbody id="hw">
					   	
						<c:forEach var="dto" items="${homeworks }" varStatus="loop">
						
								<tr>
									
										<td>${loop.count} </td>
										<td>${dto.name} </td>
										<td>${dto.content}</td>
										
										<td>${dto.deadline}</td> 
										<td> 
											<form  action="/hwupload" method="post" enctype="Multipart/form-data"> 
											<label class="fileupload-button"  >
												<span>업로드</span> 
												<input type="file" name="hw-${loop.count }"  class="fileupload" style="display:hidden" >
												
											</label>	 
											
											
											<input type="hidden" name="userid" value="${userdetails.user.id }">
											<input type="hidden" name="LectureID" value="${LectureID }">
											</form>		
										</td>
											
										<td><a class="button-hwsubmit">제출</a> </td>	 
									   
								</tr>
								<%-- 뭔가 form은 table하고 맞지가 않아서 노란색 경고뜬다. div로 감싸야할것 같다.  --%>
								<%--  ${}EL로 인식되므로, \${}를사용하여 응답에 출력해야한다.  --%>
												<!-- for, id 사용하여 label과input 연결가능 또는 INPUT을 label안에 넣으면 자동연결 --> 
								<%--
										<label class="fileupload-button" id="hw-${loop.count }" for="fileupload">
											업로드 <!-- for, id 사용하여 label과input 연결가능 또는 INPUT을 label안에 넣으면 자동연결 -->
										</label>
										<input class="fileupload" style="display:none" type="file" name="hw${loop.count }" >
										${}EL로 인식되므로, \${}를사용하여 응답에 출력해야한다.  
										<input type="hidden" name="userid" value="${userdetails.user.id }">
										
								--%>
							
						</c:forEach>
					
					  
				</tbody>
				
			</table>
		</div>
		</div>	<!-- END 숙제리스트 -->
<%--------------------------------------------------------------------
								END 숙제 리스트 
--------------------------------------------------------------------%> 
		<br><br>
		<div id="homeworklist">	<!-- BEGIN 답안지 -->
		<div class="box" >
			<h1 id="board_list">답안지</h1>
			<hr>
			 
			<div class="col-4" style="border:1px dotted blue;min-height:500px;margin-top:18px;">
				<h2 style="margin-bottom:100px;"><span style="width:500px;font-weight:bold;">수강과목 :  ${subjectName }</span></h2><hr>
				<h2 style="margin-bottom:100px;"><span style="width:500px;font-weight:bold;">숙제이름 :  ${homeworkName }</span></h2><Hr>
				<h2 style="margin-bottom:100px;"><span style="width:500px;font-weight:bold;">문제개수 :  ${homeworkNumber }</span></h2><hr>	
			</div>
			<div class="col-8" style="border:none; ">
				<table class="board_table">
					<colgroup>
						<col class="col1">
						<col class="col2">
						 
					</colgroup>
					<thead>
						<tr>
							<th>문제번호</th>
							<th>선택지</th>
							 
							
						</tr>
					</thead>
					
					 <tbody id="hw">
						   	<!-- 
						   	homeworkList contains both the numbers corresponding to the real hw numbers and the numbers 
						   	which are not real hw numbers. 
						   	dto is given the number if that is the real hw number
						   	dto is given -1 if that is not a real hw number.  					   	
						   	-->
						   	<c:set var="testList" value="${fn:split('-1,2,3,4,-1,6,7,8,9,10,11',',')}"/>
						   	<%--
						   	<c:forEach	var="dto" items="${homeworkList }" varStatus="loop">	
						   	${dto} and ${loop.count }<br>
						   	 --%>
						   	<c:forEach	var="dto" items="${testList }" varStatus="loop">	
						   		 
						   		<c:if test="${dto == loop.count }">
								<tr>
											
												<td style="font-size:30px;fotn-weight:bold">
													[#${loop.count}] 
												</td>
												<td style="font-size:30px;">
													<label for="choice-first" style="color:blue;">1번</label>
													<input style="width:30px;height:30px;border:1px;margin-right:20px;" type="radio" id="choice-first" name="choice-first-${loop.count }"  />
			  										<label for="choice-second" style="color:blue;">2번</label>
			  										<input style="width:30px;height:30px;border:1px;margin-right:20px;" type="radio" id="choice-second" name="choice-second-${loop.count }"  />
			  										<label for="choice-third" style="color:blue;">3번</label>
			  										<input style="width:30px;height:30px;border:1px;margin-right:20px;" type="radio" id="choice-third" name="choice-third-${loop.count }"  />
			  										<label for="choice-fourth" style="color:blue;">4번</label>
			  										<input style="width:30px;height:30px;border:1px;margin-right:20px;" type="radio" id="choice-fourth" name="choice-fourth-${loop.count }"  />
			  										 
												</td> 
												 
								</tr>
								</c:if>
							</c:forEach>
						  
					</tbody>
					
				</table>	
			</div>
			<div class="clear"></div>
			
		</div>
		</div><!-- END  답안지 -->

</div>	<!-- end container -->	
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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