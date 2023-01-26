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
		<div class="mb-3 mt-3 clearfix">
            <span class="float-start"></span>
            <span class="float-end ms-4">마지막 수정일: 2021-10-21 13:33:23</span>
            <span class="float-end"> </span>
        </div>

        <section>
        	<div class="mb-3">
                <label for="name">이름:</label>
                <div class="border bg-light rounded p-2">${user.name }</div>
            </div>
            <div class="mb-3">
                <label for="name">회원아이디:</label>
                <div class="border bg-light rounded p-2">${user.username }</div>
            </div>
            <div class="mb-3">
                <label for="name">생년월일:</label>
                <div class="border bg-light rounded p-2">3001년 1월 1일</div>
            </div>
            <div class="mb-3">
                <label for="name">비밀번호:</label>
                <div class="border bg-light rounded p-2">${user.password }</div>
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
                <div class="border bg-light rounded p-2">강남구 역삼동 </div>
            </div>
            <div class="mb-3">
                <label for="name">수강과목:</label>
                <table class="table table-success table-striped ">
		 			<thead>
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col">과목</th>
				      <th scope="col">담당선생님</th>
				      <th scope="col">교재</th>
				      <th scope="col">강의시작일</th>
				      <th scope="col">강의종료일</th>
				      <th scope="col">수강신청일</th>
				      <th scope="col">진도율</th>
				       
				   	  
				   	   
				    </tr>
				    </thead>
				    <tbody>
		            <c:forEach var="dto" items="${user.lectures }">
		                <c:if test="${dto.status ==true }">
			                <tr>
			                    <td>${dto.id }</td>
			                    <td>${dto.subject }</td>
			                    <td>${dto.teacher}</td>
			                    <td>${dto.textbook}</td>
			                    <td>${dto.startdate }</td>
			                    <td>${dto.enddate }</td>	<%-- reDate를 ReDate로 하면 property not found exception뜨더라 --%>
			                  	<td></td>		<%-- dto.에서 무조건 소문자로 시작이 되어야 하는것 같다. domain에 field는 대문자시작도 상관없어보임  --%>
			                    <td></td>
			                </tr>    
		                </c:if>
		                            
		            </c:forEach>           
		            </tbody>
 				</table>
            </div>	<%-- end 수강과목 --%>

          
             

        </section>
</body>
</html>