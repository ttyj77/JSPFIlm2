<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


    <link rel="stylesheet" media="all" type="text/css" href="https://img.cgv.co.kr/R2014/css/layout.css"/>
    <link rel="stylesheet" media="all" type="text/css" href="https://img.cgv.co.kr/R2014/css/content.css"/>

    <script type="text/javascript" src="https://img.cgv.co.kr/R2014/js/jquery-1.10.2.min.js"></script>

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


    <!-- 홈페이지 CSS 일원화로 인한 반영 20220721 -->

    <!-- 각페이지 Header Start-->

    <!--<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">https, http  혼합사용시-->
    <script type="text/javascript" src="https://img.cgv.co.kr/R2014/js/swiper.min.js"></script>
    <link rel="stylesheet" media="all" type="text/css" href="https://img.cgv.co.kr/R2014/css/swiper-bundle.min.css"/>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#btnMovie").click(function () {
                $("#movieChart_list").show();
                $("#movieChart_list_Reser").hide();
                $("#btn_allView_Movie").attr("href", "/movies/?lt=1&ft=0");
            });

            $("#btnReserMovie").click(function () {
                $("#movieChart_list").hide();
                $("#movieChart_list_Reser").show();
                $("#btn_allView_Movie").attr("href", "/movies/pre-movies.aspx");
            });

            var movieChartSwiper = new Swiper("#movieChart_list", {

                slidesPerView: 5,
                spaceBetween: 32,
                slidesPerGroup: 5,
                loopFillGroupWithBlank: true,
                navigation: {
                    nextEl: ".swiper-button-next",

                    prevEl: ".swiper-button-prev",
                },
                a11y: {
                    prevSlideMessage: '이전 슬라이드',
                    nextSlideMessage: '다음 슬라이드',
                    slideLabelMessage: '총 {{slidesLength}}장의 슬라이드 중 {{index}}번 슬라이드 입니다.',
                },
            });


            if (eventSwiper.autoplay.running) {
                $('.btn_eventControl').addClass('active');
            }

            $('.btn_eventControl').on({
                click: function (e) {
                    if (eventSwiper.autoplay.running) {
                        $(this).removeClass('active');
                        eventSwiper.autoplay.stop();
                    } else {
                        $(this).addClass('active');
                        eventSwiper.autoplay.start();
                    }
                }
            });


            $('.movieChartBeScreen_btn_wrap a').on({
                click: function (e) {
                    var target = e.target;
                    $(target).addClass('active').parent('h3').siblings().children('a').removeClass('active');
                }
            });


            var movieSelectionVideoObj = $('.video_wrap video')[0];

            $('.video_wrap video').on({
                ended: function () {
                    $('.btn_movieSelection_playStop').removeClass('active');
                }
            })
            // movieSelectionVideoObj.onended = function(){

            // }

            $('.btn_movieSelection_playStop').on({
                click: function () {
                    if (movieSelectionVideoObj.paused) {
                        movieSelectionVideoObj.play();
                        $(this).addClass('active');
                    } else {
                        movieSelectionVideoObj.pause();
                        $(this).removeClass('active');
                    }
                }
            });


            $.fn.closePopup = function () {
                $('.pop_wrap').removeClass('active');
                $('.popup').fadeOut();
            };

        });
    </script>


</head>
<body>
<%@ include file="/layout/header.jsp" %>

<!-- Contaniner -->


<%
    //사용자가 로그인을 안했을경울 메인으로 튕기게
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");


    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController controller = new FilmController(connectionMaker);

    ArrayList<FilmDTO> list = controller.selectAll();
//          우리가 el 에서 변수를 접근하기위해 page, session 에 저장해야 불러올 수 있다.
    pageContext.setAttribute("list", list); //영화 전체 리스트
//            pageContext.setAttribute("userController", userController);
%>

