<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>회원가입</title>
</head>

<body style="margin-bottom: 200px">
	<br><br><br><br><br><br><br><br><br><br><br><br><br> 
    <div class="container mt-3">

        <div class="row mt-5">
            <div class="col-12 text-center">
                <h1>회원가입</h1>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12 text-danger">
                ${error }
            </div>
        </div>
        <div class="row">
            <form method="POST" action="${pageContext.request.contextPath}/user/registerbyuser">
                <div class="form-group mt-3">
                    <label for="username">사용자 아이디</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="사용자아이디" value="${username }" required >
                </div>
                <div class="form-group mt-3">
                    <label for="name">사용자 이름</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="사용자 이름" value="${name }" required >
                </div>
                <div class="form-group mt-3">
                    <label for="password">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required >
                </div>
                <div class="form-group mt-3">
                    <label for="re-password">비밀번호 확인</label>   <%-- binding 을 위해 hyphen 사용 자제 --%>
                    <input type="password" class="form-control" id="re_password" name="re_password" placeholder="비밀번호 확인" required >
                </div>
                <button type="submit" class="w-100 btn btn-lg btn-primary mt-3">등록</button>
                <a class="w-100 btn btn-lg btn-primary my-1" href="${pageContext.request.contextPath}/home">홈</a>
            </form>
        </div>

    </div>
    
</body>
</html>
