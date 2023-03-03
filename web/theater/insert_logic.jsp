<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.UserDTO" %>
<%@ page import="model.RunningTimeDTO" %>
<%@ page import="controller.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %><%--
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

    r.setTheater_id(Integer.parseInt(request.getParameter("theater_id"))); //상영관 아이디를 넣으면 영화관은 자연스럽게 연결됨
    r.setFilm_id(Integer.parseInt(request.getParameter("film_id")));

    String strDate = request.getParameter("date") + "-" + request.getParameter("time");
    int length = Integer.parseInt(request.getParameter("film_length"));
    System.out.println(length);

    SimpleDateFormat dtFormat = new SimpleDateFormat("MM/dd/yyyy-h:mm");
    SimpleDateFormat newDtFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    // String 타입을 Date 타입으로 변환
    java.util.Date formatDate = dtFormat.parse(strDate);
    // Date타입의 변수를 새롭게 지정한 포맷으로 변환

    //시작시간
    String strNewDtFormat = newDtFormat.format(formatDate);
    System.out.println("포맷 전 : " + strDate);
    System.out.println("포맷 후 : " + strNewDtFormat);

    //종료시간 ex)상영시간 135분
    //135 / 60  -> 2 -- 나머지 : 15
    Calendar cal = Calendar.getInstance();
    cal.setTime(formatDate);
    cal.add(Calendar.MINUTE, length);
    String endTime = newDtFormat.format(cal.getTime());
    System.out.println(length + " 분후 : " + endTime);

    r.setStartTime(Timestamp.valueOf(strNewDtFormat));
    r.setEndTime(Timestamp.valueOf(endTime));

    runningTimeController.insert(r);
//    response.sendRedirect("/index.jsp");

%>


</body>

</html>
