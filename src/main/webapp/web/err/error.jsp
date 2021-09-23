<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/10
  Time: 上午 8:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%
    Object code = request.getAttribute("javax.servlet.error.status_code");
    Object info = request.getAttribute("javax.servlet.error.message");
    Object error = request.getAttribute("javax.servlet.error.exception_type");
    Object show = request.getAttribute("inn");

    Object debug = request.getAttribute("debug");

    String strInfo = info == null ? "null" : info.toString();
    String strError = error == null ? "null" : error.toString();
    String strCode = code == null ? "200" : code.toString();

    if(show != null && (boolean) show) {
        strCode = (String) request.getAttribute("code");
    }

    String msgInfo = "我也不知道发生了什么（小声）";
    String svg = "M440.5 88.5l-52 52L415 167c9.4 9.4 9.4 24.6 0 33.9l-17.4 17.4c11.8 26.1 18.4 55.1 18.4 85.6 0 114.9-93.1 208-208 208S0 418.9 0 304 93.1 96 208 96c30.5 0 59.5 6.6 85.6 18.4L311 97c9.4-9.4 24.6-9.4 33.9 0l26.5 26.5 52-52 17.1 17zM500 60h-24c-6.6 0-12 5.4-12 12s5.4 12 12 12h24c6.6 0 12-5.4 12-12s-5.4-12-12-12zM440 0c-6.6 0-12 5.4-12 12v24c0 6.6 5.4 12 12 12s12-5.4 12-12V12c0-6.6-5.4-12-12-12zm33.9 55l17-17c4.7-4.7 4.7-12.3 0-17-4.7-4.7-12.3-4.7-17 0l-17 17c-4.7 4.7-4.7 12.3 0 17 4.8 4.7 12.4 4.7 17 0zm-67.8 0c4.7 4.7 12.3 4.7 17 0 4.7-4.7 4.7-12.3 0-17l-17-17c-4.7-4.7-12.3-4.7-17 0-4.7 4.7-4.7 12.3 0 17l17 17zm67.8 34c-4.7-4.7-12.3-4.7-17 0-4.7 4.7-4.7 12.3 0 17l17 17c4.7 4.7 12.3 4.7 17 0 4.7-4.7 4.7-12.3 0-17l-17-17zM112 272c0-35.3 28.7-64 64-64 8.8 0 16-7.2 16-16s-7.2-16-16-16c-52.9 0-96 43.1-96 96 0 8.8 7.2 16 16 16s16-7.2 16-16z";
    switch (strCode) {
        case "200": msgInfo = "没事别访问 Error 界面啊（大声）"; break;
        case "404": {
            msgInfo = "小鱼干弄丢了";
            svg = "M327.1 96c-89.97 0-168.54 54.77-212.27 101.63L27.5 131.58c-12.13-9.18-30.24.6-27.14 14.66L24.54 256 .35 365.77c-3.1 14.06 15.01 23.83 27.14 14.66l87.33-66.05C158.55 361.23 237.13 416 327.1 416 464.56 416 576 288 576 256S464.56 96 327.1 96zm87.43 184c-13.25 0-24-10.75-24-24 0-13.26 10.75-24 24-24 13.26 0 24 10.74 24 24 0 13.25-10.75 24-24 24z";
            break;
        }
        case "500": {
            msgInfo = "被玩坏了呜呜";
            svg = "M480 160H32c-17.673 0-32-14.327-32-32V64c0-17.673 14.327-32 32-32h448c17.673 0 32 14.327 32 32v64c0 17.673-14.327 32-32 32zm-48-88c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24zm-64 0c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24zm112 248H32c-17.673 0-32-14.327-32-32v-64c0-17.673 14.327-32 32-32h448c17.673 0 32 14.327 32 32v64c0 17.673-14.327 32-32 32zm-48-88c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24zm-64 0c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24zm112 248H32c-17.673 0-32-14.327-32-32v-64c0-17.673 14.327-32 32-32h448c17.673 0 32 14.327 32 32v64c0 17.673-14.327 32-32 32zm-48-88c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24zm-64 0c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24z";
            break;
        }
        case "400": {
            msgInfo = "你在说什么啊";
            svg = "M202.021 0C122.202 0 70.503 32.703 29.914 91.026c-7.363 10.58-5.093 25.086 5.178 32.874l43.138 32.709c10.373 7.865 25.132 6.026 33.253-4.148 25.049-31.381 43.63-49.449 82.757-49.449 30.764 0 68.816 19.799 68.816 49.631 0 22.552-18.617 34.134-48.993 51.164-35.423 19.86-82.299 44.576-82.299 106.405V320c0 13.255 10.745 24 24 24h72.471c13.255 0 24-10.745 24-24v-5.773c0-42.86 125.268-44.645 125.268-160.627C377.504 66.256 286.902 0 202.021 0zM192 373.459c-38.196 0-69.271 31.075-69.271 69.271 0 38.195 31.075 69.27 69.271 69.27s69.271-31.075 69.271-69.271-31.075-69.27-69.271-69.27z";
            break;
        }
    }

    if(show != null && (boolean) show && request.getAttribute("str") != null) {
        msgInfo = (String) request.getAttribute("str");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>喵喵喵 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">
</head>

<body style="background: var(--color-bg);">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <%-- Code Here …… --%>
        <div align="center" class="main-card" <%if(debug != null && (boolean) debug)out.print("style=\"margin-top: 0;\"");%>>
            <div class="ss-card info-card" <%if(debug != null && (boolean) debug)out.print("style=\"display: none;\"");%>>
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="fish" class="svg-inline--fa fa-fish fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                          d="<%=svg%>"
                    ></path>
                </svg><br>
                <span id="code"><%=strCode%></span><br>
                <div id="info"><span><%=msgInfo%></span></div>
                <button onclick="window.location.href = '../..';">回去看看</button>
            </div>
            <div class="debug-card ss-card" <%if(debug == null || !(boolean) debug)out.print("style=\"display: none;\"");%>>
                <div id="card-title-hd"></div>
                <header>Debug Info</header>
                <div style="padding: 20px;">
                    <i>Code</i><br>
                    <span><%=request.getAttribute("javax.servlet.error.status_code")%></span><br>
                    <i>URL</i><br>
                    <span><%=request.getAttribute("javax.servlet.error.request_uri")%></span><br>
                    <i>Name</i><br>
                    <span><%=request.getAttribute("javax.servlet.error.servlet_name")%></span><br>
                    <i>Type</i><br>
                    <span><%=request.getAttribute("javax.servlet.error.exception_type")%></span><br>
                    <i>Message</i><br>
                    <span><%=request.getAttribute("javax.servlet.error.message")%></span><br>
                    <i>Exception</i><br>         
                    <span>
                        <code>
                            <%
                                Object base = request.getAttribute("javax.servlet.error.exception");
                                String exp = base == null ? "null" : base.toString();
                                exp = exp.replace("<", "&lt;");
                                exp = exp.replace(">", "&gt;");
                                exp = exp.replace("\n", "<br>");
                                out.print(exp);
                            %>
                        </code>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
</html>
