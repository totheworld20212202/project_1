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
<h1 class="ClassList" >개설강의 목록</h1>

<br>
<%--------------------------------------------------------------------
								현재개설강의 목록  
--------------------------------------------------------------------%> 
 		<br> 
<div class="break-out" style="background-color:#EAF2F8">	<!-- break-out은 default.css에 있음.  -->
	<div class="container">
		<c:forEach var="dto" items="${list }"> 		
		<div class="card border-primary mb-3" style="max-width: 25rem;float:left;margin-right:15px;min-width:26rem;text-align:left">
		  <div class="card-header"><h5 class="card-title" style="color:red;padding:5px;"><strong>강의제목 :</strong> ${dto.subject}</h5></div>
		  <div class="card-body text-primary">
		    <%--
		    <p class="card-text"  ></p>
		     --%>
		    
		    <input type=hidden value=${dto.id }>
		    <table class="table table-primary">
	 			 
			    <tbody>
				    <tr>
		                    <td>교재 : </td>
		                    <td>${dto.textbook } </td>		                    
		            </tr>  
		            <tr>
		                    <td>담당선생님 :  </td>
		                    <td>${dto.teacher } </td>		                     
		            </tr>
		            <tr>
		                    <td>강의시작날짜 :  </td>
		                    <td>${dto.startdate } </td>		                     
		            </tr> 
		            <tr>
		                    <td>강의종료날짜 :  </td>
		                    <td>${dto.enddate } </td>		                     
		            </tr> 
		            <tr>
		                    <td>강의상태 :  </td>
		                    <td></td>		                     
		            </tr>           
	            </tbody>
 			</table>
		     
		    <span class="regClass" >수강신청</span> 
		    <form class="form-regClass" action="/regClass" method="post">
		    	 
				<input id="regClass" type=hidden name="lectureid" value="${dto.id }">
				 
				<%--
				<input type=text name="userid" value="${userdetails.user.id }">
				 --%>
				 
			</form>	 
		    <div class="clear"></div>
		  </div>
		</div>
		</c:forEach>    	
	</div>
	
</div> 
<%--
		<table class="table table-success table-striped">
 			<thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">강의제목</th>
		      <th scope="col">교재</th>
		      <th scope="col">담당 선생님</th>
		      <th scope="col">강의시작날짜</th>
		      <th scope="col">강의종료날짜</th>
		      <sec:authorize access="hasAnyRole('ADMIN')">
		   	  <th scope="col">삭제</th> 	
		   	  <th scope="col">수정</th> 	
		   	  </sec:authorize>
		    </tr>
		    </thead>
		    <tbody>
            <c:forEach var="dto" items="${list }">
                <tr>
                    <td>${dto.id }</td>
                    <!-- 
                    <td><a href="detail?id=${dto.id }">${dto.subject }</a></td> 
                    -->
                    <td class = "subject" >${dto.subject }</td>
                    <td>${dto.textbook}</td>
                    <td>${dto.teacher}</td>
                    <td>${dto.startdate }</td>
                    <td>${dto.enddate }</td>
                    <sec:authorize access="hasAnyRole('ADMIN')">
                    <td><button id="removelecture" class="btn btn-danger me-md-2" type="button">
                    <a href="/delete?id=${dto.id }">삭제</a></button></td>
                    <td><button id="updatelecture" class="btn btn-primary me-md-2" type="button">
                    <a href="/update?id=${dto.id }">수정</a></button></td>
                    </sec:authorize>
                </tr>            
            </c:forEach>           
            </tbody>
 		</table>
 --%>
 		
 	

<%--------------------------------------------------------------------
								강의추가  
--------------------------------------------------------------------%>
<%--
<sec:authorize access="hasAnyRole('ADMIN')">
 		<hr>
 		<br><br> 
 		<form name ="addlec" action="/atpresentpost" method="post" >
 			<h1>추가할 강의를 입력하시오</h1><br><br>
 			<table class="table table-info table-striped"  >
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
	                    <td>1</td>
	                    <td><input class="form-control" type="text" name="subject" ></td>
	                    <td><input class="form-control" type="text" name="textbook"></td>
	                    <td><input class="form-control" type="text" name="teacher"></td>
               			<td><input class="form-control" type="text" name="startdate"></td>
	                    <td><input class="form-control" type="text" name="enddate"></td>
               		</tr>  
 				</tbody>
 			</table>
 		</form>
 		
 		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button id="addlecture" class="btn btn-primary me-md-2" type="button">강의추가</button>		 
		</div>

 	</sec:authorize>
 --%>
	
		 
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