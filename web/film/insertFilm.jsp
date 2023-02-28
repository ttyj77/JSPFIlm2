<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <title>Admin-FilmInsert</title>
    <meta charset="utf-8"/>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>Ads Details - ClassiGrids Classified Ads and Listing Website Template</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
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
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    ReviewController reviewController = new ReviewController(connectionMaker);
    ActorController actorController = new ActorController(connectionMaker);
    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");

//        ReplyDTO r = replyController.selectOne(id); //여기서 아이디는 댓글아이디가 필요하다.
//    ArrayList<FilmDTO> list = filmController.selectAll(f.getId()); //댓글리스트
//    ReplyController replyController = new ReplyController(connectionMaker);

%>
<%--변수선언--%>

<%@include file="/layout/header.jsp" %>
<!-- Start Item Details -->
<section class="item-details section">

    <div class="container">
        <h3>영화 등록 페이지</h3>
        <form method="post" action="insert_logic.jsp" enctype="multipart/form-data">
            <div class="top-area">
                <div class="row">
                    <div class="col-lg-6 col-md-12 col-12">
                        <div class="product-images">
                            <main id="gallery">
                                <div class="main-img">
                                    <%--                                    <input>--%>
                                    <label class="input_label" id="current" alt="#" id="target_img">
                                        <%--                                        <form method="post" enctype="multipart/form-data" action="imgup.jsp">--%>
                                        <input type="file" name="poster_image" size=40 style="display: none"
                                               onchange="setThumbnail(event)">
                                        <input type="submit" value="업로드" style="display: none"><br><br>

                                        <%--                                        </form>--%>
                                        <div id="image_container">
                                            <%--                                            <img src="${f.poster_image}">--%>
                                        </div>

                                    </label>

                                </div>


                            </main>
                        </div>
                        <div class="row">


                        </div>
                    </div>

                    <div class="col-lg-6 col-md-12 col-12">
                        <div class="product-info">
                            <div class="text_row">
                                <label class="col-sm-3 col-form-label">영화제목</label>
                                <input type="text" class="form-control" placeholder="영화제목을 입력해주세요" name="title">
                            </div>
                            <div class="text_row">
                                <label class="col-sm-3 col-form-label fs-6">영화제목(영문)</label>
                                <input type="text" class="form-control" placeholder="영문이름을 입력해주세요 (생략가능)"
                                       name="english_title">
                            </div>

                            <div class="list-info">
                                <h4>Informations</h4>
                                <ul>
                                    <li style="display: flex; align-items: baseline; justify-content: space-between;">

                                        <h4 style="margin-right: 20px">감독</h4>
                                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                                data-target="#modaldirector" data-whatever="@mdo">등록하기
                                        </button>

                                        <%--              감독 모달 start                --%>
                                        <div class="modal fade" id="modaldirector" tabindex="-1" role="dialog"
                                             aria-labelledby="ModalLabel_director"
                                             aria-hidden="true">
                                            <div class="modal-dialog" role="document" id="modal_director">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="ModalLabel_director">감독 등록</h5>
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-label="Close">

                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group">
                                                            <label for="director-name" class="col-form-label">감독 이름을
                                                                입력해주세요</label>
                                                            <input type="text" class="form-control" id="director-name"
                                                                   onkeyup="searchDirector(this.value)">
                                                        </div>
                                                    </div>
                                                    <div class="modal-body" id="director_form">
                                                        <div class="form-group">

                                                        </div>
                                                    </div>
                                                    <div class="row actorButtonContainer" id="directorBT">


                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                                data-dismiss="modal">입력완료
                                                        </button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--감독모달 end--%>

                                        <%--              출연배우 모달 start                --%>
                                        <h4>출연배우</h4>

                                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                                data-target="#exampleModal" data-whatever="@mdo">등록하기
                                        </button>

                                        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                                             aria-labelledby="exampleModalLabel"
                                             aria-hidden="true">
                                            <div class="modal-dialog" role="document" id="modal_actor">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">배우등록</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group">
                                                            <label for="recipient-name" class="col-form-label">배우 이름을
                                                                입력해주세요</label>
                                                            <input type="text" class="form-control" id="recipient-name"
                                                                   onkeyup="searchActor(this.value)">
                                                        </div>
                                                    </div>
                                                    <div class="modal-body" id="actor_form">
                                                        <div class="form-group">

                                                        </div>
                                                    </div>
                                                    <div class="row actorButtonContainer" id="actorBT">


                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                                data-dismiss="modal">입력완료
                                                        </button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--출연배우 모달 end--%>

                                    </li>

                                    <br>
                                    <hr>

                                    <div class="row" style="--bs-gutter-y: 0.8rem">
                                        <div class="col-2 cinema-input"><h3 style="font-size: 14px">상영시간</h3></div>
                                        <div class="col-10">
                                            <div class="form-box form-group">
                                                <select class="form-select " aria-label="Default select example"
                                                        onchange="insertTheaterNum(this)" id="cinemaSelectbox">

                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-2 cinema-input"><h3 style="font-size: 14px">상영등급</h3></div>
                                        <div class="col-10">
                                            <div class="form-box form-group">
                                                <select class="form-select " aria-label="Default select example"
                                                        onchange="insertTheaterNum(this)" id="#">

                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <br>
                                    <hr>
                                    <li><span class="fw-bold fs-5">줄거리</span><br><br> <textarea class="form-control"
                                                                                                placeholder="줄거리를 입력해주세요"
                                                                                                rows="8"
                                                                                                name="summary"></textarea>
                                    </li>
                                </ul>

                            </div>
                            <div class="contact-info">
                                <button type="submit" class="btn btn-primary"
                                        style="height: 8%; width: 100%; margin-top: 1%; background-color: #5931E0">
                                    등록하기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <div class="item-details-blocks">
                <div class="row">
                    <div class="col-lg-12 col-md-5 col-12">
                        <div class="item-details-sidebar">
                            <!-- Start Single Block -->
                            <div class="single-block contant-seller comment-form ">

                            </div>
                        </div>
                    </div>
                </div>
        </form>
    </div>
