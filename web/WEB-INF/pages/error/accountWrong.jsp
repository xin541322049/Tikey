<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/2/13
  Time: 下午7:35
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付失败</title>
</head>
<body>
<img alt="Brand" src="/img/Hollywood_Ticket_72px_548853_easyicon.net.jpg">
<h2>对不起，您的支付账户错误，购买失败， 请重新选购</h2>
<c:if test="${email.length()==0}">
    <a href="/tikey/stadium/performance/${code}/${id}">点击返回演出</a>
</c:if>
<c:if test="${code.length()==0}">
    <a href="/tikey/performance/detail/${id}?email=${email}">点击返回演出详情</a>
</c:if>
</body>
</html>
