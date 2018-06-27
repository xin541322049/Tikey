<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/21
  Time: 上午11:01
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
    <link rel="stylesheet" href="/css/seat.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.seat-charts.min.js"></script>
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
                        <a class="pure-button" href="/tikey/stadium/performance/${stadium.stadiumCode}/${performance.id}">返回</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" href="/tikey/stadium/performance/checkTicket?code=${stadium.stadiumCode}&id=${performance.id}&ticketId=-1">检票</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<div class="container" style="margin-left: 400px; width: 70%; margin-top: 80px">
    <h2 class="title"><a href="http://www.jq22.com/jquery-info2692">演出选座</a></h2>

    <div class="demo clearfix">

        <!---左边座位列表----->

        <div id="seat_area">

            <div class="front">舞台</div>

        </div>

        <!---右边选座信息----->

        <div class="booking_area">

            <p>演出：<span>${performance.name}</span></p>

            <p>时间：<span>${performance.showTime}</span></p>

            <p>座位：</p>

            <ul id="seats_chose" style="width: 100%"></ul>

            <p>票数：<span id="tickects_num">0</span></p>

            <p>总价：<b>￥<span id="total_price">0</span></b></p>



            <input type="button" class="pure-button" style="background: #fda572; color: white; margin-top: 20px; border-radius: 25px;" value="确定购买" onclick="purchase()"/>



            <div id="legend"></div>

        </div>

    </div>
</div>

