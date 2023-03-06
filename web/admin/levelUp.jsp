<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.LeverUpDTO" %>
<%@ page import="java.awt.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>등업 요청 페이지</title>
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
    UserController userController = new UserController(connectionMaker);
    ArrayList<LeverUpDTO> list = userController.selectRequestAll();
    pageContext.setAttribute("list", list);
    pageContext.setAttribute("userController", userController);
%>
<%@include file="/layout/header.jsp" %>
<div class="container">
    <h3 style="margin-top: 3%">등업요청 리스트</h3>
    <div class="contents">
        <table class="table">
            <thead>
            <tr>
                <th scope="col">회원번호</th>
                <th scope="col">닉네임</th>
                <th scope="col">현재등급</th>
                <th scope="col">요청등급</th>
                <th scope="col">등업승인</th>
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
                    <c:forEach var="l" items="${list}">
                        <tr>
                            <td>${l.user_id}</td>
                            <td>${userController.selectOne(l.user_id).nickname}</td>
                            <td>
                                <c:if test="${l.oldRole == 1}">
                                    일반회원
                                </c:if>
                                <c:if test="${l.oldRole == 2}">
                                    관리자
                                </c:if>
                                <c:if test="${l.oldRole == 3}">
                                    평론가
                                </c:if>

                            </td>
                            <td>
                                <c:if test="${l.newRole == 1}">
                                    일반회원
                                </c:if>
                                <c:if test="${l.newRole == 2}">
                                    관리자
                                </c:if>
                                <c:if test="${l.newRole == 3}">
                                    평론가
                                </c:if>
                            </td>
                            <td style="width: 200px">
                                <button class="btn btn-primary" style="margin-right: 10%" onclick="confirmMessage(${l.id})"> 승인
                                </button>
                                <button class="btn btn-primary"onclick="referMessage(${l.id})"> 반려</button>
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

    function confirmMessage(id) {
        console.log(id) //레벨업테이블 아이디
        let result = confirm("승인하시겠습니까?");
        console.log(result)
        if (result) {
            alert("승인이 완료되었습니다.")
            //요청리스트 아이디 + 회원아이디 를 가지고 레벨업테이블의 행을 삭제하고 유저테이블의 role을 newrole로 변경시킨다.

            let send = document.getElementById("send");
            let form = document.getElementById("form");
            let levelUpId = document.createElement("input");
            levelUpId.name = "levelUpId";
            levelUpId.value = id;
            levelUpId.style.display = "none";

            form.appendChild(levelUpId);
            form.action = "levelUp_confirm.jsp";
            form.mothod = "post";
            form.submit();

        } else {

        }
    }


    function referMessage(id) {
        console.log(id) //레벨업테이블 아이디
        let result = confirm("반려하시겠습니까?");
        console.log(result)
        if (result) {
            alert("처리가 완료되었습니다.")
            let send = document.getElementById("send");
            let form = document.getElementById("form");
            let levelUpId = document.createElement("input");
            levelUpId.name = "levelUpId";
            levelUpId.value = id;
            levelUpId.style.display = "none";

            form.appendChild(levelUpId);
            form.action = "levelUpRefer.jsp";
            form.mothod = "post";
            form.submit();

        } else {

        }
    }
</script>


</body>
</html>
