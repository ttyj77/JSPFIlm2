<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>star</title>
</head>

<body>
<h4>별점입력</h4>

<style>
    h2 {
        font-size: 15px;
    }

    .star-rating {
        width: 304px;
    }

    .star-rating, .star-rating span {
        display: inline-block;
        height: 55px;
        overflow: hidden;
        background: url("/assets/images/star.png") no-repeat;
    }

    .star-rating span {
        background-position: left bottom;
        line-height: 0;
        vertical-align: top;
    }
</style>


<div class="wrap-star" id="star_box">
    <h2>Width="90%"</h2>
    <div class='star-rating' id="star-rating">
        <span style="width:23.3%"></span>
    </div>
</div>

</body>
</html>
