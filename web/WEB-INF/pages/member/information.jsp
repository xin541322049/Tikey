<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/2/13
  Time: 下午6:53
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/blog.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/grids-responsive-min.css">
    <link rel="stylesheet" href="/css/info.css">
    <link rel="stylesheet" href="/css/rank.css">
    <link rel="stylesheet" href="/css/rotating-slider.css">
    <link href="/img/Hollywood_Ticket_64px_548853_easyicon.net.ico" rel="shortcut icon" type="image/x-icon">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>

    <style>
        .rotating-slider ul.slides li:nth-of-type(1){background: #3498db;}
        .rotating-slider ul.slides li:nth-of-type(2){background: url('/img/car-oldtimer-snow-342-825x550.jpg');}
        .rotating-slider ul.slides li:nth-of-type(3){background: #e74c3c;}
        .rotating-slider ul.slides li:nth-of-type(4){background: url('/img/analog-camera-old-olympus-om-10-1528-825x550.jpg');}
        .rotating-slider ul.slides li:nth-of-type(5){background: #f1c40f;}
        .rotating-slider ul.slides li:nth-of-type(6){background: url('/img/bridge-city-night-645-827x550.jpg');}
    </style>
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
                        <a style="width: 100px;" class="pure-button" href="/tikey/member/tickets?email=${member.email}&page1=0&page2=0&page3=0&page4=0&index=0">我的订单</a>
                    </li>
                    <li class="nav-item">
                        <a style="width: 100px" class="pure-button" href="/tikey/member/coupons?email=${member.email}">我的优惠券</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">

        <div  style="float: right">
            <a  href="/tikey?email=${member.email}">返回主页</a>
        </div>

        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">基本资料</h1>

                <!-- A single blog post -->
                <div id="info" class="content" style="color: #737373;margin-left: 11.5%">
                    <p style="font-size: 17px">
                        <span class="glyphicon glyphicon-envelope info_icon" style="color: #5aba59; font-size: 25px"></span>
                        邮箱：${member.email}
                    </p>
                    <div id="name_field">
                        <p style="font-size: 17px" id="name">
                            <span class="glyphicon glyphicon-user info_icon" style="color: #4d85d1; font-size: 25px"></span>
                            昵称：${member.name}
                            <a onclick="editName()"><span class="glyphicon glyphicon-pencil"></span></a>
                        </p>
                    </div>
                    <p style="font-size: 17px">
                        <span class="glyphicon glyphicon-bookmark info_icon" style="color: #8156a7; font-size: 25px"></span>
                        会员等级：${member.rank}
                    </p>
                    <p style="font-size: 17px">
                        <span class="glyphicon glyphicon-gift info_icon" style="color: #df2d4f; font-size: 25px"></span>
                        积分：${member.credits}
                    </p>

                    <%--<button class="pure-button join_button" data-toggle="modal" data-target="#cancelModal">会员注销</button>--%>
                    <%--<button class="join_button pure-button" onclick="editPassword()" id="password_button">修改密码</button>--%>

                    <div id="password_field"></div>
                </div>

                <div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <a class="navbar-brand" href="#">
                                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
                            </a>
                            <div class="modal-header" style="top: 25px">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title" id="cancelModalLabel"><br>会员注销</h4>
                            </div>
                            <div class="modal-body">
                                <p>确定要注销会员资格吗？一旦注销不可恢复哦。</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                <button type="button" class="btn btn-primary" onclick="cancelMember()">确认
                                </button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div>
            </div>

            <div class="posts" style="margin-top: 80px">
                <h1 class="content-subhead">我的会员</h1>
                <div class="mature-progress" style="margin-left: 115px">
                    <div class="mature-progress-bottom">
                        <!-- 等级样式  v0 v1 v2 v3 v4 v5 -->
                        <div class="mature-progress-box v0" id="mamture_progress">
                            <dl>
                                <dt>0</dt>
                                <dd><span class="member-ico v0"></span>普通会员</dd>
                            </dl>
                            <dl>
                                <dt>200</dt>
                                <dd><span class="member-ico v1"></span>白银会员</dd>
                            </dl>
                            <dl>
                                <dt>1000</dt>
                                <dd><span class="member-ico v2"></span>黄金会员</dd>
                            </dl>
                            <dl>
                                <dt>5000</dt>
                                <dd><span class="member-ico v3"></span>铂金会员</dd>
                            </dl>
                            <dl>
                                <dt>10000</dt>
                                <dd><span class="member-ico v4"></span>钻石会员</dd>
                            </dl>
                            <div class="progress-box" id="progress_content" data-progress="${member.credits}">
                                <i class="progress-box-1"></i>
                                <!-- 200 -->
                                <i class="progress-box-2"></i>
                                <!-- 1000 -->
                                <i class="progress-box-3"></i>
                                <!-- 5000 -->
                                <i class="progress-box-4"></i>
                                <!-- 10000 -->
                                <i class="progress-box-5"></i>
                                <!-- 10000+ -->
                            </div>
                        </div>
                        <div class="mature-progress-box bgtwos">
                            <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>
                        </div>
                    </div>
                </div>
                <div style="margin-left: 149px; color: #737373; margin-top: 60px">
                    <h3 style="font-size: 18px">会员特权</h3>
                    <ul>
                        <li>全网购票享受${discounts}折！（不能与优惠券同时使用）</li>
                    </ul>
                </div>
            </div>

            <div class="posts" style="margin-top: 120px">
                <h1 class="content-subhead"></h1>
            </div>

            <div class="container">
                <footer class="footer-bottom" style="margin-top: 20px">
                    <p>&copy; Tikey, NJU Software Institute, 2018.</p>
                </footer>
            </div>
        </div>
    </div>

</div>
<script src="/js/rank.js"></script>
</body>

<script>

    function editName() {
        $('#name_input').remove();
        $('#name_field').append("<div  id='name_editor'>" +
            "<input type='text' value='${member.name}' placeholder='请输入喜欢您的昵称' id='name_input'>" +
            "<a onclick='changeName()'><span class='glyphicon glyphicon-floppy-disk' style='margin-left: 7px'></span></a>" +
            "</div>");
    }

    function changeName() {
        $.ajax({
            type: "POST",
            data: {'email': "${member.email}",'name': $("#name_input").val()},
            url: "${pageContext.servletContext.contextPath}/tikey/member/changeName" ,
            error: function (data) {
                console.log(data);
            },
            success: function (data) {
                window.location.href="/tikey/member/detail?email=${member.email}"
            }
        })
    }

    function editPassword() {
        document.getElementById("password_button").setAttribute("class", "pure-button join_button pure-button-disabled")
        $('#password_field').append("<form class=\"pure-form pure-form-stacked\" id='password_form' style='margin-top: 90px'>" +
            "<fieldset style='margin-left: -1%'>" +
            "<label for=\"old_password\" id='old_check'>旧密码" +
            "<input style='width: 190px' id=\"old_password\" type=\"password\" placeholder=\"请正确输入以前的密码\" required=\"required\">" +
            "</label>" +
            "<label for=\"new_password\">新密码" +
            "<input style='width: 190px' id=\"new_password\" type=\"password\" placeholder=\"请输入要更改的新密码\" required=\"required\">" +
            "</lable>" +
            "<label for=\"new_password_check\" id='new_check'>新密码确认" +
            "<input style='width: 190px' id=\"new_password_check\" type=\"password\" placeholder=\"请重复输入新密码\" required=\"required\">" +
            "</label>" +
            "<button style='width: 84px' type=\"button\" class=\"pure-button join_button\" onclick=\"changePassword()\" id='pwd_submit'>" +
            "提交</button>" +
            "<button style='width: 84px' type=\"button\" class=\"pure-button join_button\" onclick=\"cancelChangePassword()\">取消</button>"+
            "</fieldset>" +
            "</form>");
        var str_check ="";
        $("#new_password_check").blur(
            function(){
                //start if
                if($("#new_password_check").val()!=""&&$("#new_password_check").val()!=str_check){
                    //记录上次填入的值
                    console.log("check")
                    str_check = $("#new_password_check").val();
                    if($('#new_password').val() == $("#new_password_check").val()){
                        $('#check_true').remove();
                        $('#check_false').remove();
                        $('#new_check').append("<span id='check_true' class='glyphicon glyphicon-ok-sign' " +
                            "style='color: green; top: 8px'> </span>");
                        document.getElementById("pwd_submit").setAttribute("class", "pure-button join_button");
                    } else {
                        $('#check_true').remove();
                        $('#check_false').remove();
                        $('#new_check').append("<span id='check_false' class='glyphicon glyphicon-remove-sign' " +
                            "style='color: #d06d72; top: 2px'>新密码两次输入不一致</span>");
                        document.getElementById("pwd_submit").setAttribute("class", "pure-button join_button pure-button-disabled");
                    }
                }   //end if
            });
    }

    function changePassword() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/member/changePassword",
            data:  {'email': "${member.email}",'oldPassword':$("#old_password").val(),'newPassword':$("#new_password").val()},
            success:  function(data){
                //$("#ta1").val(data);
                if(data=="success"){
                    $('#password_form').remove();
                    document.getElementById("password_button").setAttribute("class", "pure-button join_button");
                    alert("密码修改成功");
                }else{
                    $('#check_true').remove();
                    $('#check_false').remove();
                    $('#password_false').remove();
                    $('#old_check').append("<span id='password_false' class='glyphicon glyphicon-remove-sign' " +
                        "style='color: #d06d72; top: 2px'>旧密码输入错误</span>");
                }
            }
        });
    }

    function cancelChangePassword() {
        $('#password_form').remove();
        document.getElementById("password_button").setAttribute("class", "pure-button join_button");
    }

    function cancelMember() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/member/cancel",
            data:  {'email': "${member.email}"},
            success: function (data) {
                $('#cancelModal').modal('hide');
                window.location.href="/tikey"
            }
        });
    }

</script>

</html>
