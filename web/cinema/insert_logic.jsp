<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="model.CinemaDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>film_insert</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    System.out.println("insertLogic!!!!!!!!!!!!");
    request.setCharacterEncoding("utf-8");
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);
    CinemaDTO c = new CinemaDTO();

    System.out.println("theaterNumberLen : " + request.getParameterValues("theaterNumber").length);
    System.out.println("location :" + request.getParameter("location"));
    System.out.println("title :" + request.getParameter("cinemaName"));


    String citySub = request.getParameter("location").substring(0, 3);
    System.out.println(citySub);

    int city_id = 0;
    if (request.getParameter("location").substring(0, 2).equals("서울")) {
        city_id = 1;
    } else if (request.getParameter("location").substring(0, 2).equals("경기")) {
        city_id = 2;
    } else if (request.getParameter("location").substring(0, 2).equals("인천")) {
        city_id = 3;
    } else if (request.getParameter("location").substring(0, 2).equals("강원")) {
        city_id = 4;
    } else if (request.getParameter("location").substring(0, 2).equals("대전") || request.getParameter("location").substring(0, 2).equals("충청")) {
        city_id = 5;
    } else if (request.getParameter("location").substring(0, 2).equals("대구")) {
        city_id = 6;
    } else if (request.getParameter("location").substring(0, 2).equals("부산") || request.getParameter("location").substring(0, 2).equals("울산")) {
        city_id = 7;
    } else if (request.getParameter("location").substring(0, 2).equals("경상")) {
        city_id = 8;
    } else {
        city_id = 10;
    }

    String cinemaRome = Integer.toString(request.getParameterValues("theaterNumber").length) + "관";

    c.setName(request.getParameter("cinemaName"));
    c.setNumber(request.getParameter("number"));
    c.setLocation(request.getParameter("location"));
    c.setCinemaRoom(cinemaRome);
    c.setCity_id(city_id);
    c.setArea(request.getParameter("location").substring(0, 2));


    cinemaController.insert(c);

%>
</body>
</html>
