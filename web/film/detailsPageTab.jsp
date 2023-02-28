<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="controller.ActorController" %>
<%@ page import="model.ActorDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8"/>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>Ads Details - ClassiGrids Classified Ads and Listing Website Template</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg"/>
    <!-- Place favicon.ico in the root directory -->

    <!-- Web Font -->
    <link
            href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/filmDetails.js"></script>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    ReviewController reviewController = new ReviewController(connectionMaker);
    ActorController actorController = new ActorController(connectionMaker);
    FilmDTO f = filmController.selectOne(id); //여기서 id는 filmId
    ArrayList<ReviewDTO> list = reviewController.selectOneReviewList(id);
    ArrayList<ActorDTO> actorList = actorController.actorList(id);

    System.out.println("length: " + actorList.size());


    double temp = reviewController.avgReview(id);
    double averageReview = Math.round(temp * 100) / 100;
    int reviewCount = reviewController.reviewCount(id);

    pageContext.setAttribute("reviewCount", reviewCount);
    pageContext.setAttribute("averageReview", averageReview);

%>
<%--변수선언--%>
<c:set var="f" value="<%=f%>"/>
<c:set var="list" value="<%=list%>"/>
<c:set var="actorList" value="<%=actorList%>"/>
<%@include file="/layout/header.jsp" %>
<!-- Start Item Details -->
<section class="item-details section">
    <div class="container">
        <div class="top-area">
            <div class="row">
                <div class="col-lg-6 col-md-12 col-12">
                    <div class="product-images">
                        <main id="gallery">
                            <div class="main-img">
                                <img src="${f.poster_image}" id="current" alt="#">
                            </div>

                        </main>
                    </div>
                </div>

                <div class="col-lg-6 col-md-12 col-12">
                    <div class="product-info" style="margin-bottom: 10%">
                        <h2 class="title">${f.title}</h2>
                        <input type="hidden" id="filmId" value="${f.id}">
                        <p class="location"><a href="javascript:void(0)">${f.english_title}</a></p>

                        <h4 class="col-4">관람객 평점</h4>
                        <div class="row">
                            <h3>${averageReview}</h3>
                            <%--                            <img src="/assets/images/star-32.pmg" style="width:50px; height: 30px">--%>

                        </div>
                        <div class="list-info">
                            <ul>

                                <br>

                                <li><span class="fw-bold fs-5">줄거리</span><br><br> ${f.summary}</li>
                            </ul>
                        </div>

                    </div>
                    <%@include file="/reply2/star_user.jsp" %>
                </div>
            </div>
            <div class="item-details-blocks">
                <div class="row">
                    <div class="col-lg-8 col-md-7 col-12">

                        <c:choose>
                            <c:when test="${list.isEmpty()}">
                                <div class="single-block comments">
                                    <h4>${f.title}에 대한 리뷰가 아직 없어요!</h4>
                                    <div class="single-comment">
                                        <div class="row">
                                            <p>
                                                <button class="btn btn-primary" href="#">지금 등록하러 가기</button>
                                            </p>
                                        </div>
                                    </div>

                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Start Single Block -->
                                <div class="single-block comments">
                                    <h4>${f.title}에 대한 리뷰가 ${reviewCount} 개 있어요!</h4>
                                    <!-- Start Single Comment -->
                                    <div class="single-comment">
                                        <c:forEach var="r" items="${list}">
                                            <div class="row">
                                                <div class="col-1_5">
                                                    <h1>${r.score} </h1>
                                                </div>
                                                <div class="col-10 content">
                                                    <h4>${r.nickname}</h4>
                                                    <p class="m-3">
                                                            ${r.review}
                                                    </p>
                                                </div>
                                            </div>
                                        </c:forEach>

                                    </div>
                                    <!-- End Single Comment -->
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- End Single Block -->

                    </div>

                    <div class="col-lg-4 col-md-5 col-12">
                        <div class="item-details-sidebar">
                            <!-- Start Single Block -->
                            <div class="single-block author">
                                <h3>Director & Actor</h3>

                                <c:choose>
                                    <c:when test="${actorList.isEmpty()}">

                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="a" items="${actorList}">
                                            <div class="content mb-4">
                                                <img src="${a.image}"
                                                     alt="#">
                                                <h4>${a.name}</h4>
                                                <span>${a.casting}</span>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>


                            </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- End Item Details -->


<!-- ========================= scroll-top ========================= -->
<a href="#" class="scroll-top btn-hover">
    <i class="lni lni-chevron-up"></i>
</a>

<!-- ========================= JS here ========================= -->
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/wow.min.js"></script>
<script src="/assets/js/tiny-slider.js"></script>
<script src="/assets/js/glightbox.min.js"></script>
<script src="/assets/js/main.js"></script>
<script type="text/javascript">
    const current = document.getElementById("current");
    const opacity = 0.6;
    const imgs = document.querySelectorAll(".img");
    imgs.forEach(img => {
        img.addEventListener("click", (e) => {
            //reset opacity
            imgs.forEach(img => {
                img.style.opacity = 1;
            });
            current.src = e.target.src;
            //adding class
            //current.classList.add("fade-in");
            //opacity
            e.target.style.opacity = opacity;
        });
    });
</script>
</body>
</html>
