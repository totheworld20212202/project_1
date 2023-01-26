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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/board/list.css">
	 
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    
     
<title>질문게시판</title>
</head>
<body>

<div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 
<div class="container" >
		<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
	 <div class="clear"></div>
 
		
<%--------------------------------------------------------------------
								BEGIN 검색 헤더 
--------------------------------------------------------------------%> 			
	<br>
	<div id="search-header">
		<div>
			<h1 id="board_list">질문게시판 목록</h1>
		</div>
		<h3 style="color:red">(수강과목별, 학생이름별, 선생님별, 검색이 가능하도록 만들어야함. )</h3>
		<br>
		<form>
			<div class="searchfield">
				<label for="topnav" style="width:175px;">학생 이름 : </label>
				<span id="topnav" class="topnav">
				  <input type="text" style="width:220px;" placeholder="학생이름을 입력하시오.">
				</span>
			</div>
		</form>			
		<%-- 해당학생으로 검색되는 학생들의 테이블 (the table of students searched by the name typed) --%>
		<form>
			<div class="searchfield">
				 
			</div>
		</form>				
		<%-- 수강과목선택  (selecting the subject taken by the student --%>
		<form>
			<div class="searchfield">
			 
			  <label for="fruit" style="width:175px;"> 선생님 이름 : </label>
				  <select class="select-subject" name="fruit">
				    <option id="select-choose" value="">-- 선생님선택 --</option>
				    <optgroup label="여름">
				      <option value="strawberry">딸기</option>
				      <option value="banana">바나나</option>
				    </optgroup>
				    <optgroup label="여름">
				      <option value="mango">망고</option>
				      <option value="melon">멜론</option>
				      <option value="grape">포도</option>
				      <option value="watermelon">수박</option>
				    </optgroup>
				    <optgroup label="가을">
				      <option value="apple">사과</option>
				      <option value="pear">배</option>
				    </optgroup>
				    <optgroup label="겨울">
				      <option value="mandarine">귤</option>
				    </optgroup>
				</select>
			
			</div>		
		</form>	
		<%-- 해당 수강과목의 숙제 선택 (selecting a homework to score handed out in the subject --%>
		
		<form>
			<div class="searchfield" style="display:inline">
			 
			  <label for="fruit" style="width:175px;"> 수강과목 이름 : </label>
				  <select class="select-subject" id="fruit" name="fruit">
				    <option value="">-- 수강과목선택 --</option>
				    <optgroup label="여름">
				      <option value="strawberry">딸기</option>
				      <option value="banana">바나나</option>
				    </optgroup>
				    <optgroup label="여름">
				      <option value="mango">망고</option>
				      <option value="melon">멜론</option>
				      <option value="grape">포도</option>
				      <option value="watermelon">수박</option>
				    </optgroup>
				    <optgroup label="가을">
				      <option value="apple">사과</option>
				      <option value="pear">배</option>
				    </optgroup>
				    <optgroup label="겨울">
				      <option value="mandarine">귤</option>
				    </optgroup>
				</select>
			
			</div>
			<button class="btn-search">검색</button>
			
		</form>
		<div class="clear"></div>	
	</div>	
<%--------------------------------------------------------------------
								END 검색 헤더 
--------------------------------------------------------------------%> 		
<%--------------------------------------------------------------------
								페이징헤더
--------------------------------------------------------------------%> 
        <br><br>       
        <div class="mb-3 mt-3 clearfix">
            <span class="float-start me-2">총 ${cnt }개</span>
            <span class="float-start">page ${page }/${totalPage }</span>
            <span class="float-end">
            	<form name="frmPageRows">
            		<input type="hidden" name="page" value="${page }">
	                <select class="form-select" name="pageRows">
	                    <option value="10" ${pageRows==10 ? 'selected' : '' }>10</option>
	                    <option value="15" ${pageRows==15 ? 'selected' : '' }>15</option>
	                    <option value="20" ${pageRows==20 ? 'selected' : '' }>20</option>
	                    <option value="50" ${pageRows==50 ? 'selected' : '' }>50</option>
	                </select>
                </form>
            </span>
        </div>   
       
<%--------------------------------------------------------------------
								페이징헤더
--------------------------------------------------------------------%>      
<%--------------------------------------------------------------------
								목록  
--------------------------------------------------------------------%> 
		
		<table id="board_table">
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
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성날짜</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.id }</td>
						<td><a href="detail?id=${dto.id }">${dto.subject }</a></td>
						<td>${dto.user.name }</td>
						<td>${dto.viewCnt }</td>
						<td>${dto.regDateTime }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>

<%--------------------------------------------------------------------
								Pagination
--------------------------------------------------------------------%> 
    <div class="container mt-1">
        <ul class="pagination justify-content-center">
            <%-- << 표시 여부 --%>   
            <c:if test="${page > 1 }">
            <li class="page-item"><a class="page-link" href="${url }" title="처음"><i class='fas fa-angle-double-left'></i></a></li>
            </c:if>     
        	 
            <%-- < 표시 여부 --%>
            <c:if test="${startPage > 1 }">
            <li class="page-item"><a class="page-link" href="${url }?page=${startPage - 1 }"><i class='fas fa-angle-left'></i></a></li>
            </c:if>
            
            <%-- 페이징 안의 '숫자' 표시 --%> 
            <c:if test="${totalPage > 1 }">
                <c:forEach var="k" begin="${startPage }" end="${endPage }">
                <c:choose>
                    <c:when test="${k != page }">
                        <li class="page-item"><a class="page-link" href="${url }?page=${k }">${k }</a></li>        			
                    </c:when>
                    <c:otherwise>
                        <li class="page-item active"><a class="page-link" href="javascript:void(0);">${k }</a></li>
                    </c:otherwise>	<%-- javascript:void(0)는 a태그 페이지변환/이동 기능 무효화시키는 코드이다. --%>
                </c:choose>
                </c:forEach>    
            </c:if>
                        
            <%-- > 표시 여부 --%>
            <c:if test="${totalPage > endPage }">
            <li class="page-item"><a class="page-link" href="${url }?page=${endPage + 1 }"><i class='fas fa-angle-right'></i></a></li>
            </c:if>
            
            <%-- >> 표시 여부 --%>
            <c:if test="${page < totalPage }">
            <li class="page-item"><a class="page-link" href="${url }?page=${totalPage }"><i class='fas fa-angle-double-right'></i></a></li>
            </c:if>
            
        </ul>
    </div>
<%--------------------------------------------------------------------
								Pagination
--------------------------------------------------------------------%> 


<br>
		<sec:authorize access="hasAnyRole('ROLE_MEMBER')">
			<button class="button" onclick='location.href="/board/write"'>작성</button>
		</sec:authorize>
<%--------------------------------------------------------------------
								목록  
--------------------------------------------------------------------%> 		




	</div>	
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