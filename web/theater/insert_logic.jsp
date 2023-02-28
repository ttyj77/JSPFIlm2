<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.UserDTO" %>
<%@ page import="model.RunningTimeDTO" %>
<%@ page import="controller.*" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-21
  Time: 오후 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상영정보 입력</title>


</head>
<body>

<%
    request.setCharacterEncoding("utf-8");
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    RunningTimeController runningTimeController = new RunningTimeController(connectionMaker);
    RunningTimeDTO r = new RunningTimeDTO();
//
//    try {
//
//    } catch (Exception e) {
//        e.printStackTrace();
//
//    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String time1 = formatter.format(dateFormat.parse(request.getParameter("time")));
    Timestamp time = Timestamp.valueOf(time1);

    System.out.println(request.getParameter("film_id"));
    System.out.println("3번   " + request.getParameter("time"));
    System.out.println(request.getParameter("theater_id"));
    r.setTheater_id(Integer.parseInt(request.getParameter("theater_id"))); //상영관 아이디를 넣으면 영화관은 자연스럽게 연결됨
    r.setFilm_id(Integer.parseInt(request.getParameter("film_id")));

    r.setTime(time);

    runningTimeController.insert(r);
    response.sendRedirect("/index.jsp");

%>


</body>

</html>