<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="couponModalLabel"><br>优惠券使用</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="account_name" class="col-sm-2 control-label">会员邮箱</label>
                        <div class="col-sm-8" id="email_check">
                            <input type="text" class="form-control" id="member_email" placeholder="请输入会员邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <div id = "discounts_field" hidden="hidden" class="col-sm-8">
                            <p>享受 <span id="discounts"></span>折 会员优惠 </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8">
                            <p>支付总额为 ¥<span id="coupon_sum"></span></p>
                        </div>
                    </div>
                </form>
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
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="purchaseModalLabel"><br>支付界面</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="pay-form" action="/tikey/stadium/purchaseWithSeat">
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
                        <input type="text" id="email" name="email" hidden="hidden">
                        <input type="text" id="code" name="code" value="${code}" hidden="hidden">
                        <input type="text" id="id" name="id" value="${performance.id}" hidden="hidden">
                        <input type="text" id="type" name="type" value="${type}" hidden="hidden">
                        <input type="text" id="seats" name="seats" hidden="hidden">
                        <input type="text" id="sumPrice" name="sum" hidden="hidden">
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
    var price = ${price}; //电影票价
    var number = 0;
    var rank = [0.95, 0.9, 0.85, 0.8, 0.7];
    var discounts = 0;
    var sum = 0;

    $(document).ready(function() {

        var $cart = $('#seats_chose'), //座位区

            $tickects_num = $('#tickects_num'), //票数

            $total_price = $('#total_price'); //票价总额

        var seatMap = [];
        if(${type=='stall'}){
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
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfSecondFloor}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfThirdFloor}; i++){
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfThirdFloor}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfFourthFloor}; i++){
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfFourthFloor}; i++){
                seatMap.push(rowSeat);
            }
        }

        if(${type=='second'}){
            var rowSeat = "";
            var i = 0;
            for (i=0; i<${stadium.colOfStall}; i++){
                rowSeat = rowSeat+'_';
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
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfThirdFloor}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfFourthFloor}; i++){
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfFourthFloor}; i++){
                seatMap.push(rowSeat);
            }
        }

        if(${type=='third'}){
            var rowSeat = "";
            var i = 0;
            for (i=0; i<${stadium.colOfStall}; i++){
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfStall}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfSecondFloor}; i++){
                rowSeat = rowSeat+'_';
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
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfFourthFloor}; i++){
                seatMap.push(rowSeat);
            }
        }

        if(${type=='fourth'}){
            var rowSeat = "";
            var i = 0;
            for (i=0; i<${stadium.colOfStall}; i++){
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfStall}; i++){
                seatMap.push(rowSeat);
            }
            rowSeat = "";
            for (i=0; i<${stadium.colOfSecondFloor}; i++){
                rowSeat = rowSeat+'_';
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
                rowSeat = rowSeat+'_';
            }
            for (i=0; i<${stadium.rowOfFourthFloor}; i++){
                seatMap.push(rowSeat);
            }
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

                items: [

                    ['c', 'available', '可选座'],

                    ['c', 'unavailable', '已售出']

                ]

            },

            click: function() {

                if (this.status() == 'available') { //若为可选座状态，添加座位

                    if(number==6){
                        alert("选座购买一次最多买6张");
                        return 'available';
                    } else {
                        $('<li>' + (this.settings.row + 1) + '排' + this.settings.label + '座</li>')

                            .attr('id', 'cart-item-' + this.settings.id)

                            .data('seatId', this.settings.id)

                            .appendTo($cart);



                        $tickects_num.text(sc.find('selected').length + 1); //统计选票数量

                        $total_price.text(getTotalPrice(sc) + price);//计算票价总金额

                        number++;

                        sum = getTotalPrice(sc) + price;



                        return 'selected';
                    }

                } else if (this.status() == 'selected') { //若为选中状态



                    $tickects_num.text(sc.find('selected').length - 1);//更新票数量

                    $total_price.text(getTotalPrice(sc) - price);//更新票价总金额

                    $('#cart-item-' + this.settings.id).remove();//删除已预订座位

                    number--;

                    sum = getTotalPrice(sc) - price;



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
        if(${type=='stall'}){
            for(i=0; i<${stadium.rowOfStall}; i++){
                for (j=0; j<${stadium.colOfStall}; j++){
                    var index = i*${stadium.colOfStall}+j;
                    if(map[index] == '1'){
                        var row = i+1;
                        var col = j+1;
                        var seat = row+'_'+col;
                        console.log(seat);
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        }
        if(${type=='second'}){
            for(i=0; i<${stadium.rowOfSecondFloor}; i++){
                for (j=0; j<${stadium.colOfSecondFloor}; j++){
                    var index = i*${stadium.colOfSecondFloor}+j;
                    if(map[index] == '1'){
                        var row = i+1+${stadium.rowOfStall};
                        var col = j+1;
                        var seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        }
        if(${type=='third'}){
            for(i=0; i<${stadium.rowOfThirdFloor}; i++){
                for (j=0; j<${stadium.colOfThirdFloor}; j++){
                    var index = i*${stadium.colOfThirdFloor}+j;
                    if(map[index] == '1'){
                        var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor};
                        var row = i+1+temp;
                        var col = j+1;
                        var seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        }
        if(${type=='fourth'}){
            for(i=0; i<${stadium.rowOfFourthFloor}; i++){
                for (j=0; j<${stadium.colOfStall}; j++){
                    var index = i*${stadium.colOfStall}+j;
                    if(map[index] == '1'){
                        var temp = ${stadium.rowOfStall}+${stadium.rowOfSecondFloor}+${stadium.rowOfThirdFloor};
                        var row = i+1+temp;
                        var col = j+1;
                        var seat = row+'_'+col;
                        sc.get([seat]).status('unavailable');
                    }
                }
            }
        }

        // sc.get(['1_3', '1_4', '4_4', '4_5', '4_6', '4_7', '4_8']).status('unavailable');



    });



    function getTotalPrice(sc) { //计算票价总额

        var total = 0;

        sc.find('selected').each(function() {

            total += price;

        });

        return total;

    }

    function purchase() {
        $('#coupon_sum').text(sum);
        var str_checkname ="";
        $("#member_email").blur(
            function(){
                //start if
                if($("#member_email").val()!=""&&$("#member_email").val()!=str_checkname){
                    //记录上次填入的值
                    str_checkname = $("#member_email").val() ;
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.servletContext.contextPath}/tikey/stadium/performance/memberCheck",
                        data:  {'email':$("#member_email").val()},
                        success:  function(data){
                            //$("#ta1").val(data);
                            if(data!=-1){
                                $('#check_true').remove();
                                $('#check_false').remove();
                                $('#email_check').append("<span id='check_true' class='glyphicon glyphicon-ok-sign' " +
                                    "style='color: green; top: 8px'> </span>");
                                document.getElementById("discounts_field").removeAttribute("hidden");
                                $('#discounts').text(rank[data]*10)
                                discounts = sum*rank[data];
                                $('#coupon_sum').text(discounts);
                            }else{
                                discounts = sum;
                                $('#check_true').remove();
                                $('#check_false').remove();
                                document.getElementById("discounts_field").setAttribute("hidden", "hidden");
                                $('#email_check').append("<span id='check_false' class='glyphicon glyphicon-remove-sign' " +
                                    "style='color: #d06d72; top: 8px'>用户不存在</span>");
                                $('#coupon_sum').text(sum);
                            }
                        }
                    });
                }   //end if
            });
        $('#couponModal').modal('show')
    }

    function consumeCoupon() {
        $('#couponModal').modal('hide');
        $('#sum').text(discounts);
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
        $("#number").val(number);
        $("#email").val($("#member_email").val());

        payForm.submit();
    }

    var t = 30;
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
        t = 30;
        window.clearTimeout(timer);
        $("#purchaseModal").modal("hide");
    }
</script>
</body>
</html>
