
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃 로직</title>
</head>
<body>
<%
    session.invalidate();
    response.sendRedirect("/index.jsp");
    System.out.println("logOut ok");
%>
</body>
</html>
