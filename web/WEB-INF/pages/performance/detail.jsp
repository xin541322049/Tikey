<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/23
  Time: 上午12:29
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/spinner.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="/css/uikit.css">
    <link rel="stylesheet" href="/css/uikit-rtl.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
    <%--<script type="text/javascript" src="http://libs.useso.com/js/jquery/1.7.2/jquery.min.js"></script>--%>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.spinner.js"></script>
    <script src="/js/uikit.js"></script>
    <script src="/js/uikit-icons.js"></script>
</head>
<style>
    .price_button {
        background: white;
        border: 2px solid;
        border-radius: 20px;
        margin: 10px;
        color: #999999;
    }

    .price_button:hover,
    .price_button:focus {
        background: white;
        border: 2px solid rgb(253, 165, 114);
        border-radius: 20px;
        color: #fda572;
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
<body>

<nav class="navbar navbar-default navbar-static-top header">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand no-gap" href="/tikey?email=${member.email}" style="margin-right: 10px">
                <img alt="Brand" src="/img/Hollywood_Ticket_72px_548853_easyicon.net.jpg">
            </a>
            <h3 class="pure-menu-heading" style="margin: 15px;color: #666666">Tikey</h3>
            <%--<h3 class="pure-menu-heading" style="margin: 0px; padding: 0px">Tikey</h3>--%>
        </div>

        <div class="navbar-site">
            <div class="splitor"></div>
        </div>

        <div id="choose-city" class="nav navbar-nav">
            <li class="dropdown">
                <a href="/tikey/search?email=${email}&sort=0&city=${performance.showPlace.city}"
                   class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 18px">
                    <span class="city-chooser">${performance.showPlace.city}</span><b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=all">
                            全部城市
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=北京">
                            北京
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=上海">
                            上海
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=南京">
                            南京
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=杭州">
                            杭州
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=大连">
                            大连
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${email}&sort=0&city=武汉">
                            武汉
                        </a>
                    </li>
                </ul>
            </li>
        </div>

        <div id="search-area" class="nav navbar-nav">
            <form class="form-inline search-form" role="search" action="/tikey/search" method="post">
                <input class="search-input" placeholder="搜索演出、赛事" name="term"  required="required">
                <input value="${member.email}" name="email" hidden="hidden">
                <input value="0" name="sort" hidden="hidden">
                <button class="pure-button join-button">
                    <span class="glyphicon glyphicon-search search-text"></span>搜索
                </button>
            </form>
        </div>

        <ul id="visitor_nav" class="nav navbar-nav navbar-right">
            <c:if test="${member==null}">
                <li class="user-menu"><span data-toggle="modal" href="#registerModal">
                    <i class="fa fa-user-circle fa-2x"></i>
                        <span class="user-menu-text">注册</span>
                </span>
                </li>

                <li class="user-menu"><span data-toggle="modal" href="#logModal">
                    <i class="fa fa-sign-in fa-2x"></i><span class="user-menu-text">登录</span>
                </span></li>
            </c:if>

            <c:if test="${member.email.length()>0}">
                <li class="user-menu">
                    <span onclick="return addEmail();">
                        <i class="fa fa-user fa-2x"></i>
                        <span class="user-menu-text">我的</span>
                    </span>
                </li>
                <li class="user-menu">
                    <a href="${pageContext.servletContext.contextPath}/tikey" style="padding: 0">
                        <i class="fa fa-sign-out fa-2x"></i>
                        <span class="user-menu-text"> 退出</span>
                    </a>
                </li>
                <form action="/tikey/member/detail" id="email-form" method="post" hidden="hidden">
                    <input value="${member.email}" name="email">
                </form>
            </c:if>
        </ul>
    </div>
</nav>

<div class="container" style="margin-top: 100px;
    display: table;
    border-radius: 14px;
    background-color: #fff;
    box-shadow: 0 0 20px 0 #eee;
    margin-bottom: 60px;
    border: 1px solid #eee;
    height: 56%">
    <div style="margin-left: -100px" class="row">
        <div class="col-md-4">
            <div style="margin-left: 10%;margin-top: -10%" class="poster">
                <img class="img-rounded" src="${performance.posterUrl}">
            </div>
        </div>
        <div style="margin-top: 3%;margin-left: -3%" class="col-md-8">
            <div class="movie-info">
                <h2>${performance.name}
                    <small><br><br>${performance.showPlace.name}</small>
                </h2>
                <p>
                    ${fn:substring(performance.showTime,0,16)}<span class="split-symbol"> | </span>
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
                        <button style="background-image: none" class="pure-button price_button_active" id="stall"
                                onclick="selectPrice(${performance.stallPrice}, 'stall')">
                            ¥${performance.stallPrice}</button>
                        <c:if test="${performance.secondPrice>0}">
                            <button style="background-image: none" class="pure-button price_button" id="second"
                                    onclick="selectPrice(${performance.secondPrice}, 'second')">
                                ¥${performance.secondPrice}</button>
                        </c:if>
                        <c:if test="${performance.thirdPrice>0}">
                            <button style="background-image: none" class="pure-button price_button" id="third"
                                    onclick="selectPrice(${performance.thirdPrice}, 'third')">
                                ¥${performance.thirdPrice}</button>
                        </c:if>
                        <c:if test="${performance.fourthPrice>0}">
                            <button style="background-image: none" class="pure-button price_button" id="fourth"
                                    onclick="selectPrice(${performance.fourthPrice}, 'fourth')">
                                ¥${performance.fourthPrice}</button>
                        </c:if>
                    </div>
                    <c:if test="${email.length()>0}">
                        <button class="pure-button"
                                style="background: #fda572; color: white; margin-top: 10px; margin-right:10px;border-radius: 25px; font-size: 18px; box-shadow: 0 8px 16px 0 rgba(253,165,114,0.2), 0 6px 20px 0 rgba(253,165,114,0.19);width: 130px"
                                onclick="pickSeat()">
                            选座购买
                        </button>
                    </c:if>
                    <c:if test="${email.length()==0}">
                        <button class="pure-button"
                                style="background: #fda572; color: white; margin-top: 10px; margin-right:10px;border-radius: 25px; font-size: 18px; box-shadow: 0 8px 16px 0 rgba(253,165,114,0.2), 0 6px 20px 0 rgba(253,165,114,0.19);width: 130px"
                                onclick="javascript: alert('登录后才能购票，请先登录')">
                            选座购买
                        </button>
                    </c:if>
                    <c:if test="${!performance.distributed}">
                        <c:if test="${email.length()>0}">
                            <button class="pure-button"
                                    style="background: #fda572; color: white; margin-top: 10px; margin-right:10px;border-radius: 25px; font-size: 18px; box-shadow: 0 8px 16px 0 rgba(253,165,114,0.2), 0 6px 20px 0 rgba(253,165,114,0.19);width: 130px"
                                    data-toggle="modal" data-target="#numberModal">
                                直接购买
                            </button>
                        </c:if>
                        <c:if test="${email.length()==0}">
                            <button class="pure-button"
                                    style="background: #fda572; color: white; margin-top: 10px; margin-right:10px;border-radius: 25px; font-size: 18px; box-shadow: 0 8px 16px 0 rgba(253,165,114,0.2), 0 6px 20px 0 rgba(253,165,114,0.19);width: 130px"
                                    onclick="javascript: alert('登录后才能购票，请先登录')">
                                直接购买
                            </button>
                        </c:if>
                    </c:if>
                </c:if>
                <c:if test="${performance.state=='Completed'}">
                    <h3>演出已结束</h3>
                </c:if>
            </div>
        </div>
    </div>
</div>

<hr class="footer-border"/>

<div class="container">
    <footer class="footer-bottom">
        <p>&copy; Tikey, NJU Software Institute, 2018.</p>
    </footer>
</div>

<div class="modal fade center-modal" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-mid-size">
        <div class="modal-content">
            <div class="modal-header" style="border: 0">
                <button type="button" class="close  no-border" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="row modal-top" style="margin-bottom: -5px">
                <div class="col-md-offset-3 col-md-2">
                    <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg"
                         style="background-color: transparent; width: 50px">
                </div>
                <div class="col-md-3">
                    <h4 class="modal-title" id="logModalLabel" style="margin-top: 13px">会员登录</h4>
                </div>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" role="form" id="login-form" action="/tikey" onsubmit="return logIn()">
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2" id="member_check">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="input-group col-md-8 col-md-offset-2">
                            <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                            <input type="email" class="form-control" id="email" placeholder="邮箱地址" name="email"
                                   required="required">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2" id="password_check">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="input-group col-md-8 col-md-offset-2">
                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                            <input type="password" class="form-control" id="password" placeholder="区分大小写"
                                   name="password" required="required">
                        </div>
                    </div>
                    <%--<div class="form-group">--%>
                    <%--<div class="col-sm-offset-2 col-sm-8">--%>
                    <%--<div class="checkbox"><label><input type="checkbox" name="remember" id="remember">记住用户名</label></div>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-group row" style="margin-top: 30px">
                        <button type="submit" class="col-sm-8 col-sm-offset-2 pure-button login-button"
                                id="login_button">登录
                        </button>
                    </div>
                    <div class="form-group row" style="margin-top: 30px"></div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade center-modal" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog  modal-mid-size">
        <div class="modal-content">
            <div class="modal-header" style="border: 0">
                <button type="button" class="close no-border" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="row modal-top">
                <div class="col-md-offset-3 col-md-2">
                    <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg"
                         style="background-color: transparent; width: 50px">
                </div>
                <div class="col-md-3">
                    <h4 class="modal-title" id="registerModalLabel" style="margin-top: 13px">会员注册</h4>
                </div>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/tikey/member/register">
                    <div class="form-group row">
                        <div class="input-group col-md-8 col-md-offset-2" id="email_check">
                            <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                            <input type="email" class="form-control" id="emailRegister" placeholder="完整邮箱地址"
                                   name="email" required="required">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="input-group col-md-8 col-md-offset-2">
                            <span class="input-group-addon"><i class="fa fa-pencil-square-o fa-fw"></i></span>
                            <input type="text" class="form-control" id="nameRegister" placeholder="会员昵称"
                                   name="name" required="required">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="input-group col-md-8 col-md-offset-2">
                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                            <input type="password" class="form-control" id="passwordRegister" placeholder="密码至多20位"
                                   name="password" required="required">
                        </div>
                    </div>
                    <div class="form-group row" style="margin-top: 30px">
                        <button type="submit" class="col-sm-offset-2 col-sm-8 pure-button login-button" id="register_b">
                            注册
                        </button>
                    </div>
                    <div class="form-group row"></div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="numberModal" tabindex="-1" role="dialog" aria-labelledby="numberModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="numberModalLabel"><br>购买选择</h4>
            </div>
            <div class="modal-body">
                <label for="number" class="col-sm-2 control-label">购票数量</label>
                <div class="col-sm-8">
                    <input type="text" class="spinner" id="number" name="number" value="0"/>
                </div>
                <form class="form-horizontal" role="form">
                    <div class="form-group">

                    </div>
                    <%--<div class="form-group">--%>
                    <%--<label for="number" class="col-sm-2 control-label"></label>--%>
                    <%--<div class="col-sm-8">--%>
                    <%--<input type="text" class="spinner" id="memberEmail" name="memberEmail" placeholder="如是"/>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-group">
                        <div class="modal-body">
                            <button style="margin-left: 13px;width: 200px" id="select_coupon_icon" class="uk-button uk-button-default" type="button">选择优惠券</button>
                            <div uk-dropdown>
                                <ul class="uk-nav uk-dropdown-nav">
                                    <li><a href="#" onclick="setCouponId(-1, 0, '不使用')">不使用</a></li>
                                    <c:forEach items="${couponList}" var="coupon">
                                        <li><a href="#" onclick="setCouponId(${coupon.id}, ${coupon.discounts}, '${coupon.couponName}')">${coupon.couponName}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <p>总价为：¥<span id="total">0</span></p>
                    </div>
                    <div class="col-sm-8">
                        <p>享受 <span id="member_discounts"></span>折 会员折扣</p>
                    </div>
                    <div class="col-sm-8">
                        <p>折后价为：¥<span id="discounts">0</span></p>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <button type="button" class="pure-button"
                                    style="margin-right: -20%; float: right; background: #5987c9; color: white" onclick="confirmNumber()">
                                付款
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="purchaseModal" tabindex="-1" role="dialog" aria-labelledby="purchaseModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="purchaseModalLabel"><br>支付界面</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="pay-form" action="/tikey/performance/purchase"
                      method="post">
                    <div class="form-group">
                        <label for="account_name" class="col-sm-2 control-label">账户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="account_name" placeholder="请输入正确支付账户名"
                                   name="accountName" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">支付密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="accountPassword" placeholder="注意区分大小写"
                                   name="accountPassword" required="required">
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <p>支付总额为 ¥<span id="sum"></span></p>
                    </div>
                    <div class="col-sm-8">
                        <p>支付时间还剩 <span id="time"></span> 秒</p>
                    </div>
                    <div class="form-group">
                        <input type="text" id="pay_email" name="email" value="${email}" hidden="hidden">
                        <input type="text" id="id" name="id" value="${performance.id}" hidden="hidden">
                        <input type="text" id="type" name="type" hidden="hidden">
                        <input type="text" id="sumPrice" name="sum" hidden="hidden">
                        <input type="text" id="couponId" name="couponId" hidden="hidden">
                        <input type="text" id="pay_number" name="number" hidden="hidden">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <button type="button" class="pure-button" style="float: right; margin-left: 10px"
                                    onclick="clearTimer()">取消支付
                            </button>
                            <button type="button" class="pure-button"
                                    style="float: right; background: #5987c9; color: white" onclick="pay()">
                                确认支付
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script>
    var price = ${performance.stallPrice};
    var type = 'stall';
    var number = 0;
    var rank = [0.95, 0.9, 0.85, 0.8, 0.7];
    var discounts = 0;
    var sum = 0;
    var coupon = 0;
    var couponId = -1;

    $("#member_discounts").text(rank[${member.rank}] * 10)

    <%--$(function () {--%>
        <%--$("#coupon_select").change(--%>
            <%--function () {--%>
                <%--var myselect = document.getElementById("coupon_select");--%>
                <%--var index = myselect.selectedIndex;--%>
                <%--couponId = myselect.options[index].value;--%>
                <%--coupon = parseInt(myselect.options[index].getAttribute("name"));--%>
                <%--if (index == 0) {--%>
                    <%--discounts = sum * rank[${member.rank}];--%>
                <%--}--%>
                <%--else {--%>
                    <%--discounts = sum * rank[${member.rank}] - coupon;--%>
                <%--}--%>
                <%--$("#discounts").text(discounts);--%>
            <%--}); //end button2 click--%>
    <%--});--%>

    $("#number").spinner({
        max: 20,
        min: 0,
        value: 0
    });

    $(function () {
        $("#number").change(
            function () {
                number = $("#number").val();
                sum = price * number;
                discounts = sum * rank[${member.rank}] - coupon;
                var total_span = document.getElementById("total");
                $("#total").text(sum);
                $("#discounts").text(discounts);
            });
    });

    function logIn() {
        $.ajax({
            type: "POST",
            data: {'email': $("#email").val(), 'password': $("#password").val(), 'remember': $("#remember").val()},
            url: "/tikey/member/login/check",
            success: function (data) {
                if (data == "success") {
                    // window.location.href="/tikey/member/detail/"+$("#email").val();
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#logModal').modal('hide');
                    var form = document.getElementById("login-form");
                    form.submit();
                }
                if (data == "no member") {
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#member_check').append("<span id='member_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>用该邮箱注册用户不存在</span>");
                }
                if (data == "wrong password") {
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#password_check').append("<span id='password_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>密码错误</span>");
                }
                if (data == "canceled member") {
                    // $('#member_wrong').remove();
                    // $('#password_wrong').remove();
                    $('#logModal').modal('hide');
                    alert("对不起，该邮箱注册的会员已注销");
                }
            }
        });
        return false;
    }

    function addEmail() {
        var form = document.getElementById("email-form");
        form.submit();
        return false;
    }

    function selectPrice(val, t) {
        price = val;
        type = t;
        var active = document.getElementsByClassName("price_button_active");
        if (active.length > 0) {
            active.item(0).setAttribute("class", "pure-button price_button");
        }
        document.getElementById(t).setAttribute("class", "pure-button price_button_active");
    }

    function pickSeat() {
        window.location.href = "/tikey/performance/pickSeat?id=${performance.id}"
            + "&code=${performance.showPlace.stadiumCode}" + "&type=" + type + "&price=" + price
            + "&email=${email}";
    }

    function confirmNumber() {
        $("#numberModal").modal('hide');
        $("#sum").text(discounts);
        $('#purchaseModal').modal('show');
        showTime();
    }

    var t = 90;
    var timer;

    //显示倒数秒数
    function showTime() {
        t -= 1;
        document.getElementById('time').innerHTML = t;
        if (t == 0) {
            location.href = "/tikey/performance/cancel?id=${performance.id}&email=${email}";
        }
        //每秒执行一次,showTime()
        timer = setTimeout("showTime()", 1000);
    }

    function pay() {
        var payForm = document.getElementById("pay-form");
        $("#type").val(type);
        $("#sumPrice").val(sum);
        $("#couponId").val(couponId);
        $("#pay_number").val(number);

        payForm.submit();
    }

    function clearTimer() {
        t = 90;
        window.clearTimeout(timer);
        $("#purchaseModal").modal("hide");
    }

    function setCouponId(id, discount, name) {
        couponId = id;
        if(id!=0){
            discounts = discounts-parseInt(discount);
        }
        $("#select_coupon_icon").text(name);
        $("#total").text(sum - parseInt(discount));
        $("#discounts").text(discounts);
    }
</script>

</body>

</html>
