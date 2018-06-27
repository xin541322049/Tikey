<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/17
  Time: 上午10:49
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
    <link rel="stylesheet" href="/css/info.css">
    <link rel="stylesheet" href="/css/rank.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div id="layout" class="pure-g">
    <div class="sidebar pure-u-1 pure-u-md-1-4">
        <div class="header">
            <h1 class="brand-title">${stadium.name}</h1>
            <%--<h2 class="brand-tagline">在 Tikey,<br>发现你从未见过的世界</h2>--%>
            <nav class="nav">
                <ul class="nav-list">
                    <c:if test="${stadium.state=='unAccepted'}">
                        <li class="nav-item">
                            <a class="pure-button pure-button-disabled" href="/tikey/stadium/performanceList?code=${stadium.stadiumCode}">场馆演出</a>
                        </li>
                        <li class="nav-item">
                            <a class="pure-button pure-button-disabled" href="/tikey/stadium/finance?code=${stadium.stadiumCode}">场馆财务</a>
                        </li>
                    </c:if>

                    <c:if test="${stadium.state=='Valid'}">
                        <li class="nav-item">
                            <a class="pure-button" href="/tikey/stadium/performanceList?code=${stadium.stadiumCode}">场馆演出</a>
                        </li>
                        <li class="nav-item">
                            <a class="pure-button" href="/tikey/stadium/finance?code=${stadium.stadiumCode}">场馆财务</a>
                        </li>
                    </c:if>
                </ul>
                <form hidden="hidden" id="code-form">
                    <input value="${stadium.stadiumCode}" name="code">
                </form>
            </nav>
        </div>
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div  style="float: right">
            <a  href="/tikey">退出</a>
        </div>

        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">场馆状态</h1>
                <div class="mature-progress" style="margin-left: 115px">
                    <div class="mature-progress-bottom">
                        <!-- 等级样式  v0 v1 v2 v3 v4 v5 -->
                        <div class="mature-progress-box v0" id="mamture_progress">
                            <dl>
                                <dt>1</dt>
                                <dd><span class="member-ico v0"></span>申请中</dd>
                            </dl>
                            <dl>
                                <dt>2</dt>
                                <dd><span class="member-ico v1"></span>已审核</dd>
                            </dl>
                            <c:if test="${stadium.state=='Valid'}">
                                <div class="progress-box" id="progress_content" data-progress="1">
                                    <i class="progress-box-1"></i>
                                    <i class="progress-box-2"></i>
                                </div>
                            </c:if>
                            <c:if test="${stadium.state=='unAccepted'}">
                                <div class="progress-box" id="progress_content" data-progress="0">
                                    <i class="progress-box-1"></i>
                                    <i class="progress-box-2"></i>
                                </div>
                            </c:if>
                        </div>
                        <div class="mature-progress-box bgtwos">
                            <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>
                        </div>
                    </div>
                </div>
            </div>

            <div class="posts"  style="margin-top: 140px">
                <h1 class="content-subhead">场馆信息</h1>

                <!-- A single blog post -->
                <div id="info" class="content" style="color: #737373">
                    <p id="name">
                        <span class="glyphicon glyphicon-user info_icon" style="color: #4d85d1"></span>
                        场馆名称：${stadium.name}
                    </p>
                    <p>
                        <span class="glyphicon glyphicon-tag info_icon" style="color: #5aba59"></span>
                        场馆验证码：${stadium.stadiumCode}
                    </p>
                    <p>
                        <span class="glyphicon glyphicon-home info_icon" style="color: #8156a7"></span>
                        场馆地址：${stadium.province}省 ${stadium.city}市 ${stadium.address}
                    </p>
                    <p>
                        <span class="glyphicon glyphicon-usd info_icon" style="color: #df2d4f"></span>
                        场馆账户名：${stadium.accountName}
                    </p>

                    <c:if test="${stadium.state=='Valid'}">
                        <c:if test="${changeApplied==1}">
                            <button class="pure-button join_button pure-button-disabled">修改申请已提交</button>
                        </c:if>
                        <c:if test="${changeApplied!=1}">
                            <button class="pure-button join_button" data-toggle="modal" data-target="#applyModal">修改信息</button>
                        </c:if>
                        <button class="join_button pure-button" onclick="editPassword()" id="password_button">修改密码</button>

                        <div id="password_field"></div>
                    </c:if>
                </div>

                <div class="modal fade" id="applyModal" tabindex="-1" role="dialog" aria-labelledby="applyModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <a class="navbar-brand" href="#">
                                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
                            </a>
                            <div class="modal-header" style="top: 25px">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title" id="applyModalLabel"><br>场馆信息修改</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal" role="form" action="/tikey/stadium/changeInfo">
                                    <div class="form-group">
                                        <label for="name_register" class="col-sm-2 control-label">场馆名称</label>
                                        <div class="col-sm-8">
                                            <input type="text" hidden="hidden" name="code" value="${stadium.stadiumCode}">
                                            <input type="text" class="form-control" id="name_register" value="${stadium.name}"
                                                   placeholder="请输入完整的场馆名称" name="name" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="province_register" class="col-sm-2 control-label">场馆地址</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="province_register" value="${stadium.province}"
                                                   placeholder="请输入场馆所在省份" name="province" required="required">
                                            <input type="text" class="form-control" id="city_register" value="${stadium.city}"
                                                   placeholder="请输入场馆所在市" name="city" required="required">
                                            <input type="text" class="form-control" id="address_register" value="${stadium.address}"
                                                   placeholder="请输入场馆具体地址" name="address" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="account_register" class="col-sm-2 control-label">支付账户</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="account_register" value="${stadium.accountName}"
                                                   placeholder="请输入完整有效的账户名称" name="account" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="stall_row_register" class="col-sm-2 control-label">池座</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="stall_row_register" value="${stadium.rowOfStall}"
                                                   placeholder="行个数" name="stallRow" required="required">
                                            <input type="text" class="form-control" id="stall_col_register" value="${stadium.colOfStall}"
                                                   placeholder="列个数" name="stallCol" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="second_row_register" class="col-sm-2 control-label">二层</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="second_row_register" value="${stadium.rowOfSecondFloor}"
                                                   placeholder="行个数" name="secondRow">
                                            <input type="text" class="form-control" id="second_col_register" value="${stadium.colOfSecondFloor}"
                                                   placeholder="列个数" name="secondCol">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="third_row_register" class="col-sm-2 control-label">三层</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="third_row_register" value="${stadium.rowOfThirdFloor}"
                                                   placeholder="行个数" name="thirdRow">
                                            <input type="text" class="form-control" id="third_col_register" value="${stadium.colOfThirdFloor}"
                                                   placeholder="列个数" name="thirdCol">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="fourth_row_register" class="col-sm-2 control-label">四层</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="fourth_row_register" value="${stadium.rowOfFourthFloor}"
                                                   placeholder="行个数" name="fourthRow">
                                            <input type="text" class="form-control" id="fourth_col_register" value="${stadium.colOfFourthFloor}"
                                                   placeholder="列个数" name="fourthCol">
                                        </div>
                                    </div>
                                    <div class="form-group">

                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white; margin-right: 40px" id="register_btn">
                                            申请</button>
                                    </div>
                                </form>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div>
            </div>

            <div class="footer">
                <div class="pure-menu pure-menu-horizontal">
                    <ul>
                        <li class="pure-menu-item"><a href="http://purecss.io/" class="pure-menu-link">About</a></li>
                        <li class="pure-menu-item"><a href="http://twitter.com/yuilibrary/" class="pure-menu-link">Twitter</a></li>
                        <li class="pure-menu-item"><a href="http://github.com/yahoo/pure/" class="pure-menu-link">GitHub</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/state.js"></script>

