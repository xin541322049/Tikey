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
                        <a class="pure-button" href="/tikey/member/tickets?email=${member.email}">我的订单</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/member/detail?email=${member.email}">我的资料</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">优惠券兑换</h1>
                <table class="pure-table">
                    <thead>
                    <tr style="color: white; background-color: rgba(253,85,5,0.19); border: rgba(253,165,114,0.19)">
                        <th>优惠券</th>
                        <th>所需积分</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${couponTypeList}" var="couponType">
                        <tr>
                            <td>${couponType.name}</td>
                            <td>${couponType.value}</td>
                            <c:if test="${member.validCredit>couponType.value}">
                                <td>
                                    <a type="button" class="pure-button"
                                       href="/tikey/member/coupon/convert?email=${member.email}&couponType=${couponType}"
                                       style="float: right; background: #5987c9; color: white; margin-right: 40px">兑换</a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <p><br>当前可兑换积分为 ${member.validCredit}</p>
            </div>

            <div class="posts" style="margin-top: 70px">
                <h1 class="content-subhead">可用优惠券</h1>
                <c:if test="${couponList.size()>0}">
                    <ul style="font-size: large">
                        <c:forEach items="${couponList}" var="coupon">
                            <li style="margin: 25px">
                                <td>${coupon.couponName}</td>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${couponList.size()==0}">
                    <p>您目前还没有可用的优惠券哦，快去兑换叭</p>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