</section>
<!-- End Item Details -->

<!-- Start Newsletter Area -->


<!-- Start Footer Area -->
<footer class="footer">
    <!-- Start Footer Top -->
    <div class="footer-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-12">
                    <!-- Single Widget -->
                    <div class="single-footer mobile-app">
                        <h3>Mobile Apps</h3>
                        <div class="app-button">
                            <a href="javascript:void(0)" class="btn">
                                <i class="lni lni-play-store"></i>
                                <span class="text">
                                        <span class="small-text">Get It On</span>
                                        Google Play
                                    </span>
                            </a>
                            <a href="javascript:void(0)" class="btn">
                                <i class="lni lni-apple"></i>
                                <span class="text">
                                        <span class="small-text">Get It On</span>
                                        App Store
                                    </span>
                            </a>
                        </div>
                    </div>
                    <!-- End Single Widget -->
                </div>


            </div>
        </div>
    </div>
    <!--/ End Footer Middle -->
    <!-- Start Footer Bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-12">
                        <div class="content">
                            <ul class="footer-bottom-links">
                                <li><a href="javascript:void(0)">Terms of use</a></li>
                                <li><a href="javascript:void(0)"> Privacy Policy</a></li>
                                <li><a href="javascript:void(0)">Advanced Search</a></li>
                                <li><a href="javascript:void(0)">Site Map</a></li>
                                <li><a href="javascript:void(0)">Information</a></li>
                            </ul>
                            <p class="copyright-text">Designed and Developed by <a href="https://graygrids.com/"
                                                                                   rel="nofollow" target="_blank">GrayGrids</a>
                            </p>
                            <ul class="footer-social">
                                <li><a href="javascript:void(0)"><i class="lni lni-facebook-filled"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="lni lni-twitter-original"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="lni lni-youtube"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="lni lni-linkedin-original"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Footer Middle -->
</footer>
<!--/ End Footer Area -->

<!-- ========================= scroll-top ========================= -->
<a href="#" class="scroll-top btn-hover">
    <i class="lni lni-chevron-up"></i>
</a>

<!-- ========================= JS here ========================= -->

<script src="/assets/js/modalScript.js"></script>


<form name="signform" method="POST" ENCTYPE="multipart/form-data" action="./design_update.htm">
    <input type="file" id="file" name="file" style="display:none;" onchange="changeValue(this)">
    <input type="hidden" name="target_url">
</form>
<%--포스터 이미지--%>
<script>
    function setThumbnail(event) {
        let reader = new FileReader();
        let imageDIV = document.getElementById("image_container")
        imageDIV.innerHTML = '';
        reader.onload = function (event) {
            let img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            document.querySelector("div#image_container").appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
    }

</script>
<script>
    function modalActorInfo() {

        let modalInfo = document.getElementById("modalActorList")
        console.log(modalInfo.value)
    }
</script>


</body>
</html>
