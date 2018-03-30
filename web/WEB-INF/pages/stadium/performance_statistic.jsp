<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/27
  Time: 下午10:09
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
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performanceList?code=${stadium.stadiumCode}">返回</a>
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
        $('#container').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: '售票情况统计'
            },
            tooltip: {
                headerFormat: '<b>{point.key}<br /></b>',
                pointFormat: '<span>{point.y} 张<br />占比: {point.percentage:.1f}%</span>'
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
                name: '票类占比',
                data: [['未选座预定', ${unseated}],['选座预定', ${unused}],['退定', ${refunded}],['空座', ${emptys}], ['已检票', ${used}]]
            }]
        });
    });
</script>
</body>
</html>
