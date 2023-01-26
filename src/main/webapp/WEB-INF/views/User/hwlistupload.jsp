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
	<script src="${pageContext.request.contextPath }/JS/HW/hwregister.js"></script>
	<script src="${pageContext.request.contextPath }/JS/Sidebar/sidebar_hw.js"></script>
	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/default.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/board/list.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/HW/hw.css"> 
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/HW/hwregister.css"> 
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/HW/hwsearch.css"> 
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/HW/searchAndScoringUsersBySubject.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/Sidebar/sidebar_hw.css"> 
 
	
    
     
<title>숙제등록</title>
</head>
<body style="background-image: url('/IMAGE/Background/background_homework.jpg');height:100%;">

<div style="background-color:#F2F2F2;height:74px; width:100%;opacity:0.8;z-index:-1;position:absolute"></div> 

<div class="container" id="container">
 
<jsp:include page="/WEB-INF/views/Include/nav.jsp"/> 
<jsp:include page="/WEB-INF/views/Include/sidebar_hw.jsp"/>
	 <div class="clear"></div>

<br><br>
	<div id="user">			 
			<span style="color:red;">${userdetails.user.name }</span>님이 개설한 강의는 다음과 같습니다. <br><br>
			해당 과목의 숙제리스트를 클릭해서 숙제를 업로드해주세요!    
		</div>
		<div id="courselist">	<!-- begin 수강과목 리스트 -->	 
			<a name="hw-list"></a>
			<div >
				<h1 id="board_list">개설강의목록</h1>
			</div>
			<hr>
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
						<th>개설과목</th>
						<th>숙제리스트 확인</th>
						<th>수강시작일</th>
						<th>수강완료일</th>					
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${userdetails.user.lectures }" varStatus="loop"> 				 
						<c:if test="${dto.status == true }"> </c:if> 
							<tr>
								<td>${loop.count }</td>	<!-- loop.count는 1부터 출발, loop.index는 0부터 출발  -->
								<td>${dto.subject }</td>
								<td class="homeworkConfirm"><a>homework list</a></td>
								<td>${dto.startdate }</td>
								<td>${dto.enddate } </td>
							</tr>
							<input type="hidden" value="${dto.id }">							 
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
			<hr>
			<%-- 
			<input type="hidden" >${userdetails.user.lectures[0] }
			${userdetails.user.lectures[0].homeworks[0].name }
			 --%>
			<%--${userdetails.user.lectures[0] }  --%>
			<%--
			${homeworks }
			 --%>
			<form id="target" action="/hwlistuplaod" method="post">
				<input type="hidden"  id="hwSelected" name="hwSelected" value="abc">
				<input type="hidden" name="userid" value="${userdetails.user.id }">
				<input type="hidden" id="lectureSelected" name="lectureid" value ="lectureid">
			</form>
			<%--
			userid와 몇번째 과목인지 보내야함. 
			 --%>	   
			<br>
<%--------------------------------------------------------------------
								BEGIN 숙제 리스트 
