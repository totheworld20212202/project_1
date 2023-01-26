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
    <script>
		     		function checkNull(){
		     			alert("Hello");
		     			var s = $("#selectlectures").val();
		     			if (s==null || s==""){
		     				alert('회원종류는 최소한 하나 선택해야합니다. 선택 후 초록색버튼의 "회원종류등록"을 눌러주세요!')
		     				return false;
		     				
		     			}
		     			return true; 
		     			
		     		}
	</script>
     
<title>회원권한추가</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
<br><br>
<div class="container" >
<h1 class="ClassList" >회원권한변경</h1>
<br>
<%--------------------------------------------------------------------
								내정보
--------------------------------------------------------------------%> 
        
        <hr>
       
     	  
	            
	     
     	 
     	
     	<form name ="addmem" action="/user/updateOk" method="post"  >
 			 
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
	                    <td></td>
	                    <td><input class="form-control" type="text"  placeholder="${user.username }" readonly ></td>
	                    <td><input class="form-control" type="text"  placeholder="${user.name }" readonly></td>
	                    <td><input class="form-control" type="text" placeholder="${user.password }" hidden>
	                    <input class="form-control" type="text"  readonly></td>
               			<td><input id= "usertype" class="form-control" type="text" name="userauthorities" placeholder="클릭 후 선택" readonly style="background-color:#FAEEFF;"></td>
               			<td><input id = "selectlectures" class="form-control" type="text" placeholder"${user.lectures }" hidden>
               			<input class="form-control" type="text"  readonly></td>
	                    <td><input class="form-control" type="text" placeholder="${user.registerDate }" readonly ></td>
	                    <td><input class="form-control" type="text" placeholder="${user.leaveDate }" readonly ></td>
	                    <input hidden name="userid" value=${user.id }>
               		</tr>  <%-- controller에서 처리하면 된다. --%> 
 				</tbody>
 			</table>
 			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
 				<span style="margin-right:50px;margin-top:5px;color:red;font-weight:bold;">${message }</span>	
				<button id="addmember" class="btn btn-primary me-md-2" type="button">회원권한변경</button>		 
			</div>
				
			<hr>
 			 
<%--------------------------------------------------------------------
								END 회원추가  
--------------------------------------------------------------------%>			 
			 
			<br>
 
 		 
 		 
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
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
</div>	  <%-- END container --%>

 		 


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
     	