<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/27
  Time: 下午6:07
  To change this template use File | Settings | File Templates.
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
    <script src="/js/highcharts/highcharts.js"></script>
    <script src="/js/highcharts/highcharts-more.js"></script>
    <script src="/js/highcharts/modules/exporting.js"></script>
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
                        <a class="pure-button" href="/tikey/stadium/login?code=${stadium.stadiumCode}">返回</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<div class="container" style="margin-left: 400px; width: 70%; margin-top: 80px" id="container">
</div>

<script>
    $(function () {
        var chart = Highcharts.chart('container', {
            title: {
                text: '场馆财务'
            },
            subtitle: {
                text: '每月收入'
            },
            xAxis: {
                categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
            },
            series: [{
                type: 'column',
                colorByPoint: true,
                data: [${statistic[0]}, ${statistic[1]}, ${statistic[2]}, ${statistic[3]}, ${statistic[4]}, ${statistic[5]},
                    ${statistic[6]}, ${statistic[7]}, ${statistic[8]}, ${statistic[9]}, ${statistic[10]}, ${statistic[11]}],
                showInLegend: false
            }]
        });
    });
</script>
</body>
</html>
