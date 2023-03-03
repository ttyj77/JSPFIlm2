<%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-03-02
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
</head>
<body>
<script>


    $(function () {
        $("#datepicker").datepicker();
    });

    $(function() {
        $('#timepicker1').timepicker();
    });


</script>
<link rel="stylesheet" href="/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">

<!-- Updated stylesheet url -->
<link rel="stylesheet" href="//jonthornton.github.io/jquery-timepicker/jquery.timepicker.css">

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>

<!-- Updated JavaScript url -->
<script src="//jonthornton.github.io/jquery-timepicker/jquery.timepicker.js"></script>


<form method="post" action="makecleaningappt">
    What day would you like a cleaning?
    <input type="text" id="datepicker" name="date">What time would you like to start?
    <br>(example format: 3 pm)
    <input type="text" id="timepicker1" name="time">
</form>
</body>
</html>
