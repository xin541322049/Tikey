<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/27
  Time: 下午11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我与Tikey的故事</title>
    <link rel="stylesheet" href="/css/rotating-slider.css">
    <style>
        body{background: url("/img/ostap-senyuk-443230-unsplash.jpg"); }
        li{
            opacity: 1;
        }
        .rotating-slider ul.slides li:nth-of-type(1){background: #3498db;}
        .rotating-slider ul.slides li:nth-of-type(2){background: url('/img/car-oldtimer-snow-342-825x550.jpg');}
        .rotating-slider ul.slides li:nth-of-type(3){background: #e74c3c;}
        .rotating-slider ul.slides li:nth-of-type(4){background: url('/img/analog-camera-old-olympus-om-10-1528-825x550.jpg');}
        .rotating-slider ul.slides li:nth-of-type(5){background: #f1c40f;}
        .rotating-slider ul.slides li:nth-of-type(6){background: url('/img/bridge-city-night-645-827x550.jpg');}
        .rotating-slider ul.slides li:nth-of-type(7){background: #fda572;}
        .rotating-slider ul.slides li:nth-of-type(8){background: url('/img/edited.jpg');}
    </style>
</head>
<body>
<div class="container">
    <div class="rotating-slider">
        <ul class="slides">
            <li>
                <div class="inner">
                    <h2>Tikey真的非常开心</h2>
                    <p>您在Tikey一共购买了 <strong>${totalTicketNumber}</strong> 张演出门票</p>
                </div>
            </li>
            <li>
                <div class="inner"></div>
            </li>
            <li>
                <div class="inner">
                    <h2>Tikey很荣幸能为您的生活添彩</h2>
                    <p>从相识开始，您已经通过Tikey观看了 <strong>${totalUsedTicket}</strong> 场演出</p>
                </div>
            </li>
            <li>
                <div class="inner">
                </div>
            </li>
            <li>
                <div class="inner">
                    <h2>请继续支持Tikey，Tikey不会让您失望的</h2>
                    <p>您一共在Tikey消费了 <strong>¥${totalConsumeAmount}</strong>元</p>
                    <p><small>Now touch & drag friendly!</small></p>
                </div>
            </li>
            <li>
                <div class="inner">
                </div>
            </li>
            <li>
                <div class="inner">
                    <h2>Tikey会努力变得更好</h2>
                    <p>您通过Tikey成功退款共 <strong>¥${totalRefundAmount}</strong>元</p>
                </div>
            </li>
            <li>
                <div class="inner">
                </div>
            </li>
        </ul>
    </div>
</div>

<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
<script src="/js/jquery.rotating-slider.js"></script>
<script>
    $(function(){
        $('.rotating-slider').rotatingSlider();
    });
</script>
</body>
</html>
