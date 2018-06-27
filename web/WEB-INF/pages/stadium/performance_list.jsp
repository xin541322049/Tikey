<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 2018/3/17
  Time: 下午10:21
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
    <link rel="stylesheet" href="/css/fileinput.css">
    <link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="/js/moment-with-locales.js"></script>
    <script src="/js/fileinput.js"></script>
    <script src="/js/zh.js"></script>
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
                        <a class="pure-button"
                           href="/tikey/stadium/login?code=${stadium.stadiumCode}&password=${stadium.password}">返回</a>
                    </li>
                    <li class="nav-item">
                        <a class="pure-button" data-toggle="modal" href="#applyModal">演出申请</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <div class="modal fade" id="applyModal" tabindex="-1" role="dialog"
         aria-labelledby="applyModalLabel" aria-hidden="true" style="letter-spacing: 0.015em">
        <div class="modal-dialog">
            <div class="modal-content">
                <a class="navbar-brand" href="#">
                    <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
                </a>
                <div class="modal-header" style="top: 25px">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="applyModalLabel"><br>演出申请</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" action="/tikey/performance/apply/${stadium.stadiumCode}" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="name" class="col-sm-2 control-label">演出名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="name" placeholder="请输入完整的演出名称" name="name" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-sm-2 control-label">演出简介</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="description" placeholder="请输入演出简介" name="description" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="actors" class="col-sm-2 control-label">演出人员</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="actors" placeholder="请演员间请以逗号隔开" name="actors" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="type" class="col-sm-2 control-label">演出类型</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="type" name="type">
                                    <option>演唱会</option>
                                    <option>体育比赛</option>
                                    <option>歌剧</option>
                                    <option>马戏</option>
                                    <option>话剧</option>
                                    <option>舞蹈</option>
                                    <option>儿童亲子</option>
                                    <option>音乐会</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="datetimepicker" class="col-sm-2 control-label">演出日期</label>
                            <div class="col-sm-8">
                                <div class='input-group date' id='datetimepicker'>
                                    <input type='text' class="form-control" name="showtime" id="showtime"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="stall_privce" class="col-sm-2 control-label">票价</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="stall_privce" placeholder="池座票价" name="stallPrice" required="required">
                                <c:if test="${stadium.rowOfSecondFloor>0}">
                                    <input type="text" class="form-control" id="second_privce" placeholder="二楼票价" name="secondPrice" required="required">
                                </c:if>
                                <c:if test="${stadium.rowOfThirdFloor>0}">
                                    <input type="text" class="form-control" id="third_privce" placeholder="三楼票价" name="thirdPrice" required="required">
                                </c:if>
                                <c:if test="${stadium.rowOfFourthFloor>0}">
                                    <input type="text" class="form-control" id="fourth_privce" placeholder="四楼票价" name="fourthPrice" required="required">
                                </c:if>
                                <c:if test="${stadium.rowOfSecondFloor==0}">
                                    <input type="text" class="form-control" name="secondPrice" hidden="hidden" value="0">
                                </c:if>
                                <c:if test="${stadium.rowOfThirdFloor==0}">
                                    <input type="text" class="form-control" name="thirdPrice" hidden="hidden" value="0">
                                </c:if>
                                <c:if test="${stadium.rowOfFourthFloor==0}">
                                    <input type="text" class="form-control" name="fourthPrice" hidden="hidden" value="0">
                                </c:if>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="poster" class="col-sm-2 control-label">演出海报</label>
                            <div class="col-sm-8">
                                <input type="file" class="form-control file" id="poster" placeholder="上传演出海报" name="posterFile" >
                            </div>
                        </div>
                        <div class="form-group">
                            <input id="posterUrl" type="text" name="poster" hidden="hidden">
                            <button type="submit" class="pure-button" style="float: right; background: #5987c9; color: white; margin-right: 40px" id="register_btn">
                                注册</button>
                        </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

    <div class="content pure-u-1 pure-u-md-3-4">
        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">待审批演出</h1>

                <c:forEach items="${applyingList}" var="performance">
                    <section class="post" style="margin-bottom: 70px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <a href="/tikey/stadium/performance/${stadium.stadiumCode}/${performance.id}">
                                <h2 class="post-title">${performance.name}</h2>
                            </a>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <p>
                                ${performance.description}
                            </p>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">正在售票演出</h1>

                <c:forEach items="${saleList}" var="performance">
                    <section class="post" style="margin-bottom: 70px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <a href="/tikey/stadium/performance/${stadium.stadiumCode}/${performance.id}">
                                <h2 class="post-title">${performance.name}</h2>
                            </a>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <p>
                                    ${performance.description}
                            </p>
                            <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white; margin-left: 20px"
                                    onclick="statistic(${performance.id})">
                                查看统计</button>
                            <c:if test="${!performance.distributed}">
                                <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white"
                                        onclick="transportid(${performance.id})">
                                    开始配票</button>
                            </c:if>
                            <c:if test="${performance.distributed}">
                                <button type="button" class="pure-button" style="float: right; background: #5987c9; color: white;"
                                        onclick="transportId(${performance.id})">
                                    结束售票</button>
                            </c:if>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">已结束演出</h1>

                <c:forEach items="${completedList}" var="performance">
                    <section class="post" style="margin-bottom: 70px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <a href="/tikey/stadium/performance/${stadium.stadiumCode}/${performance.id}">
                                <h2 class="post-title">${performance.name}</h2>
                            </a>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <p>
                                    ${performance.description}
                            </p>
                        </div>
                    </section>
                </c:forEach>
            </div>

            <div class="posts">
                <h1 class="content-subhead">已结算演出</h1>

                <c:forEach items="${settledList}" var="performance">
                    <section class="post" style="margin-bottom: 70px">
                        <header class="post-header">
                            <img width="78" height="78" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src=${performance.posterUrl}>

                            <h2 class="post-title">${performance.name}</h2>

                            <p class="post-meta">
                                由 <a href="#" class="post-author">${performance.actors}</a>出演，
                                定于${performance.showTime}演出
                                <c:if test="${performance.type=='Concert'}">
                                    <span class="post-category post-category-concert">演唱会</span>
                                </c:if>
                                <c:if test="${performance.type=='Competition'}">
                                    <span class="post-category post-category-competition">体育比赛</span>
                                </c:if>
                                <c:if test="${performance.type=='Opera'}">
                                    <span class="post-category post-category-opera">歌剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Circus'}">
                                    <span class="post-category post-category-circus">马戏</span>
                                </c:if>
                                <c:if test="${performance.type=='Drama'}">
                                    <span class="post-category post-category-drama">话剧</span>
                                </c:if>
                                <c:if test="${performance.type=='Dance'}">
                                    <span class="post-category post-category-dance">舞蹈</span>
                                </c:if>
                                <c:if test="${performance.type=='ChildPlay'}">
                                    <span class="post-category post-category-child">儿童亲子</span>
                                </c:if>
                                <c:if test="${performance.type=='Music'}">
                                    <span class="post-category post-category-music">音乐会</span>
                                </c:if>
                            </p>
                        </header>

                        <div class="post-description">
                            <div class="row">
                                <div class="col-sm-8">
                                    <p>
                                            ${performance.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:forEach>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="completeModal" tabindex="-1" role="dialog" aria-labelledby="completeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="completeModalLabel"><br>结束售票</h4>
            </div>
            <div class="modal-body">
                <p>确定要结束本场演出的售票吗。</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="complete()">确认
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="distributeModal" tabindex="-1" role="dialog" aria-labelledby="distributeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="/img/viking_ship_48px_1209600_easyicon.net.ico">
            </a>
            <div class="modal-header" style="top: 25px">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="distributeModalLabel"><br>开始配票</h4>
            </div>
            <div class="modal-body">
                <p>配票之后必须选座购买，确定开始配票？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="distribute()">确认
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script>
    $(function(){
        $('#datetimepicker').datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd hh:ii',//显示格式
            minView: 0,//设置只显示到月份
            minuteStep:1,
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn')
    });
        //默认获取当前日期
        var today = new Date();
        var nowdate = (today.getFullYear()) + "-" + (today.getMonth() + 1) + "-" + today.getDate()
            + " " + today.getHours() + ":" + today.getMinutes();
        document.getElementById("showtime").value = nowdate;
    });

    $("#poster").fileinput({
        //上传的地址
        uploadUrl:"/tikey/performance/poster/upload",
        uploadAsync : true, //默认异步上传
        showUpload : false, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption : true,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        maxFileCount : 1, //表示允许同时上传的最大文件个数
        enctype : 'multipart/form-data',
        validateInitialCount : true,
        previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        allowedFileTypes : [ 'image' ],//配置允许文件上传的类型
        allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
        allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
        language : 'zh'
    })

    $("#poster").on("fileuploaded", function(event, data) {
        console.log("fileuploaded");
        var ref = $(this).attr("data-ref");
        console.log(data.response.url);
        document.getElementById("posterUrl").setAttribute("value", data.response.url)
        var poster = document.getElementById("poster")
        poster.setAttribute("value", data.response.url);
        // $("#poster").val(data.response.url);

    });

    var performanceId;
    function transportId(id) {
        performanceId = id;
        $("#completeModal").modal("show");

    }

    function complete() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/stadium/performance/complete",
            data:  {'code': '${stadium.stadiumCode}', 'id': performanceId},
            success:  function(data){
                if(data == "success"){
                    $("#completeModal").modal("hide");
                    location.reload();
                }
            }
        });
    }

    var performanceid;
    function transportid(id) {
        performanceid = id;
        $("#distributeModal").modal("show");

    }

    function distribute() {
        $.ajax({
            type: "POST",
            url: "${pageContext.servletContext.contextPath}/tikey/stadium/performance/distribute",
            data:  {'id': performanceid},
            success:  function(data){
                if(data == "success"){
                    alert("配票成功")
                    location.reload();
                }
            }
        });
    }

    function statistic(id){
        window.location.href="/tikey/stadium/performance/statistics?code=${stadium.stadiumCode}&id="+id;
    }
</script>

</body>
</html>
