<%@ page import="cn.stapxs.api.appInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/1
  Time: 下午 6:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html prefix="og: https://ogp.me/ns#">
<head>
    <title>林槐服务接口</title>
    <jsp:include page="../module/head.jsp"/>
    <link rel="stylesheet" href="../css/index.css">
</head>

<body style="background: var(--color-bg);">
<jsp:include page="../module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
<div class="container-lg" style="flex: 1;">
    <div class="ss-card wel-card">
        <div>
            <div class="wel-icon">
                <i class="fa fa-plug" aria-hidden="true"></i>
            </div>
            <span id="wel-title">Stapxs Web API</span><br>
            <span id="version">
                <%
                    out.print(appInfo.type + " - " + appInfo.version);
                %>
            </span><br>
            <button id="see-history" class="ss-button" style="margin-top: 20%;width: 80%;">更新日志</button>
        </div>
        <div id="wel-bl-pad" style="position: relative;pointer-events:none;">
            <svg style="opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
            </svg>
            <svg style="margin-left: calc(-70% - 240px);opacity: 1;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
            </svg>
            <svg style="margin-left: calc(-60% - 160px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
            </svg>
            <svg style="margin-left: calc(-40% - 80px);" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
            </svg>
            <svg style="margin-left: -30%;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512">
                <path fill="currentColor" d="M -160 44 c 30 0 58 -18 88 -18 s 58 18 88 18 s 58 -18 88 -18 s 58 18 88 18 v 44 h -352 Z"></path>
            </svg>
        </div>
    </div>
    <div class="wel-card-right">
        <div class="ss-card ana-card">
            <div></div>
            <span id="ana" style="width: 100%;">你好世界！</span>
        </div>
        <div class="ss-card main-card">
            <div>
                <svg style="width: 20px;margin-left: 30%; margin-top: 10%;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 347 443.03"><path fill="currentColor" d="M172,3S141.5,222.5,0,222c142.5-.5,172,218,172,218s43.5-217.5,175-218C215.5,221.5,172,3,172,3Z"></path></svg>
                <svg style="width: 20px;margin-left: 55%; margin-top: 00%;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 347 443.03"><path fill="currentColor" d="M172,3S141.5,222.5,0,222c142.5-.5,172,218,172,218s43.5-217.5,175-218C215.5,221.5,172,3,172,3Z"></path></svg>
                <svg style="width: 20px;margin-left: 90%; margin-top: 20%;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 347 443.03"><path fill="currentColor" d="M172,3S141.5,222.5,0,222c142.5-.5,172,218,172,218s43.5-217.5,175-218C215.5,221.5,172,3,172,3Z"></path></svg>
                <svg style="width: 20px;margin-left: 70%; margin-top: 30%;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 347 443.03"><path fill="currentColor" d="M172,3S141.5,222.5,0,222c142.5-.5,172,218,172,218s43.5-217.5,175-218C215.5,221.5,172,3,172,3Z"></path></svg>
                <svg style="width: 20px;margin-left: 05%; margin-top: 25%;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 347 443.03"><path fill="currentColor" d="M172,3S141.5,222.5,0,222c142.5-.5,172,218,172,218s43.5-217.5,175-218C215.5,221.5,172,3,172,3Z"></path></svg>
                <svg style="margin-left: 010%; margin-top: 05%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                <svg style="margin-left: 070%; margin-top: 15%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                <svg style="margin-left: 100%; margin-top: 00%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                <svg style="margin-left: 040%; margin-top: 30%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                <svg style="margin-left: 095%; margin-top: 30%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
                <svg style="margin-left: 040%; margin-top: 00%;width: 3px;transform: rotate(35deg);" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 13 270"><rect fill="currentColor" x="0.5" y="0.5" width="12" height="269"></rect></svg>
            </div>
            <div>
                <svg style="width: 40px;margin-bottom: 20px;margin-top: 20px;" aria-hidden="true" focusable="false" data-prefix="far" data-icon="grin-tongue-wink" class="svg-inline--fa fa-grin-tongue-wink fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512"><path fill="currentColor" d="M152 180c-25.7 0-55.9 16.9-59.8 42.1-.8 5 1.7 10 6.1 12.4 4.4 2.4 9.9 1.8 13.7-1.6l9.5-8.5c14.8-13.2 46.2-13.2 61 0l9.5 8.5c2.5 2.2 8 4.7 13.7 1.6 4.4-2.4 6.9-7.4 6.1-12.4-3.9-25.2-34.1-42.1-59.8-42.1zm176-52c-44.2 0-80 35.8-80 80s35.8 80 80 80 80-35.8 80-80-35.8-80-80-80zm0 128c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-72c-13.3 0-24 10.7-24 24s10.7 24 24 24 24-10.7 24-24-10.7-24-24-24zM248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm64 400c0 35.6-29.1 64.5-64.9 64-35.1-.5-63.1-29.8-63.1-65v-42.8l17.7-8.8c15-7.5 31.5 1.7 34.9 16.5l2.8 12.1c2.1 9.2 15.2 9.2 17.3 0l2.8-12.1c3.4-14.8 19.8-24.1 34.9-16.5l17.7 8.8V408zm28.2 25.3c2.2-8.1 3.8-16.5 3.8-25.3v-43.5c14.2-12.4 24.4-27.5 27.3-44.5 1.7-9.9-7.7-18.5-17.7-15.3-25.9 8.3-64.4 13.1-105.6 13.1s-79.6-4.8-105.6-13.1c-9.9-3.1-19.4 5.3-17.7 15.3 2.9 17 13.1 32.1 27.3 44.5V408c0 8.8 1.6 17.2 3.8 25.3C91.8 399.9 48 333 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 77-43.8 143.9-107.8 177.3z"></path></svg><br>
                <span style="color: var(--color-main);font-size: 1.3rem;">欢迎使用林槐服务接口</span><br>
                <span>这里有各种好玩的、有用的还有乱七八糟的 API 服务接口</span>
<%--                <hr>--%>
                <div id="main-more">
                    <div>
                        <i class="fa fa-picture-o" aria-hidden="true"></i>
                        <span>图片</span>
                    </div>
                    <div>
                        <i class="fa fa-font" aria-hidden="true"></i>
                        <span>文本</span>
                    </div>
                    <div>
                        <i style="width: 32px;" class="fa fa-sliders" aria-hidden="true"></i>
                        <span>工具</span>
                    </div>
                    <div>
                        <i class="fa fa-list-alt" aria-hidden="true"></i>
                        <span>其他</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ss-card more-card">
        <header><div></div>近期新增</header>
    </div>
</div>
    <jsp:include page="../module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="../js/index.js"></script>
</html>
