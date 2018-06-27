<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/22
  Time: 下午4:29
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
    <link rel="stylesheet" href="/css/seat.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.seat-charts.min.js"></script>
</head>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">管理员，你好</h1>
            <%--<h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>--%>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/manager/login">返回</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/manager/modifications">修改申请</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">申请场馆</h1>

                <c:forEach items="${applyList}" var="stadium">
                    <section class="post">
                        <header class="post-header">

                            <a href="/tikey/manager/stadium/${stadium.stadiumCode}">
                                <h2 class="post-title">${stadium.name}</h2>
                            </a>

                            <p class="post-meta" style="margin-top: 8px; margin-bottom: 8px">
                                场馆验证码：<a href="#" class="post-author">${stadium.stadiumCode}</a> &nbsp&nbsp&nbsp&nbsp
                                位于 <a href="#" class="post-author">${stadium.province}省 ${stadium.city}市 ${stadium.address}</a>
                                <c:if test="${stadium.rowOfSecondFloor==0}">
                                    <span class="post-category post-category-concert">小型场馆</span>
                                </c:if>
                                <c:if test="${stadium.rowOfThirdFloor==0}">
                                    <span class="post-category post-category-competition">中小型场馆</span>
                                </c:if>
                                <c:if test="${stadium.rowOfFourthFloor==0}">
                                    <span class="post-category post-category-opera">普通场馆</span>
                                </c:if>
                                <c:if test="${stadium.rowOfFourthFloor>0}">
                                    <span class="post-category post-category-circus">大型场馆</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <p>
                                账户名：${stadium.accountName}<br>
                                池座：${stadium.rowOfStall}行  ${stadium.colOfStall}列<br>
                                <c:if test="${stadium.rowOfSecondFloor>0}">
                                    二层：${stadium.rowOfSecondFloor}行  ${stadium.colOfSecondFloor}列<br>
                                </c:if>
                                <c:if test="${stadium.rowOfThirdFloor>0}">
                                    三层：${stadium.rowOfThirdFloor}行  ${stadium.colOfThirdFloor}列<br>
                                </c:if>
                                <c:if test="${stadium.rowOfFourthFloor>0}">
                                    四层：${stadium.rowOfFourthFloor}行  ${stadium.colOfFourthFloor}列<br>
                                </c:if>
                            </p>
                            <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                    data-toggle="modal" data-target="#acceptModal">通过审核</button>
                        </div>

                        <div class="modal fade" id="acceptModal" tabindex="-1" role="dialog" aria-labelledby="acceptModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <a class="navbar-brand" href="#">
                                        <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
                                    </a>
                                    <div class="modal-header" style="top: 25px">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title" id="acceptModalLabel"><br>场馆审核</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>确定要通过该场馆的申请吗？</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                        <a type="button" class="btn btn-primary"
                                           href="/tikey/manager/accept/${stadium.stadiumCode}">确认
                                        </a>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div>
                    </section>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

</body>
</html>
