<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>영화 상영시간</title>
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

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<div class="row">
    <div class="contents index">


        <div class="reserve theater-list-box">
            <div class="tab-block tab-layer mb30" style="display: none;">
                <ul></ul>
            </div>
            <c:choose>
            <c:when test="${list.isEmpty()}">
                <div class="fs-4">상영정보가 존재하지 않습니다.</div>
            </c:when>
            <c:otherwise>
            <c:forEach var="r" items="${list}">
                <div class="theater-list">
                    <div class="theater-tit"><p class="movie-grade age-12"></p>
                        <p><a href="/film/detailsPage.jsp?id=${r.film_id}" title="movieTitle">${r.title}</a></p>
                        <p class="infomation"><span>상영중  </span> ${r.length} 분</p></div>
                    <div class="theater-type-box">
                        <div class="theater-type"><p class="theater-name">${r.number} 관</p>
                            <p class="chair">총 ${r.scale}석</p></div>
                        <div class="theater-time">
                            <div class="theater-type-area">${r.rating}</div>
                            <div class="theater-time-box">
                                <table class="time-list-table">
                                    <caption>상영시간을 보여주는 표 입니다.</caption>
                                    <tbody>
                                    <tr>
                                        <td class="" brch-no="1372" play-schdl-no="2302191372067"
                                            rpst-movie-no="22088100"
                                            theab-no="01" play-de="20230219" play-seq="3">
                                            <div class="td-ab">
                                                <div class="txt-center"><a href="" title="영화예매하기">
                                                    <div class="ico-box"><i class="iconset ico-off"></i></div>
                                                    <p class="time"><fmt:formatDate value="${r.startTime}"
                                                                                    pattern="M/dd HH : mm"/></p>
                                                    <p class="chair">${r.scale} 석</p>
                                                </a></div>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        </c:otherwise>
        </c:choose>

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
