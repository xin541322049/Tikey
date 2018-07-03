<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="/css/uikit.css">
    <link rel="stylesheet" href="/css/paging.css">
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/uikit-icons.js"></script>
    <script src="/js/uikit.js"></script>
    <script src="/js/paging.js"></script>
</head>
<style>
    .page_div {
        margin-left: 35%;
    }

    h2 {
        font-size: large;
        margin-top: 5px;
    }

    .performance-link {
        color: #666666;
    }

    .performance-link:hover,
    .performance-link:focus {
        color: #ea8c30;
        text-decoration: none;
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
        </div>

        <div class="navbar-site">
            <div class="splitor"></div>
        </div>

        <div id="choose-city" class="nav navbar-nav">
            <li class="dropdown">
                <c:if test="${city.equals('all')}">
                    <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&genre=${genre}"
                       class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 18px">
                        <span class="city-chooser">全部城市</span><b class="caret"></b>
                    </a>
                </c:if>
                <c:if test="${!city.equals('all')}">
                    <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=${city}&genre=${genre}"
                       class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 18px">
                        <span class="city-chooser">${city}</span><b class="caret"></b>
                    </a>
                </c:if>
                <ul class="dropdown-menu">
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&genre=${genre}">
                            全部城市
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=北京&genre=${genre}">
                            北京
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=上海&genre=${genre}">
                            上海
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=南京&genre=${genre}">
                            南京
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=杭州&genre=${genre}">
                            杭州
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=大连&genre=${genre}">
                            大连
                        </a>
                    </li>
                    <li>
                        <a href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=武汉&genre=${genre}">
                            武汉
                        </a>
                    </li>
                </ul>
            </li>
        </div>

        <div id="search-area" class="nav navbar-nav">
            <form class="form-inline search-form" role="search" action="/tikey/search" method="post">
                <input class="search-input" placeholder="搜索演出、赛事" name="term" value="${search_term}"
                       required="required">
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
                        <span class="user-menu-text">退出</span>
                    </a>
                </li>
                <form action="/tikey/member/detail" id="email-form" method="post" hidden="hidden">
                    <input value="${member.email}" name="email">
                </form>
            </c:if>
        </ul>
    </div>
</nav>

<%--没有搜索关键字--%>
<c:if test="${search_term.equals('') || search_term == null}">
    <div id="nav-channel">
        <div class="container" style="padding-left: 0; padding-right: 0">
            <ol class="breadcrumb genres no-gap">
                <c:if test="${genre.equals('') || genre == null}">
                    <li class="genre">
                        <a style="font-weight: 800;color: #ea8c30;"
                           href="/tikey?email=${member.email}&sort=0&city=${city}">首页</a>
                        <div class="border-bottom"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('') && genre != null}">
                    <li class="genre"><a href="/tikey?email=${member.email}&sort=0&city=${city}">首页</a></li>
                </c:if>

                <c:if test="${genre.equals('演唱会')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}&sort=0&city=${city}">演唱会</a>
                        <div class="border-bottom" style="margin-left: 15px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('演唱会')}">
                    <li class="genre"><a
                            href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}&sort=0&city=${city}">演唱会</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('体育赛事')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}&sort=0&city=${city}">体育赛事</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('体育赛事')}">
                    <li class="genre"><a
                            href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}&sort=0&city=${city}">体育赛事</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('音乐会')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}&sort=0&city=${city}">音乐会</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('音乐会')}">
                    <li class="genre"><a
                            href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}&sort=0&city=${city}">音乐会</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('歌剧')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">歌剧</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('歌剧')}">
                    <li class="genre"><a href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">歌剧</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('话剧')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">话剧</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('话剧')}">
                    <li class="genre"><a href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">话剧</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('儿童亲子')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}&sort=0&city=${city}">儿童亲子</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('儿童亲子')}">
                    <li class="genre"><a
                            href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}&sort=0&city=${city}">儿童亲子</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('舞蹈')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}&sort=0&city=${city}">舞蹈</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('舞蹈')}">
                    <li class="genre"><a href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}&sort=0&city=${city}">舞蹈</a>
                    </li>
                </c:if>

                <c:if test="${genre.equals('马戏杂技')}">
                    <li class="genre"><a style="font-weight: 800;color: #ea8c30;"
                                         href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}&sort=0&city=${city}">马戏杂技</a>
                        <div class="border-bottom" style="margin-left: 12px"></div>
                    </li>
                </c:if>
                <c:if test="${!genre.equals('马戏杂技')}">
                    <li class="genre"><a
                            href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}&sort=0&city=${city}">马戏杂技</a>
                    </li>
                </c:if>
            </ol>
        </div>
    </div>
</c:if>

