<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 7:58
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

    System.out.println("update_logic_film");
    request.setCharacterEncoding("UTF-8");
    String filmId = request.getParameter("filmId");
    String title = request.getParameter("title");
    String summary = request.getParameter("summary");
    System.out.println("====" + filmId);

    FilmDTO f = new FilmDTO();
    f.setId(Integer.parseInt(filmId));
    f.setTitle(title);
    f.setSummary(summary);


    Boolean result = filmController.update(f);

    if (result) {
        response.sendRedirect("/film/film_admin.jsp");
    } else {
        System.out.println("실패");
    }
%>
</body>
</html>
