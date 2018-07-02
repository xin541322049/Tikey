<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <link rel="stylesheet" href="/css/uikit.css">
    <link rel="stylesheet" href="/css/uikit-rtl.css">
    <link rel="stylesheet" href="/css/paging.css">
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/uikit-icons.js"></script>
    <script src="/js/uikit.js"></script>
    <script src="/js/paging.js"></script>

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
                        <a class="pure-button" href="/tikey/member/detail?email=${member.email}">返回我的资料</a>
                    </li>
                    <%--<li class="nav-item">--%>
                        <%--<a class="pure-button" href="/tikey/member/coupons?email=${member.email}">我的优惠券</a>--%>
                    <%--</li>--%>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">

        <ul ul uk-switcher="animation: uk-animation-fade" id="tabElement" uk-tab>
            <li><a href="#">未使用/已选座</a></li>
            <li><a href="#">未使用/未选座</a></li>
            <li><a href="#">已使用</a></li>
            <li><a href="#">已退款</a></li>
        </ul>

        <ul class="uk-switcher uk-margin">
            <li>
                <div class="posts">
                    <%--<h1 class="content-subhead">未使用</h1>--%>
                    <c:forEach items="${unusedList}" var="ticket" begin="${page1 * 5}" end="${(page1 + 1) * 5 - 1}">
                    <section class="post" style="margin-bottom: 15px">
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
                                购票时间：${fn:substring(ticket.saleTime,0,19)}<br>
                                <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white; margin-top: -30px; margin-right: 20px "
                                        data-toggle="modal" data-target="#acceptModal" onclick="refundCheck(${ticket.id})">
                                    退票</button>
                            </p>
                        </div>
                    </section>
                    </c:forEach>
                </div>

                <div id="page_page_1" class="page_div"></div>
            </li>
            <li>
                <div class="posts">
                    <c:forEach items="${unseatedList}" var="ticket" begin="${page2 * 5}" end="${(page2 + 1) * 5 - 1}">
                        <section class="post" style="margin-bottom: 15px">
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
                                    购票时间：${fn:substring(ticket.saleTime,0,19)}<br>
                                    <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white; margin-top: -20px; margin-right: 20px "
                                            data-toggle="modal" data-target="#acceptModal" onclick="refundCheck(${ticket.id})">
                                        退票</button>
                                </p>
                            </div>
                        </section>
                    </c:forEach>
                </div>

                <div id="page_page_2" class="page_div"></div>
            </li>
            <li>
                <div class="posts">
                    <%--<h1 class="content-subhead">已使用</h1>--%>
                    <c:forEach items="${usedList}" var="ticket" begin="${page3 * 5}" end="${(page3 + 1) * 5 - 1}">
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
                                    购票时间：${fn:substring(ticket.saleTime,0,19)}<br>
                                </p>
                            </div>
                        </section>
                    </c:forEach>
                </div>

                <div id="page_page_3" class="page_div"></div>
            </li>
            <li>

                <div class="posts">
                    <%--<h1 class="content-subhead">已退款</h1>--%>
                    <c:forEach items="${refundedList}" var="ticket" begin="${page4 * 5}" end="${(page4 + 1) * 5 - 1}">
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
                                    票价：¥${fn:substring(ticket.price, 0, fn:indexOf(ticket.price, ".") + 2)}<br>
                                    <c:if test="${ticket.theRow!=-1}">
                                        位置：${ticket.theRow}排${ticket.theColumn}座<br>
                                    </c:if>
                                    <c:if test="${ticket.theRow==-1}">
                                        位置：未选座<br>
                                    </c:if>
                                    购票时间：${fn:substring(ticket.saleTime,0,19)}<br>
                                    退款金额：${fn:substring(ticket.refund, 0, fn:indexOf(ticket.refund, ".") + 2)}<br>
                                </p>
                            </div>
                        </section>
                    </c:forEach>
                </div>

                <div id="page_page_4" class="page_div"></div>
            </li>
        </ul>

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

    var page_1 = ${page1};
    var page_2 = ${page2};
    var page_3 = ${page3};
    var page_4 = ${page4};
    var index = ${index};
    var page_size = 5;
    var max_page_1 = ${unusedList.size()};
    var max_page_2 = ${unseatedList.size()};
    var max_page_3 = ${usedList.size()};
    var max_page_4 = ${refundedList.size()};
    max_page_1 = Math.ceil(max_page_1 / page_size);
    max_page_2 = Math.ceil(max_page_2 / page_size);
    max_page_3 = Math.ceil(max_page_3 / page_size);
    max_page_4 = Math.ceil(max_page_4 / page_size);

    function changePage(number, newPage) {
        switch (number){
            case 1:
                page_1 = newPage;
                break;
            case 2:
                page_2 = newPage;
                break;
            case 3:
                page_3 = newPage;
                break;
            case 4:
                page_4 = newPage;
                break;
        }
        index = number - 1;
        window.location = "/tikey/member/tickets?email=${member.email}&page1=" + page_1 +"&page2=" + page_2 +"&page3=" + page_3 +"&page4=" + page_4 +"&index=" + index;
    }

    $(document).ready(function(){
        var i = ${index};
        var element = $("#tabElement");
        UIkit.tab(element).show(i);
    });

    $("#page_page_1").paging({
        pageNo:page_1+1,
        totalPage: max_page_1,
        totalSize: ${unusedList.size()},
        callback: function(num) {
            changePage(1,num-1)
        }
    })

    $("#page_page_2").paging({
        pageNo:page_2+1,
        totalPage: max_page_2,
        totalSize: ${unseatedList.size()},
        callback: function(num) {
            changePage(2,num-1)
        }
    })

    $("#page_page_3").paging({
        pageNo:page_3+1,
        totalPage: max_page_3,
        totalSize: ${usedList.size()},
        callback: function(num) {
            changePage(3,num-1)
        }
    })

    $("#page_page_4").paging({
        pageNo:page_4+1,
        totalPage: max_page_4,
        totalSize: ${refundedList.size()},
        callback: function(num) {
            changePage(4,num-1)
        }
    })

</script>
</html>
