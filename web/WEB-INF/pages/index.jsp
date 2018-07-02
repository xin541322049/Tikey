<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2017/12/18
  Time: 下午9:24
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/carousel.css">
    <link rel="stylesheet" href="/css/unit.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
</head>

<body id="mainBody">

<nav class="navbar navbar-default navbar-static-top header">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand no-gap" href="/tikey?email=${member.email}" style="margin-right: 10px">
                <img alt="Brand" src="/img/Hollywood_Ticket_72px_548853_easyicon.net.jpg">
            </a>
            <h3 class="pure-menu-heading" style="margin: 15px;color: #666666">Tikey</h3>
        </div>

        <div class="navbar-site">
            <div class="splitor"></div>
        </div>

        <div id="choose-city" class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 15px">
                    <span class="city-chooser">南京</span><b class="caret"></b>
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
        </div>

        <div id="search-area" class="nav navbar-nav" style="margin-left: 120px;">
            <form class="form-inline" role="search" action="/tikey/search" method="post"
                  style="margin-top: 20px; line-height: 40px; height: 40px;">
                <input class="search-input" placeholder="搜索演出、赛事" name="term">
                <input value="${member.email}" name="email" hidden="hidden">
                <button class="pure-button join-button" style="padding-bottom: 8px">
                    <span class="glyphicon glyphicon-search" style="margin-right: 5px"></span>搜索
                </button>
            </form>
        </div>

        <ul id="visitor_nav" class="nav navbar-nav navbar-right" style="margin-top: 25px">
            <c:if test="${member==null}">
                <li class="user-menu"><span data-toggle="modal" href="#registerModal"
                                            style="outline: none; cursor: pointer">
                    <i class="fa fa-user-circle fa-2x"></i>
                        <span style="position:relative;bottom: 5px">注册</span>
                </span></li>

                <li class="user-menu"><span data-toggle="modal" href="#logModal" style="outline: none; cursor: pointer">
                    <i class="fa fa-sign-in fa-2x"></i>
                        <span style="position:relative;bottom: 5px">登录</span>
                </span></li>
            </c:if>

            <c:if test="${member.email.length()>0}">
                <li>
                    <a href="${pageContext.servletContext.contextPath}/tikey/member/detail"
                       onclick="return addEmail();">
                        <i class="fa fa-user-circle fa-2x"></i>
                        <span style="position:relative;bottom: 5px">我的</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.servletContext.contextPath}/tikey">
                        <i class="fa fa-sign-out fa-2x"></i>
                        <span style="position:relative;bottom: 5px"> 退出</span>
                    </a>
                </li>
                <form action="/tikey/member/detail" id="email-form" method="post">
                    <input value="${member.email}" name="email">
                </form>
            </c:if>
        </ul>
    </div>
</nav>

<div id="nav-channel">
    <div class="container" style="padding-left: 0; padding-right: 0">
        <ol class="breadcrumb genres" style="margin: 0; padding: 0">
            <li class="genre"><a style="font-weight: 800;color: #ea8c30;" href="/tikey?email=${member.email}">首页</a>
                <div class="border-bottom"></div>
            </li>
            <%--<li class="genre"><a href="/tikey?genre=演唱会&email=${member.email}">演唱会</a><div class="border-bottom" style="margin-left: 10px"></div></li>--%>
            <li class="genre"><a href="/tikey?genre=演唱会&email=${member.email}">演唱会</a></li>
            <li class="genre"><a href="/tikey?genre=体育赛事&email=${member.email}">体育赛事</a></li>
            <li class="genre"><a href="/tikey?genre=音乐会&email=${member.email}">音乐会</a></li>
            <li class="genre"><a href="/tikey?genre=歌剧&email=${member.email}">歌剧</a></li>
            <li class="genre"><a href="/tikey?genre=话剧&email=${member.email}">话剧</a></li>
            <li class="genre"><a href="/tikey?genre=儿童亲子&email=${member.email}">儿童亲子</a></li>
            <li class="genre"><a href="/tikey?genre=舞蹈&email=${member.email}">舞蹈</a></li>
            <li class="genre"><a href="/tikey?genre=马戏杂技&email=${member.email}">马戏杂技</a></li>
        </ol>
    </div>
