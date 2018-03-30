<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/22
  Time: 下午11:49
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/home.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top header" role="navigation" style="padding-left: 20px; padding-right: 20px">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img alt="Brand" src="/img/viking_ship_72px_1209600_easyicon.net.ico">
        </a>
        <div class="navbar-header">
            <h1 class="pure-menu-heading">Tikey</h1>
        </div>
        <div style="padding-top: 17px" id="nav_body">
            <ul class="nav navbar-nav" style="padding-top: 15px">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        南京<b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">北京</a></li>
                        <li><a href="#">上海</a></li>
                        <li><a href="#">杭州</a></li>
                        <li class="divider"></li>
                        <li><a href="#">大连</a></li>
                        <li><a href="#">武汉</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-left search" role="search" action="/tikey/search">
                <div class="form-group">
                    <input type="text" class="search-input" placeholder="Search" name="term">
                </div>
                <button type="submit" class="pure-button join-button">搜索</button>
            </form>
            <ul class="nav navbar-nav navbar-right navbar-light" id="visitor_nav">
                <c:if test="${member.email.length()>0}">
                    <%--<li style="margin-top: 25px; margin-left: 15px">Welcome ${member.name}!</li>--%>
                    <li><a  href="${pageContext.servletContext.contextPath}/tikey/member/detail" onclick="return addEmail();">
                        <span class="glyphicon glyphicon-user"></span> 我的</a>
                    </li>
                    <li><a href="${pageContext.servletContext.contextPath}/tikey">
                        <span class="glyphicon glyphicon-log-in"></span> 退出</a>
                    </li>
                    <form action="/tikey/member/detail" hidden="hidden" id="email-form">
                        <input value="${member.email}" name="email">
                    </form>
                </c:if>
                <c:if test="${member==null}">
                    <li><a data-toggle="modal" href="#registerModal"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
                    <li><a data-toggle="modal" href="#logModal"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-top: 130px">
    <c:if test="${result.size()==0}">
        <h2>哎呀，目前还没有这个演出哦～返回<a href="/tikey">首页</a>看看别的演出叭，也很精彩呢！</h2>
    </c:if>
    <c:forEach items="${result}" var="performance">
        <div class="row" style="margin: 30px">
            <div class="col-md-4">
                <div class="poster" style="max-height: 350px; max-width: 200px">
                    <img class="img-thumbnail" src="${performance.posterUrl}">
                </div>
            </div>
            <div class="col-md-8">
                <div class="movie-info">
                    <h2>
                        <a href="/tikey/performance/detail/${performance.id}?email=${email}">${performance.name}</a>
                        <small> <br><br>${performance.showPlace.name}</small>
                    </h2>
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
                    <%--<h3>现场购票</h3>--%>
                    <%--<div>--%>
                        <%--<label for="stall">选择票面：</label>--%>
                        <%--<button class="pure-button price_button_active" id="stall"--%>
                                <%--onclick="selectPrice('${performance.stallPrice}', 'stall')">--%>
                            <%--¥${performance.stallPrice}</button>--%>
                        <%--<c:if test="${performance.secondPrice>0}">--%>
                            <%--<button class="pure-button price_button" id="second"--%>
                                    <%--onclick="selectPrice('${performance.secondPrice}', 'second')">--%>
                                <%--¥${performance.secondPrice}</button>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${performance.thirdPrice>0}">--%>
                            <%--<button class="pure-button price_button" id="third"--%>
                                    <%--onclick="selectPrice('${performance.thirdPrice}', 'third')">--%>
                                <%--¥${performance.thirdPrice}</button>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${performance.fourthPrice>0}">--%>
                            <%--<button class="pure-button price_button" id="fourth"--%>
                                    <%--onclick="selectPrice('${performance.fourthPrice}', 'fourth')">--%>
                                <%--¥${performance.fourthPrice}</button>--%>
                        <%--</c:if>--%>
                    <%--</div>--%>
                    <%--<button class="pure-button" style="background: #fda572; color: white; margin-top: 20px; border-radius: 25px; font-size: 18px" onclick="pickSeat()">--%>
                        <%--选座购买</button>--%>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="logModalLabel"><br>会员登录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="login-form" action="/tikey" onsubmit="return logIn()">
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8" id="member_check">
                            <input type="email" class="form-control" id="email" placeholder="请输入完整邮箱地址" name="email" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8" id="password_check">
                            <input type="password" class="form-control" id="password" placeholder="注意区分大小写" name="password" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="remember" id="remember">记住用户名
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white" id="login_button">
                                登录</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="registerModalLabel"><br>会员注册</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/tikey/member/register">
                    <div class="form-group">
                        <label for="emailRegister" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8" id="email_check">
                            <input type="email" class="form-control" id="emailRegister" placeholder="请输入正确完整邮箱地址" name="email" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="nameRegister" class="col-sm-2 control-label">会员昵称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="nameRegister" placeholder="请给您起一个喜欢的昵称" name="name" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="passwordRegister" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="passwordRegister" placeholder="密码至多20位" name="password" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8" id="button_container">
                            <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white" id="register_b">
                                注册</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

</body>

<script>
    function logIn(){
        $.ajax({
            type: "POST",
            data: {'email':$("#email").val(), 'password': $("#password").val(), 'remember': $("#remember").val()},
            url: "/tikey/member/login/check" ,
            success: function (data) {
                if(data=="success"){
                    // window.location.href="/tikey/member/detail/"+$("#email").val();
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#logModal').modal('hide');
                    var form = document.getElementById("login-form");
                    form.submit();
                }
                if(data=="no member"){
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#member_check').append("<span id='member_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>用该邮箱注册用户不存在</span>");
                }
                if(data=="wrong password"){
                    $('#member_wrong').remove();
                    $('#password_wrong').remove();
                    $('#password_check').append("<span id='password_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>密码错误</span>");
                }
                if(data=="canceled member"){
                    // $('#member_wrong').remove();
                    // $('#password_wrong').remove();
                    $('#logModal').modal('hide');
                    alert("对不起，该邮箱注册的会员已注销");
                }
            }
        });
        return false;
    }

    function addEmail(){
        var form = document.getElementById("email-form");
        form.submit();
        return false;
    }
</script>

</html>