--------------------------------------------------------------------%> 		 	 	
		<div class="homeworkList">	 		
	 		<table class="hwregister_table">
				<colgroup>
					<col class="col1">
					<col class="col2">
					<col class="col3">
					<col class="col4">					 
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>숙제이름</th>
						<th>숙제내용</th>
						<th>마감일</th>						
					</tr>
				</thead>				
				 <tbody id="hw">					   	
						<c:forEach var="dto" items="${homeworks }" varStatus="loop">						
								<tr>									
										<td>${loop.count} </td>
										<td>${dto.name} </td>
										<td>${dto.content}</td>
										<td>${dto.deadline}</td> 							   
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
			 
				<form name = "form_hw" id="form-hw" action="\newhwupload" method="post" onsubmit="return chkSubmit()" >
					<div id="newhwregister">
						<label for="hwname" class="addhwlabel">숙제이름 : </label>		
						<input type="text" id="hwname"  class="addhw" name="name"> <br><br>
						<label for="hwcontent" class="addhwlabel">숙제내용 : </label>		
						<input type="text" id="hwcontent" class="addhw" name="content"> <br><br> 
						<label for="hwdeadline" style="margin-right:20px;" class="addhwlabel">마감일 : </label>		
						<input type="text" id="hwdeadline" class="addhw" name="deadline"> 	
					</div>
					<input type="hidden" name="hwSelected" value="${hwnumber }">
					<input type="hidden" name="lectureid" value="${lectureid }">
					<input type="hidden" name="userid" value="${userdetails.user.id }">
				</form>	
			
			<br>
			<span id="newhw">새 숙제 추가</span><span id="registerhw">새 숙제 등록</span>
		</div>
		</div>	<!-- END 숙제리스트 -->
		
		<script>
		
				function chkSubmit(){
				  var frm = document.forms['form_hw'];
				
				  if(frm['name'].value.trim() == ""){
					    alert("숙제이름은 필수입니다");
					    frm['name'].focus();   // return false 하기 전에 커서 위치시키기
					    return false;   // onsubmit 에 false 를 리턴하면 submit 안된다.
				  }
				  if(frm['content'].value.trim() == ""){
					    alert("숙제내용은 필수입니다");
					    frm['name'].focus();   // return false 하기 전에 커서 위치시키기
					    return false;   // onsubmit 에 false 를 리턴하면 submit 안된다.
				  }
				  if(frm['deadline'].value.trim() == ""){
					    alert("마감일은 필수입니다");
					    frm['deadline'].focus();   // return false 하기 전에 커서 위치시키기
					    return false;   // onsubmit 에 false 를 리턴하면 submit 안된다.
				  }
				
				  return true;  // onsubmit 에 true 를 리턴하면 submit 진행된다.
				}
		</script>			
<%--------------------------------------------------------------------
								END 숙제 리스트 
--------------------------------------------------------------------%> 
<br><br>
<%--------------------------------------------------------------------
								BEGIN 객관식 숙제등록   
