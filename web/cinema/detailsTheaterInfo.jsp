<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="dbConn.MysqlConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-20
  Time: 오후 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <!-- ========================= CSS here ========================= -->
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

<c:set var="t" value="<%=t%>"/>
</body>
<div class="container">
    <div class="contents">

        <div class="fs-3 info-box">${t.name}</div>
        <div class="T-information">
            <div class="row">
                <div class="T-info-content">
                    <span>총 상영관 수 : </span>
                    ${t.cinemaRoom}&nbsp&nbsp&nbsp
                    <span>총 좌석수</span>
                    ${t.roomScale}
                </div>
            </div>
            <div class="row" style="flex-wrap: nowrap">
                <div class="T-info-content">
                    <span>주소 : </span>
                    ${t.location}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    <span>전화번호 : </span>
                    ${t.number}
                </div>
            </div>
        </div>
    </div>
</div>
</html>
