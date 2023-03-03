<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.FilmController" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상영과 정보 입력</title>

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
    <link rel="stylesheet" href="/assets/css/jquery.timepicker.css"/>

    <%
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        CinemaController cinemaController = new CinemaController(connectionMaker);
        FilmController filmController = new FilmController(connectionMaker);
        ArrayList<CinemaDTO> cinemaList = cinemaController.selectAll();
        ArrayList<FilmDTO> filmList = filmController.selectShow_0(); // 현재상영중인 영화선택
        TheaterDTO t = new TheaterDTO();
        SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");
        request.setCharacterEncoding("utf-8");
        pageContext.setAttribute("cinemaList", cinemaList);
        pageContext.setAttribute("filmList", filmList);
    %>
</head>
<body>
<%@include file="/layout/header.jsp" %>

<!-- Start Item Details -->
<section class="item-details section">

    <div class="container">
        <h3>상영정보 등록 페이지</h3>
        <div class="item-details-blocks">
            <div class="row">
                <div class="col-lg-12 col-md-5 col-12">
                    <div class="item-details-sidebar">
                        <!-- Start Single Block -->
                        <div class="single-block contant-seller comment-form ">
                            <form action="insert_logic.jsp" method="post">
                                <div class="row">
                                    <div class="col-2 cinema-input"><h3 class="fs-5">영화관 선택</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <select class="form-select " aria-label="Default select example"
                                                    onchange="insertTheaterNum(this)" id="cinemaSelectbox">
                                                <%--                                                <option selected>영화관을 선택해주세요</option>--%>
                                                <c:forEach var="c" items="${cinemaList}">
                                                    <option value="${c.id}">${c.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-2 cinema-input"><h3 class="fs-5">상영관 선택</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <select class="form-select " aria-label="Default select example"
                                                    id="theaterSelectbox" name="theater_id">
                                                <option selected value="0">상영관을 선택해주세요</option>

                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-2 cinema-input"><h3 class="fs-5">영화 선택</h3></div>

                                    <div class="col-10">
                                        <div class="form-box form-group">
                                            <select class="form-select " aria-label="Default select example"
                                                    id="filmSelectbox" onchange="getFilm_value()" name="film_id">
                                                <option selected value="1">영화를 선택해주세요</option>
                                                <c:forEach var="f" items="${filmList}">
                                                    <option value="${f.id}" value2="${f.length}"
                                                            name="film_id">${f.title}</option>
                                                </c:forEach>
                                            </select>
                                            <div id="film_id_div">

                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-2 cinema-input"><h3 style="font-size: 18px">상영시간 선택</h3></div>
                                    <div class="col-10">
                                        <div class="form-box form-group input-group mb-3">
                                            <%--                                            <input type="datetime-local" value="2022-02-22" name="time">--%>
                                            <h6>상영날짜 &nbsp&nbsp&nbsp&nbsp </h6> <input type="text" id="datepicker"
                                                                                       name="date"><br>    <h6>
                                            &nbsp&nbsp&nbsp&nbsp상영 시작시간 &nbsp&nbsp&nbsp&nbsp</h6> <input type="text"
                                                                                                         class="form-box form-group"
                                                                                                         id="timepicker1"
                                                                                                         name="time">
                                        </div>
                                    </div>


                                </div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block insertBt"
                                >등록하기
                                </button>
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
    let request = new XMLHttpRequest();

    function insertTheaterNum(id) {
        console.log(id.value)
        console.log("진입")
        console.log("CInema ID : " + id.value)
        let Cid = id.value;
        request.open("Post", "../TheaterServlet?id=" + Cid, true);
        request.onreadystatechange = searchProcess;
        console.log("request: " + request)
        request.send(null);
    }

    function searchProcess() {
        console.log("searchProcess 진입")
        console.log("searchProcess : request" + request.responseText)


        if (request.readyState == 4 && request.status == 200) {
            let selectDiv = document.getElementById("theaterSelectbox");
            selectDiv.innerHTML = "";
            selectDiv.innerHTML = "<option selected value='0'>상영관을 선택해주세요</option>";
            let temp = JSON.parse(request.responseText);
            let array = JSON.parse(temp.responseText);
            console.log(array)
            for (let i = 0; i < array.length; i++) {
                let option = document.createElement("option")
                option.id = array[i].id;
                option.value = array[i].number;
                option.innerText = array[i].number + "관           좌석 수 : " + array[i].scale + "석";

                selectDiv.appendChild(option);

            }
            window.onload = function () {
                searchFunction();

            }
        }
    }
</script>

<script>


    function setMinValue() {
        // console.log("111  " + dateElement.value.toLocaleDateString());
        console.log("222  " + nowDate.toLocaleDateString())
        console.log(typeof nowDate)
        if (dateElement.value < date) {
            alert('지난 날짜는 설정할 수 없습니다.');
            dateElement.value = date;
        }
    }
</script>

<script>
    function getFilm_value() {

        var id = $("#filmSelectbox > option:selected").attr("value");
        var length = $("#filmSelectbox > option:selected").attr("value2");

        console.log(id)
        console.log(length)

        let film_div = document.getElementById("film_id_div");
        film_div.innerHTML = "";
        let film_id = id;
        let film_length = length;
        let filmIdInput = document.createElement("input");
        let filmLengthInput = document.createElement("input");
        filmIdInput.type = "hidden";
        filmIdInput.value = film_id;
        filmIdInput.name = "film_id";
        filmLengthInput.type = "hidden";
        filmLengthInput.value = film_length;
        filmLengthInput.name = "film_length";
        film_div.appendChild(filmIdInput);
        film_div.appendChild(filmLengthInput);


    }
</script>
<link rel="stylesheet" href="/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">

<!-- Updated stylesheet url -->


<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>

<!-- Updated JavaScript url -->
<script src="//jonthornton.github.io/jquery-timepicker/jquery.timepicker.js"></script>

<script>


    $(function () {
        $("#datepicker").datepicker();
    });

    $(function () {
        $('#timepicker1').timepicker();
    });


</script>
</body>
</html>
