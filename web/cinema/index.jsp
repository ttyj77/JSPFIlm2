<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>상영관</title>

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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);
    SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 H:m:s");
    ArrayList<CinemaDTO> theaterList = cinemaController.selectAll();
    ArrayList<CinemaDTO> seoulList = cinemaController.selectCity(1);
    pageContext.setAttribute("seoulList", seoulList);
%>
<%--변수선언--%>
<c:set var="theaterList" value="<%=theaterList%>"/>
<c:set var="cinemaController" value="<%=cinemaController%>"/>

<%@include file="/layout/header.jsp" %>


<!-- End Breadcrumbs -->
<div class="inner-wrap">
    <h2 class="tit mt-40">전체극장</h2>
    <div class="theater-box" style="overflow: hidden; height: auto" id="theaterBox">
        <ul class="nav nav-pills mb-3 fs-4" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="1" data-bs-toggle="pill" data-bs-target="#pills-home"
                        type="button" role="tab" aria-controls="pills-home" aria-selected="true"
                        onclick="searchFunction(this.id); dynamicHeight()">
                    &nbsp&nbsp&nbsp서울&nbsp&nbsp&nbsp
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="2" data-bs-toggle="pill" data-bs-target="#pills-profile"
                        type="button" role="tab" aria-controls="pills-profile" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">
                    &nbsp&nbsp&nbsp경기&nbsp&nbsp&nbsp
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="3" data-bs-toggle="pill" data-bs-target="#pills-contact"
                        type="button" role="tab" aria-controls="pills-contact" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">
                    &nbsp&nbsp&nbsp인천&nbsp&nbsp&nbsp
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="4" data-bs-toggle="pill" data-bs-target="#pills-contact"
                        type="button" role="tab" aria-controls="pills-contact" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">대전/충청/세종
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="5" data-bs-toggle="pill" data-bs-target="#pills-contact"
                        type="button" role="tab" aria-controls="pills-contact" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">부산/대구/경상
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="6" data-bs-toggle="pill" data-bs-target="#pills-contact"
                        type="button" role="tab" aria-controls="pills-contact" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">
                    &nbsp&nbsp광주/전라&nbsp
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="7" data-bs-toggle="pill" data-bs-target="#pills-contact"
                        type="button" role="tab" aria-controls="pills-contact" aria-selected="false"
                        onclick="searchFunction(this.id); dynamicHeight()">
                    &nbsp&nbsp&nbsp&nbsp강원&nbsp&nbsp&nbsp&nbsp
                </button>
            </li>

        </ul>
        <div class="theater-list" id="divSize">
            <ul id="ajaxDiv">
                <c:forEach var="s" items="${seoulList}">
                    <li>
                        <a href="/cinema/detailsPage.jsp?id=${s.id}">
                                ${s.name}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>


    </div>

    <div class="tit-util mt100 mb15">
        <h3 class="tit">극장 공지사항</h3>
        <a href="/support/notice?ti=3" class="more" title="극장 공지사항 더보기">더보기 <i
                class="iconset ico-arr-right-gray"></i></a>
    </div>
    <%--    <div class="tit mt-100">--%>
    <%--        <h2 class="tit">극장 공지사항</h2>--%>
    <%--        <a href="/support/notice?ti=3" class="more" title="극장 공지사항 더보기">더보기 <i--%>
    <%--                class="iconset ico-arr-right-gray"></i></a>--%>
    <%--    </div>--%>

    <div class="table-wrap">
        <table class="board-list info_table">
            <caption>극장, 제목, 지역, 등록일이 들어간 극장 공지사항 목록</caption>
            <colgroup>
                <col style="width:150px;">
                <col>
                <col style="width:150px;">
                <col style="width:120px;">
            </colgroup>
            <thead class="info_thead">
            <tr>
                <th scope="col">극장</th>
                <th scope="col">제목</th>
                <th scope="col">지역</th>
                <th scope="col">등록일</th>
            </tr>
            </thead>
            <tbody class="info_tbody">


            <tr>
                <td>상암월드컵경기장</td>
                <th scope="row">
                    <a href="/support/notice/detail?artiNo=10780&bbsNo=9" title="[상암월드컵경기장]관람요금 변경 안내 상세보기">
                        [상암월드컵경기장]관람요금 변경 안내
                    </a>
                </th>
                <td>서울</td>
                <td>2023.02.15</td>
            </tr>


        </table>
    </div>

</div>
<script>
    // window.onload = function () {
    // // div height 설정
    // setDivHeight('divSize', 'theaterBox');
    // }
    function dynamicHeight(divMinHeight) {
        let tempDiv = document.getElementById("theaterBox");
        tempDiv.style.minHeight = divMinHeight + "px"
    }


</script>
<script>
    let request = new XMLHttpRequest();

    function searchFunction(id) {
        // request.open("Post", "../CinemaSearchServlet?cityId=" + encodeURIComponent(document.getElementById("cityId").value), true);
        request.open("Post", "../CinemaSearchServlet?cityId=" + id, true);
        request.onreadystatechange = searchProcess;
        console.log("request: " + request)
        request.send(null);
    }

    function searchProcess() {
        let DR1 = document.getElementById("ajaxDiv")
        DR1.innerHTML = "";
        console.log("searchProcess 진입")
        console.log("searchProcess : request" + request.responseText)


        if (request.readyState == 4 && request.status == 200) {

            let temp = JSON.parse(request.responseText);
            let array = JSON.parse(temp.responseText);

            for (let i = 0; i < array.length; i++) {
                let newDiv = document.createElement("li")
                let a_tag = document.createElement("a")
                a_tag.setAttribute("href", "/cinema/detailsPage.jsp?id="+array[i].id)

                a_tag.innerHTML = array[i].name
                newDiv.appendChild(a_tag);
                DR1.appendChild(newDiv);

            }

            temp = document.getElementById("divSize")
            console.log(temp.offsetHeight)
            let divMinHeight = temp.offsetHeight + 20;
            dynamicHeight(divMinHeight);

        }

        window.onload = function () {
            searchFunction();

        }
    }


</script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</body>
</html>
