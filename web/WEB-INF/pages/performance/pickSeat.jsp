<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/23
  Time: 上午8:48
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="/css/seat.css">
    <link rel="stylesheet" href="/css/uikit.css">
    <link rel="stylesheet" href="/css/uikit-rtl.css">
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.seat-charts.min.js"></script>
    <script src="/js/uikit.js"></script>
    <script src="/js/uikit-icons.js"></script>
</head>
<body>

<nav class="navbar navbar-default navbar-static-top header">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand no-gap" href="/tikey?email=${member.email}" style="margin-right: 10px">
                <img alt="Brand" src="/img/Hollywood_Ticket_72px_548853_easyicon.net.jpg">
            </a>
            <h3 class="pure-menu-heading" style="margin: 15px;color: #666666">Tikey</h3>
        </div>

        <div class="navbar-site">
            <div class="splitor"></div>
        </div>

        <div id="choose-city" class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="margin-top: 15px">
                    <span class="city-chooser">南京</span><b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">北京</a></li>
                    <li><a href="#">上海</a></li>
                    <li><a href="#">杭州</a></li>
                    <li class="divider"></li>
                    <li><a href="#">大连</a></li>
                    <li><a href="#">武汉</a></li>
                </ul>
            </li>
        </div>

        <div id="search-area" class="nav navbar-nav" style="margin-left: 120px;">
            <form class="form-inline" role="search" action="/tikey/search"  method="post"
                  style="margin-top: 20px; line-height: 40px; height: 40px;">
                <input class="search-input" placeholder="搜索演出、赛事" name="term">
                <input value="${member.email}" name="email" hidden="hidden">
                <button class="pure-button join-button" style="padding-bottom: 8px">
                    <span class="glyphicon glyphicon-search" style="margin-right: 5px"></span>搜索
                </button>
            </form>
        </div>

        <ul id="visitor_nav" class="nav navbar-nav navbar-right" style="margin-top: 25px">
            <c:if test="${member==null}">
                <li class="user-menu"><span data-toggle="modal" href="#registerModal"
                                            style="outline: none; cursor: pointer">
                    <i class="fa fa-user-circle fa-2x"></i>
                        <span style="position:relative;bottom: 5px">注册</span>
                </span></li>

                <li class="user-menu"><span data-toggle="modal" href="#logModal" style="outline: none; cursor: pointer">
                    <i class="fa fa-sign-in fa-2x"></i>
                        <span style="position:relative;bottom: 5px">登录</span>
                </span></li>
            </c:if>

            <c:if test="${member.email.length()>0}">
                <li>
                    <a href="${pageContext.servletContext.contextPath}/tikey/member/detail"
                       onclick="return addEmail();">
                        <span class="glyphicon glyphicon-user"></span> 我的
                    </a>
                </li>
                <li>
                    <a href="${pageContext.servletContext.contextPath}/tikey">
                        <span class="glyphicon glyphicon-log-in"></span> 退出
                    </a>
                </li>
                <form action="/tikey/member/detail" hidden="hidden" id="email-form" method="post">
                    <input value="${member.email}" name="email">
                </form>
            </c:if>
        </ul>
    </div>
</nav>

<script>
    var sum = 0;
    var couponId = -1;
</script>