</div>

<article id="banner" style="margin-bottom: 10px; margin-top: -18px">
    <div class="caroursel poster-main" data-setting='{
	        "width":1200,
	        "height":360,
	        "posterWidth":890,
	        "posterHeight":360,
	        "scale":0.8,
	        "dealy":"2000",
	        "algin":"middle"
	    }'>
        <ul class="poster-list">
            <li class="poster-item"><img src="https://img2.tking.cn/assets/img/cyKpCMZMEa.jpg" width="100%"
                                         height="100%"></li>
            <li class="poster-item"><img src="https://img0.tking.cn/assets/img/DJZGrerwaN.jpg" width="100%"
                                         height="100%"></li>
            <li class="poster-item"><img src="https://img0.tking.cn/assets/img/wwY35nA5Wt.jpg" width="100%"
                                         height="100%"></li>
            <li class="poster-item"><img src="https://img1.tking.cn/assets/img/7i5ASpE6it.jpg" width="100%"
                                         height="100%"></li>
            <li class="poster-item"><img src="https://img0.tking.cn/assets/img/7w7McrXKxs.jpg" width="100%"
                                         height="100%"></li>
        </ul>

        <div class="poster-btn poster-prev-btn"></div>
        <div class="poster-btn poster-next-btn"></div>
    </div>
</article>

<div class="container" style="margin-left: 110px; margin-right: 110px">
    <%--近期热门--%>
    <section id="hot-section">
        <div class="section-header">
            <div class="section-title">近期热门</div>
            <div class="section-operation" style="margin-left: 500px;"><a href="#" class="no-default-a hover-a">查看更多<i
                    class="fa fa-angle-right fa-lg"></i></a></div>
        </div>

        <c:forEach items="${hotList}" var="performance" varStatus="status">
            <c:if test="${status.index< 6}">
                <div class="single-member effect-2" style="width: 210px; height: 350px">
                    <div class="member-image">
                        <img src="${performance.posterUrl}" alt="Member" style="width: 210px; height: 285px">
                    </div>
                    <div class="member-info">
                        <h4 style="color: #5987c9; font-size: 17px; margin-top: 5px">
                            <a href="/tikey/performance/detail/${performance.id}?email=${member.email}">${performance.name}</a>
                        </h4>
                        <h5 style="color: #737373">${performance.showPlace.name}</h5>
                        <p style="color: #737373">${performance.description}</p>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </section>

    <%--人气TOP 5--%>
    <section id="top-section">
        <div class="section-header">
            <div class="section-title">人气TOP 5</div>
            <div class="section-operation" style="margin-left: 140px;"><a href="#" class="no-default-a hover-a">查看更多<i
                    class="fa fa-angle-right fa-lg"></i></a></div>
        </div>
        <c:forEach items="${hotList}" var="performance" varStatus="status">
            <c:if test="${status.index<5}">
                <a href="/tikey/performance/detail/${performance.id}?email=${member.email}" class="top-item">
                    <div class="show-index">${status.index + 1}</div>
                    <div class="image-holder">
                        <img src="${performance.posterUrl}" style="width: 90px; height: 130px">
                    </div>
                    <div class="show-detail">
                        <span style="font-size: 15px">${performance.name}</span>
                        <h5 style="color: #737373">${performance.showPlace.name}</h5>
                        <h5 style="color: #737373">${performance.showTime}</h5>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </section>
</div>

<hr style="margin-top: 30px"/>

<div class="container" style="margin-top: 40px">
    <footer style="margin-bottom: 60px">
        <p>&copy; Tikey, NJU Software Institute, 2018.</p>
        <%--<a href="#" class="btn btn-default">Back to top</a>--%>
        <%--<button type="button" class="btn btn-default" data-toggle="modal" data-target="#applyModal">场馆注册</button>--%>
        <%--<button type="button" class="btn btn-default" data-toggle="modal" data-target="#workInModal">场馆登录</button>--%>
        <%--<button type="button" class="btn btn-default" data-toggle="modal" data-target="#adminModal">管理员登录</button>--%>
    </footer>
