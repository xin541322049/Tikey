<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2017/12/18
  Time: 下午9:24
  To modification this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Tikey</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/pure-min.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="/css/carousel.css">
    <link rel="stylesheet" href="/css/unit.css">
  </head>
  <body id="mainBody">
  <nav class="navbar navbar-default navbar-fixed-top header" role="navigation" style="padding-left: 20px; padding-right: 20px">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">
        <img alt="Brand" src="/img/viking_ship_72px_1209600_easyicon.net.ico">
      </a>
      <div class="navbar-header">
        <h1 class="pure-menu-heading">Tikey</h1>
      </div>
      <div style="padding-top: 17px" id="nav_body">
        <ul class="nav navbar-nav" style="padding-top: 15px">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              南京<b class="caret"></b>
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
        </ul>
        <form class="navbar-form navbar-left search" role="search" action="/tikey/search">
          <div class="form-group">
            <input type="text" class="search-input" placeholder="Search" name="term">
            <input type="text" hidden="hidden" name="email" value="${member.email}">
          </div>
          <button type="submit" class="pure-button join-button">搜索</button>
        </form>
        <ul class="nav navbar-nav navbar-right navbar-light" id="visitor_nav">
          <c:if test="${member.email.length()>0}">
            <%--<li style="margin-top: 25px; margin-left: 15px">Welcome ${member.name}!</li>--%>
            <li><a  href="${pageContext.servletContext.contextPath}/tikey/member/detail" onclick="return addEmail();">
              <span class="glyphicon glyphicon-user"></span> 我的</a>
            </li>
            <li><a href="${pageContext.servletContext.contextPath}/tikey">
              <span class="glyphicon glyphicon-log-in"></span> 退出</a>
            </li>
            <form action="/tikey/member/detail" hidden="hidden" id="email-form">
              <input value="${member.email}" name="email">
            </form>
          </c:if>
          <c:if test="${member==null}">
            <li><a data-toggle="modal" href="#registerModal"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
            <li><a data-toggle="modal" href="#logModal"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
          </c:if>
        </ul>
      </div>
    </div>
  </nav>
  <ol class="genres breadcrumb">
    <li class="active genre"><a href="/tikey">首页</a></li>
    <li class="genre"><a href="/tikey?genre=演唱会&email=${member.email}">演唱会</a></li>
    <li class="genre"><a href="/tikey?genre=体育赛事&email=${member.email}">体育赛事</a></li>
    <li class="genre"><a href="/tikey?genre=音乐会&email=${member.email}">音乐会</a></li>
    <li class="genre"><a href="/tikey?genre=歌剧&email=${member.email}">歌剧</a></li>
    <li class="genre"><a href="/tikey?genre=话剧&email=${member.email}">话剧</a></li>
    <li class="genre"><a href="/tikey?genre=儿童亲子&email=${member.email}">儿童亲子</a></li>
    <li class="genre"><a href="/tikey?genre=舞蹈&email=${member.email}">舞蹈</a></li>
    <li class="genre"><a href="/tikey?genre=马戏杂技&email=${member.email}">马戏杂技</a></li>
  </ol>

  <article class="jq22-container" style="margin-bottom: 100px">

    <div class = "caroursel poster-main" data-setting = '{
	        "width":1200,
	        "height":370,
	        "posterWidth":800,
	        "posterHeight":370,
	        "scale":0.8,
	        "dealy":"2000",
	        "algin":"middle"
	    }'>
      <ul class = "poster-list">
        <li class = "poster-item"><img src="https://img2.tking.cn/assets/img/cyKpCMZMEa.jpg" width = "100%" height="100%"></li>
        <li class = "poster-item"><img src="https://img0.tking.cn/assets/img/DJZGrerwaN.jpg" width = "100%" height="100%"></li>
        <li class = "poster-item"><img src="https://img0.tking.cn/assets/img/wwY35nA5Wt.jpg" width = "100%" height="100%"></li>
        <li class = "poster-item"><img src="https://img1.tking.cn/assets/img/7i5ASpE6it.jpg" width = "100%" height="100%"></li>
        <li class = "poster-item"><img src="https://img0.tking.cn/assets/img/7w7McrXKxs.jpg" width = "100%" height="100%"></li>
      </ul>


      <div class = "poster-btn poster-prev-btn"></div>
      <div class = "poster-btn poster-next-btn"></div>

    </div>

  </article>

  <div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <a class="navbar-brand" href="#">
          <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
        </a>
        <div class="modal-header" style="top: 25px">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h4 class="modal-title" id="logModalLabel"><br>会员登录</h4>
        </div>
        <div class="modal-body">
          <form class="form-horizontal" role="form" id="login-form" action="/tikey" onsubmit="return logIn()">
            <div class="form-group">
              <label for="email" class="col-sm-2 control-label">邮箱</label>
              <div class="col-sm-8" id="member_check">
                <input type="email" class="form-control" id="email" placeholder="请输入完整邮箱地址" name="email" required="required">
              </div>
            </div>
            <div class="form-group">
              <label for="password" class="col-sm-2 control-label">密码</label>
              <div class="col-sm-8" id="password_check">
                <input type="password" class="form-control" id="password" placeholder="注意区分大小写" name="password" required="required">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-8">
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="remember" id="remember">记住用户名
                  </label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white" id="login_button">
                  登录</button>
              </div>
            </div>
          </form>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>

  <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <a class="navbar-brand" href="#">
          <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
        </a>
        <div class="modal-header" style="top: 25px">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h4 class="modal-title" id="registerModalLabel"><br>会员注册</h4>
        </div>
        <div class="modal-body">
          <form class="form-horizontal" role="form" action="/tikey/member/register">
            <div class="form-group">
              <label for="emailRegister" class="col-sm-2 control-label">邮箱</label>
              <div class="col-sm-8" id="email_check">
                <input type="email" class="form-control" id="emailRegister" placeholder="请输入正确完整邮箱地址" name="email" required="required">
              </div>
            </div>
            <div class="form-group">
              <label for="nameRegister" class="col-sm-2 control-label">会员昵称</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="nameRegister" placeholder="请给您起一个喜欢的昵称" name="name" required="required">
              </div>
            </div>
            <div class="form-group">
              <label for="passwordRegister" class="col-sm-2 control-label">密码</label>
              <div class="col-sm-8">
                <input type="password" class="form-control" id="passwordRegister" placeholder="密码至多20位" name="password" required="required">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-8" id="button_container">
                <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white" id="register_b">
                  注册</button>
              </div>
            </div>
          </form>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>

  <div class="container" style="width: 1300px; ">
    <h2>热门</h2>
    <c:forEach items="${hotList}" var="performance">
      <div class="single-member effect-2">
        <div class="member-image">
          <img src="${performance.posterUrl}" alt="Member">
        </div>
        <div class="member-info">
          <h3 style="color: #5987c9; font-size: 18px">
            <a href="/tikey/performance/detail/${performance.id}?email=${member.email}">${performance.name}</a>
          </h3>
          <h5 style="color: #737373">${performance.showPlace.name}</h5>
          <p style="color: #737373">${performance.description}</p>
        </div>
      </div>
    </c:forEach>
  </div>

  <div class="container">
    <hr />

    <footer>
      <p>&copy; Tikey, NJU Software Institute, 2018.</p>
      <%--<a href="#" class="btn btn-default">Back to top</a>--%>
      <button type="button" class="btn btn-default" data-toggle="modal" data-target="#applyModal">场馆注册</button>
      <button type="button" class="btn btn-default" data-toggle="modal" data-target="#workInModal">场馆登录</button>
      <button type="button" class="btn btn-default" data-toggle="modal" data-target="#adminModal">管理员登录</button>
    </footer>

    <div class="modal fade" id="applyModal" tabindex="-1" role="dialog" aria-labelledby="applyModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <a class="navbar-brand" href="#">
            <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
          </a>
          <div class="modal-header" style="top: 25px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="applyModalLabel"><br>场馆注册</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal" role="form" action="/tikey/stadium/register">
              <div class="form-group">
                <label for="name_register" class="col-sm-2 control-label">场馆名称</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="name_register" placeholder="请输入完整的场馆名称" name="name" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="password_register" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8">
                  <input type="password" class="form-control" id="password_register" placeholder="密码至多20位" name="password" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="province_register" class="col-sm-2 control-label">场馆地址</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="province_register" placeholder="请输入场馆所在省份" name="province" required="required">
                  <input type="text" class="form-control" id="city_register" placeholder="请输入场馆所在市" name="city" required="required">
                  <input type="text" class="form-control" id="address_register" placeholder="请输入场馆具体地址" name="address" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="account_register" class="col-sm-2 control-label">支付账户</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="account_register" placeholder="请输入完整有效的账户名称" name="account" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="stall_row_register" class="col-sm-2 control-label">池座</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="stall_row_register" placeholder="行个数" name="stallRow" required="required">
                  <input type="text" class="form-control" id="stall_col_register" placeholder="列个数" name="stallCol" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="second_row_register" class="col-sm-2 control-label">二层</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="second_row_register" placeholder="行个数" name="secondRow">
                  <input type="text" class="form-control" id="second_col_register" placeholder="列个数" name="secondCol">
                </div>
              </div>
              <div class="form-group">
                <label for="third_row_register" class="col-sm-2 control-label">三层</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="third_row_register" placeholder="行个数" name="thirdRow">
                  <input type="text" class="form-control" id="third_col_register" placeholder="列个数" name="thirdCol">
                </div>
              </div>
              <div class="form-group">
                <label for="fourth_row_register" class="col-sm-2 control-label">四层（没有请输入0）</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="fourth_row_register" placeholder="行个数" name="fourthRow">
                  <input type="text" class="form-control" id="fourth_col_register" placeholder="列个数" name="fourthCol">
                </div>
              </div>
              <div class="form-group">

              </div>
              <div class="form-group">
                <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white; margin-right: 40px" id="register_btn">
                  注册</button>
              </div>
            </form>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>

    <div class="modal fade" id="workInModal" tabindex="-1" role="dialog" aria-labelledby="workInModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <a class="navbar-brand" href="#">
            <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
          </a>
          <div class="modal-header" style="top: 25px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="workInModalLabel"><br>场馆登录</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal" role="form" id="workIn-form" action="/tikey/stadium/login" onsubmit="return workIn();">
              <div class="form-group">
                <label for="code" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="code" placeholder="请正确输入系统分配的场馆验证码" name="code" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8" id="code_check">
                  <input type="password" class="form-control" id="stdm_password" placeholder="注意区分大小写" name="password" required="required">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="remember" id="code_remember">记住验证码
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                  <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white" id="workin_button">登录</button>
                </div>
              </div>
            </form>
          </div>
        </div><!-- /.modal-content -->
      </div>
    </div>

    <div class="modal fade" id="adminModal" tabindex="-1" role="dialog" aria-labelledby="adminModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <a class="navbar-brand" href="#">
            <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
          </a>
          <div class="modal-header" style="top: 25px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="adminModalLabel"><br>管理员登录</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal" role="form" id="admin-form">
              <div class="form-group">
                <label for="code" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" id="admin_id" placeholder="请正确输入系统管理员验证码" name="id" required="required">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8" id="admin_check">
                  <input type="password" class="form-control" id="admin_password" placeholder="注意区分大小写" name="password" required="required">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                  <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white" onclick="adminCheck()">登录</button>
                </div>
              </div>
            </form>
          </div>
        </div><!-- /.modal-content -->
      </div>
    </div>

  </div>
  </body>

  <script src="/js/jquery-1.8.3.min.js"></script>
  <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/jquery.carousel.js"></script>

  <script type="text/javascript">

      $(function(){
          var str_checkname ="";
          $("#emailRegister").blur(
              function(){
                  //start if
                  if($("#emailRegister").val()!=""&&$("#emailRegister").val()!=str_checkname){
                      //记录上次填入的值
                      str_checkname = $("#emailRegister").val() ;
                      $.ajax({
                          type: "POST",
                          url: "${pageContext.servletContext.contextPath}/tikey/member/register/check",
                          data:  {'email':$("#emailRegister").val()},
                          success:  function(data){
                              //$("#ta1").val(data);
                              if(data=="success"){
                                  $('#check_true').remove();
                                  $('#check_false').remove();
                                  $('#email_check').append("<span id='check_true' class='glyphicon glyphicon-ok-sign' " +
                                      "style='color: green; top: 8px'> </span>");
                                  $('#register_b').remove();
                                  $('#button_container').append("<button type='submit' class='pure-button ' " +
                                      "style='float: right; background: #5987c9; color: white' id='register_b'>\n" +
                                      "                  注册</button>");
                              }else{
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
                  }   //end if
              }); //end button2 click
      });

      function logIn(){
          $.ajax({
              type: "POST",
              data: {'email':$("#email").val(), 'password': $("#password").val(), 'remember': $("#remember").val()},
              url: "/tikey/member/login/check" ,
              success: function (data) {
                  if(data=="success"){
                      // window.location.href="/tikey/member/detail/"+$("#email").val();
                      $('#member_wrong').remove();
                      $('#password_wrong').remove();
                      $('#logModal').modal('hide');
                      // $('#visitor_nav').remove();
                      // $('#nav_body').append(
                      //     "<ul class=\"nav navbar-nav navbar-right navbar-light\" id=\"member_nav\">\n" +
                      //     "<li><a  href='#' id='my_info'><span class=\"glyphicon glyphicon-user\"></span> 我的</a></li>\n" +
                      //     "<li><a  href='/tikey'><span class=\"glyphicon glyphicon-log-in\"></span> 退出</a></li>" +
                      //     "</ul>");
                      // var link = "/tikey/member/detail/";
                      // link = link+$("#email").val();
                      // document.getElementById("my_info").setAttribute("href", link);
                      var form = document.getElementById("login-form");
                      form.submit();
                  }
                  if(data=="no member"){
                      $('#member_wrong').remove();
                      $('#password_wrong').remove();
                      $('#member_check').append("<span id='member_wrong' class='glyphicon glyphicon-remove-sign' " +
                          "style='color: #d06d72; top: 8px'>用该邮箱注册用户不存在</span>");
                  }
                  if(data=="wrong password"){
                      $('#member_wrong').remove();
                      $('#password_wrong').remove();
                      $('#password_check').append("<span id='password_wrong' class='glyphicon glyphicon-remove-sign' " +
                          "style='color: #d06d72; top: 8px'>密码错误</span>");
                  }
                  if(data=="canceled member"){
                      // $('#member_wrong').remove();
                      // $('#password_wrong').remove();
                      $('#logModal').modal('hide');
                      alert("对不起，该邮箱注册的会员已注销");
                  }
              }
          });
          return false;
      }

      function workIn(){
          $.ajax({
              type: "POST",
              data: {'code':$("#code").val(), 'password': $("#stdm_password").val(), 'remember': $("#code_remember").val()},
              url: "/tikey/stadium/login/check" ,
              success: function (data) {
                  if(data==="success"){
                      var form = document.getElementById("workIn-form");
                      form.submit();
                  }
                  if(data==="fail"){
                      $('#stadium_wrong').remove();
                      $('#code_check').append("<span id='stadium_wrong' class='glyphicon glyphicon-remove-sign' " +
                          "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
                  }
              }
          });
          return false;
      }

      function addEmail(){
          var form = document.getElementById("email-form");
          form.submit();
          return false;
      }

      function adminCheck(){
          $.ajax({
              type: "POST",
              data: {'id':$("#admin_id").val(), 'password': $("#admin_password").val()},
              url: "/tikey/manager/login/check" ,
              success: function (data) {
                  if(data==="success"){
                      window.location.href="/tikey/manager/login?id="+$("#admin_id").val()
                          +"&password="+$("#admin_password").val();
                  }
                  if(data==="fail"){
                      $('#admin_wrong').remove();
                      $('#admin_check').append("<span id='admin_wrong' class='glyphicon glyphicon-remove-sign' " +
                          "style='color: #d06d72; top: 8px'>验证码或密码错误</span>");
                  }
              }
          });
      }

  </script>

  <script>
      Caroursel.init($('.caroursel'))
  </script>
</html>
