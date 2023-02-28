<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.UserController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 4:11
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
    UserController userController = new UserController(connectionMaker);

    System.out.println("levelUpRefer.jsp");
    request.setCharacterEncoding("UTF-8");
    String levelUpId = request.getParameter("levelUpId");
    System.out.println(levelUpId);

    userController.levelUpRefer(Integer.parseInt(levelUpId));

    response.sendRedirect("/user/levelUp.jsp");
%>
</body>
</html>
