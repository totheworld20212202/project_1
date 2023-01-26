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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>내정보</title>
</head>
<body>

<div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 
<div class="container" >
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
<h1 class="ClassList" >내정보</h1>
<br>
<%--------------------------------------------------------------------
								내정보
--------------------------------------------------------------------%> 
        
        <hr>
        <div class="mb-3 mt-3 clearfix">
            <span class="float-start"></span>
            <span class="float-end ms-4">마지막 수정일: 2021-10-21 13:33:23</span>
            <span class="float-end"> </span>
        </div>

        <section>
        	<div class="mb-3">
                <label for="name">이름:</label>
                <div class="border bg-light rounded p-2">${userdetails.user.name }</div>
            </div>
            <div class="mb-3">
                <label for="name">회원아이디:</label>
                <div class="border bg-light rounded p-2">${userdetails.username }</div>
            </div>
            <div class="mb-3">
                <label for="name">생년월일:</label>
                <div class="border bg-light rounded p-2">12월1일</div>
            </div>
            <div class="mb-3">
                <label for="name">비밀번호:</label>
                <div class="border bg-light rounded p-2">${userdetails.user.password }</div>
            </div>
            <div class="mb-3">
                <label for="name">E-mail:</label>
                <div class="border bg-light rounded p-2">it@naver.com</div>
            </div>
            <div class="mb-3">
                <label for="name">전화번호:</label>
                <div class="border bg-light rounded p-2">010-1234-5678</div>
            </div>
            <div class="mb-3">
                <label for="name">주소:</label>
                <div class="border bg-light rounded p-2">강남구대치동</div>
            </div>
            <div class="mb-3">
                <label for="name">수강내역</label>
                <div class="border bg-light rounded p-2">
                	<c:forEach var="lectures" items="${userdetails.user.lectures }">
	                    	${lectures.subject }<br>
	                </c:forEach>
                </div>
            </div>

            <button type="button" class="btn btn-outline-dark">수정</button>
             

        </section>
        <br><br><br><br><br>
     	<hr>
     	<br><br>
     	  
	            
	    <%--   
	    <sec:authorize access="hasAnyRole('ADMIN')">        
	    --%>     
	    <sec:authorize access="hasAnyRole('ADMIN')">    
     	<h1>전체 회원정보</h1><br><br>
<%--------------------------------------------------------------------
								현재개설강의 목록  
--------------------------------------------------------------------%> 
 		<table class="table table-success table-striped ">
 			<thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">회원아이디</th>
		      <th scope="col">회원이름</th>
		      <th scope="col">비밀번호</th>
		      <th scope="col">회원종류</th>
		      <th scope="col">수강과목</th>
		      <th scope="col">회원가입날짜</th>
		   	  <th scope="col">회원탈퇴날짜</th> 	
		   	  <th scope="col">강제탈퇴</th>
		   	  
		   	   
		    </tr>
		    </thead>
		    <tbody>
            <c:forEach var="dto" items="${list }">
                <tr>
                    <td>${dto.id }</td>
                    <td>${dto.username }</td>
                    <td>${dto.name}</td>
                    <td>${dto.password}</td>
                    <td>
	                    <c:forEach var="auth" items="${dto.authorities }">
	                    	${auth.name }
	                    </c:forEach>
                    </td>
                    <td class = "userdetail" >수강과목</td>
                  	<td>${dto.registerDate }</td>	<%-- reDate를 ReDate로 하면 property not found exception뜨더라 --%>
                  	<td>${dto.leaveDate }</td>		<%-- dto.에서 무조건 소문자로 시작이 되어야 하는것 같다. domain에 field는 대문자시작도 상관없어보임  --%>
                    
                    <td><button id="removeuser" class="btn btn-danger me-md-2" type="button">
                    <a href="/user/delete?id=${dto.id }">강제탈퇴</a></button></td>
                     
                </tr>            
            </c:forEach>           
            </tbody>
 		</table>
 		<br><br>
 		<hr>
 		<br><br> 
<%--------------------------------------------------------------------
								회원추가  
