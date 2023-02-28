<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 7:28
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
    FilmController filmController = new FilmController(connectionMaker);

    System.out.println("delete_logic_film");
    request.setCharacterEncoding("UTF-8");
    String filmId = request.getParameter("deleteId");
    System.out.println("===="+filmId);

    Boolean result = filmController.delete(Integer.parseInt(filmId));

    if (result) {
        response.sendRedirect("/film/film_admin.jsp");
    } else {
        System.out.println("실패");
    }
%>
</body>
</html>
