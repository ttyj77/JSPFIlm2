<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);

    System.out.println("delete_logic");
    request.setCharacterEncoding("UTF-8");
    String cinemaId = request.getParameter("deleteId");
    System.out.println(cinemaId);

    Boolean result = cinemaController.delete(Integer.parseInt(cinemaId));

    if (result) {
        response.sendRedirect("/cinema/cinema_admin.jsp");
    } else {
        System.out.println("실패");
    }
%>
</body>
</html>
