<%@ page import="model.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>header</title>
</head>
<body>

<!-- Start Header Area -->
<header class="header navbar-area">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-12">
                <div class="nav-inner">
                    <nav class="navbar navbar-expand-lg">
                        <a class="navbar-brand" href="/index.jsp">
                            <img src="/assets/images/logo/filmLogo.png" alt="Logo">
                        </a>
                        <button class="navbar-toggler mobile-menu-btn" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                            <ul id="nav" class="navbar-nav ms-auto">
                                <li class="nav-item">
                                    <a class=" dd-menu collapsed" href="javascript:void(0)"
                                       data-bs-toggle="collapse" data-bs-target="#submenu-1-1"
                                       aria-controls="navbarSupportedContent" aria-expanded="false"
                                       aria-label="Toggle navigation">영화목록</a>
                                    <ul class="sub-menu collapse" id="submenu-1-1">
                                        <li class="nav-item"><a href="/film/filmAll.jsp">전체 영화목록</a></li>
                                        <li class="nav-item"><a href="/film/filmShow_0.jsp">현재 상영중인 영화목록</a></li>
                                        <li class="nav-item"><a href="/film/filmShow_1.jsp">상영 예정 영화목록</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="/cinema/index.jsp" class="active" aria-label="Toggle navigation">극장정보</a>
                                </li>



                            </ul>
                        </div> <!-- navbar collapse -->
                        <div class="login-button">
                            <ul>

                                <c:choose>
                                    <%--             로그인 안함                       --%>
                                    <c:when test="${logIn == null}">
                                        <li>
                                            <a href="/user/login.jsp"><i class="lni lni-enter"></i> Login</a>
                                        </li>
                                        <li>
                                            <a href="/user/register.jsp"><i class="lni lni-enter"></i> Register</a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>

                                        <li>
                                            <a href="/user/mypage.jsp"><i class="lni lni-enter"></i> Mypage</a>
                                        </li>
                                        <li>
                                            <form method="post" action="/user/logout_logic.jsp">
                                                <button class="logout_button"><i class="lni lni-enter"></i>logOut
                                                </button>
                                            </form>
                                        </li>

                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${logIn.role == 2}">
                                    <div class="button header-button">
                                        <a href="/user/managePageIndex.jsp" class="btn">관리자 페이지</a>
                                    </div>

                                </c:if>

                            </ul>
                        </div>

                    </nav> <!-- navbar -->
                </div>
            </div>
        </div> <!-- row -->
    </div> <!-- container -->
</header>
<!-- End Header Area -->

<!-- Start Breadcrumbs -->
<div class="breadcrumbs">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-6 col-12">
                <div class="breadcrumbs-content">
<%--                    <h1 class="page-title">Category</h1>--%>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-12">
<%--                <ul class="breadcrumb-nav">--%>
<%--                    <li><a href="index.html">Home</a></li>--%>
<%--                    <li>category</li>--%>
<%--                </ul>--%>
            </div>
        </div>
    </div>
</div>
<!-- End Breadcrumbs -->

</body>
</html>
