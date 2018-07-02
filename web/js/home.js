
Caroursel.init($('.caroursel'));
$(function () {
    var str_checkname = "";
    $("#emailRegister").blur(
        function () {
            //start if
            if ($("#emailRegister").val() != "" && $("#emailRegister").val() != str_checkname) {
                //记录上次填入的值
                str_checkname = $("#emailRegister").val();
                $.ajax({
                    type: "POST",
                    url: "${pageContext.servletContext.contextPath}/tikey/member/register/check",
                    data: {'email': $("#emailRegister").val()},
                    success: function (data) {
                        //$("#ta1").val(data);
                        if (data == "success") {
                            $('#check_true').remove();
                            $('#check_false').remove();
                            $('#email_check').append("<span id='check_true' class='glyphicon glyphicon-ok-sign' " +
                                "style='color: green; top: 8px'> </span>");
                            $('#register_b').remove();
                            $('#button_container').append("<button type='submit' class='pure-button ' " +
                                "style='float: right; background: #5987c9; color: white' id='register_b'>\n" +
                                "                  注册</button>");
                        } else {
                            $('#check_true').remove();
                            $('#check_false').remove();
                            $('#email_check').append("<span id='check_false' class='glyphicon glyphicon-remove-sign' " +
                                "style='color: #d06d72; top: 8px'>该邮箱已注册，请直接登录</span>");
                            $('#register_b').remove();
                            $('#button_container').append("<button type='submit' " +
                                "class='pure-button pure-button-disabled' " +
                                "style='float: right; background: #5987c9; color: white' id='register_b'>\n" +
                                "                  注册</button>");
                        }
                    }
                });
            }
        });
});

function logIn() {
    $.ajax({
        type: "POST",
        data: {'email': $("#email").val(), 'password': $("#password").val(), 'remember': $("#remember").val()},
        url: "/tikey/member/login/check",
        success: function (data) {
            if (data == "success") {
                $('#member_wrong').remove();
                $('#password_wrong').remove();
                $('#logModal').modal('hide');
                var form = document.getElementById("login-form");
                form.submit();
            }
            if (data == "no member") {
                $('#member_wrong').remove();
                $('#password_wrong').remove();
                $('#member_check').append("<span id='member_wrong' class='glyphicon glyphicon-remove-sign' " +
                    "style='color: #d06d72; top: 8px'>用该邮箱注册用户不存在</span>");
            }
            if (data == "wrong password") {
                $('#member_wrong').remove();
                $('#password_wrong').remove();
                $('#password_check').append("<span id='password_wrong' class='glyphicon glyphicon-remove-sign' " +
                    "style='color: #d06d72; top: 8px'>密码错误</span>");
            }
            if (data == "canceled member") {
                // $('#member_wrong').remove();
                // $('#password_wrong').remove();
                $('#logModal').modal('hide');
                alert("对不起，该邮箱注册的会员已注销");
            }
        }
    });
    return false;
}

function workIn() {
    $.ajax({
        type: "POST",
        data: {
            'code': $("#code").val(),
            'password': $("#stdm_password").val(),
            'remember': $("#code_remember").val()
        },
        url: "/tikey/stadium/login/check",
        success: function (data) {
            if (data === "success") {
                var form = document.getElementById("workIn-form");
                form.submit();
            }
            if (data === "fail") {
                $('#stadium_wrong').remove();
                $('#code_check').append("<span id='stadium_wrong' class='glyphicon glyphicon-remove-sign' " +
                    "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
            }
        }
    });
    return false;
}

function addEmail() {
    var form = document.getElementById("email-form");
    form.submit();
    return false;
}

function adminCheck() {
    $.ajax({
        type: "POST",
        data: {'id': $("#admin_id").val(), 'password': $("#admin_password").val()},
        url: "/tikey/manager/login/check",
        success: function (data) {
            if (data === "success") {
                window.location.href = "/tikey/manager/login?id=" + $("#admin_id").val()
                    + "&password=" + $("#admin_password").val();
            }
            if (data === "fail") {
                $('#admin_wrong').remove();
                $('#admin_check').append("<span id='admin_wrong' class='glyphicon glyphicon-remove-sign' " +
                    "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
            }
        }
    });
}