</body>

<script>
    function editPassword() {
        document.getElementById("password_button").setAttribute("class", "pure-button join_button pure-button-disabled")
        $('#password_field').append("<form class=\"pure-form pure-form-stacked\" id='password_form' style='margin-top: 90px'>" +
            "<fieldset>" +
            "<label for=\"old_password\" id='old_check'>旧密码" +
            "<input id=\"old_password\" type=\"password\" placeholder=\"请正确输入以前的密码\" required=\"required\">" +
            "</label>" +
            "<label for=\"new_password\">新密码</label>" +
            "<input id=\"new_password\" type=\"password\" placeholder=\"请输入要更改的新密码\" required=\"required\">" +
            "<label for=\"new_password_check\" id='new_check'>新密码确认" +
            "<input id=\"new_password_check\" type=\"password\" placeholder=\"请重复输入新密码\" required=\"required\">" +
            "</label>" +
            "<button type=\"button\" class=\"pure-button join_button\" onclick=\"changePassword()\" id='pwd_submit'>" +
            "提交</button>" +
            "<button type=\"button\" class=\"pure-button join_button\" onclick=\"cancelChangePassword()\">取消</button>"+
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
                            "style='color: #d06d72; top: 8px'>新密码两次输入不一致</span>");
                        document.getElementById("pwd_submit").setAttribute("class", "pure-button join_button pure-button-disabled");
                    }
                }   //end if
            });
    }

    function changePassword() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/stadium/changePassword",
            data:  {'code': "${stadium.stadiumCode}",'oldPassword':$("#old_password").val(),'newPassword':$("#new_password").val()},
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
                        "style='color: #d06d72; top: 8px'>旧密码输入错误</span>");
                }
            }
        });
    }

    function cancelChangePassword() {
        $('#password_form').remove();
        document.getElementById("password_button").setAttribute("class", "pure-button join_button");
    }

    function addCode(location) {
        var form = document.getElementById("code-form")
        if(location=="performanceList") {
            form.setAttribute("action", "/tikey/stadium/performanceList");
        } else {
            form.setAttribute("action", "tikey/stadium/finance");
        }
        form.submit();
        return false;
    }

</script>

</html>
