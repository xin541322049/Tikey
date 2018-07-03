<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

        <div id="search-area" class="nav navbar-nav">
            <form class="form-inline search-form" role="search" action="/tikey/search" method="post">
                <input class="search-input" placeholder="搜索演出、赛事" name="term">
                <input value="${member.email}" name="email" hidden="hidden">
                <button class="pure-button join-button">
                    <span class="glyphicon glyphicon-search search-text"></span>搜索
                </button>
            </form>
        </div>

        <ul id="visitor_nav" class="nav navbar-nav navbar-right">
            <c:if test="${member==null}">
                <li class="user-menu"><span data-toggle="modal" href="#registerModal">
                    <i class="fa fa-user-circle fa-2x"></i>
                        <span  class="user-menu-text">注册</span>
                </span>
                </li>

                <li class="user-menu"><span data-toggle="modal" href="#logModal">
                    <i class="fa fa-sign-in fa-2x"></i><span class="user-menu-text">登录</span>
                </span></li>
            </c:if>

            <c:if test="${member.email.length()>0}">
                <li class="user-menu">
                    <span onclick="return addEmail();">
                        <i class="fa fa-user-o fa-2x"></i>
                        <span  class="user-menu-text">我的</span>
                    </span>
                </li>
                <li class="user-menu">
                    <a href="${pageContext.servletContext.contextPath}/tikey" style="padding: 0">
                        <i class="fa fa-sign-out fa-2x"></i>
                        <span  class="user-menu-text"> 退出</span>
                    </a>
                </li>
                <form action="/tikey/member/detail" id="email-form" method="post" hidden="hidden">
                    <input value="${member.email}" name="email">
                </form>
            </c:if>
        </ul>
    </div>
</nav>

<div id="nav-channel">
    <div class="container" style="padding-left: 0; padding-right: 0">
        <ol class="breadcrumb genres" style="margin: 0; padding: 0">
            <c:if test="${curType.equals('') || curType == null}">
                <li class="genre">
                    <a style="font-weight: 800;color: #ea8c30;" href="/tikey?email=${member.email}">首页</a>
                    <div class="border-bottom"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('') && curType != null}">
                <li class="genre"><a href="/tikey/search?email=${member.email}">首页</a></li>
            </c:if>

            <c:if test="${curType.equals('演唱会')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}">演唱会</a>
                    <div class="border-bottom" style="margin-left: 15px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('演唱会')}">
                <li class="genre"><a href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}">演唱会</a>
                </li>
            </c:if>

            <c:if test="${curType.equals('体育赛事')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}">体育赛事</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('体育赛事')}">
                <li class="genre"><a href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}">体育赛事</a>
                </li>
            </c:if>

            <c:if test="${curType.equals('音乐会')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}">音乐会</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('音乐会')}">
                <li class="genre"><a href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}">音乐会</a>
                </li>
            </c:if>

            <c:if test="${curType.equals('歌剧')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}">歌剧</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('歌剧')}">
                <li class="genre"><a href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}">歌剧</a></li>
            </c:if>

            <c:if test="${curType.equals('话剧')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}">话剧</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('话剧')}">
                <li class="genre"><a href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}">话剧</a></li>
            </c:if>

            <c:if test="${curType.equals('儿童亲子')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}">儿童亲子</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('儿童亲子')}">
                <li class="genre"><a href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}">儿童亲子</a>
                </li>
            </c:if>

            <c:if test="${curType.equals('舞蹈')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}">舞蹈</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('舞蹈')}">
                <li class="genre"><a href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}">舞蹈</a></li>
            </c:if>

            <c:if test="${curType.equals('马戏杂技')}">
                <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                     href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}">马戏杂技</a>
                    <div class="border-bottom" style="margin-left: 12px"></div>
                </li>
            </c:if>
            <c:if test="${!curType.equals('马戏杂技')}">
                <li class="genre"><a href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}">马戏杂技</a>
                </li>
            </c:if>
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
            <div class="section-operation" style="margin-left: 500px;"><a
                    href="/tikey/search?email=${member.email}&term=${search_term}" class="no-default-a hover-a">查看更多<i
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
            <div class="section-operation" style="margin-left: 140px;"><a
                    href="/tikey/search?email=${member.email}&term=${search_term}" class="no-default-a hover-a">查看更多<i
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
                        <h5 style="color: #737373">${fn:substring(performance.showTime,0,16)}</h5>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </section>
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

</body>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/js/jquery.carousel.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script src="/js/home.js"></script>
</html>
