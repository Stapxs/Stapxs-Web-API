<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/26
  Time: 上午 9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/api/account.css">
</head>

<body style="background: var(--color-bg);">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <%-- Code Here …… --%>
        <div id="pan-main" class="main-pan">
            <div id="login-pan" class="login-box-1">
                <div class="login-pan ss-card">
                    <div id="login-body" class="login-body-1">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="fish" class="fish svg-inline--fa fa-fish fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="currentColor" d="M327.1 96c-89.97 0-168.54 54.77-212.27 101.63L27.5 131.58c-12.13-9.18-30.24.6-27.14 14.66L24.54 256 .35 365.77c-3.1 14.06 15.01 23.83 27.14 14.66l87.33-66.05C158.55 361.23 237.13 416 327.1 416 464.56 416 576 288 576 256S464.56 96 327.1 96zm87.43 184c-13.25 0-24-10.75-24-24 0-13.26 10.75-24 24-24 13.26 0 24 10.74 24 24 0 13.25-10.75 24-24 24z"></path></svg>
                        <br><span class="main-title">林槐账户服务</span>
                        <form onsubmit="return loginAcc();">
                            <input id="inuname" style="margin-top: 30px;" type="text" class="form-control" placeholder="用户名" aria-label="用户名">
                            <input id="inupwd" type="password" class="form-control" placeholder="密码" aria-label="密码">
                            <div class="fog-pwd"><span>忘记密码</span></div>
                            <button id="go-btn" type="submit" class="login-bt">
                                <svg id="go-icon" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" class="svg-inline--fa fa-angle-right fa-w-8" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path id="go-icon-path" fill="currentColor" d="M224.3 273l-136 136c-9.4 9.4-24.6 9.4-33.9 0l-22.6-22.6c-9.4-9.4-9.4-24.6 0-33.9l96.4-96.4-96.4-96.4c-9.4-9.4-9.4-24.6 0-33.9L54.3 103c9.4-9.4 24.6-9.4 33.9 0l136 136c9.5 9.4 9.5 24.6.1 34z"></path></svg>
                            </button>
                        </form>
                        <br><span class="no-acc">没有账号？<a onclick="showRegPan();">注册</a></span>
                        <label class="back-button" id="back-button">
                            <input type="button" onclick="backRegPan();" style="display: none;">
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" class="svg-inline--fa fa-chevron-left fa-w-10" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="currentColor" d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"></path></svg>
                        </label>
                    </div>
                </div>
                <div id="err-card" class="err-pan ss-card" style="visibility: hidden;">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times" class="svg-inline--fa fa-times fa-w-11" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"><path fill="currentColor" d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg>
                    <span id="err-info">账号或密码错误！</span>
                </div>
            </div>
            <div id="reg-pan" class="reg-box-1">
                <div class="login-pan ss-card">
                    <div id="reg-body">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="inbox" class="svg-inline--fa fa-inbox fa-w-18 fish" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="currentColor" d="M567.938 243.908L462.25 85.374A48.003 48.003 0 0 0 422.311 64H153.689a48 48 0 0 0-39.938 21.374L8.062 243.908A47.994 47.994 0 0 0 0 270.533V400c0 26.51 21.49 48 48 48h480c26.51 0 48-21.49 48-48V270.533a47.994 47.994 0 0 0-8.062-26.625zM162.252 128h251.497l85.333 128H376l-32 64H232l-32-64H76.918l85.334-128z"></path></svg>
                        <br><span class="main-title">林槐账户服务</span>
                        <form onsubmit="return false;">
                            <input id="reg-inuname" style="margin-top: 30px;" type="text" class="form-control" placeholder="用户名" aria-label="用户名">
                            <input id="reg-inupwd" type="password" class="form-control" placeholder="密码" aria-label="密码">
                            <input id="reg-inupwdagain" type="password" class="form-control" placeholder="确认密码" aria-label="密码">
                            <div class="fog-pwd"><span></span></div>
                            <button id="reggo-btn" type="submit" class="login-bt">
                                <svg id="reggo-icon" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" class="svg-inline--fa fa-angle-right fa-w-8" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path id="go-icon-path" fill="currentColor" d="M224.3 273l-136 136c-9.4 9.4-24.6 9.4-33.9 0l-22.6-22.6c-9.4-9.4-9.4-24.6 0-33.9l96.4-96.4-96.4-96.4c-9.4-9.4-9.4-24.6 0-33.9L54.3 103c9.4-9.4 24.6-9.4 33.9 0l136 136c9.5 9.4 9.5 24.6.1 34z"></path></svg>
                            </button>
                        </form>
                    </div>
                </div>
                <div id="regerr-card" class="err-pan ss-card" style="visibility: hidden;">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times" class="svg-inline--fa fa-times fa-w-11" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"><path fill="currentColor" d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"></path></svg>
                    <span id="regerr-info">账号或密码错误！</span>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/api/account.js"></script>
<script src="${pageContext.request.contextPath}/js/util/jsencrypt.min.js"></script>
</html>
