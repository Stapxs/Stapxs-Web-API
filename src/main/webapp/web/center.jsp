<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/12
  Time: 下午 2:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.stapxs.api.appInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="scroll-behavior: smooth;">
<head>
    <title>用户中心 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/api/center.css">
    <script src="${pageContext.request.contextPath}/js/util/clipboard.min.js"></script>
</head>

<body style="background: var(--color-bg);">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <%-- Code Here …… --%>
        <div id="center_err_pan" class="ss-card center-err" style="margin-bottom: 0;">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times" class="svg-inline--fa fa-times fa-w-11" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"><path fill="currentColor" d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg>
            <span id="center_err_msg">好像哪儿不对：但是没啥不对的</span>
        </div>
        <div class="ss-card" style="padding: 0;height: 200px;margin-bottom: 20px;">
            <div class="info-line"></div>
            <div style="display: flex;padding-top: 40px;">
                <div class="avatar-center">
                    <img id="avatar-center-img" src="/img/user-solid-dark.svg" alt="头像">
                </div>
                <div class="info-panel style-info">
                    <i id="id"></i>
                    <i id="name"></i>
                    <i id="nick"></i>
                </div>
                <div id="login_info_pan" class="info-panel login-info" style="display: none;">
                    <i>上次登录信息：</i>
                    <i id="login_time">2021-12-20 13:08:33</i>
                    <i id="login_ip">127.0.0.1</i>
                    <button class="ss-button"><i class="fa fa-sign-out" aria-hidden="true"></i> 退出登录</button>
                </div>
                <div id="exit_button_pan" class="info-panel login-info" style="min-width: 140px;margin-top: 15px;">
                    <button class="ss-button center-exit" title="退出登录"><i class="fa fa-sign-out" aria-hidden="true"></i></button>
                </div>
            </div>
        </div>
        <div class="ss-card" style="margin-bottom: 20px;">
            <header>
                <div></div>管理用户 Key
                <div class="key-control" style="float: right;">
                    <button id="create-key" onclick="createKey()" class="ss-button" title="新建"><i class="fa fa-plus" aria-hidden="true"></i> 新建</button>
                </div>
            </header>
            <div class="ss-card" style="background: var(--color-card-1);margin-bottom: 20px;padding: 20px;margin-top: 10px;">
                <span style="font-size: 0.8rem;">
                    你可以在下面管理属于你的用户 key，这个 key 将用于需要指向你的地方。用于代表 ”指向你创建的东西“，你最多可以创建五个 key。<br>虽然在大部分情况下使用 key 的时候并不危险，但它有权绕过登录系统修改部分属于你的东西（比如在 Doing API 里修改你的 Doing 数据），请仅有必要的情况下分享你的 Key，或发现滥用情况时及时替换他们。
                </span>
            </div>
            <div id="key-body">
                <div class="key-control key-body" id="key-loading">
                    <span>少女祈祷中 ……</span>
                    <svg style="height: 20px;margin-top: 8px;animation: fa-spin 1.5s infinite linear;margin-right: 10px;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="cog" class="svg-inline--fa fa-cog fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M487.4 315.7l-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3L380.8 110c-17.9-15.4-38.5-27.3-60.8-35.1V25.8c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7V75c-22.2 7.9-42.8 19.8-60.8 35.1L88.7 85.5c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14L67.3 221c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zM256 336c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z"></path></svg>                    <div></div>
                </div>
            </div>
        </div>
        <div class="ss-card" style="margin-bottom: 20px;">
            <header>
                <div></div>个性化
            </header>
            <div style="padding: 0 0 0 20px;margin-top: 10px;">
                <div class="set-body">
                    <div>
                        <span>暗黑模式</span>
                        <i>启用更适合夜间以及 OLED 显示设备的暗黑模式。</i>
                    </div>
                    <label class="ss-switch" data-id="0" id="opt0">
                        <input type="checkbox" onchange="changeSet(this);">
                        <div><div></div></div>
                    </label>
                </div>
                <div class="set-body">
                    <div>
                        <span>自动暗黑模式</span>
                        <i>让页面自动跟随系统的颜色模式。</i>
                    </div>
                    <label class="ss-switch" data-id="1" id="opt1">
                        <input type="checkbox" onchange="changeSet(this);">
                        <div><div></div></div>
                    </label>
                </div>
                <div class="set-body" id="color-list">
                    <div>
                        <span>主题色</span>
                        <i>换个颜色换个心情 ~</i>
                    </div>
                    <label class="ss-radio" title="坏猫黄" data-id="4">
                        <input type="radio" name="color" onclick="setMainColor(this);">
                        <div style="background: var(--color-main-4);;"><div></div></div>
                    </label>
                    <label class="ss-radio" title="林槐蓝" data-id="3">
                        <input type="radio" name="color" onclick="setMainColor(this);">
                        <div style="background: var(--color-main-3);;"><div></div></div>
                    </label>
                    <label class="ss-radio" title="天牧红" data-id="2">
                        <input type="radio" name="color" onclick="setMainColor(this);">
                        <div style="background: var(--color-main-2);;"><div></div></div>
                    </label>
                    <label class="ss-radio" title="玄素黑" data-id="1">
                        <input type="radio" name="color" onclick="setMainColor(this);">
                        <div style="background: var(--color-main-1);;"><div></div></div>
                    </label>
                    <label class="ss-radio" title="Zorin 蓝（默认）" data-id="0">
                        <input type="radio" name="color" onclick="setMainColor(this);">
                        <div style="background: var(--color-main-0);"><div></div></div>
                    </label>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/api/center.js?version=<%=appInfo.version%>-<%=appInfo.build%>"></script>
</html>
