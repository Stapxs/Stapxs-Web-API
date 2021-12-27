<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/2
  Time: 下午 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>API 列表 - 林槐服务接口</title>
    <jsp:include page="../module/head.jsp"/>
    <link rel="stylesheet" href="../css/jquery-ui.css">
    <link rel="stylesheet" href="../css/list.css">
</head>
<body style="background: var(--color-bg);color: var(--color-font)">
    <jsp:include page="../module/navbar.jsp"/>
    <div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
        <div class="container-lg" style="flex: 1;">
            <%-- code here …… --%>
                <div id="tabs">
                    <ul class="list-card ss-card">
                        <li><a href="#tabs-1"><i class="fa fa-picture-o" aria-hidden="true"></i><span>图片</span></a></li>
                        <li><a href="#tabs-2"><i class="fa fa-font" aria-hidden="true"></i><span>文本</span></a></li>
                        <li><a href="#tabs-3"><i class="fa fa-sliders" aria-hidden="true"></i><span>工具</span></a></li>
                        <li><a href="#tabs-4"><i class="fa fa-list-alt" aria-hidden="true"></i><span>其他</span></a></li>
                    </ul>
                    <div class="main-card">
                        <div id="tabs-1">
                            <div class="ss-card ana-card ana-card-left">
                                <div></div>
                                <span>图片分类</span>
                            </div>
                        </div>
                        <div id="tabs-2">
                            <div class="ss-card ana-card ana-card-left">
                                <div></div>
                                <span>文本分类</span>
                            </div>
                        </div>
                        <div id="tabs-3">
                            <div class="ss-card ana-card ana-card-left">
                                <div></div>
                                <span>工具分类</span>
                            </div>
                        </div>
                        <div id="tabs-4">
                            <div class="ss-card ana-card ana-card-left">
                                <div></div>
                                <span>其他分类</span>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <jsp:include page="../module/footer.jsp"/>
    </div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/util/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/js/api/list.js"></script>
<script>
    // 初始化 tabs
    $(function() {
        $("#tabs").tabs();
    });
</script>
</html>