--------------------------------------------------------------------%>
 		<form name ="addmem" action="/user/register" method="post" >
 			<h1>추가할 회원정보를 입력하시오</h1><br><br>
 			<table class="table table-info table-striped"  >
 				<thead>
 					<tr>
 						  <th scope="col">#</th>
					      <th scope="col">회원아이디</th>
					      <th scope="col">회원이름</th>
					      <th scope="col">비밀번호</th>
					      <th scope="col">회원종류</th>
					      <th scope="col">수강과목</th>
					      <th scope="col">회원가입날짜</th>
					   	  <th scope="col">회원탈퇴날짜</th> 
					   	  	
					   	   
 					</tr>
 				</thead>
 				<tbody>
 					<tr>
	                    <td>1</td>
	                    <td><input class="form-control" type="text" name="username" ></td>
	                    <td><input class="form-control" type="text" name="name"></td>
	                    <td><input class="form-control" type="text" name="password"></td>
               			<td><input id= "usertype" class="form-control" type="text" name="userauthorities" placeholder="클릭 후 선택" readonly></td>
               			<td><input id = "selectlectures" class="form-control" type="text" name="prelectures" placeholder="클릭 후 선택" readonly></td>
	                    <td><input class="form-control" type="text" name="registerDate"></td>
	                    <td><input class="form-control" type="text" name="leaveDate"></td>
               		</tr>  <%-- controller에서 처리하면 된다. --%> 
 				</tbody>
 			</table>
 			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
 				<span style="margin-right:50px;margin-top:5px;color:red;font-weight:bold;">${message }</span>	
				<button id="addmember" class="btn btn-primary me-md-2" type="button">회원추가</button>		 
			</div>
			
			<hr>
 			 
			 
			 
			<br>
<%--------------------------------------------------------------------
								개설과목보기  
--------------------------------------------------------------------%>		
	
			<div id = "subjectlist" >
				<button id="checksubject" class="btn btn-success me-md-2" type="button">개설과목등록</button>	 
				<br><br>
				<table class="table table-info table-striped">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">과목</th>
							<th scope="col">담당선생님</th>
							<th scope="col">교재</th>
							<th scope="col">강의시작일</th>
							<th scope="col">강의종료일</th>
							<th scope="col">수강신청</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${lectures }">
							<tr>
								<td>${dto.id }</td>
								<td>${dto.subject }</td>
								<td>${dto.teacher}</td>
								<td>${dto.textbook}</td>
								<td>${dto.startdate }</td>
								<td>${dto.enddate }</td>
								<%-- reDate를 ReDate로 하면 property not found exception뜨더라 --%>
								<td class="selectlecture"><i class="fa-solid fa-check"></i></td>
							</tr>

						</c:forEach>
					</tbody>
				</table>
			</div> 	
<%------------------------------------------------------------------%> 				
 		 
 		 
<%--------------------------------------------------------------------
								회원종류 
--------------------------------------------------------------------%>
			
			 
			<div id="authoritylist">
				<button id = "checkauthoritylist" class="btn btn-success me-md-2" type="button">회원종류등록</button>
				<br><br>
				<table class="table table-info table-striped">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">회원종류</th>
							<th scope="col">권한선택</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${authorities }">
							<tr>
								<td>${dto.id }</td>
								<td>${dto.name }</td>
								<td class="selectauthority"><i class="fa-solid fa-check"></i></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>	 
<%------------------------------------------------------------------%> 					








			<%------------------------------------------------------------------%> 		
 		</form>
 		<%--
 		</sec:authorize>
 		 --%>
 		</sec:authorize>
		<br>
</div>	  

 		 


<hr>
<%--

	<sec:authorize access="hasAnyRole('ROLE_MEMBER')">
		<div class="container" id="footerAbove">
			<span><a href="#" style="color: black">회사소개</a></span>&nbsp; | &nbsp;
			<span><a href="#" style="color: black">선생님 모집</a></span>&nbsp; |
			&nbsp; <span><a href="#" style="color: black">저작권 신고</a></span>
		</div>
	</sec:authorize>
 --%>
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