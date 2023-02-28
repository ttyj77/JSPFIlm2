<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>film update</title>
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
    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    FilmDTO f = filmController.selectOne(id); //여기서 id는 filmId

%>
<%--변수선언--%>
<c:set var="f" value="<%=f%>"/>
<%--<c:set var="selectOne" value="<%=userController.selectOne(b.getWriterId())%>"/>--%>
<%@include file="/layout/header.jsp" %>
<section class="item-details section">
    <div class="container">
        <div class="top-area">
            <form action="updateFilm_logic.jsp" method="post">
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
                        <div class="product-info">
                            <%--                        <h2 class="title">${f.title}</h2>--%>
                            <input type="hidden" value="${f.id}" name="filmId">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="" aria-label=""
                                       aria-describedby="basic-addon1" value="${f.title }" style="font-size: 20px" name="title">
                            </div>

                            <div class="list-info">
                                <ul>

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
                                    예매하기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
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
