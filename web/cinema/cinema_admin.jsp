<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 7:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);
    ArrayList<CinemaDTO> list = cinemaController.selectAll();
    pageContext.setAttribute("list", list);
%>
<%@include file="/layout/header.jsp" %>
<div class="container">
    <h3 style="margin-top: 3%">영화관 리스트</h3>
    <div class="contents">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">상영관 번호</th>
                <th scope="col">이름</th>
                <th scope="col">위치</th>
                <th scope="col">수정여부</th>
            </tr>
            </thead>
            <c:choose>
                <c:when test="${list.isEmpty()}">
                    <div class="single-block comments">
                        <h4>아직 요청이 없습니다.</h4>
                    </div>
                </c:when>

                <c:otherwise>
                    <tbody>
                    <c:forEach var="c" items="${list}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.name}</td>
                            <td>
                                    ${c.location}
                            </td>

                            <td style="width: 200px">
                                <button class="btn btn-primary" style="margin-right: 10%"
                                        onclick="location.href='updateCinema.jsp?id=${c.id}'"> 수정
                                </button>
                                <button class="btn btn-primary" onclick="cinemaDelete(${c.id})"> 삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </c:otherwise>
            </c:choose>

        </table>
    </div>
    <form method="post" onsubmit="return false" id="form">

    </form>
</div>
<script>
    // function confirm() {
    //     confirm("승인하시겠습니까?");
    // }

    function cinemaDelete(id) {
        console.log(id) //레벨업테이블 아이디
        let result = confirm("삭제하시겠습니까?");
        console.log(result)
        if (result) {
            alert("삭제가 완료되었습니다.")
            //요청리스트 아이디 + 회원아이디 를 가지고 레벨업테이블의 행을 삭제하고 유저테이블의 role을 newrole로 변경시킨다.

            let send = document.getElementById("send");
            let form = document.getElementById("form");
            let deleteId = document.createElement("input");
            deleteId.name = "deleteId";
            deleteId.value = id;
            deleteId.style.display = "none";

            form.appendChild(deleteId);
            form.action = "cinemaDelete_logic.jsp";
            form.mothod = "post";
            form.submit();

        } else {

        }
    }


</script>
</body>
</html>
