
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 페이지</title>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>

</head>
<body>
<%@include file="/layout/header.jsp" %>
<div class="container">
    <h3 style="margin-top: 3%">관리자 메뉴</h3>
    <div class="contents" style="display: flex">
        <div class="card text-white bg-primary manageBt" style="background-color: #858c9659 !important;">
            <div class="card-header">회원관리</div>
            <div class="card-body">
                <button class="btn btn-primary innerTop" href="/#">회원 목록조회</button>
                <button class="btn btn-primary innerUnder"  onclick="location.href='/user/levelUp.jsp'">회원 등급변경</button>
            </div>
        </div>
        <div class="card text-white bg-primary manageBt" style="background-color: #858c9659 !important;">
            <div class="card-header">극장관리</div>
            <div class="card-body">
                <button class="btn btn-primary innerTop" onclick="location.href='/cinema/insertCinema.jsp'">극장 신규등록</button>
                <button class="btn btn-primary innerUnder" onclick="location.href='/cinema/cinema_admin.jsp'">극장 목록조회</button>
            </div>
        </div>
        <div class="card text-white bg-primary manageBt" style="background-color: #858c9659 !important;">
            <div class="card-header">상영정보관리</div>
            <div class="card-body">
                <button class="btn btn-primary innerTop" onclick="location.href='/theater/insertTheater.jsp'">상영정보 신규등록</button>
                <button class="btn btn-primary innerUnder">상영정보 목록조회</button>
            </div>
        </div>
        <div class="card text-white bg-primary manageBt" style="background-color: #858c9659 !important;">
            <div class="card-header">영화관리</div>
            <div class="card-body">
                <button class="btn btn-primary innerTop" onclick="location.href='/film/insertFilm.jsp'">영화 신규등록</button>
                <button class="btn btn-primary innerUnder" onclick="location.href='/film/film_admin.jsp'">영화 목록조회</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