<div class="container" style="margin-top: 20px; width: 70% ">

    <h2 class="title" style="font-size: 23px; font-weight: 500"><a href="">演出选座</a></h2>

    <div class="demo clearfix">

        <!---左边座位列表----->

        <div id="seat_area">

            <div class="front">舞台</div>

        </div>

        <!---右边选座信息----->

        <div class="booking_area">

            <p>演出：<span>${performance.name}</span></p>

            <p>时间：<span>${fn:substring(performance.showTime,0,16)}</span></p>

            <p>座位：</p>

            <ul id="seats_chose" style="width: 60%"></ul>

            <p>票数：<span id="tickects_num">0</span></p>

            <p>总价：<b>￥<span id="total_price">0</span></b></p>

            <p>折后价：<b>￥<span id="discount_price">0</span></b></p>

            <input type="button" class="pure-button" style="background: #fda572; color: white; margin-top: 20px; border-radius: 25px;" value="确定购买" onclick="purchase()"/>

            <a type="button" class="pure-button"
               style="background: #999999; color: white; margin-top: 20px; border-radius: 25px; text-decoration: none; margin-left: 8px"
               href="/tikey/performance/detail/${performance.id}?email=${member.email}">返回演出</a>

            <div id="legend">
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="couponModalLabel"><br>优惠券使用</h4>
            </div>
            <div class="modal-body">
                <button style="width: 200px" id="select_coupon_icon" class="uk-button uk-button-default" type="button">选择优惠券</button>
                <div uk-dropdown>
                    <ul class="uk-nav uk-dropdown-nav">
                        <li><a href="#" onclick="setCouponId(-1, 0, '不使用')">不使用</a></li>
                        <c:forEach items="${couponList}" var="coupon">
                            <li><a href="#" onclick="setCouponId(${coupon.id}, ${coupon.discounts}, '${coupon.couponName}')">${coupon.couponName}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <p>使用优惠券后支付总额为 ¥<span id="coupon_sum"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="giveUpCoupon()">不使用，直接支付</button>
                <button type="button" class="btn btn-primary" onclick="consumeCoupon()">确认使用并支付
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="purchaseModal" tabindex="-1" role="dialog" aria-labelledby="purchaseModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/Hollywood_Ticket_64px_548853_easyicon.net.jpg">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="purchaseModalLabel"><br>支付界面</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="pay-form" action="/tikey/performance/purchaseWithSeat">
                    <div class="form-group">
                        <label for="account_name" class="col-sm-2 control-label">账户名</label>
                        <div class="col-sm-8" id="member_check">
                            <input type="text" class="form-control" id="account_name" placeholder="请输入正确支付账户名" name="accountName" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">支付密码</label>
                        <div class="col-sm-8" id="password_check">
                            <input type="password" class="form-control" id="password" placeholder="注意区分大小写" name="accountPassword" required="required">
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <p>支付总额为 ¥<span id="sum"></span></p>
                    </div>
                    <div class="col-sm-8">
                        <p>支付时间还剩 <span id="time"></span> 秒</p>
                    </div>
                    <div class="form-group">
                        <input type="text" id="email" name="email" value="${email}" hidden="hidden">
                        <input type="text" id="id" name="id" value="${performance.id}" hidden="hidden">
                        <input type="text" id="type" name="type" value="${type}" hidden="hidden">
                        <input type="text" id="seats" name="seats" hidden="hidden">
                        <input type="text" id="sumPrice" name="sum" hidden="hidden">
                        <input type="text" id="couponId" name="couponId" hidden="hidden">
                        <input type="text" id="number" name="number" hidden="hidden">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <button type="button" class="pure-button" onclick="clearTimer()" style="float: right; margin-left: 10px">取消支付</button>
                            <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white" id="login_button" onclick="pay()">
                                确认支付</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script>
    var sum_price = 0;
    var price = ${price}; //电影票价
    var number = 0;
    var rank = [0.95, 0.9, 0.85, 0.8, 0.7];
    var discounts = 0;

    // $(function(){
    //     $("#coupon_select").change(
    //         function(){
    //             var myselect=document.getElementById("coupon_select");
    //             var index = myselect.selectedIndex;
    //             if(index==0){
    //                 discounts = sum;
    //             }
    //             else {
    //                 discounts = sum-parseInt(myselect.options[index].getAttribute("name"));
    //             }
    //             $("#coupon_sum").text(discounts);
    //         }); //end button2 click
    // });

    $(document).ready(function() {

        var $cart = $('#seats_chose'), //座位区

            $tickects_num = $('#tickects_num'), //票数

            $discount_price = $('#discount_price'),

            $total_price = $('#total_price'); //票价总额

        var seatMap = [];
        <%--if(${type=='stall'}){--%>
            var rowSeat = "";
            var i = 0;
            for (i=0; i<${stadium.colOfStall}; i++){
                rowSeat = rowSeat+'c';
            }
            for (i=0; i<${stadium.rowOfStall}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfSecondFloor}; i++){
                rowSeat = rowSeat+'c';
            }
            for (i=0; i<${stadium.rowOfSecondFloor}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfThirdFloor}; i++){
                rowSeat = rowSeat+'c';
            }
            for (i=0; i<${stadium.rowOfThirdFloor}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfFourthFloor}; i++){
                rowSeat = rowSeat+'c';
            }
            for (i=0; i<${stadium.rowOfFourthFloor}; i++){
                seatMap.push(rowSeat);
            }
        // }

        <%--if(${type=='second'}){--%>
            <%--var rowSeat = "";--%>
            <%--var i = 0;--%>
            <%--for (i=0; i<${stadium.colOfStall}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfStall}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfSecondFloor}; i++){--%>
                <%--rowSeat = rowSeat+'c';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfSecondFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfThirdFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfThirdFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfFourthFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfFourthFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
        <%--}--%>

        <%--if(${type=='third'}){--%>
            <%--var rowSeat = "";--%>
            <%--var i = 0;--%>
            <%--for (i=0; i<${stadium.colOfStall}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfStall}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfSecondFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfSecondFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfThirdFloor}; i++){--%>
                <%--rowSeat = rowSeat+'c';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfThirdFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfFourthFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfFourthFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
        <%--}--%>

        <%--if(${type=='fourth'}){--%>
            <%--var rowSeat = "";--%>
            <%--var i = 0;--%>
            <%--for (i=0; i<${stadium.colOfStall}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfStall}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfSecondFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfSecondFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfThirdFloor}; i++){--%>
                <%--rowSeat = rowSeat+'c';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfThirdFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
            <%--rowSeat = "";--%>
            <%--for (i=0; i<${stadium.colOfFourthFloor}; i++){--%>
                <%--rowSeat = rowSeat+'_';--%>
            <%--}--%>
            <%--for (i=0; i<${stadium.rowOfFourthFloor}; i++){--%>
                <%--seatMap.push(rowSeat);--%>
            <%--}--%>
        <%--}--%>
        var l_list = [

            ['c', 'unavailable', '已售出'],

            ['c', 'available stall', '¥${performance.stallPrice}'],

        ]
        if(${performance.secondPrice > 0}){
            l_list.push(['c', 'available second', '¥${performance.secondPrice}'])
        }

        if(${performance.thirdPrice > 0}){
            l_list.push(['c', 'available third', '¥${performance.thirdPrice}'])
        }

        if(${performance.fourthPrice > 0}){
            l_list.push(['c', 'available forth', '¥${performance.fourthPrice}'])
        }

        var sc = $('#seat_area').seatCharts({

            map: seatMap,

            naming: {//设置行列等信息

                top: false, //不显示顶部横坐标（行）

                getLabel: function(character, row, column) { //返回座位信息

                    return column;

                }

            },

            legend: {//定义图例

                node: $('#legend'),

                items: l_list

            },

            click: function() {

                var id = (this.settings.row+1) + '_' + (this.settings.column+1);

                price = parseInt(document.getElementById(id).value);

                if (this.status() == 'available') { //若为可选座状态，添加座位

                    if(number==6){
                        alert("选座购买一次最多买6张");
                        return 'available';
                    } else {
                        number++;
                        $('<li>' + (this.settings.row + 1) + '排' + this.settings.label + '座</li>')

                            .attr('id', 'cart-item-' + this.settings.id)

                            .data('seatId', this.settings.id)

                            .appendTo($cart);



                        $tickects_num.text(sc.find('selected').length + 1); //统计选票数量

                        $total_price.text(getTotalPrice(sc)+price);//计算票价总金额

                        $discount_price.text((getTotalPrice(sc)+price)*rank[${member.rank}]);

                        sum = (getTotalPrice(sc)+price)*rank[${member.rank}];



                        return 'selected';
                    }

                } else if (this.status() == 'selected') { //若为选中状态



                    $tickects_num.text(sc.find('selected').length - 1);//更新票数量

                    $total_price.text(getTotalPrice(sc) - price);//更新票价总金额

                    $discount_price.text((getTotalPrice(sc) - price)*rank[${member.rank}]);

                    sum = (getTotalPrice(sc)-price)*rank[${member.rank}];

                    $('#cart-item-' + this.settings.id).remove();//删除已预订座位
                    number--;


                    return 'available';

                } else if (this.status() == 'unavailable') { //若为已售出状态

                    return 'unavailable';

                } else {

                    return this.style();

                }

            }

        });

        //设置已售出的座位

        var i = 0;
        var j = 0;
        var map = '${saleMatrix}';
        <%--if(${type=='stall'}){--%>
            for(i=0; i<${stadium.rowOfStall}; i++){
                for (j=0; j<${stadium.colOfStall}; j++){
                    var index = i*${stadium.colOfStall}+j;
                    if(map[index] == '1'){
                        var row = i+1;
                        var col = j+1;
                        var seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        // }
        <%--if(${type=='second'}){--%>
            for(i=0; i<${stadium.rowOfSecondFloor}; i++){
                for (j=0; j<${stadium.colOfSecondFloor}; j++){
                    index = i*${stadium.colOfSecondFloor}+j+${stadium.rowOfStall*stadium.colOfStall};
                    if(map[index] == '1'){
                        row = i+1+${stadium.rowOfStall};
                        col = j+1;
                        seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        // }
        <%--if(${type=='third'}){--%>
            for(i=0; i<${stadium.rowOfThirdFloor}; i++){
                for (j=0; j<${stadium.colOfThirdFloor}; j++){
                    index = i*${stadium.colOfThirdFloor}+j+${stadium.rowOfStall*stadium.colOfStall}+${stadium.rowOfSecondFloor*stadium.colOfSecondFloor};
                    if(map[index] == '1'){
                        var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor};
                        row = i+1+temp;
                        col = j+1;
                        seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        // }
        <%--if(${type=='fourth'}){--%>
            for(i=0; i<${stadium.rowOfFourthFloor}; i++){
                for (j=0; j<${stadium.colOfStall}; j++){
                    index = i*${stadium.colOfFourthFloor}+j
                        +${stadium.rowOfStall*stadium.colOfStall}
                        +${stadium.rowOfSecondFloor*stadium.colOfSecondFloor}
                        +${stadium.rowOfThirdFloor*stadium.colOfThirdFloor};
                    if(map[index] == '1'){
                        var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor}+${stadium.rowOfThirdFloor};
                        row = i+1+temp;
                        col = j+1;
                        seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        // }
    });

    //区分不同区域座位的价格
    $(document).ready(function() {
        var i=0
        var j = 0
        for(i=0; i<${stadium.rowOfStall}; i++){
            for (j=0; j<${stadium.colOfStall}; j++){
                var row = i+1;
                var col = j+1;
                var id = row+'_'+col;
                var seat = document.getElementById(id);
                seat.classList.add("stall");
                seat.value = ${performance.stallPrice};
            }
        }

        for(i=0; i<${stadium.rowOfSecondFloor}; i++){
            for (j=0; j<${stadium.colOfSecondFloor}; j++){
                row = row = i+1+${stadium.rowOfStall};
                col = j+1;
                id = row+'_'+col;
                seat = document.getElementById(id);
                seat.classList.add("second");
                seat.value = ${performance.secondPrice};
            }
        }

        for(i=0; i<${stadium.rowOfThirdFloor}; i++){
            for (j=0; j<${stadium.colOfThirdFloor}; j++){
                var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor};
                row = i+1+temp;
                col = j+1;
                id = row+'_'+col;
                seat = document.getElementById(id);
                seat.classList.add("third");
                seat.value = ${performance.thirdPrice};
            }
        }

        for(i=0; i<${stadium.rowOfFourthFloor}; i++){
            for (j=0; j<${stadium.colOfFourthFloor}; j++){
                var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor}+${stadium.rowOfThirdFloor};
                row = i+1+temp;
                col = j+1;
                id = row+'_'+col;
                seat = document.getElementById(id);
                seat.classList.add("forth");
                seat.value = ${performance.fourthPrice};
            }
        }
    });

    function addEmail(){
        var form = document.getElementById("email-form");
        form.submit();
        return false;
    }

    function getTotalPrice(sc) { //计算票价总额

        var total = 0;

        sc.find('selected').each(function() {

            var id = (this.settings.row+1) + '_' + (this.settings.column+1);

            p = parseInt(document.getElementById(id).value);

            total += p;

        });

        return total;

    }

    function purchase() {
        var couponValid = 0;

        var seatMap = document.getElementById("seats_chose");
        var lis = seatMap.getElementsByTagName("li");
        if(lis.length == 0){
            alert("请先选择您喜欢的座位，然后点击确定购买")
            return;
        }

        if(${couponList.size()>0}){
            $('#coupon_sum').text(sum);
            $('#couponModal').modal('show')
        }
        else{
            $('#sum').text(sum);
            $('#purchaseModal').modal('show');
            showTime();
        }
    }

    function consumeCoupon() {
        sum = discounts;
        $('#couponModal').modal('hide');
        $('#sum').text(sum);
        $('#purchaseModal').modal('show');
        showTime();
    }

    function giveUpCoupon() {
        $('#couponModal').modal('hide');
        $('#sum').text(sum);
        $('#purchaseModal').modal('show');
        showTime();
    }

    function pay() {
        var payForm = document.getElementById("pay-form");
        var seatMap = document.getElementById("seats_chose");
        var lis = seatMap.getElementsByTagName("li");
        var seatInfo = "";
        var i = 0;
        for (i=0; i<lis.length-1; i++){
            seatInfo = seatInfo+lis.item(i).innerText+",";
        }
        seatInfo = seatInfo + lis.item(lis.length-1).innerText;
        $("#seats").val(seatInfo);
        $("#sumPrice").val(sum);
        $("#couponId").val(couponId);
        $("#number").val(number);

        payForm.submit();
    }

    var t = 90;
    var timer;
    //显示倒数秒数
    function showTime(){
        t -= 1;
        document.getElementById('time').innerHTML= t;
        if(t==0){
            location.href="/tikey/performance/cancel?id=${performance.id}&email=${email}";
        }
        //每秒执行一次,showTime()
        timer = setTimeout("showTime()",1000);
    }

    function clearTimer() {
        t = 90;
        window.clearTimeout(timer);
        $("#purchaseModal").modal("hide");
    }

    function setCouponId(id, discount, name) {
        couponId = id;
        if(id==0){
            discounts = sum;
        }
        else {
            discounts = sum-parseInt(discount);
        }
        $("#select_coupon_icon").text(name);
        $("#coupon_sum").text(discounts);
    }

</script>

</body>
</html>
