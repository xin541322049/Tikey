<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/25
  Time: 下午12:15
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
</head>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">${member.name}</h1>
            <h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>

            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/member/detail?email=${member.email}">我的资料</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/member/coupons?email=${member.email}">我的优惠券</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">

        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">未使用</h1>
                <c:forEach items="${unusedList}" var="ticket">
                    <section class="post" style="margin-bottom: 60px">
                        <header class="post-header">
                            <img width="100" height="100" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${ticket.posterUrl}>

                            <a href="/tikey/performance/detail/${ticket.performanceId}?email=${member.email}">
                                <h2 class="post-title">${ticket.performanceName}</h2>
                            </a>

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
                                <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                        data-toggle="modal" data-target="#acceptModal" onclick="refundCheck(${ticket.id})">
                                    退票</button>
                            </p>
                        </div>
                    </section>
                </c:forEach>

                <c:forEach items="${unseatedList}" var="ticket">
                    <section class="post" style="margin-bottom: 60px">
                        <header class="post-header">
                            <img width="100" height="100" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${ticket.posterUrl}>

                            <a href="/tikey/performance/detail/${ticket.performanceId}?email=${member.email}">
                                <h2 class="post-title">${ticket.performanceName}</h2>
                            </a>

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
                                位置：未选座，等待配票<br>
                                购票时间：${ticket.saleTime}<br>
                                <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                        data-toggle="modal" data-target="#acceptModal" onclick="refundCheck(${ticket.id})">
                                    退票</button>
                            </p>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts" style="margin-top: 50px">
                <h1 class="content-subhead">已使用</h1>
                <c:forEach items="${usedList}" var="ticket">
                    <section class="post">
                        <header class="post-header">
                            <img width="100" height="100" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${ticket.posterUrl}>

                            <a href="/tikey/performance/detail/${ticket.performanceId}?email=${member.email}">
                                <h2 class="post-title">${ticket.performanceName}</h2>
                            </a>

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


            <div class="posts" style="margin-top: 70px">
                <h1 class="content-subhead">已退款</h1>
                <c:forEach items="${refundedList}" var="ticket">
                    <section class="post">
                        <header class="post-header">
                            <img width="100" height="100" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${ticket.posterUrl}>

                            <a href="/tikey/performance/detail/${ticket.performanceId}?email=${member.email}">
                                <h2 class="post-title">${ticket.performanceName}</h2>
                            </a>

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
                                <c:if test="${ticket.theRow!=-1}">
                                    位置：${ticket.theRow}排${ticket.theColumn}座<br>
                                </c:if>
                                <c:if test="${ticket.theRow==-1}">
                                    位置：未选座<br>
                                </c:if>
                                购票时间：${ticket.saleTime}<br>
                                退款金额：${ticket.refund}<br>
                            </p>
                        </div>
                    </section>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="refundModal" tabindex="-1" role="dialog" aria-labelledby="refundModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="refundModalLabel"><br>退票</h4>
            </div>
            <div class="modal-body">
                <p>退回金额为 ¥<span id="refund_amount"></span>，确定退票吗？</p>

                <form class="form-horizontal" role="form" id="admin-form">
                    <div class="form-group">
                        <label for="accountName" class="col-sm-2 control-label">账户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="accountName" required="required" placeholder="请输入退款账户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="account_password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8" id="admin_check">
                            <input type="password" class="form-control" id="account_password" placeholder="注意区分大小写" required="required">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="refund()">确认
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
</body>

<script>
    var refundId = -1;
    function refundCheck(ticketId) {
        refundId = ticketId;
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/performance/refund/checkAmount",
            data:  {'id': ticketId},
            success:  function(data){
                $("#refund_amount").text(data);
                $("#refundModal").modal("show");
            }
        });
    }

    function refund() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/performance/refund",
            data:  {'id': refundId, 'accountName': $("#accountName").val(),
                'accountPassword': $("#account_password").val(), 'email': "${member.email}"},
            success:  function(data){
                if(data == "success"){
                    alert("退款成功");
                    $("#refundModal").modal("hide");
                    location.reload();
                }
                if(data == "fail"){
                    alert("账户错误")
                }
            }
        });
    }
</script>
</html>