<%--有搜索关键字--%>
<c:if test="${!search_term.equals('') && search_term != null}">
    <div id="filter-channel" class="container" style="margin-bottom: -10px; margin-top: 10px">
        <div class="panel panel-default filter-panel">
            <div class="panel-body">
                <ol class="breadcrumb genres no-gap">
                    <li class="filter-item"><span class="filter-label">按类型： </span></li>

                    <c:if test="${genre.equals('') || genre == null}">
                        <li class="filter-item">
                            <a class="filter-text filter-chosen"
                               href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=${city}">不限</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('') && genre != null}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?email=${member.email}&term=${search_term}&sort=0&city=${city}">不限</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('演唱会')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}&sort=0&city=${city}">演唱会</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('演唱会')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=演唱会&email=${member.email}&term=${search_term}&sort=0&city=${city}">演唱会</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('体育赛事')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}&sort=0&city=${city}">体育赛事</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('体育赛事')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=体育赛事&email=${member.email}&term=${search_term}&sort=0&city=${city}">体育赛事</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('音乐会')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}&sort=0&city=${city}">音乐会</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('音乐会')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=音乐会&email=${member.email}&term=${search_term}&sort=0&city=${city}">音乐会</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('歌剧')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">歌剧</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('歌剧')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=歌剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">歌剧</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('话剧')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">话剧</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('话剧')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=话剧&email=${member.email}&term=${search_term}&sort=0&city=${city}">话剧</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('儿童亲子')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}&sort=0&city=${city}">儿童亲子</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('儿童亲子')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=儿童亲子&email=${member.email}&term=${search_term}&sort=0&city=${city}">儿童亲子</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('舞蹈')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}&sort=0&city=${city}">舞蹈</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('舞蹈')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=舞蹈&email=${member.email}&term=${search_term}&sort=0&city=${city}">舞蹈</a>
                        </li>
                    </c:if>

                    <c:if test="${genre.equals('马戏杂技')}">
                        <li class="filter-item"><a class="filter-text filter-chosen"
                                                   href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}&sort=0&city=${city}">马戏杂技</a>
                        </li>
                    </c:if>
                    <c:if test="${!genre.equals('马戏杂技')}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?genre=马戏杂技&email=${member.email}&term=${search_term}&sort=0&city=${city}">马戏杂技</a>
                        </li>
                    </c:if>
                </ol>
            </div>
        </div>
    </div>

    <div id="sort-channel" class="container" style="margin-bottom: -10px; margin-top: 10px">
        <div class="panel panel-default filter-panel">
            <div class="panel-body">
                <ol class="breadcrumb genres no-gap">
                    <li class="filter-item"><span class="filter-label" style="padding-right: 16px">排序： </span></li>

                    <c:if test="${sortType == 0}">
                        <li class="filter-item"><a class="filter-text sort-chosen"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=0&city=${city}&genre=${genre}">默认</a>
                        </li>
                    </c:if>
                    <c:if test="${sortType != 0}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=0&city=${city}&genre=${genre}">默认</a>
                        </li>
                    </c:if>

                    <c:if test="${sortType == 1}">
                        <li class="filter-item"><a class="filter-text sort-chosen"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=1&city=${city}&genre=${genre}">按开演时间</a>
                        </li>
                    </c:if>
                    <c:if test="${sortType != 1}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=1&city=${city}&genre=${genre}">按开演时间</a>
                        </li>
                    </c:if>

                    <c:if test="${sortType == 2}">
                        <li class="filter-item"><a class="filter-text sort-chosen"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=2&city=${city}&genre=${genre}">按价格升序</a>
                        </li>
                    </c:if>
                    <c:if test="${sortType != 2}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=2&city=${city}&genre=${genre}">按价格升序</a>
                        </li>
                    </c:if>
                    <c:if test="${sortType == 3}">
                        <li class="filter-item"><a class="filter-text sort-chosen"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=3&city=${city}&genre=${genre}">按价格降序</a>
                        </li>
                    </c:if>
                    <c:if test="${sortType != 3}">
                        <li class="filter-item"><a class="filter-text"
                                                   href="/tikey/search?&email=${member.email}&term=${search_term}&sort=3&city=${city}&genre=${genre}">按价格降序</a>
                        </li>
                    </c:if>
                </ol>
            </div>
        </div>
    </div>
</c:if>

<div class="container" style="margin-top: 35px; min-height: 50%">
    <c:if test="${result.size()==0}">
        <div class="row" style="padding-top: 120px; min-height: 40%;">
            <h2 class="col-md-offset-4">暂时还没有相关演出哦～
                返回<a href="/tikey?email=${email}">首页</a>看看别的演出叭
            </h2>
        </div>
    </c:if>

    <c:if test="${result.size()>0}">
        <div style="min-height: 40%">
            <c:forEach items="${result}" var="performance" begin="${page * 10}" end="${(page + 1) * 10 - 1}">
                <div class="col-md-5 uk-card uk-card-default uk-card-hover uk-card-body"
                     style=" padding: 8px; margin: 4% 4%; height: 215px">
                    <div class="col-md-3" style="padding-right: 0;">
                        <div class="poster"
                             style="float: right; margin-left: -40%; margin-top: -40%; margin-bottom: 40%">
                            <img class="img-thumbnail" src="${performance.posterUrl}" style="height: 200px">
                        </div>
                    </div>
                    <div class="col-md-9" style="padding-left: 30px;">
                        <div class="movie-info">
                            <h2>
                                <a href="/tikey/performance/detail/${performance.id}?email=${email}"
                                   class="performance-link">${performance.name}</a>
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
                            <div style="color: #ff936f; font-size: large; padding-left: 68%; font-weight: 500">
                                ¥${performance.stallPrice}<span
                                    style="color: #666666; font-size: small; font-weight: normal"> 以内</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <div class="col-md-11 col-md-offset-1">
        <div id="page_block" class="page_div "></div>
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
                    <h4 class="modal-title" id="registerModalLabel"
                        style="margin-top:13px; font-size:18px; font-weight: 500;">会员注册</h4>
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

<script>
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

    max_page = ${result.size()}
        max_page = Math.ceil(max_page / 10)

    function changePage(newPage) {
        $("#search-form-page").val(newPage)
        $("#search-form").submit()
    }

    $("#page_block").paging({
        pageNo: ${page}+1,
        totalPage: max_page,
        totalSize: ${result.size()},
        callback: function (num) {
            changePage(num - 1)
        }
    })
</script>

</html>
