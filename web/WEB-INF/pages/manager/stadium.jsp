<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/22
  Time: 下午6:26
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
    <link rel="stylesheet" href="/css/fileinput.css">
    <link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">管理员，你好</h1>
            <h2 class="brand-tagline">场馆：${stadium.name}</h2>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/manager/login">返回</a>
                    </li>
                    <%--<li class="nav-item">--%>
                        <%--<a class="pure-button" >演出申请</a>--%>
                    <%--</li>--%>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">待审批演出</h1>

                <c:forEach items="${applyingList}" var="performance">
                    <section class="post" style="margin-bottom: 40px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <h2 class="post-title">${performance.name}</h2>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <div class="row">
                                <div class="col-sm-8">
                                    <p>
                                        池座票价：¥${performance.stallPrice}<br>
                                        <c:if test="${stadium.rowOfSecondFloor>0}">
                                            二层票价：¥${performance.secondPrice}<br>
                                        </c:if>
                                        <c:if test="${stadium.rowOfThirdFloor>0}">
                                            三层票价：¥${performance.thirdPrice}<br>
                                        </c:if>
                                        <c:if test="${stadium.rowOfFourthFloor>0}">
                                            四层票价：¥${performance.fourthPrice}<br>
                                        </c:if>
                                            ${performance.description}
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4" style="float: right">
                                    <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                            data-toggle="modal" data-target="#acceptModal">通过审核</button>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="acceptModal" tabindex="-1" role="dialog" aria-labelledby="acceptModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <a class="navbar-brand" href="#">
                                        <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
                                    </a>
                                    <div class="modal-header" style="top: 25px">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title" id="acceptModalLabel"><br>演出审核</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>确定要通过该演出的申请吗？</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                        <a type="button" class="btn btn-primary"
                                           href="/tikey/performance/accept/${performance.id}?code=${stadium.stadiumCode}">确认
                                        </a>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">正在售票演出</h1>

                <c:forEach items="${saleList}" var="performance">
                    <section class="post" style="margin-bottom: 40px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <h2 class="post-title">${performance.name}</h2>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <div class="row">
                                <div class="col-sm-8">
                                    <p>
                                            ${performance.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">已结束演出</h1>

                <c:forEach items="${completedList}" var="performance">
                    <section class="post" style="margin-bottom: 40px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <h2 class="post-title">${performance.name}</h2>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <div class="row">
                                <div class="col-sm-8">
                                    <p>
                                            ${performance.description}
                                    </p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4" style="float: right">
                                    <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                            onclick="settle(${performance.id})">结算</button>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">已结算演出</h1>

                <c:forEach items="${settledList}" var="performance">
                    <section class="post" style="margin-bottom: 40px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <h2 class="post-title">${performance.name}</h2>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <div class="row">
                                <div class="col-sm-8">
                                    <p>
                                            ${performance.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:forEach>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="settleModal" tabindex="-1" role="dialog" aria-labelledby="settleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="settleModalLabel"><br>演出结算</h4>
            </div>
            <div class="modal-body">
                <p>本场演出门票收入总共 ¥<span id="total_income"></span> 元</p><br>
                <p>Tikey收取5%的平台费用</p><br>
                <p>给场馆账户转入 ¥<span id="transport_amount"></span> 元</p><br>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" onclick="transport()">确认
                </a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
</body>

<script>
    var performanceId;

    function settle(id) {
        performanceId = id;
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/manager/stadium/settle",
            data:  {'id': performanceId},
            success:  function(data){
                var transport = parseFloat(data);
                $("#total_income").text(transport+'');
                transport = transport*0.95;
                $("#transport_amount").text(transport+'');
                $("#settleModal").modal("show");
            }
        });
    }

    function transport() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/manager/stadium/transport",
            data:  {'id': performanceId, 'code': '${stadium.stadiumCode}'},
            success:  function(data){
                alert("结算成功");
                location.reload()
            }
        });
    }
</script>
</html>
