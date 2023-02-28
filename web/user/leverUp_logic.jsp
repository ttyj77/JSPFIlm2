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

    System.out.println("leverUp_logic");
    request.setCharacterEncoding("UTF-8");
    String user_id = request.getParameter("id");
    String old_role = request.getParameter("oldRole");
    String new_role = request.getParameter("newRole");
    System.out.println(user_id);
    System.out.println(old_role);
    System.out.println(new_role);


    LeverUpDTO l = new LeverUpDTO();
    l.setUser_id(Integer.parseInt(user_id));
    l.setOldRole(Integer.parseInt(old_role));
    l.setNewRole(Integer.parseInt(new_role));


    Boolean result = userController.levelUp(l);

    if (result) {
        response.sendRedirect("/user/mypage.jsp");
    } else {
        System.out.println("실패");
    }
%>
</body>
</html>
