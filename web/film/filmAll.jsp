<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-19
  Time: 오후 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전체영화목록</title>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
</head>
<body>
<%@include file="/layout/header.jsp" %>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");
    ArrayList<FilmDTO> list = filmController.selectAll();

%>
<%--변수선언--%>
<c:set var="list" value="<%=list%>"/>


<div class="container">
    <div class="content index">
        <%--       <ol class="poster-box">--%>
        <ul class="flex-container">
            <c:forEach var="f" items="${list}">

                <li>
                    <img src="${f.poster_image}" onclick="location.href='/film/detailsPage.jsp?id=${f.id}'">

                </li>

            </c:forEach>
        </ul>
    </div>

</div>


<!-- ========================= JS here ========================= -->
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/wow.min.js"></script>
<script src="/assets/js/tiny-slider.js"></script>
<script src="/assets/js/glightbox.min.js"></script>
<script src="/assets/js/main.js"></script>
<script type="text/javascript"></script>
</body>
</html>
