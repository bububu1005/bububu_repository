<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">

    <!--表示使用IE最新的渲染模式进行解析-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--
    	兼容一些移动设备，会根据屏幕的大小缩放
    	width=device-width  表示宽度是设备的宽度（很多手机的宽度都是980px）
    	initial-scale=1  初始化缩放级别   1-5
    	minimum-scale=1  maximum-scale=5
    	user-scalable=no  禁止缩放
    -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>添加或修改视频</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

    <!-- 如果IE版本小于9，加载以下js,解决低版本兼容问题 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


    <!--
    	引入网络的jquery  ,如果想换成自己的，导入即可
    	网站优化：建议将你网站的css\js等代码，放置在互联网公共平台上维护，比如：七牛
    -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <style type="text/css">
        th {
            text-align: center;
        }
    </style>
    <script type="text/javascript">

        function showName(obj, id, type) {
            // if (type == 1) {
            //想获取下拉列表选中的值
            var chooseName = $(obj).text();
            // 将获取的值显示在输入框内
            $("#subject_name").val(chooseName);
            //想给隐藏的文本赋值
            $("#subject_id").val(id);
            // }
        }


        //页面加载完毕之后就执行以下代码片段
        $(function () {
            var speakerId = '${course.subject_id}';
            $("#selectSpeaker li").each(function () {

                if ($(this).val() == speakerId) {
                    $("#subject_name").val($(this).text());
                }
            });
        });

    </script>

</head>
<body>


<nav class="navbar-inverse">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">

            <a class="navbar-brand" href="${pageContext.request.contextPath}/video/list">视频管理系统</a>
        </div>

        <div class="collapse navbar-collapse"
             id="bs-example-navbar-collapse-9">
            <ul class="nav navbar-nav">
                <li><a href="${pageContext.request.contextPath}/video/list">视频管理</a></li>
                <li><a href="${pageContext.request.contextPath}/speaker/showSpeakerList">主讲人管理</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/course/showCourseList">课程管理</a></li>
                <li><a href="${pageContext.request.contextPath}/#">Y先生教育</a></li>

            </ul>
            <p class="navbar-text navbar-right">
                <span>${username}</span> <i class="glyphicon glyphicon-log-in"
                                                         aria-hidden="true"></i>&nbsp;&nbsp;<a
                    href="${pageContext.request.contextPath}/jsp/behind/login.jsp"
                    class="navbar-link">退出</a>
            </p>
        </div>
        <!-- /.navbar-collapse -->


    </div>
    <!-- /.container-fluid -->
</nav>

<div class="jumbotron" style="padding-top: 15px;padding-bottom: 15px;">
    <div class="container">

        <%-- <c:if test="empty ${video.id}"> --%>
        <c:if test="${empty course.id}">
            <h2>添加课程信息</h2>
        </c:if>

        <c:if test="${not empty course.id}">
            <h2>修改课程信息</h2>
        </c:if>

    </div>
</div>


<div class="container" style="margin-top: 20px;">

    <form class="form-horizontal" action="${pageContext.request.contextPath}/course/saveOrUpdate" method="post">


        <c:if test="${not empty course.id}">
            <input type="hidden" name="id" value="${course.id}">
        </c:if>

        <div class="form-group">
            <label class="col-sm-2 control-label">名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="course_title" value="${course.course_title}"
                       placeholder="主讲人名称" required>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">课程</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">下拉菜单<span class="caret"></span></button>
                        <ul id="selectSpeaker" class="dropdown-menu">
                            <c:forEach items="${subjectList}" var="subjects">
                                <li value="${subjects.id}"><a href="#"
                                                              onclick="showName(this,${subjects.id},2)">${subjects.subject_name}</a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div><!-- /btn-group -->
                    <c:if test="${empty course.subject_id}">
                        <input type="hidden" class="form-control" id="subject_id" name="subject_id" value="0">
                    </c:if>
                    <c:if test="${not empty course.subject_id}">
                        <input type="hidden" class="form-control" id="subject_id" name="subject_id"
                               value="${course.subject_id}">
                    </c:if>
                    <input type="text" class="form-control" required onfocus=this.blur() id="subject_name" aria-label="...">
                </div><!-- /input-group -->
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">简介</label>
            <div class="col-sm-10">
                <textarea class="form-control" name="course_desc" rows="3" required>${course.course_desc}</textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">保存</button>
            </div>
        </div>
    </form>

</div>

</body>
</html>
</body>
</html>
