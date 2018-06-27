<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/27
  Time: 下午7:37
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
            <h1 class="brand-title">管理员，你好</h1>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/manager/finance">返回</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/manager/statistics/stadium">场馆统计</a>
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
                text: 'Tikey会员分布'
            },
            subtitle: {
                text: '不同等级人数'
            },
            xAxis: {
                categories: ['普通会员', '白银会员', '黄金会员', '铂金会员', '钻石会员', '注销会员']
            },
            series: [{
                type: 'column',
                colorByPoint: true,
                data: [${statistic[0]}, ${statistic[1]}, ${statistic[2]}, ${statistic[3]}, ${statistic[4]}, ${statistic[5]}],
                showInLegend: false
            }]
        });
    });
</script>
</body>
</html>
