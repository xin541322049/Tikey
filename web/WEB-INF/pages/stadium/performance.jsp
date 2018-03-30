<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/20
  Time: 下午3:52
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/blog.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/grids-responsive-min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
<body>

<style>
    .price_button{
        background: white;
        border: 2px solid;
        border-radius: 20px;
        margin: 10px;
    }
    .price_button:hover,
    .price_button:focus {
        background: white;
        border: 2px solid rgb(253, 165, 114);
        border-radius: 20px;
        margin: 10px;
    }
    .price_button_active {
        background: white;
        border: 2px solid rgb(253, 165, 114);
        border-radius: 20px;
        color: #fda572;
        margin: 10px;
    }
    .price_button_active:hover
    .price_button_active:focus {
        background: white;
        border: 2px solid rgb(253, 165, 114);
        border-radius: 20px;
        color: #fda572;
        margin: 10px;
    }

</style>

<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">${stadium.name}</h1>
            <%--<h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>--%>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performanceList?code=${stadium.stadiumCode}">返回</a>
                    </li>
                    <li class="nav-item">
                        <c:if test="${performance.state=='Sale'}">
                            <a class="pure-button"
                               href="/tikey/stadium/performance/checkTicket?code=${stadium.stadiumCode}&id=${performance.id}&ticketId=-1">
                                检票</a>
                        </c:if>
                        <c:if test="${performance.state!='Sale'}">
                            <a class="pure-button pure-button-disabled" href="">检票</a>
                        </c:if>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<div class="container" style="margin-left: 400px; width: 70%; margin-top: 80px">
    <div class="row">
        <div class="col-md-4">
            <div class="poster">
                <img class="img-thumbnail" src="${performance.posterUrl}">
            </div>
        </div>
        <div class="col-md-8">
            <div class="movie-info">
                <h2>${performance.name}<small> <br><br>${performance.showPlace.name}</small></h2>
                <p>
                    ${performance.showTime}<span class="split-symbol"> | </span>
                        <c:if test="${performance.type=='Concert'}">
                            演唱会
                        </c:if>
                        <c:if test="${performance.type=='Competition'}">
                            体育比赛
                        </c:if>
                        <c:if test="${performance.type=='Opera'}">
                            歌剧
                        </c:if>
                        <c:if test="${performance.type=='Circus'}">
                            马戏
                        </c:if>
                        <c:if test="${performance.type=='Drama'}">
                            话剧
                        </c:if>
                        <c:if test="${performance.type=='Dance'}">
                            舞蹈
                        </c:if>
                        <c:if test="${performance.type=='ChildPlay'}">
                            儿童亲子
                        </c:if>
                        <c:if test="${performance.type=='Music'}">
                            音乐会
                        </c:if>
                </p>
                <p>
                    ${performance.actors} 出演
                </p>
                <p>
                    ${performance.description}
                </p>
                <c:if test="${performance.state=='Sale'}">
                    <h3>现场购票</h3>
                    <div>
                        <label for="stall">选择票面：</label>
                        <button class="pure-button price_button_active" id="stall"
                                onclick="selectPrice('${performance.stallPrice}', 'stall')">
                            ¥${performance.stallPrice}</button>
                        <c:if test="${performance.secondPrice>0}">
                            <button class="pure-button price_button" id="second"
                                    onclick="selectPrice('${performance.secondPrice}', 'second')">
                                ¥${performance.secondPrice}</button>
                        </c:if>
                        <c:if test="${performance.thirdPrice>0}">
                            <button class="pure-button price_button" id="third"
                                    onclick="selectPrice('${performance.thirdPrice}', 'third')">
                                ¥${performance.thirdPrice}</button>
                        </c:if>
                        <c:if test="${performance.fourthPrice>0}">
                            <button class="pure-button price_button" id="fourth"
                                    onclick="selectPrice('${performance.fourthPrice}', 'fourth')">
                                ¥${performance.fourthPrice}</button>
                        </c:if>
                    </div>
                    <button class="pure-button" style="background: #fda572; color: white; margin-top: 20px; border-radius: 25px; font-size: 18px;box-shadow: 0 8px 16px 0 rgba(253,165,114,0.2), 0 6px 20px 0 rgba(253,165,114,0.19);width: 150px" onclick="pickSeat()">
                        选座购买</button>
                </c:if>
            </div>
        </div>
    </div>
    <c:if test="${performance.state=='BeingAccepted'}">
        <div class="row" style="margin-top: 50px">
            <div class="col-md-5"></div>
            <div class="col-md-7" style="color: #737373">
                <h3>演出申请审核中</h3>
            </div>
        </div>
    </c:if>
</div>
</body>

<script>
    var price = ${performance.stallPrice};
    var type = 'stall';

    function selectPrice(val, t){
        price=val;
        type = t;
        var active = document.getElementsByClassName("price_button_active");
        if (active.length>0) {
            active.item(0).setAttribute("class", "pure-button price_button");
        }
        document.getElementById(t).setAttribute("class", "pure-button price_button_active");
    }

    function pickSeat() {
        window.location.href="/tikey/stadium/performance/pickSeat?id="+"${performance.id}"
            +"&code="+"${stadium.stadiumCode}"+"&type="+type+"&price="+price;
    }
</script>

</html>
