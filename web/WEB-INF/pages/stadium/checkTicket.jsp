<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/21
  Time: 下午10:20
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
            <h1 class="brand-title">${stadium.name}</h1>
            <%--<h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>--%>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performance/${stadium.stadiumCode}/${performance.id}">返回</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performanceList?code=${stadium.stadiumCode}">演出列表</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div class="row" style="margin-top: 50px">
            <div class="col-md-4">
                <div class="poster">
                    <img class="img-thumbnail" src="${performance.posterUrl}">
                </div>
            </div>
            <div class="col-md-8">
                <h2>${performance.name}<small> <br><br></small></h2>
                <p>场次：${performance.showTime}</p>
                <form class="form-horizontal" role="form" action="/tikey/stadium/performance/checkTicket"
                      enctype="multipart/form-data" style="margin-top: 100px">
                    <div class="form-group" hidden="hidden">
                        <input type="text" name="code" value="${stadium.stadiumCode}">
                        <input type="text" name="id" value="${performance.id}">
                    </div>
                    <div class="form-group">
                        <c:if test="${correct.length()>0}">
                            <label for="ticket_number" class="col-sm-2 control-label">票号</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="ticket_number" placeholder="请输入完整的票号" name="ticketId" required="required">
                            </div>
                            <div class="col-sm-2"><button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white; margin-right: 40px">
                                检票</button>
                            </div>
                        </c:if>
                    </div>
                    <c:if test="${wrongPerformance.length()>0}">
                        <div class="form-group has-error">
                            <label class="col-sm-4 control-label" for="inputError">票号错误或演出不符</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="inputError" placeholder="请输入完整的票号" name="ticketId" required="required" value="${ticketId}">
                            </div>
                            <div class="col-sm-2"><button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white; margin-right: 40px">
                                检票</button>
                        </div>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>

        <div id="ticket_info">
            <!-- A wrapper for all the blog posts -->
            <c:if test="${ticketId>0 && correct.length()>0}">
                <div class="posts" style="margin-top: 50px">
                    <h1 class="content-subhead">检票成功</h1>
                    <section class="post" style="margin-bottom: 60px; width: 70%">
                        <header class="post-header">

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
                            <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                    data-toggle="modal" data-target="#acceptModal" onclick="confirm()">
                                确定</button>
                        </div>
                    </section>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
<script>
    function confirm() {
        window.location.href="/tikey/stadium/performance/checkTicket?code=${stadium.stadiumCode}&id=${performance.id}&ticketId=-1";
    }
</script>
</html>
