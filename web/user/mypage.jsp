<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="model.UserDTO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>mypage</title>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="/assets/css/animate.css"/>
    <link rel="stylesheet" href="/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="/assets/css/main.css"/>
    <link rel="stylesheet" href="/assets/css/cgv.css"/>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/filmDetails.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
</head>
<body>

<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");


    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    } else {
        UserDTO u = userController.selectOne(logIn.getId());
        pageContext.setAttribute("u", u); //영화 전체 리스트
        System.out.println(u.getUsername());
    }

%>
<c:set var="logIn" value="<%=logIn%>"/>
<%@include file="/layout/header.jsp" %>

<!-- 회원정보 수정부분 -->
<section class="login section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-12">
                <div class="form-head" id="form-head">
                    <h4 class="title">Mypage</h4>
                    <form action="/update_logic" method="post" id="update_logic">
                        <!-- <input th:type="hidden" th:value="secret" name="secret_Key" /> -->
                        <div class="form-group">
                            <%--                            <label>회원번호</label>--%>
                            <input name="c_id" id="c_id" value="${u.id}" type="hidden"
                                   required="required" disabled/>

                        </div>
                        <div class="form-group">
                            <label>Id</label>
                            <input value="${u.username}" name="username" id="username" type="text" disabled/>
                        </div>

                        <div class="form-group">
                            <label>이름</label>
                            <input value="${u.name}" name="name" id="name" type="text"/>
                        </div>
                        <div class="form-group">
                            <label>닉네임</label>
                            <input value="${u.nickname}" name="nickname" id="nickname" type="text"/>
                        </div>
                        <label>회원등급</label>
                        <div class="form-group">
                            <c:choose>
                                <c:when test="${logIn.role == 1}">
                                    <input name="oldRole" id="oldRole" value="일반회원" type="text"
                                           required="required" disabled/>
                                </c:when>
                                <c:when test="${logIn.role == 2}">
                                    <input name="oldRole" id="oldRole" value="관리자" type="text"
                                           required="required" disabled/>
                                </c:when>
                                <c:otherwise>
                                    <input name="oldRole" id="oldRole" value="평론가" type="text"
                                           required="required" disabled/>
                                </c:otherwise>
                            </c:choose>

                        </div>


                    </form>
                    <c:choose>

                        <c:when test="${logIn.role!=2}">
                            <div style="display: flex; justify-content: center;">
                                <button id="request" type="submit" onclick="confirmLevelUp(this.id)" class="btn m-3"
                                        name="reviewer" style="border: solid black 1px "
                                >평론가 등업신청
                                </button>

                                <button id="admin" type="submit" class="btn m-3" onclick="confirmLevelUp(this.id)"
                                        name="reviewer" style="border: solid black 1px "
                                >관리자 등업요청

                                </button>
                            </div>
                        </c:when>
                    </c:choose>
                    <div style=" display: flex; justify-content: center">
                        <input type="button"
                               onclick="updateUser()"
                               value="회원정보 수정" class="btn-primary"
                               style="width: 100%; height: 55px !important; border-radius: 4px;">

                    </div>
                </div>

            </div>
        </div>
        <form method="post" onsubmit="return false" id="form">

        </form>
    </div>
</section>
<!-- 회원정보 수정 부분 끝 -->


<script>
    function confirmLevelUp(id) {
        let isExecuted = "";
        let num = 0;
        //일반회원 1
        //관리자 2
        //평론가 3
        console.log(this.c_id)
        console.log(this.oldRole)
        if (id === "admin") { //관리자 등업요청
            if (this.oldRole.value == "관리자") {
                alert("같은 등급으로는 요청이 불가능합니다.")
                location.reload()
            } else {
                isExecuted = confirm("관리자로 등업요청을 하시겠습니까?.");
                num = 2;
            }

        } else {
            if (this.oldRole.value == "평론가") {
                alert("같은 등급으로는 요청이 불가능합니다.")

                location.reload()
            } else {
                isExecuted = confirm("평론가로 등업요청을 하시겠습니까?.");
                num = 3;
            }
        }
        console.log(id)
        let sendData = {
            userId: this.c_id.value,
        }
        $.ajax({
            url: "/reply/checkRole",
            method: "get",
            data: sendData,
            success: (result) => {
                console.log("ajax 갔다옴")
                let response = JSON.parse(result);
                console.log(response.result)
                if (response.status == "success") {

                    if (isExecuted) {
                        alert("신청완료되었습니다.")
                        //회원아이디, 현재 등급 전송.

                        let form = document.getElementById("form");
                        let infoId = document.createElement("input");
                        let oldRole = document.createElement("input");
                        let newRole = document.createElement("input");
                        infoId.name = "id";
                        infoId.value = this.c_id.value;
                        infoId.style.display = "none";

                        oldRole.name = "oldRole";
                        oldRole.value = ${u.role};
                        oldRole.style.display = "none";


                        newRole.name = "newRole";
                        newRole.value = num;
                        newRole.style.display = "none";

                        form.appendChild(infoId);
                        form.appendChild(oldRole);
                        form.appendChild(newRole);
                        form.action = "leverUp_logic.jsp";
                        form.mothod = "post";
                        form.submit();
                    }
                } else if (response.status == "fail") {
                    let message = "";
                    if (response.result == 2) {
                        message = "이미 관리자로 등업을 요청하였습니다."
                    } else if (response.result == 3) {
                        message = "이미 평론가로 등업을 요청하였습니다."
                    }
                    Swal.fire({title: "에러메세지를 확인해주세요", text: message, icon: "error"})
                }
            }
        })


    }


</script>

<script>

    let updateUser = () => {
        let id = $('#c_id').val()
        let formData = {
            id: id,
            username: $('#name').val(),
            nickname: $('#nickname').val()
        }

        $.ajax({
            url: "/user/update",
            method: "post",
            data: formData,
            success: (response) => {
                let result = JSON.parse(response);
                console.log(result)
                Swal.fire({
                    icon: result.status,
                    text: result.message
                }).then(() => {
                    location.href = result.nextPath;
                })
            }
        })
        console.log(formData);
    }
</script>
</body>
</html>
