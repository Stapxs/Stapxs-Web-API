<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/4
  Time: 下午 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.stapxs.api.appInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="scroll-behavior: smooth;">
<head>
    <title>文档 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/api/doc.css?version=<%=appInfo.version%>-<%=appInfo.build%>">
</head>

<body style="background: var(--color-bg);position: relative;" data-spy="scroll">
    <jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
    <div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
        <div class="container-lg" style="flex: 1;">
            <%-- Code Here …… --%>
                <div class="ml-main" style="margin-top: calc(50vh + 75px);" id="ml-main">
                    <nav id="navbar-example3" class="navbar navbar-light flex-column doc-main-nav ss-card">
                        <div class="main-title"></div>
                        <a style="color: var(--color-main);font-weight: 300;font-size: 0.99rem;">快速导航</a>
                        <div class="ml-tool">
                            <i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.5rem;margin-top: -2px;transform: rotate(180deg);" onclick="downCard(this);"></i>
                            <i class="fa fa-times" aria-hidden="true" onclick="closeCard();"></i>
                        </div>
                        <nav class="nav nav-pills flex-column" id="main-list"></nav>
                    </nav>
                </div>
                <div data-spy="scroll" data-target="#navbar-example3" data-offset="0" class="scrollspy-example-2" id="main-body">
                    <div id="loading-card" class="ss-card" style="text-align: center;margin-bottom: 20px;">
                        <div class="loading-doc">
                            <svg id="history-load" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="cog" class="svg-inline--fa fa-cog fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M487.4 315.7l-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3L380.8 110c-17.9-15.4-38.5-27.3-60.8-35.1V25.8c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7V75c-22.2 7.9-42.8 19.8-60.8 35.1L88.7 85.5c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14L67.3 221c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zM256 336c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z"></path></svg>
                            <br><i id="history-err">少女祈祷中</i>
                        </div>
                    </div>
                </div>
        </div>
        <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
    </div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/api/doc.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
</html>
