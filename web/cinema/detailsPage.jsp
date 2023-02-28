<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.RunningTimeController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.TimeTableDTO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"
            integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD"
            crossorigin="anonymous"></script>

</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    RunningTimeController runningTimeController = new RunningTimeController(connectionMaker);
    CinemaController cinemaController = new CinemaController(connectionMaker);

    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");

    CinemaDTO t = cinemaController.selectOne(id); //여기서 id는 filmId

    System.out.println("id : " + id);
    ArrayList<TimeTableDTO> list = runningTimeController.selectRunningTable(id);
    System.out.println("list : " + list);
    pageContext.setAttribute("list", list);

%>

<%@ include file="/layout/header.jsp" %>

<div class="container">
    <ul class="nav nav-tabs tab" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button"
                    role="tab" aria-controls="home" aria-selected="true">극장정보
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button"
                    role="tab" aria-controls="profile" aria-selected="false">상영시간표
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button"
                    role="tab" aria-controls="contact" aria-selected="false">관람료
            </button>
        </li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
            <%@include file="detailsTheaterInfo.jsp" %>
            <%--    극장정보        --%>

        </div>
        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
            <%@include file="RunningTImePage.jsp" %>
        </div>
        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">ddddddddddddddd
        </div>
    </div>
</div>

<!-- ========================= JS here ========================= -->
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/wow.min.js"></script>
<script src="/assets/js/tiny-slider.js"></script>
<script src="/assets/js/glightbox.min.js"></script>
<script src="/assets/js/main.js"></script>
</body>

</html>
