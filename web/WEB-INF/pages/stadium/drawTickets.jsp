<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/26
  Time: 上午9:07
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
</head>
<link rel="stylesheet" href="/css/blog.css">
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/pure-min.css">
<link rel="stylesheet" href="/css/grids-responsive-min.css">
<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">${stadium.name}</h1>
            <%--<h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>--%>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performance/${stadium.stadiumCode}/${id}">返回</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">

        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">出票</h1>
                <c:forEach items="${drawList}" var="ticket">
                <section class="post" style="margin-bottom: 60px">
                    <header class="post-header">
                        <img width="100" height="100" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${ticket.posterUrl}>

                        <h2 class="post-title">${ticket.performanceName}</h2>

                        <p class="post-meta" style="margin-top: 13px; margin-bottom: 13px">
                            <c:if test="${ticket.type=='Stall'}">
                                <span class="post-category post-category-concert">池座</span>
                            </c:if>
                            <c:if test="${ticket.type=='Second'}">
                                <span class="post-category post-category-competition">二楼</span>
                            </c:if>
                            <c:if test="${ticket.type=='Third'}">
                                <span class="post-category post-category-opera">三楼</span>
                            </c:if>
                            <c:if test="${ticket.type=='Fourth'}">
                                <span class="post-category post-category-circus">四楼</span>
                            </c:if>
                        </p>
                    </header>

                    <div class="post-description">
                        <p>
                            票号：${ticket.id}<br>
                            票价：¥${ticket.price}<br>
                            位置：${ticket.theRow}排${ticket.theColumn}座<br>
                            购票时间：${ticket.saleTime}<br>
                        </p>
                    </div>
                </section>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html>
