<%@ page import="model.LeverUpDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.UserController" %><%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-22
  Time: 오후 1:58
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

    request.setCharacterEncoding("UTF-8");
    String levelUpId = request.getParameter("levelUpId");
    System.out.println(levelUpId);

    Boolean result = userController.levelUpConfirm(Integer.parseInt(levelUpId));

    System.out.println("result : " + result);
    if (result) {
        response.sendRedirect("/user/levelUp.jsp");
    } else {
        System.out.println("false");
    }
%>
</body>
</html>