--------------------------------------------------------------------%> 
		<div id="homeworklist">	<!-- BEGIN 답안지 -->
		<div class="box" >
			<h1 id="board_list">객관식 숙제등록</h1>
			<hr>
			 <!--  밑에 문제개수를 증가감소시키는 eventListener를 적용해야함.  -->
			<div class="col-4" style="border:1px dotted blue;min-height:500px;margin-top:18px;">
				<h2 style="margin-bottom:50px;"><span style="width:500px;font-weight:bold;">수강과목 :  ${subjectName }</span></h2><hr>
				<h2 style="margin-bottom:50px;"><span style="width:500px;font-weight:bold;">숙제이름 :  ${homeworkName }</span></h2><Hr>
				<h2><span style="width:500px;font-weight:bold;">문제개수 :    
					<span style="float:right;font-size:20px;margin-top:14px;margin-left:5px;">개</span><input value="10" id="hw_number" readonly type = "text" placeholder="(예) 10" style="float:right;width:50px;height:50px;font-size:20px;text-align:center;"></span>
					<div class="clear"></div>
					<button id="hw_number-plus" style="float:right;font-size:20px;margin-top:10px;margin-right:8px;"><i class="fa-solid fa-minus"></i></button>
					<button id="hw_number-minus" style="float:right;font-size:20px;margin-top:10px;margin-right:1px;"><i class="fa-solid fa-plus"></i></button>					 
				</h2><br><hr>
				
				<h2><span style="width:500px;font-weight:bold;">선택지개수 :   
					<span style="float:right;font-size:20px;margin-top:14px;margin-left:5px;">개</span><input value="5" readonly id="choice_number" type = "text" placeholder="(예) 10" style="float:right;width:50px;height:50px;font-size:20px;text-align:center;"></span>
					<div class="clear"></div>
					<button id="answer_number-plus" style="float:right;font-size:20px;margin-top:10px;margin-right:8px;"><i class="fa-solid fa-minus"></i></button>
					<button id="answer_number-minus" style="float:right;font-size:20px;margin-top:10px;margin-right:1px;"><i class="fa-solid fa-plus"></i></button>					 
				</h2><br><hr>
				<h2><span style="width:500px;font-weight:bold;">선택지이름 :   					 
						<select id="cars" style="float:right;font-size:25px;margin-top:3px;margin-right:20px;">
						  <option value="volvo">Kor</option>
						  <option value="saab">Eng</option>
						</select> 	
				</span>
				</h2><br><hr>	 						  						   
				<h2><span style="width:500px;font-weight:bold;">선택지종류 :   
						<select id="cars" style="float:right;font-size:25px;margin-top:0px;margin-right:20px;padding:5px;">
						  <option value="volvo">단일답안</option>
						  <option value="saab">복수답안</option>
						</select>
				</span>
				</h2><br><hr>
				<h2><span style="width:500px;font-weight:bold;">설명 : </span></h2> <br> <p style="font-size:20px;">숙제번호가 해당되지 않으면 빈칸으로 두면 됩니다. </p> 
			</div>
			<script>
				let hw_number_plus = document.querySelector("#hw_number-plus");
				let hw_number_minus = document.querySelector("#hw_number-minus");
				let hw_number = document.querySelector("#hw_number");
				let answer_number_plus = document.querySelector("#answer_number-plus");
				let answer_number_minus = document.querySelector("#answer_number-minus");
				let choice_number = document.querySelector("#choice_number");
				hw_number_plus.addEventListener("click", function(){
					console.log()
					hw_number.value = hw_number.value + 1; 
				})
				hw_number_minus.addEventListener("click", function(){
					hw_number.value = hw_number.value - 1; 
				})
				answer_number_plus.addEventListener("click", function(){
					choice_number.value = choice_number.value + 1; 
				})
				answer_number_minus.addEventListener("click", function(){
					choice_number.value = choice_number.value - 1; 
				})
				console.log("hw_number는 : " + hw_number);
				//let arr = [];
				//document.querySelector("#hw_number").value = "abc";
				//console.log(document.querySelector("#hw_number").value);
				var num; 
				hw_number.addEventListener('input',function(e){// 'change'나, 'click' 처럼 'input'이 생기면, 그걸 function안에 object e안에 e.target.value에 저장시킨다.
					 
					//console.log(e.target.value);
					num = e.target.value;  
					document.querySelector("#hw_number").value = num;
					
					 
					 
				});
				 
				 
				 
						 
				//$("h1").click(function(){
				//	alert($("#hw_number").val())
				//})
			</script>
			 
			<div class="col-8" style="border:none; ">
				<table class="board_table">
					<colgroup>
						<col class="col1">
						<col class="col2">
						 
					</colgroup>
					<thead>
						<tr>
							<th>문제번호</th>
							<th>답</th>
							 
							
						</tr>
					</thead>
					
					 <tbody id="hw">
						   	<!-- 
						   	homeworkList contains both the numbers corresponding to the real hw numbers and the numbers 
						   	which are not real hw numbers. 
						   	dto is given the number if that is the real hw number
						   	dto is given -1 if that is not a real hw number.  					   	
						   	-->
						   	<c:set var="testList" value="${fn:split('1,2,3,4,5,6,7,8,9,10',',')}"/>
						   	<span id = "split"></span>
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
<%--------------------------------------------------------------------
								END 객관식 숙제등록   
--------------------------------------------------------------------%> 		

<%--------------------------------------------------------------------
								BEGIN 학생숙제 검색 및 채점 
--------------------------------------------------------------------%> 	
	
