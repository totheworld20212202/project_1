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
	 
<!--Main Navigation-->
<%--<header> --%>
 
  <!-- Sidebar -->
  <nav id="sidebar_customized" class="sidebar_customized">
  	<div class="sidebar_position">
  	 
  		<a
          href="#hw-list"
          class="list-group-item list-group-item-action py-2 ripple"
          aria-current="true"
        >
          <i class="fas fa-tachometer-alt fa-fw me-3"></i><span>숙제등록</span>
        </a>
         
        <a href="#hw-search" class="list-group-item list-group-item-action py-2 ripple active">
          <i class="fas fa-chart-area fa-fw me-3"></i><span>숙제검색 및 채점</span>
        </a>
        <a href="#hw-submit" class="list-group-item list-group-item-action py-2 ripple"
          ><i class="fas fa-lock fa-fw me-3"></i><span>숙제제출여부</span></a
        >
  	</div>
  </nav> 
   
   
 