<div id="contaniner" class=""><!-- 벽돌 배경이미지 사용 시 class="bg-bricks" 적용 / 배경이미지가 없을 경우 class 삭제  -->
    <input type="hidden" id="isOpenUserEmailYNPopup" name="isOpenUserEmailYNPopup" value="False"/>

    <div class="movieChartBeScreen_wrap">
        <div class="contents index">
            <div class="movieChartBeScreen_btn_wrap">
                <div class="tabBtn_wrap">
                    <h3><a href="film/filmShow_0.jsp" class="active" id="btnMovie">무비차트</a></h3>
                </div>
                <a href=film/filmShow_0.jsp id="btn_allView_Movie" class="btn_allView">전체보기</a>
            </div>

            <div class="swiper movieChart_list" id="movieChart_list">
                <div class="swiper-wrapper">
                    <c:forEach var="f" items="${list}">
                        <div class="swiper-slide swiper-slide-movie">
                            <div class="img_wrap index" data-scale="false">
                                <img src="${f.poster_image}"
                                     alt="앤트맨과 와스프-퀀텀매니아">
                                <div class="movieAgeLimit_wrap">
                                    <!-- 영상물 등급 노출 변경 2022.08.24 -->
                                    <i class="cgvIcon etc age12">12</i>
                                    <!-- <img src="https://img.cgv.co.kr/R2014/images/common/flag/age/12.png" alt="12세"> -->
                                    <!-- <div class='dDay_wrap'><span>1</span></div>-->
                                    <i class='cgvIcon etc ageDay' data-before-text='D - 1'>D Day</i>

                                </div>
                                <div class="screenType_wrap">

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/imax_white.png"
                                            alt="imax"></i>

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/forDX_white.png"
                                            alt="forDX"></i>

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/screenx_white.png"
                                            alt="screenx"></i>

                                </div>
                                <div class="movieChart_btn_wrap">
                                        <%--상세보기 링크넣기 --%>
                                    <a class="btn_movieChart_detail" href="/film/detailsPage.jsp?id=${f.id}">상세보기</a>



                                </div>
                            </div>
                            <div class="movie_info_wrap">
                                <strong class="movieName">${f.title}</strong>
                                <span> <img
                                        src='https://img.cgv.co.kr/R2014/images/common/egg/eggGoldeneggPreegg.png'
                                        alt='Golden Egg Preegg'> 99%</span>
                                <span>예매율 61.0%</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="swiper movieChart_list" id="movieChart_list_Reser">
                <div class="swiper-wrapper">
                    <c:forEach var="f" items="${list}">
                        <div class="swiper-slide swiper-slide-movie">
                            <div class="img_wrap" data-scale="false">
                                <img src="${f.poster_image}"
                                     alt="#" onerror="errorImage(this)">
                                <div class="movieAgeLimit_wrap">
                                    <!-- 영상물 등급 노출 변경 2022.08.24 -->
                                    <i class="cgvIcon etc age12">12</i>
                                    <!-- <img src="https://img.cgv.co.kr/R2014/images/common/flag/age/12.png" alt="12세"> -->
                                    <!-- <div class='dDay_wrap'><span>1</span></div>-->
                                    <i class='cgvIcon etc ageDay' data-before-text='D - 1'>D Day</i>

                                </div>
                                <div class="screenType_wrap">

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/imax_white.png"
                                            alt="imax"></i>

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/forDX_white.png"
                                            alt="forDX"></i>

                                    <i class="screenType"><img
                                            src="https://img.cgv.co.kr/R2014/images/common/logo/screenx_white.png"
                                            alt="screenx"></i>

                                </div>
                                <div class="movieChart_btn_wrap">
                                        <%--상세보기 링크넣기 --%>
                                    <a class="btn_movieChart_detail">상세보기</a>



                                </div>
                            </div>
                            <div class="movie_info_wrap">
                                <strong class="movieName">${f.title}</strong>
<%--                                <span> <img--%>
<%--                                        src='https://img.cgv.co.kr/R2014/images/common/egg/eggGoldeneggPreegg.png'--%>
<%--                                        alt='Golden Egg Preegg'> 99%</span>--%>
<%--                                <span>예매율 61.0%</span>--%>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <!-- E > 무비차트 | 상영예정작 -->
</div>
</body>
</html>