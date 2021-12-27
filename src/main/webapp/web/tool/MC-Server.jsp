<%--
  Created by IntelliJ IDEA.
  User: Stapxs
  Date: 2021/9/11
  Time: 下午 8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object debug = request.getParameter("debug");
%>
<!DOCTYPE html>
<html>
<head>
    <title>MC 服务器信息 - 林槐服务接口</title>
    <jsp:include page="${pageContext.request.contextPath}/module/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/api/error.css/error.css">
</head>

<script>
    const json = String.raw`<%=request.getAttribute("str")%>`;
</script>
<style>
    .debug-card span {
        font-size: 1rem;
        color: var(--color-font-1);
        font-weight: 300;
    }
</style>

<body style="background: var(--color-bg);">
<jsp:include page="${pageContext.request.contextPath}/module/navbar.jsp"/>
<div style="display: flex;flex-direction: column;height: calc(100vh - 76px);">
    <div class="container-lg" style="flex: 1;">
        <%-- Code Here …… --%>
            <div class="debug-card ss-card">
                <div id="card-title-hd"></div>
                <header>服务器信息</header>
                <div style="padding: 20px;">
                    <img style="width: 138px;
                                height: 138px;
                                background: var(--color-card-1);
                                padding: 10px;
                                margin-bottom: 20px;
                                border-radius: 7px;" id="img" alt="favicon">
                    <img style="width: 74px;
                                height: 74px;
                                margin-top: calc(128px - 64px);
                                margin-left: 20px;
                                background: var(--color-card-1);
                                padding: 10px;
                                margin-bottom: 20px;
                                border-radius: 7px;" id="img-s" alt="favicon small"><br>
                    <i>标题</i><br>
                    <span id="title" style="white-space: pre;"></span><br>
                    <i id="version-t">版本</i><br>
                    <span id="version"></span><br>
                    <i id="players-t">玩家列表</i><br>
                    <span id="players"></span><br>
                    <i id="mods-t">MOD 列表</i><br>
                    <span id="mods"></span><br>
                    <i>PING</i><br>
                    <span id="ping"></span><br>
                    <i<%if(debug == null || !debug.equals("true"))out.print(" style=\"display:none;\"");%>>JSON</i><br>
                    <span style="<%if(debug == null || !debug.equals("true"))out.print("display:none;");%>">
                        <code>
                            <%
                                if(debug != null && debug.equals("true")) {
                                    String exp = request.getAttribute("str").toString();
                                    exp = exp.replace("<", "&lt;");
                                    exp = exp.replace(">", "&gt;");
                                    exp = exp.replace("\n", "<br>");
                                    out.print(exp);
                                }
                            %>
                        </code>
                    </span>
                </div>
            </div>
    </div>
    <jsp:include page="${pageContext.request.contextPath}/module/footer.jsp"/>
</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/module/js.jsp"/>
<script src="${pageContext.request.contextPath}/js/tool/MC-Server.js"></script>
</html>

