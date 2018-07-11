<%@ page import="cn.tikey.entity.Coupon" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/24
  Time: 上午10:27
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
    <link rel="stylesheet" href="/css/uikit.css">
    <link rel="stylesheet" href="/css/uikit-rtl.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/uikit-icons.js"></script>
    <script src="/js/uikit.js"></script>
</head>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title" style="color: white">${member.name}</h1>
            <h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>

            <nav class="nav">
                <ul class="nav-list">
                    <%--<li class="nav-item">--%>
                        <%--<a class="pure-button" href="/tikey/member/tickets?email=${member.email}&page1=0&page2=0&page3=0&page4=0&index=0">我的订单</a>--%>
                    <%--</li>--%>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/member/detail?email=${member.email}">返回我的资料</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div>
            <div  style="float: right;">
                <a  href="/tikey?email=${member.email}">返回主页</a>
            </div>

            <!-- A wrapper for all the blog posts -->
            <div style="margin-top: 1%" class="posts">
                <h1 class="content-subhead">优惠券兑换 (积分:${member.validCredit}）</h1>
                <div class="uk-child-width-1-3@m uk-grid-small uk-grid-match" uk-grid>
                    <c:forEach items="${couponList}" var="coupons">
                        <div>
                            <div style="height: 180px;margin-bottom: 30px" class="uk-card uk-card-default uk-card-body">
                                <h3 class="uk-card-title">${coupons.name}</h3>
                                <p>兑换所需积分:${coupons.value}<br>
                                    已拥有数量:${coupons.holdAmount}
                                </p>
                                <c:if test="${member.validCredit>coupons.value}">
                                    <a type="button" class="pure-button"
                                       href="/tikey/member/coupon/convert?email=${member.email}&name=${coupons.name}&condition=${coupons.condition}"
                                       style="float: right; background: #5987c9; color: white; margin-right: 40px;margin-top: -50px">兑换</a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="posts" style="margin-top: 200px">
            <h1 class="content-subhead"></h1>
        </div>

            <footer class="footer-bottom" style="margin-top: 35px">
                <p>&copy; Tikey, NJU Software Institute, 2018.</p>
            </footer>
    </div>
</div>
</body>
</html>
