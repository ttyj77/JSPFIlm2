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
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg"/>
    <!-- Place favicon.ico in the root directory -->

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
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    ReviewController reviewController = new ReviewController(connectionMaker);
    ActorController actorController = new ActorController(connectionMaker);
    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");

    request.setCharacterEncoding("utf-8");
%>
<%--변수선언--%>

<%@include file="/layout/header.jsp" %>
<!-- Start Item Details -->
<section class="item-details section">

    <div class="container">
        <h3>영화관 등록 페이지</h3>
        <div class="item-details-blocks">
            <div class="row">
                <div class="col-lg-12 col-md-5 col-12">
                    <div class="item-details-sidebar">
                        <!-- Start Single Block -->
                        <div class="single-block contant-seller comment-form ">
                            <form action="insert_logic.jsp" method="post">
                                <div class="row">
                                    <div class="col-2 cinema-input"><h3 class="fs-5">지점명</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <input type="text" class="form-control form-control-custom"
                                                   placeholder="ex) 강남 비트컴퓨터점" name="cinemaName"/>
                                        </div>
                                    </div>
                                    <div class="col-2 cinema-input"><h3 class="fs-5">주소</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <input type="text" name="location"
                                                   class="form-control form-control-custom"
                                                   placeholder="ex) 서울특별시 서초구 서초대로74길 33"/>
                                        </div>
                                    </div>
                                    <div class="col-2 cinema-input"><h3 class="fs-5">전화번호</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <input type="text" name="number"
                                                   class="form-control form-control-custom"
                                                   placeholder="ex) 02-3486-1234"/>
                                        </div>
                                    </div>
                                    <div class="col-2 cinema-input"><h3 class="fs-5">상영관 정보</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group" id="box"
                                             style="display: flex; flex-wrap: wrap">

                                            <div style="display: flex">
                                                <div class="fs-5 innerFont"
                                                >
                                                    1관
                                                </div>
                                                <input type="text" class="form-control inputBox"
                                                       style="margin-right: 2%" name="theaterNumber" placeholder="좌석수 입력">
                                                <input class="btn btn-outline-secondary inputBT" type="button"
                                                       value="추가"
                                                       onclick="add_textbox()">
                                            </div>


                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-lg btn-block"
                                            style="margin-top: 3%">등록하기
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

<script>
    let num = 1;

    function add_textbox() {
        num++;
        let box = document.getElementById("box");
        let newInput_box = document.createElement('div');


        let ele = document.getElementById('box');
        let eleCount = ele.childElementCount; // 전체 노드 + 1
        newInput_box.style.display = 'flex';
        newInput_box.innerHTML = "<div class='fs-5 innerFont'>" + (eleCount + 1) + "관" + "</div><input type='text' name='theaterNumber' placeholder='좌석수 입력' class='form-control inputBox'  style='margin-right: 2%'><input class='btn btn-outline-secondary inputBT' type='button' value='삭제' onclick='remove(this,num)' style='margin-right: 1%'>";


        console.log("ele   " + eleCount)

        box.appendChild(newInput_box);

    }

    function remove(obj) {
        console.log("Num!! " + num)
        if (num == 0) {
            alert("마지막 컬럼은 삭제할 수 없습니다.")
        } else {
            num--;
            document.getElementById('box').removeChild(obj.parentNode);
            reNum(num);
        }
    }

    function reNum(num) {
        console.log("renum")
        console.log("num! " + num)
        let box = document.getElementById('box');
        box.innerHTML = "";
        let i = 0;
        for (i; i < num; i++) {
            if (i == 0) {
                console.log(i)
                let newInput_box = document.createElement('div');
                newInput_box.style.display = 'flex';
                newInput_box.innerHTML = "<div class='fs-5 innerFont'>" + (i + 1) + "관" + "</div><input type='text' name='theaterNumber' class='form-control inputBox'  placeholder='좌석수 입력' style='margin-right: 2%'><input class='btn btn-outline-secondary inputBT' type='button' value='추가' onclick='add_textbox()'>";
                console.log('Walking east one step');
                box.appendChild(newInput_box);
            } else {
                console.log(i)
                let newInput_box = document.createElement('div');
                newInput_box.style.display = 'flex';
                newInput_box.innerHTML = "<div class='fs-5 innerFont'>" + (i + 1) + "관" + "</div><input type='text' name='theaterNumber' class='form-control inputBox'  placeholder='좌석수 입력' style='margin-right: 2%'><input class='btn btn-outline-secondary inputBT' type='button' value='삭제' onclick='remove(this)' style='margin-right: 1%'>";
                console.log('Walking east one step');
                box.appendChild(newInput_box);
            }
        }
    }
</script>

<!-- ========================= scroll-top ========================= -->
<a href="#" class="scroll-top btn-hover">
    <i class="lni lni-chevron-up"></i>
</a>

<!-- ========================= JS here ========================= -->
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


<form name="signform" method="POST" ENCTYPE="multipart/form-data" action="./design_update.htm">
    <input type="file" id="file" name="file" style="display:none;" onchange="changeValue(this)">
    <input type="hidden" name="target_url">
</form>

<script>
    function setThumbnail(event) {
        s
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


</body>
</html>
