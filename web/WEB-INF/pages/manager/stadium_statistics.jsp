<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script>
    var stadiumDistributionData = []
</script>
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
                        <a class="pure-button" href="/tikey/manager/statistics/member">会员统计</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<div class="container" style="margin-left: 400px; width: 70%; margin-top: 80px" id="container"></div>

<c:forEach items="${statistic}" var="statistics" varStatus="status">
    <p id="number-cache-${status.index}">${statistics.x}</p>
    <script>
        var genre = document.getElementById("number-cache-${status.index}").innerHTML;
        var number = Number(${statistics.y});
        stadiumDistributionData.push([genre, number]);
        var cache = document.getElementById("number-cache-${status.index}");
        cache.parentNode.removeChild(cache);
    </script>
</c:forEach>

<script>
    $(function () {
        $('#container').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Tikey注册各场馆演出统计'
            },
            tooltip: {
                headerFormat: '<b>{point.key}<br /></b>',
                pointFormat: '<span>{point.y} 场演出<br />占比: {point.percentage:.1f}%</span>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                },
                series: {
                    colorByPoint: true
                }
            },
            legend:{
                Style: {
                    fontSize:'36px'
                }
            },
            series: [{
                type: 'pie',
                name: '场馆演出占比',
                data: stadiumDistributionData
            }]
        });
    });
</script>
</body>
</html>