<div id="hw-search">
	<h1 id="board_list">해당과목의 숙제를 제출한 학생 검색 및 채점</h1><a name="hw-search"></a>
	<hr>
		
		<%-- 학생이름으로 수강과목 검색 (searching the subjects taken by students) --%>
		<%--
		<form>
			<div class="searchfield">
				<label for="topnav" style="width:175px;">학생이름 : </label>
				<span id="topnav" class="topnav">
				  <input type="text" style="width:220px;" placeholder="학생이름을 입력하시오.">
				</span>
			</div>
		</form>	
		--%>
				
		<%-- 해당학생으로 검색되는 학생들의 테이블 (the table of students searched by the name typed) --%>
		<form>
			<div class="searchfield">
				 
			</div>
		</form>				
		<%-- 수강과목선택  (selecting the subject taken by the student --%>
		<!-- 수강과목을 선택하고, 숙제번호를 선택하여 학생목록을 얻고 다운로드버튼과 전체다운로드 버튼을 설정 
			 채점결과를 업로드하는 버튼도 생성하기 
		 -->
		 
			<div class="searchfield">
			 
			  <label for="fruit" style="width:175px;"> 수강과목 선택 : </label>
		      	<select class="select-subject" id="fruit" name="fruit">
		      		<c:set var="lecturename" value="${lec_name }"/>
		      		<c:choose>
			      		<c:when test="${lecturename != null }">
			      			<option value="" style="color:blue;">${lec_name }</option>	
			      			
			      		<c:forEach var="dto" items="${userdetails.user.lectures }">
					    	<option class="hw_subject" value="">${dto.subject }</option>
					    	<option style="display:none;">${dto.id }</option>
					    </c:forEach>	
			      		</c:when>
			      		<c:otherwise>
					    	<option value="" style="color:blue;">-- 선택하세요 --</option>
					    <c:forEach var="dto" items="${userdetails.user.lectures }">
					    	<option class="hw_subject" value="">${dto.subject }</option>
					    	<option style="display:none;">${dto.id }</option>
					    </c:forEach>
					    </c:otherwise>
				    </c:choose>	 
				</select>
				
				<span id="userid" style="display:none;">${userdetails.user.id }</span>
			</div>		
			<%--
			<input id="hw-subject-selected" type="hidden" name="hwSubjectId" value="">
			 --%>
			 
 			
			 
			<script>
				
				//$("#hw_").click(function(){
				//	alert("Hello");
				
				//})
				
				
				let subject = document.querySelector(".select-subject");
					subject.addEventListener("change",function(){
						//alert(subject.options[subject.selectedIndex].value);
						//alert(subject.options[subject.selectedIndex].text);
						//console.log(subject.options[subject.selectedIndex+1].text);
						let subjectSelectedId = subject.options[subject.selectedIndex+1].text;
						//document.querySelector("#hw-subject-selected").value=subjectSelectedId;
						//console.log(document.querySelector("#hw-subject-selected").value);
						//let userid = document.querySelector("#userid").innerText;
						//alert("userid는" + userid);
						//console.log("userid는" + userid);
						//location.href="/hwBySubject?lid="+subjectSelectedId+"&uid=" + userid;
						location.href="/hwBySubject?lid="+subjectSelectedId;
					});
				
			</script>
			
    		<c:choose>
    			<c:when test="${lec_name != null }">
    				<script>
    					location.href = "#hw-search";
    				</script>
    			</c:when>
    		</c:choose>
		<%-- 해당 수강과목의 숙제 선택 (selecting a homework to score handed out in the subject --%>
		
		<form>
			<div class="searchfield" style="display:inline">
			 
			  <label for="fruit" style="width:175px;"> 숙제 선택 : </label>
			  	<select class="select-subject select-homework" id="fruit" name="fruit">
			  		<c:set var="homeworkname" value="${hw_name }"/>
		      		<c:choose>
		      			<c:when test="${homeworkname != null }">
				      			<option value="" style="color:blue;">${hw_name }</option>	
				      			
				      		<c:forEach var="dto" items="${lid_homeworks }">
						    	<option class="hw_name" value="">${dto.name }</option>
						    	<option style="display:none;">${dto.id }</option>
						    	<option style="display:none;">${lec_id }</option>
						    </c:forEach>	
			      		</c:when>
			      		<c:otherwise>
						    	<option value="">-- 선택하세요 --</option>
						    <c:forEach var="dto" items="${lid_homeworks }">
						    	<option class="hw_name" value="">${dto.name }</option>
						    	<option style="display:none;">${dto.id }</option>
						    	<option style="display:none;">${lec_id }</option>
						    </c:forEach>
					    </c:otherwise>
				    </c:choose>	 
				    
				</select>
				<div id="check_userid" style="display:none">${userdetails.user.id }</div>	 
			</div>
			<!-- 
			<button class="btn-search">검색</button>
			 -->
			 
		</form>	
		<hr>
			<script>
				let homework = document.querySelector(".select-homework");
				let userid = document.querySelector("#check_userid").innerHTML; 
					console.log("userid는 : " + userid);
					homework.addEventListener("change",function(){
						 
						let homeworkSelectedId = homework.options[homework.selectedIndex+1].text;
						let lectureSelectedId = homework.options[homework.selectedIndex+2].text;
						
						console.log("homework는 : " + homeworkSelectedId);
						console.log("lecture는 : " + lectureSelectedId);
						location.href="/usersByHwAndLec?hid="+homeworkSelectedId+"&lid="+lectureSelectedId+"&uid="+userid;
					});				
			</script>			
		<div>
		
		
			<table class="searchUserBySubjects_Table">
				<colgroup>
					<col class="col1">
					<col class="col2">
					<col class="col3">
					<col class="col4">	
					<col class="col5">
					<col class="col6">
					<col class="col7">				 
				</colgroup>
					<thead>
						<tr>
							<th>#</th>
							<th>학생이름</th>
							<th>제출여부</th>
							<th>제출된 숙제  </th>	
							<th>채점결과 </th>
							<th>숙제점수</th>
							<th>채점상태</th>					
						</tr>
					</thead>				
						<tbody id="hw">					   	
								<c:forEach var="dto" items="${usersByLecture }" varStatus="loop">		<!-- 숙제검색 및 채점 -->				
										<tr>									
												<td>${loop.count } </td>
												<td>${dto.name } </td>
												<td id="submit-${loop.count }"style="font-size:50px;"><i class="fa-solid fa-square-xmark"></i></td>
												<td><button id="down-${loop.count }"class="btn-search" style="float:none;">다운로드</button> </td> 
												<td><button class="btn-search" style="float:none;">업로드</button></td>
												<td>
													<div>
														 
															<span id="topnav" class="topnav" >
															  <input type="text" style="margin-bottom:10px;width:200px;float:none;"placeholder="숙제점수를 입력하시오.">
															</span>
													</div>														
												</td>
												<td>
													<button class="btn-search" style="float:none;">입력</button>
													<button class="btn-search" style="float:none;display:none;">수정</button>
												</td>
										</tr>
											<form name="${loop.count }" action="#" method="post">
											 
											 	
												<input id="path-${loop.count }" type="hidden" name="path" value="">
												 
											</form>
										 	 
								</c:forEach>
											 
										<c:forEach var="Submit" items="${isSubmit }" varStatus="loop">
											 		 
										 	 
										 	 
												<c:choose>
													<c:when test="${Submit == true}">	
															<c:forEach var="list" items="${listOfPaths }" varStatus="loop_two">
													 			 
													 			<c:if test="${loop_two.count == loop.count }">
													 				<c:set var="path" value="${list }"/>
													 				 
													 				<input id="particular" type="hidden" value = ${path }>
													 				
													 			</c:if>
														 	</c:forEach>
															<script>	 
																	document.querySelector("#submit-"+${loop.count }).innerHTML = '<i class="fa-solid fa-check"></i>';
																	let particular = document.querySelector("#particular").value;															 
																	document.querySelector("#path-"+${loop.count}).setAttribute('value',particular);
																	console.log(document.querySelector("#path-"+${loop.count}).getAttribute('value'));
																	let down = document.querySelector("#down-"+${loop.count });																 
																	down.addEventListener("click",function(){																		 
																		document.querySelector('form[name="'+${loop.count}+'"]').setAttribute('action',"/HwDownload" );
																		document.querySelector('form[name="'+${loop.count}+'"]').submit(); 	
																	})
																	
																	
																	
															</script>
													</c:when>
												</c:choose>
											 
										</c:forEach>
						</tbody>				
			</table>	
								
		</div> 
		 	 		
		 
		<div class="clear"></div>
	 
		<hr>
		 
		 
		<%-- 제출된 숙제 보기 (reading and downloading the homework uploaded by the student) --%>


</div>	
	
<%--------------------------------------------------------------------
								END 학생숙제 검색 및 채점 
--------------------------------------------------------------------%> 	
	
<%--------------------------------------------------------------------
								BEGIN 수강과목별 숙제제출한 학생검색 
--------------------------------------------------------------------%> 	
	<a name="hw-submit"></a>
<div id="hw-search">
	<h1 id="board_list">수강과목별 숙제제출한 학생검색 및 성적 </h1>
	<hr>
		
		<%-- 학생이름으로 수강과목 검색 (searching the subjects taken by students) --%>
		<form>
			<div class="searchfield">
			 
			  <label for="fruit"> 개설과목 : </label>
				  <select class="select-subject" id="fruit" name="fruit">
				    	<option value="">-- 선택하세요 --</option>
				    <c:forEach var="dto" items="${userdetails.user.lectures }">
				    	<option value="">dto.subject</option>
				    </c:forEach> 
				</select>
			
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
			 
			  <label for="fruit"> 숙제번호 : </label>
				  <select class="select-subject" id="fruit" name="fruit">
				    <option value="">-- 선택하세요 --</option>
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
			 
			  <label for="fruit"> 학생이름 : </label>
				  <select class="select-subject" id="fruit" name="fruit">
				    <option value="">-- 선택하세요 --</option>
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
		<hr>
		<br><br><br><br><br>
		<div>
			<button class="btn-search">제출된 숙제 다운로드</button>
		</div>
		<div class="clear"></div>
		<br>
		<div>
			<label for="hw-score">숙제점수입력 : </label>
			<input class="select-subject" id="hw-score" type="text" placeholder="숙제점수를 입력하시오.">
			<button class="btn-search">채점된 숙제 업로드</button>
		</div>	
		<%-- 제출된 숙제 보기 (reading and downloading the homework uploaded by the student) --%>


</div>	
	
<%--------------------------------------------------------------------
								END 수강과목별 숙제제출한 학생검색 
--------------------------------------------------------------------%> 		
	
	
	
	
	
	
	
	
	
		 
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

<%--
<script>
//alert("Hello")
//alert(document.querySelector("#path-"+${loop.count }).getAttribute('action'))
			//document.querySelector("#path-"+${loop.count }).setAttribute('action', "/HwDownload"); 
//alert(document.querySelector("#path-"+${loop.count }).getAttribute('action'));
//alert(document.querySelector("#path-"+${loop.count}).getAttribute('id'));
//console.log(document.forms['patha'] )
//	console.log(document.querySelector("#path-"+${loop.count }).getAttribute('value'))
	//document.querySelector("#path-"+${loop.count }).setAttribute('value',"${listOfPaths.get("+${loop.count}+")}")
	//console.log("${listOfPaths.get("+${loop.count}+")}")
//console.log(document.querySelector("#path-"+${loop.count }).parentNode())
//console.log(document.querySelector('form[id="patha"] :nth-child(1)'));
//console.log(document.querySelector("#alksjdf :nth-child(1)"))
//alert($("#path-"+${loop.count}))
//let down = document.querySelector("#down-"+${loop.count });
//down.addEventListener("click",function(){
//	document.querySelector("#path-"+${loop.count }).submit();
</script>
 --%>
</html>