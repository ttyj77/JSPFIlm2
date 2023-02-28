<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.CinemaController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 8:45
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
    CinemaController controller = new CinemaController(connectionMaker);

    System.out.println("update_logic_cinema");
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String location = request.getParameter("location");
    String number = request.getParameter("number");
    System.out.println("====" + id);

    System.out.println("====" + name);
    System.out.println("====" + location);
    System.out.println("====" + number);


    CinemaDTO c = new CinemaDTO();
    c.setId(Integer.parseInt(id));
    c.setName(name);
    c.setLocation(location);
    c.setNumber(number);

    Boolean result = controller.update(c);

    if (result) {
        response.sendRedirect("/cinema/cinema_admin.jsp");
    } else {
        System.out.println("실패");
    }
%>
</body>
</html>
