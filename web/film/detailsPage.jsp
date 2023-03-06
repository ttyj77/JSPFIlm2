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
    <title>영화 상세 페이지</title>
    <meta charset="utf-8"/>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>Ads Details - ClassiGrids Classified Ads and Listing Website Template</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- Place favicon.ico in the root directory -->


    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
    <link rel="stylesheet" href="/assets/css/star.css">


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>



    <script src="/assets/js/filmDetails.js"></script>
</head>
<body onload="initPage()">
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
                                <img id="film-poster">
                            </div>

                        </main>
                    </div>
                </div>

                <div class="col-lg-6 col-md-12 col-12">
                    <div class="product-info" style="margin-bottom: 10%">
                        <h2 class="title" id="film-title"></h2>
                        <input type="hidden" id="filmId">
                        <p class="location"><a id="e-title" href="javascript:void(0)"></a></p>
                        <div style="display: flex; justify-content: space-between;" id="rating_score_1">
                            <h5>관람객 평점</h5>
                            <div class="star-rating_3" id="starBox3">
                                <label class="star pr-4">★</label>
                            </div>
                        </div>
                        <div style="display: flex;     justify-content: space-between; margin-top: 2%"
                             id="rating_score_2">
                            <h5>평론가 평점</h5>
                            <div class="star-rating_3" id="starBox4">
                                <label class="star pr-4">★</label>
                            </div>
                        </div>
                        <div class="list-info">
                            <ul>

                                <br>

                                <li><span class="fw-bold fs-5" id="film-summary">줄거리</span><br><br></li>
                            </ul>
                        </div>

                    </div>

                </div>
            </div>
            <div class="item-details-blocks">
                <div class="row">
                    <div class="col-lg-8 col-md-7 col-12">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="margin-top: 7%;">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home"
                                        aria-selected="true">일반인 평점
                                </button>
                            </li>

                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-contact" type="button" role="tab"
                                        aria-controls="pills-contact" aria-selected="false">전문가 평점
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                 aria-labelledby="pills-home-tab">
                                <%--                     일반인 평점 출력--%>
                                <div class="wrap-star star_box" id="star_box2">
                                    <div class='star-rating' id="star-rating2">

                                    </div>
                                </div>
                            </div>
                            <%--전문가 평점 Start--%>
                            <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                 aria-labelledby="pills-contact-tab">
                                <%--            평점 평균                    --%>
                                <div class="wrap-star star_box" id="star_box3"
                                     style="margin-top: 4%; margin-bottom: 4%">
                                    <div class='star-rating' id="star-rating3">

                                    </div>
                                </div>
                                <div id="review-box">

                                </div>
                            </div>
                        </div>
                        <%--전문가 평점 end--%>
                    </div>

                    <!-- End Single Block -->
                    <div class="col-lg-4 col-md-5 col-12">
                        <div class="item-details-sidebar" id="item-sidebar">
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
                        <!-- Large modal -->


                        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true"
                             id="review1">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                    </div>
                                    <h5 style="text-align: center; margin-bottom: 2%"> 평점 입력하기</h5>
                                    <div class="star-rating_1 space-x-4 mx-auto" id="starBox">
                                        <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="5-stars" class="star pr-4">★</label>
                                        <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="4-stars" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="3-stars" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="2-stars" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="1-star" name="rating" value="1" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="1-star" class="star">★&nbsp &nbsp </label>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal" onclick="insertReply()">입력완료
                                        </button>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog"
                             aria-hidden="true" id="review2">
                            <div class="modal-dialog modal-sm">
                                <div class="modal-content">
                                    <div class="modal-header">
                                    </div>
                                    <h5 style="text-align: center; margin-bottom: 2%"> 평점 입력하기</h5>
                                    <div class="star-rating_2 space-x-4 mx-auto" id="starBox2">
                                        <input type="radio" id="5-stars2" name="rating" value="5" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="5-stars2" class="star pr-4">★</label>
                                        <input type="radio" id="4-stars2" name="rating" value="4" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="4-stars2" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="3-stars2" name="rating" value="3" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="3-stars2" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="2-stars2" name="rating" value="2" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="2-stars2" class="star">★&nbsp &nbsp </label>
                                        <input type="radio" id="1-star2" name="rating" value="1" v-model="ratings"
                                               onclick="starValue(this.value)"/>
                                        <label for="1-star2" class="star">★&nbsp &nbsp </label>
                                    </div>

                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="director-name" class="col-form-label fs-6">리뷰를
                                                입력해주세요</label>
                                            <textarea type="text" class="form-control" id="director-name"
                                                      dname="review"></textarea>
                                        </div>
                                    </div>
                                    <div class="row actorButtonContainer" id="directorBT">

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-dismiss="modal" onclick="insertReply()">입력완료
                                            </button>

                                        </div>
                                    </div>
                                </div>
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
            e.target.style.opacity = opacity;
        });
    });


</script>


<style>
    h2 {
        font-size: 15px;
    }

    .star-rating {
        width: 304px;
    }

    .star-rating, .star-rating span {
        display: inline-block;
        height: 55px;
        overflow: hidden;
        background: url("/assets/images/star.png") no-repeat;
    }

    .star-rating span {
        background-position: left bottom;
        line-height: 0;
        vertical-align: top;
    }

    .star-rating-review {
        display: flex;
        flex-direction: row-reverse;
        font-size: 2.25rem;
        line-height: 1.8rem;
        justify-content: space-around;
        padding: 0 0.2em;
        text-align: center;
        width: 5em;
    }


</style>
<script>
    function starValue(id) {
        console.log(id);
        let hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "score";
        hiddenInput.id = "score"
        hiddenInput.value = id;
        let starBox = document.getElementById("starBox");
        starBox.appendChild(hiddenInput);
    }

</script>
</body>
</html>