</div>

<div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg">
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
                            <input type="email" class="form-control" id="email" placeholder="请输入完整邮箱地址" name="email"
                                   required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8" id="password_check">
                            <input type="password" class="form-control" id="password" placeholder="注意区分大小写"
                                   name="password" required="required">
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
                            <button type="submit" class="pure-button"
                                    style="float: right; background: #5987c9; color: white" id="login_button">
                                登录
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg"
                     style="background-color: transparent">
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
                            <input type="email" class="form-control" id="emailRegister" placeholder="请输入正确完整邮箱地址"
                                   name="email" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="nameRegister" class="col-sm-2 control-label">会员昵称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="nameRegister" placeholder="请给您起一个喜欢的昵称"
                                   name="name" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="passwordRegister" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="passwordRegister" placeholder="密码至多20位"
                                   name="password" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8" id="button_container">
                            <button type="submit" class="pure-button"
                                    style="float: right; background: #5987c9; color: white" id="register_b">
                                注册
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

</body>

<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.carousel.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script type="text/javascript">
    Caroursel.init($('.caroursel'));
    $(function () {
        var str_checkname = "";
        $("#emailRegister").blur(
            function () {
                //start if
                if ($("#emailRegister").val() != "" && $("#emailRegister").val() != str_checkname) {
                    //记录上次填入的值
                    str_checkname = $("#emailRegister").val();
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.servletContext.contextPath}/tikey/member/register/check",
                        data: {'email': $("#emailRegister").val()},
                        success: function (data) {
                            //$("#ta1").val(data);
                            if (data == "success") {
                                $('#check_true').remove();
                                $('#check_false').remove();
                                $('#email_check').append("<span id='check_true' class='glyphicon glyphicon-ok-sign' " +
                                    "style='color: green; top: 8px'> </span>");
                                $('#register_b').remove();
                                $('#button_container').append("<button type='submit' class='pure-button ' " +
                                    "style='float: right; background: #5987c9; color: white' id='register_b'>\n" +
                                    "                  注册</button>");
                            } else {
                                $('#check_true').remove();
                                $('#check_false').remove();
                                $('#email_check').append("<span id='check_false' class='glyphicon glyphicon-remove-sign' " +
                                    "style='color: #d06d72; top: 8px'>该邮箱已注册，请直接登录</span>");
                                $('#register_b').remove();
                                $('#button_container').append("<button type='submit' " +
                                    "class='pure-button pure-button-disabled' " +
                                    "style='float: right; background: #5987c9; color: white' id='register_b'>\n" +
                                    "                  注册</button>");
                            }
                        }
                    });
                }
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

    function workIn() {
        $.ajax({
            type: "POST",
            data: {
                'code': $("#code").val(),
                'password': $("#stdm_password").val(),
                'remember': $("#code_remember").val()
            },
            url: "/tikey/stadium/login/check",
            success: function (data) {
                if (data === "success") {
                    var form = document.getElementById("workIn-form");
                    form.submit();
                }
                if (data === "fail") {
                    $('#stadium_wrong').remove();
                    $('#code_check').append("<span id='stadium_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
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

    function adminCheck() {
        $.ajax({
            type: "POST",
            data: {'id': $("#admin_id").val(), 'password': $("#admin_password").val()},
            url: "/tikey/manager/login/check",
            success: function (data) {
                if (data === "success") {
                    window.location.href = "/tikey/manager/login?id=" + $("#admin_id").val()
                        + "&password=" + $("#admin_password").val();
                }
                if (data === "fail") {
                    $('#admin_wrong').remove();
                    $('#admin_check').append("<span id='admin_wrong' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
                }
            }
        });
    }
</script>
</html>
