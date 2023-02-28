<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.CinemaController" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>update cinema</title>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);
    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");
    CinemaDTO ci = cinemaController.selectOne(id);
    request.setCharacterEncoding("utf-8");
%>
<%--변수선언--%>
<c:set var="ci" value="<%=ci%>"/>
<%@include file="/layout/header.jsp" %>
<!-- Start Item Details -->
<section class="item-details section">

    <div class="container">
        <h3>영화관 수정페이지</h3>
        <div class="item-details-blocks">
            <div class="row">
                <div class="col-lg-12 col-md-5 col-12">
                    <div class="item-details-sidebar">
                        <!-- Start Single Block -->
                        <div class="single-block contant-seller comment-form ">
                            <form action="updateCinema_logic.jsp" method="post">
                                <div class="row">
                                    <div class="col-1 cinema-input"><h3 class="fs-5">지점명</h3></div>
                                    <div class="col-11">
                                        <input type="hidden" value="${ci.id}" name="id">

                                        <div class="form-box form-group">
                                            <input type="text" class="form-control"
                                                   value="${ci.name}" style="font-size: 20px" name="name">
                                        </div>
                                    </div>
                                    <div class="col-1 cinema-input"><h3 class="fs-5">주소</h3></div>
                                    <div class="col-11">
                                        <div class="form-box form-group">
                                            <input type="text" class="form-control"
                                                   value="${ci.location}" style="font-size: 20px" name="location">
                                        </div>
                                    </div>
                                    <div class="col-1 cinema-input"><h3 class="fs-5">전화번호</h3></div>
                                    <div class="col-11">
                                        <div class="form-box form-group">
                                            <input type="text" class="form-control"
                                                   value="${ci.number}" style="font-size: 20px" name="number">
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-lg btn-block"
                                            style="margin-top: 3%">수정하기
                                    </button>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Item Details -->

</body>
</html>
