<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%--
<nav class="navbar navbar-dark bg-primary"></nav> 
--%> 
	 
<nav class="navbar navbar-expand-lg  style="background-color:#F2F2F2">
	 
  <div class="container-fluid">
    <a class="navbar-brand" href="#" style="font-size:xx-large;font-weight:bold;color:#F79F81;">K-학원</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
   
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/home"style="font-size:x-large;font-weight:bold;">소개</a>
        </li>
         
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size:x-large;font-weight:bold;">
            수업 
          </a>
          <ul class="dropdown-menu">
          	<li><a class="dropdown-item" href="/atpresent">현재개설강의</a></li>
          	<li><a class="dropdown-item" href="/upcoming">개설예정강의</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/requestclass">수업개설요청</a></li>
          </ul>
        </li>
       
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"style="font-size:x-large;font-weight:bold;">
            학생 
          </a>
          <ul class="dropdown-menu">
          	<li><a class="dropdown-item" href="/user/info">내정보</a></li>
          	<li><a class="dropdown-item" href="/board/list">질문게시판</a></li>
            <li><a class="dropdown-item" href="/user/homework">숙제제출(주관식)</a></li>
            <li><a class="dropdown-item" href="/mcq">숙제제출(객관식)</a></li>
            <li><a class="dropdown-item" href="#">성적확인</a></li>     
            <li><a class="dropdown-item" href="/user/homework">강의실(온라인)</a></li>
               
             
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"style="font-size:x-large;font-weight:bold;">
            학부모
          </a>
          <ul class="dropdown-menu">
          	<li><a class="dropdown-item" href="#">내정보</a></li>
            <li><a class="dropdown-item" href="#">상담</a></li>
            <li><a class="dropdown-item" href="#">성적확인</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">결제</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"style="font-size:x-large;font-weight:bold;">
            선생님
          </a>
          <ul class="dropdown-menu">
          	<li><a class="dropdown-item" href="#">내정보</a></li>
            <li><a class="dropdown-item" href="/hwlistupload">숙제등록과 채점</a></li>
            <li><a class="dropdown-item" href="#">수업계획서 등록 및<br> 개설과목 신청</a></li>
          	<li><a class="dropdown-item" href="#">자료실</a></li>
          </ul>
          
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/user/admin"style="font-size:x-large;font-weight:bold;">관리자</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="/location"style="font-size:x-large;font-weight:bold;">장소 및 시간</a>
        </li>
        <%--
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li>
         --%>
        
      </ul>
      <%--
      
       <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
       --%>
      
			<sec:authorize access="isAnonymous()">
				<button type="button" class="btn btn-outline-success"
					style="font-size: x-large; font-weight: bold;" onclick='location.href="/user/login"'>로그인</button>   
     			&nbsp;
    			<button type="button" class="btn btn-outline-success"
					style="font-size: x-large; font-weight: bold;" onclick='location.href="/user/register_person"'>회원가입</button>
			</sec:authorize>

			<!-- 로그인한 사람에게만 보이는 메뉴 -->
			<sec:authorize access="isAuthenticated()">
				<button type="button" class="btn btn-outline-success"
					style="font-size: x-large; font-weight: bold;" onclick='location.href="/user/logout"'>로그아웃</button>   
     			 
			</sec:authorize>
		</div>
     
    
    
  </div>
   
  
</nav>
 